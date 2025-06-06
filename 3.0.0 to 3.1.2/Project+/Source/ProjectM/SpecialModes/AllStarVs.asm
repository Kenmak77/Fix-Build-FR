[Legacy TE] All Star Versus 1.33 LTE [wiiztec] 
#(Knuckles added in [Eon])
#(Training mode Battle Portrait fix [DukeItOut])
* 4A000000 90000000
* 08588099 000000FF
* 000300A0 00000000
* 3A17F37E FF000002
* 0858809C 00000000
* 200300A0 00000000
* 08588368 00000000
* 20030070 00000000

* C2946354 00000004	# Runs every frame?
* 899E0053 1D8C0080
* 397E005A 7D6B6214
* 3D808059 916C82F4
* 887E005A 00000000

HOOK @ $8077FB7C 
{
loc_0x0:
  stwu r1, -80(r1)
  stmw r14, 8(r1)
  lis r12, 0x9018
  lbz r12, -3201(r12)
  cmpwi r12, 0x2
  bne- loc_0x15C			# Check if in All-Star Vs.
  lis r14, 0x8058
  ori r14, r14, 0x8003
  lis r15, 0x9018
  ori r15, r15, 0xFB8
  lis r29, 0x8058
  ori r29, r29, 0x8300
  lwz r22, -12(r29)
  cmpwi r25, 0x14
  bne- loc_0x60
  cmplwi r26, 48879
  blt- loc_0x60

loc_0x44:
  stw r7, 153(r14)
  stw r7, 104(r29)
  addi r14, r14, 0xA0
  addi r29, r29, 0x70
  addi r9, r9, 0x1
  cmpwi r9, 0x4
  bne+ loc_0x44

loc_0x60:
  addi r16, r14, 0x98
  lhz r26, -7(r14)
  lbzx r17, r16, r26
  cmpwi cr1, r17, 0x9B
  cmpwi r30, 0xBE
  bne- loc_0x80
  stbx r7, r16, r26
  beq- cr1, loc_0x90

loc_0x80:
  cmpwi r30, 0x10B
  bne- loc_0x15C
  cmpwi r23, 0xBD
  bne- loc_0x15C

loc_0x90:
  lwz r12, 8(r31)
  lwz r11, 272(r12)
  cmpwi cr4, r11, 0xF
  bne- cr4, loc_0xAC
  lhz r11, 252(r12)
  cmpwi r11, 0x1
  beq- loc_0x15C

loc_0xAC:
  lwz r12, 28(r31)
  lwz r12, 40(r12)
  lwz r12, 16(r12)
  lbz r12, 85(r12)
  mulli r16, r12, 0xA0
  mulli r17, r12, 0x5C
  mulli r23, r12, 0x80
  add r16, r16, r14
  sub r22, r22, r23
  lbz r20, 153(r16)

loc_0xD4:
  lbzx r19, r16, r20
  cmplwi r19, 204
  blt- loc_0xE8
  li r20, 0xFFFD
  b loc_0xD4

loc_0xE8:
  lwzx r19, r16, r20
  rlwinm r18, r19, 8, 24, 31
  cmpwi r18, 0x3D
  bne- loc_0x104
  mflr r24
  bl RandomSelect
  mtlr r24

  lbzx r11, r15, r17
  cmpw r11, r18
  beq loc_0xE8

loc_0x104:
  rlwinm r19, r19, 24, 8, 31
  lis r11, 0x8128
  ori r11, r11, 0xAE64
  bne- cr4, loc_0x118
  subi r11, r11, 0x280

loc_0x118:
  li r6, 0x52
  rlwinm r6, r6, 12, 0, 19
  mullw r6, r6, r12
  lwzx r6, r11, r6
  beq- cr1, loc_0x134
  cmpwi r6, 0x1
  beq- loc_0x15C

loc_0x134:
  li r23, 0x12
  stb r23, 0(r22)
  stbx r18, r15, r17
  addi r15, r15, 0x5
  sthx r19, r15, r17
  addi r20, r20, 0x3
  stb r20, 153(r16)
  lbz r21, 154(r16)
  addi r21, r21, 0x1
  stb r21, 154(r16)

loc_0x15C:
  lmw r14, 8(r1)
  addi r1, r1, 0x50
  lwz r3, 44(r29)
  b exit

RandomSelect:
  stwu r1, -100(r1)
  stmw r9, 8(r1)
  lis r27, 0x8003
  ori r27, r27, 0xFC7C
  mflr r8
  mtctr r27
  li r3, 0x36 	#set range 0-0x35
  bctrl 
  mtlr r8
  lmw r9, 8(r1)
  addi r1, r1, 0x64
  mr r18, r3
  cmpwi r18, 0x17 #if wario
  bne- RandomChecks
  lis r19, 0x6    #set wario costume to warioland wario

RandomChecks:
  cmpwi r18, 0x11 #if ID is sopo rechoose random ID
  beq+ RandomSelect
  cmpwi r18, 0x12 #if ID is sona rechoose random ID
  beq+ RandomSelect
  cmpwi r18, 0x1D #if ID is pokemon trainer's charizard rechoose random ID
  beq+ RandomSelect
  cmpwi r18, 0x1F #if ID is pokemon trainer's squirtle rechoose random ID
  beq+ RandomSelect
  cmpwi r18, 0x21 #if ID is pokemon trainer's ivysaur rechoose random ID
  beq+ RandomSelect
  cmpwi r18, 0x2C #if ID is less than 0x2C ID is good so branch to blr
  blt- end
  cmpwi r18, 0x31 #if ID is giga bowser, warioman, or alloys rechoose random ID
  ble+ RandomSelect
  cmpwi r18, 0x34 #if ID is 0x34, rechoose random ID.
  beq RandomSelect

end:
  blr 
exit:


}

#game start
* C26DEFD4 0000000F		# Related to launching ASV
* 9421FF80 BC410008
* 3D809018 898CF37F
* 2C0C0002 9817009E
* 40820050 3DC08058
* 61CE8003 3DE09018
* 61EF0FB8 826EFFFD
* 5672463E 2C12003D
* 40820010 7F6802A6
* 4BFFFF31 7F6803A6 # break on this line moved 0x8 further to point to correct spot
* 5673C23E 9A4F0000
* B26F0005 39CE00A0
* 39EF005C 3AD60001
* 2C160007 4082FFC8
* B8410008 38210080
* 60000000 00000000

* C26DEF94 00000003		# Related to launching ASV
* 3D809018 898CF37F
* 2C0C0002 41820008
* 887800B8 00000000

* C26DEF98 00000003		# Related to launching ASV
* 3D809018 898CF37F
* 2C0C0002 41820008
* 98770098 00000000

* C26DEFCC 00000003		# Related to launching ASV
* 3D809018 898CF37F
* 2C0C0002 41820008
* 9877009D 00000000

* C269680C 00000020		# Related to which character to place token on
* 3D808058 618C8000
* 817E01B0 1D6B00A0
* 7D8C5A14 896C009C
* 7D0C582E 290800FF
* A21E000E 56080673
* 5788402E 41820028
* 2C1C0017 40820008
* 39081600 2C1C000C
* 40820008 39082000
* 2C1C0010 40820008
* 39080100 560F06B5
* 4182000C 6108003D
* 48000018 560F06F7
* 4182000C 6108003E
* 48000008 7D08EB78
* 5508402E 7D08FB78
* 5508402E 2D8A01BB
* 408E0008 3D003D00
* 610800CC 28190003
* 41810044 28070001
* 41820028 41800054
* 89FE01F8 2C0F0000
* 40820048 396BFFFD
* 2C0B0000 4180003C
* 7D0C592E 48000034
* 418A0030 7D0C592E
* 396B0003 996C009C
* 48000020 408E0008
* 910C0000 2C0B0000
* 41820010 396BFFFD
* 7D0C59AE 996C009C
* 9B9E0444 00000000

* C2696610 00000004		# Related to which character to place token on
* 3D809019 898CA0E5
* 2C0C0001 40820008
* 38600000 2C030000
* 60000000 00000000

* C26965F8 0000000C		# Related to which character to place token on
* 83E301BC 3D808058
* 618C8300 817E01B0
* 1D6B0070 7D8C5A14
* 896C0068 5788402E
* 7D08FB78 28870001
* 41860020 41840030
* 89FE01F8 2C8F0000
* 40860024 396BFFFF
* 7FEC59AE 48000018
* 2C990000 41840010
* 7D0C5B2E 396B0002
* 996C0068 00000000

* C269A2FC 00000011		# Related to team color
* 809F01B8 3D809018
* 898CF37F 2C0C0002
* 40820074 2C0A0030
* 4082006C 3D808058
* 618C8300 817F01B0
* 1D6B0070 7D8C5A14
* 896C0068 2C0B0002
* 41810014 39600000
* 39E000DC 99EC006A
* 48000030 2C0B0068
* 4180000C 396BFFFE
* 48000020 396BFFFD
* 7F4C58AE 396BFFFF
* 7C8C58AE 988C006A
* 9B4C006B 396B0002
* 996C0068 39E000FC
* 99EC0069 00000000

* C2699A9C 00000014		# Related to character color in team
* 809B01B8 3D809018
* 898CF37F 2C0C0002
* 4082008C 2C040028
* 41820084 2C0A0030
* 4082007C 3D808058
* 618C8300 817E01B0
* 1D6B0070 7D8C5A14
* 896C0068 2C0B0002
* 41810014 39600000
* 39E000DC 99EC006A
* 48000040 2C0B0068
* 4180000C 396BFFFC
* 4800001C 396BFFFD
* 7F2C58AE 396BFFFF
* 7C8C58AE 988C006A
* 9B2C006B 3BBDFFFF
* 2C1D0000 40800008
* 3BA00002 396B0002
* 996C0068 39E000FC
* 99EC0069 00000000

* C268CBA0 00000011	# Related to adding/removing members of squad
* 80A301B8 3D809018
* 898CF37F 2C0C0002
* 40820074 3D808058
* 618C8300 1D7B0070
* 7D8C5A14 896C0069
* 2C0B00FC 41800058
* 896C006A 2C0B0029
* 4182004C 88AC006A
* 2C0500DC 40820040
* 8177B088 2C0B0000
* 4180001C 8177B100
* 2C0B0000 40820028
* 92F7B100 3977B060
* 48000018 8177B020
* 2C0B0000 40820010
* 92F7B020 3977AF80
* 91770010 00000000

* C26970EC 00000009 # Related to choosing a character on the CSS
* 80DE01BC 3D809018
* 898CF37F 2C0C0002
* 40820030 3D808058
* 618C8300 817E01B0
* 1D6B0070 7D8C5A14
* 89EC0069 2C0F00FC
* 40820008 88CC006B
* 39E000AC 99EC0069
* 60000000 00000000

* C281C528 0000000F	# Upon loading. Related to stock count
* 3D809018 898CF37F
* 2C0C0002 40820060
* 2C083FED 4082000C
* 7C681B78 48000008
* 81030000 542C801E
* 558C843E 280C4DE0
* 4082003C 2C190003
* 41810034 897F0002
* 3D808058 618C8000
* 1D6B00A0 7D8C5A14
* 896C009D 2C0B009D
* 4180000C 3980FF00
* 7D8B5B78 7C8B2050
* 90880034 8803000A
* 60000000 00000000

* C29586B4 00000008 # Related to share stock?
* 80747C28 3D808058
* 618C809B 1D7B00A0
* 39E0009B 7DEC59AE
* B16CFF61 398C0002
* 7DEC58AE 39EFFFFF
* 7DEC59AE 1D7900A0
* 7DEC58AE 39EF0001
* 7DEC59AE 00000000

* C281BC74 0000000A	# Upon loading
* 3D809018 898CF37F
* 2C0C0002 4082002C
* 8183006C 398C0001
* 9183006C 556C043E
* 2C0C4B40 41820014
* 3D808081 618CBC84
* 7D8903A6 4E800420
* 90E30040 90E3006C
* 90E30070 90E30074
* 90E30078 00000000
* 0481BCCC 48000010

* C26D1CA0 00000003	# Unknown
* 2C000008 41820008
* 38000000 3863A378
* 60000000 00000000

* 0495506C 60000000	# Related to stock matches
* 04957DEC 60000000	# Related to team stock matches

HOOK @ $80947958
{
  lis r12, 0x9018
  lbz r12, -3201(r12)
  cmpwi r12, 0x2; beq- %END%		# Check if in All-Star Vs.
  bla 0x0E1384	# remove battle portraits if not in ASV and removing a character slot!
}

* E0000000 80008000

################################################
All Star VS: proper respawn 1.0d [wiiztec,Magus]
################################################
HOOK @ $8081EDDC		# When starting a match
{
  lbz r0, 0xC(r3)
  
  lis r12, 0x9018
  lbz r12, -3201(r12)
  cmpwi r12, 0x2; bne- %END%		# Check if in All-Star Vs.
  cmpwi r0, 0x2;  bne- %END%		# Currently unknown
  li r0, 0x0
}
HOOK @ $8094FFE4		# Runs every frame?!
{
  lis r12, 0x9018
  lbz r12, -0xC81(r12)
  cmpwi r12, 0x2
  bne- loc_0x3C			# Check if in All-Star Vs.
  
  lwz r10, 0x50(r31)
  lwz r9, 0x44(r10)
  lis r8, 0x300
  ori r8, r8, 0x100
  cmpw r9, r8
  bne+ loc_0x3C
  lbz r7, 0x57(r10)
  cmpwi r7, 0x2
  bne- loc_0x3C
  li r7, 0x1
  stb r7, 0x40(r31)

loc_0x3C:
  lbz r0, 0x40(r31)		# Original operation.

}


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A0200D3
	for <bpf@vger.kernel.org>; Sat, 30 Mar 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711793433; cv=none; b=B/CJx481q3lugKl2oKKUWSReyEB7Lh2BHhXSi/fbY6DqqOwdl6C04AjLDGD9cyrQg1cquVmqw2eTdRseHoN6UYSQD6sIYCn+YNEwz/LY/rPpUC3ckdMzR6tO2gw4EDzBWq3CNvfLrq8RFF1vCleU/TQrtp4o1o4EZSKptSB8DX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711793433; c=relaxed/simple;
	bh=fVIRqSJRfEPHi/nmw7J79d0AwEnag7/0FX+UeuSAw8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+MtRR2tISMCeinrRoT0mw5j4nYZrhIKZz0FdV1IHlPThT6avwsydAXhoW1tP+DHmDUhTr2L7F8PTh8K4UtXGHPeuzPWHR2Tf0yi5DXyUIFxFPouyXf/mwsK1pPOJpow1x96FKw+WvWhRSDDl3bLn0t7i0eziabg68ZZsis3icg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fp+S0S86; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fp+S0S86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711793431; x=1743329431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fVIRqSJRfEPHi/nmw7J79d0AwEnag7/0FX+UeuSAw8I=;
  b=Fp+S0S862PSNbA9R3VGEdDc9O9bCVV0Yikh43HBjnl2bZHsyu9+zKTJG
   OW09kOzofxqBnH7ogRiyCqZOdV253oYwiClyQnZYEsMo+vKcmgxBRBSAj
   WvWKQoDR7RTz7xSikdgWY6mKcUpVRzg2fGbM5MMSmPq5BBodZNZPbY7wm
   BhriArbVkbOTH8Jg5pUnOyKpcalNIfaIlnE77G/eiJ9TO7SoaPYnz+bw8
   q8ajWrWBQmXc8KabxHkA1/cP/REFTnT+W3ouiJIGhDgICN3WMUNGYQQWh
   Iw1xe/iRGmO4bElhwWtwIvaPZ96Hr8xT76zNZndZPxWPkRcZfiF6acwwO
   g==;
X-CSE-ConnectionGUID: AXBRN9GwQ3+D4zRVXk/tHg==
X-CSE-MsgGUID: 6XtrBtFDS5m75D5P8TGgrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="17527982"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="17527982"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 03:10:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="17179555"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 30 Mar 2024 03:10:27 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqVfM-000494-2Z;
	Sat, 30 Mar 2024 10:10:24 +0000
Date: Sat, 30 Mar 2024 18:10:05 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, andrii@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/4] bpf: add internal-only per-CPU LDX
 instructions
Message-ID: <202403301707.PvBvfoI2-lkp@intel.com>
References: <20240329184740.4084786-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329184740.4084786-2-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-add-internal-only-per-CPU-LDX-instructions/20240330-025035
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240329184740.4084786-2-andrii%40kernel.org
patch subject: [PATCH bpf-next 1/4] bpf: add internal-only per-CPU LDX instructions
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20240330/202403301707.PvBvfoI2-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240330/202403301707.PvBvfoI2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403301707.PvBvfoI2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/net/bpf_jit_comp.c:1925:14: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'void *' [-Wvoid-pointer-to-int-cast]
    1925 |                         u32 off = (u32)(void *)&this_cpu_off;
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1925 arch/x86/net/bpf_jit_comp.c

  1264	
  1265	/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
  1266	#define RESTORE_TAIL_CALL_CNT(stack)				\
  1267		EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
  1268	
  1269	static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
  1270			  int oldproglen, struct jit_context *ctx, bool jmp_padding)
  1271	{
  1272		bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
  1273		struct bpf_insn *insn = bpf_prog->insnsi;
  1274		bool callee_regs_used[4] = {};
  1275		int insn_cnt = bpf_prog->len;
  1276		bool tail_call_seen = false;
  1277		bool seen_exit = false;
  1278		u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
  1279		u64 arena_vm_start, user_vm_start;
  1280		int i, excnt = 0;
  1281		int ilen, proglen = 0;
  1282		u8 *prog = temp;
  1283		int err;
  1284	
  1285		arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
  1286		user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
  1287	
  1288		detect_reg_usage(insn, insn_cnt, callee_regs_used,
  1289				 &tail_call_seen);
  1290	
  1291		/* tail call's presence in current prog implies it is reachable */
  1292		tail_call_reachable |= tail_call_seen;
  1293	
  1294		emit_prologue(&prog, bpf_prog->aux->stack_depth,
  1295			      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
  1296			      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
  1297		/* Exception callback will clobber callee regs for its own use, and
  1298		 * restore the original callee regs from main prog's stack frame.
  1299		 */
  1300		if (bpf_prog->aux->exception_boundary) {
  1301			/* We also need to save r12, which is not mapped to any BPF
  1302			 * register, as we throw after entry into the kernel, which may
  1303			 * overwrite r12.
  1304			 */
  1305			push_r12(&prog);
  1306			push_callee_regs(&prog, all_callee_regs_used);
  1307		} else {
  1308			if (arena_vm_start)
  1309				push_r12(&prog);
  1310			push_callee_regs(&prog, callee_regs_used);
  1311		}
  1312		if (arena_vm_start)
  1313			emit_mov_imm64(&prog, X86_REG_R12,
  1314				       arena_vm_start >> 32, (u32) arena_vm_start);
  1315	
  1316		ilen = prog - temp;
  1317		if (rw_image)
  1318			memcpy(rw_image + proglen, temp, ilen);
  1319		proglen += ilen;
  1320		addrs[0] = proglen;
  1321		prog = temp;
  1322	
  1323		for (i = 1; i <= insn_cnt; i++, insn++) {
  1324			const s32 imm32 = insn->imm;
  1325			u32 dst_reg = insn->dst_reg;
  1326			u32 src_reg = insn->src_reg;
  1327			u8 b2 = 0, b3 = 0;
  1328			u8 *start_of_ldx;
  1329			s64 jmp_offset;
  1330			s16 insn_off;
  1331			u8 jmp_cond;
  1332			u8 *func;
  1333			int nops;
  1334	
  1335			switch (insn->code) {
  1336				/* ALU */
  1337			case BPF_ALU | BPF_ADD | BPF_X:
  1338			case BPF_ALU | BPF_SUB | BPF_X:
  1339			case BPF_ALU | BPF_AND | BPF_X:
  1340			case BPF_ALU | BPF_OR | BPF_X:
  1341			case BPF_ALU | BPF_XOR | BPF_X:
  1342			case BPF_ALU64 | BPF_ADD | BPF_X:
  1343			case BPF_ALU64 | BPF_SUB | BPF_X:
  1344			case BPF_ALU64 | BPF_AND | BPF_X:
  1345			case BPF_ALU64 | BPF_OR | BPF_X:
  1346			case BPF_ALU64 | BPF_XOR | BPF_X:
  1347				maybe_emit_mod(&prog, dst_reg, src_reg,
  1348					       BPF_CLASS(insn->code) == BPF_ALU64);
  1349				b2 = simple_alu_opcodes[BPF_OP(insn->code)];
  1350				EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
  1351				break;
  1352	
  1353			case BPF_ALU64 | BPF_MOV | BPF_X:
  1354				if (insn_is_cast_user(insn)) {
  1355					if (dst_reg != src_reg)
  1356						/* 32-bit mov */
  1357						emit_mov_reg(&prog, false, dst_reg, src_reg);
  1358					/* shl dst_reg, 32 */
  1359					maybe_emit_1mod(&prog, dst_reg, true);
  1360					EMIT3(0xC1, add_1reg(0xE0, dst_reg), 32);
  1361	
  1362					/* or dst_reg, user_vm_start */
  1363					maybe_emit_1mod(&prog, dst_reg, true);
  1364					if (is_axreg(dst_reg))
  1365						EMIT1_off32(0x0D,  user_vm_start >> 32);
  1366					else
  1367						EMIT2_off32(0x81, add_1reg(0xC8, dst_reg),  user_vm_start >> 32);
  1368	
  1369					/* rol dst_reg, 32 */
  1370					maybe_emit_1mod(&prog, dst_reg, true);
  1371					EMIT3(0xC1, add_1reg(0xC0, dst_reg), 32);
  1372	
  1373					/* xor r11, r11 */
  1374					EMIT3(0x4D, 0x31, 0xDB);
  1375	
  1376					/* test dst_reg32, dst_reg32; check if lower 32-bit are zero */
  1377					maybe_emit_mod(&prog, dst_reg, dst_reg, false);
  1378					EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
  1379	
  1380					/* cmove r11, dst_reg; if so, set dst_reg to zero */
  1381					/* WARNING: Intel swapped src/dst register encoding in CMOVcc !!! */
  1382					maybe_emit_mod(&prog, AUX_REG, dst_reg, true);
  1383					EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
  1384					break;
  1385				}
  1386				fallthrough;
  1387			case BPF_ALU | BPF_MOV | BPF_X:
  1388				if (insn->off == 0)
  1389					emit_mov_reg(&prog,
  1390						     BPF_CLASS(insn->code) == BPF_ALU64,
  1391						     dst_reg, src_reg);
  1392				else
  1393					emit_movsx_reg(&prog, insn->off,
  1394						       BPF_CLASS(insn->code) == BPF_ALU64,
  1395						       dst_reg, src_reg);
  1396				break;
  1397	
  1398				/* neg dst */
  1399			case BPF_ALU | BPF_NEG:
  1400			case BPF_ALU64 | BPF_NEG:
  1401				maybe_emit_1mod(&prog, dst_reg,
  1402						BPF_CLASS(insn->code) == BPF_ALU64);
  1403				EMIT2(0xF7, add_1reg(0xD8, dst_reg));
  1404				break;
  1405	
  1406			case BPF_ALU | BPF_ADD | BPF_K:
  1407			case BPF_ALU | BPF_SUB | BPF_K:
  1408			case BPF_ALU | BPF_AND | BPF_K:
  1409			case BPF_ALU | BPF_OR | BPF_K:
  1410			case BPF_ALU | BPF_XOR | BPF_K:
  1411			case BPF_ALU64 | BPF_ADD | BPF_K:
  1412			case BPF_ALU64 | BPF_SUB | BPF_K:
  1413			case BPF_ALU64 | BPF_AND | BPF_K:
  1414			case BPF_ALU64 | BPF_OR | BPF_K:
  1415			case BPF_ALU64 | BPF_XOR | BPF_K:
  1416				maybe_emit_1mod(&prog, dst_reg,
  1417						BPF_CLASS(insn->code) == BPF_ALU64);
  1418	
  1419				/*
  1420				 * b3 holds 'normal' opcode, b2 short form only valid
  1421				 * in case dst is eax/rax.
  1422				 */
  1423				switch (BPF_OP(insn->code)) {
  1424				case BPF_ADD:
  1425					b3 = 0xC0;
  1426					b2 = 0x05;
  1427					break;
  1428				case BPF_SUB:
  1429					b3 = 0xE8;
  1430					b2 = 0x2D;
  1431					break;
  1432				case BPF_AND:
  1433					b3 = 0xE0;
  1434					b2 = 0x25;
  1435					break;
  1436				case BPF_OR:
  1437					b3 = 0xC8;
  1438					b2 = 0x0D;
  1439					break;
  1440				case BPF_XOR:
  1441					b3 = 0xF0;
  1442					b2 = 0x35;
  1443					break;
  1444				}
  1445	
  1446				if (is_imm8(imm32))
  1447					EMIT3(0x83, add_1reg(b3, dst_reg), imm32);
  1448				else if (is_axreg(dst_reg))
  1449					EMIT1_off32(b2, imm32);
  1450				else
  1451					EMIT2_off32(0x81, add_1reg(b3, dst_reg), imm32);
  1452				break;
  1453	
  1454			case BPF_ALU64 | BPF_MOV | BPF_K:
  1455			case BPF_ALU | BPF_MOV | BPF_K:
  1456				emit_mov_imm32(&prog, BPF_CLASS(insn->code) == BPF_ALU64,
  1457					       dst_reg, imm32);
  1458				break;
  1459	
  1460			case BPF_LD | BPF_IMM | BPF_DW:
  1461				emit_mov_imm64(&prog, dst_reg, insn[1].imm, insn[0].imm);
  1462				insn++;
  1463				i++;
  1464				break;
  1465	
  1466				/* dst %= src, dst /= src, dst %= imm32, dst /= imm32 */
  1467			case BPF_ALU | BPF_MOD | BPF_X:
  1468			case BPF_ALU | BPF_DIV | BPF_X:
  1469			case BPF_ALU | BPF_MOD | BPF_K:
  1470			case BPF_ALU | BPF_DIV | BPF_K:
  1471			case BPF_ALU64 | BPF_MOD | BPF_X:
  1472			case BPF_ALU64 | BPF_DIV | BPF_X:
  1473			case BPF_ALU64 | BPF_MOD | BPF_K:
  1474			case BPF_ALU64 | BPF_DIV | BPF_K: {
  1475				bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
  1476	
  1477				if (dst_reg != BPF_REG_0)
  1478					EMIT1(0x50); /* push rax */
  1479				if (dst_reg != BPF_REG_3)
  1480					EMIT1(0x52); /* push rdx */
  1481	
  1482				if (BPF_SRC(insn->code) == BPF_X) {
  1483					if (src_reg == BPF_REG_0 ||
  1484					    src_reg == BPF_REG_3) {
  1485						/* mov r11, src_reg */
  1486						EMIT_mov(AUX_REG, src_reg);
  1487						src_reg = AUX_REG;
  1488					}
  1489				} else {
  1490					/* mov r11, imm32 */
  1491					EMIT3_off32(0x49, 0xC7, 0xC3, imm32);
  1492					src_reg = AUX_REG;
  1493				}
  1494	
  1495				if (dst_reg != BPF_REG_0)
  1496					/* mov rax, dst_reg */
  1497					emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
  1498	
  1499				if (insn->off == 0) {
  1500					/*
  1501					 * xor edx, edx
  1502					 * equivalent to 'xor rdx, rdx', but one byte less
  1503					 */
  1504					EMIT2(0x31, 0xd2);
  1505	
  1506					/* div src_reg */
  1507					maybe_emit_1mod(&prog, src_reg, is64);
  1508					EMIT2(0xF7, add_1reg(0xF0, src_reg));
  1509				} else {
  1510					if (BPF_CLASS(insn->code) == BPF_ALU)
  1511						EMIT1(0x99); /* cdq */
  1512					else
  1513						EMIT2(0x48, 0x99); /* cqo */
  1514	
  1515					/* idiv src_reg */
  1516					maybe_emit_1mod(&prog, src_reg, is64);
  1517					EMIT2(0xF7, add_1reg(0xF8, src_reg));
  1518				}
  1519	
  1520				if (BPF_OP(insn->code) == BPF_MOD &&
  1521				    dst_reg != BPF_REG_3)
  1522					/* mov dst_reg, rdx */
  1523					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_3);
  1524				else if (BPF_OP(insn->code) == BPF_DIV &&
  1525					 dst_reg != BPF_REG_0)
  1526					/* mov dst_reg, rax */
  1527					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_0);
  1528	
  1529				if (dst_reg != BPF_REG_3)
  1530					EMIT1(0x5A); /* pop rdx */
  1531				if (dst_reg != BPF_REG_0)
  1532					EMIT1(0x58); /* pop rax */
  1533				break;
  1534			}
  1535	
  1536			case BPF_ALU | BPF_MUL | BPF_K:
  1537			case BPF_ALU64 | BPF_MUL | BPF_K:
  1538				maybe_emit_mod(&prog, dst_reg, dst_reg,
  1539					       BPF_CLASS(insn->code) == BPF_ALU64);
  1540	
  1541				if (is_imm8(imm32))
  1542					/* imul dst_reg, dst_reg, imm8 */
  1543					EMIT3(0x6B, add_2reg(0xC0, dst_reg, dst_reg),
  1544					      imm32);
  1545				else
  1546					/* imul dst_reg, dst_reg, imm32 */
  1547					EMIT2_off32(0x69,
  1548						    add_2reg(0xC0, dst_reg, dst_reg),
  1549						    imm32);
  1550				break;
  1551	
  1552			case BPF_ALU | BPF_MUL | BPF_X:
  1553			case BPF_ALU64 | BPF_MUL | BPF_X:
  1554				maybe_emit_mod(&prog, src_reg, dst_reg,
  1555					       BPF_CLASS(insn->code) == BPF_ALU64);
  1556	
  1557				/* imul dst_reg, src_reg */
  1558				EMIT3(0x0F, 0xAF, add_2reg(0xC0, src_reg, dst_reg));
  1559				break;
  1560	
  1561				/* Shifts */
  1562			case BPF_ALU | BPF_LSH | BPF_K:
  1563			case BPF_ALU | BPF_RSH | BPF_K:
  1564			case BPF_ALU | BPF_ARSH | BPF_K:
  1565			case BPF_ALU64 | BPF_LSH | BPF_K:
  1566			case BPF_ALU64 | BPF_RSH | BPF_K:
  1567			case BPF_ALU64 | BPF_ARSH | BPF_K:
  1568				maybe_emit_1mod(&prog, dst_reg,
  1569						BPF_CLASS(insn->code) == BPF_ALU64);
  1570	
  1571				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  1572				if (imm32 == 1)
  1573					EMIT2(0xD1, add_1reg(b3, dst_reg));
  1574				else
  1575					EMIT3(0xC1, add_1reg(b3, dst_reg), imm32);
  1576				break;
  1577	
  1578			case BPF_ALU | BPF_LSH | BPF_X:
  1579			case BPF_ALU | BPF_RSH | BPF_X:
  1580			case BPF_ALU | BPF_ARSH | BPF_X:
  1581			case BPF_ALU64 | BPF_LSH | BPF_X:
  1582			case BPF_ALU64 | BPF_RSH | BPF_X:
  1583			case BPF_ALU64 | BPF_ARSH | BPF_X:
  1584				/* BMI2 shifts aren't better when shift count is already in rcx */
  1585				if (boot_cpu_has(X86_FEATURE_BMI2) && src_reg != BPF_REG_4) {
  1586					/* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
  1587					bool w = (BPF_CLASS(insn->code) == BPF_ALU64);
  1588					u8 op;
  1589	
  1590					switch (BPF_OP(insn->code)) {
  1591					case BPF_LSH:
  1592						op = 1; /* prefix 0x66 */
  1593						break;
  1594					case BPF_RSH:
  1595						op = 3; /* prefix 0xf2 */
  1596						break;
  1597					case BPF_ARSH:
  1598						op = 2; /* prefix 0xf3 */
  1599						break;
  1600					}
  1601	
  1602					emit_shiftx(&prog, dst_reg, src_reg, w, op);
  1603	
  1604					break;
  1605				}
  1606	
  1607				if (src_reg != BPF_REG_4) { /* common case */
  1608					/* Check for bad case when dst_reg == rcx */
  1609					if (dst_reg == BPF_REG_4) {
  1610						/* mov r11, dst_reg */
  1611						EMIT_mov(AUX_REG, dst_reg);
  1612						dst_reg = AUX_REG;
  1613					} else {
  1614						EMIT1(0x51); /* push rcx */
  1615					}
  1616					/* mov rcx, src_reg */
  1617					EMIT_mov(BPF_REG_4, src_reg);
  1618				}
  1619	
  1620				/* shl %rax, %cl | shr %rax, %cl | sar %rax, %cl */
  1621				maybe_emit_1mod(&prog, dst_reg,
  1622						BPF_CLASS(insn->code) == BPF_ALU64);
  1623	
  1624				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  1625				EMIT2(0xD3, add_1reg(b3, dst_reg));
  1626	
  1627				if (src_reg != BPF_REG_4) {
  1628					if (insn->dst_reg == BPF_REG_4)
  1629						/* mov dst_reg, r11 */
  1630						EMIT_mov(insn->dst_reg, AUX_REG);
  1631					else
  1632						EMIT1(0x59); /* pop rcx */
  1633				}
  1634	
  1635				break;
  1636	
  1637			case BPF_ALU | BPF_END | BPF_FROM_BE:
  1638			case BPF_ALU64 | BPF_END | BPF_FROM_LE:
  1639				switch (imm32) {
  1640				case 16:
  1641					/* Emit 'ror %ax, 8' to swap lower 2 bytes */
  1642					EMIT1(0x66);
  1643					if (is_ereg(dst_reg))
  1644						EMIT1(0x41);
  1645					EMIT3(0xC1, add_1reg(0xC8, dst_reg), 8);
  1646	
  1647					/* Emit 'movzwl eax, ax' */
  1648					if (is_ereg(dst_reg))
  1649						EMIT3(0x45, 0x0F, 0xB7);
  1650					else
  1651						EMIT2(0x0F, 0xB7);
  1652					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  1653					break;
  1654				case 32:
  1655					/* Emit 'bswap eax' to swap lower 4 bytes */
  1656					if (is_ereg(dst_reg))
  1657						EMIT2(0x41, 0x0F);
  1658					else
  1659						EMIT1(0x0F);
  1660					EMIT1(add_1reg(0xC8, dst_reg));
  1661					break;
  1662				case 64:
  1663					/* Emit 'bswap rax' to swap 8 bytes */
  1664					EMIT3(add_1mod(0x48, dst_reg), 0x0F,
  1665					      add_1reg(0xC8, dst_reg));
  1666					break;
  1667				}
  1668				break;
  1669	
  1670			case BPF_ALU | BPF_END | BPF_FROM_LE:
  1671				switch (imm32) {
  1672				case 16:
  1673					/*
  1674					 * Emit 'movzwl eax, ax' to zero extend 16-bit
  1675					 * into 64 bit
  1676					 */
  1677					if (is_ereg(dst_reg))
  1678						EMIT3(0x45, 0x0F, 0xB7);
  1679					else
  1680						EMIT2(0x0F, 0xB7);
  1681					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  1682					break;
  1683				case 32:
  1684					/* Emit 'mov eax, eax' to clear upper 32-bits */
  1685					if (is_ereg(dst_reg))
  1686						EMIT1(0x45);
  1687					EMIT2(0x89, add_2reg(0xC0, dst_reg, dst_reg));
  1688					break;
  1689				case 64:
  1690					/* nop */
  1691					break;
  1692				}
  1693				break;
  1694	
  1695				/* speculation barrier */
  1696			case BPF_ST | BPF_NOSPEC:
  1697				EMIT_LFENCE();
  1698				break;
  1699	
  1700				/* ST: *(u8*)(dst_reg + off) = imm */
  1701			case BPF_ST | BPF_MEM | BPF_B:
  1702				if (is_ereg(dst_reg))
  1703					EMIT2(0x41, 0xC6);
  1704				else
  1705					EMIT1(0xC6);
  1706				goto st;
  1707			case BPF_ST | BPF_MEM | BPF_H:
  1708				if (is_ereg(dst_reg))
  1709					EMIT3(0x66, 0x41, 0xC7);
  1710				else
  1711					EMIT2(0x66, 0xC7);
  1712				goto st;
  1713			case BPF_ST | BPF_MEM | BPF_W:
  1714				if (is_ereg(dst_reg))
  1715					EMIT2(0x41, 0xC7);
  1716				else
  1717					EMIT1(0xC7);
  1718				goto st;
  1719			case BPF_ST | BPF_MEM | BPF_DW:
  1720				EMIT2(add_1mod(0x48, dst_reg), 0xC7);
  1721	
  1722	st:			if (is_imm8(insn->off))
  1723					EMIT2(add_1reg(0x40, dst_reg), insn->off);
  1724				else
  1725					EMIT1_off32(add_1reg(0x80, dst_reg), insn->off);
  1726	
  1727				EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
  1728				break;
  1729	
  1730				/* STX: *(u8*)(dst_reg + off) = src_reg */
  1731			case BPF_STX | BPF_MEM | BPF_B:
  1732			case BPF_STX | BPF_MEM | BPF_H:
  1733			case BPF_STX | BPF_MEM | BPF_W:
  1734			case BPF_STX | BPF_MEM | BPF_DW:
  1735				emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
  1736				break;
  1737	
  1738			case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
  1739			case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
  1740			case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
  1741			case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
  1742				start_of_ldx = prog;
  1743				emit_st_r12(&prog, BPF_SIZE(insn->code), dst_reg, insn->off, insn->imm);
  1744				goto populate_extable;
  1745	
  1746				/* LDX: dst_reg = *(u8*)(src_reg + r12 + off) */
  1747			case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
  1748			case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
  1749			case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
  1750			case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
  1751			case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
  1752			case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
  1753			case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
  1754			case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
  1755				start_of_ldx = prog;
  1756				if (BPF_CLASS(insn->code) == BPF_LDX)
  1757					emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
  1758				else
  1759					emit_stx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
  1760	populate_extable:
  1761				{
  1762					struct exception_table_entry *ex;
  1763					u8 *_insn = image + proglen + (start_of_ldx - temp);
  1764					s64 delta;
  1765	
  1766					if (!bpf_prog->aux->extable)
  1767						break;
  1768	
  1769					if (excnt >= bpf_prog->aux->num_exentries) {
  1770						pr_err("mem32 extable bug\n");
  1771						return -EFAULT;
  1772					}
  1773					ex = &bpf_prog->aux->extable[excnt++];
  1774	
  1775					delta = _insn - (u8 *)&ex->insn;
  1776					/* switch ex to rw buffer for writes */
  1777					ex = (void *)rw_image + ((void *)ex - (void *)image);
  1778	
  1779					ex->insn = delta;
  1780	
  1781					ex->data = EX_TYPE_BPF;
  1782	
  1783					ex->fixup = (prog - start_of_ldx) |
  1784						((BPF_CLASS(insn->code) == BPF_LDX ? reg2pt_regs[dst_reg] : DONT_CLEAR) << 8);
  1785				}
  1786				break;
  1787	
  1788				/* LDX: dst_reg = *(u8*)(src_reg + off) */
  1789			case BPF_LDX | BPF_MEM | BPF_B:
  1790			case BPF_LDX | BPF_PROBE_MEM | BPF_B:
  1791			case BPF_LDX | BPF_MEM | BPF_H:
  1792			case BPF_LDX | BPF_PROBE_MEM | BPF_H:
  1793			case BPF_LDX | BPF_MEM | BPF_W:
  1794			case BPF_LDX | BPF_PROBE_MEM | BPF_W:
  1795			case BPF_LDX | BPF_MEM | BPF_DW:
  1796			case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
  1797				/* LDXS: dst_reg = *(s8*)(src_reg + off) */
  1798			case BPF_LDX | BPF_MEMSX | BPF_B:
  1799			case BPF_LDX | BPF_MEMSX | BPF_H:
  1800			case BPF_LDX | BPF_MEMSX | BPF_W:
  1801			case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
  1802			case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
  1803			case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
  1804				insn_off = insn->off;
  1805	
  1806				if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
  1807				    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
  1808					/* Conservatively check that src_reg + insn->off is a kernel address:
  1809					 *   src_reg + insn->off >= TASK_SIZE_MAX + PAGE_SIZE
  1810					 * src_reg is used as scratch for src_reg += insn->off and restored
  1811					 * after emit_ldx if necessary
  1812					 */
  1813	
  1814					u64 limit = TASK_SIZE_MAX + PAGE_SIZE;
  1815					u8 *end_of_jmp;
  1816	
  1817					/* At end of these emitted checks, insn->off will have been added
  1818					 * to src_reg, so no need to do relative load with insn->off offset
  1819					 */
  1820					insn_off = 0;
  1821	
  1822					/* movabsq r11, limit */
  1823					EMIT2(add_1mod(0x48, AUX_REG), add_1reg(0xB8, AUX_REG));
  1824					EMIT((u32)limit, 4);
  1825					EMIT(limit >> 32, 4);
  1826	
  1827					if (insn->off) {
  1828						/* add src_reg, insn->off */
  1829						maybe_emit_1mod(&prog, src_reg, true);
  1830						EMIT2_off32(0x81, add_1reg(0xC0, src_reg), insn->off);
  1831					}
  1832	
  1833					/* cmp src_reg, r11 */
  1834					maybe_emit_mod(&prog, src_reg, AUX_REG, true);
  1835					EMIT2(0x39, add_2reg(0xC0, src_reg, AUX_REG));
  1836	
  1837					/* if unsigned '>=', goto load */
  1838					EMIT2(X86_JAE, 0);
  1839					end_of_jmp = prog;
  1840	
  1841					/* xor dst_reg, dst_reg */
  1842					emit_mov_imm32(&prog, false, dst_reg, 0);
  1843					/* jmp byte_after_ldx */
  1844					EMIT2(0xEB, 0);
  1845	
  1846					/* populate jmp_offset for JAE above to jump to start_of_ldx */
  1847					start_of_ldx = prog;
  1848					end_of_jmp[-1] = start_of_ldx - end_of_jmp;
  1849				}
  1850				if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
  1851				    BPF_MODE(insn->code) == BPF_MEMSX)
  1852					emit_ldsx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
  1853				else
  1854					emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
  1855				if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
  1856				    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
  1857					struct exception_table_entry *ex;
  1858					u8 *_insn = image + proglen + (start_of_ldx - temp);
  1859					s64 delta;
  1860	
  1861					/* populate jmp_offset for JMP above */
  1862					start_of_ldx[-1] = prog - start_of_ldx;
  1863	
  1864					if (insn->off && src_reg != dst_reg) {
  1865						/* sub src_reg, insn->off
  1866						 * Restore src_reg after "add src_reg, insn->off" in prev
  1867						 * if statement. But if src_reg == dst_reg, emit_ldx
  1868						 * above already clobbered src_reg, so no need to restore.
  1869						 * If add src_reg, insn->off was unnecessary, no need to
  1870						 * restore either.
  1871						 */
  1872						maybe_emit_1mod(&prog, src_reg, true);
  1873						EMIT2_off32(0x81, add_1reg(0xE8, src_reg), insn->off);
  1874					}
  1875	
  1876					if (!bpf_prog->aux->extable)
  1877						break;
  1878	
  1879					if (excnt >= bpf_prog->aux->num_exentries) {
  1880						pr_err("ex gen bug\n");
  1881						return -EFAULT;
  1882					}
  1883					ex = &bpf_prog->aux->extable[excnt++];
  1884	
  1885					delta = _insn - (u8 *)&ex->insn;
  1886					if (!is_simm32(delta)) {
  1887						pr_err("extable->insn doesn't fit into 32-bit\n");
  1888						return -EFAULT;
  1889					}
  1890					/* switch ex to rw buffer for writes */
  1891					ex = (void *)rw_image + ((void *)ex - (void *)image);
  1892	
  1893					ex->insn = delta;
  1894	
  1895					ex->data = EX_TYPE_BPF;
  1896	
  1897					if (dst_reg > BPF_REG_9) {
  1898						pr_err("verifier error\n");
  1899						return -EFAULT;
  1900					}
  1901					/*
  1902					 * Compute size of x86 insn and its target dest x86 register.
  1903					 * ex_handler_bpf() will use lower 8 bits to adjust
  1904					 * pt_regs->ip to jump over this x86 instruction
  1905					 * and upper bits to figure out which pt_regs to zero out.
  1906					 * End result: x86 insn "mov rbx, qword ptr [rax+0x14]"
  1907					 * of 4 bytes will be ignored and rbx will be zero inited.
  1908					 */
  1909					ex->fixup = (prog - start_of_ldx) | (reg2pt_regs[dst_reg] << 8);
  1910				}
  1911				break;
  1912	
  1913			/* internal-only per-cpu zero-extending memory load */
  1914			case BPF_LDX | BPF_MEM_PERCPU | BPF_B:
  1915			case BPF_LDX | BPF_MEM_PERCPU | BPF_H:
  1916			case BPF_LDX | BPF_MEM_PERCPU | BPF_W:
  1917			case BPF_LDX | BPF_MEM_PERCPU | BPF_DW:
  1918				insn_off = insn->off;
  1919				EMIT1(0x65); /* gs segment modifier */
  1920				emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
  1921				break;
  1922	
  1923			/* internal-only load-effective-address-of per-cpu offset */
  1924			case BPF_LDX | BPF_ADDR_PERCPU | BPF_DW: {
> 1925				u32 off = (u32)(void *)&this_cpu_off;
  1926	
  1927				/* mov <dst>, <src> (if necessary) */
  1928				EMIT_mov(dst_reg, src_reg);
  1929	
  1930				/* add <dst>, gs:[<off>] */
  1931				EMIT2(0x65, add_1mod(0x48, dst_reg));
  1932				EMIT3(0x03, add_1reg(0x04, dst_reg), 0x25);
  1933				EMIT(off, 4);
  1934	
  1935				break;
  1936			}
  1937			case BPF_STX | BPF_ATOMIC | BPF_W:
  1938			case BPF_STX | BPF_ATOMIC | BPF_DW:
  1939				if (insn->imm == (BPF_AND | BPF_FETCH) ||
  1940				    insn->imm == (BPF_OR | BPF_FETCH) ||
  1941				    insn->imm == (BPF_XOR | BPF_FETCH)) {
  1942					bool is64 = BPF_SIZE(insn->code) == BPF_DW;
  1943					u32 real_src_reg = src_reg;
  1944					u32 real_dst_reg = dst_reg;
  1945					u8 *branch_target;
  1946	
  1947					/*
  1948					 * Can't be implemented with a single x86 insn.
  1949					 * Need to do a CMPXCHG loop.
  1950					 */
  1951	
  1952					/* Will need RAX as a CMPXCHG operand so save R0 */
  1953					emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
  1954					if (src_reg == BPF_REG_0)
  1955						real_src_reg = BPF_REG_AX;
  1956					if (dst_reg == BPF_REG_0)
  1957						real_dst_reg = BPF_REG_AX;
  1958	
  1959					branch_target = prog;
  1960					/* Load old value */
  1961					emit_ldx(&prog, BPF_SIZE(insn->code),
  1962						 BPF_REG_0, real_dst_reg, insn->off);
  1963					/*
  1964					 * Perform the (commutative) operation locally,
  1965					 * put the result in the AUX_REG.
  1966					 */
  1967					emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
  1968					maybe_emit_mod(&prog, AUX_REG, real_src_reg, is64);
  1969					EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
  1970					      add_2reg(0xC0, AUX_REG, real_src_reg));
  1971					/* Attempt to swap in new value */
  1972					err = emit_atomic(&prog, BPF_CMPXCHG,
  1973							  real_dst_reg, AUX_REG,
  1974							  insn->off,
  1975							  BPF_SIZE(insn->code));
  1976					if (WARN_ON(err))
  1977						return err;
  1978					/*
  1979					 * ZF tells us whether we won the race. If it's
  1980					 * cleared we need to try again.
  1981					 */
  1982					EMIT2(X86_JNE, -(prog - branch_target) - 2);
  1983					/* Return the pre-modification value */
  1984					emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
  1985					/* Restore R0 after clobbering RAX */
  1986					emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
  1987					break;
  1988				}
  1989	
  1990				err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
  1991						  insn->off, BPF_SIZE(insn->code));
  1992				if (err)
  1993					return err;
  1994				break;
  1995	
  1996				/* call */
  1997			case BPF_JMP | BPF_CALL: {
  1998				int offs;
  1999	
  2000				func = (u8 *) __bpf_call_base + imm32;
  2001				if (tail_call_reachable) {
  2002					RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
  2003					if (!imm32)
  2004						return -EINVAL;
  2005					offs = 7 + x86_call_depth_emit_accounting(&prog, func);
  2006				} else {
  2007					if (!imm32)
  2008						return -EINVAL;
  2009					offs = x86_call_depth_emit_accounting(&prog, func);
  2010				}
  2011				if (emit_call(&prog, func, image + addrs[i - 1] + offs))
  2012					return -EINVAL;
  2013				break;
  2014			}
  2015	
  2016			case BPF_JMP | BPF_TAIL_CALL:
  2017				if (imm32)
  2018					emit_bpf_tail_call_direct(bpf_prog,
  2019								  &bpf_prog->aux->poke_tab[imm32 - 1],
  2020								  &prog, image + addrs[i - 1],
  2021								  callee_regs_used,
  2022								  bpf_prog->aux->stack_depth,
  2023								  ctx);
  2024				else
  2025					emit_bpf_tail_call_indirect(bpf_prog,
  2026								    &prog,
  2027								    callee_regs_used,
  2028								    bpf_prog->aux->stack_depth,
  2029								    image + addrs[i - 1],
  2030								    ctx);
  2031				break;
  2032	
  2033				/* cond jump */
  2034			case BPF_JMP | BPF_JEQ | BPF_X:
  2035			case BPF_JMP | BPF_JNE | BPF_X:
  2036			case BPF_JMP | BPF_JGT | BPF_X:
  2037			case BPF_JMP | BPF_JLT | BPF_X:
  2038			case BPF_JMP | BPF_JGE | BPF_X:
  2039			case BPF_JMP | BPF_JLE | BPF_X:
  2040			case BPF_JMP | BPF_JSGT | BPF_X:
  2041			case BPF_JMP | BPF_JSLT | BPF_X:
  2042			case BPF_JMP | BPF_JSGE | BPF_X:
  2043			case BPF_JMP | BPF_JSLE | BPF_X:
  2044			case BPF_JMP32 | BPF_JEQ | BPF_X:
  2045			case BPF_JMP32 | BPF_JNE | BPF_X:
  2046			case BPF_JMP32 | BPF_JGT | BPF_X:
  2047			case BPF_JMP32 | BPF_JLT | BPF_X:
  2048			case BPF_JMP32 | BPF_JGE | BPF_X:
  2049			case BPF_JMP32 | BPF_JLE | BPF_X:
  2050			case BPF_JMP32 | BPF_JSGT | BPF_X:
  2051			case BPF_JMP32 | BPF_JSLT | BPF_X:
  2052			case BPF_JMP32 | BPF_JSGE | BPF_X:
  2053			case BPF_JMP32 | BPF_JSLE | BPF_X:
  2054				/* cmp dst_reg, src_reg */
  2055				maybe_emit_mod(&prog, dst_reg, src_reg,
  2056					       BPF_CLASS(insn->code) == BPF_JMP);
  2057				EMIT2(0x39, add_2reg(0xC0, dst_reg, src_reg));
  2058				goto emit_cond_jmp;
  2059	
  2060			case BPF_JMP | BPF_JSET | BPF_X:
  2061			case BPF_JMP32 | BPF_JSET | BPF_X:
  2062				/* test dst_reg, src_reg */
  2063				maybe_emit_mod(&prog, dst_reg, src_reg,
  2064					       BPF_CLASS(insn->code) == BPF_JMP);
  2065				EMIT2(0x85, add_2reg(0xC0, dst_reg, src_reg));
  2066				goto emit_cond_jmp;
  2067	
  2068			case BPF_JMP | BPF_JSET | BPF_K:
  2069			case BPF_JMP32 | BPF_JSET | BPF_K:
  2070				/* test dst_reg, imm32 */
  2071				maybe_emit_1mod(&prog, dst_reg,
  2072						BPF_CLASS(insn->code) == BPF_JMP);
  2073				EMIT2_off32(0xF7, add_1reg(0xC0, dst_reg), imm32);
  2074				goto emit_cond_jmp;
  2075	
  2076			case BPF_JMP | BPF_JEQ | BPF_K:
  2077			case BPF_JMP | BPF_JNE | BPF_K:
  2078			case BPF_JMP | BPF_JGT | BPF_K:
  2079			case BPF_JMP | BPF_JLT | BPF_K:
  2080			case BPF_JMP | BPF_JGE | BPF_K:
  2081			case BPF_JMP | BPF_JLE | BPF_K:
  2082			case BPF_JMP | BPF_JSGT | BPF_K:
  2083			case BPF_JMP | BPF_JSLT | BPF_K:
  2084			case BPF_JMP | BPF_JSGE | BPF_K:
  2085			case BPF_JMP | BPF_JSLE | BPF_K:
  2086			case BPF_JMP32 | BPF_JEQ | BPF_K:
  2087			case BPF_JMP32 | BPF_JNE | BPF_K:
  2088			case BPF_JMP32 | BPF_JGT | BPF_K:
  2089			case BPF_JMP32 | BPF_JLT | BPF_K:
  2090			case BPF_JMP32 | BPF_JGE | BPF_K:
  2091			case BPF_JMP32 | BPF_JLE | BPF_K:
  2092			case BPF_JMP32 | BPF_JSGT | BPF_K:
  2093			case BPF_JMP32 | BPF_JSLT | BPF_K:
  2094			case BPF_JMP32 | BPF_JSGE | BPF_K:
  2095			case BPF_JMP32 | BPF_JSLE | BPF_K:
  2096				/* test dst_reg, dst_reg to save one extra byte */
  2097				if (imm32 == 0) {
  2098					maybe_emit_mod(&prog, dst_reg, dst_reg,
  2099						       BPF_CLASS(insn->code) == BPF_JMP);
  2100					EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
  2101					goto emit_cond_jmp;
  2102				}
  2103	
  2104				/* cmp dst_reg, imm8/32 */
  2105				maybe_emit_1mod(&prog, dst_reg,
  2106						BPF_CLASS(insn->code) == BPF_JMP);
  2107	
  2108				if (is_imm8(imm32))
  2109					EMIT3(0x83, add_1reg(0xF8, dst_reg), imm32);
  2110				else
  2111					EMIT2_off32(0x81, add_1reg(0xF8, dst_reg), imm32);
  2112	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

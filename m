Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FBD298CBE;
	Thu,  5 Mar 2026 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692752; cv=none; b=fQDUqx5S4Z62VfT0J4OOPx4kBZzKxsUp6wi7BU4vb77pod1qW6RxFfrSVczmuXOm1m1i39zNtcuZu8YZMtuOK/AJNjUCKpsOF5lRRHkrD0gfebevDagemHf+HUunlBinjoca4jcgGDASItBAu/TF8EVzLb6iEHereU7LKCoFQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692752; c=relaxed/simple;
	bh=08P+xjE+qk6UsI8mJrxebsA7ZIQQhBiJz1S2trq85zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K89722FWFeeBdGCc2MZoda7WKt/kftj9jIYpQAAfupFTIiopMYULtFgvWpki8CvOpSimpD+AJrX7ERztnCNt9LrA1my6OOv7kksOXNWPMLMgc79CPzs5Tbdxq/5g4SIuvkRQJLDaaut0WWmw+vI8Qq+5Zk8LLPsKx6y/LEx0oOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRGDL2Ej; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRGDL2Ej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772692751; x=1804228751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=08P+xjE+qk6UsI8mJrxebsA7ZIQQhBiJz1S2trq85zI=;
  b=iRGDL2EjwHfDYXZBx0nnPzq8KWQJl2ZNQTNjewkhQz7L+o4uGEkaUbTw
   W4l8KsL7Z0M+jAe72ztPBCZN45EPyLITeXbyFRQgf5UV/IHeFqS5Z6AuW
   t0bRwHVy/Hd9wjg1dsoCqhFvToOGXZm6Y2DSLEHR/gDTjKJhBHffDH9e0
   KvE3gvt08Z8TGCLXlKzpWYoc61m+jizSu420rUMkNIFhSKIiIDeR3A0Re
   WSOp8z79O+T3Gr70rX1pB07whj3TkLh7BmRIhsK/zraE4V8dGjPMn3epg
   SUr6q10ceK4OgLChgIs3sVZkTDSXVQ+cjLCl2j1qvQfWR/2D7vQdyzn7Z
   Q==;
X-CSE-ConnectionGUID: nojLGCdvRy6MgIDpZrDnbw==
X-CSE-MsgGUID: 7376VqK1TDSv7hWYGlrnFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73676972"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="73676972"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 22:39:10 -0800
X-CSE-ConnectionGUID: bC+F6IgTQTuCY9Sz1CyJRw==
X-CSE-MsgGUID: /WZQqOdbSIOFcsYMa2AF0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="217821731"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 04 Mar 2026 22:39:07 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy2MQ-0000000005m-4B7I;
	Thu, 05 Mar 2026 06:39:02 +0000
Date: Thu, 5 Mar 2026 14:38:43 +0800
From: kernel test robot <lkp@intel.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf, x86: Emit ENDBR for indirect jump
 targets
Message-ID: <202603051414.AAMjmOHv-lkp@intel.com>
References: <20260302102726.1126019-5-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302102726.1126019-5-xukuohai@huaweicloud.com>

Hi Xu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Kuohai/bpf-Move-JIT-for-single-subprog-programs-to-verifier/20260302-181031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260302102726.1126019-5-xukuohai%40huaweicloud.com
patch subject: [PATCH bpf-next v5 4/5] bpf, x86: Emit ENDBR for indirect jump targets
config: x86_64-buildonly-randconfig-001-20260305 (https://download.01.org/0day-ci/archive/20260305/202603051414.AAMjmOHv-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603051414.AAMjmOHv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051414.AAMjmOHv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/net/bpf_jit_comp.c: In function 'do_jit':
>> arch/x86/net/bpf_jit_comp.c:1747:37: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1747 |                         EMIT_ENDBR();
         |                                     ^


vim +/if +1747 arch/x86/net/bpf_jit_comp.c

  1660	
  1661	static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
  1662			  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
  1663	{
  1664		bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
  1665		struct bpf_insn *insn = bpf_prog->insnsi;
  1666		bool callee_regs_used[4] = {};
  1667		int insn_cnt = bpf_prog->len;
  1668		bool seen_exit = false;
  1669		u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
  1670		void __percpu *priv_frame_ptr = NULL;
  1671		u64 arena_vm_start, user_vm_start;
  1672		void __percpu *priv_stack_ptr;
  1673		int i, excnt = 0;
  1674		int ilen, proglen = 0;
  1675		u8 *prog = temp;
  1676		u32 stack_depth;
  1677		int err;
  1678	
  1679		stack_depth = bpf_prog->aux->stack_depth;
  1680		priv_stack_ptr = bpf_prog->aux->priv_stack_ptr;
  1681		if (priv_stack_ptr) {
  1682			priv_frame_ptr = priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(stack_depth, 8);
  1683			stack_depth = 0;
  1684		}
  1685	
  1686		arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
  1687		user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
  1688	
  1689		detect_reg_usage(insn, insn_cnt, callee_regs_used);
  1690	
  1691		emit_prologue(&prog, image, stack_depth,
  1692			      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
  1693			      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
  1694	
  1695		bpf_prog->aux->ksym.fp_start = prog - temp;
  1696	
  1697		/* Exception callback will clobber callee regs for its own use, and
  1698		 * restore the original callee regs from main prog's stack frame.
  1699		 */
  1700		if (bpf_prog->aux->exception_boundary) {
  1701			/* We also need to save r12, which is not mapped to any BPF
  1702			 * register, as we throw after entry into the kernel, which may
  1703			 * overwrite r12.
  1704			 */
  1705			push_r12(&prog);
  1706			push_callee_regs(&prog, all_callee_regs_used);
  1707		} else {
  1708			if (arena_vm_start)
  1709				push_r12(&prog);
  1710			push_callee_regs(&prog, callee_regs_used);
  1711		}
  1712		if (arena_vm_start)
  1713			emit_mov_imm64(&prog, X86_REG_R12,
  1714				       arena_vm_start >> 32, (u32) arena_vm_start);
  1715	
  1716		if (priv_frame_ptr)
  1717			emit_priv_frame_ptr(&prog, priv_frame_ptr);
  1718	
  1719		ilen = prog - temp;
  1720		if (rw_image)
  1721			memcpy(rw_image + proglen, temp, ilen);
  1722		proglen += ilen;
  1723		addrs[0] = proglen;
  1724		prog = temp;
  1725	
  1726		for (i = 1; i <= insn_cnt; i++, insn++) {
  1727			const s32 imm32 = insn->imm;
  1728			u32 dst_reg = insn->dst_reg;
  1729			u32 src_reg = insn->src_reg;
  1730			u8 b2 = 0, b3 = 0;
  1731			u8 *start_of_ldx;
  1732			s64 jmp_offset;
  1733			s16 insn_off;
  1734			u8 jmp_cond;
  1735			u8 *func;
  1736			int nops;
  1737	
  1738			if (priv_frame_ptr) {
  1739				if (src_reg == BPF_REG_FP)
  1740					src_reg = X86_REG_R9;
  1741	
  1742				if (dst_reg == BPF_REG_FP)
  1743					dst_reg = X86_REG_R9;
  1744			}
  1745	
  1746			if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
> 1747				EMIT_ENDBR();
  1748	
  1749			switch (insn->code) {
  1750				/* ALU */
  1751			case BPF_ALU | BPF_ADD | BPF_X:
  1752			case BPF_ALU | BPF_SUB | BPF_X:
  1753			case BPF_ALU | BPF_AND | BPF_X:
  1754			case BPF_ALU | BPF_OR | BPF_X:
  1755			case BPF_ALU | BPF_XOR | BPF_X:
  1756			case BPF_ALU64 | BPF_ADD | BPF_X:
  1757			case BPF_ALU64 | BPF_SUB | BPF_X:
  1758			case BPF_ALU64 | BPF_AND | BPF_X:
  1759			case BPF_ALU64 | BPF_OR | BPF_X:
  1760			case BPF_ALU64 | BPF_XOR | BPF_X:
  1761				maybe_emit_mod(&prog, dst_reg, src_reg,
  1762					       BPF_CLASS(insn->code) == BPF_ALU64);
  1763				b2 = simple_alu_opcodes[BPF_OP(insn->code)];
  1764				EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
  1765				break;
  1766	
  1767			case BPF_ALU64 | BPF_MOV | BPF_X:
  1768				if (insn_is_cast_user(insn)) {
  1769					if (dst_reg != src_reg)
  1770						/* 32-bit mov */
  1771						emit_mov_reg(&prog, false, dst_reg, src_reg);
  1772					/* shl dst_reg, 32 */
  1773					maybe_emit_1mod(&prog, dst_reg, true);
  1774					EMIT3(0xC1, add_1reg(0xE0, dst_reg), 32);
  1775	
  1776					/* or dst_reg, user_vm_start */
  1777					maybe_emit_1mod(&prog, dst_reg, true);
  1778					if (is_axreg(dst_reg))
  1779						EMIT1_off32(0x0D,  user_vm_start >> 32);
  1780					else
  1781						EMIT2_off32(0x81, add_1reg(0xC8, dst_reg),  user_vm_start >> 32);
  1782	
  1783					/* rol dst_reg, 32 */
  1784					maybe_emit_1mod(&prog, dst_reg, true);
  1785					EMIT3(0xC1, add_1reg(0xC0, dst_reg), 32);
  1786	
  1787					/* xor r11, r11 */
  1788					EMIT3(0x4D, 0x31, 0xDB);
  1789	
  1790					/* test dst_reg32, dst_reg32; check if lower 32-bit are zero */
  1791					maybe_emit_mod(&prog, dst_reg, dst_reg, false);
  1792					EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
  1793	
  1794					/* cmove r11, dst_reg; if so, set dst_reg to zero */
  1795					/* WARNING: Intel swapped src/dst register encoding in CMOVcc !!! */
  1796					maybe_emit_mod(&prog, AUX_REG, dst_reg, true);
  1797					EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
  1798					break;
  1799				} else if (insn_is_mov_percpu_addr(insn)) {
  1800					/* mov <dst>, <src> (if necessary) */
  1801					EMIT_mov(dst_reg, src_reg);
  1802	#ifdef CONFIG_SMP
  1803					/* add <dst>, gs:[<off>] */
  1804					EMIT2(0x65, add_1mod(0x48, dst_reg));
  1805					EMIT3(0x03, add_2reg(0x04, 0, dst_reg), 0x25);
  1806					EMIT((u32)(unsigned long)&this_cpu_off, 4);
  1807	#endif
  1808					break;
  1809				}
  1810				fallthrough;
  1811			case BPF_ALU | BPF_MOV | BPF_X:
  1812				if (insn->off == 0)
  1813					emit_mov_reg(&prog,
  1814						     BPF_CLASS(insn->code) == BPF_ALU64,
  1815						     dst_reg, src_reg);
  1816				else
  1817					emit_movsx_reg(&prog, insn->off,
  1818						       BPF_CLASS(insn->code) == BPF_ALU64,
  1819						       dst_reg, src_reg);
  1820				break;
  1821	
  1822				/* neg dst */
  1823			case BPF_ALU | BPF_NEG:
  1824			case BPF_ALU64 | BPF_NEG:
  1825				maybe_emit_1mod(&prog, dst_reg,
  1826						BPF_CLASS(insn->code) == BPF_ALU64);
  1827				EMIT2(0xF7, add_1reg(0xD8, dst_reg));
  1828				break;
  1829	
  1830			case BPF_ALU | BPF_ADD | BPF_K:
  1831			case BPF_ALU | BPF_SUB | BPF_K:
  1832			case BPF_ALU | BPF_AND | BPF_K:
  1833			case BPF_ALU | BPF_OR | BPF_K:
  1834			case BPF_ALU | BPF_XOR | BPF_K:
  1835			case BPF_ALU64 | BPF_ADD | BPF_K:
  1836			case BPF_ALU64 | BPF_SUB | BPF_K:
  1837			case BPF_ALU64 | BPF_AND | BPF_K:
  1838			case BPF_ALU64 | BPF_OR | BPF_K:
  1839			case BPF_ALU64 | BPF_XOR | BPF_K:
  1840				maybe_emit_1mod(&prog, dst_reg,
  1841						BPF_CLASS(insn->code) == BPF_ALU64);
  1842	
  1843				/*
  1844				 * b3 holds 'normal' opcode, b2 short form only valid
  1845				 * in case dst is eax/rax.
  1846				 */
  1847				switch (BPF_OP(insn->code)) {
  1848				case BPF_ADD:
  1849					b3 = 0xC0;
  1850					b2 = 0x05;
  1851					break;
  1852				case BPF_SUB:
  1853					b3 = 0xE8;
  1854					b2 = 0x2D;
  1855					break;
  1856				case BPF_AND:
  1857					b3 = 0xE0;
  1858					b2 = 0x25;
  1859					break;
  1860				case BPF_OR:
  1861					b3 = 0xC8;
  1862					b2 = 0x0D;
  1863					break;
  1864				case BPF_XOR:
  1865					b3 = 0xF0;
  1866					b2 = 0x35;
  1867					break;
  1868				}
  1869	
  1870				if (is_imm8(imm32))
  1871					EMIT3(0x83, add_1reg(b3, dst_reg), imm32);
  1872				else if (is_axreg(dst_reg))
  1873					EMIT1_off32(b2, imm32);
  1874				else
  1875					EMIT2_off32(0x81, add_1reg(b3, dst_reg), imm32);
  1876				break;
  1877	
  1878			case BPF_ALU64 | BPF_MOV | BPF_K:
  1879			case BPF_ALU | BPF_MOV | BPF_K:
  1880				emit_mov_imm32(&prog, BPF_CLASS(insn->code) == BPF_ALU64,
  1881					       dst_reg, imm32);
  1882				break;
  1883	
  1884			case BPF_LD | BPF_IMM | BPF_DW:
  1885				emit_mov_imm64(&prog, dst_reg, insn[1].imm, insn[0].imm);
  1886				insn++;
  1887				i++;
  1888				break;
  1889	
  1890				/* dst %= src, dst /= src, dst %= imm32, dst /= imm32 */
  1891			case BPF_ALU | BPF_MOD | BPF_X:
  1892			case BPF_ALU | BPF_DIV | BPF_X:
  1893			case BPF_ALU | BPF_MOD | BPF_K:
  1894			case BPF_ALU | BPF_DIV | BPF_K:
  1895			case BPF_ALU64 | BPF_MOD | BPF_X:
  1896			case BPF_ALU64 | BPF_DIV | BPF_X:
  1897			case BPF_ALU64 | BPF_MOD | BPF_K:
  1898			case BPF_ALU64 | BPF_DIV | BPF_K: {
  1899				bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
  1900	
  1901				if (dst_reg != BPF_REG_0)
  1902					EMIT1(0x50); /* push rax */
  1903				if (dst_reg != BPF_REG_3)
  1904					EMIT1(0x52); /* push rdx */
  1905	
  1906				if (BPF_SRC(insn->code) == BPF_X) {
  1907					if (src_reg == BPF_REG_0 ||
  1908					    src_reg == BPF_REG_3) {
  1909						/* mov r11, src_reg */
  1910						EMIT_mov(AUX_REG, src_reg);
  1911						src_reg = AUX_REG;
  1912					}
  1913				} else {
  1914					/* mov r11, imm32 */
  1915					EMIT3_off32(0x49, 0xC7, 0xC3, imm32);
  1916					src_reg = AUX_REG;
  1917				}
  1918	
  1919				if (dst_reg != BPF_REG_0)
  1920					/* mov rax, dst_reg */
  1921					emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
  1922	
  1923				if (insn->off == 0) {
  1924					/*
  1925					 * xor edx, edx
  1926					 * equivalent to 'xor rdx, rdx', but one byte less
  1927					 */
  1928					EMIT2(0x31, 0xd2);
  1929	
  1930					/* div src_reg */
  1931					maybe_emit_1mod(&prog, src_reg, is64);
  1932					EMIT2(0xF7, add_1reg(0xF0, src_reg));
  1933				} else {
  1934					if (BPF_CLASS(insn->code) == BPF_ALU)
  1935						EMIT1(0x99); /* cdq */
  1936					else
  1937						EMIT2(0x48, 0x99); /* cqo */
  1938	
  1939					/* idiv src_reg */
  1940					maybe_emit_1mod(&prog, src_reg, is64);
  1941					EMIT2(0xF7, add_1reg(0xF8, src_reg));
  1942				}
  1943	
  1944				if (BPF_OP(insn->code) == BPF_MOD &&
  1945				    dst_reg != BPF_REG_3)
  1946					/* mov dst_reg, rdx */
  1947					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_3);
  1948				else if (BPF_OP(insn->code) == BPF_DIV &&
  1949					 dst_reg != BPF_REG_0)
  1950					/* mov dst_reg, rax */
  1951					emit_mov_reg(&prog, is64, dst_reg, BPF_REG_0);
  1952	
  1953				if (dst_reg != BPF_REG_3)
  1954					EMIT1(0x5A); /* pop rdx */
  1955				if (dst_reg != BPF_REG_0)
  1956					EMIT1(0x58); /* pop rax */
  1957				break;
  1958			}
  1959	
  1960			case BPF_ALU | BPF_MUL | BPF_K:
  1961			case BPF_ALU64 | BPF_MUL | BPF_K:
  1962				maybe_emit_mod(&prog, dst_reg, dst_reg,
  1963					       BPF_CLASS(insn->code) == BPF_ALU64);
  1964	
  1965				if (is_imm8(imm32))
  1966					/* imul dst_reg, dst_reg, imm8 */
  1967					EMIT3(0x6B, add_2reg(0xC0, dst_reg, dst_reg),
  1968					      imm32);
  1969				else
  1970					/* imul dst_reg, dst_reg, imm32 */
  1971					EMIT2_off32(0x69,
  1972						    add_2reg(0xC0, dst_reg, dst_reg),
  1973						    imm32);
  1974				break;
  1975	
  1976			case BPF_ALU | BPF_MUL | BPF_X:
  1977			case BPF_ALU64 | BPF_MUL | BPF_X:
  1978				maybe_emit_mod(&prog, src_reg, dst_reg,
  1979					       BPF_CLASS(insn->code) == BPF_ALU64);
  1980	
  1981				/* imul dst_reg, src_reg */
  1982				EMIT3(0x0F, 0xAF, add_2reg(0xC0, src_reg, dst_reg));
  1983				break;
  1984	
  1985				/* Shifts */
  1986			case BPF_ALU | BPF_LSH | BPF_K:
  1987			case BPF_ALU | BPF_RSH | BPF_K:
  1988			case BPF_ALU | BPF_ARSH | BPF_K:
  1989			case BPF_ALU64 | BPF_LSH | BPF_K:
  1990			case BPF_ALU64 | BPF_RSH | BPF_K:
  1991			case BPF_ALU64 | BPF_ARSH | BPF_K:
  1992				maybe_emit_1mod(&prog, dst_reg,
  1993						BPF_CLASS(insn->code) == BPF_ALU64);
  1994	
  1995				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  1996				if (imm32 == 1)
  1997					EMIT2(0xD1, add_1reg(b3, dst_reg));
  1998				else
  1999					EMIT3(0xC1, add_1reg(b3, dst_reg), imm32);
  2000				break;
  2001	
  2002			case BPF_ALU | BPF_LSH | BPF_X:
  2003			case BPF_ALU | BPF_RSH | BPF_X:
  2004			case BPF_ALU | BPF_ARSH | BPF_X:
  2005			case BPF_ALU64 | BPF_LSH | BPF_X:
  2006			case BPF_ALU64 | BPF_RSH | BPF_X:
  2007			case BPF_ALU64 | BPF_ARSH | BPF_X:
  2008				/* BMI2 shifts aren't better when shift count is already in rcx */
  2009				if (boot_cpu_has(X86_FEATURE_BMI2) && src_reg != BPF_REG_4) {
  2010					/* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
  2011					bool w = (BPF_CLASS(insn->code) == BPF_ALU64);
  2012					u8 op;
  2013	
  2014					switch (BPF_OP(insn->code)) {
  2015					case BPF_LSH:
  2016						op = 1; /* prefix 0x66 */
  2017						break;
  2018					case BPF_RSH:
  2019						op = 3; /* prefix 0xf2 */
  2020						break;
  2021					case BPF_ARSH:
  2022						op = 2; /* prefix 0xf3 */
  2023						break;
  2024					}
  2025	
  2026					emit_shiftx(&prog, dst_reg, src_reg, w, op);
  2027	
  2028					break;
  2029				}
  2030	
  2031				if (src_reg != BPF_REG_4) { /* common case */
  2032					/* Check for bad case when dst_reg == rcx */
  2033					if (dst_reg == BPF_REG_4) {
  2034						/* mov r11, dst_reg */
  2035						EMIT_mov(AUX_REG, dst_reg);
  2036						dst_reg = AUX_REG;
  2037					} else {
  2038						EMIT1(0x51); /* push rcx */
  2039					}
  2040					/* mov rcx, src_reg */
  2041					EMIT_mov(BPF_REG_4, src_reg);
  2042				}
  2043	
  2044				/* shl %rax, %cl | shr %rax, %cl | sar %rax, %cl */
  2045				maybe_emit_1mod(&prog, dst_reg,
  2046						BPF_CLASS(insn->code) == BPF_ALU64);
  2047	
  2048				b3 = simple_alu_opcodes[BPF_OP(insn->code)];
  2049				EMIT2(0xD3, add_1reg(b3, dst_reg));
  2050	
  2051				if (src_reg != BPF_REG_4) {
  2052					if (insn->dst_reg == BPF_REG_4)
  2053						/* mov dst_reg, r11 */
  2054						EMIT_mov(insn->dst_reg, AUX_REG);
  2055					else
  2056						EMIT1(0x59); /* pop rcx */
  2057				}
  2058	
  2059				break;
  2060	
  2061			case BPF_ALU | BPF_END | BPF_FROM_BE:
  2062			case BPF_ALU64 | BPF_END | BPF_FROM_LE:
  2063				switch (imm32) {
  2064				case 16:
  2065					/* Emit 'ror %ax, 8' to swap lower 2 bytes */
  2066					EMIT1(0x66);
  2067					if (is_ereg(dst_reg))
  2068						EMIT1(0x41);
  2069					EMIT3(0xC1, add_1reg(0xC8, dst_reg), 8);
  2070	
  2071					/* Emit 'movzwl eax, ax' */
  2072					if (is_ereg(dst_reg))
  2073						EMIT3(0x45, 0x0F, 0xB7);
  2074					else
  2075						EMIT2(0x0F, 0xB7);
  2076					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  2077					break;
  2078				case 32:
  2079					/* Emit 'bswap eax' to swap lower 4 bytes */
  2080					if (is_ereg(dst_reg))
  2081						EMIT2(0x41, 0x0F);
  2082					else
  2083						EMIT1(0x0F);
  2084					EMIT1(add_1reg(0xC8, dst_reg));
  2085					break;
  2086				case 64:
  2087					/* Emit 'bswap rax' to swap 8 bytes */
  2088					EMIT3(add_1mod(0x48, dst_reg), 0x0F,
  2089					      add_1reg(0xC8, dst_reg));
  2090					break;
  2091				}
  2092				break;
  2093	
  2094			case BPF_ALU | BPF_END | BPF_FROM_LE:
  2095				switch (imm32) {
  2096				case 16:
  2097					/*
  2098					 * Emit 'movzwl eax, ax' to zero extend 16-bit
  2099					 * into 64 bit
  2100					 */
  2101					if (is_ereg(dst_reg))
  2102						EMIT3(0x45, 0x0F, 0xB7);
  2103					else
  2104						EMIT2(0x0F, 0xB7);
  2105					EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
  2106					break;
  2107				case 32:
  2108					/* Emit 'mov eax, eax' to clear upper 32-bits */
  2109					if (is_ereg(dst_reg))
  2110						EMIT1(0x45);
  2111					EMIT2(0x89, add_2reg(0xC0, dst_reg, dst_reg));
  2112					break;
  2113				case 64:
  2114					/* nop */
  2115					break;
  2116				}
  2117				break;
  2118	
  2119				/* speculation barrier */
  2120			case BPF_ST | BPF_NOSPEC:
  2121				EMIT_LFENCE();
  2122				break;
  2123	
  2124				/* ST: *(u8*)(dst_reg + off) = imm */
  2125			case BPF_ST | BPF_MEM | BPF_B:
  2126				if (is_ereg(dst_reg))
  2127					EMIT2(0x41, 0xC6);
  2128				else
  2129					EMIT1(0xC6);
  2130				goto st;
  2131			case BPF_ST | BPF_MEM | BPF_H:
  2132				if (is_ereg(dst_reg))
  2133					EMIT3(0x66, 0x41, 0xC7);
  2134				else
  2135					EMIT2(0x66, 0xC7);
  2136				goto st;
  2137			case BPF_ST | BPF_MEM | BPF_W:
  2138				if (is_ereg(dst_reg))
  2139					EMIT2(0x41, 0xC7);
  2140				else
  2141					EMIT1(0xC7);
  2142				goto st;
  2143			case BPF_ST | BPF_MEM | BPF_DW:
  2144				EMIT2(add_1mod(0x48, dst_reg), 0xC7);
  2145	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

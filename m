Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2020C34BA56
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596793; cv=none; b=GTBo+cFoSLnfexFksrKHXgA1I8jeWO0zJLuETiswY9oOAJs4N59nuNjEG6ls9GNqWuGXz+AH2X2Bw1+g9fmyZcVHg+RebuDH/zNexsBBiKMacjJLhbL8fmU3knLNMxFEgTOP/S74FZN2vwEaakDH4pCh59A4yKQG0xPUhtz9tPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596793; c=relaxed/simple;
	bh=OUI1A7ygL/iNXUbKNK+B4L0+mjxdJh6wHVrnM+wAuho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/Lh2gQB/OwfVUxYKI5Vxaq1vSE9ljzycBAxv8CFTYGjQwL566T4gFJrer7sa2xAiDbWGvvjYjTnmudx+rT//1CONjZCHP0XYqv/rQYwTZSzyEymFL5sXFwzJUisdczlmF5eVjz+o6rTuMxAv3vaNBJgomcrtTnDMfpmGxFmyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rH6qOMIC; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rH6qOMIC"
Message-ID: <ab290f15-77f9-4680-942e-17d910c03b4c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771596779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISt+ZhBmiTcwgwZuK2HN5EncESz0NE0wpGRN8/6gb34=;
	b=rH6qOMICWP5n7zm7TDqIpUKD8SnrEN8pCfZRWkFE0d4gPjOeKKBXg4uqMvRaf3Z5r0VcjQ
	wLK5sM4+aC1rxYeJBmi8e5bqJLUZJkS/ZTtn7JI9VIQSCQ9/OaSntdHtw1EpzFpkxdTelL
	vIjyItH04Ise7pFzqEtqIQUxlHjJv4k=
Date: Fri, 20 Feb 2026 22:12:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/6] bpf, x86: Add 64-bit bitops kfuncs
 support for x86_64
To: kernel test robot <lkp@intel.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Peilin Ye <yepeilin@google.com>,
 Luis Gerhorst <luis.gerhorst@fau.de>, Viktor Malik <vmalik@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260219142933.13904-3-leon.hwang@linux.dev>
 <202602200536.JWzGHAc6-lkp@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <202602200536.JWzGHAc6-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/20 06:05, kernel test robot wrote:
> Hi Leon,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-Introduce-64-bit-bitops-kfuncs/20260219-223550
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20260219142933.13904-3-leon.hwang%40linux.dev
> patch subject: [PATCH bpf-next v2 2/6] bpf, x86: Add 64-bit bitops kfuncs support for x86_64
> config: x86_64-randconfig-073-20260220 (https://download.01.org/0day-ci/archive/20260220/202602200536.JWzGHAc6-lkp@intel.com/config)

Ack.

It was caused by the missing CONFIG_BPF_SYSCALL.

$ rg _BPF .config
118:CONFIG_BPF=y
120:CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
125:# CONFIG_BPF_SYSCALL is not set
126:CONFIG_BPF_JIT=y
127:CONFIG_BPF_JIT_DEFAULT_ON=y
1339:CONFIG_LWTUNNEL_BPF=y
7449:CONFIG_IO_URING_BPF=y

I'll make those symbols relied on CONFIG_BPF_SYSCALL in the next revision.

Thanks,
Leon

> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260220/202602200536.JWzGHAc6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602200536.JWzGHAc6-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: arch/x86/net/bpf_jit_comp.o: in function `bpf_inlines_func_call':
>>> arch/x86/net/bpf_jit_comp.c:1621:(.text+0xe70b): undefined reference to `bpf_clz64'
>>> ld: arch/x86/net/bpf_jit_comp.c:1647:(.text+0xe718): undefined reference to `bpf_ctz64'
>>> ld: arch/x86/net/bpf_jit_comp.c:1673:(.text+0xe725): undefined reference to `bpf_ffs64'
>>> ld: arch/x86/net/bpf_jit_comp.c:1677:(.text+0xe732): undefined reference to `bpf_fls64'
>>> ld: arch/x86/net/bpf_jit_comp.c:1683:(.text+0xe743): undefined reference to `bpf_popcnt64'
>>> ld: arch/x86/net/bpf_jit_comp.c:1707:(.text+0xe758): undefined reference to `bpf_rol64'
>>> ld: arch/x86/net/bpf_jit_comp.c:1714:(.text+0xe765): undefined reference to `bpf_ror64'
>    ld: arch/x86/net/bpf_jit_comp.c:1647:(.text+0x10e85): undefined reference to `bpf_ctz64'
>    ld: arch/x86/net/bpf_jit_comp.c:1673:(.text+0x10e92): undefined reference to `bpf_ffs64'
>    ld: arch/x86/net/bpf_jit_comp.o: in function `bpf_jit_inlines_kfunc_call':
>>> arch/x86/net/bpf_jit_comp.c:4247:(.text+0x177c8): undefined reference to `bpf_ffs64'
>    ld: arch/x86/net/bpf_jit_comp.c:4247:(.text+0x177d1): undefined reference to `bpf_ctz64'
>    ld: arch/x86/net/bpf_jit_comp.c:4250:(.text+0x177da): undefined reference to `bpf_fls64'
>>> ld: arch/x86/net/bpf_jit_comp.c:4250:(.text+0x177e3): undefined reference to `bpf_clz64'
>    ld: arch/x86/net/bpf_jit_comp.c:4253:(.text+0x177ec): undefined reference to `bpf_popcnt64'
>    ld: arch/x86/net/bpf_jit_comp.c:4256:(.text+0x177f5): undefined reference to `bpf_ror64'
>    ld: arch/x86/net/bpf_jit_comp.c:4256:(.text+0x177ff): undefined reference to `bpf_rol64'
> 
> 
> vim +1621 arch/x86/net/bpf_jit_comp.c
> 
>   1607	
>   1608	static bool bpf_inlines_func_call(u8 **pprog, void *func)
>   1609	{
>   1610		bool has_popcnt = boot_cpu_has(X86_FEATURE_POPCNT);
>   1611		bool has_bmi1 = boot_cpu_has(X86_FEATURE_BMI1);
>   1612		bool has_abm = boot_cpu_has(X86_FEATURE_ABM);
>   1613		bool inlined = true;
>   1614		u8 *prog = *pprog;
>   1615	
>   1616		/*
>   1617		 * x86 Bit manipulation instruction set
>   1618		 * https://en.wikipedia.org/wiki/X86_Bit_manipulation_instruction_set
>   1619		 */
>   1620	
>> 1621		if (func == bpf_clz64 && has_abm) {
>   1622			/*
>   1623			 * Intel® 64 and IA-32 Architectures Software Developer's Manual (June 2023)
>   1624			 *
>   1625			 *   LZCNT - Count the Number of Leading Zero Bits
>   1626			 *
>   1627			 *     Opcode/Instruction
>   1628			 *     F3 REX.W 0F BD /r
>   1629			 *     LZCNT r64, r/m64
>   1630			 *
>   1631			 *     Op/En
>   1632			 *     RVM
>   1633			 *
>   1634			 *     64/32-bit Mode
>   1635			 *     V/N.E.
>   1636			 *
>   1637			 *     CPUID Feature Flag
>   1638			 *     LZCNT
>   1639			 *
>   1640			 *     Description
>   1641			 *     Count the number of leading zero bits in r/m64, return
>   1642			 *     result in r64.
>   1643			 */
>   1644			/* emit: x ? 64 - fls64(x) : 64 */
>   1645			/* lzcnt rax, rdi */
>   1646			EMIT5(0xF3, 0x48, 0x0F, 0xBD, 0xC7);
>> 1647		} else if (func == bpf_ctz64 && has_bmi1) {
>   1648			/*
>   1649			 * Intel® 64 and IA-32 Architectures Software Developer's Manual (June 2023)
>   1650			 *
>   1651			 *   TZCNT - Count the Number of Trailing Zero Bits
>   1652			 *
>   1653			 *     Opcode/Instruction
>   1654			 *     F3 REX.W 0F BC /r
>   1655			 *     TZCNT r64, r/m64
>   1656			 *
>   1657			 *     Op/En
>   1658			 *     RVM
>   1659			 *
>   1660			 *     64/32-bit Mode
>   1661			 *     V/N.E.
>   1662			 *
>   1663			 *     CPUID Feature Flag
>   1664			 *     BMI1
>   1665			 *
>   1666			 *     Description
>   1667			 *     Count the number of trailing zero bits in r/m64, return
>   1668			 *     result in r64.
>   1669			 */
>   1670			/* emit: x ? __ffs64(x) : 64 */
>   1671			/* tzcnt rax, rdi */
>   1672			EMIT5(0xF3, 0x48, 0x0F, 0xBC, 0xC7);
>> 1673		} else if (func == bpf_ffs64 && has_bmi1) {
>   1674			/* emit: __ffs64(x); x == 0 has been handled in verifier */
>   1675			/* tzcnt rax, rdi */
>   1676			EMIT5(0xF3, 0x48, 0x0F, 0xBC, 0xC7);
>> 1677		} else if (func == bpf_fls64 && has_abm) {
>   1678			/* emit: fls64(x) */
>   1679			/* lzcnt rax, rdi */
>   1680			EMIT5(0xF3, 0x48, 0x0F, 0xBD, 0xC7);
>   1681			EMIT3(0x48, 0xF7, 0xD8);       /* neg rax */
>   1682			EMIT4(0x48, 0x83, 0xC0, 0x40); /* add rax, 64 */
>> 1683		} else if (func == bpf_popcnt64 && has_popcnt) {
>   1684			/*
>   1685			 * Intel® 64 and IA-32 Architectures Software Developer's Manual (June 2023)
>   1686			 *
>   1687			 *   POPCNT - Return the Count of Number of Bits Set to 1
>   1688			 *
>   1689			 *     Opcode/Instruction
>   1690			 *     F3 REX.W 0F B8 /r
>   1691			 *     POPCNT r64, r/m64
>   1692			 *
>   1693			 *     Op/En
>   1694			 *     RM
>   1695			 *
>   1696			 *     64 Mode
>   1697			 *     Valid
>   1698			 *
>   1699			 *     Compat/Leg Mode
>   1700			 *     N.E.
>   1701			 *
>   1702			 *     Description
>   1703			 *     POPCNT on r/m64
>   1704			 */
>   1705			/* popcnt rax, rdi */
>   1706			EMIT5(0xF3, 0x48, 0x0F, 0xB8, 0xC7);
>> 1707		} else if (func == bpf_rol64) {
>   1708			EMIT1(0x51);             /* push rcx */
>   1709			/* emit: rol64(x, s) */
>   1710			EMIT3(0x48, 0x89, 0xF1); /* mov rcx, rsi */
>   1711			EMIT3(0x48, 0x89, 0xF8); /* mov rax, rdi */
>   1712			EMIT3(0x48, 0xD3, 0xC0); /* rol rax, cl */
>   1713			EMIT1(0x59);             /* pop rcx */
>> 1714		} else if (func == bpf_ror64) {
>   1715			EMIT1(0x51);             /* push rcx */
>   1716			/* emit: ror64(x, s) */
>   1717			EMIT3(0x48, 0x89, 0xF1); /* mov rcx, rsi */
>   1718			EMIT3(0x48, 0x89, 0xF8); /* mov rax, rdi */
>   1719			EMIT3(0x48, 0xD3, 0xC8); /* ror rax, cl */
>   1720			EMIT1(0x59);             /* pop rcx */
>   1721		} else {
>   1722			inlined = false;
>   1723		}
>   1724	
>   1725		*pprog = prog;
>   1726		return inlined;
>   1727	}
>   1728	
> 


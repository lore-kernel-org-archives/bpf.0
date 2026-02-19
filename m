Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01762F5A06;
	Thu, 19 Feb 2026 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771538758; cv=none; b=iX7xbIs79ik3PrfTFIe/rl8fLYjm5d5B/B7B2Z6j6kGQ2wTPZRzu7noIwfXG4oz/UcfDGOvqqvVHHwbPjhMMEyIpEmiVwpGVRq3FEhvC80H6lOslh1lgVkeE4ny4HNE5v/6RXjFd3Zuiw6tRJxBkiUtGP6EMCmc/Vjp9FBsJ8eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771538758; c=relaxed/simple;
	bh=xNuRCdmIcI9DWfIUR4spe/tz7x/2mIOXeyKXOf2vRbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAz8L0FaflYwmP1m0RYnEDocsXWzdgeTSxulHzBKKjvrvyYtU9vtYqxYu8TxhSVSgXdE9EsZp6VdBcmMT+0hqMYzXukjUuvC/lLIKEoLpZr05Jj/oRzQrFulYc25dtnftfNF2NqZMXzYKLQ65J4kz5kRYQs8dwAF65Md0p5svUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Un/fJ9tq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Un/fJ9tq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771538757; x=1803074757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xNuRCdmIcI9DWfIUR4spe/tz7x/2mIOXeyKXOf2vRbM=;
  b=Un/fJ9tqAcUXzzBEIxTZjhdIb+hXte5kj3fDywnjXA0ZZx3F0Ktt+UoV
   qHHuh3XOnEJph9WJJi8aZ86lul6mluQjUAzs/WL5cDdNRzdcnoFd7V1qd
   v5bWPQ9m8ivmOnLFvIwuH9T5cb7DhRmnRfCNBAZtqhl1AmSp8i0BGb1pH
   dOTZ4Y5rFvxidMQG/tubAmMWIOpQzWOkawVUJZAMDuridAAoTOMSY8sVj
   zCP6/KU0frbWN7QGhxKCEzrdcwO1PptpU+tfR9aX5NGaHsvAlBtjkmGAp
   eSWUFsgOTDXsyDVRXRT3qXv5SzUdVOJZisAQFUI0fWlc4AhUpCp4mCxDP
   A==;
X-CSE-ConnectionGUID: 7hbq64MySxyXthoxAX1qNQ==
X-CSE-MsgGUID: 3VUKPljSTnWVEyMm4bF60g==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="98101309"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="98101309"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 14:05:56 -0800
X-CSE-ConnectionGUID: rMe7/UydR8quK7ptMGxeUw==
X-CSE-MsgGUID: f9ybEvIFS4Ww19OssGq9QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="219220500"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 19 Feb 2026 14:05:49 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtC9b-000000013ae-1rXj;
	Thu, 19 Feb 2026 22:05:47 +0000
Date: Fri, 20 Feb 2026 06:05:16 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Leon Hwang <leon.hwang@linux.dev>, Peilin Ye <yepeilin@google.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Viktor Malik <vmalik@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/6] bpf, x86: Add 64-bit bitops kfuncs
 support for x86_64
Message-ID: <202602200536.JWzGHAc6-lkp@intel.com>
References: <20260219142933.13904-3-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219142933.13904-3-leon.hwang@linux.dev>

Hi Leon,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-Introduce-64-bit-bitops-kfuncs/20260219-223550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260219142933.13904-3-leon.hwang%40linux.dev
patch subject: [PATCH bpf-next v2 2/6] bpf, x86: Add 64-bit bitops kfuncs support for x86_64
config: x86_64-randconfig-073-20260220 (https://download.01.org/0day-ci/archive/20260220/202602200536.JWzGHAc6-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260220/202602200536.JWzGHAc6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602200536.JWzGHAc6-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/net/bpf_jit_comp.o: in function `bpf_inlines_func_call':
>> arch/x86/net/bpf_jit_comp.c:1621:(.text+0xe70b): undefined reference to `bpf_clz64'
>> ld: arch/x86/net/bpf_jit_comp.c:1647:(.text+0xe718): undefined reference to `bpf_ctz64'
>> ld: arch/x86/net/bpf_jit_comp.c:1673:(.text+0xe725): undefined reference to `bpf_ffs64'
>> ld: arch/x86/net/bpf_jit_comp.c:1677:(.text+0xe732): undefined reference to `bpf_fls64'
>> ld: arch/x86/net/bpf_jit_comp.c:1683:(.text+0xe743): undefined reference to `bpf_popcnt64'
>> ld: arch/x86/net/bpf_jit_comp.c:1707:(.text+0xe758): undefined reference to `bpf_rol64'
>> ld: arch/x86/net/bpf_jit_comp.c:1714:(.text+0xe765): undefined reference to `bpf_ror64'
   ld: arch/x86/net/bpf_jit_comp.c:1647:(.text+0x10e85): undefined reference to `bpf_ctz64'
   ld: arch/x86/net/bpf_jit_comp.c:1673:(.text+0x10e92): undefined reference to `bpf_ffs64'
   ld: arch/x86/net/bpf_jit_comp.o: in function `bpf_jit_inlines_kfunc_call':
>> arch/x86/net/bpf_jit_comp.c:4247:(.text+0x177c8): undefined reference to `bpf_ffs64'
   ld: arch/x86/net/bpf_jit_comp.c:4247:(.text+0x177d1): undefined reference to `bpf_ctz64'
   ld: arch/x86/net/bpf_jit_comp.c:4250:(.text+0x177da): undefined reference to `bpf_fls64'
>> ld: arch/x86/net/bpf_jit_comp.c:4250:(.text+0x177e3): undefined reference to `bpf_clz64'
   ld: arch/x86/net/bpf_jit_comp.c:4253:(.text+0x177ec): undefined reference to `bpf_popcnt64'
   ld: arch/x86/net/bpf_jit_comp.c:4256:(.text+0x177f5): undefined reference to `bpf_ror64'
   ld: arch/x86/net/bpf_jit_comp.c:4256:(.text+0x177ff): undefined reference to `bpf_rol64'


vim +1621 arch/x86/net/bpf_jit_comp.c

  1607	
  1608	static bool bpf_inlines_func_call(u8 **pprog, void *func)
  1609	{
  1610		bool has_popcnt = boot_cpu_has(X86_FEATURE_POPCNT);
  1611		bool has_bmi1 = boot_cpu_has(X86_FEATURE_BMI1);
  1612		bool has_abm = boot_cpu_has(X86_FEATURE_ABM);
  1613		bool inlined = true;
  1614		u8 *prog = *pprog;
  1615	
  1616		/*
  1617		 * x86 Bit manipulation instruction set
  1618		 * https://en.wikipedia.org/wiki/X86_Bit_manipulation_instruction_set
  1619		 */
  1620	
> 1621		if (func == bpf_clz64 && has_abm) {
  1622			/*
  1623			 * Intel® 64 and IA-32 Architectures Software Developer's Manual (June 2023)
  1624			 *
  1625			 *   LZCNT - Count the Number of Leading Zero Bits
  1626			 *
  1627			 *     Opcode/Instruction
  1628			 *     F3 REX.W 0F BD /r
  1629			 *     LZCNT r64, r/m64
  1630			 *
  1631			 *     Op/En
  1632			 *     RVM
  1633			 *
  1634			 *     64/32-bit Mode
  1635			 *     V/N.E.
  1636			 *
  1637			 *     CPUID Feature Flag
  1638			 *     LZCNT
  1639			 *
  1640			 *     Description
  1641			 *     Count the number of leading zero bits in r/m64, return
  1642			 *     result in r64.
  1643			 */
  1644			/* emit: x ? 64 - fls64(x) : 64 */
  1645			/* lzcnt rax, rdi */
  1646			EMIT5(0xF3, 0x48, 0x0F, 0xBD, 0xC7);
> 1647		} else if (func == bpf_ctz64 && has_bmi1) {
  1648			/*
  1649			 * Intel® 64 and IA-32 Architectures Software Developer's Manual (June 2023)
  1650			 *
  1651			 *   TZCNT - Count the Number of Trailing Zero Bits
  1652			 *
  1653			 *     Opcode/Instruction
  1654			 *     F3 REX.W 0F BC /r
  1655			 *     TZCNT r64, r/m64
  1656			 *
  1657			 *     Op/En
  1658			 *     RVM
  1659			 *
  1660			 *     64/32-bit Mode
  1661			 *     V/N.E.
  1662			 *
  1663			 *     CPUID Feature Flag
  1664			 *     BMI1
  1665			 *
  1666			 *     Description
  1667			 *     Count the number of trailing zero bits in r/m64, return
  1668			 *     result in r64.
  1669			 */
  1670			/* emit: x ? __ffs64(x) : 64 */
  1671			/* tzcnt rax, rdi */
  1672			EMIT5(0xF3, 0x48, 0x0F, 0xBC, 0xC7);
> 1673		} else if (func == bpf_ffs64 && has_bmi1) {
  1674			/* emit: __ffs64(x); x == 0 has been handled in verifier */
  1675			/* tzcnt rax, rdi */
  1676			EMIT5(0xF3, 0x48, 0x0F, 0xBC, 0xC7);
> 1677		} else if (func == bpf_fls64 && has_abm) {
  1678			/* emit: fls64(x) */
  1679			/* lzcnt rax, rdi */
  1680			EMIT5(0xF3, 0x48, 0x0F, 0xBD, 0xC7);
  1681			EMIT3(0x48, 0xF7, 0xD8);       /* neg rax */
  1682			EMIT4(0x48, 0x83, 0xC0, 0x40); /* add rax, 64 */
> 1683		} else if (func == bpf_popcnt64 && has_popcnt) {
  1684			/*
  1685			 * Intel® 64 and IA-32 Architectures Software Developer's Manual (June 2023)
  1686			 *
  1687			 *   POPCNT - Return the Count of Number of Bits Set to 1
  1688			 *
  1689			 *     Opcode/Instruction
  1690			 *     F3 REX.W 0F B8 /r
  1691			 *     POPCNT r64, r/m64
  1692			 *
  1693			 *     Op/En
  1694			 *     RM
  1695			 *
  1696			 *     64 Mode
  1697			 *     Valid
  1698			 *
  1699			 *     Compat/Leg Mode
  1700			 *     N.E.
  1701			 *
  1702			 *     Description
  1703			 *     POPCNT on r/m64
  1704			 */
  1705			/* popcnt rax, rdi */
  1706			EMIT5(0xF3, 0x48, 0x0F, 0xB8, 0xC7);
> 1707		} else if (func == bpf_rol64) {
  1708			EMIT1(0x51);             /* push rcx */
  1709			/* emit: rol64(x, s) */
  1710			EMIT3(0x48, 0x89, 0xF1); /* mov rcx, rsi */
  1711			EMIT3(0x48, 0x89, 0xF8); /* mov rax, rdi */
  1712			EMIT3(0x48, 0xD3, 0xC0); /* rol rax, cl */
  1713			EMIT1(0x59);             /* pop rcx */
> 1714		} else if (func == bpf_ror64) {
  1715			EMIT1(0x51);             /* push rcx */
  1716			/* emit: ror64(x, s) */
  1717			EMIT3(0x48, 0x89, 0xF1); /* mov rcx, rsi */
  1718			EMIT3(0x48, 0x89, 0xF8); /* mov rax, rdi */
  1719			EMIT3(0x48, 0xD3, 0xC8); /* ror rax, cl */
  1720			EMIT1(0x59);             /* pop rcx */
  1721		} else {
  1722			inlined = false;
  1723		}
  1724	
  1725		*pprog = prog;
  1726		return inlined;
  1727	}
  1728	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

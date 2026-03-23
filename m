Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17D3164B4;
	Mon, 23 Mar 2026 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249691; cv=none; b=bKH9XYQZyTYyoVX1WY4hAIFXeEdSe1LfcUu4yiht1PyF5hMQBJ+VGgeIPPHmTRh7wotlVduqgxKfELK7NVLGBw8Kq+3GBXXGpPhnJ9ELHAKIaaMcXuNNPcDtkZDex2jvDVeDj6ohdpLE01HfWOrjnbjlRhUyH9cXxRzsVwxP8p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249691; c=relaxed/simple;
	bh=RCpk62n3AYbYiVU8MLmHxHTP0ibiZw4A4+CXyOIQstk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apgo8KsekhnMNEJ8Cr2hhCDcAoto1uJqFyrOinTHgkbasE42uGrGzbCoCICOpw9cfjquITMQ+6N3DkV7Mltd8Y/bDrG8LF3UqGP4W22JWAeSohfHB7SmUXpQ0W/icykkVmWvnqF3rMFjpcVEDXS1egzqXXcOSNgHyjDV7pROQ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBIe6ECB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBIe6ECB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774249689; x=1805785689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RCpk62n3AYbYiVU8MLmHxHTP0ibiZw4A4+CXyOIQstk=;
  b=TBIe6ECBaG7YbtyvMgl4zH9374wdggctey17zDE9OTHh5Kpzhki3sSEX
   CLMJ5WSeTb7Uudlb2LdyTGXjAlr0DU2HjW0mcl0mv7maXIhuy8/e2Xoao
   it3g5ddyMJVWaZoOhqc6Q5D83K83RvQV5GldDMsyuqDiBFDJNoWtTL5oR
   oj9laSEUTAXSCBD6cVR+RYsqYi5MJ269SV8x45NuuS6Rih5TwwMwOBAfK
   820Z/6d/x4GBp6N366mp/yf6Er8U2v8rlj6/siuEK7GWWKp+93GrXyqp1
   lhRQK1ofy1Y+oGKyPs5MPN8DhIQaf+NZre3vB+hiwaDqJQsobGXXezdJ4
   w==;
X-CSE-ConnectionGUID: r+bA+MCpRdSY7C28BRmXpg==
X-CSE-MsgGUID: 9rTP+yXOQ3eax83fsuVo+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="77851862"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="77851862"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 00:08:08 -0700
X-CSE-ConnectionGUID: kRJ1g0y0QDaExnkxhsB7Kg==
X-CSE-MsgGUID: badPk84/Tv+lneKFJzNajg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="219142609"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa006.fm.intel.com with ESMTP; 23 Mar 2026 00:08:03 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4ZOK-000000006Zt-2URK;
	Mon, 23 Mar 2026 07:08:00 +0000
Date: Mon, 23 Mar 2026 08:07:28 +0100
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Pingfan Liu <piliu@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	bpf@vger.kernel.org, systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 08/13] kexec_file: Factor out routine to find a symbol
 in ELF
Message-ID: <202603230851.qOD27RaS-lkp@intel.com>
References: <20260322014402.8815-9-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322014402.8815-9-piliu@redhat.com>

Hi Pingfan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master akpm-mm/mm-nonmm-unstable linus/master v7.0-rc5 next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/bpf-Introduce-kfuncs-to-parser-buffer-content/20260323-084500
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260322014402.8815-9-piliu%40redhat.com
patch subject: [PATCHv7 08/13] kexec_file: Factor out routine to find a symbol in ELF
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260323/202603230851.qOD27RaS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260323/202603230851.qOD27RaS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603230851.qOD27RaS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/kexec_file.c:1276:23: error: redefinition of 'kexec_purgatory_find_symbol'
    1276 | static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
         |                       ^
   kernel/kexec_file.c:958:23: note: previous definition is here
     958 | static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
         |                       ^
   1 error generated.


vim +/kexec_purgatory_find_symbol +1276 kernel/kexec_file.c

  1268	
  1269	/*
  1270	 * kexec_purgatory_find_symbol - find a symbol in the purgatory
  1271	 * @pi:		Purgatory to search in.
  1272	 * @name:	Name of the symbol.
  1273	 *
  1274	 * Return: pointer to symbol in read-only symtab on success, NULL on error.
  1275	 */
> 1276	static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
  1277							  const char *name)
  1278	{
  1279		if (!pi->ehdr)
  1280			return NULL;
  1281	
  1282		return elf_find_symbol(pi->ehdr, name);
  1283	}
  1284	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039C038B154;
	Mon, 23 Mar 2026 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261210; cv=none; b=L/deagztaqpdPMsQZ5mJeIDurtH6UX8dWGFF1KkY9/124ZAQoCVJKNcw3erZOQ1OG9J6si7Jy19tkcuocg+gDfsIsEL2ObteEZxbZ1abC7Q2tgHP7LppmL2kQv/rzbw1pKo+fKxGulo2R4kuW2m11j18f2b3UZOH6++VMfKW1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261210; c=relaxed/simple;
	bh=yXatQ4JO8B9DvDgSV+G8n5ZDZn06+ptILBIxSJt93bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7X/f7J/fLTItq0pUVxK7x3gBWRJKb6LbqySYx7nyFKUKy8zqD0Fwr294eQbrZn5QTSnzPyN4vPPdbz9kal4zPNoR9GQoEIHS1m43Ps4ld6oUIvGLcJCaFNYUQLqsAwxQ9nGQo7q4+YwbPZkMX0zFlczP2ePDndqOtLidNU6ngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SG+YvpF5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SG+YvpF5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774261208; x=1805797208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yXatQ4JO8B9DvDgSV+G8n5ZDZn06+ptILBIxSJt93bs=;
  b=SG+YvpF5S9ycHR19ld9cXh3Zk6PYlOuwW1A6Fdbj29hJxOJkbBuCu1pX
   OjstibpTnvMoZIGT4UjcsT8Ighl6POOqiceFwbzM8PCe9jBepnTyKKATR
   +CPMNvYeooROevJ7uSFHAzeRadodkRo/8IyPK1sMTSM224U+fv1Sz2MFR
   5pWMdrfZ87eed6lpmQg69fL93yMkRqrXB8GLy9ltbb5BAwiweepJeNk5R
   KAbxdOq/JW/geca6fPC6rdPXTh4TaoBeiuLIKzW6ZQEAq280QVTG7pQQT
   iy1TGXUt+jcuWt15kQBnwFX95zGpACr0NKQPRcAeBiukz6X0+6Il7dlT5
   A==;
X-CSE-ConnectionGUID: NYddu8LLSSW/GlBAYophpg==
X-CSE-MsgGUID: 2GI84B6XR+GWSsZIf+0uqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="74433430"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74433430"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:20:07 -0700
X-CSE-ConnectionGUID: sdWJRHdHQlOkec0YBpFIgQ==
X-CSE-MsgGUID: nHQx2jjIRzyJoC4IQ2Koiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228707869"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 Mar 2026 03:20:01 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4cO6-000000000LJ-0Inl;
	Mon, 23 Mar 2026 10:19:58 +0000
Date: Mon, 23 Mar 2026 18:19:04 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <202603231812.ZGRRlzPe-lkp@intel.com>
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
config: x86_64-randconfig-002-20260323 (https://download.01.org/0day-ci/archive/20260323/202603231812.ZGRRlzPe-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260323/202603231812.ZGRRlzPe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603231812.ZGRRlzPe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/kexec_file.c:1276:23: error: redefinition of 'kexec_purgatory_find_symbol'
    1276 | static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/kexec_file.c:958:23: note: previous definition of 'kexec_purgatory_find_symbol' with type 'const Elf64_Sym *(struct purgatory_info *, const char *)' {aka 'const struct elf64_sym *(struct purgatory_info *, const char *)'}
     958 | static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~


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

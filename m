Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E66383C98
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773284947; cv=none; b=sblNDJX+N1aa8846mSflSJnqmf2CEDXZAGwuwzQlFEZpjbUh3FKnVMsRo51+l0umigW4G4MJZxeOvKUWLPICpAOF0NNa9r1HsF7pzwq84Y/up1gr93k52Zr0c8wclv848X9IVI06sGF0cMXcLSumA4bbOuqRkukpVUOTl641GYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773284947; c=relaxed/simple;
	bh=MjofBuiu/1p6QwVUp6QptSjHhi/8J0onTIBIrWBJEeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PC3szco3e92Tt9GAqoPyCv/1YK3yoy5hcNjfByCF5M/D+a2GdijwByr5L7TR5gbKDBt9RJ5y65VqA3zk5Lw5C/1w/d+PBmCeEP7f6sJpFyH2dNCpFi+2Kxpx2x6ZlKhJha/DvGfw20QfJAjq5iZPGTolNgg8BthL7MwqGSW4Xls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVe6y1DZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVe6y1DZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773284946; x=1804820946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MjofBuiu/1p6QwVUp6QptSjHhi/8J0onTIBIrWBJEeE=;
  b=NVe6y1DZTJGHFfKVMcym2tdYQ3osTK8x4j6fSMC7wFRsvL/0HLp5zL91
   /UZJ/z1PYpRTJDluYuc6ESN+nmKhlpUiGj/hFx3U93bgFPl5zrte+osD1
   vPGacgVh7AA3zOzrBIbuV7ui4T5ljvi6szp/TT5UMvNVNA5lZVmh+k5Z6
   fYo7im0A89+91ZhinG2cniFgxuqSyn/oGrbta4pbQ1Fyw/bcE4uvaQS1H
   JQmCDGTIJAnDZMq49EhzlZ31oT5s7qjpga4gwbIoM+ZhhMo/CDunxLj6A
   JmHI5UGlg5sXecs2XwLOtM9APl6lbVOGRKxrYXxuFbHvLbf3s/nogfoS3
   A==;
X-CSE-ConnectionGUID: OOvj5xK6TpeRg0UjJwHqkA==
X-CSE-MsgGUID: QyPA4OHzSm+e9w8bhFHRUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="84686096"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="84686096"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 20:09:05 -0700
X-CSE-ConnectionGUID: 5TRL9SQESyiwAtOJR8nDxw==
X-CSE-MsgGUID: w9RAcCPkRiC04zYSh7poKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="219945600"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa010.jf.intel.com with ESMTP; 11 Mar 2026 20:09:01 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0WPy-000000003Rh-1meA;
	Thu, 12 Mar 2026 03:08:58 +0000
Date: Thu, 12 Mar 2026 04:08:19 +0100
From: kernel test robot <lkp@intel.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, martin.lau@linux.dev
Cc: oe-kbuild-all@lists.linux.dev, ameryhung@gmail.com, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, grbell@redhat.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	memxor@gmail.com, sdf@fomichev.me, song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH] bpf: Release module BTF IDR before module unload
Message-ID: <202603120435.9bfX2C28-lkp@intel.com>
References: <20260311130321.1055808-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311130321.1055808-1-memxor@gmail.com>

Hi Kumar,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master linus/master v6.16-rc1 next-20260311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kumar-Kartikeya-Dwivedi/bpf-Release-module-BTF-IDR-before-module-unload/20260311-211036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260311130321.1055808-1-memxor%40gmail.com
patch subject: [PATCH] bpf: Release module BTF IDR before module unload
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260312/202603120435.9bfX2C28-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260312/202603120435.9bfX2C28-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603120435.9bfX2C28-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/btf.c:1886:13: error: static declaration of 'btf_is_module' follows non-static declaration
    1886 | static bool btf_is_module(const struct btf *btf);
         |             ^~~~~~~~~~~~~
   In file included from include/linux/bpf.h:29,
                    from include/linux/bpf_verifier.h:7,
                    from kernel/bpf/btf.c:19:
   include/linux/btf.h:219:6: note: previous declaration of 'btf_is_module' with type 'bool(const struct btf *)' {aka '_Bool(const struct btf *)'}
     219 | bool btf_is_module(const struct btf *btf);
         |      ^~~~~~~~~~~~~


vim +/btf_is_module +1886 kernel/bpf/btf.c

  1885	
> 1886	static bool btf_is_module(const struct btf *btf);
  1887	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

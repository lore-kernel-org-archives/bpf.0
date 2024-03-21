Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7913A1DE
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008180; cv=none; b=VIelFvE5X7mNf78a8AVJc9894RYYaM0AeFUJCGy4bjxqIWWtdlO6iuYH09lvcY2E/xkN66RAWOoxW8CUhTp4KGxW74g0dd/ybHewIuSyIgdoxkE8OoEpGrePrfcRYbev3V947z0+zECcWiT+fWPAuApizGuovS0P09zc/8kbIZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008180; c=relaxed/simple;
	bh=brgko2LcN+fOM1PcKsGiSggIxlN7xfWMZ83ESpgT/fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0udJ0nt89s2aMzp7KlLsube97sIUw/rHMW7RhxERdlBhChteE8TioxK5eELrvkFVEufhzFHA3EHo2HP6EuyYJt/lVB2YKhSG5T1Kp5HTCgaWf7SiRl9E+OmEKCCn6dIh40Xiah7iDYgDDsAM86E/xP0rMBptfMcR04ZHD8101c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHJ8/Pvo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHJ8/Pvo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711008179; x=1742544179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=brgko2LcN+fOM1PcKsGiSggIxlN7xfWMZ83ESpgT/fA=;
  b=lHJ8/PvokWt3k69FCRHY5+AREAWDRp4mMIf0vPP6bbbUFlzL+sz76F4Y
   y4dbuilZX8FkUYof7QQFF7fuC20Oqzpv+D9+uxhSg1r8VWLY+ANZnFMIj
   6c2qgvk9eQTdfFzkaxSsgeeErjClecyNlZ7a2xAxKYsPYbpMr5Aq+swk2
   UYnhwn5gSvMeh2f5y/3XOisCUx5fEm3zuLNv7PiUxlggDj5wdJgQGmvgO
   b0KXvqtJC8Ffw3nEoEZYVEmLtpB/KKUdZIyjMGFlCB9bMTZZ86RHO2vDv
   980D0IbKj+QfFve+1XVMCjS2kzBlgBZ4s0PqCsku4zm6Y/xlgbWuZfscD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6189055"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6189055"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 01:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="19000084"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Mar 2024 01:02:38 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnDNk-000JFv-0z;
	Thu, 21 Mar 2024 08:02:36 +0000
Date: Thu, 21 Mar 2024 16:02:33 +0800
From: kernel test robot <lkp@intel.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Message-ID: <202403211543.wg8VXMiO-lkp@intel.com>
References: <20240319175406.2940628-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319175406.2940628-1-yonghong.song@linux.dev>

Hi Yonghong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/bpf-Add-bpf_link-support-for-sk_msg-and-sk_skb-progs/20240320-015917
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240319175406.2940628-1-yonghong.song%40linux.dev
patch subject: [PATCH bpf-next v2 1/6] bpf: Add bpf_link support for sk_msg and sk_skb progs
config: x86_64-randconfig-011-20240321 (https://download.01.org/0day-ci/archive/20240321/202403211543.wg8VXMiO-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240321/202403211543.wg8VXMiO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403211543.wg8VXMiO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/skmsg.c:1279:9: error: call to undeclared function 'sock_map_prog_update'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1279 |                 (void)sock_map_prog_update(sk_link->map, NULL, link->prog,
         |                       ^
   net/core/skmsg.c:1281:3: error: call to undeclared function 'bpf_map_put_with_uref'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1281 |                 bpf_map_put_with_uref(sk_link->map);
         |                 ^
   net/core/skmsg.c:1316:8: error: call to undeclared function 'sock_map_prog_update'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1316 |         ret = sock_map_prog_update(sk_link->map, new_prog, old_prog,
         |               ^
   net/core/skmsg.c:1383:8: error: call to undeclared function 'bpf_map_get_with_uref'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1383 |         map = bpf_map_get_with_uref(attr->link_create.target_fd);
         |               ^
   net/core/skmsg.c:1383:6: error: incompatible integer to pointer conversion assigning to 'struct bpf_map *' from 'int' [-Wint-conversion]
    1383 |         map = bpf_map_get_with_uref(attr->link_create.target_fd);
         |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/skmsg.c:1409:8: error: call to undeclared function 'sock_map_prog_update'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1409 |         ret = sock_map_prog_update(map, prog, NULL, attach_type);
         |               ^
   net/core/skmsg.c:1420:2: error: call to undeclared function 'bpf_map_put_with_uref'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1420 |         bpf_map_put_with_uref(map);
         |         ^
>> net/core/skmsg.c:1371:5: warning: no previous prototype for function 'bpf_sk_msg_skb_link_create' [-Wmissing-prototypes]
    1371 | int bpf_sk_msg_skb_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
         |     ^
   net/core/skmsg.c:1371:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1371 | int bpf_sk_msg_skb_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
         | ^
         | static 
   1 warning and 7 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_I915_DEBUG_GEM
   Depends on [n]: HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && DRM_I915_WERROR [=n]
   Selected by [y]:
   - DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && !COMPILE_TEST [=n]


vim +/bpf_sk_msg_skb_link_create +1371 net/core/skmsg.c

  1370	
> 1371	int bpf_sk_msg_skb_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
  1372	{
  1373		struct bpf_link_primer link_primer;
  1374		struct bpf_sk_msg_skb_link *sk_link;
  1375		enum bpf_attach_type attach_type;
  1376		enum bpf_link_type link_type;
  1377		struct bpf_map *map;
  1378		int ret;
  1379	
  1380		if (attr->link_create.flags)
  1381			return -EINVAL;
  1382	
> 1383		map = bpf_map_get_with_uref(attr->link_create.target_fd);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

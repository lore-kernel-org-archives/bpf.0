Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F93812F0;
	Fri,  7 Aug 2026 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139949; cv=none; b=foBAS3jj7L38HmMBNpj28DE9i0Xy2UY55Mddtoq7tKs6kiJtwwzr+F9ztNzrwS8uv/bRIBn1NVd5PX15NsZgM+EyHo4jLSKPYTLhvwRnHkGdvUWK0Xgw2IlP60vmmu1QxoTZXGXvXk3xVWftMgKWtVhZ72/QB7uOvK2/lvP7Xic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139949; c=relaxed/simple;
	bh=OMPA9zXQ5zDnWya5oPn/91CDMMEk4mnMb/BLCxXR530=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5obDny8E550ti7+XtxE19+xnULrYct95JE0IhDReFgBnGoxGsffcaPHyFSB9+olMDwaPedFNfGRZEd0pt3S80waFZo1c9M2P60vAu0tvOXvVwjxQn5Jn7WWHUjTt5rtCXyoal9q9qd3C/FiDlRkWr58QOnk6fOGD+lZ4d0p8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+uWovCZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+uWovCZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786139948; x=1817675948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OMPA9zXQ5zDnWya5oPn/91CDMMEk4mnMb/BLCxXR530=;
  b=C+uWovCZMuzV8TSqCqBH9NfN4V4hR095+j4+xoFPicAfzVRilYuJJWR5
   6IeP1d8VKhwGSlpJ8gCF/0btASaMyZT5VmFlMiDDMoaxSA3W9+MYl50Xi
   CjOqqvox/aQJlKJ/gggEAoVEQruv2emnk3WKMQb74i95RofocITQgYKKQ
   DDj/QPaVZu+KcmY54SVNB4bcM3Ez8Qsdst4lkklp3u8yID1zGxUtl8of0
   ssLzhIq1tjv72frds4ohlOk9Dm0gdWwi/vwjX/PUSEWgwkkWk9XcYTkre
   nPyxDqas+INKJwb8dLGBDk+qA34t7b2V6fKkhpXGjJiOEbfbaTtLbeJhP
   A==;
X-CSE-ConnectionGUID: ckEJIw4xTTOpmSiuSITDug==
X-CSE-MsgGUID: h2ez+Jz8SCi1wGG3ujGx+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="112302732"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="112302732"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 14:59:07 -0700
X-CSE-ConnectionGUID: dnAzD3ZaTrmIUwx9c7YBcQ==
X-CSE-MsgGUID: +dRjWKiRRi2D2SXSdRA0vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="287198450"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2026 14:59:03 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wsSah-00000000JLw-3pMV;
	Fri, 07 Aug 2026 21:58:59 +0000
Date: Sat, 8 Aug 2026 05:58:31 +0800
From: kernel test robot <lkp@intel.com>
To: Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, vmalik@redhat.com,
	ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	"(open list:BPF \\(Safe Dynamic Programs and Tools\\))" <bpf@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test
 bpf_strcat,bpf_strncat kfuncs
Message-ID: <202608080502.lI7AVjty-lkp@intel.com>
References: <tencent_DB0510330C3A8574B3C62E6154165FCB4709@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_DB0510330C3A8574B3C62E6154165FCB4709@qq.com>

Hi Rong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Rong-Tao/selftests-bpf-Test-bpf_strcat-bpf_strncat-kfuncs/20260807-065842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/tencent_DB0510330C3A8574B3C62E6154165FCB4709%40qq.com
patch subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs
config: s390-randconfig-r052-20260807 (https://download.01.org/0day-ci/archive/20260808/202608080502.lI7AVjty-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 12df34b8469b8095359de8c249cb1b2753fadeea)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260808/202608080502.lI7AVjty-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608080502.lI7AVjty-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/helpers.c:4228:3: error: invalid lvalue in asm output
    4228 |                 __put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:612:2: note: expanded from macro '__put_kernel_nofault'
     612 |         arch_put_kernel_nofault(dst, src, type, local_label);   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/include/asm/uaccess.h:471:33: note: expanded from macro 'arch_put_kernel_nofault'
     471 | #define arch_put_kernel_nofault __mvc_kernel_nofault
         |                                 ^
   arch/s390/include/asm/uaccess.h:424:19: note: expanded from macro '__mvc_kernel_nofault'
     424 |                         : [_dst] "=Q" (*(type *)dst)                    \
         |                                        ^~~~~~~~~~~~
   kernel/bpf/helpers.c:4233:2: error: invalid lvalue in asm output
    4233 |         __put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:612:2: note: expanded from macro '__put_kernel_nofault'
     612 |         arch_put_kernel_nofault(dst, src, type, local_label);   \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/include/asm/uaccess.h:471:33: note: expanded from macro 'arch_put_kernel_nofault'
     471 | #define arch_put_kernel_nofault __mvc_kernel_nofault
         |                                 ^
   arch/s390/include/asm/uaccess.h:424:19: note: expanded from macro '__mvc_kernel_nofault'
     424 |                         : [_dst] "=Q" (*(type *)dst)                    \
         |                                        ^~~~~~~~~~~~
   2 errors generated.


vim +4228 kernel/bpf/helpers.c

  4197	
  4198	static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
  4199	{
  4200		int dlen, slen, space, copied;
  4201		char cs = '?';
  4202	
  4203		if (!copy_from_kernel_nofault_allowed(dst, 1) ||
  4204		    !copy_from_kernel_nofault_allowed(src, 1)) {
  4205			return -ERANGE;
  4206		}
  4207	
  4208		dlen = bpf_strnlen(dst, dsz);
  4209		if (dlen < 0)
  4210			return dlen;
  4211		slen = bpf_strnlen(src, sz);
  4212		if (slen < 0)
  4213			return slen;
  4214	
  4215		if (dlen >= dsz || sz == 0 || dsz == 0)
  4216			return -EINVAL;
  4217	
  4218		space = dsz - dlen;
  4219		if (space <= 1 || space < min(slen, sz) + 1)
  4220			return -E2BIG;
  4221	
  4222		guard(pagefault)();
  4223		for (copied = 0; copied < space - 1 && copied < slen; copied++) {
  4224			__get_kernel_nofault(&cs, src, char, err_out);
  4225			if (cs == '\0')
  4226				break;
  4227	
> 4228			__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
  4229	
  4230			src++;
  4231		}
  4232		cs = '\0';
  4233		__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
  4234	
  4235		__get_kernel_nofault(&cs, src, char, err_out);
  4236		if (cs != '\0' && sz > copied)
  4237			return -E2BIG;
  4238	
  4239		return dlen + copied;
  4240	err_out:
  4241		return -EFAULT;
  4242	}
  4243	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

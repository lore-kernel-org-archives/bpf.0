Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4E334C9AD;
	Tue, 23 Jun 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218292; cv=none; b=mg+YXeosk32A/htzBLbLpapPsigNiqiQ2k79sMwnT2Cy+mq4RMHVL6f+qAR36QPReUnjx4F89F1Hts+nHJsdoIXdWkMJjTTzvoKXfzI5mZh4zXbGlY3KzQUjh57G4EeEf4CcI8mrt4TR9EnBg9BWaElc46PwdRdyQXjXrni1FKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218292; c=relaxed/simple;
	bh=h653bIgjXltHaURrSBDDbFgYViiGWwyVeGsxyv3j5wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3CVALiRBjJ7Rr2t2pDCIr4s1UvUacbN1fq9DzySDU55OZ5/Ik8uSZkACpG/rcx6vNRbewAhVf2XoWHkl5XdmOWZMV2AJ21HN5Jx0Hbq/EGh8c3yfyGGK+H+nEMsY9XIX64QBHzIuwffs5/o50oXRFY6dv3GFKJmUn5eSx9Okg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYeBQom5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYeBQom5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782218289; x=1813754289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h653bIgjXltHaURrSBDDbFgYViiGWwyVeGsxyv3j5wA=;
  b=VYeBQom5U5fJAUb8m9SNxVqHpIRWWcr5ghXVLCBABnACcdQxkpfbHcKf
   vivmcqzXVfEJs3MlGj4XDAX456JAnmPk0L3YwvK/HtJCktxvbr/R9Nm+S
   D1UOWC/ZoAr5/YvDsP+JYslz5Z4Ca8jni7DO1iy6OOSgQvIiQiJ+7vX1h
   WMpsO46HS3b2X0zr5BxGc4CUour7lNuuRbiX1VrDK2xdnWO0ycc8QpRNP
   tHO2DRYulWlHxD6uMEkEmlw11FuvdeohqzqvKW3PxQSfU+iB/v2WphELX
   fhJ1m6gdZg7XaTe4cI121z2b1uKnW9Z/BF+qMXUe8cPT5AZucAfTcMhVa
   A==;
X-CSE-ConnectionGUID: UX8cjhFyTjiD+ysWzdSUWg==
X-CSE-MsgGUID: kCU2VGpwQ2WL6ibaMIQbmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82063875"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82063875"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 05:38:08 -0700
X-CSE-ConnectionGUID: R5zIMnSvTw2+gUuXk1c4CA==
X-CSE-MsgGUID: DlZxwkCaTxWl1+N3yuucbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="249366207"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 23 Jun 2026 05:38:01 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wc0O2-000000002WH-1rQC;
	Tue, 23 Jun 2026 12:37:54 +0000
Date: Tue, 23 Jun 2026 20:36:49 +0800
From: kernel test robot <lkp@intel.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, eddyz87@gmail.com,
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
	john.fastabend@gmail.com, sdf@fomichev.me, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
	yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
	a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
	eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add bpf_fib_lookup() VLAN
 flag tests
Message-ID: <202606232057.G1fSw98N-lkp@intel.com>
References: <20260623025147.1001664-4-avinash.duduskar@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623025147.1001664-4-avinash.duduskar@gmail.com>

Hi Avinash,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a975094bf98ca97be9146f9d3b5681a6f9cf5ce3]

url:    https://github.com/intel-lab-lkp/linux/commits/Avinash-Duduskar/bpf-Add-BPF_FIB_LOOKUP_VLAN-flag-to-bpf_fib_lookup-helper/20260623-105336
base:   a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
patch link:    https://lore.kernel.org/r/20260623025147.1001664-4-avinash.duduskar%40gmail.com
patch subject: [PATCH bpf-next v4 3/3] selftests/bpf: Add bpf_fib_lookup() VLAN flag tests
config: i386-buildonly-randconfig-006-20260623 (https://download.01.org/0day-ci/archive/20260623/202606232057.G1fSw98N-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260623/202606232057.G1fSw98N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606232057.G1fSw98N-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/filter.c:6567:14: warning: unused variable 'net' [-Wunused-variable]
    6567 |         struct net *net = dev_net(skb->dev);
         |                     ^~~
   1 warning generated.


vim +/net +6567 net/core/filter.c

87f5fc7e48dd31 David Ahern            2018-05-09  6563  
87f5fc7e48dd31 David Ahern            2018-05-09  6564  BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
87f5fc7e48dd31 David Ahern            2018-05-09  6565  	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
87f5fc7e48dd31 David Ahern            2018-05-09  6566  {
4f74fede40df8d David Ahern            2018-05-21 @6567  	struct net *net = dev_net(skb->dev);
f392520e15094e Avinash Duduskar       2026-06-23  6568  	struct net_device *fwd_dev = NULL;
4c79579b44b187 David Ahern            2018-06-26  6569  	int rc = -EAFNOSUPPORT;
2c0a10af688c02 Jesper Dangaard Brouer 2021-02-09  6570  	bool check_mtu = false;
4f74fede40df8d David Ahern            2018-05-21  6571  
87f5fc7e48dd31 David Ahern            2018-05-09  6572  	if (plen < sizeof(*params))
87f5fc7e48dd31 David Ahern            2018-05-09  6573  		return -EINVAL;
87f5fc7e48dd31 David Ahern            2018-05-09  6574  
31de4105f00d64 Martin KaFai Lau       2023-02-17  6575  	if (flags & ~BPF_FIB_LOOKUP_MASK)
9ce64f192d161a David Ahern            2018-05-29  6576  		return -EINVAL;
9ce64f192d161a David Ahern            2018-05-29  6577  
2c0a10af688c02 Jesper Dangaard Brouer 2021-02-09  6578  	if (params->tot_len)
2c0a10af688c02 Jesper Dangaard Brouer 2021-02-09  6579  		check_mtu = true;
2c0a10af688c02 Jesper Dangaard Brouer 2021-02-09  6580  
87f5fc7e48dd31 David Ahern            2018-05-09  6581  	switch (params->family) {
87f5fc7e48dd31 David Ahern            2018-05-09  6582  #if IS_ENABLED(CONFIG_INET)
87f5fc7e48dd31 David Ahern            2018-05-09  6583  	case AF_INET:
f392520e15094e Avinash Duduskar       2026-06-23  6584  		rc = bpf_ipv4_fib_lookup(net, params, flags, check_mtu,
f392520e15094e Avinash Duduskar       2026-06-23  6585  					 &fwd_dev);
4f74fede40df8d David Ahern            2018-05-21  6586  		break;
87f5fc7e48dd31 David Ahern            2018-05-09  6587  #endif
87f5fc7e48dd31 David Ahern            2018-05-09  6588  #if IS_ENABLED(CONFIG_IPV6)
87f5fc7e48dd31 David Ahern            2018-05-09  6589  	case AF_INET6:
f392520e15094e Avinash Duduskar       2026-06-23  6590  		rc = bpf_ipv6_fib_lookup(net, params, flags, check_mtu,
f392520e15094e Avinash Duduskar       2026-06-23  6591  					 &fwd_dev);
4f74fede40df8d David Ahern            2018-05-21  6592  		break;
87f5fc7e48dd31 David Ahern            2018-05-09  6593  #endif
87f5fc7e48dd31 David Ahern            2018-05-09  6594  	}
4f74fede40df8d David Ahern            2018-05-21  6595  
2c0a10af688c02 Jesper Dangaard Brouer 2021-02-09  6596  	if (rc == BPF_FIB_LKUP_RET_SUCCESS && !check_mtu) {
f392520e15094e Avinash Duduskar       2026-06-23  6597  		/* without tot_len, check the skb against the FIB-result
f392520e15094e Avinash Duduskar       2026-06-23  6598  		 * device's MTU
2c0a10af688c02 Jesper Dangaard Brouer 2021-02-09  6599  		 */
f392520e15094e Avinash Duduskar       2026-06-23  6600  		if (!is_skb_forwardable(fwd_dev, skb))
4c79579b44b187 David Ahern            2018-06-26  6601  			rc = BPF_FIB_LKUP_RET_FRAG_NEEDED;
e1850ea9bd9eca Jesper Dangaard Brouer 2021-02-09  6602  
f392520e15094e Avinash Duduskar       2026-06-23  6603  		params->mtu_result = fwd_dev->mtu; /* union with tot_len */
4f74fede40df8d David Ahern            2018-05-21  6604  	}
4f74fede40df8d David Ahern            2018-05-21  6605  
4c79579b44b187 David Ahern            2018-06-26  6606  	return rc;
87f5fc7e48dd31 David Ahern            2018-05-09  6607  }
87f5fc7e48dd31 David Ahern            2018-05-09  6608  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

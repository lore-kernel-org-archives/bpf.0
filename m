Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1189D425CC4;
	Tue, 31 Mar 2026 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979801; cv=none; b=cajhfywXGuZWRnZYzNsf+mfumiT3xBQK9wGCsA18+C3rC5aMpriuiEsu5QUNu6lFCLG8w6tC1PLD/Y2NZVB90HwfkD4XbqKk/qTeYXT3ketJytw711cMCNk5nVq1g09f04atbJUwyd+y88dyqN5e9o1yxX8wv/8FYIcXbRZpTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979801; c=relaxed/simple;
	bh=DwkTCA5YmgJHm81msbMX/aBjsel/Wf5D82F5TzSEOqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdxqIfn/5yJgvsuwls64PiQnWGq/M6rsrNAlnQZHjewz86CYm40fsQnj+hLkPO//Qm3B/DIoSiNHaDUo7Tap1mL/AdwM50qdQUE/jjACtSwGFNncUkPyf/KZEKcICq9U8GbNkRp7cn3rt8VSG2XM75TBPqlywuQ6xyXrvvCAzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sp8yYlAU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sp8yYlAU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774979799; x=1806515799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DwkTCA5YmgJHm81msbMX/aBjsel/Wf5D82F5TzSEOqY=;
  b=Sp8yYlAUZ+FWSJm2EhytySrNyJIq2XxSyspqU8JZ7erRj+CJR9PaMZu5
   gtw4RUKdFWL9wwgLSN/7cO/UzWZDrrFtSBJ9aTgG62haXoVNvxfpdTH0+
   Ai6GfBjg5QpD4IKCXEETuc9WhuSF8vNan/+axtycsguyBBE0uTdaA98KR
   R3tBCT/QP34JsdMOe0cZbUSBzkdyV0jdt4eS9cB8jCvAkjZ4u8Rpb2dSU
   jGNhJKDkCo9onvvOeY9z30Yv89rBGUQNISgebEv+5DQci6iy5Xr6Pcpzr
   kBbPDtwG/Yzn4vmPJnFUMO7ak2OIBA5elcz2O69yebEt2h63kh+ia9n6C
   g==;
X-CSE-ConnectionGUID: dFQJIvm8Twqvzdz2KzLzvQ==
X-CSE-MsgGUID: lIasQNU+TmyNd3/oKWIjEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87078481"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="87078481"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 10:56:38 -0700
X-CSE-ConnectionGUID: TKI0kEJZTii6/2w99M5+yg==
X-CSE-MsgGUID: 7PbP8QNgS1SXzDQYsDBchw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="230501582"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 31 Mar 2026 10:56:33 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7dKI-00000000461-3IPB;
	Tue, 31 Mar 2026 17:56:30 +0000
Date: Wed, 1 Apr 2026 01:55:44 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Rife <jrife@google.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jordan Rife <jrife@google.com>,
	bpf@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net-next v3 2/4] udp: Remove disconnected sockets from
 the 4-tuple hash
Message-ID: <202604010154.iewJbUya-lkp@intel.com>
References: <20260330215707.2374657-3-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330215707.2374657-3-jrife@google.com>

Hi Jordan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jordan-Rife/udp-Only-compare-daddr-dport-when-sk_state-TCP_ESTABLISHED/20260331-082300
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260330215707.2374657-3-jrife%40google.com
patch subject: [PATCH net-next v3 2/4] udp: Remove disconnected sockets from the 4-tuple hash
config: sparc64-randconfig-r071-20260331 (https://download.01.org/0day-ci/archive/20260401/202604010154.iewJbUya-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604010154.iewJbUya-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604010154.iewJbUya-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/udp.c: In function 'udp_disconnect_unhash4':
   net/ipv4/udp.c:2182:31: error: implicit declaration of function 'udp_get_table_prot'; did you mean 'vm_get_page_prot'? [-Werror=implicit-function-declaration]
     struct udp_table *udptable = udp_get_table_prot(sk);
                                  ^~~~~~~~~~~~~~~~~~
                                  vm_get_page_prot
>> net/ipv4/udp.c:2182:31: warning: initialization of 'struct udp_table *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   cc1: some warnings being treated as errors


vim +2182 net/ipv4/udp.c

  2179	
  2180	static int udp_disconnect_unhash4(struct sock *sk, int flags)
  2181	{
> 2182		struct udp_table *udptable = udp_get_table_prot(sk);
  2183	
  2184		udp_unhash4(udptable, sk);
  2185		__udp_disconnect(sk, flags);
  2186	
  2187		return 0;
  2188	}
  2189	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE1364E89;
	Thu, 10 Sep 2026 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789004403; cv=none; b=ic4jfSKfZX1TeEG4I5jX/ufAVNGX8+85D6bDizXA4g+T7Jfqd75w5RJ1TYKsxScx3SdnfPXTVuauNGUZ4bFXCfpj2b6JMtY0cTSlcfpTRIgDev8P0ugIakYI6635DhkWodKbHI546ZAd2vHEOy+ZOOR/p/4jBQl9IS3MiT6gNAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789004403; c=relaxed/simple;
	bh=7eJlRhYUSCRjBQJUVrGhLJFMHDY2ri2GxDXNKikWGFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiwdKWyUiFd7VSVXWs3n+fjAyEIDlXbRTfpk80RjiqjT3i41Q71398MwH9rPD7MEpe+8WYegdd4zFSPf5SwSsuo07a+jZ01jSXUKXKge2PMtqTXHdwGWzO1SFG3H4CKnO5OH6vP8DpZwP7orB8B1OffHuXuxMewANaBv+Fjn2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tkz72tDj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tkz72tDj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789004400; x=1820540400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7eJlRhYUSCRjBQJUVrGhLJFMHDY2ri2GxDXNKikWGFQ=;
  b=Tkz72tDjtyBNxArgDXe7CE0eMJkbtkumosGoEbsHMVXzVbLeTmf4CSbV
   qlmMcHR8SAwY7aUIQAEhDk5t+4w7WqXu3QxOotMnJPPbZej2DCxKI7LcT
   CUPcZL8ZDuwfSQHv4tPcndRutCGgqV7sZR0m9PE81pppmd8ZqOZJUWSQi
   drLAYZFquITwac+BhXRqJh8rXrQCDRmFlmH9/+EpGWTZSJGrSP/O4FX7E
   VeqvCs9SqZbQ3i78X1W+IOjg5I6jyXb8DDSp3IxwDXFL6LKAdTMjPHsKP
   wp3P9AEpKIIPnJKiVcKdoIoXSgrzrSP3zNvjoQmqj2pfq4u3EuHcXNJjt
   g==;
X-CSE-ConnectionGUID: Ep4aKt7yS8aDxcmm9XzVfw==
X-CSE-MsgGUID: aocPNhtFRQGu8/nwVJ0PhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93269745"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="93269745"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 18:39:59 -0700
X-CSE-ConnectionGUID: EYP87P8xRN6nqNsrDMlwtw==
X-CSE-MsgGUID: /Rm+jYFORf29YO6rb2bdrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="269720277"
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Sep 2026 18:39:52 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4TlU-000000001EK-25yq;
	Thu, 10 Sep 2026 01:39:48 +0000
Date: Thu, 10 Sep 2026 09:38:48 +0800
From: kernel test robot <lkp@intel.com>
To: Irlanki Sandeep <irlanki.s@samsung.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	corbet@lwn.net, linux-kernel@vger.kernel.org, lorenzo@google.com,
	maze@google.com, sporeba@google.com, motomuman@google.com,
	srihari.k@samsung.com, g.pokhra@samsung.com, r.kumawat@samsung.com,
	raj.kumars@samsung.com, ts413.lee@samsung.com,
	Irlanki Sandeep <irlanki.s@samsung.com>
Subject: Re: [PATCH net-next] tcp: add TCP_ECN and TCP_ECN_OPTION socket
 options
Message-ID: <202609100957.cYRwpjGl-lkp@intel.com>
References: <20260909144557.800676-1-irlanki.s@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909144557.800676-1-irlanki.s@samsung.com>

Hi Irlanki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 548b86839f7fb819a4d6c83b71c73ec378d24275]

url:    https://github.com/intel-lab-lkp/linux/commits/Irlanki-Sandeep/tcp-add-TCP_ECN-and-TCP_ECN_OPTION-socket-options/20260909-201557
base:   548b86839f7fb819a4d6c83b71c73ec378d24275
patch link:    https://lore.kernel.org/r/20260909144557.800676-1-irlanki.s%40samsung.com
patch subject: [PATCH net-next] tcp: add TCP_ECN and TCP_ECN_OPTION socket options
config: i386-randconfig-141-20260910 (https://download.01.org/0day-ci/archive/20260910/202609100957.cYRwpjGl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260910/202609100957.cYRwpjGl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609100957.cYRwpjGl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/tcp_input.c: In function 'tcp_ecn_create_request':
>> net/ipv4/tcp_input.c:7460:27: warning: unused variable 'net' [-Wunused-variable]
    7460 |         const struct net *net = sock_net(listen_sk);
         |                           ^~~


vim +/net +7460 net/ipv4/tcp_input.c

1fb6f159fd21c64 Octavian Purdila                      2014-06-25  7436  
d82bd1229885d55 Florian Westphal                      2014-09-29  7437  /* RFC3168 : 6.1.1 SYN packets must not have ECT/ECN bits set
d82bd1229885d55 Florian Westphal                      2014-09-29  7438   *
d82bd1229885d55 Florian Westphal                      2014-09-29  7439   * If we receive a SYN packet with these bits set, it means a
d82bd1229885d55 Florian Westphal                      2014-09-29  7440   * network is playing bad games with TOS bits. In order to
d82bd1229885d55 Florian Westphal                      2014-09-29  7441   * avoid possible false congestion notifications, we disable
f4e715c3254e3c0 stephen hemminger                     2014-10-29  7442   * TCP ECN negotiation.
d82bd1229885d55 Florian Westphal                      2014-09-29  7443   *
d82bd1229885d55 Florian Westphal                      2014-09-29  7444   * Exception: tcp_ca wants ECN. This is required for DCTCP
843c2fdf7a12951 Florian Westphal                      2015-01-30  7445   * congestion control: Linux DCTCP asserts ECT on all packets,
843c2fdf7a12951 Florian Westphal                      2015-01-30  7446   * including SYN, which is most optimal solution; however,
843c2fdf7a12951 Florian Westphal                      2015-01-30  7447   * others, such as FreeBSD do not.
f6fee16dbbe3fe4 Tilmans, Olivier (Nokia - BE/Antwerp  2019-04-03  7448)  *
f6fee16dbbe3fe4 Tilmans, Olivier (Nokia - BE/Antwerp  2019-04-03  7449)  * Exception: At least one of the reserved bits of the TCP header (th->res1) is
f6fee16dbbe3fe4 Tilmans, Olivier (Nokia - BE/Antwerp  2019-04-03  7450)  * set, indicating the use of a future TCP extension (such as AccECN). See
f6fee16dbbe3fe4 Tilmans, Olivier (Nokia - BE/Antwerp  2019-04-03  7451)  * RFC8311 §4.3 which updates RFC3168 to allow the development of such
f6fee16dbbe3fe4 Tilmans, Olivier (Nokia - BE/Antwerp  2019-04-03  7452)  * extensions.
d82bd1229885d55 Florian Westphal                      2014-09-29  7453   */
d82bd1229885d55 Florian Westphal                      2014-09-29  7454  static void tcp_ecn_create_request(struct request_sock *req,
d82bd1229885d55 Florian Westphal                      2014-09-29  7455  				   const struct sk_buff *skb,
f7b3bec6f5167ef Florian Westphal                      2014-11-03  7456  				   const struct sock *listen_sk,
f7b3bec6f5167ef Florian Westphal                      2014-11-03  7457  				   const struct dst_entry *dst)
d82bd1229885d55 Florian Westphal                      2014-09-29  7458  {
d82bd1229885d55 Florian Westphal                      2014-09-29  7459  	const struct tcphdr *th = tcp_hdr(skb);
d82bd1229885d55 Florian Westphal                      2014-09-29 @7460  	const struct net *net = sock_net(listen_sk);
d82bd1229885d55 Florian Westphal                      2014-09-29  7461  	bool th_ecn = th->ece && th->cwr;
843c2fdf7a12951 Florian Westphal                      2015-01-30  7462  	bool ect, ecn_ok;
c3a8d9474684d39 Daniel Borkmann                       2015-08-31  7463  	u32 ecn_ok_dst;
d82bd1229885d55 Florian Westphal                      2014-09-29  7464  
3cae34274c79e0c Ilpo Järvinen                         2025-09-16  7465  	if (tcp_accecn_syn_requested(th) &&
4ea2ce8e35e36ab Irlanki Sandeep                       2026-09-09  7466  	    (tcp_ecn_mode_eff(listen_sk) >= 3 ||
100f946b8d44b64 Chia-Yu Chang                         2026-01-31  7467  	     tcp_ca_needs_accecn(listen_sk))) {
3cae34274c79e0c Ilpo Järvinen                         2025-09-16  7468  		inet_rsk(req)->ecn_ok = 1;
3cae34274c79e0c Ilpo Järvinen                         2025-09-16  7469  		tcp_rsk(req)->accecn_ok = 1;
3cae34274c79e0c Ilpo Järvinen                         2025-09-16  7470  		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
3cae34274c79e0c Ilpo Järvinen                         2025-09-16  7471  					    INET_ECN_MASK;
3cae34274c79e0c Ilpo Järvinen                         2025-09-16  7472  		return;
3cae34274c79e0c Ilpo Järvinen                         2025-09-16  7473  	}
3cae34274c79e0c Ilpo Järvinen                         2025-09-16  7474  
d82bd1229885d55 Florian Westphal                      2014-09-29  7475  	if (!th_ecn)
d82bd1229885d55 Florian Westphal                      2014-09-29  7476  		return;
d82bd1229885d55 Florian Westphal                      2014-09-29  7477  
d82bd1229885d55 Florian Westphal                      2014-09-29  7478  	ect = !INET_ECN_is_not_ect(TCP_SKB_CB(skb)->ip_dsfield);
c3a8d9474684d39 Daniel Borkmann                       2015-08-31  7479  	ecn_ok_dst = dst_feature(dst, DST_FEATURE_ECN_MASK);
4ea2ce8e35e36ab Irlanki Sandeep                       2026-09-09  7480  	ecn_ok = tcp_ecn_mode_eff(listen_sk) || ecn_ok_dst;
d82bd1229885d55 Florian Westphal                      2014-09-29  7481  
3cae34274c79e0c Ilpo Järvinen                         2025-09-16  7482  	if (((!ect || th->res1 || th->ae) && ecn_ok) ||
3cae34274c79e0c Ilpo Järvinen                         2025-09-16  7483  	    tcp_ca_needs_ecn(listen_sk) ||
91b5b21c7c16899 Lawrence Brakmo                       2017-06-30  7484  	    (ecn_ok_dst & DST_FEATURE_ECN_CA) ||
91b5b21c7c16899 Lawrence Brakmo                       2017-06-30  7485  	    tcp_bpf_ca_needs_ecn((struct sock *)req))
d82bd1229885d55 Florian Westphal                      2014-09-29  7486  		inet_rsk(req)->ecn_ok = 1;
d82bd1229885d55 Florian Westphal                      2014-09-29  7487  }
d82bd1229885d55 Florian Westphal                      2014-09-29  7488  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

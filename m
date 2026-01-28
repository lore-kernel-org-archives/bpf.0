Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A4B28C5B1;
	Wed, 28 Jan 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611550; cv=none; b=F5bxNH799D4ZMPZ1lKtjQnDKexKJZpkqMN98RM5V4uwuN0kPLHJmKfNbb8qxohlkQtWqqzqarOuvRr5uhj9JIRCxUiGrArL745JePzsAKYs9/j9PVI1dgiK8nQVP3pMKUZx1nSCB+r06ZfpUev2BL9jrE8amOuJKZAsoc+QRnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611550; c=relaxed/simple;
	bh=+eH8C9zSuGZKQtATqOlIcM1L0qnOfOH4Q1w1uWBpTVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga1avgodkjHkoGszx3bGt1hv/viV2BAJbrK//J46iwLVlpPFPjtdRLheu7nySmaXXCrxvfcc5BH0xNIOyCN7F4yc64v05tbEIyIHl1+zb4wZhLaH4nT1uHQdSRxqVAIc7iySUyFlmzsKcbDv5kmfAK5ZOtWv6jBpElJYMuuhHNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0LgYgLo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0LgYgLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769611549; x=1801147549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+eH8C9zSuGZKQtATqOlIcM1L0qnOfOH4Q1w1uWBpTVk=;
  b=J0LgYgLoZsESAVpH7N/1UktQ1yMWVeCwqxmL8VKYsPLoHr85ESO9F6sm
   S6t6GKyzcVyD7/+NB8rYSEIypvo0G6CNUMn1W8X+GRSoUDW2GW2cApWoH
   N84Gsva3aHd/4vtn3eA5t93rJbosMxirNtnN9/Zce+G24QiAZaXV8yUvK
   dAPq98rrGwWZQapzBZlLZddk3jQDD1wgLrH5Ek0gBfckPNcdEeUcqfh9Z
   +Iidb9GN5kPUd6fI7gnOJ+DNcpHvsmHkmfzKJd+XwOUnI8elEPkUZoz95
   /G0HY2vguNd0kBVPWb/Tq6YnifsYhVc+fzOjntQgxULn4Vh13iz9DFqUL
   w==;
X-CSE-ConnectionGUID: mIe9u2OkTQ+y0gq09Vy34g==
X-CSE-MsgGUID: V1FUQxIIShefEicAYs6dUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="58405199"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="58405199"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 06:45:48 -0800
X-CSE-ConnectionGUID: eeaYUYVPTS+pfSiR37CUhQ==
X-CSE-MsgGUID: H+qkhrBkRd2KCqtMMuhg2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208348253"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 28 Jan 2026 06:45:43 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vl6nd-00000000Zm4-1T9i;
	Wed, 28 Jan 2026 14:45:41 +0000
Date: Wed, 28 Jan 2026 22:45:27 +0800
From: kernel test robot <lkp@intel.com>
To: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Add the missing types in the logs
Message-ID: <202601282215.BONmLaMY-lkp@intel.com>
References: <20260128085842.145057-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128085842.145057-1-yangfeng59949@163.com>

Hi Feng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Feng-Yang/bpf-Add-the-missing-types-in-the-logs/20260128-170535
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260128085842.145057-1-yangfeng59949%40163.com
patch subject: [PATCH bpf-next] bpf: Add the missing types in the logs
config: x86_64-buildonly-randconfig-003-20260128 (https://download.01.org/0day-ci/archive/20260128/202601282215.BONmLaMY-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260128/202601282215.BONmLaMY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601282215.BONmLaMY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/log.c: In function 'reg_type_str':
>> kernel/bpf/log.c:476:59: warning: '%s' directive output may be truncated writing up to 13 bytes into a region of size between 8 and 64 [-Wformat-truncation=]
     476 |         snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
         |                                                           ^~
   kernel/bpf/log.c:476:9: note: 'snprintf' output between 1 and 178 bytes into a destination of size 64
     476 |         snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     477 |                  type & MEM_RDONLY ? "rdonly_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     478 |                  type & MEM_RINGBUF ? "ringbuf_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     479 |                  type & MEM_USER ? "user_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     480 |                  type & MEM_PERCPU ? "percpu_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     481 |                  type & MEM_RCU ? "rcu_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     482 |                  type & PTR_UNTRUSTED ? "untrusted_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     483 |                  type & PTR_TRUSTED ? "trusted_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     484 |                  type & MEM_UNINIT ? "uninit_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     485 |                  type & DYNPTR_TYPE_LOCAL ? "dynptr_local_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     486 |                  type & DYNPTR_TYPE_RINGBUF ? "dynptr_ringbuf_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     487 |                  type & MEM_FIXED_SIZE ? "fixed_size_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     488 |                  type & MEM_ALLOC ? "alloc_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     489 |                  type & NON_OWN_REF ? "non_own_ref_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     490 |                  type & DYNPTR_TYPE_SKB ? "dynptr_skb_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     491 |                  type & DYNPTR_TYPE_XDP ? "dynptr_xdp_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     492 |                  type & MEM_ALIGNED ? "aligned_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     493 |                  type & MEM_WRITE ? "write_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     494 |                  type & DYNPTR_TYPE_SKB_META ? "dynptr_skb_meta_" : "",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     495 |                  type & DYNPTR_TYPE_FILE ? "dynptr_file_" : ""
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     496 |         );
         |         ~


vim +476 kernel/bpf/log.c

   434	
   435	/* string representation of 'enum bpf_reg_type'
   436	 *
   437	 * Note that reg_type_str() can not appear more than once in a single verbose()
   438	 * statement.
   439	 */
   440	const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
   441	{
   442		char postfix[16] = {0}, prefix[64] = {0};
   443		static const char * const str[] = {
   444			[NOT_INIT]		= "?",
   445			[SCALAR_VALUE]		= "scalar",
   446			[PTR_TO_CTX]		= "ctx",
   447			[CONST_PTR_TO_MAP]	= "map_ptr",
   448			[PTR_TO_MAP_VALUE]	= "map_value",
   449			[PTR_TO_STACK]		= "fp",
   450			[PTR_TO_PACKET]		= "pkt",
   451			[PTR_TO_PACKET_META]	= "pkt_meta",
   452			[PTR_TO_PACKET_END]	= "pkt_end",
   453			[PTR_TO_FLOW_KEYS]	= "flow_keys",
   454			[PTR_TO_SOCKET]		= "sock",
   455			[PTR_TO_SOCK_COMMON]	= "sock_common",
   456			[PTR_TO_TCP_SOCK]	= "tcp_sock",
   457			[PTR_TO_TP_BUFFER]	= "tp_buffer",
   458			[PTR_TO_XDP_SOCK]	= "xdp_sock",
   459			[PTR_TO_BTF_ID]		= "ptr_",
   460			[PTR_TO_MEM]		= "mem",
   461			[PTR_TO_ARENA]		= "arena",
   462			[PTR_TO_BUF]		= "buf",
   463			[PTR_TO_FUNC]		= "func",
   464			[PTR_TO_INSN]		= "insn",
   465			[PTR_TO_MAP_KEY]	= "map_key",
   466			[CONST_PTR_TO_DYNPTR]	= "dynptr_ptr",
   467		};
   468	
   469		if (type & PTR_MAYBE_NULL) {
   470			if (base_type(type) == PTR_TO_BTF_ID)
   471				strscpy(postfix, "or_null_");
   472			else
   473				strscpy(postfix, "_or_null");
   474		}
   475	
 > 476		snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
   477			 type & MEM_RDONLY ? "rdonly_" : "",
   478			 type & MEM_RINGBUF ? "ringbuf_" : "",
   479			 type & MEM_USER ? "user_" : "",
   480			 type & MEM_PERCPU ? "percpu_" : "",
   481			 type & MEM_RCU ? "rcu_" : "",
   482			 type & PTR_UNTRUSTED ? "untrusted_" : "",
   483			 type & PTR_TRUSTED ? "trusted_" : "",
   484			 type & MEM_UNINIT ? "uninit_" : "",
   485			 type & DYNPTR_TYPE_LOCAL ? "dynptr_local_" : "",
   486			 type & DYNPTR_TYPE_RINGBUF ? "dynptr_ringbuf_" : "",
   487			 type & MEM_FIXED_SIZE ? "fixed_size_" : "",
   488			 type & MEM_ALLOC ? "alloc_" : "",
   489			 type & NON_OWN_REF ? "non_own_ref_" : "",
   490			 type & DYNPTR_TYPE_SKB ? "dynptr_skb_" : "",
   491			 type & DYNPTR_TYPE_XDP ? "dynptr_xdp_" : "",
   492			 type & MEM_ALIGNED ? "aligned_" : "",
   493			 type & MEM_WRITE ? "write_" : "",
   494			 type & DYNPTR_TYPE_SKB_META ? "dynptr_skb_meta_" : "",
   495			 type & DYNPTR_TYPE_FILE ? "dynptr_file_" : ""
   496		);
   497	
   498		snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
   499			 prefix, str[base_type(type)], postfix);
   500		return env->tmp_str_buf;
   501	}
   502	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

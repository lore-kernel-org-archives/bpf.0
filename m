Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88113CF82;
	Thu, 15 Oct 2026 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792023904; cv=none; b=LfJBPN/kDCBwinV5QQF1FNg7HlpT9+UOP0wFshi3fbOnGFxGdfv5pr7UtOrT1sS/qqtKXCMOmVNAn4GlC1dyglZTLLkXXTX66TgsJIyiLgd7m/k7td6wWzVw1a9rXLl4shyXQAiiPD/0Pymi6P4wIkzbvJ5WUXjeUrBsNNCE88Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792023904; c=relaxed/simple;
	bh=Z74CIpFqSRRc46W6Aogy0/axOIHTqt2eqDMEYrxKQQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAIH2F070abBAh95aKjuTPhs5qdDTtusbqCVaYJx/zmoqawkVuHExEHMmKAXzhQ85ESLq19tU4Dw5lZoPXttp8vHaXl9AMy8iRvQCTTpFs9EL8t5zb2tsHtX4ejaWkQtcz2H+MMImwxVPDrBNvJFjh2ApmCniEytnXEdr1VZCu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCYALGhr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCYALGhr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792023903; x=1823559903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z74CIpFqSRRc46W6Aogy0/axOIHTqt2eqDMEYrxKQQ4=;
  b=CCYALGhr0rrgoC0w/iru2zpOLNtdI86bHaGLTS+Pc4vgZSOttCf5iNva
   b/HZOVvC5jD8iC+JIWZACLUAkkxW9s5vFj527hrvlWYWS1gkA6vd4VJvR
   R0GvV1OPFhinSXZ2556Y/+qurgS1aoJIYMWVsAbOlT1cEFqM4cqvS+ESr
   YrRlixwgLcyBRtiHfMsNi7VgNkuuThfu3o+RcP43G5xE3gSgeYQQW1a1N
   pmHN9EbOtgmXWEQheE7qS5SQe0pbaEMv/eFMwGuMPu/ALpCGBZIjnMNhP
   tKjxQXDH+8KDT9bLyZlZOgDsEEE456n8P0uxHUnHyvltH3v4OZQ+x1oZg
   g==;
X-CSE-ConnectionGUID: wyQFS8k/SNyQQJ2Y+ODIkA==
X-CSE-MsgGUID: HeUbZsHVRzOvi4hqxiuVxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="673871"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="673871"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 17:25:02 -0700
X-CSE-ConnectionGUID: Urepl0S1QyKgdE9VSTATJA==
X-CSE-MsgGUID: 9mJuBg9mRCCL3pq9CP7fJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1584506"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 14 Oct 2026 17:24:55 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xH9H9-00000000FQl-2kEh;
	Thu, 15 Oct 2026 00:24:51 +0000
Date: Thu, 15 Oct 2026 08:24:03 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>, Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>, Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 14/21] bpf: Add tracing_multi link info
 support for bpf progs
Message-ID: <202610151004.s3b0Ih11-lkp@intel.com>
References: <20261012154024.29423-15-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012154024.29423-15-leon.hwang@linux.dev>

Hi Leon,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-Initialize-ftrace_managed-in-bpf_trampoline_get/20261012-234003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20261012154024.29423-15-leon.hwang%40linux.dev
patch subject: [PATCH bpf-next v2 14/21] bpf: Add tracing_multi link info support for bpf progs
config: i386-randconfig-1011-20261013 (https://download.01.org/0day-ci/archive/20261015/202610151004.s3b0Ih11-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610151004.s3b0Ih11-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610151004.s3b0Ih11-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/bpf_trace.c: In function 'bpf_tracing_multi_link_fill_link_info':
>> kernel/trace/bpf_trace.c:3755:32: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    3755 |                         addr = (u64) mnode->trampoline->func.addr;
         |                                ^


vim +3755 kernel/trace/bpf_trace.c

  3708	
  3709	static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
  3710							 struct bpf_link_info *info)
  3711	{
  3712		u32 __user *fids = u64_to_user_ptr(info->tracing_multi.func_btf_ids);
  3713		u64 __user *ucookies = u64_to_user_ptr(info->tracing_multi.cookies);
  3714		u64 __user *uaddrs = u64_to_user_ptr(info->tracing_multi.addrs);
  3715		u32 __user *uids = u64_to_user_ptr(info->tracing_multi.ids);
  3716		struct bpf_tracing_multi_link *tr_link;
  3717		u32 ucount = info->tracing_multi.count;
  3718		bool has_cookies, show_addrs, has_progs;
  3719		int err = 0;
  3720	
  3721		if ((uids || ucookies || uaddrs || fids) && !ucount)
  3722			return -EINVAL;
  3723	
  3724		tr_link = container_of(link, struct bpf_tracing_multi_link, link);
  3725	
  3726		info->tracing_multi.attach_type = tr_link->link.attach_type;
  3727		info->tracing_multi.count = tr_link->nodes_cnt;
  3728		info->tracing_multi.btf_obj_id = btf_obj_id(tr_link->link.prog->aux->attach_btf);
  3729		has_progs = !!tr_link->tgt_progs;
  3730		info->tracing_multi.flags = has_progs ? BPF_F_TRACING_MULTI_TGT_PROGS : 0;
  3731	
  3732		if (!uids && !ucookies && !uaddrs && !fids)
  3733			return 0;
  3734		if (has_progs != !!fids)
  3735			return -EINVAL;
  3736	
  3737		if (ucount < tr_link->nodes_cnt)
  3738			err = -ENOSPC;
  3739		else
  3740			ucount = tr_link->nodes_cnt;
  3741	
  3742		has_cookies = !!tr_link->cookies;
  3743		show_addrs = kallsyms_show_value(current_cred());
  3744	
  3745		for (int i = 0; i < ucount; i++) {
  3746			struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
  3747			u32 prog_id, btf_id;
  3748			u64 addr, cookie;
  3749	
  3750			bpf_trampoline_unpack_key(mnode->trampoline->key, &prog_id, &btf_id);
  3751	
  3752			if (!show_addrs)
  3753				addr = 0;
  3754			else if (has_progs)
> 3755				addr = (u64) mnode->trampoline->func.addr;
  3756			else
  3757				addr = mnode->trampoline->ip;
  3758			cookie = has_cookies ? tr_link->cookies[i] : 0;
  3759	
  3760			if (uids && put_user(has_progs ? prog_id : btf_id, uids + i))
  3761				return -EFAULT;
  3762			if (uaddrs && put_user(addr, uaddrs + i))
  3763				return -EFAULT;
  3764			if (ucookies && put_user(cookie, ucookies + i))
  3765				return -EFAULT;
  3766			if (has_progs && put_user((u32) mnode->trampoline->key, fids + i))
  3767				return -EFAULT;
  3768	
  3769			cond_resched();
  3770		}
  3771	
  3772		return err;
  3773	}
  3774	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

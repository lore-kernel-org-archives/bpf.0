Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444823914E2;
	Sun, 18 Oct 2026 03:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792294141; cv=none; b=pqoFE2ooxeiwg1DawVM3SIf5QkuXt8dPnBuEI+yNSDUAtaMajJWOQfKynQx3wADmMgTJOw7iFfWJn9ViM0ehv43dWTnLHssyvoLBFevLJtOgg0nyUVw/BR9zbID0fSDjHSSHYGNZsz9eKirdJJa8lU3d5v787STjwConLKS3Phc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792294141; c=relaxed/simple;
	bh=F+Hq0GMwdlaQdyJkkOLy2FYTmXa++UKxr1RzWfqR9Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFMNBCm6wW7TsatzRtBF8X84/fnD8ixhROG9ZF0NiRd0lUHlc+DEIkOTweAHNR8gk8b6Djwu7pdrjgpGFkUbcY6oEPz/Hf8DL8zc0C/K75B4Ev4zbiWI40RY85d/wM/u2uYTxDEp2SkH20ZKwNYCZFJdhu8Rk2DydzRPo+5pNk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGYJafbg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGYJafbg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792294138; x=1823830138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F+Hq0GMwdlaQdyJkkOLy2FYTmXa++UKxr1RzWfqR9Qk=;
  b=GGYJafbgbKrmhVqtLIfWe3CF0RhVTtyDkP1yTQAXZuvF95OScm+pdHws
   mAEHV6Wd4BVpnW7H3YsKJYVGBkYqczonKf//UKouuy4U5zYutN8lGAkzQ
   Hv6fwQoT21KChfnVE/vFDG/MVyzQ7Gvlsxeni4LrnatHuUZigFr2Frb8r
   Xw+jRd+Mn57DZBidnUR2kPVPIbz1yJrloWXkN63/7umHURmie6B8k91tK
   5lsIMAqPPILFig+X3ouQgZWF8FRf84spYcmgpIxhkw0N3T4JYLlstgOwp
   +LmjJw0k0ePuo0D48d6QJEzSlv7QtxwdMn7QYRpj1B99JSgkCIGPCK98A
   Q==;
X-CSE-ConnectionGUID: u2dcIjv7QSW5qhbvfeGsNQ==
X-CSE-MsgGUID: BRzNgwMSQkOgNQramYCcsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1033961"
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="1033961"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 20:28:57 -0700
X-CSE-ConnectionGUID: H2kq8ComQM28lxHqC8d2EA==
X-CSE-MsgGUID: K2jZON5XSQWVuvrP1P0Z7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="2246898"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Oct 2026 20:28:52 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIHZo-00000000K2M-0QN0;
	Sun, 18 Oct 2026 03:28:48 +0000
Date: Sun, 18 Oct 2026 11:28:29 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Masashi Honma <masashi.honma@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add syscall common attrs support for
 xdp link_create
Message-ID: <202610181150.jL2DnHl7-lkp@intel.com>
References: <20261017142649.51047-3-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017142649.51047-3-leon.hwang@linux.dev>

Hi Leon,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-Add-syscall-common-attrs-support-for-link_create/20261017-222644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20261017142649.51047-3-leon.hwang%40linux.dev
patch subject: [PATCH bpf-next 2/6] bpf: Add syscall common attrs support for xdp link_create
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20261018/202610181150.jL2DnHl7-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261018/202610181150.jL2DnHl7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610181150.jL2DnHl7-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: net/core/dev.o: in function `bpf_xdp_link_attach':
>> net/core/dev.c:10789:(.text+0x96f9): undefined reference to `bpf_log'
   collect2: error: ld returned 1 exit status


vim +10789 net/core/dev.c

 10774	
 10775	int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
 10776				struct bpf_verifier_log *log)
 10777	{
 10778		struct net *net = current->nsproxy->net_ns;
 10779		struct bpf_link_primer link_primer;
 10780		struct netlink_ext_ack extack = {};
 10781		struct bpf_xdp_link *link;
 10782		struct net_device *dev;
 10783		int err, fd;
 10784	
 10785		rtnl_lock();
 10786		dev = dev_get_by_index(net, attr->link_create.target_ifindex);
 10787		if (!dev) {
 10788			rtnl_unlock();
 10789			bpf_log(log, "Invalid target_ifindex.\n");
 10790			return -EINVAL;
 10791		}
 10792	
 10793		link = kzalloc_obj(*link, GFP_USER);
 10794		if (!link) {
 10795			err = -ENOMEM;
 10796			goto unlock;
 10797		}
 10798	
 10799		bpf_link_init(&link->link, BPF_LINK_TYPE_XDP, &bpf_xdp_link_lops, prog,
 10800			      attr->link_create.attach_type);
 10801		link->dev = dev;
 10802		link->flags = attr->link_create.flags;
 10803	
 10804		err = bpf_link_prime(&link->link, &link_primer);
 10805		if (err) {
 10806			kfree(link);
 10807			goto unlock;
 10808		}
 10809	
 10810		netdev_lock_ops(dev);
 10811		err = dev_xdp_attach_link(dev, &extack, link);
 10812		netdev_unlock_ops(dev);
 10813		rtnl_unlock();
 10814	
 10815		if (err) {
 10816			link->dev = NULL;
 10817			bpf_link_cleanup(&link_primer);
 10818			bpf_log(log, extack._msg);
 10819			trace_bpf_xdp_link_attach_failed(extack._msg);
 10820			goto out_put_dev;
 10821		}
 10822	
 10823		fd = bpf_link_settle(&link_primer);
 10824		/* link itself doesn't hold dev's refcnt to not complicate shutdown */
 10825		dev_put(dev);
 10826		return fd;
 10827	
 10828	unlock:
 10829		rtnl_unlock();
 10830	
 10831	out_put_dev:
 10832		dev_put(dev);
 10833		return err;
 10834	}
 10835	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

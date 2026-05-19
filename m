Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70536C0CE;
	Tue, 19 May 2026 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779228288; cv=none; b=nSPPkpaFeXXbDzB6kt9Oej0I8TZ7aXaDfASYnGM9I3/lP/G4zLqO7WmEwErKOQEPsp50BB6ZuzA5TGBHAOpMm5rmY2C8itm7A3I2eTx5GoHxR+BildPpZTOlAXgPyge8wlg8ksiw1veA0+HBjmpsVYrYWufdrLF593qlbL40mLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779228288; c=relaxed/simple;
	bh=g1vLSl5trggIm1zXbVe+RM8Rm+X/YE9INdqu72haORU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucN+X/c6vZPjyoEuu9af2YMA1B0g/cNyUmBduuAeiASuo7mH81GD+Y6WtFK/sHjwFIUb+8E9dXBa8Lxu8KYFzeHGhvwp38JvaDYZIrWbepcxnD9kW2zXgt9mb5FJutHpQgXJ95axnT3vd5mtnpLVz48KDtvn43EN6eUskcV5ZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eiyGG2XD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eiyGG2XD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779228286; x=1810764286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g1vLSl5trggIm1zXbVe+RM8Rm+X/YE9INdqu72haORU=;
  b=eiyGG2XDk+3E/Gcjzh4D/TShElUaWlC5CXe4+t5vOwFIKSvPVDPI4JUA
   CbJ78xvhusbCC6Cyj6Uf1jF6qTC53rOWXM78vYQ9X1w/BUXzYquxtD2R/
   GAK2hEpCAuCUrC1GUR7s2CxC8MALontw4BFbOgW8A9rTTJQjPh0KDgIlv
   F+f9hojw2gyKpWv50Dg5+k/JEf0TaZFbfuUvVGUdgzyagxEMh2w1czp7F
   UbE3Izfcp1+BiwHo75/bmRS4czrjclmffUZ2YYSux7oUsC7pkvf8I9RVs
   ab0ntpVrC4p2MTOMtfaHL4g4wbN59lv+nY1rGQ6JUnxEDhwHz4jkf9/Od
   g==;
X-CSE-ConnectionGUID: OksB6s25S6yk2S2DPj8zpQ==
X-CSE-MsgGUID: pWXM1OaBRz+K0A+PBJKb1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91225993"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="91225993"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:04:45 -0700
X-CSE-ConnectionGUID: +qqDDFa0SEOi/J7/yRTUUA==
X-CSE-MsgGUID: xqAAC6yDTN+5o9hFml3plQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="237298787"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 19 May 2026 15:04:40 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPSXz-0000000020H-2LDo;
	Tue, 19 May 2026 22:04:23 +0000
Date: Wed, 20 May 2026 06:03:38 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>,
	Douglas Raillard <douglas.raillard@arm.com>,
	Tom Zanussi <zanussi@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v5] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <202605200549.zZkT9xWc-lkp@intel.com>
References: <20260519130144.40e71a00@fedora>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519130144.40e71a00@fedora>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v7.1-rc4 next-20260519]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-eprobes-Allow-use-of-BTF-names-to-dereference-pointers/20260520-011353
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260519130144.40e71a00%40fedora
patch subject: [PATCH v5] tracing/eprobes: Allow use of BTF names to dereference pointers
config: arc-defconfig (https://download.01.org/0day-ci/archive/20260520/202605200549.zZkT9xWc-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260520/202605200549.zZkT9xWc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605200549.zZkT9xWc-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_probe.c: In function 'parse_probe_vars':
   kernel/trace/trace_probe.c:1035:21: error: implicit declaration of function 'parse_trace_event'; did you mean 'parse_trace_event_arg'? [-Wimplicit-function-declaration]
    1035 |                 if (parse_trace_event(arg, code, ctx) < 0)
         |                     ^~~~~~~~~~~~~~~~~
         |                     parse_trace_event_arg
   kernel/trace/trace_probe.c: In function 'sprint_nth_btf_arg':
   kernel/trace/trace_probe.c:1803:27: error: implicit declaration of function 'ctx_btf' [-Wimplicit-function-declaration]
    1803 |         struct btf *btf = ctx_btf(ctx);
         |                           ^~~~~~~
>> kernel/trace/trace_probe.c:1803:27: error: initialization of 'struct btf *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   kernel/trace/trace_probe.c: At top level:
   kernel/trace/trace_probe.c:318:12: warning: 'parse_trace_event_arg' defined but not used [-Wunused-function]
     318 | static int parse_trace_event_arg(char *arg, struct fetch_insn *code,
         |            ^~~~~~~~~~~~~~~~~~~~~


vim +1803 kernel/trace/trace_probe.c

  1797	
  1798	static int sprint_nth_btf_arg(int idx, const char *type,
  1799				      char *buf, int bufsize,
  1800				      struct traceprobe_parse_context *ctx)
  1801	{
  1802		const char *name;
> 1803		struct btf *btf = ctx_btf(ctx);
  1804		int ret;
  1805	
  1806		if (idx >= ctx->nr_params) {
  1807			trace_probe_log_err(0, NO_BTFARG);
  1808			return -ENOENT;
  1809		}
  1810		name = btf_name_by_offset(btf, ctx->params[idx].name_off);
  1811		if (!name) {
  1812			trace_probe_log_err(0, NO_BTF_ENTRY);
  1813			return -ENOENT;
  1814		}
  1815		ret = snprintf(buf, bufsize, "%s%s", name, type);
  1816		if (ret >= bufsize) {
  1817			trace_probe_log_err(0, ARGS_2LONG);
  1818			return -E2BIG;
  1819		}
  1820		return ret;
  1821	}
  1822	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

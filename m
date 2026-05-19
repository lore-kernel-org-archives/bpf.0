Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1E3E3166;
	Tue, 19 May 2026 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225066; cv=none; b=BJHsIE0VZ4P+rKXfW8/9dDf0g+2xYl7xKqi9b4ylWXhDYPek8WJOBGueByZFU6eXVf3kuWAx02jiuVmShA79jfOngFUDmqKOh2X8pDXMxpzkxbkuC23gIkouAWpoJrWyqje4x5pbNtxmpxVFhJhyPhowkeEA9kD0U0WSKQ+ihvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225066; c=relaxed/simple;
	bh=cQCETGmDqQbProNekXgVH2umQrcT5F2oaEv9arVNF68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgCl9/Bh4IPyHCo1uT0hhDEnh3ZlfZlB88nauNFw7woj3gBmzoQsAJOe6mrmzN2mqb+PzCpa89ffZ7Z7A5Qk6EEX0XSlAImPw8xekNh26HW2/VCRcarw5I0kEhPwILtFU97uwYh8a4ylbcRNRrk7AGgLHiD54AGSCwP3/DLOXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBFb2MHr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBFb2MHr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779225064; x=1810761064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cQCETGmDqQbProNekXgVH2umQrcT5F2oaEv9arVNF68=;
  b=jBFb2MHrQ8DacYOsNHt2pbMQDasr/GIIzwBmlvLV8Z7BURKLZBI3PDR8
   2TZu1dyhYrfBlmlSHJgoSRl2Jbw06IgYx7b74xvDjNMYHtEBysrFXsQhF
   3KU1kdY9CBzIDl1QIJ4r6P2lA/vGuMF2TvxrKS1qKSZOsbp2MHbn8tyUs
   o1NJMpZDoX/uCSsMBPTWycJ4peCK5ewyxkd46IEyc3+MLb8VUN0mneQwR
   oqJ5J8mviQUn3XLpFmfKHPQweZmgaSiLfg/9iUGvddmeqBc/k3vBXe5ef
   kKI5H574TZTaBb1FxPHIDYMdoKVRL6N5bDx0P83FeCv1lzicAySSNcCm9
   w==;
X-CSE-ConnectionGUID: b0CqmwFuQxWPNgkypNB15Q==
X-CSE-MsgGUID: ih0C1BD5QaWuwFa5Y2MM1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="97547169"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="97547169"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 14:11:03 -0700
X-CSE-ConnectionGUID: CoQjoB/NSAai3aCAu3qk8w==
X-CSE-MsgGUID: 4v0xHdqcT4SzGr1t9tjm7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239949807"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 19 May 2026 14:10:59 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPRhx-000000001v7-3iDF;
	Tue, 19 May 2026 21:10:44 +0000
Date: Wed, 20 May 2026 05:09:54 +0800
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
Message-ID: <202605200427.0xXjKghz-lkp@intel.com>
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
config: s390-randconfig-r071-20260520 (https://download.01.org/0day-ci/archive/20260520/202605200427.0xXjKghz-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260520/202605200427.0xXjKghz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605200427.0xXjKghz-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/trace/trace_probe.c: In function 'parse_probe_vars':
>> kernel/trace/trace_probe.c:1035:7: error: implicit declaration of function 'parse_trace_event'; did you mean 'parse_trace_event_arg'? [-Werror=implicit-function-declaration]
      if (parse_trace_event(arg, code, ctx) < 0)
          ^~~~~~~~~~~~~~~~~
          parse_trace_event_arg
   kernel/trace/trace_probe.c: In function 'sprint_nth_btf_arg':
>> kernel/trace/trace_probe.c:1803:20: error: implicit declaration of function 'ctx_btf' [-Werror=implicit-function-declaration]
     struct btf *btf = ctx_btf(ctx);
                       ^~~~~~~
>> kernel/trace/trace_probe.c:1803:20: warning: initialization of 'struct btf *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   At top level:
>> kernel/trace/trace_probe.c:318:12: warning: 'parse_trace_event_arg' defined but not used [-Wunused-function]
    static int parse_trace_event_arg(char *arg, struct fetch_insn *code,
               ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1035 kernel/trace/trace_probe.c

  1020	
  1021	/* Parse $vars. @orig_arg points '$', which syncs to @ctx->offset */
  1022	static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
  1023				    struct fetch_insn **pcode,
  1024				    struct fetch_insn *end,
  1025				    struct traceprobe_parse_context *ctx)
  1026	{
  1027		struct fetch_insn *code = *pcode;
  1028		int err = TP_ERR_BAD_VAR;
  1029		char *arg = orig_arg + 1;
  1030		unsigned long param;
  1031		int ret = 0;
  1032		int len;
  1033	
  1034		if (ctx->flags & TPARG_FL_TEVENT) {
> 1035			if (parse_trace_event(arg, code, ctx) < 0)
  1036				goto inval;
  1037			return 0;
  1038		}
  1039	
  1040		if (str_has_prefix(arg, "retval")) {
  1041			if (!(ctx->flags & TPARG_FL_RETURN)) {
  1042				err = TP_ERR_RETVAL_ON_PROBE;
  1043				goto inval;
  1044			}
  1045			if (!(ctx->flags & TPARG_FL_KERNEL) ||
  1046			    !IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS)) {
  1047				code->op = FETCH_OP_RETVAL;
  1048				return 0;
  1049			}
  1050			return parse_btf_arg(orig_arg, pcode, end, ctx);
  1051		}
  1052	
  1053		len = str_has_prefix(arg, "stack");
  1054		if (len) {
  1055	
  1056			if (arg[len] == '\0') {
  1057				code->op = FETCH_OP_STACKP;
  1058				return 0;
  1059			}
  1060	
  1061			if (isdigit(arg[len])) {
  1062				ret = kstrtoul(arg + len, 10, &param);
  1063				if (ret)
  1064					goto inval;
  1065	
  1066				if ((ctx->flags & TPARG_FL_KERNEL) &&
  1067				    param > PARAM_MAX_STACK) {
  1068					err = TP_ERR_BAD_STACK_NUM;
  1069					goto inval;
  1070				}
  1071				code->op = FETCH_OP_STACK;
  1072				code->param = (unsigned int)param;
  1073				return 0;
  1074			}
  1075			goto inval;
  1076		}
  1077	
  1078		if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
  1079			code->op = FETCH_OP_COMM;
  1080			return 0;
  1081		}
  1082	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

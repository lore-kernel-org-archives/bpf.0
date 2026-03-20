Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612E38D6A8;
	Fri, 20 Mar 2026 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001947; cv=none; b=VV1mbrh+XPbNi4PE2sjZfLkKK9pCjYfoeUzewKQpyGzDJXBAa4dymsBErK/hPJLgl8rO+TclxXAYe5RTZfB7VMdf1W+CKRwJETGQ1R717W/5V3ozsD6TiNeTx1KUbMgDwv/eqyJfEOJxVhJGKcW4JyaH0jLKqSj5oe6DbcX1j+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001947; c=relaxed/simple;
	bh=9xUNeMBUbv50TFhTrU7GhOJSxZ6PPhrSR/Qj7v/5NWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8e1yjPFc5mnHEaweCQ5Jc+JvHd2z+Jh+UqDPjtDCQMwlz4O8eZ1ZJ04ckQA3v568CHg8LWAMxHkLw9n6IYuTI0ywWYYMI2AzMqGgQ8cjZhSYOi4Do6+Cget3gTJuXLJFoiOiRVKvfFa3gdBNJI+eS+/fSV7OQ8/8VaiRqPHKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3FGcLQz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3FGcLQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774001938; x=1805537938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9xUNeMBUbv50TFhTrU7GhOJSxZ6PPhrSR/Qj7v/5NWQ=;
  b=I3FGcLQzeRTfk76HnulvH+h0zeBVDPzhLDdQKHnFqpABJUjdbGNEZ+C2
   oIbWtmrhL7yotqGX8SLAdxp1kqfejXPHNjqDNkYww4GXWBLKjfHk68Jwx
   mPug6e4B5sIMXOUjVOol7OCYEYFDK8Sj+TiFzJnaxH+/SmeJCwYyZDaRl
   hXZzzO4g8AKm8I/UJAF6Lc6cyNURlD8seF1DUSBW2jOLUn4HukJ8QruMo
   QMzzNT3NM29DjM9CULiYH/OXvp63/78WTYR6GPPyu5tx/pVB/D+zsxI1u
   2lzN2flpvCNh70uV3KWnVZVgCt7k0A4nJJxWXvTxDZITacZfKCeLe7CpD
   g==;
X-CSE-ConnectionGUID: ihfi/Hy3TvmpFw/rjZqqVw==
X-CSE-MsgGUID: cRN7TxXZSouGn57h2W3j5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="92658889"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="92658889"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:18:57 -0700
X-CSE-ConnectionGUID: zLehAkZ/Qu6Cfa49jA9rEA==
X-CSE-MsgGUID: HEHwKXlOS/6q0uNEFA0sYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="218615516"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 20 Mar 2026 03:18:53 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3WwM-000000002G5-2cL7;
	Fri, 20 Mar 2026 10:18:50 +0000
Date: Fri, 20 Mar 2026 18:18:26 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv3 bpf-next 08/24] bpf: Add
 bpf_trampoline_multi_attach/detach functions
Message-ID: <202603201820.zsM5FRDS-lkp@intel.com>
References: <20260316075138.465430-9-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316075138.465430-9-jolsa@kernel.org>

Hi Jiri,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Olsa/ftrace-Add-ftrace_hash_count-function/20260316-160117
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260316075138.465430-9-jolsa%40kernel.org
patch subject: [PATCHv3 bpf-next 08/24] bpf: Add bpf_trampoline_multi_attach/detach functions
config: x86_64-randconfig-075-20260320 (https://download.01.org/0day-ci/archive/20260320/202603201820.zsM5FRDS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603201820.zsM5FRDS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603201820.zsM5FRDS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/trampoline.c:1520:8: error: call to undeclared function 'btf_distill_func_proto'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1520 |         err = btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel);
         |               ^
   1 error generated.


vim +/btf_distill_func_proto +1520 kernel/bpf/trampoline.c

  1498	
  1499	static int bpf_get_btf_id_target(struct btf *btf, struct bpf_prog *prog, u32 btf_id,
  1500					 struct bpf_attach_target_info *tgt_info)
  1501	{
  1502		const struct btf_type *t;
  1503		unsigned long addr;
  1504		const char *tname;
  1505		int err;
  1506	
  1507		if (!btf_id || !btf)
  1508			return -EINVAL;
  1509		t = btf_type_by_id(btf, btf_id);
  1510		if (!t)
  1511			return -EINVAL;
  1512		tname = btf_name_by_offset(btf, t->name_off);
  1513		if (!tname)
  1514			return -EINVAL;
  1515		if (!btf_type_is_func(t))
  1516			return -EINVAL;
  1517		t = btf_type_by_id(btf, t->type);
  1518		if (!btf_type_is_func_proto(t))
  1519			return -EINVAL;
> 1520		err = btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel);
  1521		if (err < 0)
  1522			return err;
  1523		if (btf_is_module(btf)) {
  1524			/* The bpf program already holds refference to module. */
  1525			if (WARN_ON_ONCE(!prog->aux->mod))
  1526				return -EINVAL;
  1527			addr = find_kallsyms_symbol_value(prog->aux->mod, tname);
  1528		} else {
  1529			addr = kallsyms_lookup_name(tname);
  1530		}
  1531		if (!addr || !ftrace_location(addr))
  1532			return -ENOENT;
  1533		tgt_info->tgt_addr = addr;
  1534		return 0;
  1535	}
  1536	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

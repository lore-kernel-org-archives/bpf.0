Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F5F47A87A;
	Fri, 25 Sep 2026 23:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377370; cv=none; b=aebwFObxV8ehSBnR3/H/7fzaqhTpGjMJTvZdXzK8kDWMDMwxF6FaA+T9P1i3WOVHmWHJ24PEmOXhSLc8DPRpvxSXow6XumGoQxPyOPvfrGuB0MiX3RCH9n+u+yprgsfjkJdbG1ZgztLSkC3lwZlGhlbO3l1hlMNstYKfr3mJldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377370; c=relaxed/simple;
	bh=pdCv4UcozVHgKk7UfV9mEseJYHtwD2DHpqfJ6KA5iAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtgqpswV4ZpwGvtqP06MdM+8vxoZij2bXjK0+gy5bd+GuHoZF43njWNi81o9nldrg0y1DYrtukhCHRxT24z0cC5BgAielVCaxnyp9LxKA3unCTz/uFMrBuEUU1KzrGBKdXVF53kdIHyRBnP/Tw3VXJhcdJl8VCgWU9l08Wr59sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=T4GZ8SF/; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="T4GZ8SF/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790377369; x=1821913369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JQe85Z5Rbqw6JLCH1J2snkDs7p4I536/WA8nqd/VrHE=;
  b=T4GZ8SF/gXk2RAyzQYCar3tus70nIz2Br7YgLw4qvNnnOC6SUWAYJSt7
   AxzA0ju3ggzi4B+zmKYW7wIXnwAJBk23kIxOhsNstVLpncGXn/rIjQD1D
   bpMLb4ikJ6CxKXFWm8VpkRZ3jxmAzJsgC1aQFm5EPfUJuaN5qdK9FOGUZ
   tQUREFI96NtH88cVdaaLp4c8z2zw49h2+/QVsnLj/hfBWrl8NynsnodBL
   ysarWgbhLn0q/hDRpzedfNDQUqQlbsdAR8MbtV4vVawkk/LW2T5FETh9b
   BW5u64r6+ArNoMJfNfsBLvbe0U/+Tjvb9fxllBWAQkrVi8+wcoBE4aqVS
   g==;
X-CSE-ConnectionGUID: 9BWfvgFKSs6c4sx0qwaFNA==
X-CSE-MsgGUID: JIKwq5U2TnaeDi40RDQ9gw==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29482109"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 23:02:48 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:8699]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.186:2525] with esmtp (Farcaster)
 id 389bb488-efa7-4648-96b3-49db0e908d31; Fri, 25 Sep 2026 23:02:47 +0000 (UTC)
X-Farcaster-Flow-ID: 389bb488-efa7-4648-96b3-49db0e908d31
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:47 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:47 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>
CC: <alan.maguire@oracle.com>, <martin.lau@linux.dev>,
	<yonghong.song@linux.dev>, <nathan@kernel.org>, <nsc@kernel.org>,
	<linux-kbuild@vger.kernel.org>, <mcgrof@kernel.org>, <petr.pavlu@suse.com>,
	<linux-modules@vger.kernel.org>, <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <abuehaze@amazon.com>, <doebel@amazon.de>,
	<jay.wang.upstream@gmail.com>, <martin.lau@kernel.org>, <mason@kernel.org>,
	<ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 3/6] bpf: fetch the vmlinux BTF where kernel types enter a program
Date: Fri, 25 Sep 2026 23:02:46 +0000
Message-ID: <20260925230246.33537-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <39f6151d364d966f70b7802cfd4bbca15734a7945478265ecc681f1779e50abb@mail.kernel.org>
References: <39f6151d364d966f70b7802cfd4bbca15734a7945478265ecc681f1779e50abb@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Addressed since v2; the current version is v3 (patch 3/9):
https://lore.kernel.org/bpf/20260925224229.1850-1-wanjay@amazon.com/

Two of these are real gaps in the set of fetch sites and are
fixed:

- bpf_ctx_convert.t: the program context types are kernel types too, and
  btf_prepare_func_args() (global subprogs taking the context) and
  btf_translate_to_vmlinux() (ctx access of tracing/EXT programs) read
  the table without anything having fetched the BTF.  It is now fetched
  in the table's readers.  Tested with a socket filter whose global
  subprogram takes struct __sk_buff * as the first user on a fresh boot.

- bpf_snprintf_btf()/bpf_seq_printf_btf(): the type id travels inside
  struct btf_ptr, so the arg/ret type check does not see it.  The two
  helpers are now named explicitly.  Tested with a raw_tp program
  calling bpf_snprintf_btf() as the first user.

Also addressed:

- The IS_ERR(btf_vmlinux) check in bpf_check() now reads through
  bpf_peek_btf_vmlinux().  With =m a failed parse is not stored (below),
  so it only fires for =y, where the BTF is parsed at boot as before;
  with =m each fetch site reports the failure itself.
- btf_prepare_func_args() and btf_check_kfunc_name() check the result
  of bpf_get_btf_vmlinux() (pre-existing, but cheap).
- A failed parse is no longer cached with =m; the payload was verified
  against the kernel when the module loaded, so a failure there is a
  resource problem and the next caller retries.  =y keeps caching, as
  before: a parse failure there means the build is broken.

Not a bug:

- bpf_verifier_lock vs request_module(): the lock is only taken for
  unprivileged programs, and none of the fetch sites is reachable from
  one: kfuncs, ksyms, map pointer access and the BTF helpers all need
  privileged program types, and the context-type path needs a global
  subprogram, i.e. program BTF, which BPF_BTF_LOAD only accepts with
  CAP_BPF.  modprobe does not load BPF programs.

Jay

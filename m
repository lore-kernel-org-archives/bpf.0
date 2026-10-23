Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714636;
	b=23nBw3CSuaMQNW/uFLsyUYGMSATpDEC/ZokABLL+7SGPDlfVnd7d3luD4PMgroO5FQFz
	 VYu++OaEwufQdQikmFqa5XVThw3/g6DnN2zdQfl7PlpFm8kbKlRNtCohpq5s5VnNpJk5A
	 ZFolkn9Fr9jlqogVp+20BNiW/wZaMrBd+lBFxMYgWT76y/VA2HC4KxqZhgkW9E9mLYs6g
	 DSogplMxoHkRkuHcrrhSpTFGFtu9fmTjfY2Rb/fkLFCibqfgk+RWDEKk/7s129O3jlUyJ
	 Ek5WsaD+AbrGLsbBccdv4PoNehXAZ1E3XlTaAnZuQO74Ksej7V7J94MTe6JLJqn5L6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=k9AsLihF+plfOh4bix9+PxHbqUaaLj3NetmJnD5B0HA=;
	b=XSIMLkd6h2jJxJD/pbE4O4qgVWHWFmyCqQe19UadhBHrSKC+/2KtGCHjGtRCzoQMOYxJ
	 Q5q4thi+rBKUavgtb1B/r9LxPkY7F/4kujmY/85i2LtS0e4H03wOilksJ/JDbd8c4HF1h
	 Sw0VIZsY1UMEnmWF9O4rtEu9q+wxuLnZVzCJVJpl49fSLpcsSpjGpib4IqI4uPdbPEGCD
	 9UQ9I29H9g3V7J+XUwfEiO3OstMi5Ib/V2xZvzmp1N2muMJO8tm/PfWnQc97IoP/nUVmK
	 44bLg7QQzV3s1gllyiefWSXA2b11tfA2mtuIo00xuEip1mVJGfXhPem6m54zHnOCjdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=b+lefz++;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF2606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72CF2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=b+lefz++
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3552883bd19so1116760eec.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792714635; x=1793319435; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k9AsLihF+plfOh4bix9+PxHbqUaaLj3NetmJnD5B0HA=;
        b=b+lefz++RY2Vf+vwPTZKdVHK2gPGoWcL5qKzIYEIZlGq1QuO7Fb+Langj4r599r0pZ
         SgowuDwyHZQIUwoSDKrZ1tm7P2Y00cpjASYrPKTmPttnr3qBfGqLPw0eikfWOWQBvgoT
         G9HA+Rloyr9LKBsBo44Fwh4ORzs9F6yo/t+UcyOuEFcHhJl1g1pypjL2wmKG576A9zXP
         7j7fch9H4Piad2uCHWgA3ljFsGw4zw8PwW2Uj3GW+MdWXNj2YoutMVXrJO7jgeNW2jcr
         9/rh0STYq871H+QY6H8mx28wdSRwy3yGI92/+49RlhDLIMlDnLINFr9ZhzDhPDeYWJKG
         gvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714635; x=1793319435;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k9AsLihF+plfOh4bix9+PxHbqUaaLj3NetmJnD5B0HA=;
        b=CImO9iz33jKTJF1gv1Y59o6j+cR8Mv4GZVlpy9MoZ6qwBbMHLfwIpcVO4jW7cFT8xU
         axLYMJtzIRa7aXCyD4je0ZEknmvflLMrDa4sl2Hs5zml4c5cZzjR2qsEBUA/O0mltvYt
         2/nYXWJPW29PZG2EujBzqUiawGler9FK9s1/neQvowCaSOjy53m9VnA2ZPJGbFezJDfa
         +k4mMPaZhqostIrZXVDbYX276OlQKXynGeCszfqjG9vpumUgx/PUMLCmu9Q1ej4jUQye
         8gsOSz5GSdFEi0it+iHPUKDn8IGnbg17UXJhpLZJEAyrxmbzmifure5B+kBFeL9mzoWe
         3BVg==
X-Forwarded-Encrypted: i=1; AKwUvBw2Hb6FmujRVg94LLxsz5siKNgCohqikIV58pDf+coGkSLw4yPSp4c4x8weQ4iep0se8dU=@vger.kernel.org
X-Gm-Message-State: AFq9FYII4DOH1lQv+92y/FXizv27b4OiGVx11RIpK1NLext56f8WRJYL
	CQq73sWM/Qd5az8SZPwLLni5Xdh11nqgxddBxw7HoeUiYKU9U5BrzUTsO7msDAh6mTMS89N0ggA
	r1jhUU6kFU4ghUQ==
X-Received: from dyuq24.prod.google.com ([2002:a05:693c:66d8:b0:351:4a2a:1ece])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:a225:b0:351:6b27:d67d with SMTP id 5a478bee46e88-369d9802e3amr774839eec.30.1792714635111;
 Thu, 22 Oct 2026 17:17:15 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:16:01 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023001603.560210-8-wusamuel@google.com>
Subject: [PATCH bpf-next v2 0/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

/proc/kallsyms is the primary interface for userspace to query the kernel
symbol table. However, resolving even a handful of symbols or addresses
requires reading and parsing the entire text file, which is often several
megabytes and takes thousands of read() syscalls.

This patchseries adds an extensible KALLSYMS_QUERY ioctl() to
/proc/kallsyms with two query modes:
1. KALLSYMS_QUERY_BY_SYMBOL: Resolves a NUL-terminated symbol name to its
   address. Searches vmlinux first with binary search, then falls back to
   loaded modules. Matches names exactly (without stripping .llvm.<hash>
   suffixes) and rejects ambiguous symbols with different addresses.
2. KALLSYMS_QUERY_BY_ADDR: Resolves a kernel address to the symbol's
   name, covering vmlinux, loaded modules, BPF JIT programs, and ftrace
   trampolines.

Access control matches reading /proc/kallsyms directly: the ioctl checks
the kallsyms_show_value() result cached at open() time and returns -EPERM
whenever symbol addresses would be masked to zero.

There were significant performance improvements with this patchseries:

1. libbpf typeless ksym resolution (8-CPU x86-64 Cuttlefish VM, BPF
   object with 11 typeless ksyms):

   Metric                      Text parse  KALLSYMS_QUERY   Change
   --------------------------  ----------  ---------------  ------------
   Resolve 11 typeless ksyms   157 ms      0.7 ms           ~220x faster

2. Perfetto symbolization & callstack sampling (8-CPU x86-64 VM,
   175k-line /proc/kallsyms):

   Metric                      Text parse  KALLSYMS_QUERY   Change
   --------------------------  ----------  ---------------  ------------
   Init                        155.7 ms    0.44 ms          352x faster
   50k lookups                 25.2 ms     2.2 ms           11.7x faster
   traced_probes VmRSS         15.1 MB     4.8 MB           -68%
   traced_probes VmHWM         23.9 MB     4.8 MB           -80%

Changes in v2:
- Replaced the BPF syscall approach in libbpf with the more generalizable
  KALLSYMS_QUERY ioctl() on /proc/kallsyms, per Andrii
- Added KALLSYMS_QUERY_BY_ADDR for address-to-symbol lookup
- Added proc and bpf selftests and procfs documentation
- v1 link: https://lore.kernel.org/all/20261009130708.1370675-1-wusamuel@google.com/

Samuel Wu (6):
  kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
  tools: Copy KALLSYMS_QUERY definitions to linux/fs.h
  docs/procfs: Document KALLSYMS_QUERY ioctl on /proc/kallsyms
  libbpf: Resolve typeless ksyms via KALLSYMS_QUERY ioctl
  selftests/bpf: Test typeless module ksym resolution
  selftests/proc: Add KALLSYMS_QUERY tests

 Documentation/filesystems/proc.rst            |  15 ++
 include/uapi/linux/fs.h                       |  41 ++++
 kernel/kallsyms.c                             | 132 +++++++++++
 tools/include/uapi/linux/fs.h                 |  41 ++++
 tools/lib/bpf/libbpf.c                        |  78 ++++++-
 .../testing/selftests/bpf/prog_tests/ksyms.c  |   7 +
 .../testing/selftests/bpf/progs/test_ksyms.c  |   3 +
 tools/testing/selftests/proc/.gitignore       |   1 +
 tools/testing/selftests/proc/Makefile         |   1 +
 .../selftests/proc/proc-kallsyms-query.c      | 213 ++++++++++++++++++
 10 files changed, 530 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/proc/proc-kallsyms-query.c

-- 
2.56.0.257.gf7497c7d27-goog


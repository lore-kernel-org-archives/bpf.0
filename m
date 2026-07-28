Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D096471417
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250708; cv=none; b=X23ywCyyCfg+wavQr/P/JI9GG2hcZiqYBSTIZvesScUQgL2yGk26IxH22/z0nLE8mNZQzj6wUvo8ImxbJES6/wTk0CJgSRSorghzDknhVGA8ST+7jx3jMaz1jZWM98FuF+3XQJwngtrijZ/XEJ/P5tU4GnCiijNBLrrgSiv6KiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250708; c=relaxed/simple;
	bh=3jr2r76yx+dXDUKnRJEpTrhNqN2n/yrTtG1Di+6VMYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fS9sI6Im03Sq7wEbc2hZXv3DKp8K5TPKBxGslK3xhiKRjWRRh4XUHyKrysbpGQFFhjZdg2AOwqQBEwKi2Qb2QWpq5doanAQgZ9amIidug6dmu5eN5lB/y33f5+eyItRBGUxZu+EGi8Yx/BhgR0WkwA2gaogenSwhGZCGF5xnfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fghE8fcv; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fghE8fcv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785250694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WhZG3AkkllchHioWC2aFMhmuAYMHUiIKUyKER7s2cAk=;
	b=fghE8fcv8vmsSwrL+KSumi560ULOkxATjA0IQ/93paEV5tCgBfJWAX1RgP7DrJRjXylifz
	ZJBRwW0y7+Jgb3cRwNqw2r2XKSicgj8KW4Pia8++G77UMNQi1KMZp4gqs8retpikWtE7cE
	kSv7rSB4VCLyESOeQYN3V1pC8pxB8bw=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Rong Tao <rongtao@cestc.cn>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	Viktor Malik <vmalik@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH bpf-next 0/6] bpf: Optimize string kfuncs
Date: Tue, 28 Jul 2026 22:57:21 +0800
Message-ID: <20260728145727.45153-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

My friend Gray reported that bpf_strnstr() kfunc has poorer performance
than his SWAR(SIMD Within A Register)-alike pure-bpf implementation [1].

I built his microbench, and ran it on a 16-cores 16GiB QEMU VM:

taskset -c 1 ./bpf_swar_benchmark
BPF HTTP Host search benchmark
kernel=7.2.0-rc4-00662-g771a7ae30d95 arch=amd64 repeat=100000 trials=9 warmup=1000

Scenario     Bytes   Byte ns/op   SWAR ns/op   Kfunc ns/op SWAR speedup Kfunc speedup
first           64        492.0        246.0         345.0        2.00x        1.43x
middle         512       2761.0        780.0        1193.0        3.54x        2.31x
late          1536      11801.0       2829.0        4469.0        4.17x        2.64x
absent        2048      19874.0       4557.0        7389.0        4.36x        2.69x

The result verified his report.

Then, with LLM assistance, I optimized all string kfuncs with
word-at-a-time, include bpf_strnstr(). And, re-ran the microbench:

taskset -c 1 ./bpf_swar_benchmark
BPF HTTP Host search benchmark
kernel=7.2.0-rc4-00667-g707cce56283d arch=amd64 repeat=100000 trials=9 warmup=1000

Scenario     Bytes   Byte ns/op   SWAR ns/op   Kfunc ns/op SWAR speedup Kfunc speedup
first           64        487.0        245.0         261.0        1.99x        1.87x
middle         512       2827.0        781.0         352.0        3.62x        8.03x
late          1536      12127.0       2822.0         708.0        4.30x       17.13x
absent        2048      20463.0       4548.0         982.0        4.50x       20.84x

The optimized bpf_strnstr() kfunc was 10x faster than the original
bpf_strnstr() kfunc.

Next, I (LLM) implemented the benchmarks for the 4 kinds of string kfuncs:

cd tools/testing/selftests/bpf
bash ./benchs/run_bench_bpf_str_kfuncs.sh
BPF string kfunc benchmark comparison
baseline kernel=7.2.0-rc4-00661-g4748a67f7111 arch=x86_64 repeat=100000 trials=9 warmup=1000
current  kernel=7.2.0-rc4-00671-g239632cc49ee arch=x86_64 repeat=100000 trials=9 warmup=1000

scan (bpf_strnchr)
Scenario  Bytes  Baseline ns/op  Current ns/op   Speedup
first        64           174.0          179.0     0.97x
middle      512           489.0          241.0     2.03x
late       1536          1706.0          506.0     3.37x
absent     2048          2781.0          727.0     3.83x

comparison (bpf_strcmp)
Scenario  Bytes  Baseline ns/op  Current ns/op   Speedup
first        64           186.0          189.0     0.98x
middle      512           614.0          238.0     2.58x
late       1536          2234.0          458.0     4.88x
equal      2048          3663.0          634.0     5.78x

span (bpf_strcspn)
Scenario  Bytes  Baseline ns/op  Current ns/op   Speedup
first        64           179.0          195.0     0.92x
middle      512          1047.0          266.0     3.94x
late       1536          4489.0          482.0     9.31x
absent     2048          7468.0          661.0    11.30x

substring (bpf_strnstr)
Scenario  Bytes  Baseline ns/op  Current ns/op   Speedup
first        64           277.0          218.0     1.27x
middle      512          1115.0          296.0     3.77x
late       1536          4427.0          613.0     7.22x
absent     2048          7261.0          854.0     8.50x

The optimized kfuncs win most of the benchmarks.

For the implementation details, pls look into the first 4 patches.

The checkpatch.pl reports
"WARNING: Macros with flow control statements should be avoided" about
those two macros. I will address it in the next revision.

Links:
[1] https://github.com/jschwinger233/bpf_swar_benchmark

Leon Hwang (6):
  bpf: Optimize string scan kfuncs
  bpf: Optimize string comparison kfuncs
  bpf: Optimize string span kfuncs
  bpf: Optimize string substring kfuncs
  selftests/bpf: Exercise word-at-a-time string kfuncs
  selftests/bpf: Benchmark string kfuncs

 kernel/bpf/helpers.c                          | 557 +++++++++++++-----
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |  11 +
 tools/testing/selftests/bpf/bench.h           |   2 +
 .../bpf/benchs/bench_bpf_str_kfuncs.c         | 228 +++++++
 .../bpf/benchs/run_bench_bpf_str_kfuncs.sh    |  98 +++
 .../bpf/progs/bpf_str_kfuncs_bench.c          |  48 ++
 .../bpf/progs/string_kfuncs_failure1.c        |  58 ++
 .../bpf/progs/string_kfuncs_success.c         |  86 +++
 9 files changed, 957 insertions(+), 133 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_str_kfuncs.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_str_kfuncs.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_str_kfuncs_bench.c

--
2.55.0

Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6A37AA92
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948695; cv=none; b=FWdhRu/7PGnqqOI3+X5yKWdt7y31F0SOByE28BU6PZ7JftvysA5aGOLl1kpA0pn2+HMec5saRsH3uyfKwwmJ8uvRWE7sKPaT3IOcOSMjDop93fR7thSEK8+o1SEUZzZrQnwhnkPLEtTsWgFEI/hpcxPXMShFouKJ2uS6dIzUw1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948695; c=relaxed/simple;
	bh=273XCrzmAdbCT89p9Ch08I6IsbJHTHk266OvP2ce1h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8QAFSPfICZlr9NxuLneYrM08jq1CEHPUu0SyXwyttxMxv7PWqW/eaELu30bjkc4ptyguhysTsK05SNW78VH6R1srF7jGFIdQR8ZyvIf1k9yBuB+2Dq3yUyf6vbiww65BJBlApIrEd0N3swFMLJtYxmThX2/6N16xe6ZXwU0R9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pCitqSgA; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pCitqSgA"
Message-ID: <b1825aab-b1d2-40c4-a74c-bb05ce50327d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785948690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpcBlsFzi4+7YT+H0jx3YNPc4qypxBr5/eqR94FR2YE=;
	b=pCitqSgA9Xtw97JhC3Y/0oWPfkxXS2AQgmtk0CGcym3yQ6YC78edeAkHjUh7Rc9KW5mS0a
	cpb8g9zIkVGN2/h+a5IMSSGHBXbSalu3if1sbcWdEcaGv3R10/5qMZaSoCP30chJd5BB5F
	fybZDNA9SbshMMiRngLiZIyn8VrjNHQ=
Date: Thu, 6 Aug 2026 00:51:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/3] bpf: Allow selected kfuncs under
 bpf_spin_lock
To: Kaitao Cheng <kaitao.cheng@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805153340.34776-1-kaitao.cheng@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260805153340.34776-1-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/8/5 23:33, Kaitao Cheng wrote:
> The verifier currently has a hard-coded allowlist of kfuncs that may be
> called while a BPF program holds a bpf_spin_lock. This works for the
> small set of built-in kfuncs known to the verifier, but it does not give
> kfunc providers a registration-time way to declare that a kfunc is safe
> in such a region. In particular, module kfuncs cannot be added to that
> allowlist without changing verifier code.
> 
> This series adds a new KF_SPINLOCK_SAFE kfunc flag and teaches the
> verifier to use kfunc registration metadata when deciding whether a
> kfunc call is allowed while a bpf_spin_lock is held.
> 
> The built-in kfuncs that are currently accepted by the verifier's
> lock-held allowlist are annotated with the new flag. This preserves the
> existing behavior while removing the verifier-side category checks and
> uses the same mechanism for built-in and module kfuncs.
> 
> The selftest coverage marks one bpf_testmod kfunc as KF_SPINLOCK_SAFE
> and verifies that it can be called under a bpf_spin_lock. It also calls
> another registered but unmarked bpf_testmod kfunc under the lock and
> checks that the verifier rejects it.
> 
> Changes in v2:
> - Rename KF_SPIN_LOCK to KF_SPINLOCK_SAFE. (Kumar Kartikeya Dwivedi,
>   Leon Hwang)
> - Deprecate the verifier's lock-held allowlist mechanism and annotate the
>   relevant kfuncs uniformly with KF_SPINLOCK_SAFE (Kumar Kartikeya Dwivedi)
> - Add selftests. (Leon Hwang)
> 
> Link to v1:
> https://lore.kernel.org/bpf/DKG0YUDSTBUY.1X220287HT9V3@gmail.com/
> 
> Kaitao Cheng (3):
>   bpf: Add KF_SPINLOCK_SAFE flag for kfuncs under bpf_spin_lock
>   bpf: Mark existing lock-safe kfuncs with KF_SPINLOCK_SAFE
>   selftests/bpf: Test module kfunc calls under spin lock
> 
>  include/linux/btf.h                           |  1 +
>  kernel/bpf/arena.c                            |  6 +-
>  kernel/bpf/helpers.c                          | 56 ++++++++++---------
>  kernel/bpf/rqspinlock.c                       |  8 +--
>  kernel/bpf/verifier.c                         | 38 +++----------
>  .../selftests/bpf/prog_tests/kfunc_call.c     |  2 +
>  .../selftests/bpf/progs/kfunc_call_fail.c     | 12 ++++
>  .../selftests/bpf/progs/kfunc_call_test.c     | 12 ++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |  2 +-
>  9 files changed, 72 insertions(+), 65 deletions(-)
> 


Nice to drop those 'is_*_kfunc()' helpers in verifier.

BTW, some of those kfuncs can be dropped from the special_kfunc_list.
That would be better.

Any way, this series looks good to me.

Acked-by: Leon Hwang <leon.hwang@linux.dev>


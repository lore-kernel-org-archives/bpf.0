Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075C839FCBC
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337260; cv=none; b=RhkhJDoiuFllQ+5moh+5DtD5kzEy5iYu1PeH1HFj3Qi00CWsoc/Ar8GKlu2OJwGTruD2pMIuo6z5dRlBXjiCUd25ILmMK8xcMG86Ubf68P389KOhpH+I0/TibgAHEQPfOsTKGPxu3lxBIbVsi3owL8s4vea1fGvXmGm9PcSuTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337260; c=relaxed/simple;
	bh=ZpivS+YZKOUrVYbGq1hapR1nin4EHd3Kt7Lzfc+LuzE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fQ2r+XMHj2IGutPGgqsVYaXIPV1WWsr50K1VFixIQrM+gcW4DvzrT93W5uoOTzhGhX2tRo41OWKi9Q1hP7NmX7hSS23F+BtfFrpCEF9qGPXDcreiMqDoIoc6UxEqox2NhGe6f5CgXtqOFnrunGFmbJRiKoP5lWLgABzoKRaVfNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBM7nnKh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBM7nnKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD641F00A3A;
	Wed,  2 Sep 2026 08:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788337258;
	bh=RgX/KogHDyiHDbY0VZWEhHfcsW2GROViWXVhqkB/dGE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OBM7nnKhgm4mDdWTJ74HX/QNTaL7AnwRZMx4zmSiXO/zi4+y6jqcyQ9bTailt9uUZ
	 FhKaQCjJS2uiajR5aPq7xYKajDIgT5zIQm0zdQD18Ysjyj3GvtJCGXf/3MLP4osM4y
	 LWKaDBLB3vDIcVlQqQVWny9Sa7rS4DXlS84FJGrQtBm25+HTerhJ9k22GTPfLzCTBK
	 JHxidOiSJ/WLJSLVlyNmuxCQ7bXFNMa1dLFbjSKT6GFXHym65+WYujZcLHd0p5laYQ
	 e7UniVU069qAHSPL2EISm2PbyRgw7/onKnJ2OStQg7ZbZ4ZkcLUc0ZHAf1EIETFnW6
	 dlYnd/WRSJcOw==
Content-Type: multipart/mixed; boundary="===============7656497724204217346=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7c6c45d657c2f3fea405b5f418796ce0e5e5a45ff76aa1dde17c70ba8357acd3@mail.kernel.org>
In-Reply-To: <20260902070239.16968-6-emil@etsalapatis.com>
References: <20260902070239.16968-6-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Add arena allocation race tests
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,nickolay.lysenko@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  2 Sep 2026 08:20:57 +0000 (UTC)

--===============7656497724204217346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_race.c b/tools/testing/selftests/bpf/prog_tests/arena_race.c
> new file mode 100644
> index 0000000000000..c3a2a4397315a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_race.c

[ ... ]

> +static void test_free_before_flush(bool deferred)
> +{
> +	struct free_thread_ctx ctx = {};
> +	struct arena_race *skel;
> +	pthread_t thread;
> +	__u64 *addr;
> +	bool thread_created = false, flush_seen = false, completed = false;
> +	int err;

[ ... ]

> +release:
> +	skel->bss->release = 1;
> +	if (thread_created) {
> +		ASSERT_OK(pthread_join(thread, NULL), "pthread_join");
> +		thread_created = false;

[ ... ]

> +out:
> +
> +	if (thread_created)
> +		pthread_join(thread, NULL);
> +
> +	arena_race__destroy(skel);
> +}

This isn't a bug, but could the join at the out: label be dropped? On both
paths reaching out: the thread_created flag is already false - the goto
precedes any assignment to thread_created, and the fall-through clears it at
the release: block after joining.

> +/*
> + * Force a race between a faulting thread in userspace and a
> + * free operation on the arena.
> + */
> +static void test_fault_free_realloc(void)
> +{
> +	struct fault_thread_ctx fault = {};
> +	struct arena_race *skel;
> +	pthread_t fault_thread;
> +	bool fault_created = false;
> +	__u64 *addr;
> +	__u64 expected, value;
> +	int err, i;

[ ... ]

> +	fault.addr = addr;
> +	err = pthread_create(&fault_thread, NULL, fault_reader_thread, &fault);
> +	if (!ASSERT_OK(err, "pthread_create_fault"))
> +		goto out;
> +	fault_created = true;
> +
> +	for (i = 0; i < 1000 && !READ_ONCE(fault.stop); i++) {

This isn't a bug, but was fault_reader_thread() meant to set fault.stop on
some condition (e.g. an unexpected value)? As written nothing but this thread
writes fault.stop, so the loop guard is always true.

> +		LIBBPF_OPTS(bpf_test_run_opts, opts);
> +
> +		err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.free_page),
> +					     &opts);
> +		if (err) {
> +			ASSERT_OK(err, "free_realloc");
> +			break;
> +		}
> +		if (opts.retval) {
> +			ASSERT_OK(opts.retval, "free_realloc");
> +			break;
> +		}
> +		value = *addr;
> +		expected = skel->bss->current_marker;
> +		if (value != expected) {
> +			ASSERT_EQ(value, expected, "marker_after_realloc");
> +			break;
> +		}
> +	}
> +
> +	WRITE_ONCE(fault.stop, 1);
> +	if (fault_created) {
> +		ASSERT_OK(pthread_join(fault_thread, NULL), "pthread_join_fault");
> +		fault_created = false;
> +	}
> +	ASSERT_GE(i, 1, "race_iterations");

This isn't a bug, but is race_iterations meant to assert something stronger,
such as that at least one iteration observed the free/realloc race? As
written i is 1000 on the normal path and 0 only when another assertion has
already failed.

> +out:
> +	WRITE_ONCE(fault.stop, 1);
> +	if (fault_created)
> +		pthread_join(fault_thread, NULL);
> +	arena_race__destroy(skel);
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/arena_race.c b/tools/testing/selftests/bpf/progs/arena_race.c
> new file mode 100644
> index 0000000000000..df5b54ef5b4c0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_race.c

[ ... ]

> +void __arena *ptr;
> +void __arena *realloc_ptr;
> +bool realloc_after_free;
> +int free_started;
> +__u64 current_marker;

[ ... ]

> +SEC("syscall")
> +int free_page(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) || defined(BPF_ARENA_FORCE_ASM)
> +	__u64 __arena *p;
> +	__u64 marker;
> +
> +	if (!ptr)
> +		return 1;
> +	free_started = 1;
> +	bpf_arena_free_pages(&arena, ptr, 1);

This isn't a bug, but is free_started still needed? Nothing in the BPF
object or the userspace test appears to read it - could it be dropped?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33603499110
--===============7656497724204217346==--

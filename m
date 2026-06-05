Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34722D4D3
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 00:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619920; cv=none; b=NSa/sfJJVhxBj1wZtI24sKPpxUV3ULxhyDvGzdd/x5i1d9YSVFpkKdRrAvTuywmuNOZFBIYWiruR4Qkdxm36Yun1Qstk+j+IAmQC4fsdkwo3sQ601If/t2Vgq7VcpF2+Sf7Sw1fUqRoH5acDutNVNhJxy+IG6hTZRjkbJJM6EIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619920; c=relaxed/simple;
	bh=sUazo5DyXA6eEg93cED07vzNEeAJG4ESF8K2yfQntF8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jPsvUb8v4+eIcIPWhUVn8k+Cg8TFvydqZEYYkBaVj7ZhsbISNqCX2+J/6uIgud1q4Hfi6RrOE3/vqIM5jzzp2uEhmyrSN8fjLLlPX+8QZAVXR9b17jG9Qr+h9VW88t4BtquW4iYrCsfjSSQ+ZSpKABWuMlggDyIGQGmC733fljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfEDkgTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfEDkgTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4FE1F00893;
	Fri,  5 Jun 2026 00:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619918;
	bh=ZHPDFyEE8M0j00IrOr3+YcU8YOmc2/RqgrM8y8QkjX4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UfEDkgTwnL97JaFv2gcLRrwhlgmV2/4Oec44LCffL5O8SsnKDHIkMJWLtRrwommuK
	 w6uF9pePQKTSYq4DkkEw0thl3OjXQz4YbF8TbilN1FiI2+bk6QS+hQxx6fX/C45UV9
	 pujwqUWEhH77Uw/83Xnea7g/UzAW/oJ3jYhvc+0zur6mDakK4wrHuXhmouzbI+MyA2
	 ld0J9lnCdbUdgwAlHv43SpF0WK98Oh841cxDMY/aHO7U1Mm0t7RI97Peh53EXiUEWZ
	 LXS+EmBK2bH2SOWI29ZKzmEBRQ168Dc10O6EHkXULLl7EjBZbdk7lR2LYGbtFl6MIm
	 OVE7Ua3IDkwSQ==
Content-Type: multipart/mixed; boundary="===============5675909450651003500=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <90ba98c6cff57d1988a982b31c1b92db6633a7299a50106b4bf2cc84583f6e89@mail.kernel.org>
In-Reply-To: <20260604235016.20856-4-emil@etsalapatis.com>
References: <20260604235016.20856-4-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: libarena: parallel test harness and spmc parallel selftest
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 00:38:37 +0000 (UTC)

--===============5675909450651003500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
> new file mode 100644
> index 000000000000..a703479f478f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c

[ ... ]

> @@ -0,0 +1,664 @@

[ ... ]

> +static int spmc_singleval_owner(void)
> +{
> +	int ret;
> +	u64 i;
> +
> +	for (i = zero; i < TEST_SPMC_SINGLEVAL_ITERS && can_loop; i++) {
> +		ret = spmc_quiesce_on_stealer(i);
> +		if (ret)
> +			goto err;
> +
> +		ret = spmc_owned_add(spmc, i);
> +		if (ret)
> +			goto err;
> +
> +		__sync_fetch_and_add(&owner_epoch, 1);
> +
> +		spmc_singleval_tryconsume(i, false);

Does the owner thread need to validate the return value here?
spmc_singleval_tryconsume() can return -EINVAL when it encounters a
mismatched value indicating data corruption, but the function returns this
error without automatically setting the test_abort flag. The stealer thread
at spmc_singleval_stealer() correctly validates this return value, but the
owner thread ignores it, which may allow the benchmark to continue in a
corrupted state. Should the owner thread check for errors from
spmc_singleval_tryconsume() to prevent the benchmark from continuing if data
corruption is detected?

> +
> +		ret = spmc_quiesce_on_stealer(i + 1);
> +		if (ret)
> +			goto err;
> +	}

[ ... ]

> +static int spmc_resize_stealer(void)
> +{
> +	u64 val;
> +	int ret;
> +
> +	arena_subprog_init();
> +
> +	ret = spmc_quiesce_on_owner(1);
> +	if (ret)
> +		return ret;
> +
> +	__sync_fetch_and_add(&stealers_started, 1);
> +
> +	while (can_loop) {
> +		spmc_waste_time();
> +		if (test_abort)
> +			return -EINTR;
> +
> +		ret = spmc_steal(spmc, &val);
> +		if (!ret) {
> +			ret = spmc_update_stats(val, false);
> +			if (ret)
> +				return ret;
> +			continue;
> +		}
> +
> +		if (ret == -EAGAIN)
> +			continue;
> +
> +		/* Only break if this was the last resize. */
> +		if (ret == -ENOENT) {
> +			if (READ_ONCE(owner_epoch) >= 2)
> +				break;

Is there a Time-Of-Check to Time-Of-Use race condition here? If
spmc_steal() returns -ENOENT, the thread evaluates owner_epoch. However, if
the thread is preempted after spmc_steal() finds the queue empty, the owner
could add its remaining items and update owner_epoch to 2. When the stealer
resumes, it will read owner_epoch >= 2 and break the loop, leaving newly
added items unconsumed.

Should the stealer re-verify the queue state after observing the epoch
change?

> +			continue;
> +		}
> +
> +		test_abort = true;
> +		return ret;
> +	}

[ ... ]

> +__weak int
> +spmc_burst_owner_round(u64 round)
> +{
> +	u64 i, base, stolen, expected, val;
> +	int ret;
> +
> +	base = round * TEST_SPMC_BURST_BURST;
> +	round_steals = 0;
> +
> +	for (i = zero; i < TEST_SPMC_BURST_BURST && can_loop; i++) {
> +		ret = spmc_owned_add(spmc, base + i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	__sync_fetch_and_add(&owner_epoch, 1);
> +
> +	ret = spmc_wait_for_round_steals(TEST_SPMC_BURST_STEAL_TARGET);
> +	if (ret == -EINTR)
> +		return ret;

Should this check handle -ETIMEDOUT as well? If the stealers are too slow,
spmc_wait_for_round_steals() returns -ETIMEDOUT and sets the global
test_abort flag. Because this check only explicitly looks for -EINTR, the
owner will fall through on -ETIMEDOUT, incorrectly increment owner_epoch,
and initiate another wait, which may mask the failure root cause. Would it
be clearer to handle -ETIMEDOUT explicitly to properly catch the failure?

> +
> +	__sync_fetch_and_add(&owner_epoch, 1);

[ ... ]

> +__weak
> +int spmc_wait_for_steals(u64 target)
> +{
> +	u64 i;
> +
> +	bpf_for(i, 0, TEST_SPMC_SYNC_SPINS) {
> +		if (test_abort)
> +			return -EINTR;
> +		if (READ_ONCE(steals) >= target)
> +			return 0;
> +	}
> +
> +	test_abort = true;
> +
> +	return -ETIMEDOUT;
> +}

Is this function needed? It appears spmc_wait_for_steals() is fully defined
but never called anywhere in the test file.

> diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/testing/selftests/bpf/prog_tests/libarena.c
> index 81bdb084c271..03348a95fb5c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libarena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libarena.c

[ ... ]

> +static void *run_libarena_parallel_prog(void *arg)
> +{
> +	struct bpf_program *prog = arg;
> +
> +	return (void *)(long)libarena_run_prog(bpf_program__fd(prog));
> +}

Does this need file descriptor validation for the BPF program? The FD
extracted from the manually looked-up program is used without validation.
According to the BPF selftests subsystem guidelines, manual lookup APIs like
bpf_object__find_program_by_name() can return a valid bpf_program pointer
even if the program failed to load, which results in a negative FD. Should
there be an explicit file descriptor validation (such as ASSERT_GE) before
using the FD to prevent passing a negative FD?

[ ... ]

> +static int run_libarena_parallel_fini(struct libarena *skel, const char *name,
> +				      size_t prefixlen)
> +{
> +	char tdname[MAX_PARTEST_NAME];
> +	struct bpf_program *fini_prog;
> +	int ret;
> +
> +	ret = snprintf(tdname, sizeof(tdname), "%.*s__fini", (int)prefixlen, name);
> +	if (!ASSERT_LT(ret, sizeof(tdname), "partest fini name"))
> +		return -ENAMETOOLONG;
> +
> +	fini_prog = bpf_object__find_program_by_name(skel->obj, tdname);
> +	if (!ASSERT_TRUE(fini_prog, "partest fini prog"))
> +		return -ENOENT;
> +
> +	ret = libarena_run_prog(bpf_program__fd(fini_prog));

Does this pass an unverified file descriptor to libarena_run_prog()?
According to the BPF selftests subsystem guidelines, manual lookup APIs like
bpf_object__find_program_by_name() can return a valid bpf_program pointer
even if the program failed to load, which results in a negative FD. Should
there be an explicit file descriptor validation (such as ASSERT_GE) before
using the FD?

> +	ASSERT_OK(ret, tdname);
> +
> +	return ret;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26987200618
--===============5675909450651003500==--

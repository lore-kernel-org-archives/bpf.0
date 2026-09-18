Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3966D547052
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719194; cv=none; b=Of0Z3X5kCx3IWJeIcfkxAZdmAoshN051OK2mvKCbUMO8N/d3762DsHXYgw1/0g7nRRRZT2i9ZG//3prKiObYCDbCENmDi71AacXzqWa7kXdiFUpfQm7GfMoeOOpmLwGav8ELll7Iv74Dgqz5bNbYwrorgCO3dn9RGhRhLngiavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719194; c=relaxed/simple;
	bh=ZAVjnp5cn2mNeSg8XAzvSxJ6gR2P/N8Y42tWR37hjNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nMXt7vHfi7M85soHfTpeksWTV6hohjDFTijJvmzYbAasih9qLvADvKvKjO8COmntqfU5Yhy7/Br+NJ3O4KROTavCq8epzuhm3IprIUF0k0TEoeSzhUgnU9Dxh5IS63Sp5VtCf5BXn6eyI4kGOFNSw8Q4+v4/5zVJedAH1lDx4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8mCKyJ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8mCKyJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91F11F000FF;
	Fri, 18 Sep 2026 08:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789719192;
	bh=vvXxmbyiHcCbGPsgm5yJCWb5aR5dDl3EaokkRFgo5nQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c8mCKyJ4o8nHt1tlIMRrpskvyOZq4u93h9JpUFm6iK0H/F1OiY/wf9KLsRvxI6HUC
	 CcJjQRN5HGhm+aLR4M2N2Vi69ooudUTev4pTW7pSKFA8xenbanZqcFI6P8Y84CfzjW
	 A5hAfMiWfibPh5X7Y5sD0z3ozxtY//uVSh0R81+WXFjHSTQsHBRlm9BeQRvqoHJiiG
	 v/ZkNx70KhKRmp2LsD/d2eryvnBIphbYBnqMKf0xcBglBfSW4a3V+xA4VzUI9TbiPI
	 o6S5EUynEbmDEseOSi3SQawwUtMHIGDg1KO4Uv9uqmOvOtRVTDPtCAKX5fqVenWqSf
	 avTMmf/ZrJhYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add task work round
 ownership race test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Lu" <luyun_611@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918080014.54012-3-luyun_611@163.com>
References: <20260918080014.54012-1-luyun_611@163.com>
 <20260918080014.54012-3-luyun_611@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:13:12 +0000
Message-Id: <20260918081312.A91F11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] bpf: spurious -ENOENT test failure due to unhandled early delete=
 race
- [Medium] bpf: missing memory barriers cause stale error state reads in ra=
ce test
- [Medium] bpf: TOCTOU race in task_work_race_wait_ready() causes false tes=
t failures
--

commit 6a4b075b19b6a65e88e8c41b961bca6ee7533e52
Author: Yun Lu <luyun@kylinos.cn>

selftests/bpf: Add task work round ownership race test

Exercise task-work scheduling, callback completion and map-value deletion
on separate execution contexts.  Rotate through ctx reuse, deletion
after the callback body, and deletion immediately before the scheduling
kfunc.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/to=
ols/testing/selftests/bpf/prog_tests/test_task_work.c
> index 774b31a5f6ca1..6d5e1e97aa3af 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
[ ... ]
> +static int task_work_race_wait_ready(struct task_work_race *skel, __u32 =
seq)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < 2000000 / 100; i++) {
> +		__s64 value =3D 0;
> +
> +		if (!task_work_race_status(skel, RACE_READY_SEQ, &value) &&
> +		    value =3D=3D seq)
> +			return 0;
> +		if (!task_work_race_status(skel, RACE_DONE_SEQ, &value) &&
> +		    value =3D=3D seq)
> +			return -EIO;

[Severity: Medium]
Could this sequential checking lead to a false negative?

If the concurrent BPF program finishes execution exactly between these two
syscalls, the thread will see RACE_READY_SEQ as false from the first read
and RACE_DONE_SEQ as true from the second read, returning -EIO.=20

If the BPF program had finished before the first check, it would have read
RACE_READY_SEQ =3D=3D seq and correctly returned 0. Can this time-of-check =
to
time-of-use interleaving incorrectly penalize a fast BPF execution as an
error?

> +		usleep(100);
> +	}
> +	return -ETIMEDOUT;
> +}
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/task_work_race.c b/tools/t=
esting/selftests/bpf/progs/task_work_race.c
> new file mode 100644
> index 0000000000000..8d3f31fb075f8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/task_work_race.c
[ ... ]
> +SEC("tracepoint/syscalls/sys_enter_getppid")
> +int race_sched_work(void *ctx)
> +{
[ ... ]
> +	key =3D 0;
> +	work =3D bpf_map_lookup_elem(&hmap, &key);
> +	if (!work) {
> +		err =3D -ENOENT;
> +		goto out_task;
> +	}
> +
> +	work->seq =3D seq;
> +	set_status(RACE_READY_SEQ, seq);
> +	err =3D bpf_task_work_schedule_signal(task, &work->tw, &hmap,
> +					    process_work);
> +	if (err =3D=3D -EBUSY) {
> +		bpf_task_release(task);
> +		return 0;
> +	}

[Severity: Medium]
When variant 2 is tested, userspace deliberately races to delete the map
element early. If this early delete wins the race against the scheduling
kfunc above, bpf_task_work_schedule_signal() returns -EBUSY.=20

This causes the BPF program to return 0, triggering a retry. On the next
tracepoint invocation, looking up the now-deleted element fails with -ENOEN=
T.=20

Because userspace expects a successful schedule (err =3D=3D 0) in
task_work_race_check_done(), the test will fail when it observes -ENOENT.
Should the test be updated to handle this expected -ENOENT outcome, or
should the BPF program avoid retrying when the element is permanently
deleted?

> +
> +out_task:
> +	bpf_task_release(task);
> +out_done:
> +	set_status(RACE_SCHED_ERR, err);
> +	set_status(RACE_DONE_SEQ, seq);

[Severity: Medium]
Does this code sequence need a write memory barrier?

On weakly-ordered architectures like ARM64, the CPU can reorder these
independent stores because the BPF JIT does not emit barrier instructions
for array map stores.

If userspace polls RACE_DONE_SEQ and observes the update before
RACE_SCHED_ERR is globally visible, it might read a stale error code=20
(e.g., 0 instead of the actual error) and potentially mask failures.

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918080014.5401=
2-1-luyun_611@163.com?part=3D2

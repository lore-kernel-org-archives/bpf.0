Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3694D351C22
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825770; cv=none; b=iw9SW6xLzM4Y3GT1J+4UVZypDWEie1FURcPkB1h0rnv6whB0aIuDOnWF3l07vw5jEOVe8bQOs47Z1pD1jz6exSsVJs4sXbHzNFnpsULcn/apPs0n9jhrxFH/rtD0MK4DqP4wxakCTSqiq7KPao3ic1AbMp0/kKOmssOHhR2arkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825770; c=relaxed/simple;
	bh=JS9iWa+XFX2Xp4Q++QaBeH965zYSThsLECeUQKDp/PM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c3zze5VdxHQaEJ43ajnuwnaqELX4kvmJC2dvWu8KZKjQkZtnSevqK0sSE7UFja8azVOKPT6oZqnJ4l58j352OyU+an6BzNyDoX0Y77X8nzyovb88kSVGtp3fPoRpdaBqVc9lUPO5ZmwSd5wQKvnKw0FQXGs2kaLBvFo8hmrDv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoBwM+ke; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoBwM+ke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AB1C2BCB0;
	Fri, 15 May 2026 06:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778825769;
	bh=JS9iWa+XFX2Xp4Q++QaBeH965zYSThsLECeUQKDp/PM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YoBwM+keQYjgPb8iCJKYQMnXh/uT2KdcTpCOTsv6Uukibg8FPHIb4ojGm/eQ46pb8
	 mrYFHRqoE70Ua5KBvAVZkStn4FR0KGE6ObxmP4ZSNSptbsMU6Xxx0Io3SoegNNst+U
	 EIiMBEfpm0JX42k/nW+SvRf8/zwyssbiZthppovGAwoU4e4R3Hl2do6zTQbCdmC4Y/
	 0BXDeGeRCYsPBm3skDH7AD3OGMM9ss6PDdgyjdgT4hblmP9B+/vtZricinduOQETX3
	 6u1G6r4FSLUpdjH+KFgrGvoMxrnLezUx3d8t4tojxlLog1piLKcqK5x/UBJFkNbtMm
	 qJrTEZMIdRRaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 18/25] selftests/bpf: Add tests for BPF
 function stack arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513045127.2397187-1-yonghong.song@linux.dev>
References: <20260513045127.2397187-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 06:16:09 +0000
Message-Id: <20260515061609.B8AB1C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test `test_async_cb_many` uses a hardcoded `usleep(50)` to w=
ait for an asynchronous BPF timer to execute, which is prone to race condit=
ions and flakiness on loaded CI systems.
--

commit 12812727f17076398fed8cfc802771db232582f8
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add tests for BPF function stack arguments

This commit adds selftests for stack argument passing in BPF-to-BPF subprog
and kfunc calls with more than 5 arguments. It covers scalar, pointer, mixe=
d,
dynptr, memory buffer, iterator, const string, and timer pointers.

> diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg.c b/tools/t=
esting/selftests/bpf/prog_tests/stack_arg.c
> new file mode 100644
> index 0000000000000..d61bac33f8092
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/stack_arg.c
[ ... ]
> +static void test_async_cb_many(void)
> +{
[ ... ]
> +	run_subtest(skel->progs.test_async_cb_many_args, 0);
> +
> +	/* Wait for the timer callback to fire and verify the result.
> +	 * 10+20+30+40+50+60+70+80 =3D 360
> +	 */
> +	usleep(50);

Could this short sleep lead to flaky test failures on loaded CI systems?

Timer callbacks are executed in softirq context, and under load, scheduling
delays could easily exceed 50 microseconds. This might cause the test proce=
ss
to wake up and read timer_result before the callback has actually executed.

Would a polling loop with a reasonable timeout be more reliable here?

> +	ASSERT_EQ(skel->bss->timer_result, 360, "timer_result");
> +
> +out:
> +	stack_arg__destroy(skel);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513044949.2382=
019-1-yonghong.song@linux.dev?part=3D18

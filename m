Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793587482;
	b=xI26ttQyx1M/r0nEMpWXojf2zGZtMg5xMbobavvnYWeadSGstdMLIZb9RuP+Gu6UIQh7
	 hfhFQwhKMK5ZKU64PCepcltqvr3jv7ciy0vsxV+6n8NFGYkrVCWPI7zN4l3+wzTK1rZC2
	 GsAVXcsl7eD6fS+VLRzH942Eff2gI6WSGqAJX7UBMl+ls48E4EUfgqI5sFW3zkSr6uCyb
	 q/tMY8/uHKhcIGhSECgHe7jn3/2y2GLsvHrfLI2w/yxvTK/EUO2KSeCIJ+k06mmUzhjZB
	 cIzX5b0NIWp+0vvsr2gePC0B6whwsjcefRKPL6sTqiBoQ5J0/V1eaxmceDJ7dN+vgTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793587482;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TNgDNizRPpt3SatVCM2Ul5Nl7OsXMoWz+P3HPILo438=;
	b=B5oa6Am+9aLfrGYgVBOj4DdCxrpvf7XmRTI8jzPaacRJIFqsYSUPhCn04uW2J9K46e/8
	 QiQ6u1mvSXksLK9CLZ8NkSnE63+zN1QW3kDxkNR2OPPPgh8HBVkjyrpXWcoTAFHctD8+W
	 dtZEvp2vAEYenWSsE73hSG8e9BCH4C4NAI8BnoYHaMMMfoDhAY8tZgRYf1XvZJPEmX/zW
	 12Xg70MWaJEPVw9qnNER6Pfp++Wh5/SxYeAOgbINYlVMBy0t9pm4tF/Tq10S0MsZeegmX
	 klxknBiyvfYXawCP1ByclPcFjCfw3d4bWJERDygR+eaCEwmhNv2wQ5qI2FC7xvhPl4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emUChDjf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A215606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emUChDjf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B6F1F000C1;
	Mon,  2 Nov 2026 02:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793587482;
	bh=TNgDNizRPpt3SatVCM2Ul5Nl7OsXMoWz+P3HPILo438=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=emUChDjfiBEj/e/9g3kz1kx2bEtetHtQ4dkUC+35XR8cIUybTGiAmeSnrX8de4bEh
	 hT1+0H0z9O4gdst3K51kqpZNRNDYtat71PDQW+6zEaUUOOY8ltEt4FthGRSYmg3s0u
	 OCdlEJ5xPTCboUsWDL798uMHaDV7mgz1s/79D8McP2jgI8SnkAwIC/yAOhJzHlzuUA
	 q8uoMvZG4XzQSNCQyszKEcZeMoJnXQmjA5Hmv6yLGwPxzR6jeGiArrZsDlTfl9z/ha
	 xbR7+hXA5vHvBzIFGVw9RjrvdDsZisrdiXBoURVeP9Cl9CyJ84G/FwnzTk7Mm9xB5x
	 k1cl+A8bh3SMQ==
Message-ID: <sashiko-outbox-192845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Wait for wq callback before
 checking ok_sleepable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jonathan Bastari Thamrin" <thamrinjonathan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261102-wq-poll-fix-v2-1-48b7d12815b8@gmail.com>
References: <20261102-wq-poll-fix-v2-1-48b7d12815b8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 02:44:41 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: missing error jump before spin loop in serial_tes=
t_wq()
--

commit b67542c75142d5bd693ad5ed6fa8a0252549f42f
Author: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

selftests/bpf: Wait for wq callback before checking ok_sleepable

This commit replaces the 50us sleep in serial_test_wq() with a spin loop
waiting for a wq_cb_run counter to be incremented by wq_cb_sleepable()
before checking ok_sleepable.

Link: https://github.com/kernel-patches/vmtest/issues/455

> diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/=
selftests/bpf/prog_tests/wq.c
> index 97926e35aaf26..95ed4b69c0f50 100644
> --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> +++ b/tools/testing/selftests/bpf/prog_tests/wq.c
> @@ -28,8 +28,9 @@ void serial_test_wq(void)
>  	ASSERT_OK(err, "test_run");
>  	ASSERT_EQ(topts.retval, 0, "test_run");
> =20
> -	usleep(50); /* 10 usecs should be enough, but give it extra */
> -
> +	/* wait for wq callback to finish */
> +	while (!READ_ONCE(wq_skel->bss->wq_cb_run))
> +		sched_yield();

[Severity: Medium]
Can serial_test_wq() hang indefinitely here if bpf_prog_test_run_opts()
fails or if test_syscall_array_sleepable() -> test_elem_callback() in
tools/testing/selftests/bpf/progs/wq.c returns a non-zero error in
topts.retval before bpf_wq_start() schedules wq_cb_sleepable()?

Since ASSERT_OK() and ASSERT_EQ() only record the failure and evaluate to
false without returning or jumping to clean_up, execution falls through
into the while (!READ_ONCE(wq_skel->bss->wq_cb_run)) loop even when
wq_cb_sleepable() was never queued.

Should the assertions jump to clean_up on failure before entering the wait
loop, for example:

	if (!ASSERT_OK(err, "test_run") ||
	    !ASSERT_EQ(topts.retval, 0, "test_run"))
		goto clean_up;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-wq-poll-fi=
x-v2-1-48b7d12815b8@gmail.com?part=3D1

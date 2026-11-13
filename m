Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794538628;
	b=yizHDQ2ieFn8vnj5zRh4SqVPPxj7aKH6aG+PDt4aVTQ4HK00EJZkLiCdAH4s09sN5jc8
	 op2kmx0mCzvUXzL6l5w8IOvYSNGy7eZ77Z3qT6+h/apSVZeuvVbmTYwpp5NEywZAR+ch6
	 ZJYBmtOE6RPMirzPcKODpIG1VZ1HFO6KgNOJBB/oCkQtNoGGN8Hr1IinkyvrPhDYNgZ+k
	 Aaxbdnditj30xhKyJn9JBdhEEknqa7TFDTL+n67/nuXGPz0d9V5GVRov/ApNKPq3/bHH7
	 WrXQkr5N2ogeDCf+x1yxySWyMER2eczGdjBpFtTnRo3vvsEmOq+gZZA6IeIhuWxuTFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538628;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2RrneKrWhLC6311R741U12D/fvrdtls7uMrysE8oAYs=;
	b=2VfwcULPu5rqFG9g1a+UWnAWroGrVGZDjOA4tk/OMh6/yVdid5gRE2ElChRr48V0ivTy
	 fwzqwrrxpInCACubs34Ss54X9/x2mB7hV2QuxYDqTFYymLdL7uek0i1zcDfnyzwb6Iuf1
	 7kK8/LYgkMC0JiIcTy85vVPwKKLHfmJK24RkAUMVYmS+kfE4WzS+0wtO0ptyJbCB5OxFy
	 hL7hRXKvQK+g9u+hGkm4HiXSOs9eHhn12mP4XbQIOsbPrWKWXa9HdQORkqy7n5LNivs17
	 zh/94RfsJ6jNyjxxiWOAtftS/tpnzjLM9b9G9PyXpk5g7YNYi5RQAZMjOTQGPlVgh/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SmjAJNfe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BEE606A323;
	Fri, 13 Nov 2026 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SmjAJNfe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C7D1F000C7;
	Fri, 13 Nov 2026 02:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794538627;
	bh=2RrneKrWhLC6311R741U12D/fvrdtls7uMrysE8oAYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SmjAJNfeF8LeK6oDMo2qmpBQWVj4a4Poiz7i3xi10wXs0wgBnh+v8JmBWYinj+OI/
	 sXCDxopCcOTG7NbQ4NUzEhaEMCXU6mwxiYylhMamSEF14fOFO/y6eKaDyBos2TEuSp
	 vPRDPrsFCeL3T9wzrI3LAy23VYxS5AGipPF/nj68pzLBaEQetmeHstcIFAMIP//Z2s
	 /Wwv5w80NhsVralJJzdb3P3PI/qQ/HlUuXaSYVt/SESVvyIjK8thEp5hOuddglhYiZ
	 eNZWf+EbHXE3HLl/LDToJgHwoGfx98HPwMW52NutKwN9H2tAdaAcazHlVB1v0KK1p1
	 VWhd5mH3TPz0g==
Message-ID: <sashiko-outbox-212108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext v2 2/2] selftests/sched_ext: check that a
 drained DSQ iterator stays NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kang Chen" <k.chen@smail.nju.edu.cn>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20261113024505.922854-2-k.chen@smail.nju.edu.cn>
References: <20261110125113.2935742-1-k.chen@smail.nju.edu.cn>
 <20261113024505.922854-1-k.chen@smail.nju.edu.cn>
 <20261113024505.922854-2-k.chen@smail.nju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 02:57:06 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] selftests/sched_ext: unconditional overwrite of
  next_after_drain in dequeue_iter_dequeue()
- [Medium] selftests/sched_ext: empty TEST_DSQ_ID in
  dequeue_iter_dequeue() leaves iter_count at 0
--

commit 2125e4ff3cb11bd1e11aff810c77c47f61782533
Author: Kang Chen <k.chen@smail.nju.edu.cn>

selftests/sched_ext: check that a drained DSQ iterator stays NULL

This commit extends the dequeue_iter selftest to verify that calling
bpf_iter_scx_dsq_next() again after a DSQ iterator is drained continues
to return NULL.

> diff --git a/tools/testing/selftests/sched_ext/dequeue_iter.bpf.c b/tools=
/testing/selftests/sched_ext/dequeue_iter.bpf.c
> index 76c2c71a90b61..38eb2df54a6b5 100644
> --- a/tools/testing/selftests/sched_ext/dequeue_iter.bpf.c
> +++ b/tools/testing/selftests/sched_ext/dequeue_iter.bpf.c
> @@ -18,6 +18,8 @@ UEI_DEFINE(uei);
>  #define TEST_DSQ_ID 1000
> =20
>  u64 dq_count;
> +u64 iter_count;
> +u64 next_after_drain =3D -1;
> =20
>  s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_iter_init)
>  {
> @@ -47,7 +49,10 @@ void BPF_STRUCT_OPS(dequeue_iter_dequeue, struct task_=
struct *p, u64 deq_flags)
> =20
>  	if (!bpf_iter_scx_dsq_new(&it, TEST_DSQ_ID, 0)) {
>  		while ((t =3D bpf_iter_scx_dsq_next(&it)))
> -			;
> +			iter_count++;
> +
> +		/* NULL must stay final after the iterator is drained. */
> +		next_after_drain =3D (__u64)bpf_iter_scx_dsq_next(&it);
>  	}
>  	bpf_iter_scx_dsq_destroy(&it);

[Severity: Medium]
Can this assignment overwrite a non-NULL next_after_drain captured by an
earlier dequeue and cause a false pass on an unfixed kernel?

scx_consume_dispatch_q() unlinks the consumed task from TEST_DSQ_ID
before calling ops.dequeue().  If an earlier dequeue saw another task in
TEST_DSQ_ID and recorded a non-NULL task pointer in next_after_drain, any
subsequent dequeue that runs when TEST_DSQ_ID is empty will unconditionally
overwrite next_after_drain with 0.  In addition, iter_count and
next_after_drain are updated with plain stores even though ops.dequeue()
can run concurrently on multiple CPUs after dsq->lock is dropped.

> diff --git a/tools/testing/selftests/sched_ext/dequeue_iter.c b/tools/tes=
ting/selftests/sched_ext/dequeue_iter.c
> index f60711bf3b395..48e8c94b7bf14 100644
> --- a/tools/testing/selftests/sched_ext/dequeue_iter.c
> +++ b/tools/testing/selftests/sched_ext/dequeue_iter.c
> @@ -59,6 +59,10 @@ static enum scx_test_status run(void *ctx)
>  		return SCX_TEST_FAIL;
>  	}
> =20
> +	SCX_FAIL_IF(!skel->bss->iter_count,
> +		    "DSQ iterator drained no tasks");

[Severity: Medium]
Will skel->bss->iter_count stay at 0 on an idle or single-CPU system?

Because scx_consume_dispatch_q() unlinks the task being consumed from
TEST_DSQ_ID and clears SCX_TASK_IN_CUSTODY before invoking
dequeue_iter_dequeue(), bpf_iter_scx_dsq_next() only yields a task if a
second task happens to be queued in TEST_DSQ_ID at the same instant.
run() only drives a single thread calling usleep(100) until dq_count
reaches DQ_TARGET, so if no other task is concurrently queued in
TEST_DSQ_ID during those 10 dequeues, the test fails with "DSQ iterator
drained no tasks".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113024505.9228=
54-1-k.chen@smail.nju.edu.cn?part=3D2

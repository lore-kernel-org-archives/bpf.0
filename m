Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315670;
	b=eylOiPrdTRsL7b8OnGGDdV5PdMyPvSs09awnJ8JxJgXGD4X1NttToXkLzoGkroelCKZI
	 74LJAbWo5vjaq7doi2uWKJ+GrglgMv4CHBCSfhraywO3FYSc9hhUm7Ul2pyUKWCJqqyZY
	 9aBdgy1OkF/Up2OZrGVVxQPj9RwGdcedOslHfnM8dxTu0lefXDvYRVzFBLC5Qlvr5gmhj
	 ZlaG1iQHPk6NsEMTnEJ7izHuCvMved7OnMizh7udWvOFalcvHRI0qhCEP0Xgd4G1M3P1o
	 Tdr6jf2UkR8WqoVpU9Et1vtlBBTC9T6wOskXIW89UQhXOT6jebE+N92Xhc+9Kw/eA8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315670;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6TUsKtfw8LK+ehUFve3c8+TC971fmmWHnjkflx04kRU=;
	b=Q73/EGqAPFcH21NWcMEg7bknHA9o+Fo/uGDJKRwBypIQx5LUquaThMS4nib9SdASIoqf
	 WYGBz/HEfdEbMKZoLM3TibmBe73yBhIq1MwrJmVMu8bOFA1CWWn32ccDOZsx860m6tFoD
	 KoqXR/GzWLuh0oNh458mytrL0rhlmJfASxnshBz6smrHAO+V8ZGyP4RIb6mqVj+jcdGIF
	 VRzWIiHRThA8aTPHlEgjK/1WOFZtbmxoKzC778/QG3IYoIeO+SFQNo3sIqAcTDJ997xRT
	 FeBYOILAKtMnoQvbr7uD5Iu1A08aGyHCSRtzPevqI0ABhQS5GBlZr5lHJapqMCzHfNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Txc+oLsS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225A606A7C2;
	Tue, 10 Nov 2026 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Txc+oLsS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855D21F0089F;
	Tue, 10 Nov 2026 13:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315669;
	bh=6TUsKtfw8LK+ehUFve3c8+TC971fmmWHnjkflx04kRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Txc+oLsSTya5a/uDMzUi9SyNJUdNPjbkWqSzUyNPQLOZdU3Wyhv3kDcxBU+6EOmsa
	 6JYB0dacGUIaHf/v3K0zckowF7XZlnzQoMhxiwcCrYxMoIsTQzXvcoxBfnwM5ZFtcb
	 4p4rMGXoLWBR4w82/jVeiqP4dL3TO+JdVney9yBXmYX5ndLAvfS2ZzHFOtBl+oyQw8
	 Sj1idliO6yT1cNyD0HUDyAWcPYJ+kQp2W1Yx1xoKNdckm0K/aWJtFlM/Y9ERNnbb6q
	 9eImmXMneBJ5erNerVYNpU0BhH5EUlxqUpq6pQiCkGdW/hT9wVDa9GuxkZw9l8KM+p
	 OdgqQeRKkGYsA==
Message-ID: <sashiko-outbox-207066@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: make DSQ iterator stay drained after NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kang Chen" <k.chen@smail.nju.edu.cn>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20261110125113.2935742-1-k.chen@smail.nju.edu.cn>
References: <20261110125113.2935742-1-k.chen@smail.nju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:01:09 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] sched_ext: recursive dsq->lock deadlock via
  bpf_iter_scx_dsq_next() in tracing [1]
--

commit 892356944fb79fb9f40ab2f24779b6976bd4ec25
Author: Kang Chen <k.chen@smail.nju.edu.cn>

sched_ext: make DSQ iterator stay drained after NULL

This commit records a drained flag in the DSQ iterator cursor once
nldsq_cursor_next_task() returns NULL so subsequent calls to
bpf_iter_scx_dsq_next() continue returning NULL.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index ebdf7b91f9d37..f2bfd43d75526 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -11028,13 +11030,24 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf=
_iter_scx_dsq *it, u64 dsq_id,
>  __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_sc=
x_dsq *it)
>  {
>  	struct bpf_iter_scx_dsq_kern *kit =3D (void *)it;
> +	struct task_struct *p;
> =20
> -	if (!kit->dsq)
> +	if (!kit->dsq || (kit->cursor.flags & __SCX_DSQ_ITER_DRAINED))
>  		return NULL;
> =20
>  	guard(raw_spinlock_irqsave)(&kit->dsq->lock);

[Severity: High]
This problem wasn't introduced by this patch, but can bpf_iter_scx_dsq_next=
()
and bpf_iter_scx_dsq_destroy() deadlock [1] on kit->dsq->lock when
called from a BPF tracing program?

The DSQ iterator kfuncs are registered in scx_kfunc_ids_any and are not
listed in scx_kfunc_ids_no_tracing, so scx_kfunc_context_filter() allows
BPF_PROG_TYPE_TRACING programs to call them.  If a tracing program runs
while the current CPU already holds the same user DSQ's lock, iterating that
DSQ attempts to acquire kit->dsq->lock recursively on the same CPU:

scx_dispatch_enqueue()
  raw_spin_lock(&dsq->lock)
  ...
  scx_error()
    trace_sched_ext_exit()
      <BPF tracing prog>
        bpf_iter_scx_dsq_next()
          raw_spin_lock_irqsave(&kit->dsq->lock)  <-- spins forever

Adding the DSQ iterator kfuncs to scx_kfunc_ids_no_tracing would prevent
tracing programs from calling them.

[1] https://sashiko.dev/#/bug/linux-243627bf-8f5e-401e-a2af-0b6c5d9b3088

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110125113.2935=
742-1-k.chen@smail.nju.edu.cn?part=3D1

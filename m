Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795154741;
	b=UXcWsLDlg7LeC/9jJlk5vUdyWzdW67rhRtTlenBNRtFTI60EUrveR/vtpNNn7/1m/UvR
	 e7y7UgyCy0+W8jDkPBJQ9wKF6mdM7m2b/ooQcH19F7VvhQHW6jzswxK/dPiosD+W1vdql
	 iLf7T+OruPqpgt6w3zOooN3qjKoghHoEKwYzNwfhB+eIw8cziUel6R+YZZYy6uGopuMby
	 8RTrsp/71+jHIUkwyH4gDadfWv60LMSyFeLY72jT+zcvpNZO/Jdvpc/lnuHTsxhdQ4ViR
	 hCIjaP7cOUCZjfTDy7tS0sAwG7ksIzmy9sbU1epIVJ3pF7Cxv/YNXzdxviZVeO86abA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154741;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xzpLQ0/Fk6WDe/XCNcT1jw7L0z44FzfTHsAhjF7Wje0=;
	b=FBR8gHwtYGkoLeqefLtPzqysPtsUjaQ9+raWKRFvS3NsuIryZFZ7M15MOE/80NVHV4OK
	 IlYhM3bmT+Aj5UgB35FNGEWmO1zwoRyF94RzfSEOIarbuZ77r9MsyTW0k+dxdlj2FHCvN
	 AZe6PmYbYzxpJkTOq4fJvrY49z70sTUHQcR55plN7ApXvVlA/c1dsKhaIPHFVU25TKZaw
	 24rve7/J4DsJg1DZmuIZBhoeA22XdligwK09LJrY9ofXcjWzAJLRCkJJq9PLck5CIGqah
	 KWScX2LXKf5b5wrbsF7ol29Y5KhDbAWpyE0Fm0d8fdN/EDK/34fcGzeZOyW/vL6CzqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DO+e3lCR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1C606A517;
	Fri, 20 Nov 2026 06:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DO+e3lCR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273D01F000C6;
	Fri, 20 Nov 2026 06:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795154741;
	bh=xzpLQ0/Fk6WDe/XCNcT1jw7L0z44FzfTHsAhjF7Wje0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DO+e3lCR/vy8UjNwOKZho7o3trK8KiqMh1zAvuS14Kc4et3YkHR5Rj9YFI9l9Ayyu
	 CRMU6/ev3Ih2HaW1chS9tabZDJ+V3qfH8KAQC0XY3ryU0vOJBqNRPLutFyF9zcwUwh
	 6jhgk7v/b8b56xfn3qHfn38V41sio8uFZwaFciUqD3fI+ziPAuFLVFUG+W5LAvMA34
	 i8BlZUMm7XT71yCLhaG5W2TO0BN7qcWQE6TetqCaYB3y7ixLlmKUhJBC3sJfknthUL
	 C4etOfG+pQOxouYvyWoG94nbHib/Zu2tYBHf1eKLduv6jxviV7naX5IY0JhL3EJ+Hu
	 l7JNhJ/AyKWeA==
Message-ID: <sashiko-outbox-224532@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: reject oversized dispatch_max_batch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, sched-ext@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20261120054913.3795562-1-rhkrqnwk98@gmail.com>
References: <20261120054913.3795562-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 06:05:40 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] sched_ext: unbraced variable declaration after case in
  bpf_scx_init_member()
--

commit 5d981e883681165123cef4a6b3bfda42fae9cb16
Author: Sechang Lim <rhkrqnwk98@gmail.com>

sched_ext: reject oversized dispatch_max_batch

This commit validates sched_ext_ops.dispatch_max_batch against
PCPU_MIN_UNIT_SIZE in bpf_scx_init_member() so oversized per-CPU dispatch
buffer allocations are rejected with -E2BIG during struct_ops map updates.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index a9e36b5bb0386..1f663a0490068 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -9197,9 +9197,14 @@ static int bpf_scx_init_member(const struct btf_ty=
pe *t,
> =20
>  	switch (moff) {
>  	case offsetof(struct sched_ext_ops, dispatch_max_batch):
> -		if (*(u32 *)(udata + moff) > INT_MAX)
> +		u32 batch =3D *(u32 *)(udata + moff);
> +		u32 nr =3D batch ?: SCX_DSP_DFL_MAX_BATCH;

[Severity: Low]
Should this case body be wrapped in braces like the rescue_bandwidth_ppt
and rescue_quantum_us cases below?  Under -std=3Dgnu11, declaring a variable
immediately after a case label is a C23 extension that fails to build on
supported GCC versions prior to GCC 11 (and Sparse) with "a label can only
be part of a statement and a declaration is not a statement".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120054913.3795=
562-1-rhkrqnwk98@gmail.com?part=3D1

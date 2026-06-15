Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4093E3C5A;
	Mon, 15 Jun 2026 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522750; cv=none; b=G0LweWeuiSFm4bFf0cl7rW5cs+UHJsPN4FC9u6uOLj/it8OBSNAMYUPeK4lRtY1185hC7d4aPLr85AHI0dKGMZqE/FSbo09cU+BZHMqFtXnJFdG1ZL5LXNgK901ollq0GEMqusm99rv9kZhr7UtUfLoj7g74DYWQcfrGGD+SFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522750; c=relaxed/simple;
	bh=jqIm/OTRWHpq1R7LiGnVVBXBqewd1OxVaR0y/VahwNE=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iGWZA3ZYBjAyV+6FqeSIU7wAkbCALN6WQk6zKdKSUvhCIPvo7/ZtcWLEJXrDP6Jd0/HKg0P6Es0s3gTmdEX4uyx3QW58Ypm9cyR4Vetw0fMfJ1xBfgIolRUoTdLTlgryJ2Ov+4qlOCmsdcf1b4ehYM6wfzpGweQvg61izS06eQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhAO7l8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhAO7l8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B7B1F000E9;
	Mon, 15 Jun 2026 11:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781522748;
	bh=xwU/lmEPCwSMwcraYo4LXRTGY9NpSGAExrQprcalm+E=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=OhAO7l8ZQMFUerve51mU6l63EXx1aZePX1sUIsipHC6TbYmaGDkMgQdoCNiw0O23P
	 L9EkhvEPj0SbrpRQDY8bj7BxMjgTbqMwTSMLJeIdVEO32rk3Yx8TrPycKWDlZ5hAP8
	 Wplmeim7uyi0trV53XeWDIq5TMUSndzhUKtFruKeHjYguV65LgBYqEIP1p84yiCn9r
	 yr9ScrTltZzpd+CkrZQGgH0/m+oXxjgBhLHJPnZjhHHXwH3Mu59HChOAhM8QSahMfu
	 K3J7CNX1+ruzIxe8vSnpnmyqcQ83EwRwUu/JPyTb+oTcnmwBJn0V8Y+3zoWyMUALPE
	 r2zTi/l4iQITQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for-next v3 2/9] mm/slab, slub_kunit: register kprobe to
 trigger _nolock APIs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>
References: <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 11:25:48 +0000
Message-Id: <20260615112548.70B7B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Global kprobe execution introduces a data race on shared KUnit c=
ontext variables, which will trigger KCSAN warnings.
- [Low] The `test_nolock()` function is conditionally compiled only when `C=
ONFIG_PERF_EVENTS` is enabled, but it is called unconditionally by `slab_kp=
robe_pre_handler()` when `CONFIG_KPROBES` and `CONFIG_SMP` are enabled.
--

commit d19f8bc8e3ea86ee712ab0dede8b68fd72d0fbcf
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab, slub_kunit: register kprobe to trigger _nolock APIs
   =20
This patch modifies the slub_kunit test to attach a kprobe pre-handler
to test the kmalloc_nolock() and kfree_nolock() APIs. It introduces a
wrapper function slab_attach_kprobe_locked() that is invoked when
slab_lockdep_assert_held() is called.

Link: https://lore.kernel.org/linux-mm/20260427-nolock-api-fix-v2-0-a6b83a9=
2d9a4@kernel.org [1]

> diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
> index 11255fc8eb781..01d808cb77faf 100644
> --- a/lib/tests/slub_kunit.c
> +++ b/lib/tests/slub_kunit.c
[ ... ]
> @@ -326,13 +334,10 @@ static struct perf_event_attr sw_attr =3D {
>  	.sample_freq =3D 100000,
>  };
> =20
> -static void overflow_handler_test_nolock(struct perf_event *event,
> -					 struct perf_sample_data *data,
> -					 struct pt_regs *regs)
> +static void test_nolock(struct test_nolock_context *ctx)
>  {
>  	void *objp;
>  	gfp_t gfp;
> -	struct test_nolock_context *ctx =3D event->overflow_handler_context;
> =20
>  	/* __GFP_ACCOUNT to test kmalloc_nolock() in alloc_slab_obj_exts() */
>  	gfp =3D (ctx->callback_count % 2) ? 0 : __GFP_ACCOUNT;
> @@ -347,6 +352,15 @@ static void overflow_handler_test_nolock(struct perf=
_event *event,
>  	ctx->callback_count++;
>  }

[ ... ]

> +#if defined(CONFIG_KPROBES) && defined(CONFIG_SMP)
> +static int slab_kprobe_pre_handler(struct kprobe *p, struct pt_regs *reg=
s)
> +{
> +	struct test_nolock_context *ctx;
> +
> +	ctx =3D container_of(p, struct test_nolock_context, kprobe);
> +	test_nolock(ctx);

[Severity: Low]
If the kernel is built with CONFIG_KPROBES=3Dy and CONFIG_SMP=3Dy, but
CONFIG_PERF_EVENTS=3Dn, will this result in a build failure?

The test_nolock() function is defined inside an ifdef CONFIG_PERF_EVENTS
block earlier in the file, but it is called here unconditionally when
kprobes are enabled.

[Severity: Medium]
Because slab_attach_kprobe_locked() is a global function called by SLUB
internals system-wide, could multiple CPUs hit this kprobe concurrently
during the test?

If other CPUs perform slab operations, they will trigger
slab_kprobe_pre_handler() and concurrently pass the shared kprobe_ctx to
test_nolock(). This would cause multiple threads to modify shared integers
like ctx->callback_count++, ctx->alloc_ok++, and ctx->alloc_fail++ without
atomics or locks, potentially leading to lost updates and KCSAN warnings.

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-kfree_rcu_=
nolock-v3-0-70a54f3775bb@kernel.org?part=3D2

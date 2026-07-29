Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B343E7145;
	Wed, 29 Jul 2026 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314386; cv=none; b=L9IiQ1X4CZWrBIBaJMpu5ihkfA1zY7ijpNyybOkU8CKPWOdo4k3DYSvE9pofQox/e09i6x5CK7ESivDa/Nh9jpXvBWCUGAhSOkrKtcwpPGBiZ3ToXVtNI508Wk9EfO6fCJSIAhNbBpGzUy9llDD2Rf1uNQJT6G1FM9fggBn45PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314386; c=relaxed/simple;
	bh=RRVkrYeQQVMXVobe9JHbaHLfsMmPqxUihHjEkD0LTH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W3bWV3Huk4skAxHhWG1fJiMn1JoVVPRTlJf7uWqU99kYM3aWsYsUXiTpU4pPW860XoEGf1OiMFcaCK2DAX8ITVUIWfM3M6+VyTbeBRPwMOvOmzZfb8n9E6c4xzqg/UeSUANf9Z8izf94cjdGMUCldW+X9TzC7j3aEDntamjF7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku3E0xer; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku3E0xer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F2C1F000E9;
	Wed, 29 Jul 2026 08:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314385;
	bh=ZStxgCGXhRzyZgjW57H6UDqdrjQi9HHAJLdBh2z8exI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ku3E0xerGqmQGgx3aQNe5qsBkdkI5Un0VMEwtuZ3fJ85dzpAIAF9x1KopU6JGmQ8b
	 JA+jXmZK5hU+MSsYOaeGUA8ZaAeROgpZkTt52zVpLvcEJtD3QxW7RLtSv2DV5tI1D5
	 xZEMZQtTOWEbVV+ke/iXZZ3xNBjWtGAVqDd69Z2rnaU5oE7GnwaH5ej6q/oJ3Wm1f0
	 BWP3kIvU0oFkzcXxg4p1CDafufv/EFwo0hLwsrzMWQcDzrBP6e2aS4eQcYwaNELWwv
	 /+lDjZJbBhWaIgSjcZxYTUoAGgdAAZIGIcvLRY5XZPcL9yqhMyJ4PS+Q2j42aQnoPP
	 p46BajW7to53w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/8] slub_kunit: extend the test for
 kfree_rcu_nolock()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260729-kfree_rcu_nolock-v5-8-a28cdcda9673@kernel.org>
References: <20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org>
 <20260729-kfree_rcu_nolock-v5-8-a28cdcda9673@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 08:39:44 +0000
Message-Id: <20260729083944.B0F2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing synchronization for deferred RCU frees causes KUnit test=
 suite contamination and false negatives.
--

--- Patch [8]: [PATCH v5 8/8] slub_kunit: extend the test for kfree_rcu_nol=
ock() ---
commit 975207c355ab3b2db3420df72699cb12e4769b5e
Author: Harry Yoo (Oracle) <harry@kernel.org>

slub_kunit: extend the test for kfree_rcu_nolock()
   =20
When slub_kunit is not built-in, call kfree_rcu() and kfree_rcu_nolock()
to test kfree_rcu_nolock() in slub_kunit.
   =20
Rename the test case as the test covers more _nolock() APIs.

> diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
> index 8c2b9911471eb..e3b63f0338d5f 100644
> --- a/lib/tests/slub_kunit.c
> +++ b/lib/tests/slub_kunit.c
[ ... ]
> @@ -397,14 +410,14 @@ static void disable_perf_events(struct test_nolock_=
context *ctx)
>  	perf_event_release_kernel(ctx->event);
>  }
> =20
> -static void test_kmalloc_kfree_nolock_perf(struct kunit *test)
> +static void test_kmalloc_nolock_and_friends_perf(struct kunit *test)
>  {
>  	struct test_nolock_context ctx =3D { .test =3D test };
> =20
>  	if (!enable_perf_events(&ctx))
>  		kunit_skip(test, "Failed to enable perf event, skipping");
> =20
> -	test_kmalloc_kfree();
> +	test_kmalloc_and_friends();
> =20
>  	disable_perf_events(&ctx);
>  	KUNIT_EXPECT_EQ(test, 0, slab_errors);

[Severity: Medium]
Will this evaluate slab_errors before all asynchronous frees complete?

Since test_kmalloc_and_friends() queues objects via kfree_rcu() and
kfree_rcu_nolock(), the callbacks could execute in softirq context later.
If they interrupt a subsequent KUnit test, slab_add_kunit_errors() could
attribute any SLUB errors from these deferred frees to the next test, causi=
ng
it to falsely fail while causing this test to falsely pass.

Should we add a synchronization call like kvfree_rcu_barrier() before
checking slab_errors?

[ ... ]
> @@ -438,14 +451,14 @@ static void unregister_slab_kprobes(struct test_nol=
ock_context *ctx)
>  	unregister_kprobe(&ctx->kprobe);
>  }
> =20
> -static void test_kmalloc_kfree_nolock_kprobe(struct kunit *test)
> +static void test_kmalloc_nolock_and_friends_kprobe(struct kunit *test)
>  {
>  	struct test_nolock_context ctx =3D { .test =3D test };
> =20
>  	if (!register_slab_kprobes(&ctx))
>  		kunit_skip(test, "Failed to register kprobe, skipping");
> =20
> -	test_kmalloc_kfree();
> +	test_kmalloc_and_friends();
> =20
>  	unregister_slab_kprobes(&ctx);
>  	KUNIT_EXPECT_EQ(test, 0, slab_errors);

[Severity: Medium]
Does this test case need synchronization for the same reason?

Without a barrier before evaluating slab_errors, deferred RCU frees from
test_kmalloc_and_friends() might leak into the next KUnit test and cause
false test failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-kfree_rcu_=
nolock-v5-0-a28cdcda9673@kernel.org?part=3D8

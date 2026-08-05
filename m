Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA63D6472
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964552; cv=none; b=TUOocpvynobrEigi3NLYkJVj2RrOpPxFPJqyaHD7vB95rZM1sp070SCm4a25o73IenNJCy7KQpReO8MZvm/bP2/7b+Ym/6ncX84nuDl8y+x/WqvHQNDbrRRqq/jBNj4If99pzyuOZXOSrZfRBk8IaYPxaPXm56Olbj7autPtmd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964552; c=relaxed/simple;
	bh=vHvyot0fErh+QzMNxJE2dwpuBbTKUr83eI29A5sL97Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tbzYUl8sUmn3ZBjOcX8H+dbwuxKApEeZEgDWCwc9sruKZTCtlkTX79WVJs5TqucH2mqStn+ItE4O/+/Amr5PJJkbfBhLIniSohyaHStHslMebtcB3g+6ShxapK/O1h7oW+ujRF7Pro84jq5rpH8PkLdQn8Q0ObEOxDUJMsxj4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxsQHTk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxsQHTk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F9B1F00A3A;
	Wed,  5 Aug 2026 21:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785964543;
	bh=O2Tp/PU165HQsqQTVE8sd7ym2TAXTFkaluMccD/HOqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RxsQHTk+78g5opBfHWxnxn3t9lF7oTGP92zQfZy3Ud/+c4x+v20MkZ1YTU1nGmSai
	 GzNtKrngTJUv7F/ExpFjhUWnOegRAc8FTb1bB+P/f1l/TwIC/+ADd7XUpan/ah4/r2
	 y2MN8QBENMO1lrr/CqIcJzKkrjPvwfNZVlQWXPKiY1se6tgvORZg0hbf+mb6QfjoJ4
	 kRicfXPYnDsUHKnVAxXG5Q4YJMLuBMLUWC3anaieR46Cog7/Fk6ZIpi9iNfWQeL4Vm
	 BNa/bnJvfyOjBgT/dispjsJmwJwQkTx9iCIaxDXmRfCQKUDwjHVoT/fccE/gJiL+3l
	 rqTpNoCFJ8pLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 10/13] selftests/bpf: Add struct_ops __arena
 and __arena__nullable argument tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805210427.3218326-11-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
 <20260805210427.3218326-11-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:15:42 +0000
Message-Id: <20260805211543.42F9B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing NULL check for the global pointer `st_ops3` and its func=
tion pointers in `bpf_testmod_ops3_call_test_arena` and `bpf_testmod_ops3_c=
all_test_arena_nullable` kfuncs.
--

--- Patch [10]: [PATCH bpf-next v4 10/13] selftests/bpf: Add struct_ops __a=
rena and __arena__nullable argument tests ---
commit c92a05fea3ca93b4550591e23b6734b40facb5bc
Author: Tejun Heo <tj@kernel.org>

selftests/bpf: Add struct_ops __arena and __arena__nullable argument tests

Add test_arena and test_arena_nullable members to bpf_testmod_ops3 with
arena-tagged stub arguments and kfuncs that forward a caller-provided
pointer to them.

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index b92ac1e5df1d2..64ca43744c593 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c

[ ... ]

> @@ -418,6 +430,16 @@ __bpf_kfunc void bpf_testmod_ops3_call_test_2(void)
>  	st_ops3->test_2();
>  }
> =20
> +__bpf_kfunc int bpf_testmod_ops3_call_test_arena(u64 *ptr__arena)
> +{
> +	return st_ops3->test_arena(ptr__arena);

[Severity: Medium]
Will this cause a kernel panic if a BPF program calls this kfunc before
the struct_ops is attached, leaving st_ops3 as NULL?=20

Additionally, if a user provides a struct_ops map that omits the test_arena
callback, could st_ops3->test_arena be NULL, leading to a NULL function
pointer dereference?

> +}
> +
> +__bpf_kfunc int bpf_testmod_ops3_call_test_arena_nullable(u64 *ptr__aren=
a__nullable)
> +{
> +	return st_ops3->test_arena_nullable(ptr__arena__nullable);

[Severity: Medium]
Similarly, can st_ops3 or st_ops3->test_arena_nullable be NULL here under t=
he
same conditions, causing a panic?

> +}
> +
>  struct bpf_testmod_btf_type_tag_1 {
>  	int a;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805210427.3218=
326-1-memxor@gmail.com?part=3D10

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8937A29AB05
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642388; cv=none; b=n+gJ3ZCOmK7RCtT/4rxkrU08axkI16s7zfgKl2edlc+WidzgEueILhcvHusAHe6Pm5Dh5c4uDT8jWd0M5q5NB+4pXa98Au5sNIK49Wrap41oKCEfhsOGHiWmU8zo+Qewecr4WQFP4lxGFRC0t1F0jriWuFQjemyPO24fpfHexLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642388; c=relaxed/simple;
	bh=ejuXTdmVFp1WWQmeb0XpCgzTAUZNc5wrKAZYWoQyZys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VlcivUxoQ6LfWdI7K2ADciglcBiHtzTaFb66Ge4ewF+2OLWBZmaAGHBgv9F/g75gDzFGObeqpfb5oTP/QG8v8Qwl2q+yyXhaGxeBr/dNrXtVhVvmSrQICuS+CupKwFT0hySNhaHqH2KHsbSkaulZ5eH5VE12+vUyEOXWiEjyhXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw30LiCZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw30LiCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339231F00893;
	Fri,  5 Jun 2026 06:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780642387;
	bh=1qg0MHNTAnYJ9SlyVItHW2l3zghU5AWTLIPV1km+uQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nw30LiCZpJwSy8S/vlgUA0C6mYL/kJOvH4p+kJBR9dXr/uQ+SyiJdGj6anAtcmpye
	 wXavI0cilF/A3wzLPdtGUkjNjVedBBbjanYMiYD5uf9JSTDhoHY4cHsVKlZF6oxAtF
	 7bgaWMfCWYsz7XWrLb9KI8Khl/AcDwlT+VfFxoA1nh2w7cHjIMNvjik/GtvqCDDiwi
	 5pTW1aOLWacEB1c4I16Pn0ib4PRY1Ud5d7OmRQ/PVAfu5qIoqtVe+zCasIk7KNPH78
	 ckb6KLcIzw66WgwZ3vi9h9Fz6j5lwXSOWevTWIiWnv/wNKjXh86NCvJP1LTCMFOFwn
	 YDsg49kptHT5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 15/17] bpf: Report Verifier Limit errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-16-memxor@gmail.com>
References: <20260605063412.974640-16-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:53:06 +0000
Message-Id: <20260605065307.339231F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Large local character arrays (`chain[256]` and `reason[512]`) ar=
e allocated on the stack in verifier functions, risking kernel stack overfl=
ow.
--

commit 58bfdd96949c20f24a4355e1c77d8bbbd610ef4d
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Verifier Limit errors

This commit augments selected verifier limit failures with detailed reports.
These reports focus on the limit that was exceeded and the observed value or
condition across stack constraints, call frames, and instruction complexity.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -5233,6 +5267,8 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
>  	bool tail_call_reachable =3D false;
>  	int total;
>  	int tmp;
> +	char chain[256];
> +	char reason[512];

[Severity: Medium]
Could this cause kernel stack overflows? Although these variables are only
populated in slow error-reporting paths, C compilers typically allocate
local variables in the function's prologue.

This adds 768 bytes to the stack frame. Since this is only used on failure
paths, could these strings be dynamically allocated (e.g., using kasprintf)
to avoid bloating the stack?

[ ... ]
> @@ -9443,11 +9557,22 @@ static int setup_func_entry(struct bpf_verifier_e=
nv *env, int subprog, int calls
>  			    struct bpf_verifier_state *state)
>  {
>  	struct bpf_func_state *caller, *callee;
> +	char chain[256];
> +	char reason[512];
>  	int err;

[Severity: Medium]
Does this present a similar stack bloat risk? setup_func_entry() is invoked
deep within the verifier's call stack, for example:

do_check() -> do_check_insn() -> check_call() -> set_callee_state() ->
setup_func_entry()

Adding an additional ~800-byte frame size expansion here might trigger frame
warnings or kernel stack exhaustion.

>  	if (state->curframe + 1 >=3D MAX_CALL_FRAMES) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D15

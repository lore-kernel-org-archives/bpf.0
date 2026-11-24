Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529377;
	b=Dd4tKaS3+DokLAGweBFRPcBQYLgRUENbmQPzxs9M3dazWNlmBtEclBe1D6sB8IAys0Dg
	 oENQvSgFvYMem3ev/yp9rbUTVcWLfCq2him8gVUJlYohQga9+xRzpbRbAS4UE5FT/Uz2X
	 PVt/0hpgAkWJEWMtQujSgK0Hv6XBhTT71CLu8UeKCKi5PSTMwrCw+BTAmkSCWBCsrWxcn
	 fbLnj+0zfSHzO1Oe3Oniydi/a3efB01FiRKNPRPJ8iTRFpeWRGdXjdrASFGvDPl3YrEnb
	 NHw7OLp2RPP+90kkCNsEUrJJ9yE3bPmTPIyLDel15UOZWKgFfEF0VPzis2vdB3MLOGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529377;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fmj1aca+5NQ29kbRjgYxiVz1KMJEP2PTuwTtG/Ji48g=;
	b=rWvj+hZwx+e3K26e8Jh5FmVXtkOByY9N8cxB/GbuJDD5qxhD7xJaLA64sSRlYRptmlLF
	 ubYR+7UQyfZyjtFi8KX75TotwAYVqPyY2Kujy6WfzITSnenwEx/4AUO5YYa4VyFCsnapc
	 G4UQ0XOzTOFI00Ukae/tOsnJ4gmw9YOj1JxljZxoU/JO3NZGI+Z68gZZ8IQificNFHJAV
	 x1DoSgITTvqynqFOAh8IgWw+V6qlvT/kmmMPDT2xqDEk2QCTiAv8+EDcfWyrA/gW02QUS
	 tvVgQfLVheTaWHLMsBmuxrNjhO0QHJD9gom85m6W0RZbelg/Xi+gc0qJ7mleVQuFfEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lq9S8uIA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F6606B74F
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lq9S8uIA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490371F0093E;
	Tue, 24 Nov 2026 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795529377;
	bh=Fmj1aca+5NQ29kbRjgYxiVz1KMJEP2PTuwTtG/Ji48g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lq9S8uIA9zFc/jYCA7sqrP+7q3mDwn7Gfdk1FHjcRrY3idksi5PJ+9nDvKkEkxSBR
	 FlEnO1s2rIdDBKqN8BL/FCqExdkDhqvQqMCFAwtWiP7rF33ZdtkoQzNDw+sHcsZl26
	 spOx57Rk6wEhRZ2Tzt+zAEnU0Fvkh5QHT0S0hvx3cjLZE6EV+U8gFFnhBHOtblzLS4
	 66cFwRJbzoozn8hgxIHvdRqC3ykbGjBQlLHunOrO9nT/r30TJnPrk62gYgdpdMSrPt
	 E6Hcp9f3Ltoa0YkwvoLBZn+yw6ob439o2Sbz0vRae5K0I+F9a0vYvRmrKAZTzwClvw
	 5SwWfm+O2sUhA==
Message-ID: <sashiko-outbox-231307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: reduce kernel stack usage in
 bpf_guess_first_trips()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261124140155.1555535-1-arnd@kernel.org>
References: <20261124140155.1555535-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 14:09:36 +0000
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
- [Low] bpf: missing BPF_VERIFIER_GFP in bpf_guess_first_trips()
  allocation
--

commit 166dd425d776a0ec6b6a3e502aed3e0810e29438
Author: Arnd Bergmann <arnd@arndb.de>

bpf: reduce kernel stack usage in bpf_guess_first_trips()

This commit moves the temporary bpf_verifier_state in
bpf_guess_first_trips() from the stack to the heap to reduce stack frame
size.

> diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
> index d7ad7fb52ed6c..4123a84482372 100644
> --- a/kernel/bpf/equation_join.c
> +++ b/kernel/bpf/equation_join.c
> @@ -1455,7 +1455,7 @@ int bpf_guess_first_trips(struct bpf_verifier_env *=
env, struct bpf_verifier_stat
>  			  struct bpf_loop *loop)
>  {
>  	struct loop_stack_entry *e =3D bpf_top_loop(st->frame[st->curframe]);
> -	struct bpf_verifier_state next =3D {};
> +	struct bpf_verifier_state *next;
>  	struct bpf_loop_steps *steps;
>  	u64 trips =3D U64_MAX, xreg;
>  	struct scalar *s;
> @@ -1488,15 +1488,18 @@ int bpf_guess_first_trips(struct bpf_verifier_env=
 *env, struct bpf_verifier_stat
>  		return 0;
>  	e->exit_threshold =3D e->trip_index.r64.base + trips;
>  	add_iv_threshold(env, loop, e->exit_threshold, 1, THRESHOLD_EXIT_JUMP, =
U32_MAX);
> +	next =3D kzalloc_obj(*next);
> +	if (!next)
> +		return -ENOMEM;

[Severity: Low]
Should kzalloc_obj() pass BPF_VERIFIER_GFP here, like the other verifier
allocations in find_steps() and bpf_copy_verifier_state()?

Without BPF_VERIFIER_GFP (GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL |
__GFP_NOWARN), this allocation is not charged to the caller's memcg and can
emit page allocation warnings or invoke the OOM killer under memory
pressure instead of failing the program load cleanly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124140155.1555=
535-1-arnd@kernel.org?part=3D1

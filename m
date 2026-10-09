Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D273E0C77
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578912; cv=none; b=A0Rh0QuZufhBFS9BGuecEn/vYmBq25VOKD0i9+XLIzog2RwrlKZfiTC4wgAHFLfPIIw50qWoRUa3p4oa21XpTaYKk7v0rRcYuHdBlTtMbMDlTGa+8ROZT8E+AWN3OirtfHL4DDwZ53UcL5sS733dBUwNO0SXW0Ufg3Td48CFsrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578912; c=relaxed/simple;
	bh=1nTQbDunKEriEVA6luhpjjiYHy1oWcTPYe33h1yo3qw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CAr/wQiICsX+lugrKjDokdv7OniasnfAPSmN/dhxOM5bdqT3rLaXVJXGTLspag2V3faLR18uMozRx2LMgodzMUQMoT604gyq+DJqygDZagcZz3KksvQEJhhk1gw7gutOp07jkLWS82btHdnVIiJ9O4Za2qndyRgmPdRZerr6D28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdS7juMq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdS7juMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0861F000FF;
	Fri,  9 Oct 2026 20:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791578911;
	bh=UArJ5f74fUL/yGu7sQ2NR9IL1ROYFZccuxPn42B15bU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YdS7juMqtdEAaSV7Sh4vxEcCi04aQLOq8d7mwYsGPeI5W2u+aQMhcNgmMn/2pvdNz
	 cu2U00o7hn9xwaZ4er3Qb746GruVSq3MkgzKiOn758P4ykMY0ykLpEGVP1IdLDjsIs
	 BDfqyvfrWNhpCZC/FLQPaxR9dS6mY3ME7DI9R0BJ/WiV5IQfNGf3lzovuKSYwqnZsS
	 Z3xRHLpGDCoLS3vsh/Rb9RaoL7YhBrRRXy3em7VWqcZBHdO2SKyf6+evrXquncyE/2
	 mmmuFxEnxf8Hdcw6OTxkbjO8jVQySSefAwUl/Va7qCZUB9OQ3nmaKJcQ2jfFIGRFD5
	 OVHQx0FGh61aw==
Message-ID: <sashiko-outbox-166059@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 07/11] bpf: Introduce REF_TYPE_FRAME in the
 verifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009202759.50520-8-ihor.solodrai@linux.dev>
References: <20261009202759.50520-1-ihor.solodrai@linux.dev>
 <20261009202759.50520-8-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 20:48:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: UAF due to dropped parent_id in dynptr_from_mem for frame=
-scoped args
--

commit 19d3a1bd15552653b24ece884c759a788c6abaf9
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Introduce REF_TYPE_FRAME in the verifier

This commit introduces REF_TYPE_FRAME to track references owned by a callee
frame. It allows a set_callee_state_fn to anchor an argument to a reference
which is dropped when the frame is popped.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c51083c761cf2..54a4f440c33b3 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -272,15 +272,13 @@ struct bpf_stack_state {
>  };
> =20
>  struct bpf_reference_state {
> -	/* Each reference object has a type. Ensure REF_TYPE_PTR is zero to
> -	 * default to pointer reference on zero initialization of a state.
> -	 */
>  	enum ref_state_type {
>  		REF_TYPE_PTR		=3D (1 << 1),
>  		REF_TYPE_IRQ		=3D (1 << 2),
>  		REF_TYPE_LOCK		=3D (1 << 3),
>  		REF_TYPE_RES_LOCK 	=3D (1 << 4),
>  		REF_TYPE_RES_LOCK_IRQ	=3D (1 << 5),
> +		REF_TYPE_FRAME		=3D (1 << 6),
                ^^^^^^^^^^^^^^

[Severity: Critical]
Does this new reference type get ignored when the verifier checks if a regi=
ster
is referenced?

In kernel/bpf/verifier.c, find_reference_state() explicitly skips any
reference type other than REF_TYPE_PTR:

kernel/bpf/verifier.c:find_reference_state() {
...
	for (i =3D 0; i < state->acquired_refs; i++) {
		if (state->refs[i].type !=3D REF_TYPE_PTR)
			continue;
		if (state->refs[i].id =3D=3D id)
			return true;
	}
...
}

Because find_reference_state() ignores REF_TYPE_FRAME, reg_is_referenced()
returns false for frame-scoped arguments.

Could this lead to a regression if a callback passes a frame-scoped referen=
ce
(like a PTR_TO_MAP_KEY array key or ringbuf dynptr slice) to a constructor
like bpf_dynptr_from_mem() to create a local dynptr?

When check_helper_call() processes the constructor, reg_is_referenced()
returns false, which leaves meta->ref_obj.id as 0:

kernel/bpf/verifier.c:check_helper_call() {
...
	if (reg_is_referenced(env, reg))
		update_ref_obj(&meta->ref_obj, reg);
...
}

Later, mark_stack_slots_dynptr() sets the dynptr's parent_id to this 0:

kernel/bpf/verifier.c:mark_stack_slots_dynptr() {
...
		/* Track parent's id if the parent is a referenced object */
		parent_id =3D ref_obj->id;
...
}

This strips the dynptr of its frame-scoped lifetime tie. When the callback
exits, release_frame_references() won't invalidate the dynptr because its
parent_id is 0.

Can the caller then extract a pointer from the dynptr using bpf_dynptr_data=
()
and access memory after the callback frame is destroyed?

Is it possible that pointer cast functions like bpf_skc_to_tcp_sock() also
suffer from the exact same logic flaw because they rely on
find_reference_state(..., meta.ref_obj.id)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009202759.5052=
0-1-ihor.solodrai@linux.dev?part=3D7

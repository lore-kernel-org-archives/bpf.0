Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413075;
	b=jMfddw0h4EpSFIfyhooRvxtoeSYXTFcd5xABfRilIOKMASo4LOjsmMtRxx9rKNWwfWUj
	 YxyfGZCaoOhmGgGhjl6wzyAK7K/mwpJqOsdQLVWyKHm6BUkv41kbHqczltVLvbMm4omiw
	 efbAlk8ISZpUIEYRtojvjy4mUZbjqcc4Q8MhtUA36grRfIkfFiOqgBCEoOl3a8/AUTbMV
	 wMCT+vmyOkNj29d+6KPzaC8R+WifE4DGqYpA3xpPckm0U6NckiVBuQ3Q0RL8gQsh0Ck03
	 AtfJ1htU2olo5t9WnIR6XLLFuvySSRncM1oEC7V+uR21/VP9pQY97s/GN7xwdcXbgog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413075;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l9cGyi5jFMs5Bgfi02LkPpzXwAwVDH1b3wH3AEXaG1c=;
	b=O+veQcbzPOVgTfb5iIyBH/SaEJRXnW1jMMLjrNXCAX7dL9j3fizBxn5zVO+WFzK+V2ee
	 iru0SR/85ithVujDBR6xSltDyyXr+kAIGxmlsZxg2z9Wz/r+XgK9xEHRMFw/PNEuk7r9R
	 6f/Fss5DDPAgy+6kKKXLCLyDORf0ypZYQiSrHHDTg4MHXYDYnriXqHwO9It4z47Tpj0mS
	 6IXnp2rgNIhv5JXzdLdx005Z7TE/0WnZChtj5DcbLyVpAdmJ4HcIFtBv7h+ERfBCWGXQU
	 NVN1Bo9cYhSmCkh7nn41+lhu+S8zP+0J098hNCDxXxS3KPSRlXOWtFewRvY6uoHVjhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UziId8jr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE1C606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UziId8jr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024C01F00A06;
	Wed, 11 Nov 2026 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413075;
	bh=l9cGyi5jFMs5Bgfi02LkPpzXwAwVDH1b3wH3AEXaG1c=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UziId8jrSTS+qdpIdZrq27HKp9O9G0mdRmYVkxl7G7N0jwNIuoQT5Wrge4SEbymIe
	 DpeEHjkXcArq04G8kSqyqeMxOnPLaFczp/ThPjVGDovTdelm6/dyRxRMLegIJPTIvy
	 kkNe2reBL+QKb+iscpFfTZn9ts6KpQGUQot5Aux3YAaoPbTd/XU4bRrAsElxUAZoj2
	 UEtUeHjF/AUlQkj93np4qijG4oTXJNp70Qxl1xc72leq0hjjrK/6oHiSWOl3RWIele
	 mtoo6lRygIZGhj9gYXabbdW509FRcfigzaufY0thw/EsPruCu6cOyWWti+2IUTG2Iw
	 ZLREZ7EK4VYww==
Message-ID: <sashiko-outbox-209246@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 16/29] bpf: Describe locks at throw sites
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <8861d3d06eadcff128742ac81b2ba9c54f71c523.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <8861d3d06eadcff128742ac81b2ba9c54f71c523.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:04:34 +0000
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
- [High] bpf: s16 overflow in ref_locations() when computing lock offset
  adjustment
--

commit b280bb740c33eccf7a76373a4566fec46d049b84
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Describe locks at throw sites

This commit records held locks in throw site descriptors either by their fi=
xed
address for single-element array maps or relative to a stack slot or regist=
er
holding a pointer to the containing object, avoiding hidden stack slots when
every visit to the site agrees on the lock.

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> index 5cb837688f90c..72dc6597321a9 100644
> --- a/kernel/bpf/frame_desc.c
> +++ b/kernel/bpf/frame_desc.c

[ ... ]

> @@ -805,42 +844,50 @@ static void ref_locations(struct bpf_verifier_env *=
env, const struct bpf_verifie
>  	const struct bpf_res_acq *acq =3D &env->res_acqs[ref->acq - 1];
>  	const struct bpf_func_state *frame =3D st->frame[f];
>  	s16 adj, lim =3D env->subprog_info[frame->subprogno].fastcall_stack_end;
> +	bool lock =3D ref->type & REF_TYPE_LOCK_MASK, ptr;
>  	const struct bpf_stack_state *slot;
>  	int k;
> =20
> +	memset(loc->at, 0, sizeof(loc->at));
>  	loc->cnt =3D 0;
>  	loc->obj =3D false;
> -	if (ref->type & REF_TYPE_LOCK_MASK)
> +	loc->fixed =3D lock && env->resources[acq->res].addr;
> +	if (loc->fixed) {
> +		loc->cnt =3D 1;
>  		return;
> +	}
> +	/* a pointer the frame keeps: to the object, or to what a lock with an =
id is in */
> +	ptr =3D lock ? ref->id && !(acq->flags & BPF_RES_F_NO_PTR) :
> +		     ref->type =3D=3D REF_TYPE_PTR && !(acq->flags & BPF_RES_F_ARG);
>  	for (k =3D 0; k < bpf_stack_nr_slots(frame) && loc->cnt < BPF_RES_LOC_M=
AX; k++) {
>  		slot =3D bpf_stack_slot(frame, k);
>  		adj =3D 0;
>  		if (spi_off(k) < lim)
>  			break;
> -		if (stack_slot_is_object(slot, ref->id)) {
> +		if (!lock && stack_slot_is_object(slot, ref->id)) {
>  			/* the handle of a dynptr is its first word, as when it was created */
>  			if (slot->slot_type[BPF_REG_SIZE - 1] !=3D STACK_DYNPTR) {
>  				loc->obj =3D true;
>  				loc->cnt =3D 0;
>  			}
> -		} else if (ref->type !=3D REF_TYPE_PTR || (acq->flags & BPF_RES_F_ARG)=
 ||
> -			   !bpf_is_spilled_reg(slot) || !reg_ref_off(&slot->spilled_ptr, ref-=
>id, &adj)) {
> +		} else if (!ptr || !bpf_is_spilled_reg(slot) ||
> +			   !reg_ref_off(&slot->spilled_ptr, ref->id, &adj)) {
>  			continue;
>  		}
>  		loc->at[loc->cnt].off =3D spi_off(k);
> -		loc->at[loc->cnt].reg =3D false;
> -		loc->at[loc->cnt++].adj =3D adj;
> +		/* the acquisition of a lock has how far the lock is into what it is i=
n */
> +		loc->at[loc->cnt++].adj =3D lock ? adj - acq->adj : adj;
>  		if (loc->obj)
>  			return;
>  	}
> -	if (!env->describe_regs || ref->type !=3D REF_TYPE_PTR || (acq->flags &=
 BPF_RES_F_ARG))
> +	if (!env->describe_regs || !ptr)
>  		return;
>  	for (k =3D 0; k < (throws ? ARRAY_SIZE(site_regs) : 4) && loc->cnt < BP=
F_RES_LOC_MAX; k++) {
>  		if (!reg_ref_off(&frame->regs[site_regs[k]], ref->id, &adj))
>  			continue;
>  		loc->at[loc->cnt].off =3D site_regs[k];
>  		loc->at[loc->cnt].reg =3D true;
> -		loc->at[loc->cnt++].adj =3D adj;
> +		loc->at[loc->cnt++].adj =3D lock ? adj - acq->adj : adj;
>  	}
>  }

[Severity: High]
Can adj - acq->adj underflow the s16 loc->at[].adj field in both loops?

resource_of_lock() checks that acq->adj fits in s16 (0..32767) and
reg_ref_off() checks that the pointer's constant var_off fits in s16
(-32768..32767), but when the spilled or register pointer has been adjusted=
 to
a negative offset and acq->adj > 0 such that adj - acq->adj < S16_MIN, stor=
ing
the difference into loc->at[].adj wraps by +65536.  On unwind,
bpf_unwind_release_desc() computes handle =3D (void *)(long)(val - ent->adj=
) and
passes an out-of-bounds address 65536 bytes below the lock to
bpf_spin_unlock() or bpf_res_spin_unlock(), corrupting kernel memory and
leaving the lock held.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D16

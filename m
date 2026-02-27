Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2526ED54
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153220; cv=pass; b=lS6+qHpIM11WXh4GI7zVXM/uIk9I2iP8Sn3Xmo5WCJSsKQYwQqSkehyN7IJbP6qNlfZW0BEJN5TcdypnPNR9oXufA9VMTe18L5yNEORRqUE8MMJbXfLxIPOHIQ7BOAbTBNZTK1euuGqEwQNr1TGLIdr06dF61WTqZGbmzcypJTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153220; c=relaxed/simple;
	bh=MCJTeWRRGX5AQl4pXe7s6U5ij6up4QTeKDMFzLH2HZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWALyKiM554CAzUbjez3ba+LC97boF0k/6Qb/kpGvukWutb5JlZCb7Y4S80q82U08BB5x6A6HuAbjHApUlKEHABDfrvsFR1YtCbYG75H5wCdSD3tM/T0piM6NTgi4z0iFZj3vBDVVXYH7lbNnxjLi3sEE6WkieFioacB4qv/pzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KClnqxVG; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KClnqxVG"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-436e8758b91so943544f8f.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 16:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772153217; cv=none;
        d=google.com; s=arc-20240605;
        b=ib9Rw+jnPtNyigpJpyEgKOIvI0AJu7Aeu7jCAXzx0fHAsqgw1c0TGLzqC1BbHopfJE
         b61hU2aA3ifFmeHf4yc6jBwkykN4T1du2QbODghZpz24+ba10vLcrSLv3DQf6WLgCdSB
         Cxh3Py4fKUdJ38bGhFlL5X3nM8QyPvxM6ABALhPNSBmMMi+wong8fHNiHlZVxWcuYR//
         /cenIDCwK8He/WSIQnEfIg/zHGe3DkvR090+82BFLhmlPv4utWwds6jf9nSw2+Gv/XCQ
         c6xhQ3ZWJ0w94CkZp4u+r9moO6VLrbwjwq6qI0mCh+cw4H7fWbA3dKXoCuLT0GKn83/K
         oUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cype4ty9+ym43TpjTvRffOXXCPuEDqpLZ7lR7pnekf4=;
        fh=QWPamShyA1J/8s5doFWE3PWqLapUJDuSRevdrJZqM+c=;
        b=T3MWCraMqi0TmtzxFtg8NOe9/KxGz6tIAZOt8iis7g08JmqU110KMhfcG0UpmBl9rn
         2Kb62332U/Tc40EzbVbuuGPvDrmgWsRlarRtjL5pONviksAKVggpDPFEGaVBrgF+8oSS
         77VwOpmnyZq01SL94RN8BJl27qjzAq3yc2I74eYzEppU54oWJYeQSuSBW/wPpfOEcTF8
         dHHX2s6sHT2I+mJSrpvBoE2kde0602dnd9MifHDSSjEzADL/E2XPrsCBgVIT9Vh3pTyH
         SHElZDdGunJNxhb7fcurz1m4gLZ0Ql7L/1/R7WcFILlTwFMgGk4HSnHi74sXhRtP1qrk
         hWQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772153217; x=1772758017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cype4ty9+ym43TpjTvRffOXXCPuEDqpLZ7lR7pnekf4=;
        b=KClnqxVG6QNATCDhcN+a3wQVh1ykn200MaWLmWKmHmiweaIlbAxgwHcRxcLV43EJ33
         wL5ydlH5zXR5fl5Nr5z8K3no24WhJG9TVivPPj5mGmPtT/a3AQlj+Evv8VKDCR5aw2C6
         7/SG98gFRg6SUT04DhGNchOeluRmFI3dXkBy/Yf+Yzzs079/J0MLNWtlBIl2KQOYZroB
         GgUJbeJ9sXr6HjVpR4JXZo4GQq8ti7x8IrcHuZqbox/7hilfUlpjOSza+gbGpDr+8wQ3
         j/95A6Dwsu8S9d1yTo0M4UL24Oi1pKHjtCbbAyFFwWWRAg9NfgaJwiYFFkIYm2g/ICS7
         8moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772153217; x=1772758017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cype4ty9+ym43TpjTvRffOXXCPuEDqpLZ7lR7pnekf4=;
        b=cjioICFPsyVnJPFzk2GLe406YbMWOLWJN/uE3RjGHi92bTgKkOmLh7de0/ODyEdcWP
         xTs9JuZ2v1gmuaUn+gIdFkVHYoXX6cXmi/mXpcCREdwirSXczSlY0f8t+mPsgabwtShu
         mDSYzPyNu8JHFyWcR9SnCW4ZGWakmIqMu65BRpXZPMuYKdv4MZ+g61uKrbr/dSrCMS77
         QO4gtF4LkGiKzWlzCAvuVahIYN0RwMCRLq120S8vgSJjr0OrBB/EnQtVeFGVfATCPv9n
         W9ncqYhi3tMK5F0RY8xoyBAnD/I57ohktiSrUOdSMcA+I3QVmgcXNObzGIeXXktWha/L
         GnRA==
X-Gm-Message-State: AOJu0Yw8+UFkU3BN4bbGne/CUOky0422dYaZUo+ST1WI5SM+9WdUTmv0
	xT0gM1nWbrWFF9pnA+gBYKJi6vimvLvem9H1Vyryd9CHA08b2rWdSTXH5lN8qOEyvB83Lm/3Mob
	LPISZR5C4cT5okLWUBUO+BjmiJHGfJw8=
X-Gm-Gg: ATEYQzx1afyhZ6LyFWdMTl+koCM85QhXF/0Os8E4VW5TH+da4YQe0M0R3kDa8Ahpv6v
	+AZuil1Y6YvMh56IW06IC4UT1zN7kIXANsVzE3s7+BGyadbyfEV1YnZzEqpaYHLe3g+xJBQKRiK
	icFsGdwwsWnlcp9+d/KgNCc6EDtvUXWiSpV/EoD9oOBGWEdO+tcNvVtr4+zFcNq9X2LS/oJhkEz
	8AoHCQ9UZLPEiqy8nEo/zrcLd8OQurn2bSxNa+GcpdYe2OFtvUVE3S3eb8AgYLWb+8HkL9UFP42
	7wn8DO+yzLF1YOEQ6nccYckpZEvbbwVHt0k63NC3+N6bfp7yFwJO7KATwyfP8buM7NTE7aF9d4y
	wgA7MSYsFnKChzpjSrzQzFXNy4A==
X-Received: by 2002:a05:6000:4212:b0:436:3475:473f with SMTP id
 ffacd0b85a97d-4399de27c2dmr1335203f8f.36.1772153216601; Thu, 26 Feb 2026
 16:46:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226161500.775715-1-puranjay@kernel.org> <20260226161500.775715-2-puranjay@kernel.org>
In-Reply-To: <20260226161500.775715-2-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Feb 2026 16:46:45 -0800
X-Gm-Features: AaiRm50xaC2Prxw6mWgLcIFnkAPmH7tgK3JaWm_rThpb4meGO-Fhs4knaPUsvu4
Message-ID: <CAADnVQJjzd_r6SjXaxgz-OuJbpP7DkBM3DuspCgd8Nfy4M6iMA@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/8] bpf: Add KF_ACQUIRE and KF_RELEASE support for iterators
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 8:15=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Some iterators hold resources (like mmap_lock in task_vma) that prevent
> sleeping. To allow BPF programs to release such resources mid-iteration
> and call sleepable helpers, the verifier needs to track acquire/release
> semantics on iterator _next pointers.
>
> Repurpose the st->id field on STACK_ITER slots to track the ref_obj_id
> of the pointer returned by _next when the kfunc is annotated with
> KF_ACQUIRE. This is safe because st->id is initialized to 0 by
> __mark_reg_known_zero() in mark_stack_slots_iter() and is not compared
> in stacksafe() for STACK_ITER slots.
>
> The lifecycle is:
>
>   _next (KF_ACQUIRE):
>     - auto-release old ref if st->id !=3D 0
>     - acquire new ref, store ref_obj_id in st->id
>     - DRAINED branch: release via st->id, set st->id =3D 0
>     - ACTIVE branch: keeps ref, st->id tracks it
>
>   _release (KF_RELEASE + __iter arg):
>     - read st->id, release_reference(), set st->id =3D 0
>
>   _destroy:
>     - release st->id if non-zero before releasing iterator's own ref
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/verifier.c | 71 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 69 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bb12ba020649..c80e96c2c271 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1038,6 +1038,8 @@ static void __mark_reg_known_zero(struct bpf_reg_st=
ate *reg);
>  static bool in_rcu_cs(struct bpf_verifier_env *env);
>
>  static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta)=
;
> +static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta);
> +static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta);
>
>  static int mark_stack_slots_iter(struct bpf_verifier_env *env,
>                                  struct bpf_kfunc_call_arg_meta *meta,
> @@ -1083,6 +1085,22 @@ static int mark_stack_slots_iter(struct bpf_verifi=
er_env *env,
>         return 0;
>  }
>
> +/*
> + * Release the acquired reference tracked by iter_st->id, if any.
> + * Used during auto-release in _next, DRAINED handling, and _destroy.
> + */
> +static int iter_release_acquired_ref(struct bpf_verifier_env *env,
> +                                    struct bpf_reg_state *iter_st)
> +{
> +       int err;
> +
> +       if (!iter_st->id)
> +               return 0;
> +       err =3D release_reference(env, iter_st->id);
> +       iter_st->id =3D 0;
> +       return err;
> +}
> +
>  static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
>                                    struct bpf_reg_state *reg, int nr_slot=
s)
>  {
> @@ -1097,8 +1115,14 @@ static int unmark_stack_slots_iter(struct bpf_veri=
fier_env *env,
>                 struct bpf_stack_state *slot =3D &state->stack[spi - i];
>                 struct bpf_reg_state *st =3D &slot->spilled_ptr;
>
> -               if (i =3D=3D 0)
> +               if (i =3D=3D 0) {
> +                       /*
> +                        * Release any outstanding acquired ref tracked b=
y st->id
> +                        * before releasing the iterator's own ref.
> +                        */
> +                       WARN_ON_ONCE(iter_release_acquired_ref(env, st));
>                         WARN_ON_ONCE(release_reference(env, st->ref_obj_i=
d));
> +               }
>
>                 __mark_reg_not_init(env, st);
>
> @@ -8963,6 +8987,8 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, int regno, int insn_id
>                 /* remember meta->iter info for process_iter_next_call() =
*/
>                 meta->iter.spi =3D spi;
>                 meta->iter.frameno =3D reg->frameno;
> +               if (is_kfunc_release(meta))
> +                       meta->release_regno =3D regno;
>                 meta->ref_obj_id =3D iter_ref_obj_id(env, reg, spi);
>
>                 if (is_iter_destroy_kfunc(meta)) {
> @@ -9198,6 +9224,12 @@ static int process_iter_next_call(struct bpf_verif=
ier_env *env, int insn_idx,
>         /* mark current iter state as drained and assume returned NULL */
>         cur_iter->iter.state =3D BPF_ITER_STATE_DRAINED;
>         __mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
> +       /*
> +        * If _next acquired a ref (KF_ACQUIRE), release it in the DRAINE=
D branch since NULL
> +        * was returned.
> +        */
> +       if (is_kfunc_acquire(meta))
> +               return iter_release_acquired_ref(env, cur_iter);
>
>         return 0;
>  }
> @@ -14214,6 +14246,22 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>
>                 if (meta.initialized_dynptr.ref_obj_id) {
>                         err =3D unmark_stack_slots_dynptr(env, reg);
> +               } else if (base_type(reg->type) =3D=3D PTR_TO_STACK) {
> +                       struct bpf_func_state *fstate;
> +                       struct bpf_reg_state *iter_st;
> +
> +                       fstate =3D env->cur_state->frame[meta.iter.framen=
o];
> +                       if (fstate->stack[meta.iter.spi].slot_type[0] !=
=3D STACK_ITER) {
> +                               verbose(env, "expected iterator on stack =
for release\n");
> +                               return -EINVAL;
> +                       }
> +
> +                       iter_st =3D get_iter_from_state(env->cur_state, &=
meta);
> +                       if (!iter_st->id) {
> +                               verbose(env, "no acquired reference to re=
lease\n");
> +                               return -EINVAL;
> +                       }
> +                       err =3D iter_release_acquired_ref(env, iter_st);

This hunk looks generic since it acts on PTR_TO_STACK,
but it's extremely specific for one kfunc that is KF_RELEASE,
and in this patchset it happens to be bpf_iter_task_vma_release(),
but any future kfunc that accepts ptr_to_stack will fall into
this case and we will have a problem.
ptr_to_stack doesn't have to be an iterator and it doesn't have
to be this new special iter_st->id.

This whole thing screams "hack" to me.

I also don't like this save of 'id' from R0 and
auto-magic release of that 'id' during next _next() call.
Too much this kfunc and this iter specific things built into
very subtle verifier logic.

Also Amery is working on cleaning up id/ref_obj_id across reg types.
Currently pointers have id where id =3D=3D 0 is a valid id for packet point=
ers
and id > 1 gets cleared to zero for all.
Then scalars have id where id =3D=3D 0 is invalid.
Then dynptr have id.
And now iterators will have id that means something completely different?
It's saved acquired id returned from _next(). sigh.

KF_FORBID_SLEEP is ok-ish. I don't like it, but whatever.
trylock on every _next() is quite problematic.
And this repurpose of 'id' just breaks the camel's back.
Too many custom things across the verifier, kfuncs, iterators.

Sorry. This is no go.
We have to go back to the drawing board with the whole thing.

pw-bot: cr

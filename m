Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751F2C21E6
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770075607; cv=pass; b=re8csmRVDYNmR/59ReCg0P1KvwiAYaCGl6CNcFQ+eKB0HUIyaKqmw09ZxAxdRhr2AyE8c1azmhZFXPUbT3Ru/uOfAOxMG9YtTZz2AOUPEAJ6TXm8VOwHIrCJfflj993L10jk4KYUmbEw/zGJfM+IgwwEJ4u8yAPvBS2TSW0qsAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770075607; c=relaxed/simple;
	bh=d/4PHqC+8q/tKZn/tZq2NAmR55Jba9qxeMWuH7IIevg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQ+UvT41WDhfEBYsVqhpFMU49s+lmo1VZ621LubGD1tAD94LDkS0MmvxORmdaDOJegTsrw9+medj6wOzaE0XyMO+k24gClRGWkg5zwaGcb3JPDmpgKUMkY+tlRvqkt/FDw7CLI0gfqA8YLbGYbZ7g4Ek7M109/tB/ksgQI9u2qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7h0F2SA; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7h0F2SA"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-649605d3664so5668045d50.3
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 15:40:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770075605; cv=none;
        d=google.com; s=arc-20240605;
        b=ZMSBo6hR438xgsev7bK3Htp/lpgMhkj4RaXGHzyWFbRJVePiO8LMysOh3gzcy07OB4
         nmSNxInfPki3wTKjEARDdPXW9QwATgMOWZtmHoil1RUrpkXC3iWR2r15aCliMUU2A7O9
         rC5/3yYObZUe2vAjL8hDDGClCmz+uqjrBRhuzTcxY1Bc8rp11dB8lZ4Rm4ORS0VFaehs
         YmMSOJRbVcJwhLObNguz0x8dBhCSur2l2SXdSq9jFE7Ytxqd2HoJwvibg4LyWE+VC14d
         +/TDMw/HeikiMZfWHf+N1hhjRp76hm84nu8VXLqNQg8z5kX4OBpsacmFCTgSpdYZGC13
         BqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4HH9dV4RRnbaqS1byKBaPP2XgnUxuW8qreK1Jv1zuQM=;
        fh=YdDWaDljWJ5n0T9eCYK76ioNwJmtRLo9WZIZ41QkBks=;
        b=VU/0dSzcXSw9dN6GlklgUmBok+YcCBH0KhoOEPypv3OFZf3tXrdQMm8NTmVuReJQYV
         TCDLPxbQbx5pxuvfyM20Mze1hujRUJFARFp9LdN5ZcS0KFr0tW2300JmvKNwlqvNq/Me
         lZiWa/MJObPcjnb9rnJajKJVzA7EbhvKAN/WAWl2VDpkAIuC1RMY5G/voiMmUfrTWs5s
         SKS8MuXzfy3ycOejnlkWSKgFlyjUuGrjpt1E3v4Whmtd4d8ZHpMq8Ro9eteusTQihKv5
         fC8V7Rpb2KjR7VrFu0crByZUSNok0WTq0kWY27o0zMQC/EnE5EIa23UgeCJiv2lzCvJv
         /bJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770075605; x=1770680405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HH9dV4RRnbaqS1byKBaPP2XgnUxuW8qreK1Jv1zuQM=;
        b=h7h0F2SAWC3KFQY2tCrVyMspUmWt9Df4McF9PZhELLjDx2XialR6IB19dqEfJv5c6u
         3OzcnQZJgYw46SXQZUf0eh8ggUawRdZvwD04Naw1eEfk4Y0Pix4H/NgsyuQSocK5jcbc
         AsM37eZZ+QPkd0iN94CjgdbKK44ian9+rdUok0gnWtBKmPBSG/kpDs94vAKgtneY7dmk
         cGL3MA5GsKDk+YCq3Cd99rPzr9tQOiiZrlOzciZ9ovPX/7VlN+7KIwjK4nOetWiAY6f1
         p95VIbgWPd5Sr1RhOnYgJ+na430yxnhCtlH2nOtS3Bht5eRM5qujEXOucWJB+a/M9PJS
         paag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770075605; x=1770680405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HH9dV4RRnbaqS1byKBaPP2XgnUxuW8qreK1Jv1zuQM=;
        b=IA8JNhDBeXM2pLZyxwgEsodZHYuubGg4uJt0ue7+FqOC7/Dh86UOOe4NaRVw6/J016
         OES1VHtIx+cCildf9ZK696YJ8ZVQC0vnoijYFKH0r+uVFSJwCbTY2Cnl8R1GHlXL5gT+
         QOAz0dm2HeQSpyRy6bKHSSksVvTBvkC4WyUAlIjTrWfLssWp0CqahDD5olPo4qsO2kES
         /+0D6+83iYsVqBHZO1ctcaKZ58g3aiZx1kyPe3i3d/h7Ohhecl9l3yNiVq+OikXJx1Z1
         iMSWwQ0ruqiWv+71fH3DDcIo978pSXSKnTmzMDGwk5/fWss3mRjFyCkv3ZBRtxs+Upka
         AYgw==
X-Gm-Message-State: AOJu0YxG51kFrnsSPqEff2ITM3H8q0q2K14bauaVwZuicOe8+EzS4Bf7
	I15nV9Y6W0JZnit+PS261wAB2gkVenlc6f27GMtJzJsB6V/Z8EaaLw4iLLSWslpU9zZk5KXZaPB
	NcY67+ufXyy6uhlExj5ViFVfI2vf+yjI=
X-Gm-Gg: AZuq6aJZIFT96YFPS22/vnCi7JyFM2PaGldEZyM/+6AZt/OW704hbtSY+UI/29ReJ49
	k+OIaLsJKHXnQbFgID8FPu7fkmTvWC9Q9GVI9tvWMbOzMdSj5AOe1/AiMHa3Dcw3SGyG76pBVyy
	0iQFRRvzMQCBm4S15WjF4rI101Geu2M6GgXfpPRUXyMi7qiAJ+bEwBsYb0iAP8lkHjgWSuiohtF
	Ob//bIvfvVgZT2ZBO1mTKHrxKms63vJvK+fCzqpf/WgPC47/S/ZPeXXpUJ4aQNxvhgXoYA=
X-Received: by 2002:a05:690e:1486:b0:649:36f4:afb7 with SMTP id
 956f58d0204a3-649a84647f5mr11076549d50.29.1770075605146; Mon, 02 Feb 2026
 15:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202214817.2853236-1-ameryhung@gmail.com> <77f6c7cf5ed980f733fad13caf87baddedae6c1bbaa8e55db00a81828638dec3@mail.kernel.org>
In-Reply-To: <77f6c7cf5ed980f733fad13caf87baddedae6c1bbaa8e55db00a81828638dec3@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 2 Feb 2026 15:39:54 -0800
X-Gm-Features: AZwV_Qg5iGE7_oTNtKvKninvgG8pNqygpI5JosEyD2JMt1ubCtCeqspUbTTVL9k
Message-ID: <CAMB2axNRZtGGgGxiEsNCi3Dz7PTDOi_B71RgzeWLJ_=RaQGpJQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/4] bpf: Fix and refactor object
 relationship tracking
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 2:23=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6b62b6d571..a357e03051 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -10481,22 +10464,43 @@ static int release_reference_nomark(...)
> >  *
> >  * This is the release function corresponding to acquire_reference(). I=
dempotent.
> >  */
> > -static int release_reference(struct bpf_verifier_env *env, int ref_obj=
_id)
> > +static int release_reference(struct bpf_verifier_env *env, int ref_obj=
_id, bool acquired_ref)
> >  {
> >       struct bpf_verifier_state *vstate =3D env->cur_state;
> >       struct bpf_func_state *state;
> >       struct bpf_reg_state *reg;
> > -     int err;
> > +     int err, spi;
> >
> > -     err =3D release_reference_nomark(vstate, ref_obj_id);
> > -     if (err)
> > -             return err;
> > +     if (acquired_ref) {
> > +             err =3D release_reference_nomark(vstate, ref_obj_id);
> > +             if (err)
> > +                     return err;
> > +     }
> >
> >       bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > -             if (reg->ref_obj_id =3D=3D ref_obj_id)
> > +             if (reg->ref_obj_id =3D=3D ref_obj_id) {
> >                       mark_reg_invalid(env, reg);
> > +                     if (reg->id && reg->id !=3D ref_obj_id) {
> > +                             err =3D release_reference(env, reg->id, f=
alse);
> > +                             if (err)
> > +                                     return err;
> > +                     }
> > +             }
> >       }));
> >
> > +     bpf_for_each_spilled_reg(spi, state, reg, (1 << STACK_DYNPTR)) {
> > +             if (!reg || !reg->dynptr.first_slot)
> > +                     continue;
> > +             if (reg->ref_obj_id =3D=3D ref_obj_id) {
> > +                     __unmark_stack_slots_dynptr(env, state, spi);
> > +                     if (reg->id && reg->id !=3D ref_obj_id) {
> > +                             err =3D release_reference(env, reg->id, f=
alse);
> > +                             if (err)
> > +                                     return err;
> > +                     }
> > +             }
> > +     }
>
> Does this loop only scan dynptrs in the current frame?
>
> The bpf_for_each_reg_in_vstate macro sets 'state' to each frame in sequen=
ce:
>
>     for (___i =3D 0; ___i <=3D ___vstate->curframe; ___i++) {
>         __state =3D ___vstate->frame[___i];
>         ...
>     }
>
> After the macro completes, 'state' holds the last assigned value, which i=
s
> vstate->frame[vstate->curframe] - only the top frame.
>
> The subsequent bpf_for_each_spilled_reg loop uses this 'state' variable,
> so it only scans STACK_DYNPTR slots in the top frame. Dynptrs residing in
> caller frames (frames 0 through curframe-1) would not be found.
>
> When a BPF program creates a dynptr in frame 0 and then calls a subprog
> (frame 1) that releases the parent object, the dynptr in frame 0 would no=
t
> be invalidated. The selftest bpf_qdisc_fail__invalid_dynptr_cross_frame.c
> appears to test this exact scenario.
>
> Should the bpf_for_each_spilled_reg loop be wrapped in a loop over all
> frames, similar to how bpf_for_each_reg_in_vstate_mask handles it?

AI is right, it should loop through all frames. The selftest fail to
catch this because free_skb is inlined. Will fix the bug and add
__noinline to free_skb().

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/216081=
54622
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit demonstrates deep domain expertise =
with detailed ASCII diagrams, uses standard kernel conventions, and the bug=
 is a typical human oversight from misunderstanding macro variable scoping.
> issues-found: 1
> issue-severity-score: medium
> issue-severity-explanation: The dynptr invalidation loop only scans the t=
op frame, potentially missing dynptrs in caller frames when parent objects =
are released, which could lead to use-after-free in the BPF verifier.

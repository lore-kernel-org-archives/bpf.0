Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612E2874E3
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221131; cv=pass; b=sq17EtAToLvrnfcNjngb+opyKE68B1HRixcTfUhafJzFtcbSGf/BuwWEI1f0EDbHj27bR/7SvDj7TihHx8RgYNxeDMVwgi34nGTbtk72cDFHlEKjpR/pe2mkz+jH397tq4OMiKS3aVNGr49CYAUgYFoUvyL3is+/8rYvjGlKzKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221131; c=relaxed/simple;
	bh=vMHyaQd3mfK40MNsuooAQ762LxgJPrshxZ7MJzn5ZqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fg+inDlqaS/iei6yPk/ENhden7qwoU+IsFughVvGH7EQy+BsYedoXd7Ac+kyq1mI1YbNf7QBwxJa6aiR5l++34c3gS6uKs1AizYG02j/YsYQb6NA2SJacuTLnfEOoFkn5aa4Qu3TqYtHqAA7be7Bz7NVXrvs5BY8tKnNP4Tr+Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L32Cqjg2; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L32Cqjg2"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7b4ee3a88e1so36859747b3.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 13:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779221128; cv=none;
        d=google.com; s=arc-20240605;
        b=PubeW1Gri4gGKmFX6A/ZypDXYpmSBz7Hk0EOS1ZaH0iAjikRB6q1ts2aj1Kr/Y0L+J
         7G79J4+4bnvc6wzCspE5vnBFGPRWT/RhIcdSr2hEeoDI3GlH6fdSLUT5/sRWyS25wBYB
         swEaOycU18XDytZ877BxA3i1Cy/M40sKro2oFWtz8tWf8adb7/5/cHoEPQ+78Iuk5pV7
         yeiJGJd/KSTqNwA+eW29X7vyP35jjaw0rKxmOe+axlKOu28DAPfvazqBcsQQu6eXT3e5
         pANVaCDv4Ci6Rii1N0i9Eaw+FormyqO35OrPjAwVLa24Gf38zu0fDvHFlMkIE9THRRJf
         TtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SC/K1ivFHTPQh2xDJ2Hb1L4zl8Ws5/LljHDje3fKKHI=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=TMc2jjYWDuB2Va2hcUltWApPmgxZnA3pv4Drb4qlsU52RjhVb4KvLNotHGQaunnyH2
         q+YSbaYx49whhPtuysrzY8xUU6r18TV0NdvajLZf0n0tzl0OmQdZPnkgGFmTpWVW3jgq
         JB1Md/G18YFaUGJZoMhTWoPNTyVpwlDsyADCtNFTuD09x4wO8wGX27NUeZ5E3ixjSHC7
         RdM9rj3gDwRZBjKdXvO/mW8Br1ZwSfftNzNz82ZJ99GrYa0fdnjf1D/eZhIzFs4P3/Hh
         N19Pb36tBTHu3WiOQLgnA9UgkukmCgfvVRiEbKTWB04bzCihUKSLY8G+ka3QaF19osBS
         jzAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779221128; x=1779825928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC/K1ivFHTPQh2xDJ2Hb1L4zl8Ws5/LljHDje3fKKHI=;
        b=L32Cqjg2ERyR2BJb/sjVZfEvFHi7U0ezLW+DuZY7Ah/Kss3XP/dJ/mNh5r8QgfP8XB
         VQpS/9HBjh/KvWjuNyrbIhZnztwwhonN6wdjNXj31c3jq4z0EsHv+gVfOgHJ1ER7hszw
         xwyuGquc9HeyOgNqYWNXbhPbG7va2tZfbQujn450ce2wDhiGmOtYQI1FVhADLrkO+2GX
         Pil57SmMHW04H8NgoNe1ghia0tdmZi0Ap1g2B+g0ek/x8TxcBfq9R9aS13nynUUPhaY5
         zFdsukpGwsgStcXDg1gwhN6BHcN6SvhNfg0AyuQgL9ECHw1ZuTkXT+DG/E5pWpF5xpRv
         0Pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779221128; x=1779825928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SC/K1ivFHTPQh2xDJ2Hb1L4zl8Ws5/LljHDje3fKKHI=;
        b=m6LiDV3YBUaaC2Q0Ac7TxZ54SLuf+CSeVEP9NjnGfk4Z4fAlzP2X/QrZ8CIEvSs2VS
         CK7T9R/REnPcY+ODnHg+Cyg8X2PZlAS7FCaC5uAWoMOiR9jjPoGyiihzZUtsxfHbgpYv
         ygZYRuc//llngcJee1Ke2+Lg2q5EVbQhCO2wl52o9k/H4sItIuaDjWIUEZEw0aXOzTP6
         IvHPuCLqGVOpLUgdXEwlaI1eAIPUDfoxpbyMV5tHYVCFbAtNDam5l/sR0sQAC+tmvU39
         kFJZwSmU37peekANe87VaTzhmHSgtcnpPW5qJxwp7hQ+VgdlctLlaK8iMHT4rsNQy4yZ
         oQUQ==
X-Gm-Message-State: AOJu0Yx2L9LNDUO4NlttY2J23Wi1t0SKZe/cbagjeriE0rKqr58EWdt+
	VvPx4+Q1XOeut/Q05EAo3B9xPrpn03AfG2tDunf8d2ORAPUoWZHPuvYZkYF6Lj0zGwOUf2YOLGB
	M2L+HaZc4DIsFqffed7m5qNsNL0Zraoc=
X-Gm-Gg: Acq92OFCh+twjPMW6sBDZAju9xfvcRD9jSD2ltTHeHNjyT3H2VogdmJAVhKv6fRNC7D
	4BzxwFsYFHnu0qJ3+6Jm9/jLFofFYZLFzl0S3mT/5vppAg45jCjs94kn4cKXthPbplmqlmo0ta2
	KTL0rjvYxsfPaTtI74JFW7+gxtFEBF6RA4kjX5uuec22C3ZfIqVepbUzHajkRCcWDQVU8ZdYQaQ
	ZULXpdnOK+6W9rHAnar8ljVqrtO3pp0rcbLV0rKrH6W/J/gE/yy7we0SqSM6bOEAZgtNW0cdWIb
	V3coMag1R4BnhxYZSowQ
X-Received: by 2002:a05:690c:6d84:b0:79a:d2ba:3c24 with SMTP id
 00721157ae682-7c95cbe8677mr237464337b3.41.1779221127771; Tue, 19 May 2026
 13:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519181314.2731658-11-ameryhung@gmail.com> <20260519190330.207401F000E9@smtp.kernel.org>
In-Reply-To: <20260519190330.207401F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 19 May 2026 13:05:14 -0700
X-Gm-Features: AVHnY4JwyneWSluDEtuKcGNVmJPkvn_RkvdXyGAvQpH4-Hq_0A1isckPojyQxII
Message-ID: <CAMB2axMoGXL1bD7kCW2VC7gJ9Qsbg8rm84cmT-PHJLA97bE8vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 10/14] bpf: Fix dynptr ref counting to scan
 all call frames
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:03=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] The macro `bpf_for_each_reg_in_vstate_mask` incorrectly comp=
utes the `stack` pointer when iterating over outgoing stack arguments. The =
new `dynptr_ref_cnt` function uses this macro and dereferences the invalid =
pointer, leading to a verifier crash or security bypass.
> --
>
> commit 2fbeda3e91d76b77c3a4fe5a3269d7a89c9d8588
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Fix dynptr ref counting to scan all call frames
>
> This commit extracts dynptr reference counting into a new dynptr_ref_cnt(=
)
> function to check whether a referenced dynptr can be overwritten. It uses
> bpf_for_each_reg_in_vstate_mask() to scan dynptr stack slots across all
> call frames instead of just the current frame.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b7984c42ca145..97eb8033d732e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -786,10 +786,29 @@ static void mark_reg_invalid(const struct bpf_ver=
ifier_env *env, struct bpf_reg_
> [ ... ]
> > +static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_i=
d)
> > +{
> > +     struct bpf_stack_state *stack;
> > +     struct bpf_func_state *state;
> > +     struct bpf_reg_state *reg;
> > +     int ref_cnt =3D 0;
> > +
> > +     bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack=
, 1 << STACK_DYNPTR, ({
> > +             if (!stack || stack->slot_type[0] !=3D STACK_DYNPTR)
> > +                     continue;
>
> [Severity: Critical]
> Does bpf_for_each_reg_in_vstate_mask() safely provide the stack pointer w=
hen
> iterating over outgoing stack arguments?
>
> Looking at the macro definition in include/linux/bpf_verifier.h:
>
>     bpf_for_each_spilled_stack_arg(___j, __state, __reg) { \
>         if (!__reg)                              \
>             continue;                        \
>         __stack =3D &__state->stack[___j];         \
>         (void)(__expr);                          \
>     }
>
> When iterating over outgoing stack arguments, it calculates __stack using=
 the
> local stack array (__state->stack). Since out_stack_arg_cnt is independen=
t
> of allocated_stack, __state->stack could be NULL.
>
> If ___j > 0 and __state->stack is NULL, __stack would evaluate to a non-N=
ULL
> offset. Would this bypass the !stack check above and result in an
> out-of-bounds read or page fault when evaluating stack->slot_type[0]?
>
> Additionally, if __state->stack is valid, could this evaluate the same lo=
cal
> stack slot twice, artificially inflating ref_cnt and potentially bypassin=
g
> the ref_cnt <=3D 1 check?

Sashiko already pointed out the issue in patch 5. The fix is to assign
NULL to __stack for stack args and then the existing !stack check will
be enough.

>
> > +             if (!stack->spilled_ptr.dynptr.first_slot)
> > +                     continue;
> > +             if (stack->spilled_ptr.parent_id =3D=3D v_parent_id)
> > +                     ref_cnt++;
> > +     }));
> > +
> > +     return ref_cnt;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519181314.27=
31658-1-ameryhung@gmail.com?part=3D10

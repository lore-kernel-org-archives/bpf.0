Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81FD1B85F8
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773464494; cv=pass; b=PCxelDq7eyhxFZMbx2VmnGC15bi5qjxwtzJmf0UkoSWLLjEixrWcE6mqjsWAaTac3ZOfs3ka3HiNmzfAI/F4ymIPhLOb/98Av1VcnCibeqywTYYm6FEojMlyH89XJhC1A8y3C3bmrqQt/EEvd0vSOcUk1AiMBvUNIyGm74+Rveo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773464494; c=relaxed/simple;
	bh=aQDs4Uml+CxT9cFbp7u+iH/9cvd4fneI1C69cH9kB+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeT0/J7ienZb2/7PFP6JEcTgEqfyx5d3/WkSRI7cwo2rxpH9RGawbFtRNQmngnV1pbCisO5e3h4f4N6knC5r+kRVAOXw5ObwrP81pIJbl+EVv8MHKbsl2sgCdzK3FZijBhAYplyg+hmTnbXyjK0/jXKqqCFjDkE48VL7xMg3dZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krBTyKin; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krBTyKin"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5fff774800cso1841635137.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773464492; cv=none;
        d=google.com; s=arc-20240605;
        b=NsP+QRJ/cMFDR0oV8xuul6l2XRE/XftPc4Kn4ldUH5XOePc3Xdm3c6DcC7kxrlytCy
         ObhVug+AnX3jxPhCueApVAV69kUHmktPbEIaxra5oQHU/tjFK1oo16QMbITFcxCSCMVX
         zFQRS7aDPVotr3pA20f5tr2VEm/AsbVfwliN6JUD+BS0OlyDPDqH9zs6PmmWQbegjx/z
         ZnCCfENAuzM95RvV5mA+6aYXq2d1ouxX6rQ2hWDce+Wnumi6zUfFcRYlNT2ulHeGnsaX
         4qxiDfaTy7J+vITypv9qtrb7nUYMGFM6OrYz3KghWrvs3G2vUVzAo5Pvgq/lL53l1Qoo
         gHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pk/hbFXxXZKjMAj8xs5MqtSk+kzcPW92HQ6uCffEAIQ=;
        fh=Y/zSG2tfaLrVIOVIi9D8TccFClBUbPTqIN16PJazcx8=;
        b=K7k4zb8U3htsVjcI4FVlPuAsz54dYQtLS6OHwcjBrNhPJxeQeHek4jJLep0G6PWfOl
         U4IzSsQli+owW2jTHXYcevCw6ZrUvJls3qvSL/XBKuXyKLQRTdar7GPiNv7nb2EmwMdB
         spwb/WyKkw9BJyD5UOW9pkt8xNsbD45RLLYkXmVJQT6qeTtsOmxlncbZ9Z6dLOxDZ/wn
         /hHn+iwgNtySWdjVXFNrvxDsMf7dLeBQzQKgbHtCknkeuWy1NVpB0ZQINGwtkXw9No5J
         cnU+ILkuGCWjrOIr6ORRjxtbAcnIx1fjsGj915dUYILJy20pg59oH2uodJhsPDpGvTYa
         77gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773464492; x=1774069292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pk/hbFXxXZKjMAj8xs5MqtSk+kzcPW92HQ6uCffEAIQ=;
        b=krBTyKin23PsDaGfU7a+bg9CLj1t6vNzUnEHxvgTzmCeudX/3eCYXMk4UK5eRX88nc
         LhQfPw4Cz3SlWUZy2ifim6VCokpRN5t1Cy4glJ/y/mo9JeiDWH9tLsXPCApb8zbUNMZW
         tpwSWCSubNnKc8CR5guhR1sd2tCqmZFtPq7ifdcV21iD2OKgx0408/iruWm9ruwYsmj9
         0Nmwjadw1pEvtAiqkjNLsVU5f/wJKjuORwMXEYrSXV5v+y0AfRiEvHoa310jcyJWVYhX
         uOtDMKzEyNx7fa3kE6XS30Mmgmqde2QyyiynCv0Cpd7dVIqTNwAyPYd3mX9KmB0hnQOi
         CHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773464492; x=1774069292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pk/hbFXxXZKjMAj8xs5MqtSk+kzcPW92HQ6uCffEAIQ=;
        b=j+pIbOXswb5+DoggN0LFC4QmA3lZAd5xP1SB8wTATRgYYJSfIur0aYgUlbC0qZJXKW
         Fu0uMyjT13/8Mm3zM4jc5D9jXGhGAVzbRvBp2GSeQ9c966YkaJ1Yk+Xfmx3Skw1zLkj7
         ua9hDNKpRGWp+ol/8oGQtTrrvszKGajcO1HjaeTg6BoAWMlGg+uHWPI6XQKjHApqi7gZ
         bCNsmfTnmr9xDOE4szAIgX5QDgt/WQs27Jv4UVnVzNrnWjY+64HzHL7HH+BR4scSdt2Z
         oL5edg64kGDPDGabD3mOPND6KFie9zrWtB/5NPNsVv7EFT64qYLVCiwL1zp3y/vz6Xn1
         pPAA==
X-Forwarded-Encrypted: i=1; AJvYcCVDyph2oXa1J0QRwHWlnCKMtkSxaig6dUeOD3vIoafFnLtBWYODZYZwZHGsOCNy8RfgFiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHY8TLiUX13hFR0z6HZI1eb5sI21a5jlHXRjaidHVLVjpz5Ey
	T2nEwfg66Ej9bcgAtl9aeL1E9slcub+cjcvnztk15BJGy2Ee+K6bV2/q4ui0est8pAgrSFKHvro
	PvyA+qXLkBsSZzmCAeN+JV3/akwYczCM=
X-Gm-Gg: ATEYQzxy135DgvC7MMztlbryBEnGNq6Lr8U7ZF0sMW13uCuX2of6K5j6SHULw6kzTwH
	11Lo7nMr2K1uvNw79WkaJAB7DlDHQUiYdasIBdsIMrNozRy/4nSV9u5SjuTKWbaNaqFa2dgErJd
	t0FGVz8QjLUlTkld1/GgV6/3ki/XN/2DvSOeD49XG8TQDq9z0E5cv/agIwkCU89VCI7x89NoTGg
	Q/QU23Z1KoU44cHYw/WsyAxLV00XyRBHEfXb91lNkx6XwlQcLlcDY2B3OjFXj9YouMDcJWXqQoR
	xgPMP8FzlonQl4axLkk/pTY6GQ+F7+z6HloBXP4W
X-Received: by 2002:a05:6102:5124:b0:5ff:ef58:2f99 with SMTP id
 ada2fe7eead31-6020e53a9f0mr2924378137.23.1773464491412; Fri, 13 Mar 2026
 22:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773441432.git.paul.chaignon@gmail.com> <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
 <a41262218c37af754dda48811b3a165341c92028.camel@gmail.com>
In-Reply-To: <a41262218c37af754dda48811b3a165341c92028.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Sat, 14 Mar 2026 01:01:15 -0400
X-Gm-Features: AaiRm50DoT3VSTavyj8nMx0ZAWFLlFwOVr5Kohj_UK2f1FDKnIuKV9_9piX57so
Message-ID: <CAM=Ch06pLOWKx4D=sVJ5oqCCy6R_N9Lxv7t-UV_yQCjFhBtO+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Simulate branches to prune based on
 range violations
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 8:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-03-13 at 23:54 +0100, Paul Chaignon wrote:
> > From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> >
> > This patch fixes the invariant violation warnings. These warnings
> > happen after we refine ranges & tnum based on an incorrectly-detected
> > branch condition. For example, the branch is always true, but we miss
> > it in is_branch_taken; we then refine based on the branch being false
> > and end up with incoherent ranges (e.g. umax < umin).
> >
> > To avoid this, we can simulate the refinement on both branches. More
> > specifically, this patch simulates both branches taken using
> > regs_refine_cond_op and reg_bounds_sync. If the resulting register
> > states are ill-formed on one of the branches, is_branch_taken can mark
> > that branch as "never taken".
> >
> > On a more formal note, we can deduce a branch is not taken when
> > regs_refine_cond_op or reg_bounds_syncreturns an ill-formed state
> > because the branch operators are sound (formally verified). Soundness
> > means that the verifier is guaranteed to produce sound outputs on the
> > taken branches. On the non-taken branch (explored because of
> > imprecision in the bounds), the verifier is free to produce any output.
> > We use ill-formedness as a signal that the branch is dead and prune
> > that branch.
>
> So, the argument here is that only the following transitions are
> possible:
> - reg_bounds_sync(valid reg) -> reg_bounds_sync(valid reg)
> - reg_bounds_sync(invalid reg) -> reg_bounds_sync(invalid reg)
> - reg_bounds_sync(invalid reg) -> reg_bounds_sync(valid reg)
>                                   but this is sound, albeit imprecise
>
> right?

This is correct, but the main argument is that regs_refine_cond_op is
sound, which means that along a branch *that can be taken*,  the output
abstract values will always contain the concrete values possible on that
branch, given the branch condition. If a branch *cannot be taken*, there
are no guarantees,  output abstract values can be either well-formed
or ill-formed.
Soundness thus also implies that if we ever find ourselves in a state with
ill-formed register values, we must be on a branch that cannot be taken.
This can actually be detected using regs_bounds_violation and we can
prune that branch.

Your point about reg_bounds_sync also holds. reg_bounds_sync gets
its inputs from regs_refine_cond_op. Either of the 3 cases you mentioned
can happen. In case 3, regs_refine_cond_op could produce invalid bounds,
which are then "corrected" by reg_bounds_sync to valid bounds.
It is for this case that we insert the range_bounds_violation check both
after regs_refine_cond_op and after regs_bounds_sync.

> > We have had five patches fixing specific cases of invariant violations
> > in the past, all added with selftests:
> > - commit fbc7aef517d8 ("bpf: Fix u32/s32 bounds when ranges cross
> >   min/max boundary")
> > - commit efc11a667878 ("bpf: Improve bounds when tnum has a single
> >   possible value")
> > - commit f41345f47fb2 ("bpf: Use tnums for JEQ/JNE is_branch_taken
> >   logic")
> > - commit 00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign
> >   boundary")
> > - commit 6279846b9b25 ("bpf: Forget ranges when refining tnum after
> >   JSET")
> >
> > To confirm that this patch addresses all invariant violations, we have
> > also reverted those five commits and verified that their related
> > selftests don't cause any invariant violation warnings anymore. Those
> > selftests still fail but only because of mis-detected branches or
> > less-precise bounds than expected. This demonstrates that the current
> > patch is enough to avoid the invariant violation warning AND that the
> > previous five patches are still useful to improve branch detection.
> >
> > In addition to the selftests, this change was also tested with the
> > Cilium complexity test suite: all programs were successfully loaded and
> > it didn't change the number of processed instructions.
> >
> > Fixes: 5f99f312bd3b ("bpf: add register bounds sanity checks and saniti=
zation")
> > Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dc950cc277150935cc0b5
> > Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail=
.com>
> > ---
> >  kernel/bpf/verifier.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 52 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 974305ef3210..bd3bdfb6b0c1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16676,6 +16676,57 @@ static void find_good_pkt_pointers(struct bpf_=
verifier_state *vstate,
> >       }));
> >  }
> >
> > +static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf=
_reg_state *reg2,
> > +                             u8 opcode, bool is_jmp32);
> > +static u8 rev_opcode(u8 opcode);
> > +
> > +/* Learn more information about live branches by simulating both branc=
hes being taken using
> > + * regs_refine_cond_op. Because regs_refine_cond_op is sound when the =
branch is taken, if it
> > + * produces ill-formed register bounds, it must mean that the branch i=
s dead.
> > + */
> > +static int simulate_both_branches_taken(struct bpf_reg_state *false_re=
g1,
> > +                                     struct bpf_reg_state *false_reg2,=
 u8 opcode, bool is_jmp32)
> > +{
> > +     struct bpf_reg_state false_reg1_c, false_reg2_c, true_reg1_c, tru=
e_reg2_c;
>
> struct bpf_reg_state size is 112 bytes, so the above takes ~448 bytes
> of kernel stack. So far we tried to reduce the stack usage by moving
> big temporaries/buffers inside bpf_verifier_env.
>
> An additional benefit from storing these registers in `env` is that
> there would no need to recompute registers state in check_cond_jmp_op().

We were considering exactly that! It is definitely wasteful to do the
same computation
immediately in check_cond_jmp_op after forking the verifier state.
Moving the buffers
to bpf_verifier_env seems like a great idea.

> > +
> > +     /* Create copies of reg states to simulate both branches because =
regs_refine_cond_op
> > +      * will modify the reg states passed in.
> > +      */
> > +     memcpy(&false_reg1_c, false_reg1, sizeof(struct bpf_reg_state));
> > +     memcpy(&false_reg2_c, false_reg2, sizeof(struct bpf_reg_state));
> > +     memcpy(&true_reg1_c, false_reg1, sizeof(struct bpf_reg_state));
> > +     memcpy(&true_reg2_c, false_reg2, sizeof(struct bpf_reg_state));
>
> Nit: there is (a now useless) wrapper for this: `copy_register_state`/
> > +
> > +     /* Fallthrough (FALSE) branch */
> > +     regs_refine_cond_op(&false_reg1_c, &false_reg2_c, rev_opcode(opco=
de), is_jmp32);
> > +     /* If there is a range bounds violation in *any* of the abstract =
values in either
> > +      * reg_states in the FALSE branch (i.e. false_reg1, false_reg2), =
the FALSE branch must be
> > +      * dead. Only TRUE branch will be taken.
> > +      */
> > +     if (range_bounds_violation(&false_reg1_c) || range_bounds_violati=
on(&false_reg2_c))
> > +             return 1;
>
> How hard would it be to modify reg_bounds_sync() such that it
> preserves invariant violation? Thus avoiding the first round of
> range_bounds_violation() checks.

We can exit early in reg_bounds_sync by detecting ill-formed inputs
(using reg_bounds_violation itself), and have reg_bounds_sync preserve
the invalid bounds.
Unsure if preserving invalid inputs is a good idea for
reg_bounds_sync. Or if we should be
calling __mark_reg_unbounded on invalid inputs.

> > +     reg_bounds_sync(&false_reg1_c);
> > +     reg_bounds_sync(&false_reg2_c);
> > +     if (range_bounds_violation(&false_reg1_c) || range_bounds_violati=
on(&false_reg2_c))
> > +             return 1;
> > +
> > +     /* Jump (TRUE) branch */
> > +     regs_refine_cond_op(&true_reg1_c, &true_reg2_c, opcode, is_jmp32)=
;
> > +     /* If there is a range bounds violation in *any* of the abstract =
values in either
> > +      * reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the=
 TRUE branch must be dead.
> > +      * Only TRUE branch will be taken.
> > +      */
> > +     if (range_bounds_violation(&true_reg1_c) || range_bounds_violatio=
n(&true_reg2_c))
> > +             return 0;
> > +     reg_bounds_sync(&true_reg1_c);
> > +     reg_bounds_sync(&true_reg2_c);
> > +     if (range_bounds_violation(&true_reg1_c) || range_bounds_violatio=
n(&true_reg2_c))
> > +             return 0;
> > +
> > +     /* Both branches are possible, we can't determine which one will =
be taken. */
> > +     return -1;
> > +}
> > +
> >  /*
> >   * <reg1> <op> <reg2>, currently assuming reg2 is a constant
> >   */
> > @@ -16832,7 +16883,7 @@ static int is_scalar_branch_taken(struct bpf_re=
g_state *reg1, struct
> > bpf_reg_sta
> >               break;
> >       }
> >
> > -     return -1;
> > +     return simulate_both_branches_taken(reg1, reg2, opcode, is_jmp32)=
;
> >  }
> >
> >  static int flip_opcode(u32 opcode)

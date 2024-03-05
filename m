Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0381C2BD
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665432; cv=none; b=V0rekhT26Btxss4X9pZb2tchv4PqnUXxznR9xr497MZQ6Qz8gZ5u5myMvdERWGSsEo6pXJM9KddBCmaRYrIDjgJMc9RAD6oa0AGn0ut8nV3XvtUoiThoY9xAiL6vJqiKV2d0fvvZk8yHY/4QV142uXyCyBju0rvglzngse21SXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665432; c=relaxed/simple;
	bh=rmmGRYx43MjM4TUG5qgJFl3i47m2hCGmdpg0+e0kgq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkcmsaerkQC4Bt2xtFVdFIZsasgiyk0tZk3Z93iOiv/kSIF/vLfGGNNfClUlYCTLChsIYmAFSCDUlrRkj/mc85qqQqPXb90FX9VVr5lTyC4M5Io/ohrnJWt5vCX8msE6iCrhhjc21+ugDUUQjXrPPszjpQoO6i+x2vmmG4t8AVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Me34NFkd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me34NFkd"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-299d3b09342so71938a91.2
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 11:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709665430; x=1710270230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nFKQAgntPsabUMKhijS9tOO6R2NrFtq12FfMHfx09M=;
        b=Me34NFkd25hZyVPbBealhJKNt+1zU4fV4yff3mADp+pdbIV8uT44pFyP5jwswMR9kp
         JX7tcSWhLakUF9Ct//MR8g77kTedpBoislGMBzxOJ1+VqvYUDlT5mEqMKv3EuztwOclx
         16qgMrImKkbxF/g3lMj6avjs4KPsMaY79sW6iM/9B0pI5/zyPj6nqWcixAoog1OPWCQM
         qUGf+UQaDgiJWNWdztjDrCNZBACch3qokSfnLgSAFD57vPwkb8WiDO5yKq+f/pFbgtWa
         9Jf99w4CLEfzxSZEnqoQFKZpQAn9BG4tgHH+Ewk/nk08B/JxNU8O9dDavjO77Vq1tHFY
         cSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665430; x=1710270230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nFKQAgntPsabUMKhijS9tOO6R2NrFtq12FfMHfx09M=;
        b=WTw7F7crx/SuPaBBMBnNRjdUK3QJR7mP9CKyyVfGhTt+veAR6Jn2aKKuwzH3C550gD
         109mN8N7A2860rVwkvKwFAzZomUJhFOriyCCbBLlSK4YrPOucuqCnASGB+srxpvPrHae
         miKpLsKnhF57c4HNhewuDyVhsuoeSGeUTmE9IjCN0U1XTWIr72UkST7u5wqOOe25Y4XX
         gtfTrGdtgf4F8tVbhDQ7sKf6B1I0HLKlv9D4BGuRU3ppV21s+5fk0L8nexd/taJxRzYI
         o0sECIOcZrOKQOdZVZPFl1PJS6Ok0j90NDN+ECrpov5OL9SY4Y/1f5Vyv0HKWzGEfXWt
         2vHg==
X-Gm-Message-State: AOJu0YzcL1YDYvz3cA1DOe2nRniSoEflhEJ3934RF6RhvVXSUh433Hm5
	y+SRW9ZowaGTeOwOpRV48AL0VgRqVr01oJD2NokZrBGhsk9e305abhW8EwiK0y2mpsXm0V2FSV/
	6ZAI/TGYxgR6CkrlDSAS7GchKvRg=
X-Google-Smtp-Source: AGHT+IFoYvFzZakCTe/91gOHkM+zAW0/uyin321So4LwLwhZCtQDu4h+UmN7/glQOLvrrh0vUTOA6g1h9H2YcUbTtlQ=
X-Received: by 2002:a17:90b:124a:b0:29b:4755:23fc with SMTP id
 gx10-20020a17090b124a00b0029b475523fcmr6363172pjb.33.1709665429773; Tue, 05
 Mar 2024 11:03:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305045219.66142-1-alexei.starovoitov@gmail.com> <20240305045219.66142-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20240305045219.66142-3-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 11:03:37 -0800
Message-ID: <CAEf4BzbvBwcCU2dHwDKdY1HC2z8yo_Tv_=23KOT7UaP1867fGQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/4] bpf: Recognize that two registers are
 safe when their ranges match
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com, 
	john.fastabend@gmail.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 8:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> When open code iterators, bpf_loop or may_goto is used the following two =
states
> are equivalent and safe to prune the search:
>
> cur state: fp-8_w=3Dscalar(id=3D3,smin=3Dumin=3Dsmin32=3Dumin32=3D2,smax=
=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xf))
> old state: fp-8_rw=3Dscalar(id=3D2,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=
=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xf))
>
> In other words "exact" state match should ignore liveness and precision m=
arks,
> since open coded iterator logic didn't complete their propagation,
> but range_within logic that applies to scalars, ptr_to_mem, map_value, pk=
t_ptr
> is safe to rely on.
>
> Avoid doing such comparison when regular infinite loop detection logic is=
 used,
> otherwise bounded loop logic will declare such "infinite loop" as false
> positive. Such example is in progs/verifier_loops1.c not_an_inifinite_loo=
p().
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

You haven't updated stacksafe() to work with enums (the code still
assumes bool), please adjust.

pw-bot: cr

Also, I wonder if we actually need three cases. We need EXACT only for
infinite loop detection, right? I wonder if that infinite loop
detection is actually that useful in practice, I rarely encounter it
(if at all), and it constantly causes issues.

What if we just dropped infinite loop detection logic altogether and
have NOT_EXACT vs RANGE_WITHIN logic only?

>  kernel/bpf/verifier.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 226bb65f9c2c..74b55d5571c7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16254,8 +16254,8 @@ static int check_btf_info(struct bpf_verifier_env=
 *env,
>  }
>
>  /* check %cur's range satisfies %old's */
> -static bool range_within(struct bpf_reg_state *old,
> -                        struct bpf_reg_state *cur)
> +static bool range_within(const struct bpf_reg_state *old,
> +                        const struct bpf_reg_state *cur)
>  {
>         return old->umin_value <=3D cur->umin_value &&
>                old->umax_value >=3D cur->umax_value &&
> @@ -16419,21 +16419,26 @@ static bool regs_exact(const struct bpf_reg_sta=
te *rold,
>                check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
>  }
>
> +enum exact_level {
> +       NOT_EXACT,
> +       EXACT,
> +       RANGE_WITHIN
> +};
> +
>  /* Returns true if (rold safe implies rcur safe) */
>  static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *=
rold,
> -                   struct bpf_reg_state *rcur, struct bpf_idmap *idmap, =
bool exact)
> +                   struct bpf_reg_state *rcur, struct bpf_idmap *idmap,
> +                   enum exact_level exact)
>  {
> -       if (exact)
> +       if (exact =3D=3D EXACT)
>                 return regs_exact(rold, rcur, idmap);
>
> -       if (!(rold->live & REG_LIVE_READ))
> +       if (!(rold->live & REG_LIVE_READ) && exact !=3D RANGE_WITHIN)

imo, `exact =3D=3D NOT_EXACT` is easier to follow (we excluded EXACT above)

>                 /* explored state didn't use this */
>                 return true;
> -       if (rold->type =3D=3D NOT_INIT)
> +       if (rold->type =3D=3D NOT_INIT && exact !=3D RANGE_WITHIN)

ditto

>                 /* explored state can't have used this */
>                 return true;
> -       if (rcur->type =3D=3D NOT_INIT)
> -               return false;

do we need to remove this? in which case will it do the wrong thing?

>
>         /* Enforce that register types have to match exactly, including t=
heir
>          * modifiers (like PTR_MAYBE_NULL, MEM_RDONLY, etc), as a general
> @@ -16468,7 +16473,7 @@ static bool regsafe(struct bpf_verifier_env *env,=
 struct bpf_reg_state *rold,
>                         return memcmp(rold, rcur, offsetof(struct bpf_reg=
_state, id)) =3D=3D 0 &&
>                                check_scalar_ids(rold->id, rcur->id, idmap=
);
>                 }
> -               if (!rold->precise)
> +               if (!rold->precise && exact !=3D RANGE_WITHIN)

same, I think explicit `exact =3D=3D NOT_EXACT` is easier to follow

>                         return true;
>                 /* Why check_ids() for scalar registers?
>                  *
> @@ -16579,7 +16584,7 @@ static struct bpf_reg_state *scalar_reg_for_stack=
(struct bpf_verifier_env *env,
>  }
>
>  static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_stat=
e *old,
> -                     struct bpf_func_state *cur, struct bpf_idmap *idmap=
, bool exact)
> +                     struct bpf_func_state *cur, struct bpf_idmap *idmap=
, enum exact_level exact)
>  {
>         int i, spi;
>
> @@ -16743,7 +16748,7 @@ static bool refsafe(struct bpf_func_state *old, s=
truct bpf_func_state *cur,
>   * the current state will reach 'bpf_exit' instruction safely
>   */
>  static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_f=
unc_state *old,
> -                             struct bpf_func_state *cur, bool exact)
> +                             struct bpf_func_state *cur, enum exact_leve=
l exact)
>  {
>         int i;
>
> @@ -16770,7 +16775,7 @@ static void reset_idmap_scratch(struct bpf_verifi=
er_env *env)
>  static bool states_equal(struct bpf_verifier_env *env,
>                          struct bpf_verifier_state *old,
>                          struct bpf_verifier_state *cur,
> -                        bool exact)
> +                        enum exact_level exact)
>  {
>         int i;
>
> @@ -17144,7 +17149,7 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
>                          * =3D> unsafe memory access at 11 would not be c=
aught.
>                          */
>                         if (is_iter_next_insn(env, insn_idx)) {
> -                               if (states_equal(env, &sl->state, cur, tr=
ue)) {
> +                               if (states_equal(env, &sl->state, cur, RA=
NGE_WITHIN)) {
>                                         struct bpf_func_state *cur_frame;
>                                         struct bpf_reg_state *iter_state,=
 *iter_reg;
>                                         int spi;
> @@ -17168,20 +17173,20 @@ static int is_state_visited(struct bpf_verifier=
_env *env, int insn_idx)
>                                 goto skip_inf_loop_check;
>                         }
>                         if (is_may_goto_insn(env, insn_idx)) {
> -                               if (states_equal(env, &sl->state, cur, tr=
ue)) {
> +                               if (states_equal(env, &sl->state, cur, RA=
NGE_WITHIN)) {
>                                         update_loop_entry(cur, &sl->state=
);
>                                         goto hit;
>                                 }
>                                 goto skip_inf_loop_check;
>                         }
>                         if (calls_callback(env, insn_idx)) {
> -                               if (states_equal(env, &sl->state, cur, tr=
ue))
> +                               if (states_equal(env, &sl->state, cur, RA=
NGE_WITHIN))
>                                         goto hit;
>                                 goto skip_inf_loop_check;
>                         }
>                         /* attempt to detect infinite loop to avoid unnec=
essary doomed work */
>                         if (states_maybe_looping(&sl->state, cur) &&
> -                           states_equal(env, &sl->state, cur, true) &&
> +                           states_equal(env, &sl->state, cur, EXACT) &&
>                             !iter_active_depths_differ(&sl->state, cur) &=
&
>                             sl->state.may_goto_cnt =3D=3D cur->may_goto_c=
nt &&
>                             sl->state.callback_unroll_depth =3D=3D cur->c=
allback_unroll_depth) {
> @@ -17239,7 +17244,7 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
>                  */
>                 loop_entry =3D get_loop_entry(&sl->state);
>                 force_exact =3D loop_entry && loop_entry->branches > 0;
> -               if (states_equal(env, &sl->state, cur, force_exact)) {
> +               if (states_equal(env, &sl->state, cur, force_exact ? RANG=
E_WITHIN : NOT_EXACT)) {
>                         if (force_exact)
>                                 update_loop_entry(cur, loop_entry);
>  hit:
> --
> 2.43.0
>

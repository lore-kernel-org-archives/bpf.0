Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEFA155C97
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890314; cv=pass; b=U5p6zB7OtFOVnMj9RD+fvpYrmD3tCwa1Q1lIw/KoMJleByFWxjYmtsm6JMj8z+EcddMhEa4btmevu4bTf5N0cA2FYa3n+twhE6jZ/qyWq3+LPCia6yfbk3gSTxGV+ahWBH/oY2UyghFOWEBvnhLg2PiSYwRltUnR+YlQpsfthKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890314; c=relaxed/simple;
	bh=MxR6uUQzlU0L+1dtxBlkz4hJ9s/+L++FSIFIDeFs6Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8B75ogOYFXfQBR6X4s4E2lTol/k0LXobJLCQ3/d8fAshlJfBrUa2raGMwkqT+9iWttLpddnE4m5wFaQQaE4PVvfdc0s6LREsWoPjwcxlRSfOyHgzQSAVBCfWnJqMWYOEe6NhhsyZ6Yo4KMiiaKEmRiC6P+nygyeKRbMorGMcA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhBHb+PD; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhBHb+PD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so40129815e9.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 10:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774890312; cv=none;
        d=google.com; s=arc-20240605;
        b=XxGK4Jk3ey0ctMI+NPoeEfGe+aZ5E6Bj0a36+jX5XMC+P2A3Ft1YS0tPELIBMn8T+R
         6NoaYVFGp2PI8kT/DUSHgskgHfddnb3qpyHGYTv50g0T/XTPELkaI3boDVOj5b0mjbLj
         SyzCjkpojiGQhHTMlFEunqYtWCXOPDVcpdoJT2vqO8iW96VJGOVPvz4vnREtvLBMT4mH
         WgvXVZHr2IeRmk/DvKe3a5hy1NN8bJQkku89pn7acYHNjqBIHHtDY9vO4yWqlvM3eeyM
         BbLyifx7CubJccT0tVemo3pI0BGV/5DF1dYGuLJ92OrjlI0skWnmf6yXbV4iPZLjNefu
         Q4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vcbw3WU+eCsstrggqb5GtyGeU7qDydEcN6TeUdnENQs=;
        fh=hy9VkiIbMGbvBlzqgoOvPUk5XT4zWzqMRhg5Jg22NkI=;
        b=AGAfu4HC7OKHwCQQUM4LsXXdPySE+cfY+n1z+MOFavZz9WusdNOmsB7DV8byDuA9fs
         HqhUIz7idi7ofrjUC7YGNDbwMDcJ2igkorSeVFWkhvVC5hvMEvZB6F2mwdMK4Bi3yXDP
         fTGCiYu5iEeRY1yDmourKxOcXJRlnjt0rxs8O02q4j+d6HiB8R4kjzpM/CFOtEn09hkq
         mpAkjmDN/KwDKtGGq8U3p/YA0iJ+8RQtmFLmtL8oM55sMIY+Z9MW576p7DhS8mie19bT
         7DJ9hfADrqkyIWpKaLkG0kKdWrZHuVRGBTid69bQA5JAP8Tcip8XC/m5dzCbT2YC4NS8
         Ywxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774890312; x=1775495112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcbw3WU+eCsstrggqb5GtyGeU7qDydEcN6TeUdnENQs=;
        b=rhBHb+PDq9V5TlQVncDS2lfVoFRbf9nYCdRpptF4yzVzhR2im+od/fiLkENq9urUca
         M7q08/5oiL7JVh7G0Xb+Z12AvU45QQ1GrGWHjjzPbeLaiRuZ9ieSA77ftsZmUK1wEu0K
         PxCHDw6dr1vl/QRj0eHmQ60W/4rsu01Nh8Yyegp+nn//BCl2NeogcvOZ5NHQ9bFKDymX
         ciboWeX6es47YWQJ7WZ26SHX5yn+CUzaN53xUXicPKE+ov0Kvp+5TOEw0QEyPPbTtV9W
         /IZZMDyLkLelGJSP4fRShT9A5TYzQlTI6YZBBvCN4g+0s2EZGxgYSE2fXXZ9PPIhe3Dm
         SBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774890312; x=1775495112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vcbw3WU+eCsstrggqb5GtyGeU7qDydEcN6TeUdnENQs=;
        b=MZ38KpCGtI7mOyUhboZ3UcBTgTJxBy2mvZmR0JbPW/CcfZl2g5ao4UORKjaQRzKcze
         5iX6v0NU00zys9rKyeqb4N7j2N7cWlssTwL7C4lvOiwwhiq4WzSTW2v9iFRKPyhJfsLI
         ignORE5okRdsSN5fYm5sh9VUmnRY3FUIajauW3ohI2r6N0PMm/SZrSbXyWNZ7DPEgU4M
         C+HvLDa4zOyapV3G/rd18SI0t24EaidxbPzfxrqIMCyVdbbjfWCJFRaA51quH6yUddo2
         MFzYhGkIc13dvN11cuPvDGzGPJKpkRswuzE37XzmK35Nyaqw36jH8iL5yA6k2nxu1lYQ
         agOA==
X-Forwarded-Encrypted: i=1; AJvYcCVbPthDHXD55u0Qp5CIbUdmz6WlHTZxDWrFnQhUfK+rfrdHHdyDUb4poQuJLy2W7MJ8PL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmg+Sbk3F8cYywJzIE86CApKdIVzN+B2qfbmiB8+c4SGLzkDFz
	Hssl5WnRccgAkDJ7aHfvz1bsilFiynbvgjKk9cS91dK7HPSqJv6K5M45NR5s9mpGbCM09o4joqJ
	Y8lMxGhN2JdUFR38yyBaSgH7mIdGq34Vdc1ZD
X-Gm-Gg: ATEYQzztifMX+EfeH1lVtGSgQQM7tP10nfNXLWbEeS2wLl9CsG2E/x6CsLOJdD2ZjZZ
	E/xdJWyNvDU3WcA+FGyn6nz5cliqzXogFzZ7BuqwQp34kCWZL++8/CPhcn9Hm2X4TXsSPlDuwuP
	rcX6C4xLgOY1GZWTkDMhcwIaftyMN5v66SiXwDn05wpGwe21y8SfY8LGxUtF+Dxt+QJfNnhB2AD
	nxtqV+vzCQh+2t7N4z38J6gETzYOSQR290oMOjUVSLlSR5XokgiVHmyFftVKHDu0Z8wDxYUAm3V
	vouMssZgstSID2HTbghr63wRG7lhTgOMivxCSpQeJ+JXsOO35A9u4otNIrfVvOpe+fXky+tiakT
	od36vDP/qDuKT86zjIzn/fMcWznUpFAPw+Ozj
X-Received: by 2002:a5d:4748:0:b0:43c:ef4f:79e4 with SMTP id
 ffacd0b85a97d-43cef4f7c0fmr13207151f8f.37.1774890311520; Mon, 30 Mar 2026
 10:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329140506.9595-1-pilgrimtao@gmail.com> <20260329140506.9595-2-pilgrimtao@gmail.com>
In-Reply-To: <20260329140506.9595-2-pilgrimtao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Mar 2026 10:05:00 -0700
X-Gm-Features: AQROBzAfHCUSDXuIIL-jaIg2nAba48yfw0Wy23vmkt12STrtolsJ-ryxkM87QwY
Message-ID: <CAADnVQ+xS4ti=cSqAnG4ePmjEZXUb-8Ss9cjkWiiWgtv-_NNVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/9] bpf: refactor kfunc checks using
 table-driven approach in verifier
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Chengkaitao <chengkaitao@kylinos.cn>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 7:05=E2=80=AFAM Chengkaitao <pilgrimtao@gmail.com> =
wrote:
>
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> Replace per-kfunc btf_id chains check with btf_id_in_kfunc_table() and
> static kfunc tables for easier maintenance.
>
> Prepare for future extensions to the bpf_list API family.
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/verifier.c | 261 +++++++++++++++++++++++-------------------
>  1 file changed, 144 insertions(+), 117 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4fbacd2149cd..f2d9863bb290 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -544,9 +544,6 @@ static bool is_async_callback_calling_kfunc(u32 btf_i=
d);
>  static bool is_callback_calling_kfunc(u32 btf_id);
>  static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
>
> -static bool is_bpf_wq_set_callback_kfunc(u32 btf_id);
> -static bool is_task_work_add_kfunc(u32 func_id);
> -
>  static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
>  {
>         return func_id =3D=3D BPF_FUNC_for_each_map_elem ||
> @@ -586,7 +583,7 @@ static bool is_async_cb_sleepable(struct bpf_verifier=
_env *env, struct bpf_insn
>
>         /* bpf_wq and bpf_task_work callbacks are always sleepable. */
>         if (bpf_pseudo_kfunc_call(insn) && insn->off =3D=3D 0 &&
> -           (is_bpf_wq_set_callback_kfunc(insn->imm) || is_task_work_add_=
kfunc(insn->imm)))
> +           is_async_callback_calling_kfunc(insn->imm))
>                 return true;
>
>         verifier_bug(env, "unhandled async callback in is_async_cb_sleepa=
ble");
> @@ -11203,31 +11200,6 @@ static int set_task_work_schedule_callback_state=
(struct bpf_verifier_env *env,
>         return 0;
>  }
>
> -static bool is_rbtree_lock_required_kfunc(u32 btf_id);
> -
> -/* Are we currently verifying the callback for a rbtree helper that must
> - * be called with lock held? If so, no need to complain about unreleased
> - * lock
> - */
> -static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
> -{
> -       struct bpf_verifier_state *state =3D env->cur_state;
> -       struct bpf_insn *insn =3D env->prog->insnsi;
> -       struct bpf_func_state *callee;
> -       int kfunc_btf_id;
> -
> -       if (!state->curframe)
> -               return false;
> -
> -       callee =3D state->frame[state->curframe];
> -
> -       if (!callee->in_callback_fn)
> -               return false;
> -
> -       kfunc_btf_id =3D insn[callee->callsite].imm;
> -       return is_rbtree_lock_required_kfunc(kfunc_btf_id);
> -}
> -
>  static bool retval_range_within(struct bpf_retval_range range, const str=
uct bpf_reg_state *reg)
>  {
>         if (range.return_32bit)
> @@ -12639,11 +12611,103 @@ BTF_ID(func, bpf_session_is_return)
>  BTF_ID(func, bpf_stream_vprintk)
>  BTF_ID(func, bpf_stream_print_stack)
>
> -static bool is_task_work_add_kfunc(u32 func_id)
> -{
> -       return func_id =3D=3D special_kfunc_list[KF_bpf_task_work_schedul=
e_signal] ||
> -              func_id =3D=3D special_kfunc_list[KF_bpf_task_work_schedul=
e_resume];
> -}
> +/* Kfunc family related to list. */
> +static const enum special_kfunc_type bpf_list_api_kfuncs[] =3D {
> +       KF_bpf_list_push_front_impl,
> +       KF_bpf_list_push_back_impl,
> +       KF_bpf_list_pop_front,
> +       KF_bpf_list_pop_back,
> +       KF_bpf_list_front,
> +       KF_bpf_list_back,
> +};
> +
> +/* Kfuncs that take a list node argument (bpf_list_node *). */
> +static const enum special_kfunc_type bpf_list_node_api_kfuncs[] =3D {
> +       KF_bpf_list_push_front_impl,
> +       KF_bpf_list_push_back_impl,
> +};
> +
> +/* Kfuncs that take an rbtree node argument (bpf_rb_node *). */
> +static const enum special_kfunc_type bpf_rbtree_node_api_kfuncs[] =3D {
> +       KF_bpf_rbtree_remove,
> +       KF_bpf_rbtree_add_impl,
> +       KF_bpf_rbtree_left,
> +       KF_bpf_rbtree_right,
> +};
> +
> +/* Kfunc family related to rbtree. */
> +static const enum special_kfunc_type bpf_rbtree_api_kfuncs[] =3D {
> +       KF_bpf_rbtree_add_impl,
> +       KF_bpf_rbtree_remove,
> +       KF_bpf_rbtree_first,
> +       KF_bpf_rbtree_root,
> +       KF_bpf_rbtree_left,
> +       KF_bpf_rbtree_right,
> +};
> +
> +/* Kfunc family related to spin_lock. */
> +static const enum special_kfunc_type bpf_res_spin_lock_api_kfuncs[] =3D =
{
> +       KF_bpf_res_spin_lock,
> +       KF_bpf_res_spin_unlock,
> +       KF_bpf_res_spin_lock_irqsave,
> +       KF_bpf_res_spin_unlock_irqrestore,
> +};

I think it's a step in the wrong direction.
I'd wait for Ihor's BTF_ID_NAMED cleanup.

Kaitao Cheng,

also please start your part of code reviews.
Your patches are not going to be landing if you don't code review.

https://lore.kernel.org/bpf/CAADnVQ+TKKptnNB25V3=3Dbcdybh5G6c2DyW2sYtXvyRaV=
nPN8MA@mail.gmail.com/

pw-bot: cr

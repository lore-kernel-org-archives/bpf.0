Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843403B6361
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178697; cv=pass; b=jWwM5eQ5aPGa7ZAStnMLfPDM3MC8UYit4mmFOTa1JAQ2WrF/uCYiLoEHl1KWOW0GC5Mr+WnmYEag0milTcigHBSXjFjXSC4b9oEJhTdfKMwWEeEedYf+U8bnwt2tIW8ccfhWAP/9zYO3P8TP01Sr6hLProK8GcPC50Djmgu6Dn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178697; c=relaxed/simple;
	bh=PzcPB1wcnmEYPr1pLZ24If/vnO+/A/mkFoUMBpmt0/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3KDKocnxrmgFr1tw6/VXwfgIQjxhGfZ6ZnyFGRDL7WlO2XODarQ6h89DDMEe0zrfB1CDjz0ICnwqDZKJbzz7yLM+2yHvTdgoL35+YIInlEaH32hKQDRCsOXQee/U8MJPEp9RiYjcsq3H1utkrrJrQIEOG+K1CGfQ12EunHFOVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rXsaQiqd; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXsaQiqd"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e95bd1c14cso1453045ad.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:24:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792178696; cv=none;
        d=google.com; s=arc-20260327;
        b=c4oY9glRHFMr/Bo3oX5VYSk30pY6KpZS9hs6Pgaww8s/XQpXBgMnEJOXZ6kpBjquit
         W/3eIcY2UUri+zYdSRQA6dkHul6iDVaMVO4eAzlclUuMyY5QvS2Xv9jxfDx+EVbwdfa3
         VbPQ45bZtmOQ6avim+FzbHqsCj2tJoL3DlVFnTELRuFZ4Q4/6Fkb+IfPLWTJZROh8W1b
         wkTMlAJmwOmNPTwhb0/88lXAvKPPih+ec9j4sj/AeAvxxM5CyTlLkpoZ6IpOIseZk47V
         OYcButg6d0mtsOHw6YbvBWNpGr+dK7ISWQGTa+hDz7DUi+qcwAS/VLBbS5UqXYTLXYih
         kK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qAUczLaO54PjtGqW4jAyxNjLsQAEINgLtxEcHpiUHS8=;
        fh=hxRZ/yxzH0mnIMeGpQd7Zzze8yONgMQRyPM05yvEJ80=;
        b=YbdIQ4Ip5LCUq+Kkvov5iVv91Zmx9n5Ss7IPb3WyXn3GL8gYjjV+sZSE+zATlbP0UY
         DX/8W+D52Ov88gbpeWfdHTzyFJ8QdKO0AUUXbRV20JqKnn7FQlaU6asv0oFD7K2Bf+/x
         KRTxeTYbvUNDiOkg7MJqx4JGzDI2eyv3IqAXwza2J6WaK/xZrZtuUfSmZmIgkXzDwtn3
         LfYzrI4SPq2WF+NDX+omcP3fh2a0+SyrCT/nltJRe+I4RX1tT6ywS7twxZRsnz/vXdoL
         MrT2odk51YquRS9D7/u4tsgnK5RfThIDxqGjEyUcyBt4c+Xkzl1kZT565Kc/Aihbqf5M
         xQGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792178696; x=1792783496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qAUczLaO54PjtGqW4jAyxNjLsQAEINgLtxEcHpiUHS8=;
        b=rXsaQiqdk8vu9qCQdW87wuQPFFrQFoEDHuNyMSXsjR2y1CIuB6FKPUTMMceQ28VaxH
         r7BLpTKhlN/UNYt+f58YVEVByM0ib+BdaPZ7MBJoZ/paLAZ0zpf4nPy/uL1EnIY6jnEQ
         ieZmex0K6tHZNR5SJ4D332ipGacKtCAbGB2qZV+Ve3VaKozUlFmL0GPM26ImLI6dv/ya
         vHx91p8fUDrfsNhD9JYOm/ozSidk4l1h4KupoFeEqz1Ti59GMMl/t27+edj6xOUtNaO9
         OACJe0Nw/1E+UbI0XC4Ft4QpOkK6d3TnEUswf2V1lH8SlLehdQhiyz8Qo7gSELOl54X4
         tgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792178696; x=1792783496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qAUczLaO54PjtGqW4jAyxNjLsQAEINgLtxEcHpiUHS8=;
        b=S2vr1uPyhSCs4vp7rDUzpo1RxY5hiONieHeXAEu6WMpRBsiwbd+L7KGsFnlZogIi4P
         f6Ibt/v+Y4zLDaGap2Mbs6gc0i7ikpRRE4zGsrFTx5U3gNtZGCG7KKZ1CiWXcnFiigQv
         yKlpxOyeC8Enht6jWcG5PBPohZCdu5Y8SJkdSAu7XAQEP8U8skFTtZj56gEMe+JOzY1L
         rAZ8yMQMqcICkgsEVh2zeAvuqjq26DrwFSWQssDQMv5rShXjdGhKvwlFpAjqpVEOcPWx
         4ej01RqiDhmXSxgb5Bu1RSRavolaDpFH3t4pafaXNO9vmor1LvROw+NqHcJ0n/WMR/2x
         JGag==
X-Gm-Message-State: AFq9FYIGvwUkRrMJnsCerfN2FvCv9uWiPQpqY+staSsy624KUrYvJudM
	+2aN5LXDwQ+hyRrpB8wlgcrv/+rdVWpCDLP6XZRFJc16WCl07vG8x/tXbEvR79Lz15zhHONsIjY
	nKWb4rJN0yk1yuvlLBRFm9S7bSQDQmDU=
X-Gm-Gg: AYBFou3aV3C2Gy2uZcTjegpx35iuBDU1zwYbJGPpvMPGzp5y/SJPjzJjtG0sLqn7TAr
	mm9bv6+AuYoNHwe2oeJ0hzc/rPWSwgf1+IEhszQSJIa9pPgJojaleoLnD3rDnWN/1I35djoZb+T
	1uof6ax8bc/V1NZK1w+3V2PkjLlCYe1Fs7KBAOioyZCnuceLG6aKGPUz8L++lMCZ73YqO+JyV8J
	srGVJMS8DPzMN5Dja8aHqh/41aFkySJ+fYvZR/AoXkXKN0KX1PrpBG4FGOVGjhujl1eW5HPVZiW
	17Grd1PYu07CidpyMUtUnXITass8PD+eI/J8D1MI8ByL52bR9S2xk8A9IwIu5gBNipLWtMWfpAn
	Una/SWx81Ih+fKuwvUvkFqhgnyvrHUPSxfO5N
X-Received: by 2002:a17:902:dacf:b0:2e2:da4f:b2bf with SMTP id
 d9443c01a7336-2e9a6c1a323mr8077465ad.44.1792178695727; Fri, 16 Oct 2026
 12:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com> <20261010143156.379864-4-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20261010143156.379864-4-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Oct 2026 12:24:41 -0700
X-Gm-Features: AclHuK9DkRGZNH6GRHftKOGzFpwQYkBI0irWXkzL65NMmgok8Py3yZdNa1fcP2A
Message-ID: <CAEf4BzbF3d08Osi5pQJDFcEKaJiaRW4tH4LM1vzBOOmOrXFpGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/7] libbpf: BPF programs manual loading and attaching
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 7:32=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> From: Slava Imameev <slava.imameev@crowdstrike.com>
>
> BPF programs designated as manually loaded can be loaded and
> attached independently after the initial bpf_object loading and
> attaching.
>
> These programs can also be reloaded and reattached multiple times,
> enabling more flexible management of a resident BPF program set.
>
> A key motivation for this feature is to reduce load times for
> utilities that include hundreds of BPF programs. When the selection
> of a resident BPF program set cannot be determined at the time of
> bpf_object loading and attaching, all BPF programs would otherwise
> need to be marked as autoload, leading to unnecessary overhead.
> This patch addresses that inefficiency.
>
> A manual-strategy program is loaded via bpf_program__load()
> and unloaded via bpf_program__unload(). It only requires that
> bpf object is already in PREPARE state (BTF loaded, maps created,
> relocations applied) rather than requiring a full bpf_object__load().
> Manual programs are skipped by the object's own autoload pass.
>
> A few key changes described below:
>
> gen_loader is rejected if any manual program is present since
> this loader is finalized during bpf_object__load()
> and so it will miss any manual programs loaded later.
>
> To support veristat conversion from clone to manual loading
> a few commits later, several changes to libbpf had to be applied:
>
> 2 program log related APIs were relaxed to work post OBJ_LOADED
> state to fix regression where verifier logs were lost in case of
> bpf_object__prepare failure. It makes sense to relax those for MANUAL
> programs as they can load post OBJ_LOADED state so the log buff still
> can be set at this point.
>
> Failures with BPF_PROG_TYPE_STRUCT_OPS were encountered and so in several
> places code related to struct_ops logic was altered to take into account
> struct_ops program with MANUAL strategy set. The general idea is to rejec=
t
> this type of programs for manual loading since those programs cannot
> load/unload independently of each other per a given struct ops.
> SEC("!...") style declaration is rejected for them. On the other hand,
> bpf_program__set_load_strategy() accepts them because otherwise
> veristat is rejecting them.
>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c   | 218 +++++++++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf.h   |  38 ++++++-
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 233 insertions(+), 24 deletions(-)
>

[...]

>  static void bpf_program__exit(struct bpf_program *prog)
>  {
>         if (!prog)
>                 return;
>
> -       bpf_program__unload(prog);
> +       bpf_program_unload_full(prog);
>         zfree(&prog->name);
>         zfree(&prog->sec_name);
>         zfree(&prog->insns);
> @@ -1222,6 +1241,15 @@ static int bpf_object_adjust_struct_ops_autoload(s=
truct bpf_object *obj)
>                 if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
>                         continue;
>
> +               /*
> +                * We avoid this for MANUAL programs to allow veristat
> +                * conversion from clone() to MANUAL loading. Setting AUT=
O
> +                * for a program would cause it to be rejected during man=
ual
> +                * loading.
> +                */

it's weird to refer to veristat from inside the libbpf, just say that
if user set load strategy to MANUAL, we don't mess with struct ops
autoload guessing anymore (or something along those lines), assuming I
understand the intent correctly

> +               if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MAN=
UAL)
> +                       continue;
> +
>                 for (j =3D 0; j < obj->nr_maps; ++j) {
>                         const struct btf_type *type;
>

[...]

> @@ -16220,10 +16338,41 @@ void bpf_object__destroy_skeleton(struct bpf_ob=
ject_skeleton *s)
>
>  int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_pr=
og_load_strategy strategy)
>  {
> -       if (prog->obj->state >=3D OBJ_LOADED)
> +       struct bpf_object *obj =3D prog->obj;
> +
> +       /*
> +        * obj->has_manual_prog is set once in bpf_object_prepare_progs()
> +        * and never recomputed; once the object is prepared, no transiti=
on
> +        * into or out of MANUAL may change which programs are MANUAL,
> +        * regardless of direction. AUTO<->DISABLED transitions never tou=
ch
> +        * MANUAL and keep the looser, pre-existing OBJ_LOADED gate.
> +        */
> +       if (strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL ||
> +           prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL) {
> +               if (obj->state >=3D OBJ_PREPARED)
> +                       return libbpf_err(-EINVAL);
> +       } else if (obj->state >=3D OBJ_LOADED) {
>                 return libbpf_err(-EINVAL);
> +       }

see my comment on previous patch, we should accept any change before
preparation step, and reject any change after, so there is nothing
special about MANUAL here, is there?

> +
> +       if (strategy =3D=3D prog->load_strategy)
> +               return 0;

why this special check?

> +
> +       switch (strategy) {
> +       case BPF_PROG_LOAD_STRATEGY_DISABLED:
> +       case BPF_PROG_LOAD_STRATEGY_AUTO:
> +               prog->load_strategy =3D strategy;
> +               break;
> +       case BPF_PROG_LOAD_STRATEGY_MANUAL:
> +               if (prog_is_subprog(obj, prog))
> +                       return libbpf_err(-EINVAL);
> +
> +               prog->load_strategy =3D BPF_PROG_LOAD_STRATEGY_MANUAL;
> +               break;
> +       default:
> +               return libbpf_err(-EINVAL);
> +       }

[...]

>  /**
>   * @brief **bpf_program__set_load_strategy()** sets the load strategy of=
 a
>   * BPF program, controlling whether and when it gets loaded into the ker=
nel.
>   *
> - * Can only be called before the enclosing bpf_object is loaded.
> + * Can only be called before the enclosing bpf_object is loaded for
> + * non MANUAL-> non MANUAL transitions. For manual it only
> + * before bpf_object is prepared.
>   *
>   * @param prog BPF program to update
>   * @param strategy new load strategy for the program
> - * @return 0 on success; negative error code if the object was already l=
oaded
> + * @return 0 on success; negative error code error.
>   */
>  LIBBPF_API int bpf_program__set_load_strategy(struct bpf_program *prog,
>                                               enum bpf_prog_load_strategy=
 strategy);
> @@ -2150,6 +2170,16 @@ LIBBPF_API int bpf_program__set_load_strategy(stru=
ct bpf_program *prog,
>   */
>  LIBBPF_API enum bpf_prog_load_strategy bpf_program__load_strategy(const =
struct bpf_program *prog);
>
> +/**
> + * @brief **bpf_program__load()** loads a MANUAL BPF program. The enclos=
ing
> + * bpf_object must already beprepared.

typo

> + *
> + * @param prog BPF program to load; non MANUAL programs, already loaded
> + * programs and subprograms are rejected.
> + * @return 0 on success; negative error code otherwise
> + */
> +LIBBPF_API int bpf_program__load(struct bpf_program *prog);
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 689de28fe436..9835e660350b 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -464,6 +464,7 @@ LIBBPF_1.8.0 {
>                 bpf_program__attach_tracing_multi;
>                 bpf_program__clear_flags;
>                 bpf_program__clone;
> +               bpf_program__load;

as before, please move to 1.9 section now


>                 bpf_program__load_strategy;
>                 bpf_program__set_load_strategy;
>                 btf__add_loc_param;
> --
> 2.34.1
>

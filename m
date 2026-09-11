Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D9363C6A
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170263; cv=pass; b=J9L6UL39uMgtKQ3J0krRyTkG9hT8oRRMKHp3gQEUSq9//xUUJ+wNEeRWAV9RkMu0oZvbjSTq+9NlTQOflSEglQ2/i1Dt6asJ9x8lKE9Qt98nvGiH5SuGGpt20P7zVxOCRFUclYHA5jM7G0W6+xdnzY5NoD7InLE6XmkmrodR37Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170263; c=relaxed/simple;
	bh=TzO7Bco2U3/ghV6QU3str3nVrQwIfqsK3ebUFejBMBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfqiaMETO7YQlhej40TmJefVrlHwNOR+h1IAIyirnGcOjBdMrRfkYWj1yr2B29yxDmLLMknu+wlqLZvRDOUmbDyt5evgQ5KzKkyHZw0AoMk2sVBMF0AX17MAaKukW5dS9gy1WyoktLhTMB0vTXiK/ru6GU6SdgEwoP+mtiFd78U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfYjW2RZ; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfYjW2RZ"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4c3304833so79190a12.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789170259; cv=none;
        d=google.com; s=arc-20260327;
        b=GzpQQNPcTfs91AywD/XUeB+o6CjKBd/3vmyEshYZAtxMk3h/x+maDVuGQsiJdkDuNK
         2dk2fL9wgOJ67zFNn1zkIWmWstFWX7Vos/W4hhP14rrEpBsnfuk/G4EPtTbGf5CFv0tc
         IYKViAWjXuoJSwuKlHNgZrl0dsbTzgzETREX03ziSwhgwtL+ijESVy/qsQBFUObLG+0U
         5mOnkQnRHfK9S8kFQXHBYzW55HnNnkNeWuTcBzLAWKgvNx8O2tR3m02GQ2L0k5/hPqFp
         V+4N0Pn68YFM8Srz49RzDPJ/GyvU/1p1ZbCQ5gDbWkkDPigpzutPf0IdfKIyYgrO0I4s
         coew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OrIBg651/9Vt15/dvITnoMWz4z5XsQCG1eCmKVAnuQs=;
        fh=Pt6sKbZv0ijAhavqZflLqF3fSjEVzNxt6H6Xlv9tcSU=;
        b=rdbya1GP9SRD4eoYWy9UW3Imu19hViWNdJFglXsgCsic/jtTjfyMTm5BPhXxE7SU25
         PW4BGMOpXECUxhonsXdMMbL15iSaqDrXNiR+18tLNTGXxizgc5y1mjgJiNLBi8Ojl2ng
         3W4Ao08ul4Gm8VMP8unJJPIxlI0QT1rWGt3RDXzZX51aJNvDNjeoLqghjTJceByHnju5
         1NlJZwzxhRh8aZEc0Vu8FhPK7V92dBZdN0xeoB3fU78/6GfxNX8vNVm/qb+HHx7YpdUc
         suKP2x204e28b93g+TBPkd+trQ17ihvjSRAGGmX21IE5wkhXcbLxUoTBnK4C252NdV7p
         P0kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789170259; x=1789775059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OrIBg651/9Vt15/dvITnoMWz4z5XsQCG1eCmKVAnuQs=;
        b=DfYjW2RZaokKwsEIM2ckaGlwiTfrxXyFxTctg2aHU6+ZV7xiEd4xhUhAHUCQfIZ1vN
         IQbUXVP+wnPp0slWc6geEeSa6lN4gR8iDON256A9/qEWXYxpWMl5bpCIjB33if5vtJW5
         +91SVkutvleO4KUCWUEHkTsjFZpEK+KxMIt0p77tkC0I9JZUN6EfQQ8+ZxlQvaW2FyJ5
         A+DshRMdSAknV7lcqR87eW3+RuKHs3uNCvxTOk8GxEc38IFoV0kB2D0UiL/WuN9ZuYW8
         vahTfag8yKRu/xKUxpxwlYCCZRv4MbocBiIEU8kPK9U2AU9meaucwidY3804NZQz1Yui
         pqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789170259; x=1789775059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OrIBg651/9Vt15/dvITnoMWz4z5XsQCG1eCmKVAnuQs=;
        b=RUmYKcpnVTtj1jdwlNGtZb5EXn1zy1c9vsnufko8idbxs+xHr5XG2D4PRGYjrnzoys
         BoxNow8iUH0kVoaR7w28XVJP02/k2oUI8T1RxCcwWYa36yd77yV9wLCbpXvGnOtOETfb
         /+Mu+/cCTXyQFqZPte2GYUTKvtUZfFB4OAxZk19K3c2Nr+ZqkbLQqw9R+EFx40qCkrnp
         cPaDPHTuJTleMTDYXelPNVf2pkHhHy1gXRUxpNs/E3HggGddcah+j5HrtQyfWGF8NtH9
         8GobwysArWkYMIiUFqKFS7fhigb4MNCVngw67i08EP43BH5PWMX7iSk4oPjSsd+0uclC
         CAXw==
X-Gm-Message-State: AFuF++kJvKHTehwEuHICZc5wUg+AK2KtaKveO8qGoM8eH7T34dBIg5ms
	LyshmB2ArprzTQnUT/vrJ0ak2OsWKQAuujNACAq7wZSoYG4UGOLGeH+FtrwsmKNnG5gLru4/GrG
	jYNL6RZ7lYsvzSy7xbzcDugKXhZGLmhizWQ==
X-Gm-Gg: AYBFou0+iVqvMHBmw+KVeVWq9/nVU2nmGtYQXeP+2QtIkH1sOdU6PP87kpTbEpMCK62
	l2RCLvrcYbGIsQyCmnF/Viyia+tFgv5T8X02mb1QbMgwDQxv2QIzOfJrBzY/jg/GaH/8korHpMq
	V9uhmew1/5873DetMzWMKoWYmQGvrt1+eQ6tRlaFyQPY02H9pb1p7+GsbhFpYqf/dSY6XC1QHF8
	3/BSstzi6gzy4rVoMxHeA20tw/IwZVHo8mrr/AdiZD5eCbi/znsO0CXSJNtz+Yv8CT1OP7043mP
	G3HKS38wtLzAm53oz8O2QBUQozpH9eq5EzkVBw9+tU5DoSc4G3y9ORqC8s8WjGiyjjs9bqQ551S
	DkE9y8M/SVZS9XAeRtFs8hWCOht+himlsn3qM
X-Received: by 2002:a17:90a:d88b:b0:398:9bd5:490c with SMTP id
 98e67ed59e1d1-39dbc6f0775mr807396a91.19.1789170259223; Fri, 11 Sep 2026
 16:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com> <20260826181825.1826541-3-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260826181825.1826541-3-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 16:44:01 -0700
X-Gm-Features: AcwNN1WYnLidQtCA-L2GHSyCPz0u7t6ATC85ixrXR2klmOP0AHE3R26slyczOwQ
Message-ID: <CAEf4BzY8LLT6_=sOyof7mE+GenAwtVNhzEP_Emy_U07WFjU+Eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] libbpf: BPF programs dynamic loading and attaching
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, martin.kelly@crowdstrike.com, 
	slava.imameev@crowdstrike.com, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:18=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> From: Slava Imameev <slava.imameev@crowdstrike.com>
>
> BPF programs designated as dynamically loaded can be loaded and
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
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c   | 144 ++++++++++++++++++++++++++++++++++++---
>  tools/lib/bpf/libbpf.h   |   4 ++
>  tools/lib/bpf/libbpf.map |   2 +
>  3 files changed, 141 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 821d854d43a9..c3fe1de43210 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -725,6 +725,7 @@ struct bpf_object {
>
>         bool has_subcalls;
>         bool has_rodata;
> +       bool has_dynload_progs;
>
>         struct bpf_gen *gen_loader;
>
> @@ -8056,7 +8057,7 @@ static int bpf_object_load_prog(struct bpf_object *=
obj, struct bpf_program *prog
>                         log_buf =3D prog->log_buf;
>                         log_buf_size =3D prog->log_size;
>                         own_log_buf =3D false;
> -               } else if (obj->log_buf) {
> +               } else if (obj->log_buf && prog->load_type !=3D BPF_PROG_=
LOAD_TYPE_DYNAMIC) {

DYNAMIC as opposed to AUTO isn't all that clear a distinction, IMO. If
we go with "load strategy" for terminology, wouldn't this be AUTO vs
MANUAL?

>                         log_buf =3D obj->log_buf;
>                         log_buf_size =3D obj->log_size;
>                         own_log_buf =3D false;
> @@ -8403,6 +8404,7 @@ bpf_object__load_progs(struct bpf_object *obj, int =
log_level)
>                         pr_debug("prog '%s': skipped auto-loading\n", pro=
g->name);
>                         continue;
>                 }
> +
>                 prog->log_level |=3D log_level;
>
>                 if (obj->gen_loader)
> @@ -9076,15 +9078,22 @@ static void bpf_object_cleanup_btf(struct bpf_obj=
ect *obj)
>         obj->btf_modules_loaded =3D false;
>         zfree(&obj->btf_modules);
>
> -       /* clean up vmlinux BTF */
> -       btf__free(obj->btf_vmlinux);
> -       obj->btf_vmlinux =3D NULL;
> +       /* The btf_vmlinux data is needed for dynamically loaded programs=
,

nit: we've switched to more kernel-standard '/*' on separate line
style, please adjust comments in the next revision accordingly

> +        * so defer freeing it in that case to the end of the object life=
time.
> +        */
> +       if (!obj->has_dynload_progs) {
> +               btf__free(obj->btf_vmlinux);
> +               obj->btf_vmlinux =3D NULL;
> +       }
>  }
>
>  static void bpf_object_post_load_cleanup(struct bpf_object *obj)
>  {
> -       /* clean up fd_array */
> -       zfree(&obj->fd_array);
> +       /* The fd array is needed for dynamically loaded programs,
> +        * so defer freeing it in that case to the end of the object life=
time.
> +        */
> +       if (!obj->has_dynload_progs || !obj->fd_array_cnt)

why the added fd_array_cnt condition?

> +               zfree(&obj->fd_array);
>
>         /* clean up BTF */
>         bpf_object_cleanup_btf(obj);
> @@ -9678,6 +9687,8 @@ void bpf_object__close(struct bpf_object *obj)
>                 close(obj->jumptable_maps[i].fd);
>         zfree(&obj->jumptable_maps);
>
> +       zfree(&obj->fd_array);
> +
>         free(obj);
>  }
>
> @@ -9805,8 +9816,16 @@ bool bpf_program__autoload(const struct bpf_progra=
m *prog)
>
>  int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
>  {
> -       return bpf_program__set_load_type(prog,
> -               autoload ? BPF_PROG_LOAD_TYPE_AUTO : BPF_PROG_LOAD_TYPE_D=
ISABLED);
> +       enum bpf_prog_load_type type =3D prog->load_type;
> +
> +       if (autoload)
> +               type =3D BPF_PROG_LOAD_TYPE_AUTO;
> +       else if (prog->load_type =3D=3D BPF_PROG_LOAD_TYPE_AUTO)
> +               type =3D BPF_PROG_LOAD_TYPE_DISABLED;
> +       else
> +               return 0; /* Otherwise, keep the current load type. */

why? should we unconditionally set DISABLED if autoload=3D=3Dfalse?

> +
> +       return bpf_program__set_load_type(prog, type);
>  }
>
>  bool bpf_program__autoattach(const struct bpf_program *prog)
> @@ -15220,12 +15239,73 @@ void bpf_object__destroy_skeleton(struct bpf_ob=
ject_skeleton *s)
>         free(s);
>  }
>
> +static int bpf_program__set_dynamicload(struct bpf_program *prog)

we use double underscore naming only for public APIs (apart from a
bunch of legacy functions)

but also why this separate function at all, just inline it in
set_load_type below

> +{
> +       struct bpf_object *obj;
> +       const char *attach_name;
> +
> +       obj =3D prog->obj;
> +       if (!obj)
> +               return libbpf_err(-EINVAL);

do we ever check this anywhere?

> +
> +       /* Dynamically-loaded programs are not supported for gen_loader.
> +        * This is because bpf_object_load_prog is not called for
> +        * dynamicload programs, so dynamicload programs are not visible
> +        * to gen_loader. For this reason, prevent calling
> +        * bpf_program__set_dynamicload when gen_loader was used to
> +        * generate a BPF object loader.
> +        * A gen_loader implementation is being called for autoloaded
> +        * programs and defines its own model for loading BPF programs.
> +        * To pass a BPF program to gen_loader, set the program's load ty=
pe
> +        * to LD_AUTOLOAD.
> +        */
> +       if (obj->gen_loader)
> +               return libbpf_err(-ENOTSUP);
> +

ENOTSUP is kernel-internal, use EOPNOTSUPP

> +       if (prog_is_subprog(obj, prog))
> +               return libbpf_err(-EINVAL);
> +
> +       attach_name =3D strchr(prog->sec_name, '/');
> +       if (!attach_name || strchr(attach_name, ':')) {
> +               /* Only reject programs that require BTF-based attach tar=
get
> +                * resolution (indicated by the SEC_ATTACH_BTF flag). Suc=
h
> +                * programs need the section name parsed for the attach t=
arget
> +                * function name (after '/') and optionally the module na=
me
> +                * (before ':') for libbpf_find_attach_btf_id.

hm... this looks ugly... why BTF-base dattach targets can't be set to
dynamic/manual load?

> +                *
> +                * Programs like SEC("classifier"), SEC("socket"), etc. d=
o
> +                * not require BTF attach resolution and can safely use
> +                * dynamic loading despite having no '/' in their section
> +                * name. The BTF guard in libbpf_prepare_prog_load (check=
ing
> +                * SEC_ATTACH_BTF) is the authoritative check; this is an
> +                * early-reject for programs that would fail there.
> +                */
> +               long flags =3D prog->sec_def ?
> +                       (long)prog->sec_def->cookie : SEC_ATTACH_BTF;
> +               if ((flags & SEC_ATTACH_BTF) && !prog->attach_btf_id)
> +                       return libbpf_err(-EINVAL);
> +       }
> +
> +       obj->has_dynload_progs =3D true;

if someone sets load type to DISABLED from what used to be DYNAMIC
(e.g., because kernel is not supported), we don't recalculate
has_dynload_progs. I think we should determine has_dynload_progs at
the beginning of preparation step (and disable changing that), instead
of trying to keep track of it like you do here

pw-bot: cr

> +       prog->load_type =3D BPF_PROG_LOAD_TYPE_DYNAMIC;
> +       prog->autoattach =3D false;
> +
> +       return 0;
> +}
> +
>  int bpf_program__set_load_type(struct bpf_program *prog, enum bpf_prog_l=
oad_type type)
>  {
>         if (prog->obj->state >=3D OBJ_LOADED)

I think this should be OBJ_PREPARED, after bpf_object__prepare() is
called, it's too late to change this load type

>                 return libbpf_err(-EINVAL);
>
> -       prog->load_type =3D type;
> +       switch (type) {
> +       case BPF_PROG_LOAD_TYPE_DYNAMIC:
> +               return bpf_program__set_dynamicload(prog);
> +       default:

let's have explicit case XXX listed, with default returning -EINVAL

> +               prog->load_type =3D type;
> +               break;
> +       }
> +
>         return 0;
>  }
>
> @@ -15233,3 +15313,49 @@ enum bpf_prog_load_type bpf_program__load_type(c=
onst struct bpf_program *prog)
>  {
>         return prog->load_type;
>  }
> +
> +/*
> + * This function must be called after bpf_object__load_progs.

any problems with it being called after bpf_object__prepare()? what's missi=
ng?

> + * Dynamically-loaded program data is initialized on object load.
> + * Post-load initialization is not supported.
> + */
> +int
> +bpf_program__load_dynamically(struct bpf_program *prog, int extra_log_le=
vel)

just call it bpf_program__load()

> +{
> +       int err;
> +       struct bpf_object *obj;
> +
> +       obj =3D prog->obj;
> +       if (!obj || obj->state < OBJ_LOADED)

prog->obj should always be set, stop checking for it

> +               return libbpf_err(-EINVAL);
> +
> +       if (prog_is_subprog(obj, prog) || prog->load_type !=3D BPF_PROG_L=
OAD_TYPE_DYNAMIC)

we should also check that program is not already loaded (probably
enough to check prog->fd, double check)

> +               return libbpf_err(-EINVAL);
> +
> +       prog->log_level |=3D extra_log_level;

hm... why this extra_log_level? Why can't user just set
bpf_program__set_log_level() before attempting to bpf_program__load()

> +
> +       err =3D bpf_object_load_prog(obj, prog, prog->insns, prog->insns_=
cnt,
> +                                  obj->license, obj->kern_version, &prog=
->fd);
> +       if (err) {
> +               pr_warn("prog '%s': failed to dynamically load: %d\n", pr=
og->name, err);
> +               prog->log_level &=3D ~extra_log_level;
> +               return err;
> +       }
> +
> +       prog->log_level &=3D ~extra_log_level;
> +       return 0;
> +}
> +
> +int bpf_program__unload_dynamically(struct bpf_program *prog)
> +{
> +       int err;
> +
> +       if (!prog || prog->load_type !=3D BPF_PROG_LOAD_TYPE_DYNAMIC)
> +               return libbpf_err(-EINVAL);

we don't expect NULL, unless it's explicitly specified as a
possibility. And you didn't check prog for NULL in
bpf_program__load_dynamically(). let's be consistent (and not check
for NULL)


> +
> +       /* Close the file descriptor but retain the program's data to
> +        * support reloading the program if it is required again.
> +        */
> +       err =3D zclose(prog->fd);
> +       return err ? libbpf_err(-errno) : 0;
> +}
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 700634664e32..54d755861289 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -2083,15 +2083,19 @@ LIBBPF_API int bpf_program__clone(struct bpf_prog=
ram *prog, const struct bpf_pro
>   *
>   * - BPF_PROG_LOAD_TYPE_DISABLED: the program is not loaded.
>   * - BPF_PROG_LOAD_TYPE_AUTO: the program is autoloaded when the bpf_obj=
ect is loaded.
> + * - BPF_PROG_LOAD_TYPE_DYNAMIC: the program is loaded and attached dyna=
mically.
>   */
>  enum bpf_prog_load_type {
>         BPF_PROG_LOAD_TYPE_DISABLED =3D 0,
>         BPF_PROG_LOAD_TYPE_AUTO,
> +       BPF_PROG_LOAD_TYPE_DYNAMIC,
>  };
>
>  LIBBPF_API int bpf_program__set_load_type(struct bpf_program *prog,
>                                           enum bpf_prog_load_type loadtyp=
e);
>  LIBBPF_API enum bpf_prog_load_type bpf_program__load_type(const struct b=
pf_program *prog);
> +LIBBPF_API int bpf_program__load_dynamically(struct bpf_program *prog, i=
nt extra_log_level);
> +LIBBPF_API int bpf_program__unload_dynamically(struct bpf_program *prog)=
;
>
>  #ifdef __cplusplus
>  } /* extern "C" */
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 4d63dac8c3b7..a0389c58efe9 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -464,4 +464,6 @@ LIBBPF_1.8.0 {
>                 btf__new_empty_opts;
>                 bpf_program__load_type;
>                 bpf_program__set_load_type;
> +               bpf_program__load_dynamically;
> +               bpf_program__unload_dynamically;
>  } LIBBPF_1.7.0;
> --
> 2.34.1
>

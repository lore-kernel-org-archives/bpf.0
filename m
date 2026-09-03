Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00172618
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 00:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394376; cv=pass; b=lr3hhrvlg0AYM94aCb84U7c63oq5a6AmVzfdcuXJ0X2EuOdtNrlsTaGWslt6duSsGlMN7VCC2UJ3fzkqY68TkJtlW3C+jOasaCuE+cYoBy8lXParaLAmxaW00mROOijpF5HaVu3UQmoVtQYkVHMzJa9VpCDTlLHBkyWID8KfnBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394376; c=relaxed/simple;
	bh=YqYF7wD34Q4Q2Ohvxyox89BH2ovOPadye/gWn3mzzt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa/WPwx0oefguWqITIS1eeRD6RFq0uzWlqZwuUiZs0aoX0x+YSqYTtEnv9Uu92n4kpCg1xclglufyPBpLw3CJsYeLSPHymEGmxh8uELuabs9eJT2D5WSRQg6qvqeh1WSnTPvM63AWDJTLgoIZLvS4SAyqcSV0XIsbD3kEPUEbG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLjsK2mb; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLjsK2mb"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-85339ed040aso1460169b3a.1
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 17:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788394375; cv=none;
        d=google.com; s=arc-20260327;
        b=g5BUytTZgrUM3/IvolxhZKkD9sbPWTwR77LpM9hXWRy91Rb208evfmcI/S/bwdSIF0
         qIsh+fACrSk6Sne24acC6JTq7z5e/ipnVSaqeTk6Cua5JuW6Vj7JhN6s8HpYrtQCtEYh
         hy/t/3JNWR80mAtVyYzMx//ZB+ZFms159lb96FisIeoJyYirl6gOxa9lymAstr0VZTfZ
         4oeVsTqKijLYv5gPxJ1wNfCZH/sx4fJyHGfiY/G2ovn7zXBqhp08q0M3xic3Ye9aBgqW
         ID6ULqDfgBk4un/q4MIkKThKfhdYOnKINYwlPM5iCIVDvN98eEqWDtrd2QCZFwx8QKKG
         j9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7lIJmI1MD198zzuzMPQGdugnVQpMyaCF0+VM+j0LL4w=;
        fh=+3uXqjFiym8QWrBcH5365weH5VjWoesqAzojnmSsjIo=;
        b=Xnm4DC8H7vr7jzM/hcHq/oaDkWzODfrVLdMm3azYZyIHnxhHGALnwoFJvEhd/ktUgM
         aXl7YuNyHEDPUNLkF9VM0q019s6vf2r69oZsiIXBquksxuyjtvhgatJVhh7tOWbafE40
         sjoomVHNH/YhZeEzJoOO3jNVPZuTfMTzfOxDU0jcSDbkZE1hnR4sKJeFoflaJX5+4Cc0
         yx+CzLUAnbOSGl9aIpVgyjbH8rYxIZGQa7Er/2+ntVr8lL3cw1FBSzxaP0PZ7HVdrNvO
         COlqGBDJuaUek+KdEWqMNuhgxyWI8HqBItFGeksHmPFnbraPi4SHthn2jMjLuZe0Syxw
         gC2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788394375; x=1788999175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7lIJmI1MD198zzuzMPQGdugnVQpMyaCF0+VM+j0LL4w=;
        b=lLjsK2mb24T7/8/+zBuIfbYYq5+gewUODy2gx5eXA7L/LADGGrYMnvSoOD88pNUEYK
         ca10pWGhgMSqi+tAo/0HWuQ6EM22GRxakZOD/M0Wpp45c4WndNCS9EYXno3CpjAbMcMB
         nFEoWolxJqc8CAaiydwWSEYbK/NniPZK7GCUI6Xk+9Et+yrhIh1BlaK7elMxVRIAEq+J
         CVutGyaiM5KBO7gwOKjQyb0XxCZqU0BJYlZwlX6AUm+lEHuFCZWasxk8ngA1Db3xv3GQ
         9ZJwF/3G5F+GmXgsvfTPjit+3/23020CZQxXJc6XUcMNhZs8mM/U6r1emqeYducJdi1P
         oD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394375; x=1788999175;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lIJmI1MD198zzuzMPQGdugnVQpMyaCF0+VM+j0LL4w=;
        b=ZdruQZ/qKD9kvkYPCB3tLFM0uiSqXEMWSvyGt+UNn7GOPqGIui4oLTABBw2LMtwYod
         bOXuEvI+GQvFxv6dxsHWJR0BO7LY+CHCNxzV4okc4LoDRYwBTDJH87Qvxz1S2Gq/vHO2
         v/il7+OlUTQsYZ/bpNBMZWRo4kNtYk4fR43jqZrGSibcV1GNjeYpmzPUhfnPG65060qb
         awELz7Czar6TltBi87wiuCiLfkU6k5b4+bZ+pR3klVACDfm/3JfZbiKVTV3f5mpIE/on
         Z50+z4qLoqJicLc/13tbS8mTbki/0vJs4HVEiDqk6d5vPyIy8hOiCZ+L50n+p1SFse4Z
         nNqA==
X-Gm-Message-State: AFuF++nAWGF6+OaR98Yg1P0kHlaYlstIryhDaeI2afm+i70+qn0wAVUj
	HHfTGPhTh+QuHQ9mTUULuTAn0PyprVym227m/4PmkxB7dZ8ZkFi5c33OJrF3iBD0tw2BfD24MLt
	U88w12d7ydrCz6gnGaKTp90DmhMAaGws=
X-Gm-Gg: AYBFou0THXB3dsFGgPeJoB9vCaAKHf5bYxyZ0ujCKATRsYTs5tRlcjGs5MOlrBcOYSF
	ndzrGqLKfEh3Wp6Z7vE7b529edN7wUU5xAMJnfJiy40L4Gh5LzJhp1gZF1gJGdwBGhWW/3D/saH
	6zRkFCbyL/ZpnufCFvNTVCOhYyUvkpJ3uFyNX3UmWcLHzj1xq9FFgsZk7tMrEE9TLQc4EWW2sti
	NchirPzNBilcYxqjlOKP8MQg4z3xpqggw2WJKCpyudXaDoYInFghbcOJ6zozLjnkcm7SU+mmJ64
	+r4hYMnZnZlKkJrThYh2z7fEPuF3zlLueHBIpPylN/SGFGhpmiCtbrMHEpe+EzOCUqoCE/TZUwh
	EgiLNy7BDJtR/sZ22zsNBMktm72fR8bG+5ARz
X-Received: by 2002:a05:6a00:4094:b0:857:7384:b5fa with SMTP id
 d2e1a72fcca58-85ed4d10b5fmr12684837b3a.22.1788394374419; Wed, 02 Sep 2026
 17:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831133809.1161-1-zhaofuyu@vivo.com> <20260831133809.1161-2-zhaofuyu@vivo.com>
In-Reply-To: <20260831133809.1161-2-zhaofuyu@vivo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Sep 2026 17:12:41 -0700
X-Gm-Features: AcwNN1WFT6CKr63RsJA9KmEokVRL_qtKBS0BnjWeRclY6YHlyIuCUdP91xYll0o
Message-ID: <CAEf4BzaHTTEob-vmhmcRt1pmED+eBBLWnehEDUk=t7O7GUyyFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 6:38=E2=80=AFAM Fuyu Zhao <zhaofuyu@vivo.com> wrote=
:
>
> Add btf_module_names and nr_btf_module_names fields to
> bpf_object_open_opts to support selective kernel module BTF loading.
>
> With btf_module_names:
> - when provided, only the specified kernel module BTFs are loaded;
> - when an empty list is provided, no module BTFs are loaded;
> - when NULL, all module BTFs are loaded as before.
>
> This avoids unnecessary module BTF loading and reduces BPF object
> loading time when only a subset of kernel module BTFs is needed.
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>

nit: use andrii@kernel.org as my email, thanks

> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
> ---
>  tools/lib/bpf/libbpf.c | 117 +++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h |  24 ++++++++-
>  2 files changed, 140 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 514e4e9daa82..e19d0afd2592 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -779,6 +779,9 @@ struct bpf_object {
>         char *token_path;
>         int token_fd;
>
> +       char **btf_module_names;
> +       size_t nr_btf_module_names;

there is entire module related set of fields higher up, put these new
fields close to them

but also naming-wise:
  - use blah_cnt instead of nr_blah naming
  - we should call this "btf_module_allowlist" and
btf_module_allowlist_cnt, a bit verbose but explains what it is and
leaves doors open for denylist, if we ever need it. Please use these
names internally in bpf_object and in bpf_object_open_opts

overall, the code as is super verbose and doesn't feel like libbpf
code, please try to preserve naming/styling/succinct approach as much
as possible

> +
>         char path[];
>  };
>
> @@ -5803,6 +5806,103 @@ int bpf_core_add_cands(struct bpf_core_cand *loca=
l_cand,
>         return 0;
>  }
>
> +static void bpf_object_free_btf_module_names(struct bpf_object *obj)
> +{
> +       size_t i;
> +
> +       if (!obj->btf_module_names)
> +               return;
> +

no need for this check, count should be zero and everything works as
is without extra guard

> +       for (i =3D 0; i < obj->nr_btf_module_names; i++)
> +               zfree(&obj->btf_module_names[i]);
> +       zfree(&obj->btf_module_names);
> +       obj->nr_btf_module_names =3D 0;

just inline this logic in bpf_object__close()

> +}
> +
> +static int bpf_object_init_btf_module_names(struct bpf_object *obj,
> +                                           const struct bpf_object_open_=
opts *opts)

if you look at bpf_object_open(), all the opts processing is done
inline , let's do the same here. we can do validation and duplicate
detection before we even get to bpf_object__new. and alloc and strdup
loop after obj is created

pw-bot: cr

> +{
> +       const char **names;
> +       size_t i, j, cnt;
> +       int err;
> +
> +       names =3D OPTS_GET(opts, btf_module_names, NULL);
> +       if (!names)
> +               return 0;

don't exit early, we need to validate that if allowlist is not
specified, corresponding count is zero and vice versa

> +
> +       cnt =3D OPTS_GET(opts, nr_btf_module_names, 0);
> +
> +       /*
> +        * Allocate one entry for an empty list to distinguish it from th=
e
> +        * default behavior.
> +        */
> +       obj->btf_module_names =3D calloc(cnt ?: 1,

this count trick is kind of ugly... should we just set count to <0
instead? we'll still be able to do for loop without any extra
handling, but -1 vs 0 for count will be a sign of having no or empty
allowlist

> +                                      sizeof(*obj->btf_module_names));
> +       if (!obj->btf_module_names)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < cnt; i++) {
> +               if (!names[i] || !names[i][0]) {
> +                       pr_warn("invalid kernel module BTF name at index =
%zu\n", i);

I don't think this will be some common mistake, let's drop all this
verbosity with pt_warn and so on, just error out

> +                       err =3D -EINVAL;
> +                       goto err_out;
> +               }
> +
> +               /*
> +                * The list is expected to be small, so a simple nested s=
can is
> +                * sufficient for duplicate detection.
> +                */

unnecessary comment, drop it

> +               for (j =3D 0; j < i; j++) {
> +                       if (strcmp(obj->btf_module_names[j], names[i]) =
=3D=3D 0) {
> +                               pr_warn("duplicate kernel module BTF name=
 '%s'\n",
> +                                       names[i]);

ditto, just error out, no pr_warn()

> +                               err =3D -EINVAL;
> +                               goto err_out;
> +                       }
> +               }
> +
> +               obj->btf_module_names[i] =3D strdup(names[i]);
> +               if (!obj->btf_module_names[i]) {
> +                       err =3D -ENOMEM;
> +                       goto err_out;
> +               }
> +
> +               obj->nr_btf_module_names++;
> +       }
> +       return 0;
> +
> +err_out:
> +       bpf_object_free_btf_module_names(obj);

I don't think we need to clean up here, bpf_object__close() will be
closed and will take care of this cleanup, keep the logic simple

> +       return err;
> +}
> +
> +static bool is_module_btf_needed(const struct bpf_object *obj, const cha=
r *name)

let's call this is_btf_mod_allowed()

> +{
> +       size_t i;
> +
> +       if (!obj->btf_module_names)
> +               return true;
> +
> +       for (i =3D 0; i < obj->nr_btf_module_names; i++) {
> +               if (strcmp(obj->btf_module_names[i], name) =3D=3D 0)
> +                       return true;
> +       }
> +
> +       pr_debug("skipping module BTF '%s', not in btf_module_names\n", n=
ame);

drop this pr_debug(), do you think it will be very useful? this whole
feature feels super niche, whoever is going to use it should know what
they are doing, so I find it unlikely that they might be surprised by
ignoring kernel module they explicitly excluded

> +       return false;
> +}
> +
> +static bool no_module_btfs_needed(const struct bpf_object *obj)
> +{
> +       return obj->btf_module_names && !obj->nr_btf_module_names;
> +}
> +
> +static bool all_needed_module_btfs_loaded(const struct bpf_object *obj)
> +{
> +       return obj->btf_module_names &&
> +              obj->nr_btf_module_names =3D=3D obj->btf_module_cnt;
> +}
> +

these two helpers are just verbosity, let's get rid of them and do
corresponding checks inline

>  static int load_module_btfs(struct bpf_object *obj)
>  {
>         struct bpf_btf_info info;
> @@ -5825,6 +5925,9 @@ static int load_module_btfs(struct bpf_object *obj)
>         if (!kernel_supports(obj, FEAT_MODULE_BTF))
>                 return 0;
>
> +       if (no_module_btfs_needed(obj))
> +               return 0;

under new convention, it will be `if (btf_mod_allowlist_cnt =3D=3D 0) retur=
n 0;`

> +
>         while (true) {
>                 err =3D bpf_btf_get_next_id(id, &id);
>                 if (err && errno =3D=3D ENOENT)
> @@ -5867,6 +5970,11 @@ static int load_module_btfs(struct bpf_object *obj=
)
>                         continue;
>                 }
>
> +               if (!is_module_btf_needed(obj, name)) {
> +                       close(fd);
> +                       continue;
> +               }
> +
>                 btf =3D btf_get_from_fd(fd, obj->btf_vmlinux);
>                 err =3D libbpf_get_error(btf);
>                 if (err) {
> @@ -5891,6 +5999,9 @@ static int load_module_btfs(struct bpf_object *obj)
>                         break;
>                 }
>                 obj->btf_module_cnt++;
> +
> +               if (all_needed_module_btfs_loaded(obj))
> +                       break;
>         }
>
>         if (err) {
> @@ -8508,6 +8619,10 @@ static struct bpf_object *bpf_object_open(const ch=
ar *path, const void *obj_buf,
>                 }
>         }
>
> +       err =3D bpf_object_init_btf_module_names(obj, opts);
> +       if (err)
> +               goto out;
> +
>         err =3D bpf_object__elf_init(obj);
>         err =3D err ? : bpf_object__elf_collect(obj);
>         err =3D err ? : bpf_object__collect_externs(obj);
> @@ -9629,6 +9744,8 @@ void bpf_object__close(struct bpf_object *obj)
>                 close(obj->jumptable_maps[i].fd);
>         zfree(&obj->jumptable_maps);
>
> +       bpf_object_free_btf_module_names(obj);
> +

just inline that simple clean up logic here without helper function

>         free(obj);
>  }
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad571540..1cabf7e46554 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -224,10 +224,32 @@ struct bpf_object_open_opts {
>          * point (/sys/fs/bpf), in case this default behavior is undesira=
ble.
>          */
>         const char *bpf_token_path;
> +       /*
> +        * Optional list of kernel module names whose BTFs should be load=
ed.
> +        * nr_btf_module_names specifies the number of entries in
> +        * btf_module_names.

not really, it's not "what should be loaded" but what is allowed to be
loaded. quite a difference, because with "should be loaded" we should
be failing if we don't find all those modules, but I don't think that
was the intent, was it?

> +        *
> +        * With btf_module_names:
> +        * - when provided, only the BTFs of the specified modules are lo=
aded;
> +        * - when an empty list is provided, no module BTFs are loaded;
> +        * - when NULL, all module BTFs are loaded as before.
> +        *

also mention that count should be zero for empty or NULL list

> +        * The list must contain valid, non-empty module names and must n=
ot
> +        * contain duplicate entries; otherwise -EINVAL is returned.
> +        *
> +        * This affects:

just say that this allowlist affects any place where kernel module BTF
might be needed by limiting which kernel module BTFs libbpf will
consult. no need to enumerate all the different places where we use
BTF, it will get out of sync too easily.

> +        * - BPF CO-RE relocations against types defined in modules;
> +        * - BTF-based resolution of attach targets;
> +        * - module-qualified tracing multi-attach targets;
> +        * - struct_ops kernel type resolution;
> +        * - extern (ksym) resolution for kernel symbols defined in modul=
es.
> +        */
> +       const char **btf_module_names;
> +       size_t nr_btf_module_names;
>
>         size_t :0;
>  };
> -#define bpf_object_open_opts__last_field bpf_token_path
> +#define bpf_object_open_opts__last_field nr_btf_module_names
>
>  /**
>   * @brief **bpf_object__open()** creates a bpf_object by opening
> --
> 2.34.1
>

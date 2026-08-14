Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F323D47B8
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737441; cv=pass; b=Qz7utTpr1kGBSUWG7LFcWFxiqWWvurBRz9e+0Pwu9nC0oik93qdPyCdRvsbBY6RevECkWZeojeoxFDGiLF6azGi3gs9omihcUDsTEzHauRSQTkzDeOjD6fwz57t087qLWfnF75nCC4SQ0codIaHRu1Od+DjZqQtWsg4G9A9wgP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737441; c=relaxed/simple;
	bh=D+PEs+ex4x+ZqgrHZ/mCR23C7ip1taoZmxaeLJJ0ixg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIK153o3VUesxOXaCHr6qAYdbbOQqlEBg/Wxn5TPqdpJ/9u3qvAZk5jvjHE8W9em4M0wQVLEuGQ42INodutXPL39x3jGaqhMVS0cYl5X2rs8yo5YpdeHJDuUhqEm2tvKxvkpoEp0XBi7du5Tj1sXmz/RFrtIdeZkwMuel3YCMBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd6R/e1G; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd6R/e1G"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbeea240819so791948a12.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 12:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786737439; cv=none;
        d=google.com; s=arc-20260327;
        b=iQsRb7m8f8m4eXnMfSEbAAcVOzqRWEyMFwN7D/xHVuFXto4tTWDiP6u01yZkUQgE8g
         GTgqHrI3B/wsmcFEvkr3CIAAKST58mBKTs4sGB3zl6kbUtOSmzYksQD0uhVpidM+uJSx
         DZuRxx5XCkODcAh0M6iur87EZdSVyxxejLXGNXR4DlNhKCzkec/v4NSYTLyZtc8Jx5RL
         OS2/HSexiY1iGcjdBsRf9gJv8IyY7SY58nTS0dMjeQsMZZq5rPdtNBkFKieNhM8OQYic
         EoZ3yvyWrW6EtdRHfpsrp/oBTLRP5fCBrfwOda92WXW0u+X88qTntSWcxLJLFGeC7Dqq
         Bf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GxRThMWsYWSqLjREEJH/Rk7+2XCwWI2hjqPniCOaR0g=;
        fh=/O9f9fCgh0b6I60vHHUOylqoIuazqnJ/NGSGXPvV/ug=;
        b=mQhCMFsq1tTU2oYoht1o+ZpEN5YcBcZw/VQicdSvWkqAwXfacS04XZniT00aYTVYkT
         T+aY98jWoNgamo8axQHEYch6IrG1jrhIsQLzSl7QWSN6vdHziWVJ4A1aufIx+MrtjI2W
         MatHTEKOrtM9nMeGqSgOQ9Xo1uqyDg7k98KrRXY4EhaMtFh6QcunLCGv1sEg8NJHm9aA
         dInVd307pNyLT9BaP6WeyO9ufBCMQfgLlzqvjLbBtSqSdcWAKb07WSf9sm9xYbRle64y
         EYsVrhe3//TFm7C3cSS/kkNl/OKct4ekmd7ddtbbFsZMurfZajcGJtGhrCc8DJ17q0n0
         gFBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786737439; x=1787342239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GxRThMWsYWSqLjREEJH/Rk7+2XCwWI2hjqPniCOaR0g=;
        b=gd6R/e1Gf5a3da2JvJtVnYyAnNhxsOwpM+qK6Nltsz6+XqeM+prxZVesZOpsXI6rn1
         kWmzkWLcCmyDll339qVEan4nqXO+I1m4974FTe+lxhaV3O8cxLzxAn4BkH49DKm7LDrG
         gCSw38xFtWJ6YVgYDRYf7572Ul2Ede+ArQrk/NHksUEECQPaUfZpnHJxSJrp87fSJd0E
         EeFHIrhE8E+3aS8ZawReAUcDtSmAPc5T5HfptZC0hKsNCfp0iR2y//95UCAjBeI2AQVO
         CSxoqXMJgVLY6lIEQ9oJXTu/xfIZ3QKqQQ+0jPl8LIiNhbihoLzQsqI4s5Q89UimkJ0I
         dQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786737439; x=1787342239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GxRThMWsYWSqLjREEJH/Rk7+2XCwWI2hjqPniCOaR0g=;
        b=IYu32teuzDs0W5DxXcxN2XtiglGUPyi4NbuRDmaZVDN5dlqRNZlqEyAJ00HhE5qdV9
         3T7ckPfeYfPmvd0/h0mngV/o75NR4S4d2OxrOqzMv0YSqfPCasScGsVYEs4wN+gI2ugY
         ErPfdy4KAfMdYcNiFO+NHtcI5pxLz9k1k/koRk5N2sIjDwh7FEyLFEmcAd+cQ4QHetrE
         UJqSx4CKJkbNHB7Y+xB1ly2omAEZtCmiKsZDfTgh0WfkAg9WOUku9VqfREVVjHdCTccI
         HXxt8K3G+5OeOTBAIGtkWEGeiT901Ny78HKHZnX3BdbFJoZgYZLwX29VN8Pyud+u3r+h
         EuFw==
X-Gm-Message-State: AOJu0YxO4EziLoIG0RUt8CAgIX/ZM3/uPUhhZSdS6EOtMW40lzzs2+Dj
	4OWGNTYnqiz+bhWoj1YGDuFJ1+WvYoD/POo9GGf9762Q46JGV8iRfXZqU7P8jlgIU6mkRsx73pk
	TAzegZxOT4VoNoWGhxpnSm5BNlKGT45c=
X-Gm-Gg: AR+sD10AQS/YXqjGIXkNwrAKJ4JI9jaOIyDGDrFqUM1WJce8jkAXmQk0j+C9JvE6PwI
	d35ynC4JTU+KImqu4PCtlj8zY1HsDFpOHbWTgFp0KOL8ePBtD7Mvq5ld0o/E7fKI3vyYbdZJVxg
	SdJOwSM0YZcjfNbMlQIWpfLzOOg9wQlg25MBOXTmWerTalJpDpf9RAHHs6eOoMxZB8NwpJdYIrx
	ENEquXui4q9XjKeIK/zitvIyr1BH9EsAeK9VvWoa5Y8xYa8XiHaBFARiJdcEGYGwcfau3hCAXm3
	FXdgAtKjV60F5WhRts1p/H3Rntll/8QLQPwG+e2HlmUvERwuWLdPC1pmfO+uYaOnxwCpJl513sO
	VtPBkI/Sbr5vOjcGP8FoevfzdDvyQIlyST2Pb
X-Received: by 2002:a05:6a20:2446:b0:3b4:8880:2089 with SMTP id
 adf61e73a8af0-3cc71b16592mr9552678637.16.1786737438869; Fri, 14 Aug 2026
 12:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813032613.2755-1-zhaofuyu@vivo.com> <20260813032613.2755-2-zhaofuyu@vivo.com>
In-Reply-To: <20260813032613.2755-2-zhaofuyu@vivo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Aug 2026 12:57:06 -0700
X-Gm-Features: AUfX_mx5SZiJQYudo19PjEAX5yEv1Zoi1DZrDotx-9qc_B7k_-zVxtlfdVXTGn0
Message-ID: <CAEf4Bza54yCwkOte77jkwCM3W+Oo2eH4bL0xqHmvYg5kZnXbxw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 1/2] libbpf: support selective kernel
 module BTF loading via .kmod_btfs section
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, alan.maguire@oracle.com, 
	ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	shuah@kernel.org, yatsenko@meta.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 8:26=E2=80=AFPM Fuyu Zhao <zhaofuyu@vivo.com> wrote=
:
>
> Add support for a new ELF section ".kmod_btfs" that allows BPF programs
> to declare which kernel modules need BTF loading. This avoids loading
> all module BTFs and speeds up program load when only a subset of modules
> is needed.
>
> Specifically, this patch introduces two internal functions:
>   - bpf_object__collect_kmod_btf_names(): parses the ".kmod_btfs"
>     section and collects the declared module names.
>   - is_kmod_btf_needed(): determines whether a given module's BTF
>     should be loaded, allowing libbpf to skip unneeded modules.
>
> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
> ---
>  tools/lib/bpf/bpf_helpers.h |  14 +++++
>  tools/lib/bpf/libbpf.c      | 106 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 9d160b5b9c0e..171ea055cd32 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -188,6 +188,20 @@ enum libbpf_tristate {
>         TRI_MODULE =3D 2,
>  };
>
> +/* Helper typedef for declaring kernel module names that need BTF loadin=
g.
> + *
> + * Usage: define an array in the ".kmod_btfs" ELF section to specify
> + * which modules need BTF loading:
> + *
> + *   DEFINE_KMOD_BTFS(_needed_kmods)=3D { "module1", "module2", ... };
> + *
> + * This avoids unnecessary BTF loading and speeds up the BPF program
> + * load process.
> + */
> +#define KMOD_NAME_LEN 64
> +#define DEFINE_KMOD_BTFS(name) \
> +       SEC(".kmod_btfs") char name[][KMOD_NAME_LEN]
> +

I don't really like another special ELF section just to provide a
custom list of modules.

If we have to do a customization of BTF searching behavior of libbpf,
let's do this through bpf_object_open_opts struct and pass NULL or a
empty/non-empty list of kernel modules, or whatever other appropriate
way to specify this.

But in any case, extending ELF format for BPF object file for this
seems like an overkill and overcomplication.

pw-bot: cr

>  #define __kconfig __attribute__((section(".kconfig")))
>  #define __ksym __attribute__((section(".ksyms")))
>  #define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 514e4e9daa82..9fe8a653e8b6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -548,6 +548,7 @@ struct bpf_struct_ops {
>  #define STRUCT_OPS_SEC ".struct_ops"
>  #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
>  #define ARENA_SEC ".addr_space.1"
> +#define KMODS_BTFS_SEC ".kmod_btfs"
>
>  enum libbpf_map_type {
>         LIBBPF_MAP_UNSPEC,
> @@ -703,6 +704,9 @@ enum bpf_object_state {
>         OBJ_LOADED,
>  };
>
> +/* Should match the definition in bpf_helpers.h */
> +#define KMOD_NAME_LEN 64
> +
>  struct bpf_object {
>         char name[BPF_OBJ_NAME_LEN];
>         char license[64];
> @@ -779,6 +783,14 @@ struct bpf_object {
>         char *token_path;
>         int token_fd;
>
> +       /* kernel module BTFs to load, declared in ".kmod_btfs" ELF secti=
on */
> +       struct {
> +               char (*data)[KMOD_NAME_LEN];
> +               size_t nr_names;
> +               size_t nr_loaded;
> +               struct hashmap *hashmap;
> +       } *kmod_btfs;
> +
>         char path[];
>  };
>
> @@ -901,6 +913,75 @@ bpf_object__init_prog(struct bpf_object *obj, struct=
 bpf_program *prog,
>         return -ENOMEM;
>  }
>
> +static size_t mod_name_hash_fn(long key, void *ctx)
> +{
> +       return str_hash((char *)key);
> +}
> +
> +static bool mod_name_equal_fn(long key1, long key2, void *ctx)
> +{
> +       return strcmp((char *)key1, (char *)key2) =3D=3D 0;
> +}
> +
> +static int
> +bpf_object__collect_kmod_btf_names(struct bpf_object *obj, Elf_Data *sec=
_data,
> +                                  const char *sec_name)
> +{
> +       int module_cnt, i, err =3D 0;
> +
> +       if (obj->kmod_btfs) {
> +               pr_warn("sec '%s': duplicate sections detected\n", sec_na=
me);
> +               return -EEXIST;
> +       }
> +
> +       if (sec_data->d_size % KMOD_NAME_LEN !=3D 0) {
> +               pr_warn("sec '%s': size %zu should be multiple of %d\n",
> +                       sec_name, sec_data->d_size, KMOD_NAME_LEN);
> +               return -EINVAL;
> +       }
> +
> +       module_cnt =3D sec_data->d_size / KMOD_NAME_LEN;
> +       obj->kmod_btfs =3D calloc(1, sizeof(*obj->kmod_btfs));
> +       if (!obj->kmod_btfs)
> +               return -ENOMEM;
> +
> +       obj->kmod_btfs->data =3D calloc(module_cnt, KMOD_NAME_LEN);
> +       if (!obj->kmod_btfs->data) {
> +               err =3D -ENOMEM;
> +               goto err_out;
> +       }
> +       memcpy(obj->kmod_btfs->data, sec_data->d_buf, sec_data->d_size);
> +
> +       obj->kmod_btfs->hashmap =3D hashmap__new(mod_name_hash_fn,
> +                                              mod_name_equal_fn, NULL);
> +       if (IS_ERR(obj->kmod_btfs->hashmap)) {
> +               err =3D PTR_ERR(obj->kmod_btfs->hashmap);
> +               goto err_out;
> +       }
> +
> +       for (i =3D 0; i < module_cnt; i++) {
> +               obj->kmod_btfs->data[i][KMOD_NAME_LEN - 1] =3D '\0';
> +               if (hashmap__find(obj->kmod_btfs->hashmap,
> +                                 obj->kmod_btfs->data[i], NULL)) {
> +                       pr_warn("sec '%s': ignored duplicate module '%s'\=
n",
> +                               sec_name, obj->kmod_btfs->data[i]);
> +                       continue;
> +               }
> +               err =3D hashmap__set(obj->kmod_btfs->hashmap, obj->kmod_b=
tfs->data[i],
> +                                  0, NULL, NULL);
> +               if (err)
> +                       goto err_out;
> +               obj->kmod_btfs->nr_names++;
> +       }
> +       return 0;
> +
> +err_out:
> +       hashmap__free(obj->kmod_btfs->hashmap);
> +       zfree(&obj->kmod_btfs->data);
> +       zfree(&obj->kmod_btfs);
> +       return err;
> +}
> +
>  static int
>  bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
>                          const char *sec_name, int sec_idx)
> @@ -4034,6 +4115,10 @@ static int bpf_object__elf_collect(struct bpf_obje=
ct *obj)
>                                 memcpy(obj->jumptables_data, data->d_buf,=
 data->d_size);
>                                 obj->jumptables_data_sz =3D data->d_size;
>                                 obj->efile.jumptables_data_shndx =3D idx;
> +                       } else if (strcmp(name, KMODS_BTFS_SEC) =3D=3D 0)=
 {
> +                               err =3D bpf_object__collect_kmod_btf_name=
s(obj, data, name);
> +                               if (err)
> +                                       return err;
>                         } else {
>                                 pr_info("elf: skipping unrecognized data =
section(%d) %s\n",
>                                         idx, name);
> @@ -5803,6 +5888,11 @@ int bpf_core_add_cands(struct bpf_core_cand *local=
_cand,
>         return 0;
>  }
>
> +static bool is_kmod_btf_needed(struct bpf_object *obj, const char *name)
> +{
> +       return hashmap_find(obj->kmod_btfs->hashmap, (long)name, NULL);
> +}
> +
>  static int load_module_btfs(struct bpf_object *obj)
>  {
>         struct bpf_btf_info info;
> @@ -5867,6 +5957,12 @@ static int load_module_btfs(struct bpf_object *obj=
)
>                         continue;
>                 }
>
> +               if (obj->kmod_btfs && obj->kmod_btfs->hashmap &&
> +                   !is_kmod_btf_needed(obj, name)) {
> +                       close(fd);
> +                       continue;
> +               }
> +
>                 btf =3D btf_get_from_fd(fd, obj->btf_vmlinux);
>                 err =3D libbpf_get_error(btf);
>                 if (err) {
> @@ -5891,6 +5987,10 @@ static int load_module_btfs(struct bpf_object *obj=
)
>                         break;
>                 }
>                 obj->btf_module_cnt++;
> +
> +               if (obj->kmod_btfs &&
> +                   obj->kmod_btfs->nr_names =3D=3D obj->kmod_btfs->nr_lo=
aded)
> +                       break;
>         }
>
>         if (err) {
> @@ -9030,6 +9130,12 @@ static void bpf_object_cleanup_btf(struct bpf_obje=
ct *obj)
>         /* clean up vmlinux BTF */
>         btf__free(obj->btf_vmlinux);
>         obj->btf_vmlinux =3D NULL;
> +
> +       if (obj->kmod_btfs) {
> +               hashmap__free(obj->kmod_btfs->hashmap);
> +               zfree(&obj->kmod_btfs->data);
> +               zfree(&obj->kmod_btfs);
> +       }
>  }
>
>  static void bpf_object_post_load_cleanup(struct bpf_object *obj)
> --
> 2.34.1
>

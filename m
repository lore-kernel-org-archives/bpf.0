Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.230.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795016862;
	b=PcmNJmdcBo57J3qBys6f9f8Pd0k92MnxkOLLK67y/KV25ovCaDcUTh19AaSJ2FdpcnLC
	 zkxjP+kyoNhAGnQyXA1g+U0M4DpU1ti3wtwCV7hL3VqxxbbTTJUinSyesd33y+r1917Ja
	 q3JjsyadoEvTPhvsaEB4s5gSTsayqO28ZsydSung6ZYOvCTO5QrDQLZIxfG165Q83kkoY
	 r7S1FvT+vRHsun7XiSmUL/JLjHnntSFSVW6D6ggYPv+2EAJ6KyZ4fILOxkAsJvX/IDQsh
	 NH3IuJAPVJ8mVPXKBGsicdtLp7UTE8jegdBkGJVAs7XlWiZb9GAha624JFYrrOy4EpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=3WAqWA5goUdPHnVioSm+GKjjhwwf9ja5lGy7+3nU6S4=;
	b=sbEXQ1QM8Eey2xc7iY/CCWq4M7p5gqe8TIzxfJs6WJS8QLV0G3t0Yvrmo3/ZENtrl/Zl
	 70zuw+5bnOmTIJria3zcrVb1Z4ouhcBfcxK4tirEXFaUteTmeRiG4sal77liIdJDqrIbd
	 kvDk0TZCQPGV7L6o5Y4t2bLArvzueJsDZ6XmBYQHuPwargUqTmMstbcKckbiT0kjlYWyW
	 w7wGelGpStD3wIpxiewv6scuzTk7xogqCkj8yWbKNfT1MAIZtrUeJRI2eCZPpdt0cL38p
	 sxpQz+7f+ljrAQmjum6GVmFnuqTI7SweZWX495HJ4PHXOad9II31dCzielxssqgqsuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="p/o0/n3a";
	arc=fail smtp.remote-ip=74.125.230.72
Received: from mail-lr2-f8.google.com (mail-lr2-f8.google.com [74.125.230.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E98606A334
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 15:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11E98606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p/o0/n3a
Received: by mail-lr2-f8.google.com with SMTP id 38308e7fff4ca-3adf0220e61so4712361fa.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 07:47:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795016860; cv=none;
        d=google.com; s=arc-20260327;
        b=gyxO6JCbuhPiNTHaFsKXIQC4yl2fhGvuxNPa4HbtjSTTOloZh9jBkmTvXdBOCtAdc9
         unBCDmPs2O6EISlJcbWzgTEYZ0n7nQV0VREvcg+UopN9EjmO0KBqQunlz203wi8BSK1I
         ttS2WfKZyw7ZSHJmVFYcHV6sbjXM9+2GJUqRgunaWTHxhrG3snEpHv2C+A3HwQEyf4TH
         UJ6mDNE8hgpnKTksHsknmhMCOG7TgBSSFHSe5LfSzsq+FAUMYMiOMbOTDfTWp5vSJvy8
         2rKI3g8BrhJrTuawvS6gK8YN4CHuXo1XRTnPhFJUgGLWEtb7ZxHYcI7/7D9cGQutwAMH
         0/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3WAqWA5goUdPHnVioSm+GKjjhwwf9ja5lGy7+3nU6S4=;
        fh=XlgN7H5hlpw3p9JzO18EdEbEimx17ji1KAPOk2u9lkc=;
        b=lHYnVXKGR2CqisZts3zhmKuzgrm/MdogTjXHIlzTzRlSB5aYO8R2ZEz5P/jBINmgH4
         0kpnxhxbbLQvUJ6u9I54Ss1GeIHkhDQF4P3mZnPbiBeCMAjSQbWK7+czHm4e3t+XnNx9
         z32F670Pe9ztqp+ooJCuJmjk/PtYFeuI8WuumTJL+/3Kvld64omJycDBcmVJ+wm9otrK
         VrmcQLjhJA38bZ3odcVgUneLpIkoT21m2QyP73pc1TUR7a86wmb9d1tYD3Of8qQLUiuK
         QEuhyrre0EB2YaNc2nhmKYdWIj3n53bJ7VQ24msLzkLxq98V9TPurqoE6qUP7WGW/XED
         6miA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795016860; x=1795621660; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WAqWA5goUdPHnVioSm+GKjjhwwf9ja5lGy7+3nU6S4=;
        b=p/o0/n3a1Nm+8zrZHbkZU5x8/uAhd2rQwTY/0f7Ta2ZxCWDMcs2QbcqBAGe4tVFOsE
         XXYRNaMbf6HAhy4RN8qE69uw3RGxvwVubwE64JUvNPTa3o+lw1HP0WSM6FA9ckJEdMbt
         W+V82kGKOdHY8GyqfcDF2Xm0vZPBPElTcP17RRTjHHiaxIzzRHNQOyVHUJ9e9p4sBGrn
         mqx2bVpeIR7XKeIiZcTm2Ue1D+OvtaSnZVrbIV1Kf4KWR/oCcfkLeRR1A60PJkABKxzD
         Foya+D2ABrPJFoHwwlthwGnVn43ybslNyXn4syuCK7Y7eU68rFsTPt63AK1REshFivai
         q/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795016860; x=1795621660;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3WAqWA5goUdPHnVioSm+GKjjhwwf9ja5lGy7+3nU6S4=;
        b=gmkOrWW9LIkSfVUNgyTzF9AqymBJ0eUd4k8t9q45i/BYIm3xcxguymm0l8gMHA2r28
         I52pricwXLxrRgk6xV5Vue5X0+5kTvH+t6IQ6gD3zmAer1WuO7owIhsq+DbrViks22+4
         yZam2rmKByEy2Wn/XRESd4RbiMcFqsacagUIg9GdYYolm1wzazPBppehanTfteKcZHg8
         UVc4i2fi9QB1APJxblHZCTMnJBhOx8x6tMjOefd/f/pVi5A7YBGlRThpsqoXwF2iCWMB
         JRdXRCNujjP6TMzFRDP+0FzFk92YT9+5WiRjAmeITNU7TQYmgPBm7yBreocWZPUtbWQw
         9dUA==
X-Forwarded-Encrypted: i=1; AL+hErFQukEyAii/8cjh30IExlMIbY/s5xm1cORdodUh3e3c07XpszdSV4CjO3IdHBqktOpdPwM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CFwYdnHmSLg+XlCrFZgUWjjTOspkNDv62Cx/8kpugc/1lZ7wU
	NN4ZVuOx7e4v2lAuldLwu0P1b9wg0t5W3aX4eU1PnJyO/EvGSsTDL1TCgfRlQdOkheqpW93b3Vo
	WzitSCWN8pzO61wp3qMPiDriVs2QiIak=
X-Gm-Gg: AYBFou0//ykpPTZbz8n6VsPYfHWB0zvnfA/hb2rLfBmMFqUCFKSkpjFKfNI21/UQnoY
	yHAAmLhA896SPb7DjwoQRWLEjpQ6eWUrXrcCItDFf8TdeB98v9s6W4kbUTOmW8hEtF9ONnpK3Zd
	tzkFqzJ914nkzCFiDxr8FBXUgAde8PmjxOq1gIzaPo6SD7hFckuqZlCHVChNhQMuv2IHy536oOH
	7LWAmKCTzXCYwhbosxEEF/3znH5mkIUSSzPzE+TnXZ5px/ziY+lEVGNDPUf2LIpqc8jnWW1JHob
	pTrZq5gqoEmfDsVuxjn7w+vNxv8p+qb/ihCID7TaDUVizJ6iBeLKKyV8J2nBm2TxdSS8Jd4cZHP
	0dPCsR1aNl09bm4DJinWoCBTq3AlwjGvlmlc2zA==
X-Received: by 2002:a05:6512:2387:b0:5c1:4f4d:cb9c with SMTP id
 2adb3069b0e04-5c1a9d2cf47mr969576e87.40.1795016859552; Wed, 18 Nov 2026
 07:47:39 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <avzIz70qnJIA2t3x@sirena.org.uk>
In-Reply-To: <avzIz70qnJIA2t3x@sirena.org.uk>
From: J4f J4f <shlomojune6@gmail.com>
Date: Wed, 18 Nov 2026 23:47:26 +0800
X-Gm-Features: AclHuK_RiAIyf8f85-0Dlp7Zg4S5cHp2wH8Wd464BSCht-p0f6fNRI9Z5TNEFl4
Message-ID: <CAE_LbwkvPV2-LJ2b7OCFzmWmBP-jfxeMR=ARZJvuF4RNx8M1dw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
To: Mark Brown <broonie@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Nov 2026 at 05:36, Mark Brown <broonie@kernel.org> wrote:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/btf.c
>
> between commit:
>
>   b7cc45994c3f9 ("bpf: Check variable-offset accesses against special fields")
>
> from the bpf tree and commit:
>
>   ca4395aade31a ("bpf: Walk each type once when looking for special fields")
>
> from the bpf-next tree.  I'm not confident of this merge, it discards
> the bpf commit on the basis that it looks like there is some new
> handling of special fields in the bpf-next tree but I'm not sure that
> overlaps with the fix.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
Hi Mark,

Thanks for the report.

I reproduced this on bpf-next master: the rewrite does not cover the fix,
the check in btf_struct_access() now only looks at min_off again. I will
send a v4 rebased on top of the bpf-next series shortly.

Thanks,
Shihuang
> diff --combined kernel/bpf/btf.c
> index 49fcd32d418a9,e95ca39f990c6..0000000000000
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@@ -281,6 -281,7 +281,7 @@@ struct btf
>         char name[MODULE_NAME_LEN];
>         bool kernel_btf;
>         __u32 *base_id_map; /* map from distilled base BTF -> vmlinux BTF ids */
> +       u32 *next_tag; /* see btf_link_decl_tags() */
>   };
>
>   enum verifier_phase {
> @@@ -308,6 -309,9 +309,9 @@@ enum resolve_mode
>                                          */
>   };
>
> + /* It bounds the time of the loops that compare or print names */
> + #define BTF_MAX_NAME_LEN 4096
> +
>   #define MAX_RESOLVE_DEPTH 32
>
>   struct btf_sec_info {
> @@@ -319,6 -323,7 +323,7 @@@ struct btf_verifier_env
>         struct btf *btf;
>         u8 *visit_states;
>         struct resolve_vertex stack[MAX_RESOLVE_DEPTH];
> +       unsigned long *names;   /* offsets of the strings that can be names */
>         struct bpf_verifier_log log;
>         u32 log_type_id;
>         u32 top_stack;
> @@@ -684,10 -689,15 +689,15 @@@ s32 btf_find_by_name_kind(const struct
>                                 return id;
>                 }
>         } else {
> +               /* only the tags in BTF of a program have long names */
> +               bool slow = !btf->kernel_btf && strlen(name) > KSYM_NAME_LEN;
> +
>                 for (id = btf_start_id(btf); id < total; id++) {
>                         t = btf_type_by_id(btf, id);
>                         if (BTF_INFO_KIND(t->info) != kind)
>                                 continue;
> +                       if (slow && bpf_must_abort())
> +                               return -EINTR;
>                         tname = btf_name_by_offset(btf, t->name_off);
>                         if (strcmp(tname, name) == 0)
>                                 return id;
> @@@ -914,49 -924,6 +924,6 @@@ const char *btf_str_by_offset(const str
>         return NULL;
>   }
>
> - /* Names in BTF of Rust are not C identifiers. Allow any printable character */
> - static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
> - {
> -       /* offset must be valid */
> -       const char *src = btf_str_by_offset(btf, offset);
> -       const char *src_limit;
> -
> -       if (!isprint(*src))
> -               return false;
> -
> -       /* set a limit on identifier length */
> -       src_limit = src + KSYM_NAME_LEN;
> -       src++;
> -       while (*src && src < src_limit) {
> -               if (!isprint(*src))
> -                       return false;
> -               src++;
> -       }
> -
> -       return !*src;
> - }
> -
> - /* Allow any printable character in DATASEC names */
> - static bool btf_name_valid_section(const struct btf *btf, u32 offset)
> - {
> -       /* offset must be valid */
> -       const char *src = btf_str_by_offset(btf, offset);
> -       const char *src_limit;
> -
> -       if (!*src)
> -               return false;
> -
> -       /* set a limit on identifier length */
> -       src_limit = src + KSYM_NAME_LEN;
> -       while (*src && src < src_limit) {
> -               if (!isprint(*src))
> -                       return false;
> -               src++;
> -       }
> -
> -       return !*src;
> - }
> -
>   static const char *__btf_name_by_offset(const struct btf *btf, u32 offset)
>   {
>         const char *name;
> @@@ -1907,6 -1874,7 +1874,7 @@@ static void btf_free(struct btf *btf
>         if (!btf_is_vmlinux(btf))
>                 kvfree(btf->data);
>         kvfree(btf->base_id_map);
> +       kvfree(btf->next_tag);
>         kfree(btf);
>   }
>
> @@@ -1991,9 -1959,21 +1959,21 @@@ nomem
>   static void btf_verifier_env_free(struct btf_verifier_env *env)
>   {
>         kvfree(env->visit_states);
> +       kvfree(env->names);
>         kfree(env);
>   }
>
> + /* Names in BTF of Rust are not C identifiers. Allow any printable character */
> + static bool btf_name_valid(const struct btf_verifier_env *env, u32 offset)
> + {
> +       const struct btf *btf = env->btf;
> +
> +       /* offset must be valid */
> +       if (offset < btf->start_str_off)
> +               return *btf_str_by_offset(btf, offset);
> +       return test_bit(offset - btf->start_str_off, env->names);
> + }
> +
>   static bool env_type_is_resolve_sink(const struct btf_verifier_env *env,
>                                      const struct btf_type *next_type)
>   {
> @@@ -2766,7 -2746,7 +2746,7 @@@ static int btf_ref_type_check_meta(stru
>          */
>         if (BTF_INFO_KIND(t->info) == BTF_KIND_TYPEDEF) {
>                 if (!t->name_off ||
> -                   !btf_name_valid_identifier(env->btf, t->name_off)) {
> +                   !btf_name_valid(env, t->name_off)) {
>                         btf_verifier_log_type(env, t, "Invalid name");
>                         return -EINVAL;
>                 }
> @@@ -3028,7 -3008,7 +3008,7 @@@ static s32 btf_fwd_check_meta(struct bt
>
>         /* fwd type must have a valid name */
>         if (!t->name_off ||
> -           !btf_name_valid_identifier(env->btf, t->name_off)) {
> +           !btf_name_valid(env, t->name_off)) {
>                 btf_verifier_log_type(env, t, "Invalid name");
>                 return -EINVAL;
>         }
> @@@ -3351,7 -3331,7 +3331,7 @@@ static s32 btf_struct_check_meta(struc
>
>         /* struct type either no name or a valid one */
>         if (t->name_off &&
> -           !btf_name_valid_identifier(env->btf, t->name_off)) {
> +           !btf_name_valid(env, t->name_off)) {
>                 btf_verifier_log_type(env, t, "Invalid name");
>                 return -EINVAL;
>         }
> @@@ -3369,7 -3349,7 +3349,7 @@@
>
>                 /* struct member either no name or a valid one */
>                 if (member->name_off &&
> -                   !btf_name_valid_identifier(btf, member->name_off)) {
> +                   !btf_name_valid(env, member->name_off)) {
>                         btf_verifier_log_member(env, t, member, "Invalid name");
>                         return -EINVAL;
>                 }
> @@@ -3636,13 -3616,45 +3616,45 @@@ static int btf_find_kptr(const struct b
>         return BTF_FIELD_FOUND;
>   }
>
> + /* For BTF of programs: next_tag[type] -> its first tag, next_tag[tag] -> its next tag, ... 0 */
> + static int btf_link_decl_tags(struct btf *btf)
> + {
> +       u32 i;
> +
> +       btf->next_tag = kvcalloc(btf->nr_types, sizeof(u32), GFP_KERNEL | __GFP_NOWARN);
> +       if (!btf->next_tag)
> +               return -ENOMEM;
> +       for (i = btf->nr_types; --i;) {
> +               if (!btf_type_is_decl_tag(btf->types[i]))
> +                       continue;
> +               btf->next_tag[i] = btf->next_tag[btf->types[i]->type];
> +               btf->next_tag[btf->types[i]->type] = i;
> +       }
> +       return 0;
> + }
> +
> + static int btf_type_ptr_cmp(const void *a, const void *b)
> + {
> +       return cmp_int(*(void **)a, *(void **)b);
> + }
> +
> + /* last_id is 0 for the first tag */
>   int btf_find_next_decl_tag(const struct btf *btf, const struct btf_type *pt,
>                            int comp_idx, const char *tag_key, int last_id)
>   {
> +       int i = last_id ?: btf_named_start_id(btf, false) - 1, n = btf_nr_types(btf);
>         int len = strlen(tag_key);
> -       int i, n;
> +       struct btf_type **p;
>
> -       for (i = last_id + 1, n = btf_nr_types(btf); i < n; i++) {
> +       if (btf->next_tag && !last_id) {
> +               /* the types are in the order of their ids in btf->data */
> +               p = bsearch(&pt, btf->types + 1, n - 1, sizeof(*p), btf_type_ptr_cmp);
> +               if (!p)
> +                       return -ENOENT;
> +               i = p - btf->types;
> +       }
> +
> +       while ((i = btf->next_tag ? btf->next_tag[i] ?: n : i + 1) < n) {
>                 const struct btf_type *t = btf_type_by_id(btf, i);
>
>                 if (!btf_type_is_decl_tag(t))
> @@@ -3665,8 -3677,7 +3677,7 @@@ const char *btf_find_decl_tag_value(con
>         const struct btf_type *t;
>         int len, id;
>
> -       id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key,
> -                                   btf_named_start_id(btf, false) - 1);
> +       id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key, 0);
>         if (id < 0)
>                 return ERR_PTR(id);
>
> @@@ -3682,6 -3693,36 +3693,36 @@@
>         return value;
>   }
>
> + /*
> +  * The value of the decl tag "<tag_key><value>" on a function of the kernel or of
> +  * a module. The build sorts their BTF by name: the tags with one key are
> +  * neighbours, and so are those with one value.
> +  *
> +  * Only the own types of btf are searched, not its base. With the BTF of a module
> +  * func_id can be a FUNC of vmlinux: it stands for the function of that name in the
> +  * module. What the build found in the code of vmlinux is not true for it.
> +  */
> + const char *btf_find_func_tag_value(const struct btf *btf, u32 func_id, const char *tag_key)
> + {
> +       int id, n = btf_nr_types(btf), len = strlen(tag_key);
> +       const char *name = NULL;
> +       u32 name_off = 0;
> +
> +       for (id = btf_find_by_name_kind_bsearch(btf, tag_key); id < n; id++) {
> +               const struct btf_type *t = btf_type_by_id(btf, id);
> +
> +               if (t->name_off != name_off) {
> +                       name_off = t->name_off;
> +                       name = btf_name_by_offset(btf, name_off);
> +                       if (strncmp(name, tag_key, len))
> +                               break;
> +               }
> +               if (t->type == func_id && btf_type_is_decl_tag(t))
> +                       return name + len;
> +       }
> +       return NULL;
> + }
> +
>   static int
>   btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
>                     const struct btf_type *t, int comp_idx, u32 off,
> @@@ -3773,106 -3814,106 +3814,106 @@@ end
>         return type;
>   }
>
> - /* Repeat a number of fields for a specified number of times.
> + /*
> +  * A walk over the members of a type and of the structs in it. A struct is entered once.
> +  * The next member of that type gets a copy of the fields that were found:
>    *
> -  * Copy the fields starting from the first field and repeat them for
> -  * repeat_cnt times. The fields are repeated by adding the offset of each
> -  * field with
> -  *   (i + 1) * elem_size
> -  * where i is the repeat index and elem_size is the size of an element.
> +  *   struct in  { kptr p; };
> +  *   struct out { struct in a; long x; struct in b[2]; };
> +  *                enter 'in'           copy from a, twice
>    */
> - static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
> -                            u32 field_cnt, u32 repeat_cnt, u32 elem_size)
> + struct btf_field_walk {
> +       struct btf_field_info *info;
> +       u32 cnt;
> +       u32 field_mask;
> +       u32 seen_mask;
> +       struct btf_field_scope {
> +               const struct btf_type *t;
> +               u32 off;        /* in the outer type */
> +               u32 nelems;
> +               u32 first;      /* its fields in 'info' */
> +               u32 cnt;
> +               u32 next;       /* member to look at */
> +               u32 parent;
> +       } *scopes;
> +       u32 scope;              /* the current one */
> +       struct bpf_index index; /* address of the type -> scope */
> + };
> +
> + /* An allocated object has 4096 bytes at most */
> + #define BTF_OBJ_FIELDS_MAX (SZ_4K / sizeof(u64))
> +
> + static int btf_add_field(struct btf_field_walk *w, struct btf_field_info info)
>   {
> -       u32 i, j, total_cnt, total_repeats;
> -       u32 cur;
> -
> -       /* Ensure not repeating fields that should not be repeated. */
> -       for (i = 0; i < field_cnt; i++) {
> -               switch (info[i].type) {
> -               case BPF_KPTR_UNREF:
> -               case BPF_KPTR_REF:
> -               case BPF_KPTR_PERCPU:
> -               case BPF_UPTR:
> -               case BPF_LIST_HEAD:
> -               case BPF_RB_ROOT:
> -                       break;
> -               default:
> -                       return -EINVAL;
> -               }
> -       }
> -
> -       if (check_add_overflow(repeat_cnt, 1, &total_repeats) ||
> -           check_mul_overflow(field_cnt, total_repeats, &total_cnt) ||
> -           total_cnt > (u32)info_cnt)
> -               return -E2BIG;
> -
> -       cur = field_cnt;
> -       for (i = 0; i < repeat_cnt; i++) {
> -               memcpy(&info[cur], &info[0], field_cnt * sizeof(info[0]));
> -               for (j = 0; j < field_cnt; j++)
> -                       info[cur++].off += (i + 1) * elem_size;
> -       }
> +       struct btf_field_info *last = w->cnt ? &w->info[w->cnt - 1] : NULL;
>
> +       if (last && info.off < last->off + btf_field_type_size(last->type))
> +               return -EEXIST;
> +       if ((w->field_mask & BPF_GRAPH_NODE) && w->cnt == BTF_OBJ_FIELDS_MAX)
> +               return -EFBIG;
> +       if (bpf_must_abort())
> +               return -EINTR;
> +       if (!bpf_table_next(w->info, w->cnt))
> +               return -ENOMEM;
> +       w->info[w->cnt++] = info;
>         return 0;
>   }
>
> - static int btf_find_struct_field(const struct btf *btf,
> -                                const struct btf_type *t, u32 field_mask,
> -                                struct btf_field_info *info, int info_cnt,
> -                                u32 level, u32 *seen_mask);
> -
> - /* Find special fields in the struct type of a field.
> -  *
> -  * This function is used to find fields of special types that is not a
> -  * global variable or a direct field of a struct type. It also handles the
> -  * repetition if it is the element type of an array.
> -  */
> - static int btf_find_nested_struct(const struct btf *btf, const struct btf_type *t,
> -                                 u32 off, u32 nelems,
> -                                 u32 field_mask, struct btf_field_info *info,
> -                                 int info_cnt, u32 level, u32 *seen_mask)
> + /* Copy 'cnt' fields from 'first' on to 'nelems' elements. The first copy is 'by' bytes off. */
> + static int btf_repeat_fields(struct btf_field_walk *w, u32 first, u32 cnt, u32 by,
> +                            u32 nelems, u32 elem_size, bool array)
>   {
> -       int ret, err, i;
> +       struct btf_field_info info;
> +       u32 i, j;
> +       int err;
>
> -       level++;
> -       if (level >= MAX_RESOLVE_DEPTH)
> -               return -E2BIG;
> -
> -       ret = btf_find_struct_field(btf, t, field_mask, info, info_cnt, level, seen_mask);
> -
> -       if (ret <= 0)
> -               return ret;
> -
> -       /* Shift the offsets of the nested struct fields to the offsets
> -        * related to the container.
> -        */
> -       for (i = 0; i < ret; i++)
> -               info[i].off += off;
> -
> -       if (nelems > 1) {
> -               err = btf_repeat_fields(info, info_cnt, ret, nelems - 1, t->size);
> -               if (err == 0)
> -                       ret *= nelems;
> -               else
> -                       ret = err;
> +       for (i = 0; i < nelems && cnt; i++, by += elem_size) {
> +               for (j = first; j < first + cnt; j++) {
> +                       info = w->info[j];
> +                       info.off += by;
> +                       if (array && !(info.type & (BPF_KPTR | BPF_UPTR | BPF_GRAPH_ROOT)))
> +                               return -EINVAL;
> +                       if (info.type & w->seen_mask)
> +                               return -E2BIG;
> +                       err = btf_add_field(w, info);
> +                       if (err)
> +                               return err;
> +               }
>         }
> +       return 0;
> + }
>
> -       return ret;
> + static int btf_enter_struct(struct btf_field_walk *w, const struct btf_type *t, u32 off, u32 nelems)
> + {
> +       int i = bpf_index_find(&w->index, (unsigned long)t);
> +       struct btf_field_scope *s;
> +
> +       if (i >= 0) {
> +               s = &w->scopes[i];
> +               return btf_repeat_fields(w, s->first, s->cnt, off - s->off, nelems, t->size,
> +                                        nelems > 1);
> +       }
> +       i = w->index.cnt;
> +       s = bpf_table_next(w->scopes, i);
> +       if (!s || bpf_index_add(&w->index, (unsigned long)t, i))
> +               return -ENOMEM;
> +       *s = (struct btf_field_scope){
> +               .t = t, .off = off, .nelems = nelems, .first = w->cnt, .parent = w->scope,
> +       };
> +       w->scope = i;
> +       return 0;
>   }
>
>   static int btf_find_field_one(const struct btf *btf,
>                               const struct btf_type *var,
>                               const struct btf_type *var_type,
>                               int var_idx,
> -                             u32 off, u32 expected_size,
> -                             u32 field_mask, u32 *seen_mask,
> -                             struct btf_field_info *info, int info_cnt,
> -                             u32 level)
> +                             u32 base, u32 off, u32 expected_size,
> +                             struct btf_field_walk *w)
>   {
>         int ret, align, sz, field_type;
> -       struct btf_field_info tmp;
>         const struct btf_array *array;
> +       struct btf_field_info info;
>         u32 i, nelems = 1;
>
>         /* Walk into array types to find the element type and the number of
> @@@ -3889,15 -3930,13 +3930,13 @@@
>                 return 0;
>
>         field_type = btf_get_field_type(btf, var_type,
> -                                       field_mask, seen_mask, &align, &sz);
> +                                       w->field_mask, &w->seen_mask, &align, &sz);
>         /* Look into variables of struct types */
>         if (!field_type && __btf_type_is_struct(var_type)) {
>                 sz = var_type->size;
>                 if (expected_size && expected_size != sz * nelems)
>                         return 0;
> -               ret = btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
> -                                            &info[0], info_cnt, level, seen_mask);
> -               return ret;
> +               return btf_enter_struct(w, var_type, base + off, nelems);
>         }
>
>         if (field_type == 0)
> @@@ -3909,6 -3948,7 +3948,7 @@@
>                 return 0;
>         if (off % align)
>                 return 0;
> +       off += base;
>
>         switch (field_type) {
>         case BPF_SPIN_LOCK:
> @@@ -3920,8 -3960,7 +3960,7 @@@
>         case BPF_REFCOUNT:
>         case BPF_TASK_WORK:
>         case BPF_RCU_HEAD:
> -               ret = btf_find_struct(btf, var_type, off, sz, field_type,
> -                                     info_cnt ? &info[0] : &tmp);
> +               ret = btf_find_struct(btf, var_type, off, sz, field_type, &info);
>                 if (ret < 0)
>                         return ret;
>                 break;
> @@@ -3929,17 -3968,14 +3968,14 @@@
>         case BPF_KPTR_REF:
>         case BPF_KPTR_PERCPU:
>         case BPF_UPTR:
> -               ret = btf_find_kptr(btf, var_type, off, sz,
> -                                   info_cnt ? &info[0] : &tmp, field_mask);
> +               ret = btf_find_kptr(btf, var_type, off, sz, &info, w->field_mask);
>                 if (ret < 0)
>                         return ret;
>                 break;
>         case BPF_LIST_HEAD:
>         case BPF_RB_ROOT:
>                 ret = btf_find_graph_root(btf, var, var_type,
> -                                         var_idx, off, sz,
> -                                         info_cnt ? &info[0] : &tmp,
> -                                         field_type);
> +                                         var_idx, off, sz, &info, field_type);
>                 if (ret < 0)
>                         return ret;
>                 break;
> @@@ -3949,81 -3985,51 +3985,51 @@@
>
>         if (ret == BTF_FIELD_IGNORE)
>                 return 0;
> -       if (!info_cnt)
> -               return -E2BIG;
> -       if (nelems > 1) {
> -               ret = btf_repeat_fields(info, info_cnt, 1, nelems - 1, sz);
> -               if (ret < 0)
> -                       return ret;
> -       }
> -       return nelems;
> - }
> -
> - static int btf_find_struct_field(const struct btf *btf,
> -                                const struct btf_type *t, u32 field_mask,
> -                                struct btf_field_info *info, int info_cnt,
> -                                u32 level, u32 *seen_mask)
> - {
> -       int ret, idx = 0;
> -       const struct btf_member *member;
> -       u32 i, off;
> -
> -       for_each_member(i, t, member) {
> -               const struct btf_type *member_type = btf_type_by_id(btf,
> -                                                                   member->type);
> -
> -               off = __btf_member_bit_offset(t, member);
> -               if (off % 8)
> -                       /* valid C code cannot generate such BTF */
> -                       return -EINVAL;
> -               off /= 8;
> -
> -               ret = btf_find_field_one(btf, t, member_type, i,
> -                                        off, 0,
> -                                        field_mask, seen_mask,
> -                                        &info[idx], info_cnt - idx, level);
> -               if (ret < 0)
> -                       return ret;
> -               idx += ret;
> -       }
> -       return idx;
> - }
> -
> - static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
> -                               u32 field_mask, struct btf_field_info *info,
> -                               int info_cnt, u32 level, u32 *seen_mask)
> - {
> -       int ret, idx = 0;
> -       const struct btf_var_secinfo *vsi;
> -       u32 i, off;
> -
> -       for_each_vsi(i, t, vsi) {
> -               const struct btf_type *var = btf_type_by_id(btf, vsi->type);
> -               const struct btf_type *var_type = btf_type_by_id(btf, var->type);
> -
> -               off = vsi->offset;
> -               ret = btf_find_field_one(btf, var, var_type, -1, off, vsi->size,
> -                                        field_mask, seen_mask,
> -                                        &info[idx], info_cnt - idx,
> -                                        level);
> -               if (ret < 0)
> -                       return ret;
> -               idx += ret;
> -       }
> -       return idx;
> +       return btf_add_field(w, info) ?:
> +              btf_repeat_fields(w, w->cnt - 1, 1, sz, nelems - 1, sz, true);
>   }
>
>   static int btf_find_field(const struct btf *btf, const struct btf_type *t,
> -                         u32 field_mask, struct btf_field_info *info,
> -                         int info_cnt)
> +                         struct btf_field_walk *w)
>   {
> -       u32 seen_mask = 0;
> +       const struct btf_var_secinfo *vsi;
> +       const struct btf_member *member;
> +       struct btf_field_scope *s;
> +       const struct btf_type *var;
> +       u32 i, off;
> +       int err;
>
> -       if (__btf_type_is_struct(t))
> -               return btf_find_struct_field(btf, t, field_mask, info, info_cnt, 0, &seen_mask);
> -       else if (btf_type_is_datasec(t))
> -               return btf_find_datasec_var(btf, t, field_mask, info, info_cnt, 0, &seen_mask);
> -       return -EINVAL;
> +       if (!__btf_type_is_struct(t) && !btf_type_is_datasec(t))
> +               return -EINVAL;
> +
> +       for (err = btf_enter_struct(w, t, 0, 1); !err;) {
> +               if (bpf_must_abort())
> +                       return -EINTR;
> +               s = &w->scopes[w->scope];
> +               i = s->next++;
> +               if (i == btf_type_vlen(s->t)) {
> +                       if (!w->scope)
> +                               break;
> +                       s->cnt = w->cnt - s->first;
> +                       w->scope = s->parent;
> +                       err = btf_repeat_fields(w, s->first, s->cnt, s->t->size, s->nelems - 1,
> +                                               s->t->size, true);
> +               } else if (btf_type_is_datasec(s->t)) {
> +                       vsi = btf_type_var_secinfo(s->t) + i;
> +                       var = btf_type_by_id(btf, vsi->type);
> +                       err = btf_find_field_one(btf, var, btf_type_by_id(btf, var->type), -1,
> +                                                0, vsi->offset, vsi->size, w);
> +               } else {
> +                       member = btf_type_member(s->t) + i;
> +                       off = __btf_member_bit_offset(s->t, member);
> +                       if (off % 8)
> +                               /* valid C code cannot generate such BTF */
> +                               return -EINVAL;
> +                       err = btf_find_field_one(btf, s->t, btf_type_by_id(btf, member->type), i,
> +                                                s->off, off / 8, 0, w);
> +               }
> +       }
> +       return err;
>   }
>
>   /* Callers have to ensure the life cycle of btf if it is program BTF */
> @@@ -4134,6 -4140,8 +4140,8 @@@ static int btf_parse_graph_root(const s
>          * verify its type.
>          */
>         for_each_member(i, t, member) {
> +               if (bpf_must_abort())
> +                       return -EINTR;
>                 if (strcmp(info->graph_root.node_name,
>                            __btf_name_by_offset(btf, member->name_off)))
>                         continue;
> @@@ -4175,37 -4183,29 +4183,29 @@@ static int btf_parse_rb_root(const stru
>                                             __alignof__(struct bpf_rb_node));
>   }
>
> - static int btf_field_cmp(const void *_a, const void *_b, const void *priv)
> - {
> -       const struct btf_field *a = (const struct btf_field *)_a;
> -       const struct btf_field *b = (const struct btf_field *)_b;
> -
> -       if (a->offset < b->offset)
> -               return -1;
> -       else if (a->offset > b->offset)
> -               return 1;
> -       return 0;
> - }
> -
>   struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
>                                     u32 field_mask, u32 value_size)
>   {
> -       struct btf_field_info info_arr[BTF_FIELDS_MAX];
> -       u32 next_off = 0, field_type_size;
> +       struct btf_field_info *info_arr __free(kvfree) = NULL;
> +       struct btf_field_walk w = { .field_mask = field_mask };
> +       u32 field_type_size;
>         struct btf_record *rec;
>         int ret, i, cnt;
>
> -       ret = btf_find_field(btf, t, field_mask, info_arr, ARRAY_SIZE(info_arr));
> +       ret = btf_find_field(btf, t, &w);
> +       kvfree(w.scopes);
> +       kvfree(w.index.slots);
> +       info_arr = w.info;
>         if (ret < 0)
>                 return ERR_PTR(ret);
> -       if (!ret)
> +       if (!w.cnt)
>                 return NULL;
>
> -       cnt = ret;
> +       cnt = w.cnt;
>         /* This needs to be kzalloc to zero out padding and unused fields, see
>          * comment in btf_record_equal.
>          */
> -       rec = kzalloc_flex(*rec, fields, cnt, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> +       rec = kvzalloc_flex(*rec, fields, cnt, BPF_VERIFIER_GFP);
>         if (!rec)
>                 return ERR_PTR(-ENOMEM);
>
> @@@ -4223,11 -4223,10 +4223,10 @@@
>                         ret = -EFAULT;
>                         goto end;
>                 }
> -               if (info_arr[i].off < next_off) {
> -                       ret = -EEXIST;
> +               if (bpf_must_abort()) {
> +                       ret = -EINTR;
>                         goto end;
>                 }
> -               next_off = info_arr[i].off + field_type_size;
>
>                 rec->field_mask |= info_arr[i].type;
>                 rec->fields[i].offset = info_arr[i].off;
> @@@ -4316,9 -4315,6 +4315,6 @@@
>                 goto end;
>         }
>
> -       sort_r(rec->fields, rec->cnt, sizeof(struct btf_field), btf_field_cmp,
> -              NULL, rec);
> -
>         return rec;
>   end:
>         btf_record_free(rec);
> @@@ -4624,7 -4620,7 +4620,7 @@@ static s32 btf_enum_check_meta(struct b
>
>         /* enum type either no name or a valid one */
>         if (t->name_off &&
> -           !btf_name_valid_identifier(env->btf, t->name_off)) {
> +           !btf_name_valid(env, t->name_off)) {
>                 btf_verifier_log_type(env, t, "Invalid name");
>                 return -EINVAL;
>         }
> @@@ -4640,7 -4636,7 +4636,7 @@@
>
>                 /* enum member must have a valid name */
>                 if (!enums[i].name_off ||
> -                   !btf_name_valid_identifier(btf, enums[i].name_off)) {
> +                   !btf_name_valid(env, enums[i].name_off)) {
>                         btf_verifier_log_type(env, t, "Invalid name");
>                         return -EINVAL;
>                 }
> @@@ -4732,7 -4728,7 +4728,7 @@@ static s32 btf_enum64_check_meta(struc
>
>         /* enum type either no name or a valid one */
>         if (t->name_off &&
> -           !btf_name_valid_identifier(env->btf, t->name_off)) {
> +           !btf_name_valid(env, t->name_off)) {
>                 btf_verifier_log_type(env, t, "Invalid name");
>                 return -EINVAL;
>         }
> @@@ -4748,7 -4744,7 +4744,7 @@@
>
>                 /* enum member must have a valid name */
>                 if (!enums[i].name_off ||
> -                   !btf_name_valid_identifier(btf, enums[i].name_off)) {
> +                   !btf_name_valid(env, enums[i].name_off)) {
>                         btf_verifier_log_type(env, t, "Invalid name");
>                         return -EINVAL;
>                 }
> @@@ -5038,7 -5034,7 +5034,7 @@@ static s32 btf_locsec_check_meta(struc
>         }
>
>         if (!t->name_off ||
> -           !btf_name_valid_section(env->btf, t->name_off)) {
> +           !btf_name_valid(env, t->name_off)) {
>                 btf_verifier_log_type(env, t, "Invalid name");
>                 return -EINVAL;
>         }
> @@@ -5230,7 -5226,7 +5226,7 @@@ static s32 btf_func_check_meta(struct b
>                                u32 meta_left)
>   {
>         if (!t->name_off ||
> -           !btf_name_valid_identifier(env->btf, t->name_off)) {
> +           !btf_name_valid(env, t->name_off)) {
>                 btf_verifier_log_type(env, t, "Invalid name");
>                 return -EINVAL;
>         }
> @@@ -5299,7 -5295,7 +5295,7 @@@ static s32 btf_var_check_meta(struct bt
>         }
>
>         if (!t->name_off ||
> -           !btf_name_valid_identifier(env->btf, t->name_off)) {
> +           !btf_name_valid(env, t->name_off)) {
>                 btf_verifier_log_type(env, t, "Invalid name");
>                 return -EINVAL;
>         }
> @@@ -5365,7 -5361,7 +5361,7 @@@ static s32 btf_datasec_check_meta(struc
>         }
>
>         if (!t->name_off ||
> -           !btf_name_valid_section(env->btf, t->name_off)) {
> +           !btf_name_valid(env, t->name_off)) {
>                 btf_verifier_log_type(env, t, "Invalid name");
>                 return -EINVAL;
>         }
> @@@ -5752,7 -5748,7 +5748,7 @@@ static int btf_func_proto_check(struct
>
>                 if (args[i].name_off &&
>                     (!btf_name_offset_valid(btf, args[i].name_off) ||
> -                    !btf_name_valid_identifier(btf, args[i].name_off))) {
> +                    !btf_name_valid(env, args[i].name_off))) {
>                         btf_verifier_log_type(env, t,
>                                               "Invalid arg#%u", i + 1);
>                         return -EINVAL;
> @@@ -5985,6 -5981,22 +5981,22 @@@ static int btf_check_all_types(struct b
>                 return err;
>
>         env->phase++;
> +       /*
> +        * Structs and arrays go first. A walk from a pointer stops at them and hides this loop:
> +        *   ptr -> typedef -> array -+
> +        *             ^--------------+
> +        */
> +       for (i = btf->base_btf ? 0 : 1; i < btf->nr_types; i++) {
> +               type_id = btf->start_id + i;
> +               t = btf_type_by_id(btf, type_id);
> +
> +               if ((btf_type_is_struct(t) || btf_type_is_array(t)) &&
> +                   !env_type_is_resolved(env, type_id)) {
> +                       err = btf_resolve(env, t, type_id);
> +                       if (err)
> +                               return err;
> +               }
> +       }
>         for (i = btf->base_btf ? 0 : 1; i < btf->nr_types; i++) {
>                 type_id = btf->start_id + i;
>                 t = btf_type_by_id(btf, type_id);
> @@@ -6035,6 -6047,7 +6047,7 @@@ static int btf_parse_str_sec(struct btf
>         const struct btf_header *hdr;
>         struct btf *btf = env->btf;
>         const char *start, *end;
> +       u32 i, len = 0;
>
>         hdr = &btf->hdr;
>         start = btf->nohdr_data + hdr->str_off;
> @@@ -6059,6 -6072,21 +6072,21 @@@
>                 return -EINVAL;
>         }
>
> +       /* many names can share one long string: look at each byte once */
> +       kvfree(env->names);
> +       env->names = kvcalloc(BITS_TO_LONGS(hdr->str_len), sizeof(long),
> +                             GFP_KERNEL | __GFP_NOWARN);
> +       if (!env->names)
> +               return -ENOMEM;
> +       for (i = hdr->str_len; i--;) {
> +               if (!start[i])
> +                       len = 0;
> +               else if (!isprint(start[i]))
> +                       len = BTF_MAX_NAME_LEN;
> +               else if (len++ < BTF_MAX_NAME_LEN)
> +                       __set_bit(i, env->names);
> +       }
> +
>         return 0;
>   }
>
> @@@ -6290,6 -6318,10 +6318,10 @@@ btf_parse_struct_metas(struct bpf_verif
>                         ret = -EINVAL;
>                         goto free_aof;
>                 }
> +               if (bpf_must_abort()) {
> +                       ret = -EINTR;
> +                       goto free_aof;
> +               }
>
>                 ret = btf_find_kptr(btf, t, 0, 0, &tmp, BPF_KPTR);
>                 if (ret != BTF_FIELD_FOUND)
> @@@ -6347,6 -6379,9 +6379,9 @@@
>                 record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
>                                                   BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT |
>                                                   BPF_KPTR, t->size);
> +               /* It cannot be allocated. A map has its own record. */
> +               if (record == ERR_PTR(-EFBIG))
> +                       continue;
>                 /* The record cannot be unset, treat it as an error if so */
>                 if (IS_ERR_OR_NULL(record)) {
>                         ret = PTR_ERR_OR_ZERO(record) ?: -EFAULT;
> @@@ -6473,7 -6508,7 +6508,7 @@@ static struct btf *btf_parse(const unio
>         if (err)
>                 goto errout;
>
> -       err = btf_parse_type_sec(env);
> +       err = btf_parse_type_sec(env) ?: btf_link_decl_tags(btf);
>         if (err)
>                 goto errout;
>
> @@@ -8091,20 -8126,11 +8126,11 @@@ int btf_struct_access(struct bpf_verifi
>                 if (!meta)
>                         break;
>                 rec = meta->record;
> -               for (i = 0; i < rec->cnt; i++) {
> -                       struct btf_field *field = &rec->fields[i];
> -                       u32 offset = field->offset;
> -                       /* An access at 'lo' or above ends after the start of the field. */
> -                       s64 lo = max(min_off, (s64)offset - size + 1);
> -
> -                       /* Round up to min_off + k * step. The step is never 0. */
> -                       lo += imod(min_off - lo, reg->step);
> -                       if (lo <= max_off && lo < offset + field->size) {
> -                               bpf_log(log,
> -                                       "direct access to %s is disallowed\n",
> -                                       btf_field_type_name(field->type));
> -                               return -EACCES;
> -                       }
> +               i = btf_record_first_field(rec, off);
> +               if (i < rec->cnt && rec->fields[i].offset < off + size) {
> +                       bpf_log(log, "direct access to %s is disallowed\n",
> +                               btf_field_type_name(rec->fields[i].type));
> +                       return -EACCES;
>                 }
>                 break;
>         }
> @@@ -8636,8 -8662,8 +8662,8 @@@ static int btf_scan_decl_tags(struct bp
>                               const struct btf_type *fn_t,
>                               u32 arg_idx, bool is_global, u32 *tags)
>   {
> -       int id = btf_named_start_id(btf, false) - 1;
>         const char tag_key[] = "arg:";
> +       int id = 0;
>         static const struct {
>                 const char *tag_value;
>                 enum btf_arg_tag arg_tag;
> @@@ -8747,8 -8773,7 +8773,7 @@@ static int btf_validate_return_type(str
>   }
>
>   static int btf_check_arg_slots(struct bpf_verifier_log *log, const char *tname,
> -                              bool is_global, u32 slot_cnt,
> -                              struct bpf_subprog_info *sub)
> +                              bool is_global, u32 slot_cnt)
>   {
>         if (slot_cnt <= MAX_BPF_FUNC_REG_ARGS)
>                 return 0;
> @@@ -8760,12 -8785,7 +8785,7 @@@
>                         tname, slot_cnt, MAX_BPF_FUNC_REG_ARGS);
>                 return -EINVAL;
>         }
> -       if (!bpf_jit_supports_stack_args()) {
> -               bpf_log(log, "JIT does not support function %s() with %d argument slots\n",
> -                       tname, slot_cnt);
> -               return -EFAULT;
> -       }
> -       sub->stack_arg_cnt = slot_cnt - MAX_BPF_FUNC_REG_ARGS;
> +       /* The code of a static function tells which stack arguments it takes */
>         return 0;
>   }
>
> @@@ -8832,13 -8852,15 +8852,15 @@@ int btf_prepare_func_args(struct bpf_ve
>         }
>         args = (const struct btf_param *)(t + 1);
>         nargs = btf_type_vlen(t);
> -       sub->arg_slot_cnt = nargs;
> +       sub->arg_slot_cnt = min_t(u32, nargs, MAX_BPF_FUNC_ARGS);
>         if (nargs > MAX_BPF_FUNC_ARGS) {
> +               if (!is_global) /* not fatal for static funcs */
> +                       return -EINVAL;
>                 bpf_log(log, "kernel supports at most %d parameters, function %s has %d\n",
>                         MAX_BPF_FUNC_ARGS, tname, nargs);
>                 return -EFAULT;
>         }
> -       err = btf_check_arg_slots(log, tname, is_global, nargs, sub);
> +       err = btf_check_arg_slots(log, tname, is_global, nargs);
>         if (err)
>                 return err;
>
> @@@ -9027,7 -9049,7 +9049,7 @@@ skip_pointer
>                 return -EINVAL;
>         }
>
> -       err = btf_check_arg_slots(log, tname, is_global, slots_used, sub);
> +       err = btf_check_arg_slots(log, tname, is_global, slots_used);
>         if (err)
>                 return err;
>         sub->arg_slot_cnt = slots_used;

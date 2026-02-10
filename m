Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604BB2DECA8
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770706488; cv=pass; b=mf7heuZPJodf/ZlnWxAUycY10PkKeJUrB2ltEXgBhamgV2xuQYLi5QRhiyo3dZ+PChz/pGYRZpu2sFem9rEw6gELAMDHGB7yW70RMUXzQONouQ1xvE+UnKmVhZUsK71e2rLFy2nq6kiEqHbkelF2Gy46PSZxXpe8eDTY8Zgv0Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770706488; c=relaxed/simple;
	bh=cShi6S+64Ne2xKqEBDuW7M2DlXD+bHijhk4bVUcXVFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkbZ7KX/x/jOrfNzjRWAtCNpjbhZdoSFlvNeptQ5m8l+f6NXF/PQhv7UtJzhFLKg9rzduPMNEJ07SaIdGTbCKN/oW7Z2UTWQHB1dz3wN/8eLMU80AYCjj+swkCy8ZyCDxyC1+n3yZXDIBWYWlPlYQ1k59AzaMz9ircMNld5atiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPJn36jI; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPJn36jI"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso2421155ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 22:54:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770706487; cv=none;
        d=google.com; s=arc-20240605;
        b=O1+7evAZRqaPemQW7WASxgeHmE0FpLSQQQWv6bnCTmLpVBTmIz7APbP9vaw6GaTARm
         5bXll6KIJr6QnKauZVc9OMIQxcj9kSUXQbqgvWrDFAQDaokpaSx4frINikDowa6X/PZG
         YTABz0Hr/+6/8OL718w2QT/xPdJAj3mlDkQfZXTq3uK8v7QezvnUgp2yajHdCGG6Vs76
         nojTRqH5xrdctA3ri/kaAEgalC/w9t6x9yybvfjNwimrbC8lvH6+i0ND+sU+JWE10TnF
         tyx1OrqE/YfMOHYJyE6qJxQEIFuSyZx4laArJagNO+D39S8YNv4jn/8pZL7eeBIXff4e
         8/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q/oRnvZp9zxGQuEHklbxnoTFI0h43dGFyuX7iJvD5jo=;
        fh=TCTIBws018cdvbzFnR9DP/oHdDTIeWJgn/HK86y3L8c=;
        b=ISeWeRF8JYroFJLcY8xFgqke8pMkHRB/3rljrmXjDRfWF+nQbU9lRGxTWz8hogmr7Z
         UsRy1w1zXvLupAd8hVTXqFfOQBu2VJPOMo435y/QdAIB6DjG8IvIXr6KZEvxSANmZdj2
         uUVuMrvFsUNsUVyjGY4jvZ5mQ5jfell2Hg7Ljlr7V5YTgEeBMPRDDDjIpY+MfPCMlpSB
         n7RoGfffrTesjpsCVYp7y+fGT9VHcOmgA9NVHEWGEb1BHIlq5PERTWe/UIZLIO1sp5Fw
         hKeElxpGAr/wR1Ol6ai7RxN8ufAdBWFG9ORQSLAw4TE3Sd7RGBB2j3kbqWWnuM7F7IDf
         rd0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770706487; x=1771311287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/oRnvZp9zxGQuEHklbxnoTFI0h43dGFyuX7iJvD5jo=;
        b=bPJn36jI2RK7mU46tLLUZGVu3MyO0oRMhXVIxZPt+Z3CEdPPc8/XL7aAlf7dJPt57t
         htI/FCM5Vu9irf2Xub3299lk4KfyhPumfaeEvbHv9OPVEZUwXH0Icr+ioq6TUKB0KLpK
         XDOhTot75KA+BPGW4okNKtjIVG4sAokr8CW26wcr1O8VTOWg2U9yux2VPnzn2UvgPzeX
         PwsppotKzpTdbA0zCjGuyicTppChysDWjHIhRiqj0y4C1E/UPH9LRKBWCjHY3bY+hajI
         9P0espGQnooCQvSOmeYKLsJtsKs/55V00wNYpwtJAdTJKDN1Wog7Z0sBUw3r7bhUQfNk
         Imdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770706487; x=1771311287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q/oRnvZp9zxGQuEHklbxnoTFI0h43dGFyuX7iJvD5jo=;
        b=YxIv1ZGFAkgy8RYnfqLCCvbe9zeKaKG1FBe/T6p3TJdITLdqW14LMBvpviFpEKe/88
         lgoA5CUCQnPcnqrA8+2jpR6v7hkX859tymV4KcQawnj3aSyyPjN+2bCIP9xAqgfI+Flv
         wRtPcv0d3SuTDdgJJpQiewYyaKfMjNXmMsbOr3OL10H+6fkMJXYd4eZEbUU8gSSdetw4
         adZKew/41zaMPOeYGon6qfxPtGxZDMGXtvAYC4tahHXoPrG1MXJoY0pveFwphRIhiP0Q
         wkVqNejVemdHhvgkEIJ51MULgKuQapx85bHLlizNE0Rt03spDjuAQb/EInCpMNeRilEF
         fAYg==
X-Gm-Message-State: AOJu0YwCzyM07Dl8HF7bpQ5NrUqtF9m/petyJe4Is0YmgkyMgjxJKhEB
	if0JPshBWMZmDpI7iAS7GAwTd0selQ8lnwjI2PEGU1ZkEezppw1bu93ypwe6kXa0QoECDqfzh0V
	9n69dDvyE/LKKguJCbvGxnUK3qytnFVU=
X-Gm-Gg: AZuq6aLaULFDewPCfaeM2I25yk8kf9H8CxMZmpfXYSwP2W3ZrxCPbN3Fq2TcbRu3aIf
	VNkQQaL68OW5DK/GjjoOPCmWC/F5KQ9ylS+WBGhh0VL++s3RzkdbBTAOZ5ThztAx1fJcF/QkM+q
	jEpa9PCc2AESmQ8g1wjzXJyN6YIa/1R8wxagy9e7Tr/beb0jgzEXLXGDflKB0R/2oyxBYx9HgZF
	kIPEIIzahsSpvfqdcm4hyuE+ueYHnOa7GKcO8HgVrWKdHzmYxi5sRhXm4lc/j3VHLze7bVSW2Es
	tByhqjetW57jR0iX4KqyS/E=
X-Received: by 2002:a17:903:3c68:b0:2a3:c667:e0a0 with SMTP id
 d9443c01a7336-2a9516d5821mr124582285ad.29.1770706486494; Mon, 09 Feb 2026
 22:54:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210005508.3642641-1-emil@etsalapatis.com>
In-Reply-To: <20260210005508.3642641-1-emil@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Feb 2026 22:54:34 -0800
X-Gm-Features: AZwV_QiI02ooSrZEHm2FqvENU7njB7PPwTWIz4j0B7F84XnfnS4apC9mG7owwUs
Message-ID: <CAEf4BzaLqWT1oj-EXibyAfE0ExmiaCCqhosRujDi7Y0Nyho6dA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: Add gating for arena globals
 relocation feature
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@kernel.org, 
	memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 4:55=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Add feature gating for the arena globals relocation introduced in
> commit c1f61171d44b. The commit depends on a previous commit in the
> same patchset that is absent from older kernels (12a1fe6e12db,
> "bpf/verifier: Do not limit maximum direct offset into arena map").
> Without this commit, arena globals relocation with arenas >=3D 512MiB
> fails to load and breaks libbpf's backwards compatibility.
>
> Introduce a libbpf feature to check whether the running kernel includes
> patch 12a1fe6e12db, and only relocate arena globals if it does.
>
> CHANGELOG
> ---------
>
> v2 -> v3 (https://lore.kernel.org/bpf/20260209234850.2750149-1-emil@etsal=
apatis.com/)
>
> - Rename feature to better specify the verifier feature it probes for
>   (Andrii)
>
> v1 -> v2 (https://lore.kernel.org/bpf/20260209210240.2051209-1-emil@etsal=
apatis.com/)
>
> - Reworked test to use simpler array-based program (Andrii)
>
> Fixes: c1f61171d44b ("libbpf: Move arena globals to the end of the arena"=
)
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  tools/lib/bpf/features.c        | 92 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c          |  7 ++-
>  tools/lib/bpf/libbpf_internal.h |  2 +
>  3 files changed, 99 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b842b83e2480..034ea9b20617 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -506,6 +506,95 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>         return probe_fd(prog_fd);
>  }
>
> +static int probe_ldimm64_full_range_off(int token_fd)
> +{
> +       const size_t bufsz =3D 1024;

buf_sz, but really just

char log_buf[1024]; and use sizeof(log_buf) below

> +       int btf_fd, prog_fd, map;
> +       char log_buf[bufsz];
> +       int ret;
> +       static const char strs[] =3D "\0f\0";
> +       const __u32 types[] =3D {
> +               /* [1] FUNC_PROTO `void(void)` */
> +               BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 0), =
0),
> +               /* [2] FUNC 'f' -> FUNC_PROTO (main prog) */
> +               BTF_TYPE_ENC(1 /* "f" */, BTF_INFO_ENC(BTF_KIND_FUNC, 0, =
BTF_FUNC_GLOBAL), 1),
> +       };
> +       LIBBPF_OPTS(bpf_map_create_opts, map_opts,
> +               .token_fd =3D token_fd,
> +               .map_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
> +       );
> +       LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
> +               .token_fd =3D token_fd,
> +               .prog_flags =3D BPF_F_SLEEPABLE | (token_fd ? BPF_F_TOKEN=
_FD : 0),

 SLEEPABLE just for SYSCALL program? let's use TRACEPOINT and keep it simpl=
e

> +               .log_buf =3D log_buf,
> +               .log_size =3D bufsz,
> +       );
> +       struct bpf_insn insns[] =3D {
> +               BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1UL << 30),
> +               BPF_EXIT_INSN(),
> +       };
> +       const struct bpf_func_info_min func_infos[] =3D {
> +               { 0, 2 }, /* main prog -> FUNC 'f' */
> +       };

unnecesasry

> +       int insn_cnt =3D ARRAY_SIZE(insns);
> +
> +       btf_fd =3D libbpf__load_raw_btf((char *)types, sizeof(types), str=
s, sizeof(strs), token_fd);
> +       if (btf_fd < 0)
> +               return 0; /* BTF not supported at all */
> +

Do we need BTF at all? Have you tried this without it?

> +       map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr", sizeof(int), 1,=
 1, &map_opts);

nit: map_fd for consistency with prog_fd
> +       if (map < 0) {
> +               ret =3D -errno;
> +               pr_warn("Error in %s(): %s. Couldn't create simple array =
map.\n",
> +                       __func__, errstr(ret));
> +               close(btf_fd);
> +               return ret;
> +       }
> +       insns[0].imm =3D map;
> +
> +       prog_opts.prog_btf_fd =3D btf_fd;
> +       prog_opts.func_info =3D &func_infos;
> +       prog_opts.func_info_cnt =3D ARRAY_SIZE(func_infos);
> +       prog_opts.func_info_rec_size =3D sizeof(func_infos[0]);

unnecessary

> +
> +       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SYSCALL, "global_reloc", =
"GPL", insns, insn_cnt, &prog_opts);
> +

let's use TRACEPOINT as one of the most basic program types

also "global_reloc" as a name doesn't match, really

> +       ret =3D -errno;
> +       close(map);
> +       close(btf_fd);
> +
> +       if (prog_fd >=3D 0) {
> +               pr_warn("Error in %s(): Program loading unexpectedly succ=
eeded.\n",
> +                       __func__);
> +               close(prog_fd);
> +               return -EINVAL;
> +       }
> +
> +       /* Be conservative and NULL terminate the buffer to ensure strstr=
 terminates. */
> +       log_buf[bufsz - 1] =3D '\0';

let's not be conservative, trust the verifier :)

> +
> +       /*
> +        * Feature is allowed if we're not failing with the error message=
 "direct value
> +        * offset of %u is not allowed that was removed in 12a1fe6e12db

missing quote after "is not allowed", also try to keep commit hash +
subject on single line if possible (see my diff below, it looks pretty
straightforward to achieve that)

> +        * ("bpf/verifier: Do not limit maximum direct offset into arena =
map").
> +        * Instead, we should be failing with the message "invalid access=
 to map value
> +        * pointer". Ensure we match with one of the two and we're not fa=
iling with a
> +        * different, unexpected message.
> +        */
> +       if (strstr(log_buf, "direct value offset of"))
> +               return 0;
> +
> +       if (strstr(log_buf, "invalid access to map value pointer") =3D=3D=
 NULL) {

!strstr()

> +               pr_warn("Error in %s(): Program unexpectedly failed with =
message: %s.\n",
> +                       __func__, log_buf);
> +               return ret;
> +       }
> +
> +       /* Feature is on. */
> +

unnecessary comment

> +       return 1;
> +}
> +
>  typedef int (*feature_probe_fn)(int /* token_fd */);
>
>  static struct kern_feature_cache feature_cache;
> @@ -581,6 +670,9 @@ static struct kern_feature_desc {
>         [FEAT_BTF_QMARK_DATASEC] =3D {
>                 "BTF DATASEC names starting from '?'", probe_kern_btf_qma=
rk_datasec,
>         },
> +       [FEAT_LDIMM64_FULL_RANGE_OFF] =3D {
> +               "Full range LDIMM64 support", probe_ldimm64_full_range_of=
f,

this description is used in the middle of sentence, it should start
with lowercase (see other descriptions where the first word is not
some abbreviation like BTF).

> +       },
>  };
>
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..93e59ed8d9a1 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3009,8 +3009,11 @@ static int init_arena_map_data(struct bpf_object *=
obj, struct bpf_map *map,
>         memcpy(obj->arena_data, data, data_sz);
>         obj->arena_data_sz =3D data_sz;
>
> -       /* place globals at the end of the arena */
> -       obj->arena_data_off =3D mmap_sz - data_alloc_sz;
> +       /* place globals at the end of the arena (if supported) */
> +       if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
> +               obj->arena_data_off =3D mmap_sz - data_alloc_sz;
> +       else
> +               obj->arena_data_off =3D 0;
>
>         /* make bpf_map__init_value() work for ARENA maps */
>         map->mmaped =3D obj->arena_data;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index fc59b21b51b5..974147e8a8aa 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -392,6 +392,8 @@ enum kern_feature_id {
>         FEAT_ARG_CTX_TAG,
>         /* Kernel supports '?' at the front of datasec names */
>         FEAT_BTF_QMARK_DATASEC,
> +       /* Kernel supports LDIMM64 imm offsets past 512 MiB. */
> +       FEAT_LDIMM64_FULL_RANGE_OFF,
>         __FEAT_CNT,
>  };
>

So overall this patch gets the job done, but I think we should tighten
it up. I was curious why you have so much ceremony, so applied your
patch locally and tried to strip everything I thought unnecessary
(plus reformatted that big comment to be a bit more greppable). Here's
what I got and it seems to do the job...

pw-bot: cr


diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 034ea9b20617..6e27aa618e70 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -508,90 +508,64 @@ static int probe_kern_arg_ctx_tag(int token_fd)

 static int probe_ldimm64_full_range_off(int token_fd)
 {
-       const size_t bufsz =3D 1024;
-       int btf_fd, prog_fd, map;
-       char log_buf[bufsz];
+       int prog_fd, map_fd;
+       char log_buf[1024];
        int ret;
-       static const char strs[] =3D "\0f\0";
-       const __u32 types[] =3D {
-               /* [1] FUNC_PROTO `void(void)` */
-               BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 0), 0)=
,
-               /* [2] FUNC 'f' -> FUNC_PROTO (main prog) */
-               BTF_TYPE_ENC(1 /* "f" */, BTF_INFO_ENC(BTF_KIND_FUNC,
0, BTF_FUNC_GLOBAL), 1),
-       };
        LIBBPF_OPTS(bpf_map_create_opts, map_opts,
                .token_fd =3D token_fd,
                .map_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
        );
        LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
                .token_fd =3D token_fd,
-               .prog_flags =3D BPF_F_SLEEPABLE | (token_fd ? BPF_F_TOKEN_F=
D : 0),
+               .prog_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
                .log_buf =3D log_buf,
-               .log_size =3D bufsz,
+               .log_size =3D sizeof(log_buf),
        );
        struct bpf_insn insns[] =3D {
                BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1UL << 30),
                BPF_EXIT_INSN(),
        };
-       const struct bpf_func_info_min func_infos[] =3D {
-               { 0, 2 }, /* main prog -> FUNC 'f' */
-       };
        int insn_cnt =3D ARRAY_SIZE(insns);

-       btf_fd =3D libbpf__load_raw_btf((char *)types, sizeof(types),
strs, sizeof(strs), token_fd);
-       if (btf_fd < 0)
-               return 0; /* BTF not supported at all */
-
-       map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr", sizeof(int),
1, 1, &map_opts);
-       if (map < 0) {
+       map_fd =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr",
sizeof(int), 1, 1, &map_opts);
+       if (map_fd < 0) {
                ret =3D -errno;
                pr_warn("Error in %s(): %s. Couldn't create simple
array map.\n",
                        __func__, errstr(ret));
-               close(btf_fd);
                return ret;
        }
-       insns[0].imm =3D map;
-
-       prog_opts.prog_btf_fd =3D btf_fd;
-       prog_opts.func_info =3D &func_infos;
-       prog_opts.func_info_cnt =3D ARRAY_SIZE(func_infos);
-       prog_opts.func_info_rec_size =3D sizeof(func_infos[0]);
-
-       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SYSCALL, "global_reloc",
"GPL", insns, insn_cnt, &prog_opts);
+       insns[0].imm =3D map_fd;

+       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, "ldimm64_off", =
"GPL",
+                               insns, insn_cnt, &prog_opts);
        ret =3D -errno;
-       close(map);
-       close(btf_fd);
+       close(map_fd);

        if (prog_fd >=3D 0) {
-               pr_warn("Error in %s(): Program loading unexpectedly
succeeded.\n",
-                       __func__);
+               pr_warn("Error in %s(): Program loading unexpectedly
succeeded.\n", __func__);
                close(prog_fd);
                return -EINVAL;
        }

-       /* Be conservative and NULL terminate the buffer to ensure
strstr terminates. */
-       log_buf[bufsz - 1] =3D '\0';

        /*
-        * Feature is allowed if we're not failing with the error
message "direct value
-        * offset of %u is not allowed that was removed in 12a1fe6e12db
-        * ("bpf/verifier: Do not limit maximum direct offset into arena ma=
p").
-        * Instead, we should be failing with the message "invalid
access to map value
-        * pointer". Ensure we match with one of the two and we're not
failing with a
+        * Feature is allowed if we're not failing with the error message
+        * "direct value offset of %u is not allowed" that was removed in
+        * 12a1fe6e12db ("bpf/verifier: Do not limit maximum direct
offset into arena map").
+        * Instead, we should be failing with the message "invalid
access to map value pointer".
+        * Ensure we match with one of the two and we're not failing with a
         * different, unexpected message.
         */
        if (strstr(log_buf, "direct value offset of"))
                return 0;

-       if (strstr(log_buf, "invalid access to map value pointer") =3D=3D N=
ULL) {
+       if (!strstr(log_buf, "invalid access to map value pointer")) {
                pr_warn("Error in %s(): Program unexpectedly failed
with message: %s.\n",
                        __func__, log_buf);
                return ret;
        }

-       /* Feature is on. */
-
        return 1;
 }

> --
> 2.49.0
>

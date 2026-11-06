Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793925298;
	b=rXBBzrsMvqs7YIiG92A7Qah45k06QjF5M2YatmT19z3LN5XLh6o3oLayjbm8Fp5fV1Ly
	 ujnO/rP09YT5JpBr/pOaVkngOSSwGuDxADdmwBJm8fJjwOnF2XqnJtzT+PDeqLt2ucDWJ
	 qGwIbL/YLFHmuHokik4g8/4ovFs8clFABC9HMaC8QQYq50DPlyQvl+c2pqGeiY7w59Nzd
	 RqfUb0adBzLCas8quyx+CeILfUaw+UOxvEzpjyR26LldeyUhwRhpcO1pHQDcbel9WjZ2h
	 +JZSuHyr8GTaAUDO6+Lhz3hS8Xb2qhZ2LNbuy4kZumndV4cx1UnCwiG80njV5ytRj5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=joC/8wv7Bo/QMhqz+nVODUPJosO+ewZ7/h6kL5DRILE=;
	b=HclJVjmdlJTYNFNlNEqjiRje4R+YpdZGgyjIfma3ORXzQPGZMW/Ipmu2szoVJaZRWJnH
	 WCOmLbU2DvJ6/ffmhyExhSMcrVVukIgrCi/dKBhzRXAYQ2w/SN4A6v0ni30eyjLfMHnYn
	 E7l1+jT3RZyghfLnROs0Hvh4XqykL5i2w8wcrM/pOSV7TDsZscG9CRM+Qedj6sOmlvSWh
	 aI29SkRpRpw1RSbZRBV4YxdqiVcHFRalNLUjs+I7dRYcd3wyVqnDAqPwRuxw7oEhSE3Yy
	 tsm6nMrh9kqkWhxS5VaVUUrpFK6X7BhkOq1Lpw7AUcriHkfyirInqRR5YbYm4+9uZnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rZQriM4h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE8606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 00:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62FE8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rZQriM4h
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed06b725fdso7352175ad.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 16:34:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793925298; cv=none;
        d=google.com; s=arc-20260327;
        b=rn9pPSgqjZlH37Vyv3TDaLOBYpzPgcTRZVQ9wQtq/BAS1PpYCMmpiLdOfE+roIlWjg
         Iu1b+t4lMDnV4+S7r1fK7Rmepa6jFXQkLQ0gCnlX/Qhtt8FMaznTMBLdW3k4R+9Fh3bL
         cwv8zGJtuZQMnHecxZJMOypFsqw+xTkrer6jPChgnp+J0EqXFFcNB6BgKVMFYwfW/CSw
         n3AT7TNyLEc5pJyuGicrqYKlZTrqd4uhs03WpwJHFqWaP8d2Dl1EoiLscAOYDnEbKsip
         tQzuZbLzQ6I2Ull4Vb2iCrADclzt0L3uVhWycYjonlThSx39Yhba3Tjq+TR0c8q0woI+
         byyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=joC/8wv7Bo/QMhqz+nVODUPJosO+ewZ7/h6kL5DRILE=;
        fh=WVSyKFRruosN1mevD+lDt8kE8as4sWkZnQPJI9Ayo50=;
        b=XGAcWAP5FizrdAR0Cw7Ap3Gq4b7XLrJb6wctbeBE/V+6Tihso4XOEUvS3C+GA7sPim
         hvCibYGhYm0diXVxsEbDdQ6YSRnj5h0Y1lk4SMlWK0+ElohYEiif37XzNUvspUH71tHD
         Rs+a7Eh0WSAcFMul3rIWs2bundWX1OUgtXrmN0RW9kWpLJQRshPQKeZzoetBE+EFr/7u
         d1j/zJTYRVjPt9QUyY1eux+Z8B0nTUhjE4osLDxD4AZqzLmPzHhZsxCAd/ViB0Lo1gkF
         rbZ4ootgUwGyUGsa6t1M3kGGY+BoT0ROfbMuwawOedR2abnORD42vsRTLX2iG7a71ZsZ
         rEug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793925298; x=1794530098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=joC/8wv7Bo/QMhqz+nVODUPJosO+ewZ7/h6kL5DRILE=;
        b=rZQriM4hrjrWZWsvSIEFDuhoAx1jB0X3BkZN4vpqTZ2v8huvMKr4Q9YUnG6KNCa4eN
         j5TwjCtz8J4qJYaWUrYPBc8sqm6D2daDvv/2X8Do0u3o6Kij1EOaa2MAGkoDkWEfY7gm
         9psIzEWNe2mgfH8l5GZgZ+XRt2wWrgrNKMoHQ5jl1ccfxeFYQ5D1CZFeljQhNskx4/K3
         dW9vmx/c3+R8kjhgabCMdokopchoiXspVuQWVn9HwzG5dlyq53ucgAb/JIjDOAjPrHNy
         hZwnyxngqb3Cy7dzorRVEBWIEtqqEwb9IspRk2jtEmfc0+hPfAULN/Gz9jdRDBOxR4aN
         09hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925298; x=1794530098;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=joC/8wv7Bo/QMhqz+nVODUPJosO+ewZ7/h6kL5DRILE=;
        b=OmTQ7gFDZ06ESmUVSe7U5Wiwpra49Fs4cTYG57jmyYSbcJqBhDXgKWVJcZE80WJWrP
         yDWPV9KLg5SsUieH4VLre3HoBiFJ1MWG9Jq6ucB6ZTsG3mSaO8HyBvCZLxKeA1WzMHtL
         d3h7JKjbi8maJYfVQyGTnIze+Eo4ycDvSjN42RCmQ3iPW7P/Zb8DqinLve4uqOIDrAId
         tdUPwwfv2jxCNMfd9UOppe3zDdLL6E9MKT1/MD1kDimYeZsGE761cwP59JLsO9s9/oTL
         UORTZcZw5RTYeW5B1ioJH52ATwVe6gelTbL7ixXJEFU+Yp4OYKBu4VoSXDayNqIYHllH
         EtDw==
X-Forwarded-Encrypted: i=1; AKwUvBxNRryLg6TZSeG+4C8KduhtYfmwk/ZgI5l2M9nKZstPeyRnOmCpGOOwqRyZcfGmIZL1Weo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tfWHE1d1oQC47Dmu3g/cOCMb2wXoryk+0TdhBHJiYYpCvxBwr
	U/EPcoUfG/VUrlgRaHoTL36yk1VsMGQ8Pb/9DLkAxi7YNNzwOu6gSp0as6f5BQhJ0ZkUkGN4osz
	4j03lwko0YSAamimlAq4pvHWG+N4RFPk=
X-Gm-Gg: AYBFou1+DIP2pNPojarEK8dmBKpOTvYtkCiuJk3r6JpQ3FHRPIh9ovYqi9JIGk/ejCc
	WujggNaX5sq0/gNfTCsaKqGYx50oEBcUgsAfNWFZ+PsO7zUili4R+FAablUVuukOJaHQml6s5k6
	b2XUw0Fzy2Jyzn1uWci0t7sQKNWMRULozP3MPiDz4Uy9IhLQa/761Ok3SIUxAs4oPoz2hsHrV5V
	uuxuBMlhMYw3k7TFloxXBaDIhluCXwps8L6qppaWyqHYca3BMFupCEQGBOtMh8ib5+cB939qNPy
	CmSlr9SH2XPQmC3neCeGkRKixDK8dLLijy6W6sKeQ/n2ueAMBgud5oz98NPsf19lQurcyzoHGOa
	M15ZL8OWtArWKh1F/43xmbeadZYKzLjWRE5bytZiUhZd+hfkLVR7SzIsqajqRNo56ZOClYw0Tm9
	p2wk4VR9ytC+yS0Z6vKPGPtGH22uuhJlGCjw==
X-Received: by 2002:a17:903:178e:b0:2e9:95b9:4bcb with SMTP id
 d9443c01a7336-2ed40a99a24mr10149265ad.14.1793925297652; Thu, 05 Nov 2026
 16:34:57 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105102343.311331-1-jolsa@kernel.org> <20261105102343.311331-2-jolsa@kernel.org>
In-Reply-To: <20261105102343.311331-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 16:34:44 -0800
X-Gm-Features: AclHuK9eYiok-N8ZQyQvOspr_LkgO-f8_ZJjrPwcoXmwuKUXqTqkf1TIAoFchbs
Message-ID: <CAEf4BzbdBLb1cBeF0an386k=CmMYKdz=Or5mSjzy_F5SFOwsxg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 1/8] bpf: Honor const on generic kfunc memory arguments
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Federico Di Pierro <nierro92@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 2:23=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Mark generic kfunc memory arguments as read-only when their BTF pointer
> type points to const data. Preserve that access mode when resolving
> scalar structs to fixed-size memory.
>
> Derive the memory access flag from the pointer's BTF type, and preserve i=
t
> when resolving scalar structs to fixed-size memory. Document that const
> memory arguments require read access only.
>
> Assisted-by: Codex:GPT-6
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  Documentation/bpf/kfuncs.rst |  4 ++++
>  kernel/bpf/verifier.c        | 24 +++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 901c37504217..4f8dd7c1d785 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -137,6 +137,10 @@ argument as its size. By default, without __sz annot=
ation, the size of the type
>  of the pointer is used. Without __sz annotation, a kfunc cannot accept a=
 void
>  pointer.
>
> +The verifier checks such memory for read and write access. When the argu=
ment
> +is a pointer to const, like ``const void *mem``, the verifier checks it =
for
> +read access only, and read-only memory (e.g. ``.rodata``) can be passed.
> +
>  2.3.2 __k Annotation
>  --------------------
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c93437f8db0..8f885d3acaa9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13237,6 +13237,22 @@ static bool is_kfunc_arg_const_mem_size(const st=
ruct btf *btf,
>         return btf_param_match_suffix(btf, arg, "__szk");
>  }
>
> +/* A kfunc only reads through 'const T *arg'. The compiler enforces it. =
*/
> +static enum bpf_type_flag kfunc_arg_mem_flag(const struct btf *btf,
> +                                            const struct btf_param *arg)
> +{
> +       const struct btf_type *t =3D btf_type_skip_modifiers(btf, arg->ty=
pe, NULL);
> +       u32 id, ref_id;
> +
> +       btf_type_skip_modifiers(btf, t->type, &ref_id);
> +       for (id =3D t->type; id !=3D ref_id; id =3D t->type) {
> +               t =3D btf_type_by_id(btf, id);
> +               if (btf_kind(t) =3D=3D BTF_KIND_CONST)
> +                       return MEM_RDONLY;
> +       }

quite weird implementation, skip modifier, and then re-walk
modifiers... while not have a loop from t->type while
btf_type_is_modifier() and if you find btf_kind(t) =3D=3D BTF_KIND_CONST
-> return true?


> +       return MEM_WRITE;
> +}
> +
>  static bool is_kfunc_arg_constant(const struct btf *btf, const struct bt=
f_param *arg)
>  {
>         return btf_param_match_suffix(btf, arg, "__k");
> @@ -13618,7 +13634,8 @@ static int resolve_func_arg_type(struct bpf_verif=
ier_env *env,
>                         PTR_ERR(resolve_ret));
>                 return -EINVAL;
>         }
> -       *arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
> +       *arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
> +                   kfunc_arg_mem_flag(meta->btf, &args[arg]) |
>                     (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
>
>         return 0;
> @@ -14170,7 +14187,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, =
struct bpf_call_arg_meta *meta,
>                                 reg_arg_name(env, argno), btf_type_str(re=
f_t), ref_tname);
>                         return -EINVAL;
>                 }
> -               arg_type =3D ARG_PTR_TO_MEM | MEM_WRITE;
> +               arg_type =3D ARG_PTR_TO_MEM | kfunc_arg_mem_flag(meta->bt=
f, &args[arg]);
>         } else if (btf_type_is_struct(ref_t))
>                 /* A pointer to a struct without a size argument is class=
ified as ARG_PTR_TO_BTF_ID */
>                 arg_type =3D ARG_PTR_TO_BTF_ID;
> @@ -14195,7 +14212,8 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, =
struct bpf_call_arg_meta *meta,
>                         return -EINVAL;
>                 }
>                 proto->arg_size[arg] =3D type_size;
> -               arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE;
> +               arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
> +                          kfunc_arg_mem_flag(meta->btf, &args[arg]);
>         }
>
>         if (is_kfunc_arg_uninit(meta->btf, &args[arg]))
> --
> 2.43.0
>

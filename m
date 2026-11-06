Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994718;
	b=STIM6SI679YB6zyGmD7A8N3U3qKWYckG2qWmHQ3/z9yHariX3OijfKv69I0vLjOCMVSI
	 KVn2Nf1pvB+6OpOaAFNGU8SI9H6xgmyj+0g1/zQLXafXW+woU2sYzPaWr/gyKNY8IoeAc
	 GjV03D0yEzyHH/IEaRX6AelCkK5ZSr3a9uoEfOMfZ0iQAF1zYH0ksXB3GYhvlAltwK6ky
	 8RmITrYHAnszEKYjVQk5KdRh35nooILbMgKIGFE5XcxGmc1LxiRyoOMaIOIpWNuDuZdns
	 zUsM0djyZWUbxMK6NR2a6wqJvae2vJtqYk6jX/csMahx8yPC+UPqeVWGJl0kQTjuHVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DjNVWR97LjF/tV9YPAfdBbtgPlmR3ehf5bmKolaVmy0=;
	b=3JbvX29uZ7SL4gtsjUnAgxDJNucWV7CXZqfITzBUFkqSKz7KMNydj6AjisH5ISkyv4kD
	 gsEzEta5WuTHdf3/cMc+UXaIHcF9TI80BRA4HFgY3w1PjRgMd973nYBd8SyUOqAJIeg6S
	 Hy6qdtTf7nno2CL9mm7EBqYYQYzW5rCxsRheDfUThJ63+vauqPCbVwyScYqzsGxprrkah
	 A1tqKHDhQuhbx6H4A27QXpNWX90Q9m9bAel4yp51/1ip11ygbTNOIRffPUmd7ZW2C+UId
	 FjqcPAY2ZCut7HqK/uEcsArr6Cl9qWIldSwAlp7dxvP++sprnsqTbjAaiqpQG/nssVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z8YjoqGE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991D606A332
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 19:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2991D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z8YjoqGE
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ed08b07213so4168995ad.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 11:51:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994717; cv=none;
        d=google.com; s=arc-20260327;
        b=XL90VYI0Do6xOa3MobTJwePunAZSJd/AcrZ92s8i12U7xdlq0hzenut2wZEY/9QARU
         NHHm+KdV0JII58NMnTY6KTPCHBNe5O11FZSdL8ggDaK2wDOtM7Xln7B8WXqMo+zi2s9E
         8+p/5qIY+fT1tUSMhhjzpBL3DxZsdb8B57fXlFHLKB8XNiV7pHynfA7RPmux+rPypuWz
         etKJpTSP8vDVJUXiEwRVxlfhBRjzVy5aVSPPrKrSb8TvtDR0uLSGw0q+CpLiI3ga5mEJ
         AL+rxXCnRS+4838ppjgqMPkzg/PKiP6ze53I0SBWK2ZrWMCg3RlOtEl6ON8QqqhGg30r
         Uv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DjNVWR97LjF/tV9YPAfdBbtgPlmR3ehf5bmKolaVmy0=;
        fh=TPQugRyjFGWekIC7YRCvEwDswSzk/2DgkCuJzFeWW6w=;
        b=V73mxV1dLFn2KvJ39/Mi1rY2KqrvPUWEE+eb0uLf/izUs8SY3itrgohzGBcWXz9A5u
         8ZxTeYsrNtEjjsekLEPPt1Bydm9SaBdIjgMNSsa/1w6dMq8iBr6gYEvrrKoU9/9wZh8F
         1QgQ8iQWxa3dIOjmBgYxnG2SbBwcD2m7EHCNqshkkvwCpfJpkTSz+IBjf8Hhwqfi0xf4
         VZ874sqyZxwe/ecAhQWFqaoz5Ly8ogevtMIeBM1cZUp+JwCUtegOVEFCwVmDO7KQESCB
         l6JCCczCd89YERaLmkt3yg6OJjnEtOJ+cA6Ubsl4CRsbLB3OWJfQXHdJKDqz8qlICH70
         aZPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994717; x=1794599517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DjNVWR97LjF/tV9YPAfdBbtgPlmR3ehf5bmKolaVmy0=;
        b=z8YjoqGEgIUDAlZt3Vaeg2y+5DbnEccANsuUVA8aHkxqYnI343kQWvIU4rnYUh5PsK
         R7ARPAs5bbVEtzTfjz0deCrcesSpLRu5B3YupA2rLCIG9RqRUlXlcK3F69PrxySJKudq
         J7o7L+hmya/prsBGqo1XNXxCh6BriT5+OcU0764uZyIdVnOpNVG4m0J33K55AQrqP9A4
         IRDMZzvJ6A9MIBvi7K+6ASPqr6AxKJgX06Z50f7qkXkylTX+Sk5kiQp822KIXWCdXXMh
         RDePp5WF5QEKv0CPw8FNrbQsF6PnnF0Ilmv4tM1TKBJm9pyOnxWCt3p77ZlVhU9+Mn6F
         gGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994717; x=1794599517;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DjNVWR97LjF/tV9YPAfdBbtgPlmR3ehf5bmKolaVmy0=;
        b=zwBDXACeLSvnAkWKDAm8PWIztteWEdDGH+jk3Mtfm2cJkLYVTpDMGo2GsD9Phqi9CG
         1avfwxaXRbA2aqMulevwdxb8Rrf151fLMYkvwc9scBaxYJQvGaqHI6MxUYhqeZCgGduE
         gkvw5lzStd5GzX/JC11iuihqyc0lRsKrYtBaSA0xsDfvfFsPWJwcw+H7uLpTcEyqIopE
         mt5e1UUkniNPf/wHWnZu3MHIBi3KzihZ8qja58Jnb5m9drPYHBNFoKRlVGttyD5XWxYN
         o3XaJ+7+1m9hhqvH8WCzr6R9SXDXIi/D9wbl3XWIyawD3PpMJSpqK4LbexHgab2aAT+f
         3pmQ==
X-Forwarded-Encrypted: i=1; AL+hErEseavBnH0Q+y8fh6jT/j/TTPA+2BQsEul7R8zb8CZ96WAgaJIPlr/UPVSNni3cjCzmK1A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/t4EE5FUX2bzGxh7rf4KJ76zmo4ZMRaKE3Cl+aZGLqwUx2TYaj
	PrscwxfZ0WpkfZsy97PYm43EwFmftDBwgZ2Mttl+NTdusyJQdtVSHy1z+jzmmzZllAK/czqm0Oq
	Hv0OXmSXUOiWI09WcvQN1PthF5G9dNo4=
X-Gm-Gg: AYBFou02JcQEFEdc20CkJcyReGtLbY6+JdRaZmAN7dI0zdeETI078TM2/IV1QWHbnVP
	Brcb2nKk7qJarbtysY8thQoJzJYj+XHBobU7rJbDpUb5XIPpV9tAwUsftEyrMxr3B9gTL47v6w1
	nQ8fiwZAXPB799Nq9RPnkQlv2ScbquusOEfUdwYGVvqrScm0QFE5V/btoo1gMhe5/HUZ7KPIFQK
	PBDGA7NHXYe7sNKXFt0waceso+16cXjBnMNgS48p17T2fYgllhyuFDCJVvZwYsbV4c9vW4xoOyt
	0ALftDDITUHdh+YI7A520KpOyp0CJvDB8jVMv+5BvmkiFZR3jUHk/z9DoN/5KloiIDyrWxwRZ/F
	BNAVImwWHWpZIQHwg59F9id5I8MU1p8c4uCn48Uaam0rbHKCEW6tXSpMEYg0Yn2+t9ZZ6qJSjC4
	PtssrJWV4+2tAllmXHY8WWENWnECVJNkekB16Ld5A=
X-Received: by 2002:a17:903:19cc:b0:2ea:fb8b:258d with SMTP id
 d9443c01a7336-2ed404dd21emr46673395ad.6.1793994717399; Fri, 06 Nov 2026
 11:51:57 -0800 (PST)
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
 <CAEf4BzbdBLb1cBeF0an386k=CmMYKdz=Or5mSjzy_F5SFOwsxg@mail.gmail.com> <au3brpNZG2nANnha@krava>
In-Reply-To: <au3brpNZG2nANnha@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Nov 2026 11:51:45 -0800
X-Gm-Features: AclHuK_ptQ1JZ0aIAB-Tf1Sid3nwdJVHkGL304qYA1pDY1ULh37q1biQaKwvn0c
Message-ID: <CAEf4Bzbrwbg+oD+Tx=uVEdQkAB=hWxYrgyEFuON8cUWwjQ-Ojw@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 1/8] bpf: Honor const on generic kfunc memory arguments
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Federico Di Pierro <nierro92@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:52=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, Nov 05, 2026 at 04:34:44PM -0800, Andrii Nakryiko wrote:
>
> SNIP
>
> > > +/* A kfunc only reads through 'const T *arg'. The compiler enforces =
it. */
> > > +static enum bpf_type_flag kfunc_arg_mem_flag(const struct btf *btf,
> > > +                                            const struct btf_param *=
arg)
> > > +{
> > > +       const struct btf_type *t =3D btf_type_skip_modifiers(btf, arg=
->type, NULL);
> > > +       u32 id, ref_id;
> > > +
> > > +       btf_type_skip_modifiers(btf, t->type, &ref_id);
> > > +       for (id =3D t->type; id !=3D ref_id; id =3D t->type) {
> > > +               t =3D btf_type_by_id(btf, id);
> > > +               if (btf_kind(t) =3D=3D BTF_KIND_CONST)
> > > +                       return MEM_RDONLY;
> > > +       }
> >
> > quite weird implementation, skip modifier, and then re-walk
> > modifiers... while not have a loop from t->type while
> > btf_type_is_modifier() and if you find btf_kind(t) =3D=3D BTF_KIND_CONS=
T
> > -> return true?
>
> the intention was not to introduce another helper with modifier
> classification, the tradeoff is 2 loops [1]

there is btf_type_is_modifier() helper, you just need to drop it's
static qualifier. it's not so much about performance of extra loop,
it's just harder to follow what's going on. it would be more
straightforward to have a loop that goes over modifiers and check if
it has seen const. that's all. but up to you.

>
> jirka
>
>
> [1] https://lore.kernel.org/bpf/DMLRV3E28SC8.3FJZXLBLZI4DD@gmail.com/
>
> >
> >
> > > +       return MEM_WRITE;
> > > +}
> > > +
> > >  static bool is_kfunc_arg_constant(const struct btf *btf, const struc=
t btf_param *arg)
> > >  {
> > >         return btf_param_match_suffix(btf, arg, "__k");
> > > @@ -13618,7 +13634,8 @@ static int resolve_func_arg_type(struct bpf_v=
erifier_env *env,
> > >                         PTR_ERR(resolve_ret));
> > >                 return -EINVAL;
> > >         }
> > > -       *arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
> > > +       *arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
> > > +                   kfunc_arg_mem_flag(meta->btf, &args[arg]) |
> > >                     (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
> > >
> > >         return 0;
> > > @@ -14170,7 +14187,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *e=
nv, struct bpf_call_arg_meta *meta,
> > >                                 reg_arg_name(env, argno), btf_type_st=
r(ref_t), ref_tname);
> > >                         return -EINVAL;
> > >                 }
> > > -               arg_type =3D ARG_PTR_TO_MEM | MEM_WRITE;
> > > +               arg_type =3D ARG_PTR_TO_MEM | kfunc_arg_mem_flag(meta=
->btf, &args[arg]);
> > >         } else if (btf_type_is_struct(ref_t))
> > >                 /* A pointer to a struct without a size argument is c=
lassified as ARG_PTR_TO_BTF_ID */
> > >                 arg_type =3D ARG_PTR_TO_BTF_ID;
> > > @@ -14195,7 +14212,8 @@ get_kfunc_arg_type(struct bpf_verifier_env *e=
nv, struct bpf_call_arg_meta *meta,
> > >                         return -EINVAL;
> > >                 }
> > >                 proto->arg_size[arg] =3D type_size;
> > > -               arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WR=
ITE;
> > > +               arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
> > > +                          kfunc_arg_mem_flag(meta->btf, &args[arg]);
> > >         }
> > >
> > >         if (is_kfunc_arg_uninit(meta->btf, &args[arg]))
> > > --
> > > 2.43.0
> > >

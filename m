Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C107463B60
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160502; cv=pass; b=kBuLYF56f34N0kKzpcDNHW7ERDXdehs2NfzPXaM9kBlTNJTjdypII6ggQsxPsm7HCqvAgrGCLPYay/mDv/bKs+SZDqx4RgbLJIBUrRnqENrVqhvDEh30P/K4PPUu+SbYy02OvIyuCKsLEyvBc0MW3eDGvDHPbNLenxrkXvXhEUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160502; c=relaxed/simple;
	bh=ZnNCTQg42ONX2ZidYqMg3tCg29YmjwfQK6KtWU+ovcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5CWkEaJ3JGPJ/jk9yHwmtdEIn9OlQRADv75PBH+hcmngIakBPavK5oCaCedH6F/h9VZyq0FRf963ZkjXD0OARguwDp5oD7ZurRhH410c/m+MHVp36atqXx5xMyC2V2yAtvufkwWTwq43+MnJceipf5EUtrdparBdo45RnXHpiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYRHkzIo; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYRHkzIo"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7f48c750afcso1400016a34.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789160499; cv=none;
        d=google.com; s=arc-20260327;
        b=DWFv+BzcZR9+HgG5AOHMQn5qWsjW94qJXsIF0AwNmR7B0/t2zf0mN2nMlhIZ2N0y1o
         4lHbjiRYVCMkcTcgOjEKVIoxuG41V7whgWeOYdOjyFl4XWeTrg5uu2uHQZd1blY5HJho
         iNVZe0VFbIlV45KHgpMAn3OzwJ/1ggtS8SO49HCmk1WAD7qDz5bnTLUNMi1M9eaYCK9r
         rCSV6yjz4z8zgRHMByv7zzZZNSfooqmFWYmtBckw8YROwgU2iEmeOpQCYduRKDB1tyuG
         gbPXsGeLwwaYcnNmL2VxDgTWsDj6U+x+8QZD6FowgyKXCa4tZKyY3k3HJVP19Q55yEyE
         ZKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=peEQX8VEDQkCoCW2ZXlhNTZ6VuPwoZVoNHsmEy4L8oM=;
        fh=2MBOojPsOSARizhxuWgT5BqcaOh4dFXJJ9MmFSYnYEA=;
        b=XVfTat05UveFUgpMDOy+SNa1f0nKDKYxBwlZ1G/HWAiVwLiZkB3Ug8hN5zRo+ojWtL
         2f/5I/0vwbTNaYPT4KLXuzZLhtX9EM4onlw/SsLUCNLBWfdO4AGtnHZAzjJsMYCBexdQ
         lovIea3EG3xhLY5qTIas28g269IQe/NLFabWCbf0EuAmZaIS58CGTaBMbBsDDEJBiC53
         /EqgExZh9s27pgnRfkRm6MQ8JNID0XbYlN1YuHVQheIVX3n3wOSApMFzIhxHm77ASaDN
         2o1N/BdSl7NajuOiIPrOIoc+Jf1zl3eRpDhmtg8Qase3xk0rUhsdNxVjrby8ryw1mD4k
         Pbcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789160499; x=1789765299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=peEQX8VEDQkCoCW2ZXlhNTZ6VuPwoZVoNHsmEy4L8oM=;
        b=ZYRHkzIokDD8FbXvXOURnT7n40x3ioeVoMieBqRuJIYckbfD4fLZdXzEx2D7lQYrE2
         RH0zeLeu7a1gnEv8Q2ZH4DcoBfFUMMkIJMZHU4Ug58XbIsXXIm4ix1kCRPfK68HeXEQX
         4xzvXrxNU67SSD9B7ys6KlnVp71+EsY+ul6P+CVxSp41m+18u6CoVCgpL8ffCIVbpnqa
         m2q+dF7zqrYKNz9Q7C38Jva6EueJoV6lq2EDZdMlIT72X7FlIc6xDv6r1P+tvZzngT5I
         ZHSQxXSuQje6ZvokFDOJg3NA0r2McgtT3/eWVIFpaaQm8of9c2ZC7nW4rK+l9uwM3Mwy
         b4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789160499; x=1789765299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=peEQX8VEDQkCoCW2ZXlhNTZ6VuPwoZVoNHsmEy4L8oM=;
        b=sjFbO7xv4oMLY6u44IBqxaNJLGvd96tQeEb6UtyO5LbAb23b5qsd5u+yj9Pcg+EYGd
         TSIfcyRTJ4dIg1tp+qRLvN3DV4g2HbK73uhOjbgvQbtK1RzNTFLCZ284g684uaa1oHs+
         T5O3W6M12VOtoaFCQNSZvz8wScldAw3eSOqcNYer/na0mRwYqg8Psipd9bAaVzH1cFNC
         LQzSs620GW+RgKJBe192qDmQJZH4PZE7zQR6SWOsQ3gjd+LYJZw3fXKLvmXvoeUeTrlw
         SpiqvfBbWiQ7WBUkuj8SoX7GgnfGbaFzaNa0y+4HWMwTY6brnz2NlesXzF3XSptDhNNe
         VPhQ==
X-Gm-Message-State: AFuF++nZheR+pO+tePvKNHsd+w1G03+BPo639qEXyPPkDq6QFQstBa0b
	fUdC+WybEXF/rWUQASCAdkRExctHqEfASBlU+pUPoU0K+w21LE2JLOOtq+5IuTpy75GtdjdRNVc
	SX8itaaWQsbxlz6r5Km5tL2WaDD5Dm7M=
X-Gm-Gg: AYBFou2qWuXBuyh5Uo537b4gR1mb3raeXbtNPrbUoDTphu13jhGAtpOp8ugoVP6JfU4
	M2e+f+KWzj39Aog6rNSo36aDwSXw6Yc8V8gvt0kCc4AexOZHhca/fOfoms+26UCZmAPqB6c1YYT
	n36QKApYrxbDLUWJjHOKo7biTQtMIuJJeqehBSwXsEsRX3bH66fugjHN0ztdxeL9GKS/gBrQQ9z
	5oK+l90BpyJcEoAsSNJzAIHqaU/Jqt932qDA7K0+45ItKzu9AIwF1ItAQ2H1y2v58NgSlerqVup
	ks7nXTpQiR/tvyVwzelPmUHYCV7juWfn+B8s8aEBe+BRTScC0bitwUswV6t27UXwF8+fms8=
X-Received: by 2002:a05:6820:a281:20b0:6bd:e592:2c66 with SMTP id
 006d021491bc7-6c0bb8f2546mr3602363eaf.46.1789160498963; Fri, 11 Sep 2026
 14:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-1-ameryhung@gmail.com> <20260905220117.922028-15-ameryhung@gmail.com>
 <DLBYWR47GK83.33M4TZ2YKQU5W@gmail.com>
In-Reply-To: <DLBYWR47GK83.33M4TZ2YKQU5W@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 11 Sep 2026 14:01:25 -0700
X-Gm-Features: AcwNN1XjNZ6Cr25J1gbZjhwEReJ8kOWi1vIYj3RbZFqRmpnz3032PjCSNO3vFTQ
Message-ID: <CAMB2axP+p3e9XxBxE4nN0UPsFsqBq4Wd6O9vRcqgaz5sfOYnQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 14/22] bpf: Consolidate runtime argument type resolution
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 2:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat Sep 5, 2026 at 3:01 PM PDT, Amery Hung wrote:
> > A function argument type can require call-site refinement before
> > register admission. Helpers refine map-value arguments according to the
> > recorded map type, while kfuncs reinterpret a pointer to a scalar-only
> > BTF struct as fixed-size memory when the register does not carry a
> > BTF ID.
> >
> > Add resolve_func_arg_type() as the common entry point. It delegates
> > helper map-value refinement to the existing resolve_map_arg_type(),
> > then handles the kfunc BTF-to-memory fallback. It updates the effective
> > argument type and size consumed by the subsequent checks.
> >
> > Preserve PTR_MAYBE_NULL when changing the base type so later
> > nullability validation observes the BTF contract. Keep OBJ_RELEASE
> > arguments in their original pointer class. The latter is not a bug fix:
> > existing kfunc checking already validates ownership before this
> > resolver. It preserves release metadata for the later shared checking
> > order, where ownership validation follows register admission.
> >
> > Moving the kfunc fallback before admission lets the resulting
> > fixed-size memory argument enter the compatibility check directly.
> > This is another step toward routing both call types through
> > check_func_arg().
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 199 +++++++++++++++++++++++-------------------
> >  1 file changed, 110 insertions(+), 89 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2e068c095436..15ed47b90316 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8151,8 +8151,8 @@ static bool is_kfunc_call(const struct bpf_call_a=
rg_meta *meta, u32 btf_id)
> >  }
> >
> >  static int resolve_map_arg_type(struct bpf_verifier_env *env,
> > -                              const struct bpf_call_arg_meta *meta,
> > -                              enum bpf_arg_type *arg_type)
> > +                             const struct bpf_call_arg_meta *meta,
> > +                             enum bpf_arg_type *arg_type)
> >  {
> >       if (!meta->map.ptr) {
> >               /* kernel subsystem misconfigured verifier */
> > @@ -8180,6 +8180,11 @@ static int resolve_map_arg_type(struct bpf_verif=
ier_env *env,
> >       return 0;
> >  }
> >
> > +static int resolve_func_arg_type(struct bpf_verifier_env *env,
> > +                              struct bpf_reg_state *reg, u32 arg,
> > +                              struct bpf_call_arg_meta *meta, int insn=
_idx,
> > +                              enum bpf_arg_type *arg_type, u32 *arg_si=
ze);
> > +
> >  struct bpf_reg_types {
> >       const enum bpf_reg_type types[10];
> >       u32 *btf_id;
> > @@ -8794,6 +8799,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
> >       int regno =3D reg_from_argno(argno);
> >       enum bpf_reg_type type =3D reg->type;
> >       const u32 *arg_btf_id =3D NULL;
> > +     u32 arg_size =3D arg_type & MEM_FIXED_SIZE ? fn->arg_size[arg] : =
0;
> >       u32 key_size;
> >       int err =3D 0;
> >
> > @@ -8823,11 +8829,9 @@ static int check_func_arg(struct bpf_verifier_en=
v *env, u32 arg,
> >               return -EACCES;
> >       }
> >
> > -     if (base_type(arg_type) =3D=3D ARG_PTR_TO_MAP_VALUE) {
> > -             err =3D resolve_map_arg_type(env, meta, &arg_type);
> > -             if (err)
> > -                     return err;
> > -     }
> > +     err =3D resolve_func_arg_type(env, reg, arg, meta, insn_idx, &arg=
_type, &arg_size);
> > +     if (err)
> > +             return err;
> >
> >       if (bpf_register_is_null(reg) && type_may_be_null(arg_type))
> >               /* A NULL register has a SCALAR_VALUE type, so skip
> > @@ -8965,12 +8969,12 @@ static int check_func_arg(struct bpf_verifier_e=
nv *env, u32 arg,
> >                * next is_mem_size argument below.
> >                */
> >               if (arg_type & MEM_FIXED_SIZE) {
> > -                     err =3D check_mem_reg(env, reg, argno, fn->arg_si=
ze[arg],
> > +                     err =3D check_mem_reg(env, reg, argno, arg_size,
> >                                           arg_type & MEM_WRITE ? BPF_WR=
ITE : BPF_READ, meta, NULL);
> >                       if (err)
> >                               return err;
> >                       if (arg_type & MEM_ALIGNED)
> > -                             err =3D check_ptr_alignment(env, reg, 0, =
fn->arg_size[arg], true);
> > +                             err =3D check_ptr_alignment(env, reg, 0, =
arg_size, true);
> >               }
> >               break;
> >       case ARG_MEM_SIZE:
> > @@ -11814,6 +11818,65 @@ static bool btf_type_is_scalar_struct(struct b=
pf_verifier_env *env,
> >       return btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR);
> >  }
> >
> > +static int resolve_func_arg_type(struct bpf_verifier_env *env,
> > +                              struct bpf_reg_state *reg, u32 arg,
> > +                              struct bpf_call_arg_meta *meta, int insn=
_idx,
> > +                              enum bpf_arg_type *arg_type, u32 *arg_si=
ze)
> > +{
> > +     argno_t argno =3D argno_from_arg(arg + 1);
> > +     const struct btf_param *args;
> > +     const struct btf_type *ref_t, *resolve_ret;
> > +     const struct btf *btf;
> > +     const char *ref_tname;
> > +     u32 ref_id;
> > +
> > +     if (base_type(*arg_type) =3D=3D ARG_PTR_TO_MAP_VALUE)
> > +             return resolve_map_arg_type(env, meta, arg_type);
> > +
> > +     if (base_type(*arg_type) =3D=3D ARG_PTR_TO_BTF_ID) {
>
> Overall, it all looks great to me.
>
> Here can reduce indent by:
>  if (base_type(*arg_type) !=3D ARG_PTR_TO_BTF_ID)
>     return 0;

Will change.

>
> Pls address AI nits and respin, so we can land asap.
>

Thanks for reviewing the set. I will respin soon.

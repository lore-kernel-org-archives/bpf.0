Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8528233121F
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696040; cv=pass; b=DxKCiTfiPlNkeZAGv4ZsJ+Ea8GuRZ3lShCw0Sm+zK9kRePbYlpNnGfMPydBCwPibbU8nR/gJx8rwRGcQJKmleCW0cxbP94rSgbgX3wZVAXT07W2BlF2cEErx6hMqllDVDf9EyOUapQVT/a4fgwDKQftqIxe81BdTX0kyzV78GMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696040; c=relaxed/simple;
	bh=Qpe+aRE0hMRwXWmilpiyh3z4CmUbwDuJ6HVXJGMnD58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcybMDyRwYxjHwUK+i4gl11ab8c9o90FKTS57Ke0JzNyC61NoUpKaxuvUbLlHyOizbq3RWzblgNFDsxds1sDLxf5pZ0u/TnvutU2FPWzmTX9wh6tHZ4PCD5F1XSmWiuCgZ26mi8/NTCanP94y590rlD4uRNkHAQmaH2jU8MtHoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sdi7gWAo; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sdi7gWAo"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6611d20c026so7211710a12.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773696038; cv=none;
        d=google.com; s=arc-20240605;
        b=QO81yrfzrNGIj/cDw7MVdjLw8zeZLcuQ0rUQrel+DtU7YqSxN7sa6C6VXcpsXCItNp
         VS/31gL1YJWZ7zQFoO6fMhiI0wLp08eC66FB4FWw8x6OC2ZBQNw0c2sXGdEIAwx8vnwM
         1Y6hT4HGvY41zOyyaWCWj/2phsjKtmb/okcsjnVRuINwb4dgZaUVZax2GQh0amXlPK3u
         Cm6eFd7D2o4wcS7Cgq723U+DUZHYJw24xIZoAydgg7cO4XQlfXtGFGUBmfnMSCRc4Qe7
         vNpvFLmHFaSOSB4feTd8XwSvSPQCXMczHAEOSEXxXtPlga1M8e/zrefVe+Jr6CTXqlrW
         wkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2JMwXPeKP7RGMOEN2VJvtQ4mCMPdUWUkBvBVplgfXa0=;
        fh=C1/CYBrLKavvSywI/ySSol00hqfElb5orHX7sKMqunA=;
        b=lFjfqZ2WiALrEqg4p1UTLirP3pwj28n1EfcNrLTvfUWfAN5HeWbLS7e4x1HYVADtp0
         K0oh9c4zsXk6+QUKWH20lzntnp7F0oFM5vNPSn6c+/SzFDGPs8ee4Fbb3tHqWMqpK/mW
         4t76alKUvGw+QH42D3xiWb8hIDRT6cNnIrdF+pEvHXYRH1zBFbWqMDs7j/ahH8N6V61y
         A8D/JzY/6YIjeUV589Ke7e4UGqThJg70uFTcyw9En18eTJPJXjYO4T7BzR5baoNhhuHw
         INH+8ookQ8L+h7piQ5F5t1Gmxw8NbLw3oN6WwCntzYEGYvzO6f29zlCayymjuh6scCQR
         ZLKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773696038; x=1774300838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JMwXPeKP7RGMOEN2VJvtQ4mCMPdUWUkBvBVplgfXa0=;
        b=Sdi7gWAoA0FCrhP1zBzO6lKO8rrjMHVAf8qi5qozjslMrMvEdBTH1syWGB51egYcd3
         2JajPwqu5UrYEzkkCptsNWRCUXkKcpAwon6TAbjGnnDMRaYIrSFNr34zCeWkKUjykWDQ
         g7BqZk7rMud14PXEKu/lZfuJ/7Pchc45y9H5Oi+ux9zuw6hKdHCd0epr+pGaWsoXWXer
         3gtsXPDpryk3lRTz6CQwfyQ5ubP4hw19OnefHxV+y68u2wIojO7TPGh35Z95XHBVU5b6
         pflQw4zUMGZmZbkslyA8TsFY84heowS5fKjFJa3AU8j+KnLZS+i88l+zv7qpG2PaQMjJ
         zshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696038; x=1774300838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2JMwXPeKP7RGMOEN2VJvtQ4mCMPdUWUkBvBVplgfXa0=;
        b=fE7BQXjjcDcCein2rlZRUI/8PAJn4CH+1bjNFdiPQnkFIHz+nEV7/Z5rP8tMW/WP8T
         hJKNCdVKhSdwkKgfN4npFSuw9Ihk4Gf4cQOjff2H/uKaGxtXKo/N5KA7CBv6XPTscZz3
         ivQVO9vSSNCLGdXs8ArdoJI+BQlMhOTng+SNmHu+xK7HSE51SAj2NF9ad2A8ooxxrkfh
         W73C6BI23ON8OHMRL9Tr7EvJIBUmggooHciB44za51uv6vjFIMKsE6pbPf+7Slp2reUs
         ZDMdkS8AZWCcOeesduYYSvynXWOisGjjQDeuYO0AEEktQQKxYjqUROy8ttqDM+OESBZN
         a0dg==
X-Forwarded-Encrypted: i=1; AJvYcCWLWh7l9tepOtGK5ws3AZnSY8q3ZgGCiZqLIiD/Rq46SpuoY4vesKYVU1BS/ONFW4Yke3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEwhUQvR6UUY5v5wdcKJJgs0oYw6ix29Y9YkOy7mpidTb9haY
	bV4IadD4VY0r+yVICppWSBFcHWlFk1rNNwd0EI08cwLTsOKnUUnBSATs2/VUAVlYkLzvD7XcZaf
	7BAQOResjY+X42idxOAeW/0rAa4A3eFc=
X-Gm-Gg: ATEYQzxeVh5BC5xzNIt/xxDwwChYXA9fmKnvl+LvNd1vRFEiqwOqvZziZKyGA8GkGpN
	nmp4gN2oPOIliO8s7pf+HagMQuggogFDj+4RXVXh7BdnVOEzvbghAWZRsj7i+PgsFHP092oCGm0
	iSLDWD/YRmOwokeqliou+DXbEZLKh0qelKRxTN7DQhwYg35vHHQuKYvU/dOzky+R6tn5bppAuec
	hrW2yGAcWKfMtvTULExSV39K76gg6TPDrDS0y21D7il+kL5pV/1hAdnMnfAoqmIGO2DQAR2yTFG
	sapLkWZoEv33MGYM4Nyz4+lEbtwC2n0=
X-Received: by 2002:a17:906:c116:b0:b97:98a4:1d6d with SMTP id
 a640c23a62f3a-b9798a4439fmr571032766b.16.1773696037560; Mon, 16 Mar 2026
 14:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312193546.192786-1-ihor.solodrai@linux.dev>
 <CAEf4BzbhBqrPxAtw2xE2aeO8nVaHggV2TVNrMrTJVQTg05X0tQ@mail.gmail.com> <3d069965-2992-421f-bb94-827bcb177f17@linux.dev>
In-Reply-To: <3d069965-2992-421f-bb94-827bcb177f17@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Mar 2026 14:20:16 -0700
X-Gm-Features: AaiRm50BXGDkCBt9txtcsFkKrho7CxaNZGBQZ_3o7utbmaBDApA4R6mTU_GO930
Message-ID: <CAEf4BzaeRaEfX6ZbXv1RatheQDP82sV-=9fVrVctA2LQeZxr4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	=?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 3:43=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 3/12/26 2:24 PM, Andrii Nakryiko wrote:
> > On Thu, Mar 12, 2026 at 12:36=E2=80=AFPM Ihor Solodrai <ihor.solodrai@l=
inux.dev> wrote:
> >>
> >> The following kfuncs currently accept void *meta__ign argument:
> >>   * bpf_obj_new_impl
> >>   * bpf_obj_drop_impl
> >>   * bpf_percpu_obj_new_impl
> >>   * bpf_percpu_obj_drop_impl
> >>   * bpf_refcount_acquire_impl
> >>   * bpf_list_push_front_impl
> >>   * bpf_rbtree_add_impl
> >>
> >> [...]
> >>
> >>                 /* rbtree_add has extra 'less' arg, so args-to-fixup a=
re in diff regs */
> >> -               if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_rbt=
ree_add_impl]) {
> >> +               if (is_bpf_rbtree_add_kfunc(desc->func_id)) {
> >>                         struct_meta_reg =3D BPF_REG_4;
> >>                         node_offset_reg =3D BPF_REG_5;
> >>                 }
> >
> > the amount of very specific "is this a special function X"
> > special-casing is depressing... did you try to analyze if we can
> > generalize this knowing which implicit argument we are dealing with?
> > (not keeping my hopes high, but I had to ask)
>
> I am open to suggestions, but fundamentally special_kfunc_list exists
> because in special places in the verifier the function needs to be
> handled in a special way =C2=AF\_(=E3=83=84)_/=C2=AF
>
> is_bpf_foo_kfunc() is needed with this change only because we have
> to be backward compatible. It's either with helpers or the same thing
> inlined, and helpers IMO is easier to read.
>
> >
> >> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfid=
s/main.c
> >> index 5208f650080f..f8a91fa7584f 100644
> >> --- a/tools/bpf/resolve_btfids/main.c
> >> +++ b/tools/bpf/resolve_btfids/main.c
> >> @@ -1065,6 +1065,7 @@ static bool is_kf_implicit_arg(const struct btf =
*btf, const struct btf_param *p)
> >>  {
> >>         static const char *const kf_implicit_arg_types[] =3D {
> >>                 "bpf_prog_aux",
> >> +               "btf_struct_meta",
> >
> > should we add typedef u64 bpf_implicit_offset_t or something like that
> > to actually have unique and meaningful types for any kind of implicit
> > argument?
>
> I considered this, but didn't try.
> Didn't see much benefit at this point.
>
> We have to choose a convention, for example:
>
>   "Implicit arguments can *only* be of particular types."
>   (that's the current state of things, without the patch)
>
> This implies that, at least in principle, the position of the implicit
> arg can be arbitrary. But that's not true right now due to how
> resolve_btfids is implemented (note the "break" in the loop) [1].
>
> And because it's not true, I can get away with leaving u64 off as is.
>

my thinking about having unique meaningful type names was to avoid
hard-coding the knowledge that for special kfunc A special offset is
argument #4, while for special kfunc B offset is argument #3. And
instead have a more generic logic. But that might be just wishful
thinking, ignore.

> If we also add to the convention that "in a kfunc, all implicit
> arguments always follow all required arguments", then why would we
> require all implicit arguments to be of specific types? Do we want to
> enforce the BTF type in the verifier even if it's u64?
>
> We are going to be in trouble if someone decides to add implicit
> primitive arguments *only* (without a preceding implicit pointer).
> Using an __impl suffix gives me an ick, so if we anticipate
> such use-cases, that'd be a strong argument for special typedefs.
>
> I think the is_kfunc_arg_implicit() in this patch is a good way to
> determine implicitness in the verifier, so the above applies mostly to
> how resolve_btfids determines which args are implicit.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/bpf/resolve_btfids/main.c?h=3Dv7.0-rc3#n1187
>
> >
> >>         };
> >>         const struct btf_type *t;
> >>         const char *name;
> >> --
> >> 2.53.0
> >>
>

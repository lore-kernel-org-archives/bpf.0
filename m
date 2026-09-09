Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F33D3A7826
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979295; cv=pass; b=dOmXn8hrrxu4NFn3QGMIkYlZFnAo85E3DdfPjxoYvHo2aD7Qi5qCK7bqUbwONkzm3/kEDOC1iIjFR06anFxB1/+DdL/FjAQX/tnmo1vAWluGHWNcrLJ+vY8OBffEEMkiTBKWv2JmXaW60yhQ6dqOW2MUvo090Ww7KWORuuUfdTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979295; c=relaxed/simple;
	bh=sZFoyO6mQLa5LymjxwUMWCJDVxd7khKSNnuqM8jDbrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IycYrsN+FPP121kh5h5KKnKiCyxf3Y0J6b7aufQjEL3NYu5Eo5cFlSSPvcOngr+7J++3d6z5sJwj+PsIxe0rvp2+Yi1bFPsPmUK2BgpOkzlIiCKUsCc71CiU/YYJFLbx7yGuQNE2OtVjkIDEfB5haooxg/B3eC1doWrWB72bkqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlhqOHzI; arc=pass smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlhqOHzI"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-7fc4034841cso607053a34.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 11:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788979292; cv=none;
        d=google.com; s=arc-20260327;
        b=cmN68TmNlAIla7nEuXs1RaEWVS4tuAw7zzo1S8D5yGoJLI8lME7OCNfsh/giWTaUtr
         KgBpFnjq25fbZGOYznL7XHm9iUmE170SnP9VSsmsLvcvgnPEZxsxGebrSHasD3dbMruB
         xTxy0IV/Zdfxjyua0vw2GRJKlDYGfA0yC4YHztL5x1WHHFWXqMW/zftZRrBwE95ha1eT
         RAfoPmZma7K8ds2roabUfUULVr1czFbZbKlx4PasjLLzSZfVvfq0Kxq3tAYE/EP8JvgS
         nHZk91dJLAW2w1lA2PVGzWAY5SLIG5WHczm/SuKP7Egx2GgUycb56SdfzrsMeblAmhdm
         06VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mx4TZhoxvjDMANnM+cTyBZRVcMmpkgg0E+eLSW3mLKY=;
        fh=+iofH7kLhUIpDUAo/a2rUbKulXCH8Go9n65YHAt0kP0=;
        b=Q2HrsJaUeELnpQHE7H6jn6amjBwJqkzBYmPuUv3crkssP9dvohtnhj1NZZiClexMz+
         VEr3pxdxrVa2b+g45aIG4y/LpbiPzslmPVEUKYDJFsf37+Odw2CnNzqMplIMb9KYTtjE
         WHTMDuvy6JJ1dXgIQEPnPcxILujUU0cjy9jRC+8JGjrf5bRrBqcdLdVna9qXdhj5lVRS
         HrR+wASjofH7Hd4v2e1wv2lnIA4F8DNsDFKSMPWq8N4ruWq/wr25mKdJqPvZPQixAZSx
         ym3KL+gWK7iIwnFTrqvgSsgoEsr2ekxTnTh09Ej68ZxAu8nsgLHqN82Sr1AD03KOcTB0
         clgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788979292; x=1789584092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mx4TZhoxvjDMANnM+cTyBZRVcMmpkgg0E+eLSW3mLKY=;
        b=BlhqOHzIdoTPZzpzjQcQx7YJLXkeaQ7RVoRVf4hJ0KhVlpaI4Y2p1ebEZx8naaqnIg
         zlh6U5cqF9QNGlqp71Fgb9vpaN3TCrmmOnutsaFCRZVlpihSjcP/YD33sn25+m79s9NZ
         +AICR9lEOvGq9h7E4Oduc6228138k9FNhrVWRpZeyihdBw1IfY86Z7uSzvm7uJpV1G5y
         Oy13u6lWKu5G3c+JNyWLOFdP3VKqchlfE+0K81YvnZVd0izQWv+VJkstE1MNkoGVPMex
         dbvg+D2CxQd6l244GsEuRuHpIFcWJAFg9kUwWsx+NTpMUD6yisXEcesHWQEidfxp9MRE
         JwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788979292; x=1789584092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mx4TZhoxvjDMANnM+cTyBZRVcMmpkgg0E+eLSW3mLKY=;
        b=UJ3vyYuUo4Fyf46T7QVLz1dwoRyHvvmq0Xvr1EJW4SWT6t5S4AlUu5HxE+eDjKqr6w
         oV4HbUgfbwEXmCUBn7obv/v2hlNLOQsu68iUX5yTNLHnwWm8+QV1Vh5xzfZYi3mXO4fN
         aTasu8Z7mwdScinx2Wv8wkF+jFIOn6eFInXHs3s7MLvZ895zto40LRYrtrgUVEBSdNbd
         9JdJlj9R2a7NQ06ScyhYHxlwMOmuKk0PsOdsBjFxY/+rtPTTciJtKNwMlkRpm2u/IHs2
         92+3mjusv+qKJGsI5Fs0ornC3MQ3FTvVW8OQpNnTVPZW0ihXl39Uhhty0HDBFcPt8jVS
         gN0g==
X-Gm-Message-State: AFuF++nkUudgxJUhljQcyaeQE6W10RzHxYMEIQPm1DnVVmLlkNW7/CXu
	B2zd94Awr/H4TxlF3/tXvlxao9Jfxy1yQKsEhBIjOlCOZQzGhd4tz2pF71y3xvLQ6C6k98+D7ZN
	Q+S5kuwY6sScTAW/eqw2G2zu1RgRdtEs=
X-Gm-Gg: AYBFou3ZYFClGGSwOqx5enjDA1fUlKtn6HFbstrZjB+Agf8f3zN59ghVISHga3WUn6o
	nS+px6akR0X77lpuR9SaYDSrFleFnQB6upp/qzi4VQV4Jy3IhkccrqJopn2KhsTNQXIjRQoIu29
	2UrR10RylmOPB7R05PhvNa8E39dJ9gRc+95Wqh1jcC7go9KrWFo1suYvPhbSe1r8Shk0M6XRKgE
	KJhRQClVmBRbBnpn+onup7Hy+jL3DchDRT5bUxCpM8PYPR9ffPQrr1aO9L9+e+MjwqgdZj0OOVr
	mgg2zICMUKUbPffFp7+vQPgeTRvlhr1cwUSNfbzcejPSB/26Qapczi3EWIUqgzONnIIVFQ==
X-Received: by 2002:a05:6820:813:b0:6b7:46fa:16a9 with SMTP id
 006d021491bc7-6bee81fafd1mr1770500eaf.62.1788979292502; Wed, 09 Sep 2026
 11:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-12-ameryhung@gmail.com> <a578e5a3739a469e7c8c1150b31b719b013f85c22d725d2bcc4a444199759e78@mail.kernel.org>
In-Reply-To: <a578e5a3739a469e7c8c1150b31b719b013f85c22d725d2bcc4a444199759e78@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 9 Sep 2026 11:41:19 -0700
X-Gm-Features: AcwNN1U8d6wNu1tlh-uOURcuqDhwwJvH8Pnrts85FaCYqlGHIoncB-mb7n4RdDs
Message-ID: <CAMB2axNGtDyUUs3+0j-5pjEAMGg75RjkTnfZZAiknQVQYKmx5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 11/22] bpf: Set MEM_RCU when generating kfunc
 argument types
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, martin.lau@kernel.org, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 3:44=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f43462a43ee9..c5b394e847e6 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12239,6 +12239,14 @@ get_kfunc_arg_type(struct bpf_verifier_env *en=
v, struct bpf_call_arg_meta *meta,
> >       if (is_kfunc_release(meta) && arg =3D=3D 0)
> >               arg_type |=3D OBJ_RELEASE;
> >
> > +     /*
> > +      * A KF_RCU kfunc accepts an RCU-protected pointer where it would
> > +      * otherwise demand a referenced or trusted one. Only ARG_PTR_TO_=
BTF_ID
> > +      * looks at where its register came from, so leave the other kind=
s alone.
> > +      */
> > +     if (base_type(arg_type) =3D=3D ARG_PTR_TO_BTF_ID && is_kfunc_rcu(=
meta))
> > +             arg_type |=3D MEM_RCU;
> > +
>
> This isn't a bug, but would it be clearer to state the actual reason
> for the ARG_PTR_TO_BTF_ID guard here? The comment says only
> ARG_PTR_TO_BTF_ID looks at register provenance, but several other
> kinds handled in this same function do inspect provenance:
> ARG_PTR_TO_ALLOC_BTF_ID and ARG_PTR_TO_REFCOUNTED_KPTR check
> reg_is_referenced()/type_is_ptr_alloc_obj(), and
> ARG_PTR_TO_LIST_NODE/ARG_PTR_TO_RB_NODE/ARG_PTR_TO_LIST_HEAD/ARG_PTR_TO_R=
B_ROOT
> check type_is_non_owning_ref().
>
> The guard is actually needed for the reason the changelog gives: to
> prevent MEM_RCU from leaking into arguments whose handling compares
> the whole arg_type, like the ARG_PTR_TO_CTX test in
> check_func_arg_reg_off().

I will adjust the comment. Besides, I will also update the commit msg
to drop the "ARG_PTR_TO_CTX test in check_func_arg_reg_off()" example
since it now compares base type.

>
> >       return arg_type;
> >  }
> >
> > @@ -13174,7 +13182,7 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_call_arg_me
> >                           reg2btf_ids[base_type(reg->type)]) {
> >                               if (!is_trusted_reg(env, reg) ||
> >                                   bpf_type_has_unsafe_modifiers(reg->ty=
pe)) {
> > -                                     if (!is_kfunc_rcu(meta)) {
> > +                                     if (!(arg_type & MEM_RCU)) {
> >                                               const char *expected_type=
;
> >
> >                                               expected_type =3D bpf_dia=
g_fmt_btf_type(env, btf, ref_id);
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/339954=
42755

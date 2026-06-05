Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB4309EE7
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689477; cv=pass; b=Pxk+Xyct++By08fLlVY9IT5B6G9KndfxSpjhT10CH1s2+TSP3rEnuqXOQp9OXWVHwkXyPjMUr2Cr2FoaMk175SpNLKC8LY0sMWfnhWuPlBaUFBRLxEG61W3VUIDBV1Z02Q6/KtnlPzwdxYJpBjA/MhWurhcm4Ld86JpU9CxrUjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689477; c=relaxed/simple;
	bh=CwWZX6bA7Wd3IEFPJwjZuLYgybiBOKsUaqQbAdcC6C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JP/e+/U4I4auos78QcApjoCTfGZtnj4v614/npVA6Ub/Rm11JYGSnNbw2KDxLixXtC0Hk3sCh6dXrBW64nJA4NvBnzubumSImcQi2FaFDahG8rnBcZjSwQIcpTzwjjAxWjQzWzteS8xC56egMXgFzfoUQx5Okvk4g5UZPoHZ/hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7TVysEL; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7TVysEL"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7dc2b658544so21026557b3.2
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 12:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689475; cv=none;
        d=google.com; s=arc-20240605;
        b=XwaTEAUwM383gVAs2LHd6EVqZeQjN6QRFj22L8yfMdozmiugWQCOeCfl9iuIiFsPYG
         AY8ocje058WlpsNcfinN9UBoF63ZUdOx+V8DJE9Eq7ETdRi0TTreBtQtsBqBKlB5EBGj
         LWxlAKFM6dUsLwVdfFok8BfOEGTx0yhJLOOHTg/CcMxy/k9GfgI1z3jFz8aeLeKHAmlG
         6VXmHW75q/q8FiE1XCrGyJjrEdwHtcmd2RuJGOQzqzGj26NQWI8x3l+N+ulDYCxj/wbX
         zNgbHp1L5xGpo1ibyf+X3qHU01/7R0JPVNDiyHZ86yQkWgB1DMF9GZYd43EojsqJAdbw
         CiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0jGmHTY1/xqU89xp/qNCXcvtPI4E099BtKFLZ3FnV9U=;
        fh=SS7tT0KC3jLZdfo/Ptau2hbovOS8lxj95BG5rgPZ6kI=;
        b=TBT0gvynBFvhrpcV7tIBGav6+FNQ9PVtiW9pN4ErVNKDuSJmhU/rbnje+rOUQAGEd2
         4v9PwpKSAppbX/u+uktjwvOv0TagyGa2yIwoLEtVcTvwd73JRn9i1WTFIQMDM051utb7
         XR+qrBFjHaSguxibOLR4f26N+nQMwkllErN1tn6rYUbB1J/RdGGbHQZ4wCaCXddpkSzF
         6S2YgDf+wMkHb3UKBVhkRdKfhv0lnOjmfB1qOsVjlkKVbx7dTkjsAXVbgFLEVICVLsvg
         3h9H919xE+2oW+UARd3THBDZuP4vLa/JtZnMjPupAkUCvtqeoYracwRm1+qGgcNjRJA2
         +u8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780689475; x=1781294275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jGmHTY1/xqU89xp/qNCXcvtPI4E099BtKFLZ3FnV9U=;
        b=k7TVysELWpW2aXiP37rDRdceNo1d8zFjGu3I8HRErXRHxVw9Gwvq3hZm6c1FwqE0qV
         g5cArpX6wJhPgFTmN6fQRyrzx9wS52t3f+gaiMUxi+Ax1ULEmyG+zruOY2RxhAhJ+b8w
         Iz3nggscxZHbDfPT51G9MwrQR1ZcgzcMsWYwmbjp5TkFpsj63gNKk0bRSG0HezvDDjjE
         uj6r/s2uC6PL+nKseEVtiXt1Jfw0wNhyU7RG2A0FqGuQo7KvQgRFqnx2quwlpyV0MxHJ
         9R/TX4y9Sl16aA93PrDkFvw510qZRZ2iLhxIAqDQorrKa6NsC5dQMyQ7WcxHNzv+xwSh
         wQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689475; x=1781294275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0jGmHTY1/xqU89xp/qNCXcvtPI4E099BtKFLZ3FnV9U=;
        b=hpnPy3BLWfmKkFS6kKEFfFWClVU+n+HBSNXIY9gnA7b5amjx6wr9ce80jI1QmQZkie
         FGRJalJSyFC1MBSNAvutRdHtcs0RYw+B1JAtidzCxETSmWZu8dWCUyZisbyR3sEs0xVV
         rNdLyLd+MmiSx/6mK2uQhH8kIHehl1QpEHQBlo8saleIcz7tBwDZPtFWP/brm11eKvao
         S6tzjwB6ekcPzhUsI9OWIXgnz1QOrTeHKXOh8qQbW7jObgDHPladQ2NUaDYUFrccZimC
         BAs6e5djA5K46WDPNhwmrdjByp3nePdJnSfkYvJQO+oeVsnGMwwoKAwR247KkzPP1R+b
         tVZg==
X-Gm-Message-State: AOJu0Yxg/a1FszxAroUJRMK0LCZqlE2Xc9rxvxsmoqM9xF6OIEfHPn0e
	nBSnR55Evx/zz3nC6shL1xeT8EMcAhuViW2ne8B71MgWQ9RKKmXxnOsLP+luP+hByvbXqMn/bS1
	iuk6z8NGeuM1oYhgpGZ5sjXhLHGnGsgg=
X-Gm-Gg: Acq92OGIkMcP7LJ4dUAKUuXjk/9CHKyBrOlQkTgd3nHhMrtY0dCXsnFr970n0iuRlEr
	TUFS8iiESbO49dfmpaaHm5t0zxapv9jrjCyohDGKs8nbGaBOHHjCRUVxP7u7R3YH1K7KSFy6zjt
	cG7mRbW38i35f7bE76sspsdMaiSV8uKxLqCGh/DUNOrtzz4aVsUWwn7MMg0IRoVE6oXTwyJOfVE
	I+5B3XGWoLIFN5898PE2y53Zq/WN2sZanMzwGrPyxgfCFdrhvPSxjyQNIvfbTKza4wG8V8BudAd
	Ed5e6W7vY7GYqR78F8kZL4Pa1t0r0p4Xxw==
X-Received: by 2002:a05:690c:dc4:b0:7ea:77ae:ccdd with SMTP id
 00721157ae682-7ed0ef4b30bmr50021687b3.17.1780689475373; Fri, 05 Jun 2026
 12:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605183551.969144-2-ameryhung@gmail.com> <80529e40f2a7d1124be6c9d4c914629fe4bfb64ed2e111a1a23700fe268347b1@mail.kernel.org>
In-Reply-To: <80529e40f2a7d1124be6c9d4c914629fe4bfb64ed2e111a1a23700fe268347b1@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 12:57:42 -0700
X-Gm-Features: AVHnY4Ly5qAEYlYw5PTtZuMwUyIdIHcT1U4Qb9xH4-HdlO4xYQ66oh5BaH3Anb0
Message-ID: <CAMB2axMYTkj0yMH-iTjmdsYbktJdkk-vmgqgTwPg+sLhXZicBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Fix dead error check on
 acquire_reference() in check_kfunc_call
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 12:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7d27ba396d32..a741bf447931 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12817,9 +12817,10 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >       struct bpf_kfunc_call_arg_meta meta;
> >       struct bpf_insn_aux_data *insn_aux;
> >       int err, insn_idx =3D *insn_idx_p;
> > -     u32 i, nargs, ptr_type_id, id;
> >       const struct btf_param *args;
> > +     u32 i, nargs, ptr_type_id;
> >       struct btf *desc_btf;
> > +     int id;
> >
> >       /* skip for now, but return error when we find this in fixup_kfun=
c_call */
> >       if (!insn->imm)
>
> This patch fixes the missing error check in check_kfunc_call(), but
> could a similar issue exist in do_check_common() when initializing
> struct_ops program arguments?
>
> Looking at do_check_common(), there's a similar pattern where
> acquire_reference() is called:
>
> kernel/bpf/verifier.c:do_check_common() {
>     ...
>     for (i =3D 0; i < aux->ctx_arg_info_size; i++)
>         aux->ctx_arg_info[i].ref_id =3D aux->ctx_arg_info[i].refcounted ?
>                                       acquire_reference(env, 0, 0) : 0;
>     ...
> }
>
> Since acquire_reference() can return a negative error like -ENOMEM,
> assigning it directly to aux->ctx_arg_info[i].ref_id (which is a u32)
> without checking for errors would swallow the error code.
>
> Does this allow the verifier to successfully accept a BPF program without
> tracking the reference, potentially leading to a kernel resource leak whe=
n
> the reference isn't released at runtime?

This is fixed in the next patch

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/270340=
08594

Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0447261B9C
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 00:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041345; cv=pass; b=LaWJDha5ijZKITXwhUwFOax0IWWneI1H3dfzJVNqsYMIgSv8oO9obrS+dO1ji+5w7Kqrgdnd/u69XDGzBtfmFNc8K1M2imPZa3hufOwsujDvNuvCMIKMbSIfHOhtkNK/mBpkJdY0Ug0uEnFo6/axBoUzdIePCSIOY6zpnWgqx40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041345; c=relaxed/simple;
	bh=rTht2jlgLZtnSSDufST2BGNnua07jyJe5oueYXcI7Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k82ERo3qShMNOzSf2MEH9CbVZPb909hfYOMlXGeo8Qy4RwyZybwV/BY0OGCrjLt7njG9HKC9YtuOTHUhvl77XMQuRN3iaqeFDWp294Sk1mkaoYqMKjlzKQqHYZn+HOmAdYM4jv8CehVL3a6EcaHbCYWeBj854qliY6UCOIL3ijw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqdtBtgz; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqdtBtgz"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c551edc745eso134890a12.2
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 16:22:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769041342; cv=none;
        d=google.com; s=arc-20240605;
        b=SPq008oRFvSRgTTgxIFO+ZJr/Cer66Ez0TwXFXp5ga+CKTCD0ElLwA+6iuwBFHoJ9I
         auRxlb/29vztvKoNqzaAPmSqpxQLGigsmWEgOeweR8VhpYPR2xncRb2qmiqv8e3vciOO
         Hk1gtSCDwLTJt8OM4NOfjyBQx5wMTom7WA1s/0dYkBpFlW3fnk3rUEV5WPZT0YBvlYq5
         WbIg8Y1t3IiTIa/JVHY8bMRnCXYuNWRLgbeu/Z0lJ42aNl51NhMYsnFR+jG3z4k+le8L
         L/pJoH5meBN2tHoxIR5f2eOUM0Ob87Pacpf2e5woVHafowT2uI7sID04LlnGwSRjLpfm
         GVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=esxls06rnSQ7IobZFMhGI9SPyZewHXysfYzPDMfIq/A=;
        fh=Unipwk+whcznvYPyRWZbPQuYwrHHrUSBXOKR/SCYUPs=;
        b=K414sXGhjPTF9QoT2JGr298RoyiyHGxsZRhhKkv27fcfpThHCMZt8NV+b/d4Muj1tq
         77D4Hd2pA2Zs8tWVfuhG0GGhVl0XecMX7YNuyVNVAdXPDvS93BUukLV8HB+MKpP1faMo
         gzShAXjHvkL7dyo/u2xrpKqnGLJT55U5FBrL7on1tQL9ECTVvI3D8h745ylLsKY4XrOc
         SZ2R8TfMeREjccSmQZmA4EA+EwEyDmFwarl1QD3zgCExXfbQxhwOEfI+qPvuUXb0mwsh
         UA6wDoiaby0pEecuKhvee1r1UjgkivBPwdz/ziSDANDAEqWlLRm+NKseIlmJDrYkzGMy
         oWsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769041342; x=1769646142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esxls06rnSQ7IobZFMhGI9SPyZewHXysfYzPDMfIq/A=;
        b=ZqdtBtgzzbRgwHjLyZCQ1cgnAVX1ZiQDxVhmOvSyq2oJtKFY/KDinWvaGuzNlecrO3
         DfVq1naiANaKsyaoshfG3d2YEH20fTLOTpyk/PhhoKbEBT/7MJ1XA//V+aSLbsPWZYx8
         ulQkVIg+3f50V/7rS4mzTGIl2faERmdDxBRreDhBZB7eF9x9mXoq+Hp6LMMyAJCWxa/P
         3OJWMemDo8q5pGcZSWt0inTcdpongEwXADofbYzCEnsn/lwO65yeFtrSgpQtIbbk+ytm
         FCJNFHxO3HADMOfyuHgdr6LpCyKuVbHoRK72Jpqyk3Yq536lM5yLHzn6NaYy6wWFogO0
         Jiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769041342; x=1769646142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=esxls06rnSQ7IobZFMhGI9SPyZewHXysfYzPDMfIq/A=;
        b=BXcp3fgCi4kgZduk75/6GY2aSebpOmqieAt9QUNLj7HL2c+0PQPKbRwr0PI4HtVkeS
         VFDP+JWuaPgQtnpw0S65Z2aOvU7230F/61yRSwWJHsPz1LbeUhwazB7PcAg272y22UKb
         WAAFlxc2AcPgujCm+z4DOiuxASlLEOU+RT9C6SCgyOpmzcXMy7LqPyV/AZiZeAo2fBgZ
         KgezC+Url8xBNRuwvD0G/KhCRcAVKS1q4UyleeR6sLH7ss8UNRlkaol74rUAKPHqKUkr
         3Wj8Uvt6Qrwjc9ADSP48zXgzTxM/ctJTmXnHYs9n6cN38yAcGTgVU7tI5xGJlR72pWNR
         AHww==
X-Forwarded-Encrypted: i=1; AJvYcCVDZTODMxfCVucGPR/br9cAOnTxDX3vH/gxIZzt12+2JHVnrhEqHYi0RZfRwWOmbv/6bYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwswAcnfnVP3o0mzSQNlolV8INvTFpENRXQ0KGPJs86JOsB+p2+
	LaxosdWrf4HPpTRy1K+h1FrSiCQQSeEm989WV+hgkHo9TNu7XgAl71tx0PazLzar7VY6rG02x5A
	IpGf5TK0WcmdJZo9/SBHGg6o8xB1Zn5c=
X-Gm-Gg: AZuq6aIhas4npA3yuzjDiq48K+CBmPrjsmYZoZcFOA++4ngw04DE16077BhplcZZuAZ
	rcrF8/nz2eXgmKNJE+TJFv1TIFF86dtJPJB+EIG154JDVJthZ8AY0CAFmNCLwpZxu8dtpVt/hMw
	YdfzY1AmpN4pkztH3xtp3KSKGi8bfQeTNkBlyiTxIq84qs3AcYJshipg8p2+KI3SUQ+FOj2fMZt
	wvBiOfuSPo1+llt9/M/eD2N0JSdr2XyzgSckiB+J+CZcTSBxVhno5lducjPFQm3+vaGAPlU51w8
	e5YCchff
X-Received: by 2002:a17:903:3810:b0:2a1:388d:8ef5 with SMTP id
 d9443c01a7336-2a7698fb1a2mr63903145ad.19.1769041342107; Wed, 21 Jan 2026
 16:22:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
 <20260115112246.221082-8-dongml2@chinatelecom.cn> <CAEf4BzYop1GT1v7qxNQi44dsEebjwnLp-sHDp-HPzVrj69WzTw@mail.gmail.com>
In-Reply-To: <CAEf4BzYop1GT1v7qxNQi44dsEebjwnLp-sHDp-HPzVrj69WzTw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Jan 2026 16:22:07 -0800
X-Gm-Features: AZwV_QhWzV_mYhMnCtmTeqRyohTRDUETfQ34KN9rYVEgegWCd1UfxQzHm8802cs
Message-ID: <CAEf4BzZm5uenrYO3ZXiGB8qXCg67Ov7crNvZtsj=Be4XEm6OpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 07/12] bpf,x86: add fsession support for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 4:06=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 15, 2026 at 3:24=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Add BPF_TRACE_FSESSION supporting to x86_64, including:
> >
> > 1. clear the return value in the stack before fentry to make the fentry
> >    of the fsession can only get 0 with bpf_get_func_ret().
> >
> > 2. clear all the session cookies' value in the stack.
> >
> > 2. store the index of the cookie to ctx[-1] before the calling to fsess=
ion
> >
> > 3. store the "is_return" flag to ctx[-1] before the calling to fexit of
> >    the fsession.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> > v10:
> > - use "|" for func_meta instead of "+"
> > - pass the "func_meta_off" to invoke_bpf() explicitly, instead of
> >   computing it with "stack_size + 8"
> > - pass the "cookie_off" to invoke_bpf() instead of computing the curren=
t
> >   cookie index with "func_meta"
> >
> > v5:
> > - add the variable "func_meta"
> > - define cookie_off in a new line
> >
> > v4:
> > - some adjustment to the 1st patch, such as we get the fsession prog fr=
om
> >   fentry and fexit hlist
> > - remove the supporting of skipping fexit with fentry return non-zero
> >
> > v2:
> > - add session cookie support
> > - add the session stuff after return value, instead of before nr_args
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 52 ++++++++++++++++++++++++++++---------
> >  1 file changed, 40 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 2f31331955b5..16720f2be16c 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -3094,13 +3094,19 @@ static int emit_cond_near_jump(u8 **pprog, void=
 *func, void *ip, u8 jmp_cond)
> >
> >  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> >                       struct bpf_tramp_links *tl, int stack_size,
> > -                     int run_ctx_off, bool save_ret,
> > -                     void *image, void *rw_image)
> > +                     int run_ctx_off, int func_meta_off, bool save_ret=
,
> > +                     void *image, void *rw_image, u64 func_meta,
> > +                     int cookie_off)
> >  {
> > -       int i;
> > +       int i, cur_cookie =3D (cookie_off - stack_size) / 8;
>
> not sure why you went with passing cookie_off and then calculating,
> effectively, cookie count out of that?... why not pass cookie count
> directly then? it's minor, but just seems like a weird choice here,
> tbh
>

consider also just calculating cookie count out from bpf_tramp_links?
would that work? Then "func_meta" would really be just nr_args (and
I'd call it that) and bool for whether this is entry or exit
invokation (for IS_RETURN bit, and maybe we'll need this distinction
somewhere else in the future), and then invoke_bpf() will construct
func_meta from scratch.

It's relatively minor thing, but as I mentioned before, it's this
hybrid approach of partially opaque (from invoke_bpf's POV) func_meta
which we also adjust or fill out (for cookie index) is a bit of a sign
that this is not a proper interface.

>
>
> >         u8 *prog =3D *pprog;
> >
> >         for (i =3D 0; i < tl->nr_links; i++) {
> > +               if (tl->links[i]->link.prog->call_session_cookie) {
> > +                       emit_store_stack_imm64(&prog, BPF_REG_0, -func_=
meta_off,
> > +                                              func_meta | (cur_cookie =
<< BPF_TRAMP_SHIFT_COOKIE));
> > +                       cur_cookie--;
> > +               }
> >                 if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
> >                                     run_ctx_off, save_ret, image, rw_im=
age))
> >                         return -EINVAL;
>
> [...]

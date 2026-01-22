Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444B2BEC5A
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101102; cv=pass; b=R6D8REiCZXHMA6Pm5NRY+WPaJyXPQ7rCgK2c3G6SYLxBUswSLkIjeH+t5b4gEY+1ZvzsJR1daLk/txRKML/Z3UA+BDrCbcPuViNtgfBLQXoip9QO6L3h9M68RBRlo3oucGggt/eOiGIQD12HUBnzgiJORlyyujYHrhsDyI1AKi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101102; c=relaxed/simple;
	bh=lPbyE5HVBGcvAtveEW567s0jPq8xfXpiKG2oyWYcLWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCHK7uzg/47jZwm346/qLpJk7s5rerda0tdNwqtTKOdSA1Vd8tYW35DySwayqED7Uj9jyyWXAjd6Lg90Z8PhZTw0mMgJMJSXAgvwtJN5Awf1jgvbwNH5eNaLWCPJgeV20WMmZXUEW5tdS/Xxv3JVLFKFSsYg3EimB9u8M7NcykU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzqVgZed; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzqVgZed"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso789926b3a.3
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:58:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769101090; cv=none;
        d=google.com; s=arc-20240605;
        b=M+cjX+JksC6xJ29k1p1HYlfxE59BAWYDCK0KzHDv9ZJaMb6Zo1zV1p5XHCiH3xyHAP
         VpqCSMNrCU3aoL3srEzUtPk+0N/S+LsZ1JjjXRWMHMIkQyiGjmpAUwZeHALffbDovwCH
         qXGCcf+miAn1h1/i9URZeASr0gMe8+mTzA6Ikakmxi4Q9JWxghGujuKCYCjj41by0+am
         LuFi5mlhl/I0B4DnApMaGKebSixJMUcVI3aa7j2ggcXzxOqoLwPxsXjicwGDbTJRR0mY
         6WE2VbSGviyB5FPQljeYc6pm0pp2+/yqq7kh7J9yIiTmIwG8wltYttKCnLQZMS/Rk9x3
         g97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dlYWNytdbLuoBlz0DkwQwH1hWCGIcWrpH4X6lCzbbyI=;
        fh=UyVJgeF0jRG8C5GNWEaCQsr+du+m2EFCYLDmgAgr7FI=;
        b=RVxogL0M2mt68jyVN9WBJPDMSiqAFfbXImihieEpPVPF8UfhHU3/sN4Zn1fznLfoPt
         YfVVELtkIpsNAwMIDeSZYADgXbnjwurmrTE5tObw96jn8pZUaqyZ6eYa14iRKZwVfhgG
         FVl2BHw2mKXpzL9Dw5jtrTqs+eEBPv0dweGM2a1OEra3mbW//ayPBPYE2bWPhjSpDdUP
         Hj3aB/BzH0wrBAWCVl54yxyWEdJudgWw/8WVHhgQIik94ZBYPTO1KlZWUUufOLBtDvw6
         tlBZ2f0+yKAUMUtSuANJbHoZ68sKE7p5LsCE5am+FY5EXE52xKugFJ1umpgYz9BoEf+Y
         pSfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769101090; x=1769705890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlYWNytdbLuoBlz0DkwQwH1hWCGIcWrpH4X6lCzbbyI=;
        b=ZzqVgZedBew0uyeV0+NQjzrc6f5h4n9eH/ovrUrtnL8qLTqkG/xyQV1NvHYRu68jKT
         bFX57csUEIa0F9HKG5v+bMCwVe8zuABF7Ixxize7SiggwydNr9/e4Oda+U3D/SL02u7h
         5wMaeaBnfKYlgMNLxPrXoPPtee4epX4LOyakAUWWhYXsMgI1SR5WKsru6dCsJr1l26ON
         wYPMlHOzg2EEn94TidVBjp9qcs+9gcCAcgYkv76DXx0bJfJ09sAPoM/cD6EuEyocr94m
         39J7o9O+kaRWh1PeQKexOeSAPFdbIVYjgITIailgDx71I08gL+ymG6IPjbNIT1/wVe9k
         scWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769101090; x=1769705890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dlYWNytdbLuoBlz0DkwQwH1hWCGIcWrpH4X6lCzbbyI=;
        b=kJBPbyDiY/D2wW1vDu6xtHqpzNx/cbwF1DnLpbAUx9PSbtarl44KGLnuRG9oQxRdjI
         IguoGdEjx+n9lGplh4VCE+PhRIPX7syIuolbyn1BbEY70VJlw66nGpfBqcwGfJ9KDzuF
         xilYO5wp6gtMAFwle9nAUuvSTHfFpbxmfMGCMRYuuP8V0zZifBCFSpsMCAWnPUki542I
         Vgl+85mQyfN7aL5x/+ocKEvNQZlfeyp8N47ESJyzRFqh6mi8YvxfmNrweDp/DNDYTlNn
         zlBP5aLRgwK/+2YOkhJ3NvoeDIfDFFZWL+KbakQlYIE8+jQaWHWsoCY8jNnniRUY8L1L
         DAyw==
X-Forwarded-Encrypted: i=1; AJvYcCVOo5p+enzPsC4LgUWTClNP1pBLb2jfb9kQWzgvJ5P2Nv8hbxuYG8eOvqaBaf+4gnGbLZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE6tOjkepPBMfEiyb928mzLdY8GjyJ0lCdG/aMsNoPnReDG1EE
	EPi1E2AOdeCS427qi1njruQ89j0oOia9txQwXPKsFIJacbPijmKcDotKhqznNA4HVhKPtXIBqL3
	1isB24Bpaf/aARGT9XRKFlAvdeKegO7A=
X-Gm-Gg: AZuq6aLBGoQtGdvhP2R3SSGy7vPK9JNk9JmsNSBDzTkjescmRbK+cbzDnFW0GbnG/8j
	Y3PgHlqT01t1LB7D3sP1qtoH2N285cJz9aiOSZ/EaVkoonZS59wuP6ttVWMcIKf7kdYbV0WLaWa
	kMrTad76N+8kCjR28RUEZO89XEalrnZyJGoJ2KNHpooV2pzITQOq6ypX/TmBxWh5AzDjjy6r+HN
	2rcMpbWoR5iOjaX3UxHto7J0PvqXMsmCBoslTHg+bqJ30nwMy5SPpLLA2ZJMAP2la++xVA0ypIX
	ZDiQiMBWZ7I=
X-Received: by 2002:a05:6a20:d80d:b0:38d:657f:7d9d with SMTP id
 adf61e73a8af0-38e6f823b2fmr243279637.75.1769101090077; Thu, 22 Jan 2026
 08:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
 <CAEf4BzYop1GT1v7qxNQi44dsEebjwnLp-sHDp-HPzVrj69WzTw@mail.gmail.com>
 <CAEf4BzZm5uenrYO3ZXiGB8qXCg67Ov7crNvZtsj=Be4XEm6OpQ@mail.gmail.com> <3026367.e9J7NaK4W3@7940hx>
In-Reply-To: <3026367.e9J7NaK4W3@7940hx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jan 2026 08:57:57 -0800
X-Gm-Features: AZwV_QjPBQw-apRLcGe2OrHL4UUNo4YK_kjv4s9fPB2irHVYsQr_3qH8dSMkPr4
Message-ID: <CAEf4BzYR87Tpp4=UXBe=_A50kfZsAh1b8P__wmNU_4tKo5LqHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 07/12] bpf,x86: add fsession support for x86_64
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 6:41=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2026/1/22 08:22 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > On Wed, Jan 21, 2026 at 4:06=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Jan 15, 2026 at 3:24=E2=80=AFAM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > > > Add BPF_TRACE_FSESSION supporting to x86_64, including:
> > > >
> > > > 1. clear the return value in the stack before fentry to make the fe=
ntry
> > > >    of the fsession can only get 0 with bpf_get_func_ret().
> > > >
> > > > 2. clear all the session cookies' value in the stack.
> > > >
> > > > 2. store the index of the cookie to ctx[-1] before the calling to f=
session
> > > >
> > > > 3. store the "is_return" flag to ctx[-1] before the calling to fexi=
t of
> > > >    the fsession.
> > > >
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> > > > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > > > ---
> > > > v10:
> > > > - use "|" for func_meta instead of "+"
> > > > - pass the "func_meta_off" to invoke_bpf() explicitly, instead of
> > > >   computing it with "stack_size + 8"
> > > > - pass the "cookie_off" to invoke_bpf() instead of computing the cu=
rrent
> > > >   cookie index with "func_meta"
> > > >
> > > > v5:
> > > > - add the variable "func_meta"
> > > > - define cookie_off in a new line
> > > >
> > > > v4:
> > > > - some adjustment to the 1st patch, such as we get the fsession pro=
g from
> > > >   fentry and fexit hlist
> > > > - remove the supporting of skipping fexit with fentry return non-ze=
ro
> > > >
> > > > v2:
> > > > - add session cookie support
> > > > - add the session stuff after return value, instead of before nr_ar=
gs
> > > > ---
> > > >  arch/x86/net/bpf_jit_comp.c | 52 ++++++++++++++++++++++++++++-----=
----
> > > >  1 file changed, 40 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_com=
p.c
> > > > index 2f31331955b5..16720f2be16c 100644
> > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > @@ -3094,13 +3094,19 @@ static int emit_cond_near_jump(u8 **pprog, =
void *func, void *ip, u8 jmp_cond)
> > > >
> > > >  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> > > >                       struct bpf_tramp_links *tl, int stack_size,
> > > > -                     int run_ctx_off, bool save_ret,
> > > > -                     void *image, void *rw_image)
> > > > +                     int run_ctx_off, int func_meta_off, bool save=
_ret,
> > > > +                     void *image, void *rw_image, u64 func_meta,
> > > > +                     int cookie_off)
> > > >  {
> > > > -       int i;
> > > > +       int i, cur_cookie =3D (cookie_off - stack_size) / 8;
> > >
> > > not sure why you went with passing cookie_off and then calculating,
> > > effectively, cookie count out of that?... why not pass cookie count
> > > directly then? it's minor, but just seems like a weird choice here,
> > > tbh
>
> Hi, Andrii. I think you misunderstand it here. The cur_cookie is not the
> same as cookie count. The layout of the stack looks like this:
>
>   return value  -> 8 bytes
>   argN          -> 8 bytes
>   ...
>   arg1          -> 8 bytes
>   nr_args       -> 8 bytes
>   ip (optional) -> 8 bytes
>   cookie2       -> 8 bytes
>   cookie1       -> 8 bytes
>
> So if the bpf_get_func_ip() not used, the cur_cookie is exactly the same
> as cookie count. But if it exist, they are not the same.
>
> The location of the cookies is independent from the context, and the
> cur_cookie, which is the index of the current cookie, don't rely on cooki=
e
> count too and can be bigger than cookie count.
>
> PS: the location of "ip" should always laid before the nr_args, as we get
> it with ctx[-2]. Maybe we can optimize it later. We store the index of
> the ip the func_meta too, therefore it is independent from the ctx too.
> Ah, it looks not make much sense ;)

no, it makes sense, I missed that we have this optional ip stored,
which changes cookies offset. So let's leave everything as is.

A thing to consider for the future would be whether it would make
sense to have dedicated ip slot on the stack regardless of whether we
use bpf_get_func_ip() or not, just not fill it out if not necessary.
That would fix offsets and make things a bit simpler. But as I said,
just something to think about, no need to change the logic right now,
I think.

>
> > >
> >
> > consider also just calculating cookie count out from bpf_tramp_links?
> > would that work? Then "func_meta" would really be just nr_args (and
> > I'd call it that) and bool for whether this is entry or exit
> > invokation (for IS_RETURN bit, and maybe we'll need this distinction
> > somewhere else in the future), and then invoke_bpf() will construct
> > func_meta from scratch.
> >
> > It's relatively minor thing, but as I mentioned before, it's this
> > hybrid approach of partially opaque (from invoke_bpf's POV) func_meta
> > which we also adjust or fill out (for cookie index) is a bit of a sign
> > that this is not a proper interface.
>
> Yeah, the current approach is indeed not perfect. But I think it's
> a little not flex if we construct the whole func_meta in invoke_bpf().
> For now, we need to pass nr_args, is_return, cookie_off to it. And
> we need to add more function arguments to invoke_bpf() if there
> are new flags occur in the feature, which is not convenient, right?
>

I think at some point we should just collect all those different
arguments into a small on-the-stack struct and pass it as an
"invocation parameters" argument. That way we'll have properly named
arguments (struct fields) and we can easily have some defaults
skipped, if necessary. But again, just something for the future to
ponder. Just resubmit your patches as they are right now.

> So what do you think?
>
> Thanks!
> Menglong Dong
>
> >
> > >
> > >
> > > >         u8 *prog =3D *pprog;
> > > >
> > > >         for (i =3D 0; i < tl->nr_links; i++) {
> > > > +               if (tl->links[i]->link.prog->call_session_cookie) {
> > > > +                       emit_store_stack_imm64(&prog, BPF_REG_0, -f=
unc_meta_off,
> > > > +                                              func_meta | (cur_coo=
kie << BPF_TRAMP_SHIFT_COOKIE));
> > > > +                       cur_cookie--;
> > > > +               }
> > > >                 if (invoke_bpf_prog(m, &prog, tl->links[i], stack_s=
ize,
> > > >                                     run_ctx_off, save_ret, image, r=
w_image))
> > > >                         return -EINVAL;
> > >
> > > [...]
> >
>
>
>
>

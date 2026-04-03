Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB63B777D
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222851; cv=pass; b=C0PONXBRXrPBVcq6axaEdZ0mxXRTZURbK667v5bHZ+AfAvSeHxi452tQUrd3wakO4bv8qPp8j5HxaLc1ylJzv8rYjb+UU2z2Fasy4/2ISwd/wIpnzwdixWiY43x5lihRbwqDSnNaEaZp9yGRNj0oas/jtRFGYVJqNrjcTVoV78w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222851; c=relaxed/simple;
	bh=u5aZYLglLR2y0VL5RObQhknUHMYSLmH9b+G9V9Pt0TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIxPfb7Y1vy7bDKBYRJxW7u7R24sfWLDc35dwFV4HSS7nTYU61y77HJkLiAJ9ZgY9YXGChzkVlUY//P75OqpKTo9WH2856QbjtAVHKBS1HTVMYX9qfF6Ze5Vtr7dCUJTRE+wSJl0AuNIYW3KHnBTxCQBESD1LWYnCg5LX0OW+Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SagRcZ8J; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SagRcZ8J"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64fc6b21789so1467956d50.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 06:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775222850; cv=none;
        d=google.com; s=arc-20240605;
        b=M0JSqfhWxrzYPFw2qBkeVKc61kU5pZ4yZ+MYEZWaeqDGFKlPaQ4AvAlmY1mT28IVSV
         xSobrddlFR/sxRXiHCLEQwXrMCY6u1rOvj2XKWZlaBAC1+MOzY8jDZZZSgoOcrSyrlCh
         JcXeK9tbnU1dZHBctVOAcyc/6raCmj0hObtCPTpiL8/UZGD3M8P8WwB8NCg3HLjBAmSF
         W7NuLvfCoY3zXCjBkbyNAfZFoJipQn2f3NG2Rke3PPDF3oBpczKDovLmOEnLLBUrhK6f
         G68rRwk6eOU1GJt9g6MbIpHBhqbvZGwYESZr9B8tzmOJqQKXfp4XX4CHfCnqBclISOku
         s5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5CVFkoDCxGsxXBj8bPmZ7vpSl4MJkw0Z6mvu33ifBL4=;
        fh=LjKN32SXObSovxWeNbKItLFyaeR82dlWrTf1EqS+HaA=;
        b=AShgeUkSXlOPyiTrgl7Ay41CMwL3buFd2OPA7HZA7TGYlYiuvN5fO8YnvFzNABnXSE
         QRyiHzZHqkkUm2x+YjNA3OZQa8Cj2FR2C5lTpw0FJAMGeKzR1zR9LE1V/+vX/8gTfyci
         TzJnWmO3tieoA1tpMwWh97ZCab5MVfDpYG4E5cHt0QeSE8moTdvDUBYDzSpcWuzXxMAN
         Q6I+v48SAXZ9oBp3QUbH3NARdPfe5I7b8G3vyusZUdUf9q2lLGeiaUM3LiT0CFHn2m9Y
         VMo1rz4G6DiU02od3+49dM7jxBpAt7mwbHubadLBp+VE5MRZCpoQlmLzkWYT/TQZ3shT
         PKxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775222850; x=1775827650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CVFkoDCxGsxXBj8bPmZ7vpSl4MJkw0Z6mvu33ifBL4=;
        b=SagRcZ8JiTwqsvgoHBnI6ZtmliRgom9WwP9ARyt4eQJpUXiNmywuCPIWmiUfVsk4n9
         QK/E81CiRNOtX4vwyJvfgNZ9DhZcQmeBJF0Ki8tU4CLvv4k8jaeMcFuOnphkUReyhOvF
         LY9Pl76lAfJgRFIXMGZ1jkyfEIEldbQEE5LLD6L17RBoupok/cxFFIiR3Euu4boB3BEc
         EBNjBSCO7/oxgo1bM12fWj7/8qAR7hT1Sl63CgN+exA6qbUg3DJAT+7/cc/ettTp9FI7
         pb+ylDk8iNV8+llVODWRNNhDvmmgrSpTiVjYp6k02vl12sKI5cepp8h5PhA+tSf+Iam0
         CuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775222850; x=1775827650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5CVFkoDCxGsxXBj8bPmZ7vpSl4MJkw0Z6mvu33ifBL4=;
        b=pMu9pOSO2YEO3xgyn/DrIT8wL1aiMUIHIYrZ/dYBcvE9yWmfapSJkcqr+G1i64zyhB
         //5USgs0Fbw0F1Wa95v/vemDYgTFmzenP/DfFKQXzmaOwb7hJHJb0xADhTT7mnU/rlhR
         sqsF3xBV3rqC6ouwf5hZzBJOYcdszser/ZL99cs1tQyim58YQ5fJd53WlhR1wulXPFXo
         jWw7T/5uhYMWBqQcI9SJgDOvSwzFSSCj+QZMnlLvGS9IZWkF/zcGMRJsSN96fxg07VSm
         il/y9yO9nY0Opy0g993PddQJaVmTxcI7u8RrBDhtHZrnga4jyUby7GCPKipDYWLugoCx
         zALg==
X-Forwarded-Encrypted: i=1; AJvYcCXdP0crQcob+mPNl/1bJ84ebuJ0oQ2wfhnRlBd4oNolQ+o8YpQHs8WmLoczLZ/uLXbAkkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdk0+lURYbOS/kbZR5Id1SaDkvnbp/tz4hrFwk0bTpvHaP58xY
	ef7p885VTsHbW1RSnY1ldRuZ3/AQi2bEnrajz0sAg9+PP3QUHucCnfWudbQxN6npBerkA24Q/J+
	oAYSdFgbMUm2wpOgLYNOLNaRimb01ZKA=
X-Gm-Gg: AeBDieu6k+3883FbsgnZ5Z9m8usiNuU//P3ruuILtl8oaRwvW19AjfIcBpblpOb4OfK
	Qf4WgG9/1oCZpn5uyhoR6LAnHvJTN7hBvZdgfJLiZApQmPkD6eZVMMF6v5SjqgY0w0CNwFL3bxe
	hQ2gW2rMvgUJudTTc6NxqckL3P/QgQG8+qMHBpr7d9soX2JdJgMMx2V2D5soJVDsdr5Ow45R+f6
	FI4jg4s8yAyxVvXbg+QVuipgN6uXUOdK2VwzkDRvOQ8a3kroDdSACol4iC5EqVi51BaoLK5jRHT
	zSBFoWal
X-Received: by 2002:a05:690e:4146:b0:640:cccb:1fd2 with SMTP id
 956f58d0204a3-65048766844mr2643914d50.33.1775222849700; Fri, 03 Apr 2026
 06:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <2261072.irdbgypaU6@7950hx>
 <CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqgeo4C0iA@mail.gmail.com> <3036842.e9J7NaK4W3@7940hx>
In-Reply-To: <3036842.e9J7NaK4W3@7940hx>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 3 Apr 2026 21:26:53 +0800
X-Gm-Features: AQROBzAhqUn0C4z5t47fiWttRpelo5Bwp2NUuCrYH7DZ2fW1KBFq_ETr6BE5IqE
Message-ID: <CALOAHbAx=ne-ByCXF+4ehLYX9+3a5BDjHyUn=owmEJNBFXOthg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] trace: Allow kprobes to override livepatched functions
To: Menglong Dong <menglong.dong@linux.dev>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 6:26=E2=80=AFPM Menglong Dong <menglong.dong@linux.d=
ev> wrote:
>
> On 2026/4/2 21:20 Yafang Shao <laoar.shao@gmail.com> write:
> > On Thu, Apr 2, 2026 at 8:48=E2=80=AFPM Menglong Dong <menglong.dong@lin=
ux.dev> wrote:
> > >
> > > On 2026/4/2 17:26, Yafang Shao wrote:
> > > > Introduce the ability for kprobes to override the return values of
> > > > functions that have been livepatched. This functionality is guarded=
 by the
> > > > CONFIG_KPROBE_OVERRIDE_KLP_FUNC configuration option.
> > >
> > > Hi, Yafang. This is a interesting idea.
> > >
> [...]
> >
> > +/* noclone to avoid bond_get_slave_hook.constprop.0 */
> > +__attribute__((__noclone__, __noinline__))
> > +int bond_get_slave_hook(struct sk_buff *skb, u32 hash, unsigned int co=
unt)
> > +{
> > +       return -1;
> > +}
>
> Hi, yafang.
>
> I see what you mean now. So you want to allow BPF program override
> the return of all the kernel functions in a KLP module.
>
> I think the security problem is a big issue. Image that we have a KLP
> in our environment. Any users can crash the kernel by hook a BPF
> program on it with the calling of bpf_override_write().

This feature is guarded by the CONFIG_KPROBE_OVERRIDE_KLP_FUNC
configuration option, which is disabled by default. Consequently, the
user must explicitly enable this option to utilize the feature.

>
> What's more, this is a little weird for me. If we allow to use bpf_overri=
de_return()
> for the kernel functions in a KLP, why not we allow it in a common kernel
> module, as KLP is a kind of kernel module. Then, why not we allow to
> use it for all the kernel functions?

By leveraging KLP, we can rapidly deploy new features without
interrupting production workloads. Accordingly, this feature is
specifically targeted at KLP-patched functions to maintain that
seamless delivery model.

>
> Can we mark the "bond_get_slave_hook" with ALLOW_ERROR_INJECTION() in
> your example? Then we can override its return directly. This is a more
> reasonable for me. With ALLOW_ERROR_INJECTION(), we are telling people th=
at
> anyone can modify the return of this function safely.

It is unfortunate that ALLOW_ERROR_INJECTION() is incompatible with
KLP-patched functions, as this limits our ability to perform fault
injection on livepatched code

>
> WDYT?
>
> BTW, this is a BPF modification, so maybe we can use "bpf: xxx" for the t=
itle
> of this patch. Then, the BPF maintainers can notice this patch ;)

I agree with the suggestion. I will update the subject prefix to
"trace, bpf:" in the next version.

--=20
Regards
Yafang

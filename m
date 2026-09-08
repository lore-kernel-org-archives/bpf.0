Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564172931EF
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881803; cv=pass; b=pzeZ/32IAoW4HpLVMpLJMmL2g0l0fXI2L9lKcGAt78kUsMzFjaGuJ8LylfJtvPjsze1aHz/PXIRM+LR/i/DX9xSb+fgxQVFkPMXt6iyglv7mzb0JtvNDWp45eE7qLMacFC2mWqq0g/ZtDaCmJCJj/RN2UwtFfwQwhdXDFTGzZN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881803; c=relaxed/simple;
	bh=qv5CqAwUxGe/iJwgzvl6/jdT2pRBccudl+MNJGYvjwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzNAcEO7oTS/hCmHDvZaW8PvS+8kC64dzPvhJOSJDVpZYlSP0xYHNDdFMT4qjXYSZiUzMivwLY59OktmMHbptnWSYb4xeVcZYhk4fBbqil3S3+Mw17Gv0egqhKxXns1aUKwSFnDYWQo1H3gGGjjjW1IEyBHdJ2dlQYGlIgWdL90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZYqLaX5; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZYqLaX5"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae54so109288a12.3
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 08:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788881795; cv=none;
        d=google.com; s=arc-20260327;
        b=jy8kmj1tr/pAXP3/kz7WaybTALYdMP42TXfDuIVi++wXWIhmcjzB0D1Ht6zyNJe8XA
         o1FufkSCx08O70GA9qnqdDpa2dw+cx7mzivcJgtHszcYebbprczFH1RqDWkU+a5G2bzy
         iLRa275aCVZgXwYMscMfY4UrmbJcSnlZBOIykyRzXhturYAkkLNY+CMEimyPCnfe4iht
         O96vHo5bwnwdmjBtsM/tFkQX9bNXgN6A6LI7bqJImqKc/52KwIb4sZRv9bJzvoqurqUL
         uZyLS7pjyBmxW0c1ngTwOUbU490sfEMuCopgUJWp+7Smzp2Ii+sZbyewP0JCVMXv40Qd
         YBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S8FzMS8SqyHbEwR/vnXKxYqgMS5+hpscCzqtpdIcwKA=;
        fh=2bHbQh3izpVpNg70x6ZpNfMlpsGwRM6Qp+4yTyuAW/4=;
        b=fWjYixGPj03D9vSqN6mCBbtJNj4YTa0rLFoP0+cqZ7NfqPzfcF09XwbFyJaf1U8lTT
         WpnqRULBCBnS+1wRetMbbscZ67VGKRTVCZzHyorE2kzBKILHOWuvoVC03BFPgOxblwQw
         N8YTYxePz81T3yA/abDM1TZvmHEF51OS7BefB2g+vvIKDOt9eesZb3GMXj+22Yk38A1f
         Ubgp5rV1cYGINguZ9WWpPOmn0O28NB6ePP7aRkjfNAAw6K6Ne3c45oPRNFi/9Qtr82Xy
         uHVlFkXdYVfp676yuh3zhUmM4XPM+pymr8m1ws1ivZY51+h54y9ZeRrsUIkvkrzm3QEm
         PhpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788881795; x=1789486595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S8FzMS8SqyHbEwR/vnXKxYqgMS5+hpscCzqtpdIcwKA=;
        b=nZYqLaX5BXCpimJ5YPSSNzwd7qXrNrxmBbj9qM4TK+XzEI8Rtbu7j4KODLUyfpvccK
         XVJAxKw6Z/8Cnmgm4mx+vkHBbqDp/BAMPbpfaQZsGb53qnxhK7le1nTsK1reaqFZAAC5
         c+3SSlVdGlF4w9o905ACadgpB0Cpat3FmP5taLwdFKHhtf8RQGmjrs4sDJp8ZK0TxcuR
         fDue5lLygKI81g/Ha7XxA6sCTNCCSHnhurRb4O0/KTRYmicKDLCCxpMGPyL+AhvF8CfR
         Xu3wzVEeQnejMG9aKdS6qBm3BJe0JDmFgo43q0IxkY0GNiROXX3TJoxEA0oljdEMw7OI
         g4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881795; x=1789486595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S8FzMS8SqyHbEwR/vnXKxYqgMS5+hpscCzqtpdIcwKA=;
        b=POTy0da/LlUDLirWFuH7RveEmcDLk1dRm444ft1z2zG8XTZzzwFHDnyQ9dra/8zBu+
         /ItpZwNdPoFq6RL4/jZPM7Wq7MhvV69mucELyzAAFsQHknbi7qsQ12lJgwVX69xABFRj
         UV8ilof4zOwnvmML0C8xHtDxeKKYi7G9OBwaR0XbOdMqy7zLOe0OnVAWdSTMPWHBw2FP
         v5qDOobEGw1xM3Dl843hNwyfxdLWCx8GdxuCDMzE4kaPRv/Urnu9Bpj9ZLnOAQ9SR3/1
         DchAAicfRtqiLc5KYSz1VAx/d9972pTZzg8+r3o4pOdDdBI+ob2ht0og/DHMKVNvEfPO
         19gw==
X-Forwarded-Encrypted: i=1; AKwUvByx6tmUk4z48hthHQ3ZtgrXI8ee397/4LDeOd8DluS4ukiBMIN7HXVfSYVThtgK02GbadA=@vger.kernel.org
X-Gm-Message-State: AFuF++nRp/LuxUkBrDPNUKvYGXJuBH87HQYsgs+6AdSGjHy2yZi7q9rK
	mJyWB3NbDQfrKjzUUva8n0fN8hWXBC8dbl6jkx/LxUz5I0drmx8MB7CnWt/VWJS7n4GLDwuPhcr
	kaAlpGX/9xdgXsq9q4ao3IWAHko0K60s=
X-Gm-Gg: AYBFou1i1P8nVm0w8LJbU/jqvtuC8ByZO5CVVopRQdW4qr9QRjmBh9/Z5wOk/DCibca
	nww22RH28TS3rWGEtYZ/mxVLZYvohFgbE7eAAH8ysRfg41/RMzdiLFtsHiK/AZEd+d+5Xv4VU7n
	N6gfzBoz/TCVEDmb7cpUhU+sPxCMuC4zf/AlVzAkejcXVOlAZhLbDYTmXEyoc12XTKIkxK7S/TH
	XwfqODfJpMILUvJStnw3nPw7j4592F0G94rSbVRVHd7UfLRRUYLQybr7bRfF/JBl0qX5ytFyFYf
	l02edaAkj/UjL+om1H4i1tcV2iEXYhbZ62sP26Z46rNL+SdqCMq+qRH5GwuZ9zo8jYzwYgbZHuz
	xhQ==
X-Received: by 2002:a17:907:3f9c:b0:c25:c979:e76a with SMTP id
 a640c23a62f3a-c292b1dfb94mr62951066b.22.1788881794799; Tue, 08 Sep 2026
 08:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907192129.557377-2-bestswngs@gmail.com> <DL9COXZQXX4V.1FN45QO2Q77ZH@gmail.com>
In-Reply-To: <DL9COXZQXX4V.1FN45QO2Q77ZH@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Tue, 8 Sep 2026 23:35:58 +0800
X-Gm-Features: AcwNN1Xx6MilZKeliQoX9rpQOnWJ-qcSuSLe7P-XiShCEHYGUlHmCV_1KNJCP8E
Message-ID: <CANgPUi21BF7yAVGhb83sikiK96KE02X_JbVWL=OxXqWOc9uXbw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: refresh seg6local SRH pointer after skb pull
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+adfca3e91be95776@bugs.sh, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2026=E5=B9=B49=
=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C 04:02=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon Sep 7, 2026 at 12:21 PM PDT, Weiming Shi wrote:
> > An LWT_SEG6LOCAL program can invalidate its cached SRH with
> > bpf_lwt_seg6_adjust_srh() and then call bpf_skb_pull_data(). The latter
> > may reallocate skb->head, leaving the per-CPU SRH pointer dangling.
> > Post-program SRH validation then writes through that pointer.
> >
> > BUG: KASAN: slab-use-after-free in seg6_bpf_has_valid_srh (net/ipv6/seg=
6_local.c:1411)
> > Write of size 1
> >  seg6_bpf_has_valid_srh (net/ipv6/seg6_local.c:1411)
> >  input_action_end_bpf (net/ipv6/seg6_local.c:1463)
> >  seg6_local_input_core (net/ipv6/seg6_local.c:1630)
> >  seg6_local_input (net/ipv6/seg6_local.c:1639)
> >  lwtunnel_input (net/core/lwtunnel.c:466)
> >  ipv6_rcv (net/ipv6/ip6_input.c:351)
> >
> > Give LWT_SEG6LOCAL its own bpf_skb_pull_data() implementation. Save
> > the cached SRH offset before the skb operation and rebuild the pointer
> > from the current skb->data afterwards. Since pulling data can replace
> > storage but does not change packet layout, this preserves the identity
> > of the cached SRH even when multiple Routing Headers are present.
> >
> > Refresh the pointer even on error because __pskb_pull_tail() can replac=
e
> > the head before a later step fails. Preserve the pending hdrlen and val=
id
> > state so SRH validation semantics remain unchanged.
> >
> > Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")
> > Reported-by: co+adfca3e91be95776@bugs.sh
> > Closes: https://lore.kernel.org/all/GCy0KRM2IcQGoJQTjJEU9D0maBxXzEDHuQp=
q@bugs.sh/
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:gpt-5
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  net/core/filter.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 61940e7535523..e61f9e9226b10 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -7162,6 +7162,32 @@ static const struct bpf_func_proto bpf_lwt_seg6_=
adjust_srh_proto =3D {
> >       .arg2_type      =3D ARG_ANYTHING,
> >       .arg3_type      =3D ARG_ANYTHING,
> >  };
> > +
> > +BPF_CALL_2(bpf_lwt_seg6_pull_data, struct sk_buff *, skb, u32, len)
> > +{
> > +     struct seg6_bpf_srh_state *srh_state =3D
> > +             this_cpu_ptr(&seg6_bpf_srh_states);
> > +     unsigned int srhoff;
> > +     int ret;
> > +
> > +     lockdep_assert_held(&srh_state->bh_lock);
> > +     if (!srh_state->srh)
> > +             return ____bpf_skb_pull_data(skb, len);
> > +
> > +     srhoff =3D (unsigned char *)srh_state->srh - skb->data;
> > +     ret =3D ____bpf_skb_pull_data(skb, len);
> > +     srh_state->srh =3D (struct ipv6_sr_hdr *)(skb->data + srhoff);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct bpf_func_proto bpf_lwt_seg6_pull_data_proto =3D {
> > +     .func           =3D bpf_lwt_seg6_pull_data,
> > +     .gpl_only       =3D false,
> > +     .ret_type       =3D RET_INTEGER,
> > +     .arg1_type      =3D ARG_PTR_TO_CTX,
> > +     .arg2_type      =3D ARG_ANYTHING,
> > +};
> >  #endif /* CONFIG_IPV6_SEG6_BPF */
> >
> >  #ifdef CONFIG_INET
> > @@ -9052,6 +9078,8 @@ lwt_seg6local_func_proto(enum bpf_func_id func_id=
, const struct bpf_prog *prog)
> >               return &bpf_lwt_seg6_action_proto;
> >       case BPF_FUNC_lwt_seg6_adjust_srh:
> >               return &bpf_lwt_seg6_adjust_srh_proto;
> > +     case BPF_FUNC_skb_pull_data:
> > +             return &bpf_lwt_seg6_pull_data_proto;
>
> Instead of adding new support that no one will use, just disallow this he=
lper from lwt_seg6.
>
> pw-bot: cr

Thanks for the review. I will incorporate your feedback and send v2.

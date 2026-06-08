Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2253A1A29
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952139; cv=pass; b=VwdF/0pHDT+IlTgpswU8erYb7tNC5MkS/IuTQEuRa84Rm+2ij8do315BamJz7PvGQGp0VFKW9Hq58OxvpBtLWQhcHnkRKxSEERdcSp+ncMeYDp/GC1PR945aDKgkxNYUcQaZlGQ4L4Z96xNBkNkjiIOciBxjerh660/fzb+8hhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952139; c=relaxed/simple;
	bh=bGtzFFBnoXEhZVNSTDAVHXSCy3yikKw674g7i910kvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ie3fnNX8KdB0LmsclquGQRn/rvqBcguNcWSCU9nodBdNXVhVr2sF3ssC60CbGz5D4s7ykSmXPAwrWppxF5YROUcRFBMjJXMsGAnPSVPi9O+kn97Kaxo46f0WM1R4vIAxKiAbW3Le3STQcvo1wflSoncCq0RoLwpvl2XlEKf+V9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2QqLDp9; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2QqLDp9"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1363fe80fe8so6879243c88.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 13:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780952138; cv=none;
        d=google.com; s=arc-20240605;
        b=VuS61kD4uxSz3cDsU2sOvGX3BqX2fkiwMn/JZ7x7IEcVgckmMBSo6q6BspTW6YP/Qh
         wXJiZZlNIhBKVTIwVJETZb5sE5UvM0TmorqtA85Buw8UxzaE0OOAHkWyE+DrmyAFCuq6
         UyPWXDywng0/DSfSPNECTYKBPJ+z5qabgpDwyJrCqGY1VFKYSu09EsIqRN4aO7xYoP2d
         dLQpevqd49Ix3px+VFQ3r9SLLCnnIbdDkMakJWZ1GgIIkg9Ph/cQlISqPf363XjTaT8Y
         nrgekS+8CwqPqCvuKw/9HDx3FP58UUH72Iz1Z6bqJxgQUu83Au8i82ZZ0clHRfD0A2NC
         9Q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cj99u35GkuQHW83anj+PxNMaqIiv5iTy7TcOXLK7r+Y=;
        fh=s/D//a37UxGmcRuatuotOWrpCdAR/GWQRPP+nU7FiFI=;
        b=j6X9dCDWrJIvt2e/Ef+5AVmfy4BI6BLPSPIlMBcZgVtGoaWJ8g0o72jESWoBGQMbSw
         81faz0KSKk9DNg2xHrXSHxzEVkYuFlWgOoHnbj7I45hoqwCIdmCyS50PxFszZGzk0lL1
         wjgfYlxAQisyQLY3vxjvMnAdWeVyk6TUSHPakxDSx3sHBYKXXNXx6ZIGckIGYcn80qY2
         dHE3WUelup9g+zlNm32m73HiLPsK3gEkJ8JKndk0dqRWUAKwH47opG6/OgCNWRq8z4Hh
         IsYnjKyk+SbI7IQqHmtU9yXG6Kp1DA7CqgeUB4Mr5ujnLnbPM6PhJ6iOJ2CCVtligKaB
         GKpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780952138; x=1781556938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj99u35GkuQHW83anj+PxNMaqIiv5iTy7TcOXLK7r+Y=;
        b=s2QqLDp9XrrWOGmFJ1MKZT1i60QMzpv5ZpxkPwapPijH56t6sLElVNYhpagFn4tHhW
         qDZQ02PjzDY+FtkwsSDmLNFSjnM3hLM/Q287EAJ/T6xU70EjB+MYhib9sP60ho4WKeWF
         eVADLhMM2TrOgM2Th8VfqZ5xmrKaEMH2cLPOY19nhnpBQYL5J3DRZPubvIe8mGArNdsd
         2a8SVRSdzy72XgUTQgv4Hn/sB5nTBC5qrDBjQN5U3rwD6QDeGstnQpZP06RsOK4O4Q0j
         mnryWYSwQ5cuTcw9ZOYYenuHZH9JT2eHlY2lYUlowwWcuTAGb//PRZlpWg/xyzOUmhV3
         1GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952138; x=1781556938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cj99u35GkuQHW83anj+PxNMaqIiv5iTy7TcOXLK7r+Y=;
        b=dhH/GJAp57FE/j905F9mIksrBcRctI+dTvq8HyVXw7yxJEb4urGdVlTDYtsz0yfiCt
         yHRo8AxPUJicFUOCabVQArqsGAE04Cc7QrM/0LIuFTl41GoZGzEz6GoaT/Qe3t3U7nSK
         lk6+djYeRog8Nts6bFB6Y/zzzyDaunvXBt2yFkUv1sSfC9AgVhmkx21kWwmfz6iy3wTG
         FykE7G8+E+dXprGkhHU7iFWDE0hINbOYHmN/1bUpEMET9aYpizBf5auZB0zLoSey20ko
         yGr4ne/1O3mNG4STEdQLKtx/MkQ7MRurE1HxMhUnTP9c4QXRkLeDgNsECEwWu57X7cF/
         l5WQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QA3m/gv075kZJys7Ti1kanMAmM0KZLMnlSPUKRZDaP1eoVNq+R2FV5PBtFLQDgIOx7CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXjf6Kl0qj9/NdIgJtngcU+QXHK9aTrb1r23HMEPufyGsnpGi9
	iWH/VLToH8CRTG50RDk4Vw89nUt/QMqGmWMN5QjqQ/TGLA93E3auyTejkNev4P+jaVyiYilTHB/
	k/sk+k8b+E+6iBrAWowVT/DnX5jeYUeznzJ8REwI/
X-Gm-Gg: Acq92OGh2YMzEwH0TZ1bZBfvbt3FDl9VTnn/IRU8Xtl34HmryqbchXg2ejqhAOldNx9
	aoyDVTfxOZnz230PKaJNDRcionXc6fc7BI8FpGlf4z5YbHY6k6RV0ztpBVGqedfjMDfwBR0P+j4
	wl12AxtQemycIjfSOCA984BKqMF2nbefTDYN2NWFqnfD1xALEqiP5pWKwtxvV0f1Vz0K4bp496F
	w/W/m/mHqLJKRfgtPibpykYFdnwYvYhqim6qWn/ji8TVxOd8ALVfkUjgAy9yKKJpnhMi/7NxNtS
	QkxJAew+Yhm3x+zP1hTdPi8l8yh1Znc4fUE5Lcnbsg7EjweUv/RMg8s9Ty6t6RLp3Uwo9oZozEG
	ksSy8LkP9rV3qpoqCCBfLtYzXg08iFpC/c4ZcmaZ0D0YudHj3vZ0ZrQK8+U6X2huzR3oWUpU=
X-Received: by 2002:a05:7022:fb04:b0:138:51c:c5bf with SMTP id
 a92af1059eb24-138066c6ab3mr8922615c88.15.1780952136864; Mon, 08 Jun 2026
 13:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev> <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
 <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com>
In-Reply-To: <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Jun 2026 13:55:25 -0700
X-Gm-Features: AVVi8CfcOCPt_p28nph01Kh8d_ahK1oBr_59XCUgMmWvjwIoHLnnauWUude20WM
Message-ID: <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Joe Stringer <joe@wand.net.nz>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:02=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon Jun 8, 2026 at 10:21 AM PDT, Kuniyuki Iwashima wrote:
> > On Mon, Jun 8, 2026 at 5:59=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux=
.dev> wrote:
> >>
> >> bpf_sk_assign_tcp_reqsk() can assign a TCP reqsk to a non-TCP skb,
> >> causing a panic when the skb enters the wrong L4 receive path [1].
> >> An initial attempt tried to fix this in the BPF helper by checking
> >> iph->protocol, but Sashiko [2] revealed that BPF programs can bypass
> >> this check via a TOCTOU attack by modifying iph->protocol around the
> >> call:
> >>
> >>     iph->protocol =3D IPPROTO_TCP;
> >>     bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
> >>     iph->protocol =3D IPPROTO_UDP;
> >>
> >> Furthermore, bpf_sk_assign() has had the same class of vulnerability
> >> since its introduction =E2=80=94 it can assign any socket type to any =
skb
> >> without protocol validation.  Since the BPF helper check alone cannot
> >> prevent a malicious BPF program from crashing the kernel, add protocol
> >
> > I'm curious about the BPF maintainers' stance on this kind of "bug"
> > where admin tries to shoot oneself in the foot.
> >
> > I saw Alexei said this recently, and I guess it applies here as well ?
> > https://lore.kernel.org/bpf/CAADnVQLh7VEKAtckzz=3DXOVPT8ovpDQshvPPCWHDQ=
u2OWQx27_w@mail.gmail.com/
> >
> > ---8<---
> > Not every "bug" needs a fix.
> > If a malicious bpf user wants to crash the kernel they will
> > find a way to do so. Especially with agents.
> > We cannot realistically close all of the holes.
> > Right now the priority is to fix the issues that normal
> > users can hit and not bots.
> > ---8<---
>
> In addition to that I have to add that skb_steal_sock() is performance
> critical path of networking stack. Adding runtime overheard there
> because bots can find a way to abuse the interfaces is not a good trade o=
ff.
> If there is no simple way to fix it completely on the bpf side
> then we have to flag this issue as "won't fix" and move on.

I asked if we could fix this in the verifier but it seems difficult. [0]
Since this is triggered only by BPF misuse, treating it as "won't fix"
makes more sense to me.

[0]: https://lore.kernel.org/all/202648182730.i4ki.martin.lau@linux.dev/

Thanks

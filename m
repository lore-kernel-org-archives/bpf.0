Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A367337110
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775587273; cv=pass; b=bkNcLyNdh3xZCwKnsl+JYOLylvuYl6iIcRWIpxhZUqWQHPXgAGgZA2Q1YrXWBL9uBAExFaGiLSge30ddbcqkykUGm3h9iMhouDqNGVoX1r/0CbwIcgMQEmI3x/ipxQDeksSXG+oBRWnmFWiD9xy1I0xsKkVUE2HqkWiC3I66YO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775587273; c=relaxed/simple;
	bh=KZCDfzIeZ9MXyD9zphyFKr1/BkcZ0XXimcy7WGnXtA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noVNSTZrsn09VEYWd7poN9eamDXtqqB7LnwiQU+33EYEo+mEFlLFbbs0NEyTQN+Qu8tWM8v8VSb6H6xCtC+ZrYoehP5x7DcEvCFW+mdwbaE3JKUjxpFwarJrejZczngWmb3f2UrzQ3fmKH5Smf8j6cqB9etb1CkxNvs2iOVNg0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUAaRPdB; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUAaRPdB"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so1988a12.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 11:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775587270; cv=none;
        d=google.com; s=arc-20240605;
        b=EL15/SXvL0LCC3yxV4rcocrrDTz8Y2z2dYUeadoirr+/zwNbAhjSxA0JLlzzZN4GZ+
         OpHDtqPtNFywLBseoLKZdRBvsjA1NroHyOGJmz5qPOdzWef1q0ktqISPPRcty8W+4V4O
         Y+0u4aFLofTukyz0dbw0RJ3upM6EH3l1gCl4xIncJyX9eqYv38zZ/e+uDD606rkt7xkG
         cIlUwyeOjXI/x1HPzrSpZdVj2B5FzA6RI7vgBAT7d/pqw0hoCdpaWucAlqdcA+fCkmHT
         iyq4S+TgmkHt1oiexrwt+c10hZukSn0wko4hHl2PrLGsek+vZ7NZ7UCN1dUgchrvvsx9
         4C2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KZCDfzIeZ9MXyD9zphyFKr1/BkcZ0XXimcy7WGnXtA8=;
        fh=v6Rbt+UdQHb2Q4TeP88WMzN2Z3oBs2WPIP9PeimSEQM=;
        b=fRrUR6Tm5h0XMLGK5U4lca7U1cGuCGeh1sA0KpGFGoOD9GBAGGldwLBV5Qttpd/m/5
         w8qxsVNOQNIDrckeL2xlmerpP2mhn9XMW8X6mQGz4/5vXcXx4N+o4CNDDOwESloISqka
         4xmiex5Y9gNlNDvad4Iis2iqNXKyrLrXrTulw61v0qCyQtA0mMvCF8JqxO5Lfhhlx4Sj
         GICPjyeG7PhcqOdc1N/mq2jZCa77aODdMx9iR+gomfVZMkiptRgVUND+ii4/phm/Zees
         xMqlc8jRtU2l0O9fR68G+8rAASGPj2KWbC8s1C/njm34ogQve6dLEVLESOL/QANTHOW9
         GExQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775587270; x=1776192070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZCDfzIeZ9MXyD9zphyFKr1/BkcZ0XXimcy7WGnXtA8=;
        b=DUAaRPdBnrNLOhCS9+edF+j0ec+XQt3UzjdvTP3IF2wUtvnWewBDIfOG8A4asaM+gh
         Dp41Ia2yX8jvR1laMzMOzJE892sj0Si+EBIxA7qXW9mxytxolpmTAi7Yc7kuE9/kyQue
         GkUynP1fUve4u+LXuM0vIRnANGjEXgQKUOKqlLv1q+ei2VNbmDYA+vj6dz/b3S2y9cVZ
         5VCPpV4WzeVuK0R0iVsFKuDpV+LUgS8XU9jIjUQYdzIgAUneynnF8O2zqj0Ki0eDusAe
         eQR/gHaAWMNOSwT5ZB1YwCqDvn/njJ1a67122OHZfb+kQnrgN9vdaQyvy8oVcvgiqqST
         t9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775587270; x=1776192070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KZCDfzIeZ9MXyD9zphyFKr1/BkcZ0XXimcy7WGnXtA8=;
        b=CsGCCAAsgCA0/gl/kA1vSZmx7DRF4cE7gCRuOaZQ+K6jvfYI7bVRZDP/hGSm3yg/T5
         5YXKQynBoFwIEuWrOtfjcLH2cgQNfJhkEzdlefHWKDUcBqyZnG4EvNCCwQsBsvijqFF0
         r19F06ba9iXhKPD2tb+1YS4ZJVDqNxAZq7a7UOSzOuS4TYTviQbXOfay/nQRE1AOFO55
         ZYydnNd7C9B/HyGlJsLEo8FUxtZ/J4CPU2vsPnPHO1bfCNWnWakfVhfKYNOkH4P9z/la
         XMtscd8BLpK0eVIIKkEFElPEfnIaWciYQk5yNIxQkJfaJxgGPG7WM5igd3wfdYKUmils
         VwtA==
X-Forwarded-Encrypted: i=1; AJvYcCWW3ogvc5GqD6K+F0KE1d50j/P6tKLNsC9Ij9FpBYxeJR79udQGBlA3bGOgSo2u4jvjSto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDdv7eL0Bie+T14/MYuPLY0n+Wh2a9QzfJJQLBH4fF6Au7wk4s
	7/JiyYh7YYpWuzPvEQlaVYrcVQzt1TyR/ZvxFQQZeikE+QHE8Fum/vGjizmEh/G7o4LOWcFhxUx
	nabZHf4Cn5VQxF0Fv3yRJ4Bo1YnFpklUCkf2s2eMx
X-Gm-Gg: AeBDiesEg/qQDG0paGyJ/s2C00AlHy9LIktAdi7gM9K1s+1VggbBgeVvzUinonrjpWR
	VT6W0y1VBCQLzi9bKQNKEj9cYvAtwRaFho/u8mXZ00XKBMBlQT6Qy/ODkIs8LBWZT/Y7RQP8nvv
	WwirqlPTELIY+RL0IA8893TuHXHDU2NAswKTHg70NFWujgHbroNcVa+cXRegRZ2Kqojm74Fvq/w
	+JX8qIhVtBoneVUSwe2NhcQp1WaiyXmDEURtrv1W4SSj/0C/aubdmj06bWYg+/SowwrX/lJQ0+O
	6wCz32k=
X-Received: by 2002:a05:6402:a0da:10b0:661:f987:357b with SMTP id
 4fb4d7f45d1cf-66e415a1e4bmr147625a12.14.1775587269433; Tue, 07 Apr 2026
 11:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403231608.zopnhnypdclzqlx7@desk> <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk> <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk> <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk> <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <20260407171151.2gf2idjbmph35ypb@desk>
In-Reply-To: <20260407171151.2gf2idjbmph35ypb@desk>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 11:40:57 -0700
X-Gm-Features: AQROBzCt9Ys4MdyKd8Tqk8kV948jbOd6itImLNrx4CMkmInZ0JBSW_3PRIdD-Y8
Message-ID: <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:12=E2=80=AFAM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Tue, Apr 07, 2026 at 09:46:07AM -0700, Jim Mattson wrote:
> > On Tue, Apr 7, 2026 at 9:40=E2=80=AFAM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > On Mon, Apr 06, 2026 at 07:23:25AM -0700, Jim Mattson wrote:
> > > > Yes, but the guest needs a way to determine whether the hypervisor
> > > > will do what's necessary to make the short sequence effective. And,=
 in
> > > > particular, no KVM hypervisor today is prepared to do that.
> > > >
> > > > When running under a hypervisor, without BHI_CTRL and without any
> > > > evidence to the contrary, the guest must assume that the longer
> > > > sequence is necessary. At the very least, we need a CPUID or MSR bi=
t
> > > > that says, "the short BHB clearing sequence is adequate for this
> > > > vCPU."
> > >
> > > After discussing this internally, the consensus is that the best path
> > > forward is to add virtual SPEC_CTRL support to KVM, which also aligns=
 with
> > > Intel's guidance. In the long term, virtual SPEC_CTRL can benefit fut=
ure
> > > mitigations as well. As with many other mitigations (e.g. microcode),=
 the
> > > guest would rely on the host to enforce the appropriate protections.
> >
> > I don't think it's reasonable for the guest to rely on a future
> > implementation to enforce the appropriate protections.
> >
> > This is already a problem today. If a guest sees that BHI_CTRL is
> > unavailable, it will deploy the short BHB clearing sequence and
> > declare that the vulnerability is mitigated. That isn't true if the
> > guest is running on Alder Lake or newer.
>
> In any case, there is a change required in the kernel either for the gues=
t
> or the host, they both are future implementations. Why not implement the
> one that is more future proof.

There will always be old hypervisors. True future-proofing requires
that the guest be able to distinguish an old hypervisor from a new
one.

My proposal is as follows:

1. The (advanced) hypervisor can advertise to the guest (via CPUID bit
or MSR bit) that the short BHB clearing sequence is adequate. This may
mean either that the VM will only be hosted on pre-Alder Lake hardware
or that the hypervisor will set BHI_DIS_S behind the back of the
guest. Presumably, this bit would not be reported if BHI_CTRL is
advertised to the guest.
2. If the guest sees this bit, then it can use the short sequence. If
it doesn't see this bit, it must use the long sequence.

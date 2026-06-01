Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974ED3DA5C0
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328013; cv=pass; b=iUTlBj8QxZyPUODIT8NHNJi2cnxa6pDzF1CTZ+uQI5nlUT0mCDG4Vzva7sI7odGqPHprJgDQzSMHtB3FBoeNXi+i+Mos8qbun/KvM75nTN8RnuMnBm4eESjWfzZnmlYQVvAjwJL1jMExHPB89cPQzhEDDVyj89PArtngk+FQC6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328013; c=relaxed/simple;
	bh=1PTgAlGAK5hfN4DJNf5K5bRNhI988IdyaMltcAq4Eyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ8F8fTodoTyzco4QzzD0okVMA40drcGVgpj/Zrv5dVr6vBiJXoODctYeU3WvdvXrIzwltcw5JCKJb/hckvg8XjlVinekGabpUddguQxFTHIbUhJsJHQGFRbVDLKg/39TggDeHT10n31Hw8/4fWm8XsVUiRhdg/ZU8/bnxanW88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAjDP/ao; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAjDP/ao"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-91563382bcfso101059985a.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 08:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780328008; cv=none;
        d=google.com; s=arc-20240605;
        b=AhhrsXKjttC/U6UOlehImR9Bkxmvtw5wi1N9PjrCTw2Xqd756BXmuw3nZUDyKMYs6W
         djwCLgKG5Ha65Qn9Xf2GXijjQ+LpSpSbrogBKUL14xs/ahBRlJBXsrS86Ot9I8Q8//0d
         hX7wRuITtxcJhZRLT7PgLL8CJZIqHK8KgIN0BKmGD9dar5omLw9wsSEi0ab9rho+vXCm
         G7d0oqu5qEMm7SnRCB9H1ugZ4wzL3fGj5TA0of34JTUuC+Z+dfnO9MxXug+JiMEUARzH
         sja2XSnuIEmEfkbKGVWAw4I2TzEniZGKPsJZALHsXMtOwDslKHi3IzEDLnFYr2bA7SgF
         OcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UbQdOtpzUbEPtjqvjWcm+pIPF3+/nTAYsHR+hxfI1fk=;
        fh=Ppwz4RUpJPJA6Jd2kTXI/EHd0RuQbqr7BnbEdTA1Qgw=;
        b=fBTuXtLAcoz2IQATqCjIrFGfxzXpdTXFgx5/ZgLVIwp03lGrWzNY4nTzjIAIVF/4u3
         tIxNo7k0UdLbi0mWq9kXhRWioND/O8p0RjnuUyrr8DMej/NBTnNbdPQQST0zuX8A+YLZ
         mFb3vmcxcq08nhPVxr9h8o1rZ6YAiCDc+coacnTue0WMVXmHr48rtzfkj6kTMtj04kpf
         fM98NO32IvOuBrdGPrzvWHX4PiQZ/j0ZZn+Uz/kX8OTiKFEiP/bycLt54Wa1QNU689J/
         BU1eTbhnjI5z3Q7TYUx+b5/rQXPhmkpLM/AuwpxU92S1dhnnkczm6WlHiB+rk3gdZLDI
         pgSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780328008; x=1780932808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbQdOtpzUbEPtjqvjWcm+pIPF3+/nTAYsHR+hxfI1fk=;
        b=bAjDP/aoYXAEcC1ZQFFf5xeSZFT/zNbLTYWPei5d7l8S95mB3hYyMJog3ou6gukxQZ
         FH2ik6UGPPDQlSYcBmG3iAsjuFO29Cumu3aFg/sncAKtGKW3nFxIP/U5kkchXG9nimvW
         Dnv9nutSBTHU0Kxt0seQaEuvFvIuWvZ8GIVsxYrRhbacm299FwoyCPe2aqiRtDvC4qdQ
         fmP/DfY54RTyrgwhpNUAEG19lFij9HAbitpfLfYjujN8CNJMdNb10ERVslvt3TDchcpJ
         4vbrs8nzdso0oxLbDnxKyC2aaIrpHOddrJrcaWEJczXa5bYl5lt5xSz9OPsA8jHZGSZN
         0gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328008; x=1780932808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbQdOtpzUbEPtjqvjWcm+pIPF3+/nTAYsHR+hxfI1fk=;
        b=lUA/4lR7AJhIbMRfvJOeb0/aYQ86S2BQtmMVqGkufvDfCx/vDaIEilGPGKGvLAbFmz
         /vhurqn2C3+GelWfCU5K3I+XrWLsXhVOLhecTll4cCKrA5McoukzPk+yn1qXfdopayQC
         j8IxLz1Dyf8KdEsACAvMx7es9/XiKNWaIJAAH1FMxP70QklQoZSa7QI/4GweyuZrxPOK
         nA9eUBXXiaIlevuqTsZLVsH0tu6ZIK36uLatnVlce+QtWSOAlNptxyJXy6AA1JGBhErY
         xscswUy3OEq4Tis2p8DbRYLP/2kUc850FCjZT61T8NXOWwB5E0AAJRTCqReyUlhRQ+0g
         6pzA==
X-Gm-Message-State: AOJu0YxQ198r1ynDp9sIgBOBj/9BBC3Y5GkRKhJfTNmAxKhN4Vn509sF
	MEmyw/nheeVu49y3yKE6hb+aOFaXfzAWIpJPyz9lNgM07/8Tg61SbtMoclUsYrNtdhDRuu+mY6w
	ShRwGENjbKzkGczaLz5mHvZsW/B766zaD304jqWAZ
X-Gm-Gg: Acq92OFud83dWqI9MbPcWGNRi+rI5THGzUupb5i4D+VwhJWEmHhiExx4lY+R2j4y8lX
	9RtQI80c7The0rBFiqiPH02CWVw39zOn9uEi//bCuUsFMNZzAfK5v5TKx+DXO4KU13m3Ygyubde
	8DPXhfy+y0W09Tlv548126DPuKLSkRTDaz+lLszfwIqGUV5F1lWI9U+IqpuBMD+W/+EEn8oVIZa
	QycJ26qqNPfsfM2GzOEg/GhHM+uclXlojPOEd3TDIt8vfYGGeOcbWkEaRGbU+c2sJl1y7Cfng4/
	Z48QqQlK/Wsigj5S+30sJSjfx6WjFRGHEtrsIo8O01HYYuJ9iq/LR2IwfGVOtpjwnyd+XFJBb4x
	TYZtm6KeBu4J4a+svRzCgaKIIHfek
X-Received: by 2002:a05:620a:2406:10b0:8f0:5e11:d201 with SMTP id
 af79cd13be357-9153d93b22emr1342049085a.12.1780328007727; Mon, 01 Jun 2026
 08:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601150203.20352-1-leon.hwang@linux.dev> <20260601150203.20352-2-leon.hwang@linux.dev>
 <CANn89iLJgBxx=NaZDHy4s1_U9LKp9dqUDd1v9LR3CQPNo7DxEQ@mail.gmail.com>
In-Reply-To: <CANn89iLJgBxx=NaZDHy4s1_U9LKp9dqUDd1v9LR3CQPNo7DxEQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 08:33:16 -0700
X-Gm-Features: AVHnY4IsIkxzqxpucMb62Vf6bTc3GC9Y6wluDi7tPS--FKnWGOygHAF98fTYzks
Message-ID: <CANn89iJ3XfvAeEa90gTPXgfz5hJNEd1gEdH6sTubZ2k9j4M+2A@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Update transport_header when
 encapsulating UDP tunnel in lwt
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Guillaume Nault <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Peter Oskolkov <posk@google.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com, Leon Hwang <leon.huangfu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 8:28=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Jun 1, 2026 at 8:03=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> =
wrote:
> >
> > Currently, bpf_lwt_push_ip_encap() does not update skb->transport_heade=
r.
> > When a driver, e.g. ice, reuses the stale skb->transport_header to
> > offload checksum computation to NIC hardware, VxLAN packets encapsulate=
d
> > by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum=
.
> >
> > Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
> > encapsulated packet uses UDP, so checksum offload works correctly.
> >
> > Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_p=
ush_encap")
> > Cc: Leon Hwang <leon.huangfu@shopee.com>
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> >  net/core/lwt_bpf.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> > index f71ef82a5f3d..65d1dfbf3312 100644
> > --- a/net/core/lwt_bpf.c
> > +++ b/net/core/lwt_bpf.c
> > @@ -599,6 +599,7 @@ static int handle_gso_encap(struct sk_buff *skb, bo=
ol ipv4, int encap_len)
> >
> >  int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, boo=
l ingress)
> >  {
> > +       bool is_udp_tunnel;
> >         struct iphdr *iph;
> >         bool ipv4;
> >         int err;
> > @@ -612,10 +613,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, vo=
id *hdr, u32 len, bool ingress)
> >                 ipv4 =3D true;
> >                 if (unlikely(len < iph->ihl * 4))
> >                         return -EINVAL;
> > +               is_udp_tunnel =3D iph->protocol =3D=3D IPPROTO_UDP;
> > +               if (unlikely(is_udp_tunnel && len < iph->ihl * 4 + size=
of(struct udphdr)))
> > +                       return -EINVAL;
> >         } else if (iph->version =3D=3D 6) {
> >                 ipv4 =3D false;
> >                 if (unlikely(len < sizeof(struct ipv6hdr)))
> >                         return -EINVAL;
> > +               is_udp_tunnel =3D ((struct ipv6hdr *)iph)->nexthdr =3D=
=3D NEXTHDR_UDP;
> > +               if (unlikely(is_udp_tunnel && len < sizeof(struct ipv6h=
dr) + sizeof(struct udphdr)))
> > +                       return -EINVAL;
> >         } else {
> >                 return -EINVAL;
> >         }
> > @@ -637,6 +644,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, voi=
d *hdr, u32 len, bool ingress)
> >         if (ingress)
> >                 skb_postpush_rcsum(skb, iph, len);
> >         skb_reset_network_header(skb);
>
> iph might point to freed memory after skb_cow_head(), leading to UAF in i=
ph->ihl
>
> This issue is already there in the skb_postpush_rcsum(skb, iph, len) call=
 above.

Ignore this, I missed the context about iph, which does not point to skb->h=
ead

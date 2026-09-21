Received: from mail-pz2-f28.google.com (mail-pz2-f28.google.com [74.125.228.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721305158B8
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026579; cv=pass; b=GcOtaj9mHYkweZMp+2RV17EqTim1DvI2Gq//gIGl9Y7VngWxwqG/a/VRZRVjS640HaFMYDxd2P5Z31UafceGmLckYVyuOmoa0y4NEhGNGV31nh/5G3Q9Q/bGR78SCDKJQtaUcu1qBMEgQk+gWT0sPLPWpt1eMF7ITNOcOrlzrh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026579; c=relaxed/simple;
	bh=0xRxgq2j53JlZwoPQFcrgqq0FbNHb3eRgpC1bShN5I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoQb39GsfniTSRy9sBQNsZSI15HYaZlsXjyxZ37mPv0c2T767okqPgZ0Xg8qbvBR9WUg0QeY17aAwA+4fD+aH4fLF7zDYHnxW8/1NlY9mXASK/wx+ml67mwjxvgaN35KO3dLcCOU48PC4eRugxNCiiLxv/Y9bbrWTW2UVm/YoS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZeNWsg6; arc=pass smtp.client-ip=74.125.228.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZeNWsg6"
Received: by mail-pz2-f28.google.com with SMTP id 41be03b00d2f7-cc745abb731so885825a12.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790026578; cv=none;
        d=google.com; s=arc-20260327;
        b=jBbX9wDeBlTfm+0aC5b8HCoHfxoq4D+SYg81rwsmor7Y0sIGlZ5RivC76eKh8H//Om
         0cnsG5rVQ0iLHN0JDqp8y3q0u3Kclb2acNl6CtmX086Pr+9BBphBzv3yQUZPP6OaAANu
         zf2kEaE/A+uccIo4EyA58XOclPSJo2piL+Kh1rnAQIWWw1OyKiiNeqIKbUChFCLF8AAa
         X+O9zc0Wl6VlmCSzw2KJ2TGv9LpNRWiHcI95De29nuGuC7fhVM9MsGj3pj3vCia6Fb0A
         rox/bqbz4LGLZxB6No7wnyI52XoVu0bpWVFxxUsNU1KOss/7o3/uAkqyf/lxLmnKEdsP
         bSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9S4UN1V9mLtIU5XAJ4Mj87c5tZOTpom4ugNvERFaqpw=;
        fh=aeLlabBLhLvbDTtydx87+nUKYHH5r5nDRNtbc2PjsO4=;
        b=eoRJdwUQIWmbaAUigcIOa5eqz1miAGfozeydXKL4GgEJv3MjA9+wwDpnKgbIaMrdcw
         l21n65Md8qx+MWqcFx8NZhfZ+gfMHXqSoVfBV6pw6T0DgustECl7CaXWGDfQO93TfRWw
         MK/iJOyWjCl1v58GO71xe8v1/RQ4lKx5GGxQVd14qVl1TbZKqDGi1y/zz9n54sixJ6aV
         cnw9+6QLwZxGXJQwhg9n0SepAeksJG1XrDFkpBHLAizHwJjhcX6j031xJl0GpG+LDhHT
         +BaVeS1p6NsnQOEobbSbXGrSdE8K4bsnyC+BRcZMGXecv4LWHY6zBL819FgetFZ23WXL
         LLxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790026578; x=1790631378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9S4UN1V9mLtIU5XAJ4Mj87c5tZOTpom4ugNvERFaqpw=;
        b=gZeNWsg6WlFdyHjnqhIj00tMaoIcN4/2P/AinBetUew1vSGStLi5sm2QfW3sOCn9XJ
         08Sb3olbZ5zNrr9ZJAv5OnpMBIy+vKqTYGvsNnZuP9o+Dg9klLwcs2GNBAavMCuSoM/m
         CQAA6ZSA2eP9SKMO7FW4RpxH/ou2vHgrXhtptZTK0BSqujv8xcLbsCeVkC2Hmq1hDbHp
         RkE2c0BFJWgDXg2YUyw+Tu3Vuzku5Yj+dKmXBlKi0OI9obcKsv5wL4lWjoSJxzw1vApL
         ODPkFFg0z0MDXF5cmuFqt/XQme+0HuB4fwdh6WhVXFcB+gJToqq+TqQqfvBImPpOJNme
         O+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026578; x=1790631378;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9S4UN1V9mLtIU5XAJ4Mj87c5tZOTpom4ugNvERFaqpw=;
        b=BG4Vg6KHaXiemJ4hsB1otTcAep8yZamYdQ9VBrpMGB5vvgiAfnKpo8qUF8W7E5zR6M
         JV0Lm5rgtHmB2rq/pV0Lwqe+wvb3iIruBn9pFDjP6/Bv0zgQqipLzp67xwvOCQfziYol
         m0qgs8BOvbllHXrUpPvOPhW/HYcz8hbTGX5r6P2bvTjTJg0k3Zhir+f1ufxB0mvtdqPE
         SGdgCEgYXnaOEyR83KC7bVnYOY2MDYE8YdSb8oyRm1sTcXefTuWo7volYK7DQTuZoZgu
         m6IPHxJO/nI6Zi92pspisJy6GSttS5YrgHswHXnCJdPRQEU+6IaZgIM69+werCWwaxSO
         LHMw==
X-Forwarded-Encrypted: i=1; AKwUvBxHx/xVr5O6+yc1U/HyEVOz/qUgCS9DZdAQC0UgHiQb/tODpWqfWFdSLul/V08elmibKXs=@vger.kernel.org
X-Gm-Message-State: AFuF++ncPR5sI4xpVQhgTtiA7hfdKaZnzbU/dhuySYYBvLTYwUaJSzCx
	etrDt83C3NLzYj/xIOBfzuxSPJR0hDOV+w4lCfe8Q/O48yJ9xttY6++cP+n504yLChf9SU8Lcea
	xyt0ZClbaA7Va8e2jW6a0aeCajzmNYj5EPaqE/Kzj
X-Gm-Gg: AYBFou1P0bEu/AS6HcaTqecPEHIHRRFT4ie+WT12lplecdV6r4LfuEMoEKbuh2qa4H9
	eZCDLG8/Dy7qWsyQsqsDBsxwZUbNU/vxnIhB8/YQAMmXSCdtaWiCUKaZ2mlHIg4nhaONWDVJXnL
	jxxkKQ+qbdPftKG0PwvfMZaogUAWHTK9uSiBEw9rqYcu2lL6/ks/aPgAbae9cPkzq0j56aAJcZD
	KGlCVlTqHhdLaaHIkMu6wz6cItrI2rFYppIUUQi2zpo1XT1o53kJJ4gqof0+kcoN7sO7WBsn5lX
	ShJGjcY0HL8iqpiiKAt62Yv0pG9GS4bDMfClDCymyhJhH/UyBrO9ITOD05H76wsKg1Pvp1Kewqr
	4eSzuG6WwaJkySV/h3SOkefRMVH2LVF4C2/g3Ja5qc88zFwM6VeQx83zdYo7l1u3Q9S4eSRbpNj
	hjjmYQuZxFJs41HvecTTxcqw==
X-Received: by 2002:a05:6a20:548d:b0:3dd:85a8:cac7 with SMTP id
 adf61e73a8af0-3dd8c44e2famr18712394637.30.1790026577083; Mon, 21 Sep 2026
 14:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920195633.3033620-1-kuniyu@google.com> <20260920195633.3033620-7-kuniyu@google.com>
 <arGYSbQ97ORDvSBl@devvm7509.cco0.facebook.com>
In-Reply-To: <arGYSbQ97ORDvSBl@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 21 Sep 2026 14:36:05 -0700
X-Gm-Features: AcwNN1Wmuqzqu6AVItlJJYH99pXCMxSAZwEMncsGSowQkA6OYTAXgvMp6Luf5KY
Message-ID: <CAAVpQUDSU8QbnLm2ajR0NKTRNr75-6yXKaerG-ZcUkOLKz70rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 1:50=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 09/20, Kuniyuki Iwashima wrote:
> > bpf_tcp_ops.{enqueue,dequeue}_rcvq() were added to parse skb and
> > adjust sk->sk_rcvlowat dynamically to suppress unnecessary wakeups.
> >
> > Let's add a new kfunc to set sk->sk_rcvlowat.
> >
> > Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.
> >
> > For enqueue_rcvq(), wakeup is set to false because:
> >
> >   * tcp_data_ready() is always called after the hooks in
> >     tcp_queue_rcv() and tcp_ofo_queue().
> >
> >   * when tcp_fastopen_add_skb() is called for TFO SYN, the socket is
> >     not yet accept()ed, and when called for TFO SYN+ACK, the socket
> >     is woken up by sk->sk_state_change() anyway.
> >
> > For dequeue_rcvq(), wakeup is set to true because tcp_data_ready()
> > is not called in that path.
> >
> > An alternative would be to support bpf_setsockopt() for these
> > hooks.
> >
> > However, that approach involves excessive conditionals and an
> > unnecessary memcpy(), costs we do not want to pay for every skb
> > in the TCP fast path.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/ipv4/bpf_tcp_ops.c | 56 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 55 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > index b0e14b54917e..3768b1440eb7 100644
> > --- a/net/ipv4/bpf_tcp_ops.c
> > +++ b/net/ipv4/bpf_tcp_ops.c
> > @@ -359,8 +359,62 @@ static struct bpf_struct_ops bpf_tcp_ops =3D {
> >       .owner =3D THIS_MODULE,
> >  };
> >
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat=
,
> > +                                      const struct bpf_prog_aux *aux)
> > +{
> > +     u32 moff =3D aux->attach_st_ops_member_off;
> > +     bool wakeup =3D false;
> > +
> > +     if (moff =3D=3D offsetof(struct bpf_tcp_ops, dequeue_rcvq))
> > +             wakeup =3D true;
>
> [..]
>
> > +     if (rcvlowat < 0)
> > +             rcvlowat =3D INT_MAX;
>
> nit: the same check exists in setsockopt. Any reason not to move it
> to your new __tcp_set_rcvlowat ?

Maybe we could duplicate it for each protocol, but I feel the logic should
reside in the core part.

$ chgrep -E "\.set_rcvlowat.*?=3D"
net/vmw_vsock/af_vsock.c:2672: .set_rcvlowat =3D vsock_set_rcvlowat,
net/mptcp/protocol.c:4730: .set_rcvlowat   =3D mptcp_set_rcvlowat,
net/ipv6/af_inet6.c:691: .set_rcvlowat   =3D tcp_set_rcvlowat,

>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks !

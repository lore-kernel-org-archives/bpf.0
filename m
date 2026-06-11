Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C53136A370
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206031; cv=pass; b=JBfRpeufVIuhPqN5QGOUsf0DaniBD/KeV0xkG4SSl3SnIB/3d7eq7bXW1N8F9nK6xqCvFkrLnKJ70bDvTf682luVaw4ddKZxSXozfHimRGSrirSGpiskrDiH9WC6MkhU71UoE1lK6FrOMBqr3yB3IBv4JRNVeGMWHd6EfVezKR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206031; c=relaxed/simple;
	bh=GiJIqbi/zt960Tj+KwRSqVMjpp+NhQcRoTz0Bx8JZJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJ8mnKtgvuFS3+1On0SM4XCGqLiPfzwQ6/Su0WGND87HkfQ5w/9i4/lB6eDOtMlkpXSfZc18C7BWJejlupKtyGkhXnGae+iID0uEsgNsuDuqQ+/mj/PdK00Nj2Uz+TNvmUjdmvmY0emNU6JMRzDzGRecJcq7ynrXkkQ2USCOXwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+2xK7Az; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+2xK7Az"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5175d339e8bso115511cf.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 12:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781206027; cv=none;
        d=google.com; s=arc-20240605;
        b=YmXFlPSXzkTBubBWbeTk7aNXqaaakii1pjWRFsh0Vnb/mR6UyfVmHqjeeelzi5IYQ1
         9ysNICTGWGxlRWZ1DvdPl/PoiB5pQnfI5HxLBXJnyzR3KfOFrUjdrIyZDIavoV29N291
         eanoTuTAxOxPdk4pCspN5b4oqCRakuSYcTBIaCU16A2ELm5oRIkC6Gc3s9ASGrkXl4f+
         Ny3X18O+9ff0noAKBcS7u6FikaE421IjrTV0UU0gv7ML5oEMsCc+VeGQodxF3DKItaOf
         cgOHgBliFXuAFAPiQqrJNm5iFlamGWE9pi6RIwLsXx13BijTTmUgB1gd33bhIKlWbckD
         L8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B9qk5GpsUA8CAgTHbPborw1Bfo5DBMe+LeFNmN/rkbU=;
        fh=nfF3KAvYhj3ifkuFnu0p0m+XfT67IIguC8GjsdRGGXc=;
        b=T1qHKmdXvlcZ0RFYh1XLPpCNewEfIa3W8i1ivWlogFEduoDGhtc8AroJNgkJJXNTjo
         CZ6BmoIIfmg4ejNJ7FONJJTO2dd3/A60hVHlYSDq166LdXISM+XaI03/B2/u/HJowpfm
         nFzBnPrH7Eva+6APXmXK63bzB8ysByw/ceTmGOmgjbLPmzkUmfWeOK9/uldjw94rovtW
         MbA7dXaqK91pzY3oOL7dcHjiVElCnvKCDlX/cBseXgQEr8P44mS4kUARt7mqmAFJa2Xq
         BvJgQ8iTRAj4AP3clx/K+lS9FNzHzrXuA3kGv7vjlXg04WseyR0+1xc1nowZ+vSqNl+E
         1zmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781206027; x=1781810827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9qk5GpsUA8CAgTHbPborw1Bfo5DBMe+LeFNmN/rkbU=;
        b=f+2xK7AzyQrcrmbZJQ+234fii6z3bLYSHlgeOy/1SRCeyDm2nHdZ4cnPX577bxWV6Q
         CvtLY4hAORZl+R5XWmejUBcNSt/+BWHF4pznauYQ8IBqJJU6TZqRl3Q/QKOa4wrUcqqa
         CSpIrbx1j3vHQHCZrNrU39KYupoVaWlJSGzxtb9t208xejLiYbRfi+CBrmqAVEc2sJVa
         OJ2z8jl5GZ+H6gcj1NFrVKB7x6Bky+N2HCGriZHNZKqfqfHK58tSpE2sj8ysudVbf9Wa
         YUdZds+EkG3uhah+Tl98uajzwyWFmoZ7Yzeb3aAth/Daa+zbfjhnLcsRjVacAWd6rX6X
         y0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781206027; x=1781810827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9qk5GpsUA8CAgTHbPborw1Bfo5DBMe+LeFNmN/rkbU=;
        b=C2J9sG8Djrp0KB4xxfJ5zvW1wVlDX4kLK4IMyPAUU4FJIN4VYKH9JN1pMpknIjTsqa
         k2e6eCsqcmvnPSAGX544KamFFBGD56IUslHAlMCOeTGnWCn5BdRSQWprxBO9z9bf43ox
         opfZsxIVh/+5UiulBJb5p3/ZHSZls0HUUThIB6IFrInh7SiPbLwsgRI1gDAMw1YMKpct
         id+bfRpyEq+kfpAdTeWgCKINxbP+i2YS2nJZBwgCuJa/Uf+880JL2zhM1faxi0H8N9VS
         9kcU27jsEdwYPoDXC23Bk/X8eNj4tKEJvmuu98cjd7OcbHiYz0l0IJZDp5x3VoqJMzPd
         Tstw==
X-Forwarded-Encrypted: i=1; AFNElJ+Is9YbY4b0/2b3likb/piR0WBzV7hfqgNVNTjxfOHc5PHMWvani+KMufXa3Xda/lsaBsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC9cVocIrqWFMLATOMpoWgeFeL9+9ZtqUx4Gwk2n0tQrqd8+hm
	59CCWk6ddyfWAipsgSBb3E6uZcg5u0+Ci4y16Y5BWtV3qv9RIa82HktQbKW99gaYRaAOmhKdDCy
	Pp7KslVvvbHH3XeIkge/YZ3KGQOqU31+TR56KhwCe
X-Gm-Gg: Acq92OECt9bi/3u+4XUKtKzmJMP/CzK5j5CFQFDXQqH8r+C+fGH94FTZ+zkuGRwRRMm
	9wwbOGX5wbkB0jIp7yCFdAdcrmv+JCWrS3JU8zOe1gzvsPMq0vdqv1ZqtzxZAgYs61ZlLWXPQtp
	NGuN62A7uI76G8tDygn53bK4kWMeW3tCn+QIKLig2AXMFhnkgt3KZBg2/kPayG9Yza9QX9fEWfv
	n8sdp0oeXK4N4+7r2Ki1vPLONhNISpG8XK7H5vRd3II4UBPU+vKa5ZT9Sa0BeRNRiOV/CI06TX+
	ef662J7LQbsLDDpZ6irqxVoiY/iQ4qAfU3lagCz6TShJ5xbce/aV0Ki0LWlmgkw4YGm8PglMLG6
	EdEWIn8k=
X-Received: by 2002:ac8:5751:0:b0:516:3b3c:1df2 with SMTP id
 d75a77b69052e-517fb081b98mr1442321cf.14.1781206026577; Thu, 11 Jun 2026
 12:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com>
 <20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com> <CANn89iKkPJqOM=0KV8O8=2zWrZObj+E+VJoLztp4sUi7Vj0aQg@mail.gmail.com>
In-Reply-To: <CANn89iKkPJqOM=0KV8O8=2zWrZObj+E+VJoLztp4sUi7Vj0aQg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 11 Jun 2026 15:26:49 -0400
X-Gm-Features: AVVi8CcE5E6vt2s5oq4L--FKZfAYR8Si6-gSnr-nTlOrZF55zyd_6sc57DK_ztc
Message-ID: <CADVnQyk+sOAKU_WtPja7_hgiXw8he9U1g6AY7iEm5q3F3R-Hag@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/4] tcp: Add tso_segs() CC callback for TCP Prague
To: Eric Dumazet <edumazet@google.com>
Cc: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	kuniyu@google.com, ij@kernel.org, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 1:01=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jun 11, 2026 at 9:15=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.co=
m> wrote:
> >
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > This patch adds tso_segs() CC callbak for CC algorithm to provides
> > explicit tso segment number of each data burst and overrides
> > tcp_tso_autosize().
> >
> > No functional change.
> >
> > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > ---
> >  include/net/tcp.h     | 3 +++
> >  net/ipv4/tcp_output.c | 4 +++-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index e8090f542f7c..3b415c9dcc54 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -1366,6 +1366,9 @@ struct tcp_congestion_ops {
> >         /* override sysctl_tcp_min_tso_segs (optional) */
> >         u32 (*min_tso_segs)(struct sock *sk);
> >
> > +       /* override tcp_tso_autosize */
> > +       u32 (*tso_segs)(struct sock *sk, u32 mss_now);
> > +
> >         /* new value of cwnd after loss (required) */
> >         u32  (*undo_cwnd)(struct sock *sk);
> >         /* returns the multiplier used in tcp_sndbuf_expand (optional) =
*/
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index fe725d94a225..a7206fa61957 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -2274,7 +2274,9 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned=
 int mss_now)
> >                         ca_ops->min_tso_segs(sk) :
> >                         READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso=
_segs);
> >
> > -       tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
> > +       tso_segs =3D ca_ops->tso_segs ?
> > +                       ca_ops->tso_segs(sk, mss_now) :
> > +                       tcp_tso_autosize(sk, mss_now, min_tso);
> >         return min_t(u32, tso_segs, sk->sk_gso_max_segs);
> >  }
>
> Can you explain why min_tso_segs() is not enough?
>
> We do not need two different mechanisms.

I'm pretty sure this was proposed to meet Prague's goal of having TSO
bursts be sized to be at most 250 usec worth packets, rather than the
default Linux TCP TSO autosizing approach of 1ms worth of packets:

https://datatracker.ietf.org/doc/html/draft-briscoe-iccrg-prague-congestion=
-control-04#name-segmentation-offload

Where "MAX_BURST_DELAY" is defined as "Maximum allowed bottleneck
queuing delay due to segmentation offload bursts [s] (default 0.25 ms
for the public Internet)".

AFAICT this proposed patch is no longer needed now that
tcp_tso_autosize() uses a parameterized approach for :

   bytes =3D READ_ONCE(sk->sk_pacing_rate) >> READ_ONCE(sk->sk_pacing_shift=
);

AFAICT tcp_prague can simply set sk->sk_pacing_shift to be 12 for its
purposes, looking at:

   https://github.com/L4STeam/linux/blob/8ac01b97ffd993b1fed93a015ec30dd085=
857e8b/net/ipv4/tcp_prague.c#L144

   static u32 prague_burst_shift __read_mostly =3D 12; /* 1/2^12 sec ~=3D.2=
5ms */

Then probably this patch is not needed.

neal

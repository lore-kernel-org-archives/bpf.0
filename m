Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2923242A4
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787497879; cv=pass; b=EJwDx3yMtn5g/wcaZTl7ObsBG35H+ozXaGATHoIrO88uo22MgBH6UUiPmq8qnvvNZP9/qAlWSZ0qhKTwswC6a8BKCrAfaO/ADwWeP6qE7ttWDUEnQkZvPBkj65rSz+v6QUKpawOXKO8ovuUhVvHTQFAiA/N6ggtTBMskBkiXzqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787497879; c=relaxed/simple;
	bh=xIkR7zg5lhtFvWgzMHNup3lKSqq6a/c/k1dJRgDfsLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBpInlq+eAU12kPskdR9DPFLZN4MegM3tGm5QmStpaSvw0aIdPwNv29Aa20Y5HrmlkaViGH2WAScbg137SrDE5E95zFyeTUY9XDMJ8Tf1pmoGNVOpFezdubgf9ccWxzrIc/9jPLbra3xxeb466+2M8Bj70FwGdIHoI+BLRcxy2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAiHS/nS; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAiHS/nS"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2a818fc4so17564201cf.2
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 08:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787497877; cv=none;
        d=google.com; s=arc-20260327;
        b=cuUUf1RKDSnonzfl7/Lsh1u8FEzr/oJM51PvVJsItLBb9LIzLH9+sNS196fpX/RTjJ
         Hz7Bi1lxIabSjREzlUo1l7Evu/92G0Uh/AgD+gQYgd+fMFBASRkUACRRMWyGJFAuAgP+
         1jEaGj3s11MvLgpqeax8tHDMBlugYDHBcDsTWuyeqStUOrG3QjG9Nsj7LoMwmfu0O2kj
         JhCrcop1Yv9dUEF0i4zHUrtBP5sa90fEJcUwEPGvSsMDTqFHRfYDCGOBG4zdjmBmVXZ+
         mNMbzJK+cnSVhfQjlhcuCd9sGR7e13K8ZmCJtYyrmNO1r6tA1RPnoat9wFCC0ns/jpwU
         PYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xIkR7zg5lhtFvWgzMHNup3lKSqq6a/c/k1dJRgDfsLc=;
        fh=y1Wu0HWWdJ5ZwePWDARbwDn/Ow0ZZEfURtx2opcq/NQ=;
        b=hWAWD8+PAak8C/NB23R3skh9CemTLE/hVTPCp0tpvfkEmfCPZ5qhpqUKbgv7E75yD9
         b7iJ4A3C87Zbj+HLCfyvwsxIOMc66F2LUo52OYb9I0jTBdFAyYpLHSWayYPCvb6lB37Q
         dTO7dgxaool+MxZgTg+WzXVyq8/aXmUaeIHub7MkU2dlyqrwnLmE1A8L1Hd5GKMg9AVw
         sf9NOXOh6oLJ6Uo6iFkvNsquxpgfgCtRFGDBvPM7G3mGZ0SM/putldAV90w+UDo/EGht
         Jl6FlH0HVBspGT4RKdCKj+e/4NmBCYlsQaBlK65giutRQLzKKclrHzEm6Aje3qGTRhit
         oWQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787497877; x=1788102677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xIkR7zg5lhtFvWgzMHNup3lKSqq6a/c/k1dJRgDfsLc=;
        b=OAiHS/nSmpqHFH949qkvPRDHKimAT91CmO98Ppxv+VVRd9Fcfs+8Cl4AOA+tdMhxPQ
         rZTnlPe3SvbnMR7hpDDXqeQ72koj7ZAb7VidsXjqEXwk1AkYrWiCH4AJLNqUmsCYos8n
         7HVwuWW27Xuxdu6KZ395WxHKrS4lFs2n0u0Z4af/mI5mKXn57k/jqU51tauSmcgXXiAg
         IoSwX1yCywnU/IaUYo4VVs0PHNlgE3EeU0cpCnCKJIn6o4TmUw8R/Td27VKpX4fjpWzO
         WKd5qwqMK70JtFrPsdngN2HR4mbzngQLG0TkYWi/98D7euqY/pSIADFa1B1ujnYLmkmJ
         htWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787497877; x=1788102677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xIkR7zg5lhtFvWgzMHNup3lKSqq6a/c/k1dJRgDfsLc=;
        b=QsW8dBdN3QXHeUgZp2lG6zFnh58erqZ8xPI17y2mn7e58sN16v3gYoLfMlaEC7kuiG
         vcKukIYEO49RKg6VmLfiy4myV9a4WxiQAEqHJvoK3n34D/7kALRIQxz1m/CjAPOjFmIS
         YdL2V9Bg4rcE4lJY3rTU4wl/U8brjfGngAdbMb4ZydGNfIGU/2JwXHgQEnl8mpT7GQWV
         VTL9v8+l3NBbFfvCmWO5HEas/iJVPKVvDireIHEQDDnY+81HEM9mluoVom1L5xj0DKnk
         PXVw4lnWQHbnsxgFlExj1DfWRg2/wKv4ulVhLg/bfcEn1ax0fgpdsdwjqyFqwB5JQJd6
         dxLw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1UxRYr0BdqpOYx6VVl79Gur14TLDSn78r4pASSOKv5Hlf8p5GL7KmYOl2mGWEokaHJ7I=@vger.kernel.org
X-Gm-Message-State: AFuF++l9SayIQHxQi+n+YiumuD0ZkK9pYDV7TQpPAe1DoThxC3QQGo94
	FdUahA5Ncyc0KiXfhORoaJxSkGr3LzoEo16L4XhiDCm9GBpoYwIKdPQPXATG10B23dAmIB52JNa
	4Jg4XVRIZRANj2wGUJ+QAQcCvfzUcBT47PW2HGX/W
X-Gm-Gg: AR+sD10KMZGiqh07NSwlyGZCo7uTwylNfTTYP0j08k2m/f6W3cK/+7k/RNb3H7XsdJ1
	FAjSQcUQUHYQYIexQ36sfg9iYQ7RZ7EEr3d/zZsVQmpJnJo8awN8P95dM0qTWs0vdRhiy3DIDA7
	QcNWilrRn5HZP8i8Zi1oNqOrhhe2jpXHfzjhXcjbRjGhENbM94CG7/FHMsec4/XCvdu6Z/DFbNX
	jWyPbWyaPYCjd36qp8nzaIYUYdShs3qTNcortMvJCAXgjv4IszSUPjPTpyg3qAQRjSRawg4lRrI
	QMn480ld1BnxFgJ/AQXIdZHAsVGpMrdFu1KUoyPgNFkO16yzPe6Hf2rW07fxJQTd2BXADQFWgpS
	NFkZWAL5IL1aZFem8Jf/lBPn+QQ0nv9JCHPWX2Wrm+aVRBsVwE068WKf2
X-Received: by 2002:a05:622a:1f91:b0:52d:8c01:5238 with SMTP id
 d75a77b69052e-52e09cb983fmr112871311cf.33.1787497876233; Sun, 23 Aug 2026
 08:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823101809.26802-1-shlomojune6@gmail.com>
In-Reply-To: <20260823101809.26802-1-shlomojune6@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 23 Aug 2026 17:11:04 +0200
X-Gm-Features: AcwNN1XEn31QwNoOjATtV2OBczN_PVRdSeHeaGm1GS7qzu4XZoVeex3ZR6dO9QY
Message-ID: <CANn89iJALGUB4jYyRWWMQENyNqBtSChOTiBwFzOVs-s6uX9Eig@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: Don't deliver IPv6 packets to IPv4 sockets
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Joe Stringer <joe@wand.net.nz>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 12:18=E2=80=AFPM Shihuang Liu <shlomojune6@gmail.co=
m> wrote:
>
> bpf_sk_assign() allows a TC ingress program to attach an arbitrary
> hashed socket to an skb, without checking that the socket family
> matches the packet's network layer. As a result, an IPv6 UDP packet
> can be assigned to an AF_INET UDP socket: udpv6_rcv() steals the
> socket via inet6_steal_sock(), which also lacks a family check, and
> queues the IPv6 skb on the AF_INET socket.
>
> recvmsg() on that socket then runs the IPv4 udp_recvmsg(), which
> interprets the IPv6 skb control block as IPv4 IP options. When
> IP_RETOPTS is enabled on the target socket, __ip_options_echo()
> copies up to 153 bytes of attacker-controlled data from the IPv6
> Destination Options extension header into the 40-byte option-data
> area of the stack-allocated optbuf in ip_cmsg_recv_retopts():
>
>

Really you need to ask your LLM to not slow down linux fast paths.

Fix bpf_sk_assign() and bpf_sk_assign_tcp_reqsk() instead.

Thank you.

pw-bot: cr

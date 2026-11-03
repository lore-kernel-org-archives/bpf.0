Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712881;
	b=0pV7arjFL5jcsjHkgX0OwGdVPm1uy4pSWZ55oK89szNU+rf0fA0XOE4aECbAszvfsDfX
	 cBVomWy2VUWWE/ADHpFZ/u3Gc5Smoe2g0siBvhu0l4HbZ5/QMTMMruq1X68DhN4LEilmd
	 S5WyyBboyHSETqfiWJBOu/fQQa9s10CNiOP3jUKkth1EhMAtiLQfUXK8B50pRO39abDtH
	 QNRiSaRqEDdrfm7pqJG21C+vt/SpX9gBR62lqpgmys0i0WmqOsmxrDmuWkDbBMbrscPzb
	 Mqgj4ujt3I+QrVycoRT25kIehP5F1TnstwXwmmHgEBqw4SzK2J5rI2WEyAXXEvYUpmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712881;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IYte/VFkKdCZ4xhpQyoeocuEaTeaOZru7SAHY391uSM=;
	b=tFfgN07rpPUwedAd6XnlTZpWh3zhxKz6qmTWi9mb7Tyky1ei457X/mhx6newE1feE4OI
	 3ykmA7UBVYWiL/BVQy60mfbG9QJcippDdXFuhb+OdrJD4lpQK9hIa0AKPNHf9f31GrF1Z
	 bF1lRMqA52xUvo18irtohgM4xg2pnjVoiPokvpAQ3eOvdHEMNNu+s1jn5W+xh3bXjwd6K
	 G7WJMPRZdUvrd6s2DcPaZs3K4UMWdvBvc8lr6y+Zs9iARHsWZqgkK3rCUTZ0g2C8yc6eJ
	 M7+qYWFdN+plJIdIqVWHbw8jXOy1uOFiyBJp/7p4RR8jFqVe4CjCTAnDrS0NzpFW9lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M49GXcet;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9625F606A33E
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M49GXcet
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454251F00A02
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712881;
	bh=IYte/VFkKdCZ4xhpQyoeocuEaTeaOZru7SAHY391uSM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=M49GXcethFCnW6HvRe2g3NkrtCtu1clX2LP4cxnrT72d1Ekz9Hb1qvt7LZOYW2CT8
	 YCr69FbGGWhVnA7gM6Q+sWgUIuQTQyVogVN383HTmNydnIIP5SfBzQKkrDQFPgg2wc
	 o0LD16cA5OHfUzxVgQBbXOiGkXk5uQc6kxGBn/A31WnPnlNlOGTi54+uXBGNpoV9RE
	 cINT8ra2eRhtZN0viLV/sT96scSYjjKOvDat/FES1Gmlz0mfE30wqcwqui/xKrHHyq
	 ylQv8ENQY7AParmbM53WpGHQShI75Cc+2USJiltmpSWSsBG9w4KnFGiQXH/dHqA8fB
	 fTTZYvWgrH9sw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4a6f2825dd6so832709fac.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 05:34:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy6HOq/zgD3J0bpSBuFxxKN2wT9FLEMpXug3swiCgRkdNQBo7397SeDLX2W1aP7Q/BsrXU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pl1jTyExMmn/FITxyoSl/+o8diTTEiIr3v7VwmeaLKqfEo+/Y
	dROte66N0Vh9wnF7IJD/lGij1jjaf2X5K2L5pDNInNaBLQLn7EnjMhCr+nPvYWLaQJMIwF2aHwr
	UaWqt3FW8m7iWNK1at6hKlZyBVfyck48=
X-Received: by 2002:a05:6870:312a:b0:483:b752:633f with SMTP id
 586e51a60fabf-4a907714416mr7456463fac.36.1793712880594; Tue, 03 Nov 2026
 05:34:40 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030122045.3035709-1-edumazet@kernel.org> <179362213820.3131.12108035098960840444@kernel.org>
 <c573bbcc-e0d8-4f43-b14b-09c676a6fe38@redhat.com>
In-Reply-To: <c573bbcc-e0d8-4f43-b14b-09c676a6fe38@redhat.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 14:34:29 +0100
X-Gmail-Original-Message-ID: <CAL4WiiobvgoNp3Y-6qEh=OV9truPNn1v8-DoqFxR1rx=rpkZXA@mail.gmail.com>
X-Gm-Features: AclHuK99zDPGvHkXqxIh5HAxw_r9tpWTX1MGzY_JCyqvRX7nBtPz2wuFdyMsuxE
Message-ID: <CAL4WiiobvgoNp3Y-6qEh=OV9truPNn1v8-DoqFxR1rx=rpkZXA@mail.gmail.com>
Subject: Re: [PATCH v2 net] udp: restore hlist_nulls for primary and secondary
 hash tables
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	willemb@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, david.laight.linux@gmail.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 3 nov. 2026 =C3=A0 09:40, Paolo Abeni <pabeni@redhat.com> a =C3=A9c=
rit :
>
> On 11/2/26 13:22, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] The hlist_nulls restart does not work when an IPv6 SO_REUSEPOR=
T
> >    socket is tail-inserted back into the bucket it was just removed fro=
m.
>
> This look real to me. On the flip side the most straight forward fix - av=
oid
> tail insertion in udp_lib_get_port() would re-introduce the issue address=
ed
> by commit d894ba18d4e449b3a7f6eb491f16c9e02933736e. But rehash already av=
oids
> tail insertion...

Agreed, it is real, although not a regression: before this patch,
hlist_add_tail_rcu() set n->next =3D NULL and a reader parked on the
socket stopped there as well. v2 simply did not fix this case.

We still need the tail insertion: udp4_lib_lookup2() returns as soon
as the first matching socket has a reuseport group without connections,
so a dual-stack IPv6 group placed first would win over AF_INET sockets,
despite their better score.

The problem only exists while a reader can still be parked on the
socket, that is less than an RCU grace period after udp_lib_unhash().

v3 records get_state_synchronize_rcu() in udp_lib_unhash(), and
udp_lib_get_port() only uses tail insertion if
poll_state_synchronize_rcu() says the grace period has elapsed,
otherwise it uses head insertion, as udp_lib_rehash() already does.
The cookie fits in an existing hole of struct udp_sock.

The cost is that an IPv6 SO_REUSEPORT socket rebound within a grace
period of its disconnect keeps its head position, so the v4/v6 ordering
is not enforced for it, the same as after a rehash today. This needs
disconnect() then bind() on the same port, with AF_INET and dual-stack
AF_INET6 reuseport sockets sharing that port.

I also kept sk_nulls_add_node_rcu() unchanged, the tail insertion logic
is now local to UDP.

Thanks !

pw-bot: cr

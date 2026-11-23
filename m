Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795424481;
	b=RzptAL46RdXpck9AE0N33GF722jDs7KdX6xMlo9tISCQKo381Ov8DgHnVyktc7cf+pZQ
	 oPMT+VbNsRUxyjhhDx8304ssGNnIXZwYVz3yzAGjANJrVpCg6cv7Wmpf45Dj8eiH98pzh
	 pJaFaWsRQa2Tc+cK0XmVenJOVNjQLnjAZmMFRRRf4CHRNWBBbHT4QCGJrLqqSqNbtYXaF
	 cC8CCO8yXEIcckHniqwY5DLCiGcbWywtka8ztQHjXUsHEYXOVDIOLU+U+8Ug/Kc8KtML5
	 LFGlkQYlV5bK/DrsWuJ616ng+G5I0KJJE4grBpeNv4gnKT+9Cc7/n0TJe6ANcpMEJ8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iEL2+JCwPEIGLNb/94dwdFv8o2SffeGDTCEHWPlYg78=;
	b=jaYsRmQjd48agRYYH2luc2/T1F+nBLl6kJoVcQzia1CroE0sQ4tQew2KUxJ8R9Ttes8W
	 LX1taLGTqlaKNT0ECE+duI1AlW/qH/6NARuuaAYBdxQSdYin2xpjIgtg1wPlHL1KRzpKl
	 P6RZUOKMng8wWfEBZ2Qb7MrIMocr51ZmN5Eya8bjRwp9kkj5Am7N2TyK7ppd6HDRCQ+gt
	 GDhpcbXDh954TG/PrklbVkQGBdE9hve8EMcRYj6cpXdw9nzVS05E+lZ2nwSOPGlNYMP/q
	 6/pUYSvOcu9QVgv1AGY3okqdJM2EzH4EBZ9jtwBF4DZZaXxxjqtsoRdiZx+/jyd6TLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDIypQYt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2223B606A32A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 09:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2223B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDIypQYt
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so29934655e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 01:01:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795424478; cv=none;
        d=google.com; s=arc-20260327;
        b=K6PqBFC1MRM5eP8IQg2ww8fPOoV+gqzReBPt73yNUV9W1yDzh2/UdC+gsQzRNJki3M
         6Dbf8N7hDSr3TO66Cikz8azBsmNH2XqZq9caMytHLLuGGhdeUVPZnYsxAHu7jY7Z3v7N
         bv5rQPlbvYsLUxOjOZFcv9rkcT77eRpg/VJXjBjfxf8P2HS49afVdlDDki1TGtnjGAGy
         +IqbOZS+fD5PAGJLt+GFlN0Yx6yPfSIhGuE39HP+OS/o1JMVtSoA10BLDzzhIaPVZQ1o
         bDCLb2HIVZ2oTFcRQehMjjwK8xRrVjiX/Od4R8ZdDfx84MmG1g+PVhu3rtMQPOL9oFyO
         SHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iEL2+JCwPEIGLNb/94dwdFv8o2SffeGDTCEHWPlYg78=;
        fh=bKsWsa6e4T7ovr5mgjVZwx8BECbrlRnsm9jl1uHJXQE=;
        b=ib2MkhW4okaiSbYFibSLhzlJrShJy9+tNWIL/FLwRf1oz/TlgpmI+CW5jiVjwJWnaG
         vO0F/9f0QQK19D2sgKLhpJVJemzfGlrWwI0nECLzZ216U6EQS/EqHf7sFMEwn+yigw2f
         +2FhigBhrAHtBDlrSimsP7lUpKk4I5A1DG45Jz742mNepTa+HIjMri08BONNjXoL1wbs
         3yOAtAotF/hYPdbnusbOiOSd9FnDKI2ffHIilSYkCq3VSG5egNfbNSMrpP0YZfT2SW8G
         U2Cz7b/PKr+ge3u4SWa1MwAwzKoD+GO9lhNdBjP0tX55zW3QUspiF1tAzq6iiebAr2Go
         agBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795424478; x=1796029278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iEL2+JCwPEIGLNb/94dwdFv8o2SffeGDTCEHWPlYg78=;
        b=lDIypQYtGMYSsqoisCS9ORWetWNwzyhWYxVQjJILGn0axWWQ3SroGPgW/kiaaKX9yG
         IDFdSR7frhwRDZe0FYTtuKwTlxCAHC/tcedkQTP5aOAzjXzH2GcJldQHAWllOsckAvYR
         zDkYGaVfrnIMRO3xlCAmV1PaDQBHVz8RWtdrhw2Gpcr2aJjaUyLx8Ob8gXCVW8Z2g5+x
         +Oav7XOBannXpEVHxIt3Yg03EFHtiE/K2Erb55vcNC3+Ck9FIBFIBpjwYjjb1uYq4Hp/
         JYfdu/A90MLfXAg8s5WFsy5AUpbuaGnENgRq7SXuJYE9ikITVnGenNGD/kGqAHGInVZ8
         FkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795424478; x=1796029278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iEL2+JCwPEIGLNb/94dwdFv8o2SffeGDTCEHWPlYg78=;
        b=LfWRxOTn9vErtfKBqX2Oxq2sQM7Y54xyU7JS0y2ZyFIaRK91lzmVZOZV4DVWL8VzLT
         bcIPX415XQHZHxYfqxuQejzVUAhiY5w5H9XV+goLzn16v/nRW+DWVIscHxXr6e12nMjE
         g5LZKnGQR4XYk9zIhg+/RFWN4lracyABnXHh0CVZRF0wwJQuIy/fMIs2GbdySXFRx6cu
         BbMD9hTs7wO2sT9WDDXk2T4PP9aCWt0gG2YxkzmNOw2s3FJdFKfkNO/Gei37rKKZaKQr
         mYs35c32t+jGPvN1xQZnoK73LW9MsaiXPzXq3kwCIErNVJ0ugIVCW6cPFU8kN6sleccw
         HTwA==
X-Forwarded-Encrypted: i=1; AL+hErEGRYY9XqqwpxOQlCjrm6d6c5L5XCv9qAb2R4E1OnYPLvvdLXMN1vYyT2akdO8c6zisRSE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VuojyHrflfP5ySay2rkGRM62UaIslX8TJyFD1hIItqAx87MnC
	Xlg+gI0lAtkRn+XYYdVedKO9O2U3SXBDhvPKPU53oP8vpEmIYHaTAfQ8xO06M3EzDQHwaPmU8NU
	gimW5oWw6y6xYsFq4pMydn04aWpRbEjg=
X-Gm-Gg: AZFdTZcahKjFapHqu9fRAyO+oJsqcepowW8kBCpnLfvh/okUM1vpupE0Tsgsb1Pixeq
	oS/zkfWI0/5bipHq0EqVvoacLPZ6Dq9zCL4w5E78G1DDDgbceo1R5Bvk9NPgCc/OppR2Z1732qY
	VdxqeKi+LbWIkenVfsxjpeURqOlonup+q44cLMGZDx+RqKPfyG6ujqdxPDaF6R6Jy0LB+63G3TC
	qWepOJrCgNiF8xjEKylFJSo3W75S7Kds9UwYpT3Vpf36Hck8AVkakK37GLSMNr4Xjg4LkbbHrXS
	tZSQ/+fMiqyfxaP0paQq4dpmLUBHHg42mHZ+ghB+CC8cZnCwSup1LkA/OFO2b3peywDt73JNNJv
	gy+YcrxFSBhKabuvgWvrFBhSVuy4R3/52ccUBAzjsH4SJMLILEuTBUgrpGuied5k45fFJ1V1RGi
	ummBD+SR10a78T/9oTrETiSc8CLMQ9cUE7KdxVy9M0zfYtfl41Iw+A
X-Received: by 2002:a05:600c:8b11:b0:4bb:6871:8f21 with SMTP id
 5b1f17b1804b1-4bb88822346mr226556425e9.23.1795424477763; Mon, 23 Nov 2026
 01:01:17 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-reuseport-lock-filter-v1-1-a3e5324c8d55@gmail.com> <179542364209.3135.6346728453187808939@kernel.org>
In-Reply-To: <179542364209.3135.6346728453187808939@kernel.org>
From: Wong Steve <shyckless@gmail.com>
Date: Mon, 23 Nov 2026 17:01:06 +0800
X-Gm-Features: Aa3M54p7sikU-xuQj6GlI0jXC-7c2SJPbhZVFn909Hn6R_I22BVip8-BRA2UoiM
Message-ID: <CA+X8Sdi2zLn8ZUOWXQww1DOFkOqkPWFwrF9t5LnHxn==3s+8ZQ@mail.gmail.com>
Subject: Re: [PATCH net] net: reuseport: honour SO_LOCK_FILTER in SO_DETACH_REUSEPORT_BPF
To: netdev-bot+sashiko@kernel.org
Cc: pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, kuniyu@google.com, willemb@google.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev, 
	linux-kernel@vger.kernel.org, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> - [Medium] The fix only covers the setsockopt(SO_DETACH_REUSEPORT_BPF)
>   path.

Thanks for the review. Right, the patch only covers the setsockopt
path, and that is on purpose. The disconnect and re-listen case is
different: the socket leaves its group, and when it was the only member
the group itself is freed, together with the program that belongs to
it. The program is not removed from a group that keeps running. Making
that path honour SO_LOCK_FILTER would mean keeping the group alive
across a disconnect, which is a larger change than this one.

If you prefer, I can send a v2 that says in the commit message that
only SO_DETACH_REUSEPORT_BPF is covered.

Thanks,
Suyuan

<netdev-bot+sashiko@kernel.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=B8=80 16:47=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The fix only covers the setsockopt(SO_DETACH_REUSEPORT_BPF)
>   path.
>
> --
>
> net: reuseport: honour SO_LOCK_FILTER in SO_DETACH_REUSEPORT_BPF
>
> This commit makes reuseport_detach_prog() return -EPERM when
> SOCK_FILTER_LOCKED is set. Without it, an unprivileged process that is
> handed a locked socket can remove the reuseport program with
> SO_DETACH_REUSEPORT_BPF. This matches what sk_detach_filter() already
> does.
>
> > diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> > index b9e5648fa4c51..cdff61161a70a 100644
> > --- a/net/core/sock_reuseport.c
> > +++ b/net/core/sock_reuseport.c
> > @@ -727,6 +727,9 @@ int reuseport_detach_prog(struct sock *sk)
> >       struct sock_reuseport *reuse;
> >       struct bpf_prog *old_prog;
> >
> > +     if (sock_flag(sk, SOCK_FILTER_LOCKED))
> > +             return -EPERM;
> > +
>
> [Severity: Medium]
> This closes the setsockopt(SO_DETACH_REUSEPORT_BPF) path. Can the holder
> of a locked TCP SO_REUSEPORT listener still drop the program by
> disconnecting the listener and then calling listen() again?
>
> connect(fd, AF_UNSPEC) or shutdown(fd, SHUT_RD) on a listener goes
> through this chain, and none of these functions check SOCK_FILTER_LOCKED:
>
> tcp_disconnect()
>   tcp_set_state(sk, TCP_CLOSE)
>     sk->sk_prot->unhash(sk)
>       inet_unhash()
>         reuseport_stop_listen_sock()
>           reuseport_detach_sock()
>
> With net.ipv4.tcp_migrate_req at its default of 0, and a program that is
> not BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, reuseport_stop_listen_sock()
> reaches the immediate detach:
>
> net/core/sock_reuseport.c:reuseport_stop_listen_sock() {
>     ...
>         /* Not capable to do migration, detach immediately */
>         reuseport_detach_sock(sk);
>     ...
> }
>
> reuseport_detach_sock() clears sk->sk_reuseport_cb. If this socket was
> the only member, it also frees the group:
>
>         if (reuse->num_socks + reuse->num_closed_socks =3D=3D 0)
>                 call_rcu(&reuse->rcu, reuseport_free_rcu);
>
> reuseport_free_rcu() then releases the locked program:
>
>         sk_reuseport_prog_free(rcu_dereference_protected(reuse->prog, 1))=
;
>
> tcp_set_state() keeps the port bound when SOCK_BINDPORT_LOCK is set, so
> listen() can be called again on the same port:
>
>                 sk->sk_prot->unhash(sk);
>                 if (inet_csk(sk)->icsk_bind_hash &&
>                     !(sk->sk_userlocks & SOCK_BINDPORT_LOCK))
>                         inet_put_port(sk);
>
> On the second listen(), inet_reuseport_add_sock() finds no sibling and
> calls reuseport_alloc(). Because sk_reuseport_cb is now NULL, this
> creates a new group with prog =3D=3D NULL. The socket keeps listening on
> the same port, but the program is gone.
>
> Documentation/networking/filter.rst says that once SO_LOCK_FILTER is
> set, "a filter cannot be removed or changed" and that the filter "will
> be kept until the socket is closed".
>
> This only happens when the locked socket is the only member of its
> group. If it has siblings, re-listen puts it back into the existing
> group through reuseport_add_sock(). With migration enabled, the socket
> moves to the closed section and keeps the program.
>
> In a one-socket group, the program matters mostly when an SK_REUSEPORT
> eBPF program uses SK_DROP to decide which connections are admitted. The
> group-wide load-balancing change described in the commit message cannot
> happen through this path.
>
> Should the disconnect and re-listen path also respect
> SOCK_FILTER_LOCKED, or should the commit message say that only the
> setsockopt detach path is covered?
>
> >       old_prog =3D NULL;
> >       spin_lock_bh(&reuseport_lock);
> >       reuse =3D rcu_dereference_protected(sk->sk_reuseport_cb,
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261122-reuseport-lock-filter-v1-1-a3e5324c8d55%40gmail.com

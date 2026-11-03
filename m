Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734677;
	b=3Soz2TgTFAOajM2ruXCyb8LxvpsMp/2uj+M3SVigb49y+LQMeQCEQiVeYHkJjfGVl40I
	 gy69wbj2ivASj4Bf35f7KrmFZvHQ9lt9uHbloaTX3i+PFR6XwQkEw50fep3ptnx+RJ2B7
	 VI0RaLmz9sYAHXQ/TM1W5m0OpbQecsD4vt/qCwxOcBwqXzAe+XVzo81FypYCU04HLNDOm
	 cgPYS/GjSgYtxdZXC+r82eDp+bywrCQmq8I8XIS+SgGAiE5wJcOV+lAK64Gl0EJvkif2V
	 /pniDyfVA/dN2bkO1GvuxZQ2gCRH6o8SsQHYgqZLX+l5MfiNsHRk8YZD1Ql0KqtL85g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734677;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ItAo9qYkmyvqf88f/LW+ytUpAFOtt3hebtfMpwFkRN0=;
	b=oUyf83zzt1CExhJwPIOsdsuSSY4RdC6JihoozOlEUIviRrbOLHcybXR5okzsO8Twl9Ik
	 ZT97Xt2WPmD4T4g6LGeF5FwVILoI28JNC89RnLBfqlbBInOOLfLqE5rmdBQCdC54BbFi4
	 Xcopv7EWFevWcA4nPn6GVw9E0rBOQUh5t4Z4DFh72+PFMr4v5sYWA6kqOqrWcdaR8gpsY
	 1qHKqHo60qpzeOhN5SAo0c1LHxftyedIk/WbL5qoKzQVdS8oF/tPGbS378sKSNtDYb1wr
	 KLAywYQVr2G5+YqJCtY4X0KMpuKZP7+Tb54yvv43R06YMkvL6adzMHhD8b8JWolibcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtFnvrFg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1CE606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtFnvrFg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4621F00A1A
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793734676;
	bh=ItAo9qYkmyvqf88f/LW+ytUpAFOtt3hebtfMpwFkRN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TtFnvrFgJ4LexlXbJVvg3d77tz6QZ1WwXk9RMjJolAO4CjfjvPW8HVmpgOHcQ/R0y
	 5sRwGBUbH5WAexfXq508yDEoio5t2k7NTLk4ovwAU+tekKewqLa1vNvCFHtE/zvlAr
	 XA/2Rz2pKVKp7tx5xIoOVTwHb4JI/00lIsC02ECXAydEYTrexk3Pk4mqz9nsJO6sTL
	 AQ7OV60z8e3Q728qQJfOu7Ekz257G502lbR+acVi3GUVN97Qs/EjMoOIhYxfxzt7kj
	 Ibf9Uc1JYIbU341HFuA06n2u0HjnfHET/ouut5LvUuW1ISm1oGSeDmWxtpKX26qRI5
	 HF4Lvedgf1BEg==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so3278217b6e.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 11:37:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxIZpftxJUbH6uhc+QnyLcZwlWRSCP82j/Od0BUz2uPGUUC7SErGDuExKsavs/gxGqyMtg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dseCKQyBiHB/Q8I3dRCkbsnlsorT0Qu5rJsOAR6q9TyKhEfX4
	DzY6OMvebgp9n12V41pssPKFiNewqWcdrLoY/l/XvR15nI89CR0/Tqg+A/SSU9L27/eeIlbZg/2
	hxuDKDFJt5atonICbiykzvg+5Bm55dAc=
X-Received: by 2002:a05:6809:1c8:10b0:564:5fe0:dd76 with SMTP id
 5614622812f47-5645fe0f8f1mr2447428b6e.18.1793734675879; Tue, 03 Nov 2026
 11:37:55 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 20:37:45 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqw9kPmPp8WKJqUCOs+KUYY=Ek9yruY7QNZ1ZqqBcyxgw@mail.gmail.com>
X-Gm-Features: AclHuK_lWYrFuPqxHF7f8eVNTy2rRRIATiIorWPnhP8XtQMXmlNogVjkmkttJxk
Message-ID: <CAL4Wiiqw9kPmPp8WKJqUCOs+KUYY=Ek9yruY7QNZ1ZqqBcyxgw@mail.gmail.com>
Subject: Re: [PATCH net] net: reject a negative TCP header offset in qdisc_pkt_len_segs_init()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, dongchenchen2@huawei.com, 
	bpf@vger.kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 1 nov. 2026 =C3=A0 20:44, Alexei Starovoitov
<alexei.starovoitov@gmail.com> a =C3=A9crit :
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> qdisc_pkt_len_segs_init() stores skb_transport_offset(), or the inner
> offset, in the unsigned hdr_len. A header in front of skb->data gives a
> negative offset. For an offset a little below zero, pskb_may_pull() gets =
a
> small length and succeeds. Then a 64-bit kernel reads the TCP header far
> after the skb and can crash. Further below zero pskb_may_pull() fails.
>
> Commit 28a57fb2c5df ("net: iptunnel: fix stale transport header during
> tunnel decapsulation") fixed one source of such offsets. Other code that
> removes bytes from the front of a packet can leave the same stale header.
>
> Return SKB_DROP_REASON_SKB_BAD_GSO for a negative offset in the TCP branc=
h.
> SKB_GSO_UDP_L4 and the other GSO types read no header and still get a wro=
ng
> qdisc_pkt_len(). On a 64-bit kernel only packets that cause the read afte=
r
> the skb today get a new result. Then __dev_queue_xmit() drops them and
> returns -EINVAL, but sch_handle_ingress() ignores the result. Their conte=
nt
> can be valid. Thus the code that leaves the header stale needs its own fi=
x.
>
> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

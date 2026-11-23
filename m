Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430981;
	b=14kLIhilEAD34O+MSBu7v++oszkTSSL288Zve/6rkgkhCAk7p1EbEaq451ejdwrlgbBP
	 TbvH7zgD+Va8YmuBt+dB6quneI8vpyYoZ1Czf9YzXSH2AGZuD7h9n87LzWkJdr6FWj2eK
	 LhcIADbVIsGpPaCQggf+ReDTyPudXWgmk+ssc6nXyOB1E+Gn/A6wWUxgGo6IooMVWNFAs
	 k4Pie2CTb72F0bBl1teujZU9cCiZcmp7G8ayD9bp755zz8WdCh1qRz/z65NWJD/etQq5s
	 i9ZZIuqj/kP1KnURsq0PdWasuBltK4/q4whI+fXBcFL4GoK5SpMjNBzlmmL8nMCdhCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430981;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uuiRLHk3N+E1oMrfv2VmXcFop83iL6iVXO7sXhu2XFk=;
	b=rPgQOsn6XuxDEhhOOP5/gDHdoAfcesCRZRun1BDsg+KLSWtmGTpuqrWl1uOJ3XGJ+eJH
	 tH9lEz3RxzuepChyN+0/riFf+K9BpuWJC7gHzxR7+zJWlg4JfAx2jPncivDObEKhso5SY
	 /YDHmbYa4rYL0N1daGGvQQsja3eepDdb4Sqduf0390YUoYUOUx9q+CRqeBz8mioPDaj+5
	 6BPrHKmsOD4PeOdgM9Vklc1Wnpn/gUiJFYcdM6ri7K7dc0JHSDLvu9k/7la2W+luVU68Q
	 qLbpoxY5uqm4/TsPdTbXzd6vWDdgsBVuBTZmC0AGASqhp+0kP+Al3qDjcwW2XRbb13Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SywKQylB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99D2606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SywKQylB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3161F000E6
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 10:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795430981;
	bh=uuiRLHk3N+E1oMrfv2VmXcFop83iL6iVXO7sXhu2XFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SywKQylBl15vaQ2TR8/YwlAerzTW9Z/hriV5iTYVrPGsrBpT5/BpymJGSDyzRfRcA
	 afP6Veqc/qzG/dzFdd+c3MnMbcbkYY+O99HsMZ3IEMhP6VMkw1VdF7hMDpAMlP6eWF
	 DqK7jIV8HzgzvbZsz6SPuk0+6j1aeBVyaBcarinzGlqQSIm0KNM9hPMxfZ0rkzJgZ+
	 LzMmhg+vob9QZUizpAwu+xQzL9UkV5bLCt/V7u8UU1bukNmoRmpGN9A04ZZ9LvF68a
	 11TUz3NR5ndHlmmHdkYoKRlevi4DetxogRs+W5dqFGnwes2ocTqadojkXYnhtpGDry
	 XHh6aJqebkNAg==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-833e671ee9fso3005726a34.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 02:49:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGLiyrb0iJBWQOiIBYCh0Dp6Wcrj3StWHEIZ0wxJsZkjASIfNA4RQ96O8JlkXDxeBEr0Mw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kbAdRNpr+Ds0XF2dSulRbFcqHn2TyOgdeRyAvUfhIYSBIPjwt
	0IKrZb+2irACN0LKjOl7p4KawW9Ff+YBbuBYsEQm4PzuNvoM2uqlsnNyVSh6AFbzpic/Ab4t8x+
	CvLYAYbdNttazfQXjgper3ZvufE3gFUo=
X-Received: by 2002:a05:6830:2692:b0:862:c6cb:2e25 with SMTP id
 46e09a7af769-863152f8ef7mr11716687a34.2.1795430980592; Mon, 23 Nov 2026
 02:49:40 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121160204.4024204-1-razor@blackwall.org>
In-Reply-To: <20261121160204.4024204-1-razor@blackwall.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 23 Nov 2026 11:49:29 +0100
X-Gmail-Original-Message-ID: <CAL4WiireDJ9=d1QQS+kSJtBJDmzMbgM+tb7zNk1WunqCLKNMOQ@mail.gmail.com>
X-Gm-Features: Aa3M54qCBv2IH6BzoDtiob3Sz3xbIJRxyZ9--0FGnQoJNgurECB5N83TdB_5iZI
Message-ID: <CAL4WiireDJ9=d1QQS+kSJtBJDmzMbgM+tb7zNk1WunqCLKNMOQ@mail.gmail.com>
Subject: Re: [PATCH net] net: keep skbs with a prefetched socket out of
 gro_cells gro
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Joe Stringer <joe@wand.net.nz>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 21 nov. 2026 =C3=A0 17:04, Nikolay Aleksandrov
<razor@blackwall.org> a =C3=A9crit :
>
> bpf_sk_assign at tc ingress holds a reference on a socket that is not
> rcu freed, such as an established tcp socket, until the receive path
> steals it. ip_rcv_core keeps a prefetched socket so when the assigned
> packet is an ipip, gre or esp packet the socket stays attached after
> decap and their rx paths pass the skb to gro_cells_receive. GRO merges
> skbs with the same skb->sk into one flow and clears skb->sk and
> skb->destructor of each merged skb without calling the destructor so
> every merged skb leaks a socket ref.
>
> Send skbs with a prefetched socket to netif_rx instead as
> gro_cells_receive already does for cloned skbs, where each skb is
> consumed on its own and no reference is lost.
>
> skb_sk_is_prefetched tests skb->destructor which shares a cache line
> with skb->cloned that is read just before so the common case adds a singl=
e
> cheap test.
>
> Reproduced with a tcx ingress program on a veth in a receiver netns with
> an ipip tunnel which assigns an established tcp socket to ipip packets.
> The sender sends 32 tcp segments of one flow inside ipip through a netem
> slot qdisc so they are decapsulated in one batch and merged by gro.
> Then the socket is closed and the receiver netns is deleted. The leaked
> socket holds a ref on the netns so it is never torn down and its devices
> are never unregistered:
>
> Before:
>   bpf_sk_assign() calls 32, sk_refcnt 32 after the burst
>   receiver netns deleted, 30s later its veth peer still exists
>
> After:
>   bpf_sk_assign() calls 32, sk_refcnt 1 after the burst
>   receiver netns deleted, its veth peer is gone
>
> The problem was found during reviews of patches that add bpf_sk_assign
> egress support.
>
> Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Right, GRO callers are supposed to only feed skbs with no socket, or
sock_wfree() ones (see skb_prepare_for_gro() used by veth), and
gro_cells never enforced this.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

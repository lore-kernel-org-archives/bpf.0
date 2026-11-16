Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794832899;
	b=lAVh5DKJ/TUEtoe/46OEQuLzpLphvsYkZmV7KOkYn8fsIFWJpdz++N5w2Q6iCZadyQC+
	 Q3xkuQEGoJ71JArl5YkJ2JhB6WmN3zO7i2tewR8syOmyN/zVJFAuxd2boJx9axEeHIBcl
	 w8gSvZm0H7YNtUPmMcPuOafvq/jAvzyi76DJYGn00o1pQSJo2A5DGdrCdKFmKnZseG+nE
	 9cax7PuGDXam0MV0Np2UiZ9nwClUaRErFKDBJN+oNmgm8q3hUrAm9OisCTOQ2qYe660v7
	 C2MPY8NhUTHBzhiTSNsvP/8gUeN2+SIdoobSKZf62aq1//a4JrpyN0f+MyXncUiT7Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794832899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=Zv1d6vvRKz0euN6zrXybl1bD0UkhPFP+MSK0/brc4zE=;
	b=YMAzgcGePMlhieOwp9utjQ7koyyVyE0WYxtaY6LDsCurqb6osX/K3/xNM+msiMA/HpBS
	 uMItplbLPo5f2o2pZWJtF1iCOXqWNJVld1Ma+dNz+lxSUKQK2VuAx4Jmj0I9GJyC95M7F
	 Zna/hpRnJMcPo6RzMdv9t5auARMtQx3eyGrC2wuMOftiQJs2lJc8FFOwUnPYJXMoNom/i
	 p+P1RyvfO11PJFFogEgzp3yCGDjacB0ZaTT+Fz4eG3V4pW7S1H+ZgRZuYVvYtSqxp2lVW
	 fStHI+wXBq9S9+35wwj8JTvKUvJPP0UP8ZbKIGrCrZ8nvRvZ98EKB5hUI6TZQDW3vfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xN3B7Lud;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4840606A329
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 12:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4840606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xN3B7Lud
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9495f083657so323232685a.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 04:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794832898; x=1795437698; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zv1d6vvRKz0euN6zrXybl1bD0UkhPFP+MSK0/brc4zE=;
        b=xN3B7LudVvKrw3MwnajaarcX91x2+u1HXG/hvHMEH3ZnHJFdDpZBBcRtAqROyBktko
         X46g4lw7rRY4EZfOp3U9VNr6Ww9uTMObjYHuKm64PuVS6VZiijyYuVGHs7X5V0C9S2sH
         x1mxiPCTUha5+oNdEVrKnYfP19epAeCiRmmWntH6obG78ytEzkwYSmqTjW3Hw4HoLh3X
         A5SxyRIs01z3DowJd6F9SfiCmRrBIb9SignCreduEbMv4AiCUejw40piWsIP9NWhlFMc
         JSmxkHyWstT7aLbb2I7brvegGr9bpfFwWSZB9k+n5CKscylv6nxsyvHA5E8qXKFV3wL4
         fvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794832898; x=1795437698;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zv1d6vvRKz0euN6zrXybl1bD0UkhPFP+MSK0/brc4zE=;
        b=q+/HIGAkAGTzQS7MyYmaXjkVp+qhnjEekvLL/RATCh6/Phc/yMhcU1a94MRa/61pij
         zsgqdlvBwXyqgosIdyxr1DRNtW8mj74q6B5LdmvkhaPdK92zsEgnlVYeJYhTsX/a06Fp
         XOHpyMM/bpUEIDXfNLRkPJamid8yhjzIpDyVjS6afi7gUCCx9W5hDPF5dKITqoBTQBiK
         MECh6aLssOFvjz6XzUWAv3VITRq7QWbfYtW4PxlB6gFyVd+Grmtp0ToztwOfVFY0x1dL
         MK+XXkyvdAWVl9VNysdEkCUSYXmGAsYFvJX++QZDGZm0gqAIOa712RKl5gGZyLt8KqJo
         gICw==
X-Forwarded-Encrypted: i=1; AL+hErFGFDVWTEr5luogMFvl3Ro323beAamUdBPoD0ucIsMsQpzCgmMW2bd0ZobI+g0k0Me1NKU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/msnlZX3sjwG0kB+RATpccJngncwmmdXgQq29lPQJA5hB6zSll
	zdqWATS+uOuVzUyKu0Kl9R5OQ2PC5/W016Tib+Ij1r44TEVAGW97zbFp
X-Gm-Gg: AYBFou3c/C0gxxxPph7UIG5D7mBTiayRe+bJDh9hLpCmuMWzemwxDPuuhqCu42DmGJR
	1vnK0jc7gEYGHUp8OKHDE0RGEiuLns1t5bGialrNHbjhCFTupRQbB9vml8aB7eZOINhS0EH/GwZ
	aq75CLWLTKsCLYXTT4VgP6g9S1nKTU/DHP/LKVAf2UyvA0HB0oDt5xOgsN4LJ45vYXiFA5Vdn5/
	R+Bju/Yv+wLUw2Ik76epZon1iUq7TBRtSVtrnVj4OhpXGygkwMBJnatQhNf8c4CIo5jcWeS0L6D
	Bh6sGD2xV2kloJPW0Sgq8VU0KwMRAZj0bltoKR1rnwaJFts3jPPELNOMU15RBPerNSU9zVQtzjH
	SVpLnXr/BDMCouChdrd0I7AE9mN/5LkLJ0hqxLKgdQ7RQ7Mxg2x2XTifZNZcLW7N7zKfQ7YgZuU
	B4sR+8k1iRYCsleHfOFlFuFZDbWORzszUxKQuSYhMsY72b0m/Rtyms/yfjumG4U05aGeQYx5aSj
	X/1XqO3x28l/IGFxljhBIRfa9LlDNxStmOck8uzFhXpYkEboBeI+zKJGFV8RgA48iep5BF35tOu
	5hea2cdldf7T2kyYLOyOK76+xdXX+eSVew==
X-Received: by 2002:a05:620a:2903:b0:93c:a40d:e3cf with SMTP id af79cd13be357-9494b9c78a6mr1739169585a.1.1794832897831;
        Mon, 16 Nov 2026 04:41:37 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c870ad4sm830567185a.26.2026.11.16.04.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 04:41:33 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 07:41:30 -0500
Message-Id: <DMWN5R6QVUPN.1KP7SYYHHU71U@gmail.com>
To: "Todd Freed" <toddfreed@meta.com>, <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Daniel Zahka"
 <daniel.zahka@gmail.com>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>, "Wei Wang" <weiwan@google.com>, "Jamal
 Hadi Salim" <jhs@mojatatu.com>, "Jiri Pirko" <jiri@resnulli.us>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Sabrina Dubroca"
 <sd@queasysnail.net>, "Boris Pismenny" <borisp@nvidia.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 3/3] psp: only give time-wait sockets of PSP
 connections a validator
From: "Daniel Zahka" <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261113185553.171059-1-toddfreed@meta.com>
 <20261113185553.171059-4-toddfreed@meta.com>
In-Reply-To: <20261113185553.171059-4-toddfreed@meta.com>

On Fri Nov 13, 2026 at 1:55 PM EST, Todd Freed wrote:
> psp_twsk_init() sets tw_validate_xmit_skb on TCP time-wait sockets.
> Today, that becomes set whether or not the socket has PSP offload, which
> is not needed but is harmless. psp_validate_xmit() passes such packets.
>
> But a validator makes a socket look like it has an encryption offload of
> its own. The tc psp action in the net-next series "psp: introduce
> socket-less associations" relies on the presence of the validator to
> determine whether the socket has an encryption offload.

I don't think this is relevant.

>
> Set the validator only when the socket has a PSP association with a Tx
> key, as psp_sock_set_tx_key() does for full sockets.
>
> Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
> Signed-off-by: Todd Freed <toddfreed@meta.com>
> ---
>  net/psp/psp_sock.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
> index a6b1c42dd626..1df65505f1c6 100644
> --- a/net/psp/psp_sock.c
> +++ b/net/psp/psp_sock.c
> @@ -314,10 +314,13 @@ void psp_twsk_init(struct inet_timewait_sock *tw, c=
onst struct sock *sk)
>  {
>  	struct psp_assoc *pas =3D psp_sk_assoc(sk);
> =20
> -	if (pas)
> +	if (pas) {
>  		refcount_inc(&pas->refcnt);
> +		/* like the full socket case in psp_sock_set_tx_key() */

I'm not a fan of this kind of comment, but that's my own preference.

> +		if (pas->tx.spi)
> +			tw->tw_validate_xmit_skb =3D psp_validate_xmit;
> +	}
>  	rcu_assign_pointer(tw->psp_assoc, pas);
> -	tw->tw_validate_xmit_skb =3D psp_validate_xmit;
>  }
> =20
>  void psp_twsk_assoc_free(struct inet_timewait_sock *tw)

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>

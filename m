Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397062;
	b=OzAMBI47JQxf0IMsG66lenqXjucprEEHwkg/XWMbvSG0pNpPPyfdRmM2MbQ4exQmF6M+
	 JJel3rODQ5TSW1YhepzWt6yql6gDKzw61S1Z8t3AZ/0mTaGq2FH2Z9oKvIm44KAu9KXAs
	 64TfPG15qYkuA6QgtmaKK14GlUc6WE9OizaAMinecuFxHFTy1mVxac2GBl4I9NG4jI+Gq
	 JdxfbWdgVmPXXbdCXs2pgkgum5yhutYJ74Ckos/DLMl02QPHB9kRI1flmin0BPBzcuaX6
	 J0p6Cn/SaA2ogtajQ7UkH2fK7BYsXfOACZaklXTiHCjRzk0pwebLQnP5Epk5V+tES6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=GWmJbLCR3Z0PWF883WQy0SlXPcx6C4wxGpgsQpGnChg=;
	b=zSDeNzSO/nwxQSsUCgNhYTrQxghsMSCarQwOFYPr9LXPkcel+rrM3YKnG7vZO4FOXUqj
	 3neXAjvK8/T6Knlbx5DdB4AnU9sHG4isBSPjd9FpKHgCcV7JVyIPWe4oJGCPH+byfHVLJ
	 JX0i5ThDEFOcUxjdLPBSkmC54N+H77ZGad4B1QPKSzeG4Pc2YiiwtnkoFnqWL1qY6BZCm
	 AokSRLMljG5BdQomuClU1I6MOOiD/klBCUmZOzb2+IsqXITW0UzrnpCeOL/ZuldA6DEKP
	 2Mhk4Sq7OH1vtAAoXpF3VhwFQF97+6w+rNZJzEoJs6598NfJVpgKrqZeB6md2IYuNQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BlC5Gblx;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A90606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 11:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47A90606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BlC5Gblx
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-943e8d35f74so266067285a.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 03:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794397060; x=1795001860; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GWmJbLCR3Z0PWF883WQy0SlXPcx6C4wxGpgsQpGnChg=;
        b=BlC5GblxeuC6mh7E5mlcHWaa6FbwL7M5zsHQyzNo0ElWDR1HAb/10OXHf4NPTjJrYZ
         28qVLgXYI0cEYMl1lacrKBU6nz6AUicANfMZJzE7tO5nUNNb/YLGhvSTEHQIGzEOAuHd
         nVuqyNnNQTSTYCKjeMB9T9GmTGazkGf9pwsNZ07qbwteqNGC2d7g3SsUnHMTDJ/U9yLA
         UNk/kC7bqqiC/S3ciUXpdExCDcSYSMdftZTBSKD4owXddH4eUYyHOmIyppHH6JwIk37s
         OAcw2gv8gQOn9dcZudYcQ7SMmXcsyH1a+VEFKbwnhezz+4FwBTNzgzrVoz9I0rpjutiu
         fZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794397060; x=1795001860;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWmJbLCR3Z0PWF883WQy0SlXPcx6C4wxGpgsQpGnChg=;
        b=LMvUyGBRKIVkt8guvZ155Emyeb9A2ufQcOMRmaB4umt0p7xxZdNZnVXXVfn7EM7bIS
         8QGax7iFSy+fPWYwe0VOve8jwEeMwr6kZ3PMYL03SYLqucjy6Xps87wewDjQBpH1adRH
         vPVuwGpbXIKdFU7tSPkTiYRSRg6whXsffxPu6ldzQylAxMC4qKTG3kdbp2FLI1zgkzD6
         Bd901MlV9xIzkSzof0V0jyNWZMfTk/Y0yXio5sC2RFMYfrWkyh0OGEr5U+0KsPSP58bK
         hoVnJa1taOwY54A2wBWgrLGO3RvVFCzZjQXbc0Hz0bF7m+8qf5hIV0t4sIK/DmKmdMnI
         mJ8w==
X-Forwarded-Encrypted: i=1; AL+hErEcJzo9ku/gb/tYpKnlYZFsg0eH6h/72uaQFD7e0HQ9jCOr5qlaH3UQRCYn7z7kO+abG5o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pbGUI05vuA182YmqYo7XzRp/cejcV/BIhUqKY/O7C4oueNmJ3
	QcZLzTVtlVnyx8nnlT6eeLimnpr+yZhdYnxC7PugBY2LrIJYpNeG75t/
X-Gm-Gg: AYBFou2PTOf6vqoBw7fKTAFGQO30yS0Xntc7bQwq4gmzNsgjT61End3O+9o6grhC24f
	MpJU2jWZm6VGSklWK2T89ycWJPuXZVknqNtAlao3dvhscWuMXEPqNfczEvG/JlSairIenLmQsTE
	h0iOl5BqyaZmgs260nLK7LBB6jLD68NBSnHMjSLdgPYIk1E2GUzgW4H1FgG22ZH0F4ZGl2lX1Iy
	Jsldzu7VSJGgCICi5NSxaDAbskuEOxFzvDWVP76+nR2VbkPxprPtfcdrITQdtb2ZgFofe0rzahG
	Hr5rGklu9PR8oGTZ9+SKrNRMrEvDzVV15/8Lao5Hn3dvKkOg7dckwvr0LYJ5Y5o467I8gb9QcH/
	Mjhd9oHEg8lWEAcqWWlr6j9wXs/DR/QlZ5Q/u/D1fIzN/MFLBmubmt1KILPex+HMW6luVkKOb7j
	We9zxk2UXeKnZBmVE3G+GMT3zyd8DpjXqjvyXic79Y6pEVzsyRoEhdPIR4UZKm9b+67syXZnmAg
	38DmENld9y8awdiGWI/O+TKcz2tsCNjTk9mSC6s0p4xoeqY8ZxPfu9fJOD+c43XSodYDuY024SJ
	eXFp836G1TOAHqFOag5wFePLoamPc4J4CE8jzxZMltwdIqjZpKvvq4s=
X-Received: by 2002:a05:620a:4444:b0:93f:3e45:a419 with SMTP id af79cd13be357-947b002af5bmr318209785a.38.1794397060199;
        Wed, 11 Nov 2026 03:37:40 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7dc398sm462686385a.35.2026.11.11.03.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 03:37:39 -0800 (PST)
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
Date: Wed, 11 Nov 2026 06:37:38 -0500
Message-Id: <DMSCO4I434TK.15MMEZI0V4UZR@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?=
 <bjorn@kernel.org>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Daniel Zahka" <daniel.zahka@gmail.com>, "Donald
 Hunter" <donald.hunter@gmail.com>, "Eric Dumazet" <edumazet@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Jamal Hadi Salim" <jhs@mojatatu.com>,
 "Jiri Pirko" <jiri@resnulli.us>, "John Fastabend"
 <john.fastabend@gmail.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Paolo Abeni" <pabeni@redhat.com>, "Saeed Mahameed" <saeedm@nvidia.com>,
 "Simon Horman" <horms@kernel.org>, "Tariq Toukan" <tariqt@nvidia.com>, "Wei
 Wang" <weiwan@google.com>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v1 08/15] psp: only give time-wait sockets of
 psp connections a validator
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Todd Freed" <toddfreed@meta.com>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261111005533.6436-1-toddfreed@meta.com>
 <20261111005533.6436-9-toddfreed@meta.com>
In-Reply-To: <20261111005533.6436-9-toddfreed@meta.com>

On Tue Nov 10, 2026 at 7:55 PM EST, Todd Freed wrote:
> psp_twsk_init() sets tw_validate_xmit_skb on tcp time-wait sockets.
> today, that becomes set whether or not the socket has psp offload, which
> is not needed but is harmless. psp_validate_xmit() passes such packets.
>

This can get sent as a standalone patch. I would probably tag it as a
fix too, even though it is benign. I can't remember why we (I) didn't
put the validation hook under the branch, but looking at it now, it just
looks like a bug.

> but a validator makes a socket look like it has an encryption offload of
> its own, and the tc psp action, added in the next patch, relies on that:
> encap refuses the packets of such a socket, and sk_validate_xmit_skb()
> drops a packet with a psp association whose socket has a validator.
>
> set the validator only when the socket has a psp association.
>
> Signed-off-by: Todd Freed <toddfreed@meta.com>
> ---
>  net/psp/psp_sock.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
> index 609b06c7af65..664955bfb4fd 100644
> --- a/net/psp/psp_sock.c
> +++ b/net/psp/psp_sock.c
> @@ -330,10 +330,14 @@ void psp_twsk_init(struct inet_timewait_sock *tw, c=
onst struct sock *sk)
>  {
>  	struct psp_assoc *pas =3D psp_sk_assoc(sk);
> =20
> -	if (pas)
> +	if (pas) {
>  		refcount_inc(&pas->refcnt);
> +		/* Only for PSP connections: a validator makes the socket
> +		 * look like it has an encryption offload of its own
> +		 */

comment nit: for my taste, having a comment that starts with "Only for
PSP connections:" two lines under an if (pas) branch feels unnecessary.

> +		tw->tw_validate_xmit_skb =3D psp_validate_xmit;
> +	}
>  	rcu_assign_pointer(tw->psp_assoc, pas);
> -	tw->tw_validate_xmit_skb =3D psp_validate_xmit;
>  }
> =20
>  void psp_twsk_assoc_free(struct inet_timewait_sock *tw)


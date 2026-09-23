Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCBE41DEF4
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185594; cv=none; b=Cb764l434a+jT/UiLf3eGtg622omGJJSR5/RzhHldC4dbpf+oOSd3mwjxWo+fqiyWYiZL2JcgBUMs4dhaLLlT+aacllWX/4ZJCP1kyYrPsoehzeQrcWK9r2IQHtpd9TWDK1rfRANebvhTpgJ8aSWHJIC0HqF5WKCcN9aL7ih5zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185594; c=relaxed/simple;
	bh=f3YevRKPlnVtTSjlt1kYTG3kL0FTQuzETu7ncmtuDpE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HM1mgnV8oJnIhq7mQ2oxFbAGVlqSIFCaEH+OmfQ8uUoiLGUj95XeLi8Zq04PFFKmq0IcQj0uN2Y/GLS81ZuNI4x355lGjxHx4LO5NV/08TdmW/kKIBCb3sy9cPISQvhKtOkRZzDUfGR0e+zoTAOZjAF+BihTtx3TAtVBbbuOJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT/zpSu7; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT/zpSu7"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910cadeafso75369185a.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790185590; x=1790790390; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f3YevRKPlnVtTSjlt1kYTG3kL0FTQuzETu7ncmtuDpE=;
        b=QT/zpSu7PHKyQvPMsOlkRTcW3Vav5VLW0SGpwrw+lUwVe5VwPHwqwBeTB6mgJUjR26
         tA5OQfSzn1n9RJXhLhugYU7E3mWwCyagCPm+PsiAAAgYMcEH21HxXqhZeokoMIjQKJEE
         cNuUl2M5RkQe9Bg67nY2KWVxVDiZEO2TQffg6f+ptogKPz3rnN2KJmruEscGgz0zuhgZ
         AvMnoU6kWCJr/XupHeclmn1a41w+9LWUbCUPCEyWmaiT9EomZYb+sobagFbUG63MbiZE
         gMqKzHz0Xn2mrD+KNWV/2UcJywClWJjw4PfNyWrmHE9Pn3srOWXIveTNDLI+6kZc6VrK
         JIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185590; x=1790790390;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f3YevRKPlnVtTSjlt1kYTG3kL0FTQuzETu7ncmtuDpE=;
        b=SZ2ndWuw3Nl/fF3aGiwvZ6g0x6Dpjnm6WhFjGYv1/BdvYsjaBvRvJTgVcSnZgICOgz
         bZ9xYUTcHf7yIRfkk/GiyteIMw9CP9SdCq9pLV7T0WupNavkKvcS2H9o/ooMZR1iZohF
         pFJaKA+J6p6F0Zbd9qBy6k2GH0VqWl5LeTIf2kvfO8LfqeZipbo/u8WugiH827qZ6OKp
         Ppux7l4qIRDdWNr/ldWDEtMVhEAAjB/MJ/f6ZEmZE7ovI82QHaFy9WmEj1aiOMdSq9T6
         hYmekRwltrLRmkFykIYdLdD57ujNNaDwTzqfliXTNZ5yIjf/3A/Hg6Z2V60qhzH3U2xU
         MdxA==
X-Gm-Message-State: AFuF++ks0RhZRNExIT1bso4DlntfC3oSTRBgs5UbsXP5vWldvU/iklok
	o2XlmkQ9VB2lZuX5WzmGl+UtrbTXEF0cSRg83TqN8eWOFxJpyolHR1bb
X-Gm-Gg: AYBFou3qmoiAYAokHAYlPjqeNMrLNa/MVpiYariVSMe9ghal9bGawSlU4gAY2WXLqM4
	vqWiTrS6XGqQ3yGwA4A5EoyjU6KDcBqNnVQBiftn0Q/dFN1KB+E+Ab9T6mql26bGBR6J9DhwSD/
	KQYmqe5HRHw+6yxrps1Vlakbu0Z+dsyl2V/lqVTX0LYLO12Geb29yhoko3DuKUuL47QMFguGYzK
	msba5P9ihRF66l0UK3r77Tj4RWl9f+KBmzLO7K7wPOipaVqHLGCnojORBCfo1RdH0bxyWLrREUx
	6bBtvp1LPiVMl7FgsEiHA0Nmb1mTYbMdX0eMrYmB0LgLo7k4ov9BTX68FPZZplgOCrdGsrY4Bpf
	xHJ99N82395ZDcWUIvDaLJYC6MfaTuJVOR6CE7o9nUgH8eff1KOkaHZlIeT03WfbJrsWBzuzrNH
	d+zEqT43FxvY9RSW2lnde28PRo20D+CC/Y+S9eT0KlTO93QOKZOmZQny+7dAX6Te2F3TG5+9bJ2
	pM=
X-Received: by 2002:a05:620a:4054:b0:939:ff11:5328 with SMTP id af79cd13be357-93c250cc995mr521143685a.24.1790185590396;
        Wed, 23 Sep 2026 10:46:30 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2485883asm278842585a.20.2026.09.23.10.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 10:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 13:46:28 -0400
Message-Id: <DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com>
Cc: <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Florian Westphal"
 <fw@strlen.de>, "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>, <netdev@vger.kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com> <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>

On Thu Sep 10, 2026 at 10:02 AM EDT, Jakub Sitnicki wrote:
> skb_scrub_packet() drops all skb extensions unconditionally via
> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_rcv,
> etc.) and cross-netns forwarding (dev_forward_skb).
>
> This makes it impossible for a BPF program to pass metadata via bpf_skb_e=
xt
> through a tunnel or across a netns boundary. The extension is always lost
> at the scrub point.
>
> Introduce skb_ext_scrub(), a selective variant of skb_ext_reset(). It
> deletes every extension except SKB_EXT_BPF. Scrubbing is safe when the
> extension slab is shared with clones: deleting an extension only clears t=
he
> per-skb active_extensions bit, and the shared slab payload is released
> lazily by __skb_ext_put() once the last reference goes away.
>
> Replace the skb_ext_reset() call in skb_scrub_packet() with skb_ext_scrub=
()
> and also switch udp_try_make_stateless() to skb_ext_scrub() as well, so t=
he
> BPF metadata survives queueing onto a UDP socket receive queue and stays
> readable there (e.g. for a sockmap verdict program). Only mark the skb
> stateless when no extension survives the scrub. Otherwise skb_consume_udp=
()
> would take the __consume_stateless_skb() fast path, which skips
> skb_release_head_state(), and leak the extension slab.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Hello Jakub,
What are your current plans for this series? This commit solves the same
problem I have with wanting to preserve the PSP skb extension across
netns forwarding.

Daniel

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794891028;
	b=3nL2p1KOdgnEGjob9hDS22ubIxpquF9eBnR6Aho0aLVDzF4twsnQsnD3Ye/mXlkZvgO+
	 mn57TXQo7yGbiBYPst5xGT8fR6mDx7n4Sq4H/2qH4YVCGtmZ37XHFureazWNZ+CD2JIl2
	 AoirNiFmhdOU2xQLRnuRd4Sxo8RBQpZe++Rtg2/85+1y9vygwdQpRWfhia6wzmVEbpTZ1
	 2MqQaicEsWFDcJ3fZjRSYPDjN7dw7ZA3raHsI/Xz8EKgRB2fUrPLyr/PYJwVXLUfzqma9
	 FnZawcGHSI3NBN1qttTxP7texwztLPZj2lHWGdDDxx9Bi8pDnvP+NlAromSyaZZ2aXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794891028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=ZoSyoZQWdNOdSM4bWqLW3oD6P4gXP5jD57AsOWSPPmo=;
	b=1ZDaDrAOhGANI9skUPWeM6+sNDAPMVLZeCkhbCvsC39k31oOP9M1hMvb5jEodYn7tspN
	 IfMICu6dXT8RqVqtq/t5Gf14nEkOLujYbdWpAQMZ+tYBZyc03uXaarqVPgjV+pOwq7WBZ
	 6Zd3P+NLne+cyAo9/wWPX1t5bmIdBxZAWgw19zT4HYYr3pDj9z956f7rhWwI7wzaCc3wc
	 yW9oFYL8Ma5Nac3h1bl6lboM+1eT8StI32A0ImmCwra6r+WomC6VclnB7PnUxJ2W3Fr3L
	 q9Y9isSEHI7XQOyXsP5nmlYLas+nsBzgH8x/m/Wh2yZxXPm886z5evAEsvCD7lcTBZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ODDQP9xp;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D02606A334
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 04:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D02606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ODDQP9xp
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cddc597d062so2664533a12.3
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 20:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794891028; x=1795495828; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZoSyoZQWdNOdSM4bWqLW3oD6P4gXP5jD57AsOWSPPmo=;
        b=ODDQP9xpHuX6IZYldwN6KvAGbIS9mPgl3WX6YAeCyoE3ZeQcGPQyt64N2Pmc8cwLo5
         E0op/gga7XkwAcjSIi+3vJwN7vdMehi7MK6h1iAScMqecB5wOKNGl1BvAJqC+vpTghha
         4dQFttp/BxsItcM6yNk2DpeYDSbi/SDs6BeN0tegwQMad6V3WoR8ObWC94A724hVVvg3
         Vfb6az6HPk/XuWTHCq/unhAG9Gl/GQmvCcfsXwIX351USAaZelmsvYsLKt/N6UKN/upo
         Z+hSdp2CmySe01kbVMunGu29LVsKuI92P5bO8/dx3MAV8Gy8uC4pu8hVyXitQcDo/+oJ
         2BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794891028; x=1795495828;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZoSyoZQWdNOdSM4bWqLW3oD6P4gXP5jD57AsOWSPPmo=;
        b=NGw1iyJ+z2xqngEr/qJBofi11oEy5NNY2wx5jpCKQhAtru/O9Ib8iK3DNQcBcguGWd
         /P/M6lsuxX7iNF1NH1tP35vRIZJu6eV4lpzhxAkLDHRYyh3mDOkD3cqtXTfJ4qoGJEWh
         Tbw3YcU2DSz+2IvPJCZ/CVB7TLaMNGjczsjPe0iubD8TtMrTWm2ComdQBZoneqpUEYNZ
         KqRL0GkJk8+7UQzgJ2CsQhqWiBG5W78BZT4FQivGkhQgOHvfkTsQYzFLlZ7+FUAgkV5w
         CcS2vRNyUGikDbiZkJUPI2MQXA+d49jCsTrLresRdhIfEcBN6M5FyJ7mUX7Q36MO8SF9
         nhug==
X-Forwarded-Encrypted: i=1; AL+hErGQCBw6YjeAI7npK2NDQp3p0GuldRTPjRgdno0ozZ//kZ+GhVgpGjDSzHkyLnWPnneAC0g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PYq927EjuKDfdJgX5V9QaJ5QrUKuOZeaZA+hlH8R+TQsVwggJ
	96mWDj1UKrYHToPEGlJWtpyXOEwVdqceij6Dl97UN8Bk0LuXS0j31mls
X-Gm-Gg: AZFdTZf21cy4FL+cNCkLNAG6yyH5dUE52n/W054JfBMKHvDbTWyAmZ+3vSO4Qg9r6hp
	UGcya7pFyo3b2lM55E0zns7Syz7DdwznVyWPgqMX+tShiyppLjLHvsXd1sd3jECXkuWxkqNi2Cm
	IvYd2Ykjay8PoVLM+CuiTn8yQCxOpL7edPkwhlPq0sq7pGUszr6b0PTjWIomoWRMtfMxpaSi5j2
	oAoFkXHhyn8F8ARvtcWXa7/t/+HAhgD2dHKMmZK2cHD5xDgYyCkZo0p3fC10ozxdVxLR2wJVfjN
	Voq783PijlHbPpzF9gD3dq0YEY1qVjKTo0se0B95bZWb0mqwfYpzZRU67OXHK/2qfCWUovgXbn/
	pGX62eqYyX89dW1f3LdM+XG+XpUXK8dAxFnac5FRFSiXyoSpNQGrZ6mxSQZ4XqlobS1pcmyKSiW
	BeWOw/pCzW0j+sPQjwMT/kcr7UFoXKteCA7y/Lh9PcltlGAH5jP7tsI0nn/8i6LmI4EniiCfJ3t
	/2xc425yTJflB8QNnBsz3n39Mkl/kZj072WdQNazM2fg1L7q3f5PUFBsQze4vf6tNLZBqmuHSc7
	A5croUNXq2hNYYwHfnNeCG/wf0SYK8E8p9pURyDTRj9TC25Ur2vO9Tez9OaGWd4mGQGh8eXknTT
	SBRBh08okkAAI0NWLS/THFgNqpfJT/jZT/Gw=
X-Received: by 2002:a17:90a:e187:b0:3ac:9c37:9426 with SMTP id 98e67ed59e1d1-3b1b0ba53d2mr13944527a91.31.1794891027347;
        Mon, 16 Nov 2026 20:50:27 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abd06666sm1989515a91.5.2026.11.16.20.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 20:50:26 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 04:50:26 +0000
Message-Id: <DMX7RM93TMGR.AXFN4YJ55REF@gmail.com>
Cc: <netdev@vger.kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 <bpf@vger.kernel.org>, "Jiri Pirko" <jiri@resnulli.us>, "Victor Nogueira"
 <victor@mojatatu.com>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v4 4/4] bpf: drop the stale dst when
 redirecting to an explicit nexthop
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
In-Reply-To: <CAM0EoMk10vCoAKZq0P=8A_jed=Z3SudLEUV8uvXO5F=ewNjnGQ@mail.gmail.com>
References: <CORE-9NOG.v4.r0.20261116135311@mojatatu.com> <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com> <DMWXH28YQDYH.1SI4Y5WQ7EPSR@gmail.com> <CAM0EoMk10vCoAKZq0P=8A_jed=Z3SudLEUV8uvXO5F=ewNjnGQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 16, 2026 at 02:06 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> encap ip/ip6 or encap xfrm template the tunnel template lives in
> dst->lwtstate  that wont work (packet reaches the tunnel or xfrm
> device with no encapsulation).

ok. agree.

> For that reason we cant drop 3 and 4. I see the change in 2/4 (I see
> 1/4 not changing either) .  The change is not that small because it
> will have to touch multiple core files (although just small mechanical
> surgeries). Summary it will still be 4 patches..

can we keep the route and fix neigh_update_process_arp_queue() instead ?
The bug is its lookup via dst. Only teql needs that lookup, I think.
A is the device of the route, B is the target of the redirect:

  skb is queued by        skb->dev  neigh->dev  lookup via dst gives
  ----------------------  --------  ----------  --------------------
  ip_finish_output2()     A         A           the same neigh
  bpf_redirect_neigh(nh)  B         B           neigh on A, the bug
  nft fwd                 B         B           neigh on A, the bug
  __teql_resolve()        master    slave       neigh on master

The diff skips the lookup when skb->dev is neigh->dev.
lwtstate, NBMA tunnels, realm and ICMP errors work as today.
The fast path doesn't change. No need for patches 2, 3 and 4.
and 1/4 is not a prerequisite.

Your teql 3/3 queues the skb with skb->dev == slave. With this diff
the neigh of the slave adds the header and sends the skb.

thoughts?

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index d6e9c7c..04758ca 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1331,9 +1331,11 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
 		 * the packet in the output path.  So what we need to do
 		 * here is re-lookup the top-level neigh in the path so
 		 * we can reinject the packet there.
+		 * When skb->dev is neigh->dev 'neigh' is the top-level one.
+		 * dst can be a route via another device after a redirect.
 		 */
 		n2 = NULL;
-		if (dst &&
+		if (dst && skb->dev != neigh->dev &&
 		    READ_ONCE(dst->obsolete) != DST_OBSOLETE_DEAD) {
 			n2 = dst_neigh_lookup_skb(dst, skb);
 			if (n2)

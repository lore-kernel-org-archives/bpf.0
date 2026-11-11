Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416482;
	b=mq0iiQ/yLdt3aTOt3bQBghb/ZwrmfZrlhN63rxBokNvNc5qve3fqXotuwWKpZoyqlvYl
	 hVTdE0HL2bZA5FfA20wmRN7ZmCPbb2TCdU3EeEWD0Y6qcjqeWoo0msogpFv84iSeLqHII
	 cjC/lDglvZ/34aB6/4SgGYZp650EYRX3uHNAIRAaduIXvjKVlcz1gAFjpHWqgiCkOqEzr
	 JvhmoyOBUEWNWMwTxvGwhl/YJvTJ4uS9uX0i0NZh+8+q1vlxN6/KyPIRXXgE58rVedbOv
	 4Pz8wj+nNFINiaKwaahwOfOVfRD/OadHhdayy59aY9u8CVZdAP13nv66qbCH0/Nm9Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=cNJr3c3uqZZVhSfWEr07FcVM+B83XjBK0ipGpurD8/w=;
	b=YQSU3we1TWJnGYhMM3b3aBKwxP6B+c7PXfIlBfFx7vlgS4kFWgrYuqy/jQVyBjP8Wn/t
	 FpiWZggvW8l/5nd9NkaAjawy+VshpJtJG0R2/dYdHzKxm8v4Oz8eF2pNXyko+rwz3SyJZ
	 qO5t7+Cb6OpA1gbZGbUF977ji33Y3n/o1iWyGAXbUnXqqCNRmnulQ75HY/nyF08lR6svd
	 IilOY7//y/M0wQpFckUsQBWg42On8Wv1G6V+kh7T6/Hc/GvtrNRAmP8hf1IOhNYU0K+dO
	 vXTQedEpwxU4X0oExMFsFWfBOTXstQn088Zv3OKieUcnaPwlh0jOjry8/VbbIw1D5LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eV24wG6k;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D35606A32A
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 17:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74D35606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eV24wG6k
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d2e43ff4b4so33054137.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 09:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794416481; x=1795021281; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cNJr3c3uqZZVhSfWEr07FcVM+B83XjBK0ipGpurD8/w=;
        b=eV24wG6kUDKl/1BRzugsFu4O6Q8IMvuBMVX/hw3IwA8m/Qdq9KxFfGNdIwU/1eK/S/
         ryB9W0aiepskzNkxFtuLuS1B8mDbwU0HwpPUMSHmC1vGEAs3AcwgrIuW2dj/HE+iOpfC
         c2D/uE7ouHDAkBbJKtQh2hwdmG3Kxw5BCw6dYMAOxlPArZVX8CZnIRFqD41fzK06ZI1q
         GThZ1b4wU1om1c6zeGKhdtmLDrJKAvlzi1ckauC5O0yIfDFOTVBPJyXqT0g4guj/7j90
         CH18VtYry2bKaO8SsBtHxaYYhBDJn51m9CKVYwR7LJa5RW9yCa7mGQnRL7KBGekkvjZ2
         vXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794416481; x=1795021281;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cNJr3c3uqZZVhSfWEr07FcVM+B83XjBK0ipGpurD8/w=;
        b=R2r3YGE+ht9uU8zVgf4CmjmaUazQdbP9hUkIHhodi/UWN7yBhz3MRXrtBG9KDtk2Xs
         zTpGzwoQzqHqxNwu9KxQ6bJ08+0s7eRIi5oucyDjfSzUPskpn8QNzRuFB7DmlKe+Z+xz
         CWO2p8H5BKEXbOJP1rjcn3rnbELnNMm/fRuzD7YpvWnCOEWn1uFJc8jEw8FSlrhaCjSp
         TvfbS5Md3l47oL5Ak8aSNhaHFhSgH3dHPI12xYDNV2CbKC349L3Uouj7WLkxuVJCfRWB
         LnvsIcdaGLkUMdDI6mG6u4Von0ODzBu5YioB7wrK+SGM2UgXFDqNa0ctxETGb+fux2BC
         pmfA==
X-Forwarded-Encrypted: i=1; AL+hErHAuXAXT9A5Blo/2qJTTtqk2F7/3AH51zioblZnl2145b+iRx7UxgKj1rNdklmzpXPIeHI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SAkFCkq/WfAKwskVhiwHFNn4BYzWKKGWdh1cHXK1fX71WpJ17
	30v0f2Y9oNpmW2LZDGrMV9x/aT2KIKhuGnuX4WVURL9xCgKx/MsqJ8c/
X-Gm-Gg: AYBFou39p1SctYqea12IPd2lgzLmtgvrxltPCdTicyqjnqmLW0HfLZntg7RwUCasV22
	5ReIoZwKTn6K/wfBb1Bl4XtDaJr5CBdFcqr3tqHmATCTDO71oeqwJURN7fdzhWz7l/tRcAxKY+N
	fFUXY/eVdNur9+mCDrUQ8TdnWMfkMWlCpD8ES8s3WTfoxwvzCeZ/LexdhSm4SoqfDeF7yG3kwnS
	nPvI2p+dtMbNIaQpNAk0Ba7wD714kOb1WicajXU4xIGDW1Df7U7UV6u5GH7lzUeu+JYpNQbiMCh
	/I34T1opg36Pdb7g3F5u54XQvnWaDcY7OH2kiPNHYORkDXcwEC/PBCsX8LiEe8hZbJYC8DuGNgv
	c9/BdZDS7aDh1CqA/LIAZicvbzsg+DsjiSmlZUuDiPlDbOZMnma1WdYyRXOqoUqXCGlGuGR8PsH
	ZHDrnQl76JZlBb9bB6DQKnm3xhasfMrV7egfjpqg2J+B5k+I1YeNtYO0hQvo2t0xm+RirGagqAu
	Nk44R7zviGqGu/svgiSaRFNB9BwDnUJ/7dFmYgi94hVnCowuxWMcgNv8tVyIEa1gFqCoABIFs+w
	KDR9tWmQUKd17ha9
X-Received: by 2002:a05:6102:a4d:b0:7cc:905a:331a with SMTP id ada2fe7eead31-7d6316c856dmr19138137.14.1794416481052;
        Wed, 11 Nov 2026 09:01:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::6:868a])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302239188sm4078178137.2.2026.11.11.09.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 09:01:20 -0800 (PST)
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
Date: Wed, 11 Nov 2026 12:01:19 -0500
Message-Id: <DMSJJY9PLHSR.39PSNUXEC82J4@gmail.com>
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
Subject: Re: [PATCH net-next v1 00/15] psp: introduce socket-less
 associations
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Todd Freed" <toddfreed@meta.com>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261111005533.6436-1-toddfreed@meta.com>
In-Reply-To: <20261111005533.6436-1-toddfreed@meta.com>

On Tue Nov 10, 2026 at 7:55 PM EST, Todd Freed wrote:
> psp associations today are bound to a tcp socket when created. traffic
> on that socket is encapsulated in transport-mode psp, and encrypted.
>

You can start sentences with capital letters in cover letters and commit
messages.

> this series adds associations which aren't bound to a socket, which
> allows psp encapsulation and encryption to be applied to forwarded
> traffic. you can use this to transparently apply psp tunnels to flows,
> with help from userspace to manage the tc rules and orchestrate key
> exchange.
>
> the lifecycle of socket-less associations is managed over the psp
> netlink family. socket-less associations are stored in a small registry,
> and are addressable by id. the registry does not contain socket
> associations.
>
> socket-less associations are on the device's association lists, like
> socket associations. rx ones are therefore marked stale by key rotation
> in the same way. in this series, nothing acts on socket-less rx
> associations on key rotation. instead, userspace should replace decap
> rules for a SPI before its device key has been rotated twice. a
> follow-up will bring enforcement.
>
> series structure,
>
> 1, 2/ prepares psp to work with non-tcp packets
>
> 3, 4/ adds the netlink commands for managing socket-less associations
>
> 5/ adds a METADATA_PSP dst which carries the socket-less psp association
> on an skb for tx, and the transmit checks for it
>
> 6, 7/ keep mirred and bpf from sending decrypted skbs from egress to
> ingress, since skb->decrypted depends on direction
>
> 8/ limit time-wait psp socket validator to sockets actually in
> time-wait. the new psp actions check for presence of the validator
>
> 9/ adds the act_psp tc actions, psp encap and psp decap. in software,
> encap is egress only.=20
>
> 10/ adds flower matches on psp header fields, for rx matching
>
> 11, 12/ add drv-net tests (netdevsim and hardware)
>
> 13/ makes tc-testing run dependsOn probes outside the test namespace,
> where they currently always fail
>
> 14/ adds tc-testing tests
>
> 15/ Documentation for socket-less psp associations
>

Some of these can probably stand alone like the bpf decrypted, psp encap
helper, and timewait validation, and be submitted first to shorten the
series. That's just a suggestion though. If there are dependencies on
the main series you can ignore.

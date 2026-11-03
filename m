Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730540;
	b=yUkpJ0i/ofQ0SCuJ95PKopNofqIFCx0vAs2ptUi7SxqpOaG4oWOGvdXZOr6cBdfS9dWY
	 BebF/JaW9n6YII3vdrIHPIZ/eKUZhMUiHchSFnxGltxDE/u1fU7h0FaTX4Uv/b+cyrdk3
	 nRW08y/mBekhTCvs5FiRN9VNDqMZVurX1PLfkSnwam6rwTzQYLUnI/9Olz/oZi5ef42wt
	 EOPB/yA4wZl4i+kad1PcmGZt8o9BdcBK6sOFAOiS96NK7oDgFkEVSzRfGtWrmLYLVRnMF
	 1kf7rvGWqxskYBD+/IzzXpChcfV//WIY0bRWkThhXEj4oPlbUv/8vjJGaqv0cVK7YOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730540;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=A2SxbtdInviKmhuZ6qhITPKihTTKCU8zqlv1zCWXFFY=;
	b=X+lwaQ3wPaUzAQev7NhyO/QRDLzlTZqDaK/0lwb9s03+KhD+XVd3mTihjYDBaSRKdiMh
	 DSdPPOqcc7t+7GxYUemkARrUq03TUDdPMWha5aP/dkzRoIBgyqiTFHeFS7HG43LSfqKKF
	 j92jrWD5dRK7i0uXxrhv0GEGMffSz1d14M+JoEzQg86f8I8OUP9NnlRzPoMCulXTe7g0J
	 vF3Zy0leFzkkQ5zY3U6sKtJ8fdtfmeddUCRXITmxbKv+W0aueiP9Uhux2mGGgaKiCK7zq
	 TvV7Z6E3CWbSnXUsBhGqJbBN1Jh+urewXsWVf+OqBt6j1FUXtshVR+XPlUoA8dHRucw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWTqrsFV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A2606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWTqrsFV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604A21F00919
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730540;
	bh=A2SxbtdInviKmhuZ6qhITPKihTTKCU8zqlv1zCWXFFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eWTqrsFVSCOoYkWO6JKwgxZuZbuyGCUqOjMv2hJ+fgZhXiUMArt90EvcdZH0kBsPm
	 SKpH4PJpntYX3RqET8dHhFZdjNDDCbJ2M2SKJjhf8Q2JAgYkrkte9awr31Hr44qSmq
	 ubysmm8JJKzmgJ3UPwM7S90X8doOeOlcejbs0IeS5W4D/ZU/sgpni+vTjlGPegD2sU
	 d9k5eaYNOJe5pu9tVWan1knYixg7QPfXH61E56pEmGWzVHyXLGd5KgOdGznJvs/1G6
	 +6jPHvaHyZ9aGhQJGPKTO8xZ4TItOjfrAMsZcvKEld2ozllOt+Z2Vc1GeUupBwhDQ1
	 BpcAZvVx6btBQ==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93efc0452b5so292228185a.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 10:29:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwwmsxuMJJn27GfiCsapgktKnjNFCJA5s8E04gmr3wwtbvSofnQtCYg7pu2zb+HyWeb0A4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0ZVqy3Zco2USqzCjf8sO6Ssbq9mJlzPQ4XVnBdMxpoAuCoVV9
	LWCySnjfa+b2pBBJrS5O5oAZKFpfj9Ir3Qa5hCqYPu2jNSYU9gd36qjLrxs9hzA0ON3RsygvlR8
	uN/PzT2LZcE3Peri9rhQXqRtPLSB1oCA=
X-Received: by 2002:a05:620a:3196:b0:93a:824:ac8d with SMTP id
 af79cd13be357-944216b1afemr2371370885a.27.1793730539153; Tue, 03 Nov 2026
 10:28:59 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103025610.3738894-1-ridong.chen@linux.dev>
 <20261103025610.3738894-8-ridong.chen@linux.dev> <CAGsJ_4xCTSctcPcC7X6Dx4zYaOycaPqs0DG7AaxB55wx1Afwpg@mail.gmail.com>
 <9cabcddf-d807-4a36-84f1-5bb06ea72aac@linux.dev> <CAGsJ_4xXDZjhN+NkvtN+vAp8Bokack_JdNgP=nGPQtHUX8_rqg@mail.gmail.com>
 <f5137dbb-b0ed-44ea-a23f-5c848315a68a@linux.dev>
In-Reply-To: <f5137dbb-b0ed-44ea-a23f-5c848315a68a@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Wed, 4 Nov 2026 02:28:46 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zNZynkZn1mb+nT1n6dq4n399VC8Lbo5Sv92gioDfPxUg@mail.gmail.com>
X-Gm-Features: AclHuK8ocj8au7qeT_BVvieNJJ4o0s2vwCrhyBoxk-38BXmuY8mPvZOfmLABhGE
Message-ID: <CAGsJ_4zNZynkZn1mb+nT1n6dq4n399VC8Lbo5Sv92gioDfPxUg@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] mm/mglru: add tracepoint for inc_max_seq()
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Dave Chinner <david@fromorbit.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>, Ridong Chen <chenridong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 8:23=E2=80=AFPM Ridong Chen <ridong.chen@linux.dev> =
wrote:
[...]
>
> Hi Barry,
>
> Agreed, I'll go with option 2. Two things I'd like to confirm first:
>
> 1) To report the reason, should_run_aging() would need to return it
>   instead of a bool, e.g. an enum like:
>
>    enum lru_gen_aging_reason {
>         AGING_NONE,
>         AGING_NO_EVICTABLE,     /* eviction is not possible anymore */
>         AGING_MIN_GENS,         /* better to age, eviction still possible=
 */
>    };
>
> Or just report sc->priority, swappiness, max_seq/min_seq and the
> per-generation nr_pages, and let users derive the reason from them?
> The former is more direct, the latter keeps should_run_aging()
> unchanged.

Right. We can let users infer the reason from max_seq,
min_seq, and nr_pages in each generation. This shouldn't
be difficult, especially since should_run_aging() may
change. We don't need to spell out the exact reason.
Just present users with the overall state of the lru_gen.

>
> 2) try_to_shrink_lruvec() has changed quite a lot recently, e.g.
> Kairui's reclaim loop rework, and your swappiness series also touches it,
> including the aging part. Is it stable enough now to carry a tracepoint t=
here?
>

Yes, I think aging will always be needed, regardless of how
we change the code, so this should remain stable.

Best,
Barry

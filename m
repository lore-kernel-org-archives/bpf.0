Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579690;
	b=afZV06+m5ougPmi770L/Jxk9eygUAj3Fw/CVX7/k5R56x3j63FYRhaBqaf/q7hK6aCGp
	 RWPrN+EL4kqPbpkrIjy0leSxhGgXboViGsQ819MTtx2KHfqicykGhB3gP99HIdhr7OPK8
	 avqz9A4I2w9we41YmCdDxgBid1tIgVns9OmHx34ue8K6EaDfdfSl61xLwIYmZWjZWKOvS
	 qmeu1IU7i7z46df9/pyCWBFRoJTxFKKINOl5YOCE/krgzq4x01TuTO0J8FYEEB/nIqJt+
	 GtSbABlfON5QN2mXdf536UVGgeE7fAHKNTi+Lf2Q926bI4gdf7JBTk1ph6HtBYZaeuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579690;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=S0UAZkO3R9BxaE7FunGELgGEYBEKadUWsdKG0S1VcpU=;
	b=3Hzp05B48lRFT+9yB8fpUo6FihLn3oAi4EmuS7bJTn5NcWnCr0HZpQ7t0cRnf4pyVDiH
	 610kycLn1XyAphGjhujTu2qXEOTYj35BcR3vzit+WPuhfy5+pihlKwdGvplNrgT5dTOL1
	 orG4acFh1lcjMWvOE6eGaysBJIosGYq33bFwxtNSABsmyU6jM2fLYhW0t+1uct9kEGNkc
	 j99V+PGpteXrMkuoS56b6N5iwTkstVdL3qjZmE4ZorQOqf7x5q8PXEyPD4eouoDiYUtRh
	 uo3SNzH7JI82UZ9BaawWGLwL+cICVLJEmw4eIdobghLlOCA2zGfO62NuUwXynU43M2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lS2AUAso;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348ED606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lS2AUAso
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B07F1F000C4;
	Wed, 25 Nov 2026 04:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795579689;
	bh=S0UAZkO3R9BxaE7FunGELgGEYBEKadUWsdKG0S1VcpU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lS2AUAsoYpogSwRY3T+g8hHpKgBBx/TzIfv8oqg5uozKQ0DiTY3ZNytHZ8SitqO29
	 XLXQ6JHSDdpap8U+RtglaSztWb2RnIhLVE5mZFeTQikG4bOUbGsAeITccPSD7Dmge1
	 LBK8SYNkGQ8ZdRJbjErkkVkecg+FrPBKtYNlt262VG7VloulgyDigYTfKO5p7Q9eYD
	 ungGp0kdW9pjeg3PVLUOrZLPHWEnQ1tmfjpvyrpvULJRy1Fi5ZRxlBZwxXDTDgOse/
	 1tw7demqDJXskRfhrogVB4zf8V3VTWbijHHcgjDrdbH/lrJdiv9ctHMhY8yyhcfotx
	 LSDJRfaf34cnw==
Content-Type: multipart/mixed; boundary="===============4203316926115072957=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <76a830e53a16a94bc2ea72687ab065473af6c5b25d288e31f41a78174ab41ae3@mail.kernel.org>
In-Reply-To: <20261125032938.670542-43-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-43-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 42/47] bpf: Take a neighbour of the L3 master in bpf_redirect_neigh()
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 04:08:08 +0000 (UTC)

--===============4203316926115072957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Take a neighbour of the L3 master in bpf_redirect_neigh()

TL;DR: Commit message only: the Fixes: tag may point at the wrong commit
(ba452c9e996d); the review asks whether it should be b4ab31414970, which added
bpf_out_neigh_v4().

>     bpf: Take a neighbour of the L3 master in bpf_redirect_neigh()
>
>     bpf_redirect_neigh() takes the neighbour from the route, the skb gets
>     the device that the program has named. They are not always the same for
>     IPv4, and the queue of a neighbour is purged with its own device only.
>     When a L3 master was named take a neighbour of that device, as IPv6
>     does. Its driver drops the header and routes the packet, one entry does
>     for all.
>     Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support supplying nexthop")
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>

The Fixes: tag points to ba452c9e996d, but that commit only added the
nexthop-parameter branches (nh != NULL) and left the !nh path, which calls
ip_neigh_for_gw(rt, ...), unchanged. The behaviour fixed here, where the
neighbour is taken from the route while skb->dev is the L3 master named by
the program, was introduced when bpf_out_neigh_v4() was added. Should the
tag be:

  Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45542192835
--===============4203316926115072957==--

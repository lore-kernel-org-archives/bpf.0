Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63353B27F3;
	Fri, 25 Sep 2026 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363754; cv=none; b=hnSa1+oFjwNtfm5eNTNnSXL4dHeRwhqutDPZ62dpueuUkUueo04qTiYXcSzNQfwyd4Rhut+aXEIMxObOHEPMD3CknCoiaCoU7D5f65c07hXu9tEKRT+eTqi7jnyAlUz5M1KLM+psV1eN2iv00GMpNkhkPoUf/i2B49I4XrAXly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363754; c=relaxed/simple;
	bh=oemG2sJfBHkY2Br5LCPtbpT9NRroNQIC15l8mVwmdMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5Ob2F1+lLE0g/Yp9xHO6LHB02J3tpDCM+WZL/WdFaGy+1sSZQrEFeYiZe+RiJ/+NfBF4RQQ1/PNNj56aszNYdXj3fwcyuS4/h/wL0pAfn4O1Guhx5T5AMa0CB8rV6wL7UPksTAAW2+wYdfyblFjoQmpcfJapuuhz/DJAtbJ40E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/AzY73H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/AzY73H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9885F1F00893;
	Fri, 25 Sep 2026 19:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363750;
	bh=oemG2sJfBHkY2Br5LCPtbpT9NRroNQIC15l8mVwmdMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b/AzY73HNggWkeN7lXNSYKRJ2+e5thQnkMzKgzVJWVI67Fh00d65hz343VpMMAGyL
	 /w+H8Mcc7ZSwgtbOZpSy5duwK6zhjq4Wjfd5MJoAR+kvGZafTd59V1liA8m/vFLxYs
	 zYujVgnXjC1zBGwvXoFH8kMWCrVI5R75xvBFITZW5GG2yyvJ/hVp8LCHH6XvnlRqvk
	 rokNIDp+1OnyWtjFzVi2kxyhbFCDY64NRP0i1DGO42Fx8BmJ5036bdV2hLL2aRW5VD
	 FRcIkdAiaOMCjgvEBmc4M8L99b/YueLBHW2btBDgDxSM+LMzmOokay4eIFbPFFwZc2
	 W4l9PFPGc639g==
Date: Fri, 25 Sep 2026 12:15:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Willem de Bruijn <willemb@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Martin Karsten <mkarsten@uwaterloo.ca>, Jason Xing
 <kerneljasonxing@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>
Subject: Re: [PATCH net v2] tcp: prevent stale tx timestamp keys on rtx
 fallback
Message-ID: <20260925121548.6c0c8cf1@kernel.org>
In-Reply-To: <20260917172050.2191062-1-dw@davidwei.uk>
References: <20260917172050.2191062-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 10:20:50 -0700 David Wei wrote:
> tcp_tx_timestamp() can select skbs from the rtx queue when all the
> copied data has been sent in tcp_sendmsg_locked(). These skbs may be
> already cloned, sharing the same shinfo, and handed off into the lower
> tx layers.

Not sure were we are with the discussion TBH but this is now the oldest
patch in patchwork. I'm drop it, pls repost if you want to restart the
discussion (modulo the AI review).

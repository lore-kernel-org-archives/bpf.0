Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E038911B;
	Thu, 27 Aug 2026 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858417; cv=none; b=MFSbdIXaAdxoFN2C6QBIlZyyjWgnmuxuKyZGrUGAEMCX9kFFfFWNGsTnRhBsxbih6Gss/HYalhwugarxR9KUvpX5eFcmVrzkBm6VN5dkSZgrrn9yAEtuTwPj0QLdX4UyHK0ZZALRv9TYTRvNrmbmpi6kOitYkbqii7TUMS3lpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858417; c=relaxed/simple;
	bh=GgAzbW4hpDh1dPfxqxyBbADq2OQsz6GDNq+ncbYlolo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnVTvJ5KSHZm5X4IUHY8KC0afnwZX06Qg2WvRcNag7kkt1FEkPuqnYEQ9eztbRq8bXRe7YQyNrqiumy6u9tl21polU06QI2gt1NdytXnOb6YXtTE3UFVaYd2UvoJH0fkaDFBAjhzjW5zSeNwoGwmSZY/1l7nh55t5BjSAYNHILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGqJUdyo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGqJUdyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACFD1F000E9;
	Thu, 27 Aug 2026 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858415;
	bh=GgAzbW4hpDh1dPfxqxyBbADq2OQsz6GDNq+ncbYlolo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dGqJUdyokh6uZiV61YC+ZNKbs42k/Is7G6nW5fY9g60oCRekfDmCWBj/WDVFTwQG/
	 NKw836Td1p52MZynToM8uTwW2XzVdXKULPDOX80c9I5C42j8deon0tIXEBfnJF9mLl
	 M+dOoPwVw+hJmNHFAMLxQPvSW0QmOD+9rXpP92ubdg4Cs/tE6F8BeH4Kmoqwoqhh9k
	 Jp4SCi/9ZuXfeVneS/PCBtbkMxW8mg4XekvuFsHxQ3Xvll6usr9h4o8aA+sZYq1rC7
	 eg7s6eWFcrf1UoFtn8OiffNKJ1Cmj0sNhStsEXhQlkaUX3PdSlKNfJmWG+yPjaOf79
	 k8daud+q8AV6Q==
Date: Thu, 27 Aug 2026 12:20:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Simon
 Horman <horms@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Krishna Kumar <krikku@gmail.com>,
 Martin Karsten <mkarsten@uwaterloo.ca>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?=
 =?UTF-8?B?cmdlbnNlbg==?= <toke@redhat.com>, Lorenzo Bianconi
 <lorenzo.bianconi@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf, veth: xdp: fix page_pool page leak on
 skb-backed XDP
Message-ID: <20260827122014.79ac1694@kernel.org>
In-Reply-To: <20260824030705.266049-1-jiayuan.chen@linux.dev>
References: <20260824030257.263179-1-jiayuan.chen@linux.dev>
	<20260824030705.266049-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 11:06:43 +0800 Jiayuan Chen wrote:
> bpf_xdp_shrink_data() frees a released frag via __xdp_return() using
> xdp->rxq->mem.type, but that type is wrong for skb-backed XDP: the skb is
> cow'd into page_pool memory while the rxq still says MEM_TYPE_PAGE_SHARED,
> so the page_pool page is freed with page_frag_free() and we hit
> "Bad page state ... page_pool leak".

FWIW I like the idea if it can be made to work fully correctly.

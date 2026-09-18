Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75983905E0;
	Fri, 18 Sep 2026 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696774; cv=none; b=G3SEH62GvkZGRAd445yP+QJa/4W2V0YZNqMbz39fY/A7Em8Pw4bHpRXbkdzUNCP/EC/b65UD3alx4KgmmoyD394zfY3NRoZyrBWitiNCvaY6/6AiX9pqQ7hwZHu49Kqg+aBrPCoxPgbgPYwXDa+GBNObwRPyvW7T8sL6ljxcUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696774; c=relaxed/simple;
	bh=gYdkWASzdto4w7d3rcLJnbDDH4XmI/DyXN8bJd/CAek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avKkYp5tdAEIRrVIA4LMtaakNnpWcymSPORg/1mbw18FFwzwdVyy2Iyp6u4zxx0RRUpqjVxTbCsubW58/XMByeOEiLcv+EzZ3eGAxvaPg1919B0oOZk1f/S0NseyyRJCRK6ZRR/3qAdsdgiS1ryx+qdvtb+zjQ7BOTwnPQOlcuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dacUQKQy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dacUQKQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23D31F000FF;
	Fri, 18 Sep 2026 01:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789696768;
	bh=gYdkWASzdto4w7d3rcLJnbDDH4XmI/DyXN8bJd/CAek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dacUQKQyWtVSbYPvJiBlAX4GrtAshKdsLhPjk2g1CFDbfWR9yKA+LGhJHxkG6w7Rq
	 tHS5KdnRvZwtMW2LZ3KUqrbu1/7nEdD0ZqwHT9XRzT0MB7XO3daMWYipl2Mscshsl6
	 pbykNbM0yUOLKfeEf9t+OBTTd+CjFSXVy310N3HKtaJVOBJD/wMuWL1I8L5Kex2g0k
	 cLdeP2Uygd5FNbjcXVi8TBNPo2y8YS+R29zgi16U4UemCiigzuRlFLntZdSar49SkV
	 iP4QfRBuQJ6BXUa52dYBggyTiIJSYpdzCYOxHW5CYplASf/cc5Cr2Vo+cHuPQE8u9k
	 f0A9EXJbk1bGw==
Date: Thu, 17 Sep 2026 18:59:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, Martin Karsten
 <mkarsten@uwaterloo.ca>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Eelco Chaudron <echaudro@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v3 0/2] net: xdp: fix bpf_xdp_shrink_data() page
 handling on generic XDP and veth
Message-ID: <20260917185926.1bb7c430@kernel.org>
In-Reply-To: <20260911135711.109338-1-jiayuan.chen@linux.dev>
References: <20260911135711.109338-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 21:56:50 +0800 Jiayuan Chen wrote:
> I'm always confused which tree(net or bpf) should XDP target.

Selfishly Id prefer net so that all our CI would just run without any
manual effort on my part :) But perhaps BPF folks will disagree using
basically the same argument.. :S If not perhaps please switch to net?

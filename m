Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C2439918;
	Mon, 10 Aug 2026 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387809; cv=none; b=GOFUbemZH/jf1MG09xCLOCSIM1Yo6k4b4Cchn7wvNWs9b/r3t13wT/aYJcSrItz7oPrMJL4RUV1cfJ0NGfPzXtLYScDg6PRjqUfm4z4ZR92VWanPPu2i2uBHXIuB6SKfkBs21poJDfVHUxzJEqgBuVW3Wjey8ZzD61IQMvkOfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387809; c=relaxed/simple;
	bh=jaa8HdeBW/rXBYW8IfN/fGMF/NOWLK0iNyXfsssZV80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+ZCJhxBiEun9sfQIjGsA3Or9yLlEKDh83lzjUySfwiz2kjL5MPMs/hz17LHtP9riHBUKpv83dIhrwEe1TP5s7lPzAFI9OK7GZwOEUVGJCx9podqLfD3XW1BU+tJPafGT8sO0SogoHVWN1WDMRZygbkU7BRc/hkYSRqkrbRxVGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnZlNBZf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnZlNBZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC291F000E9;
	Mon, 10 Aug 2026 18:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786387806;
	bh=cHQ1IA64ugSSOuL/6cqAa0MjiWCpC62ZMVZfihalTHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VnZlNBZfPciFKLcXzqV+I2bw/olRTPuqV429Sk4wPycWzkTmwedauSv9c8KY4xO5M
	 6PdYLlaOo+IfWzSIOWX+gLUwKBGsgft/bIAiozwgU0Uk9zoe35WuCMaRUxAMtXKcJQ
	 5pOPlOQg5qCCFNrGCJNKY4MpK9lZdQONz706WPESwdOAZqxM9KfI+G/+qVS4jWystZ
	 8e4llG/Bm4fEchJh+Zb98GG0Y8ePZJ5ozX/Nrlyii2ACGkrszq7Z0on6XKl81z4OXM
	 qpwqvRtiL1g8LN+usjYbfbKT958L8C1si1DGYaeOtgNJLgbCjd+RCksAbrMa+AYnA/
	 zBfmokFIQV2wg==
Date: Mon, 10 Aug 2026 11:49:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan
 <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Krishna Kumar <krikku@gmail.com>, Samiullah Khawaja
 <skhawaja@google.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/3] bpf, xdp: move offload check into
 dev_xdp_install()
Message-ID: <20260810114958.64e6a83d@kernel.org>
In-Reply-To: <20260810050621.82035-3-jiayuan.chen@linux.dev>
References: <20260810050621.82035-1-jiayuan.chen@linux.dev>
	<20260810050621.82035-3-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 13:06:00 +0800 Jiayuan Chen wrote:
> bpf_xdp_link_update() calls dev_xdp_install() directly and skips
> dev_xdp_attach(), so the checks in dev_xdp_attach() do not run. A user can
> make an XDP link with a normal program and then swap in an offloaded or
> device-bound program with BPF_LINK_UPDATE, which puts it on the software
> path.
> 
> Move the three program checks (offloaded, bound to another device, and
> device-bound in generic mode) from dev_xdp_attach() into
> dev_xdp_install(), so both the attach path and the link update path are
> covered.

Shouldn't we move all the checks that are not explicitly about the
netlink API (so all but the first?)

It may be better to split the series and send this patch to net,
the netdev CI has a netdevsim test for the prog offload, would be
good to run that.

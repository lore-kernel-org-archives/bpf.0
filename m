Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132B3769E0;
	Fri, 14 Aug 2026 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786741796; cv=none; b=gwUktn7WWlXbVhAGDrXQyBk2CUTF2B8TbJX6H3uKqC1RNq6vUIHAGUJrLwxdU63MEp+UdpSkVtMpowguYDZINUsMfw+JtTi8TC/aUq0S7veygfj867OzWqkUHitwG1hm+25zMON7g4MpuNGPab8kzF4G2mZ0KxAFl/OPI83zniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786741796; c=relaxed/simple;
	bh=3JsTsQTVswbODlI5hArocHEAzLiWEulnRNOtAK6WZxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDVJXbO3amucTtfyFv47GzD+gZ2zFBBxArpDbGyGl8nfpO3FDy+kQKMv3U08YCDpGTHGZE/b2Fm2+hmhr5bcy4xgPFNihkPnP4axkXLDfmmhamvjzP6yc53JiMsIOG0ggieBY9xkpx5wXQpqdudLnaoSOoiGnmGmnLa3q3BFhDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkHN2VsN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkHN2VsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217421F000E9;
	Fri, 14 Aug 2026 21:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786741793;
	bh=jszSB1aALdMUq+st4+V+S0JozFvNf+7milePihRupnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PkHN2VsN3pdSWGQKScS2rxJR2VrzjKf8zG1MmZr/1FPXqEDAcRyR+BBa447HhF26V
	 dkFNlrSOclL3sUoA2QJS8LYocgxezPOxuu0U/eL6mu6/3k05j935NoTlRzQLNvl/NF
	 GedW68zI75btWCHd9e0Yu/e81P3aqT3cRsFVohGLM4y2syd/M9aro5phf48C09NwXC
	 gN/TDBtTpK4PEDk59riB3mhCNquUQLm4bLBS4ILbE5NoQXR1+9vnPoGVo0j63XKpAo
	 mBeJj10woH1rxHRM4qZ4BG50Zt5O+LVh93S1vKCyZujzg+EsC9N2xWI7g/fpUFhDLm
	 LV4u0tvq28ceA==
Date: Fri, 14 Aug 2026 14:09:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Kenneth Lee <kennethbwlee@snu.ac.kr>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki
 Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, Krishna
 Kumar <krikku@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Martin Willi
 <martin@strongswan.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: xdp: don't assume an Ethernet header in
 generic XDP
Message-ID: <20260814140952.12d3f43f@kernel.org>
In-Reply-To: <20260813113229.381136-1-jiayuan.chen@linux.dev>
References: <20260813113229.381136-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 19:32:24 +0800 Jiayuan Chen wrote:
> Refusing to attach XDP to L3 devices instead would not help: mac_len is a
> property of the skb, not of the netdev, so an ARPHRD_ETHER device can see
> mac_len == 0 too.

Let's try. There is no native XDP on any non-ether device, making
generic xdp work on those is silly. Just attach the BPF in TC.

AI says that one example for mac_len=0 packet on ether device is IP
mcast loopback, which should not go via generic XDP in the first place.

> Fixes: 22b6034323fd ("net, xdp: Update pkt_type if generic XDP changes unicast MAC")

Please don't send fixes to net-next :|
-- 
pw-bot: cr

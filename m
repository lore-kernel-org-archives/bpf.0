Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325089;
	b=NTisToWK5iIrqOe+pQ6dpDogiUtp4SBCMqCbcsTaLfUcj9KDwyeDnTTiFYrQD5kHW/aw
	 n7k5io7z2zOrvbPrt+/EdTiHkWBo2BR8XiMEg1Alhh9DwpWU05EGNfWqWPrM5ZMPzXicw
	 WHIjNaFC0q1avPUie8pEUe3V9/hX1GEfp9x4ebHmG8IIN/aSnWzdzaLMYHQEk924Kho4a
	 Q6PylLrU/GjRpXUbTs66Txl0E+zdAWSTJ17IGflAM30GHtuzVFtkfbn2z+spBJBLv7U5I
	 JbTVv8vZEiMJ8SRIg5DscqH2oWs2XJhtg+4OR1fm/cgaSIZpeakn5/1n54LDNAxy+5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325089;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3gKubFJsAndnwMy+71Kh/vTDw3q4Y5FuAjFKOiBoGMU=;
	b=m3BtGMaB0efwSDbdN+SqjlkRP5mHp0Ebfu/+9WdYHvSja7/jbNhAqk1xsRBX3SztT9T2
	 FOAEVlizqF+Sz2Lmj5NC++//V9UGHW606XjZFpF2ifKntwNK79yvMO3n5IqqwvXZ3/TmX
	 EfrqWVuJNZKNaM5GQF7ybOkuy4+t/Ynq2nOvsahk27BJYR2cmkuhGzYkE659xgbqe7KI8
	 MslgX06PWmtVs6hBTpa1jG5KlyAKm1mU6Jozth882C7fsMmScWx/YgSKyWGFPF4CIbAtV
	 2JmnE3F33rjhI+z0kw1gaqbkfpwhP/MLOFmJq6CMwgTPka7V4+XcJXmvD1TYd7UnWCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kWADNG/S";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32C606A320;
	Tue, 10 Nov 2026 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWADNG/S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24761F0089F;
	Tue, 10 Nov 2026 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325088;
	bh=3gKubFJsAndnwMy+71Kh/vTDw3q4Y5FuAjFKOiBoGMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kWADNG/SAFTOBU7/W20qxtY1BfKFVTfX4B8in6u+pRNigbK3pR+rrgb0EJh4pRITv
	 htVv7dXVeoUcJaeBjuCHwOFqnBqZYoawP54qVUPC484iCLbUPJUkgrftjNO8xK0UwS
	 CEk8ko14HNuQAB3psAhB1vA+fejKb/oUziEc85nhFa1L2qeUUSE90Ebi7WkQLbfqC7
	 7QLqMMAO5hH/dWbhWxZx38rAhZjmol6n4/HiTY6Eg4plmKZ66aUp9KyJZVppGS3lmQ
	 yfnNtLvbc7e3WX9hmCJ+AaVqqiphykLPcugOcR60DSqz1PnY53jV4LwbkiSA4cQMrq
	 bHP7ySUz8qm1Q==
Date: Tue, 10 Nov 2026 07:38:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, Simon
 Horman <horms@kernel.org>, David Keogh <dkeogh@amazon.com>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, David
 Woodhouse <dwmw2@infradead.org>, Dragos Tatulea <dtatulea@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>, Alasdair McWilliam
 <alasdair@mcwilliam.dev>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Alexei Starovoitov
 <ast@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
 <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Breno Leitao
 <leitao@debian.org>, =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5l?=
 =?UTF-8?B?c2Vu?= <ast@fiberby.net>, Danielle Ratson <danieller@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@cloudflare.com, nh-open-source@amazon.com
Subject: Re: [PATCH net-next 8/8] selftests: net: tx_extra_headroom: test
 veth peer at creation
Message-ID: <20261110073807.2fa62e6c@kernel.org>
In-Reply-To: <73b9d23a4190cdd02e89d3a2ce8a1a21ad5feadb.1794020868.git.tianyi@cloudflare.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
	<73b9d23a4190cdd02e89d3a2ce8a1a21ad5feadb.1794020868.git.tianyi@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Nov 2026 03:34:27 +0000 Tianyi Gao wrote:
> +def test_veth_peer_at_creation() -> None:
> +    """ip can set a different value on each end of a new veth pair."""
> +    if "tx_extra_headroom" not in cmd("ip link help", fail=False).stderr:
> +        raise KsftSkipEx("iproute2 does not support tx_extra_headroom")
> +
> +    with NetNS() as ns, NetNSEnter(str(ns)):
> +        ip("link add veth0 tx_extra_headroom 256 type veth "
> +           "peer name veth1 tx_extra_headroom 128")

Please use Python YNL directly, we don't want the dependency on iproute2

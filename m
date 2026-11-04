Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772462;
	b=jMV6V06QUXW3HCw7HQbOBnQEq641KAIsloFiu9Tlo4BUzNgq3QwRZc4doU547zW6bVxm
	 b/J0v9oyWSL3aovvBKwYp/1b523BFu3NirKcTX9qLF3+Db8SGNw4YR5VI/vh/foklKCYN
	 5ubIdxen7eC2FjIcm79mbxoP/1yEOBGKnnDY/Hg/beAbmXPC6W3qQ1n0I+KMxa6iDLzsa
	 /ozKxmWuIk7Le++4Wm5StRu+ZsS4RYd/sTa8B7nu7MoI2/vPbgFfie7mNGGtc2Nnqgjcr
	 AhcdIHkwTFOuymH5cpu6t/aaGeFbW/dK0eYv21I8AREMamLtMCf1Hi6fnHlnGQ0UuYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772462;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9kJziegiXF9ceVnU6QWNYLm7UZNmpZIr3z6LjOuG5MM=;
	b=Ki/haOHgN0RYCbHOYEcz95vkV3qSyKdd/u2jokeUN8w134EAKWJmJEnDAx6+NTwD5yM3
	 KCGDh3bjP+qr61eMRjGbDmnPF2zF74zfhngSHYxr3hKxNFOLH1yVGu1r7Bpk+Zg9QgY73
	 2xcXpUUas8H6i2Ob495lRC3ovvlnT2eJRDhMxf04T3MrrIlwNBUmlLG0Q2ep8AuTmHB3w
	 MpRbqmlHBiACiM8xbnpJY54VjIajX+mdG9K2jSs7hq59ZNSlIw0IRlj7+LV69B/VmvWJj
	 E/ouFjGqlPgATulonNBmcAm3cScG2PaLCSqtadb+8Jre98dBALyiimB7vjuuwJvQwUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.86
Received: from mta0.migadu.com (out-86.mta0.migadu.com [91.218.175.86])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8395B606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 06:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8395B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9kJziegiXF9ceVnU6QWNYLm7UZNmpZIr3z6LjOuG5MM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793772454; v=1; x=1794377254;
 b=fxLDSgIcA/NKQEZVdQe+c+tZv9EJm4A97xmG7kksyzEFVSz1LPqD6ZLfddWwZttwpHGHJqj4
 WbQ7rw50MpXacTQu7jIuS4iaZzy+L9FleibBF8vwLdpgPYzOHwg0ZgIAi1EWmIEfe5+1EFdSjZu
 tIaweSpziELawiYNIfJrbgZU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a8b4b12a133bf9ce;
	Wed, 04 Nov 2026 06:07:34 +0000
X-Mizu-Trace-ID: a8b4b12a133bf9ce
X-Migadu-Flow: FLOW_OUT
Message-ID: <3f0c43dd-532f-4bef-afec-76b2ca6df0a3@linux.dev>
Date: Wed, 4 Nov 2026 14:07:11 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/7] ipv6: mcast: convert ip6_mc_msfget() to
 sockopt_t
To: Breno Leitao <leitao@debian.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 david.laight.linux@gmail.com, kernel-team@meta.com
References: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
 <20261103-sockopt_expand_out_v2-v4-3-2d36da923578@debian.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-3-2d36da923578@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/3/26 7:01 PM, Breno Leitao wrote:
> MCAST_MSFILTER reads its reply through ip6_mc_msfget(), reached from
> do_ipv6_getsockopt() and from nowhere else. Convert it, and build the
> sockopt_t at the call site for as long as the caller still carries a
> sockptr_t pair.
>
> optlen only has to cover the fixed part, and the real reply size comes
> from the gf_numsrc field inside it. Userspace relies on that, so
> sockopt_expand_out() grows optval past optlen, for a user address only
> and only far enough for the sources the socket has.
>
> ip6_mc_msfget() now advances over the fixed part and writes the source
> list through iter_out. Its callers rewind by the reply length they
> already compute, which is exactly what the callee consumed, and land
> back where they used to write: offset 0 for the native reply, gf_fmode
> for the compat one.
>
> ipv6_get_msfilter() and compat_ipv6_get_msfilter() only store *optlen
> after their own copy succeeds, so a copy failure can't report a
> changed length: -EINVAL, -EADDRNOTAVAIL and -EFAULT all leave the
> caller's optlen word unchanged.
>
> The old code stored *optlen before writing the fixed part, so an
> unwritable optlen word stopped the fixed part from being written. Now
> the fixed part is written first.
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377895;
	b=IJ+lnhVmvjpsyRGRw7HBizcK2TU7rvs6lwsryjQU7eyLy8lgVj78hnIenOR1n5n1QKow
	 Eh6Z33n8xmXtKb3UW0afTFfTaMlXE9s+tSDkZfz4HvsFUcli6YZL1vnZraTv5cKfOmpEr
	 0JRB9hnDIbba4hW7vU+oVw2B4OKeFkYCO/XoOwBhahLPrgbdOxvjxqzvbJbf40VqE+EWO
	 cTm29s2EMgUSl+B+8efDxy5NpoaclPfByvFX431G/i3GSuhayK1PZr/4uNqmSAamf8bVm
	 r7JwdW7L1sjYaYsG03DXPZ+UJuXlVJME3Dn8QO50Zf4gXhJOVPl9WfuoLjvfNGs/Dtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377895;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hJntkLl71ehP6K4tL5AJK+8IdOlj65eqs2ikaDPPzO0=;
	b=TBY7syHWhEQ+86TwRHbcq3qx/QTBqFUbrQh3aUmVn9wTOnGwnCGuq6xn7P48ZrVYOU9x
	 2Oip5AUBv30vk16gfOyVc0At0BWko6AEIk0W5k2upjETlew8a095d1NW9MBhQL32a+eyH
	 bRS1/EjmdGjDnbZLX7SG996EE6Ardc4M1I+Yc8UrRj3rW15mNVH8uPGUZDwAkwM4eBwhh
	 Udmc0SMY6klMXphDMAYoMc/+j7rJfxYhL6e//h/qxq6DE38ctwGLhIYTfpJmN5LKGXeQ+
	 zDwQ53/bdH6If34EykpD6m4yIUx1XcWOHilIABYIvaKTqGL/VPluEx3/d3CdBKNWEbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mdA+kf/S";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCBA606A31A;
	Sun, 22 Nov 2026 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdA+kf/S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9432E1F000C0;
	Sun, 22 Nov 2026 20:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795377894;
	bh=hJntkLl71ehP6K4tL5AJK+8IdOlj65eqs2ikaDPPzO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mdA+kf/Syjy/2odxsfIDtxP+QqK8rJkhgh9MluIlvMlSNePU9ORNlUaOC6ZNf89ot
	 w9gZ6ij63UjNyb96TM9jmUw5CTrGIvROYIJkj1puZdEoM7GOanC/PwRdFYo3DJ/Fc0
	 0crTg3TnveG6qm/L3qAvP0vKnSjI4s9q4y7pUDWVdHPVAwFrLcSo37CNbwSaMOadrP
	 Rnu/YgZTzbKHt1APZWDu6rbkFgORoZCDeR61CAYUlNxRCafVaW3oVmfn5JWv5VAa7F
	 Psiwpr1hhe5ORuqzlBVfn2cu0i4Fnpjp+gYDf2t1DMuJ+/ziyPprWI9x4eo7q3o1Qs
	 2EcsrMyDazBJA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Alexander Duyck
 <alexanderduyck@fb.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Pavel Begunkov <asml.silence@gmail.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, kernel-team@meta.com, John Fastabend
 <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Weiming Shi <bestswngs@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Bobby
 Eshleman <bobbyeshleman@meta.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next 1/7] bpf: Keep XDP helpers within readable data
In-Reply-To: <av-SmgwQhAKI5u5P@devvm16445.scu0.facebook.com>
References: <20261117164700.2157816-1-bjorn@kernel.org>
 <20261117164700.2157816-2-bjorn@kernel.org>
 <av-SmgwQhAKI5u5P@devvm16445.scu0.facebook.com>
Date: Sun, 22 Nov 2026 21:04:51 +0100
Message-ID: <87wlq41vks.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> On 11/17, Bj=C3=B6rn T=C3=B6pel wrote:
>> Devmem and io_uring zero-copy RX put payload in fragments that the
>> kernel cannot read. XDP helpers must not treat these fragments as
>> normal pages.
>>=20
>> Reject operations that read or write these fragments. Access to the
>
> [..]
>
>> linear part still works. Tail trimming does not read the payload;
>> clear the unreadable flag after it removes every fragment.
>
> I guess this is technically true, but why allow it at all? Easier/safer
> to reject tail trimming as well?

One, maybe convoluted, use-case would be TCP RST: discard the unreadable
payload, rewrite/checksum the headers, then XDP_TX. Can't do XDP_TX with
unreadable frags... I can't see any DROP/PASS cases FWIW.

We can add it later if anyone cares. I'll remove it in the next rev!


Thanks!
Bj=C3=B6rn

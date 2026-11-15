Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794770585;
	b=zrUzRypfvmdtHrav6aDuDIW54JywgYhbBmI6JiIsKrLz0oUuGnVlPCzhstguM1F4tiPK
	 8jjgOtuY1BHx35zBE4GB/PwCSzei/hwKbR0wcKskz+jItAIaH6idUmVTIIejoDjxGxH0N
	 dL7EHeLUzNK/pNfD9UyP+YQpiZEC16EaNuAWEbQ3RfZIO78vw0gwyYOOSDNu5a6p30f46
	 3baCVScOWB/DSj0jnnHiqfEYLgRlzChuUzzepU3Qw7Dvc/C67ZN0uTuoJIBSxstCWiQHG
	 qlpL5WR+Ulsl2lxW2cZVU4p4OKq2Q3e55huz2p5QycfBnxt7ENHDomCftrv8vwInC7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794770585;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lQOjQXnCDqOZeDgjlwwko2gcjA/gK2MjwIx70kisX54=;
	b=WMggsiUGjM3N3nlFC5pnzAiG8qemjshz9sGKIWX8fLXyEQv+e/Luj0Zfb3rhF4ZdJqEz
	 KqfI3btj/DeY2n0QLu7vbkINnxcrl3eePRIftnllRZpG7PkneKDnw/6cF8g8BhLpW2ECV
	 hDQG8HuBuY/UAd1Z3IuMlDFFPu42tJ8CeeOK04zVAByU5axmpYMax+IRWTaTowb6J/gbT
	 jAXpolD/k56YnGs+GtOgcXEWEiB4tGb/QlIsHtto0UygES6zWKe6XGBRqe36Bkusb+JZZ
	 Wo0BSG0h9RJuH/wVNmruv4ARq1XJhAXtDenpLKoVQ9BjvPfsIKayBJ69HsAOSfgLo8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M66ScdV5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7022606A335;
	Sun, 15 Nov 2026 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M66ScdV5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EE61F000C5;
	Sun, 15 Nov 2026 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794770585;
	bh=lQOjQXnCDqOZeDgjlwwko2gcjA/gK2MjwIx70kisX54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=M66ScdV5h+nAP8WBXt+vpiUvnmD94r+c2ZaVEMETbDJ4Z1nCaYUFDFoYi9XdgeIv/
	 Cz4fFZuwg1v360MvRoNa+R0BsRK1G55P2hApxkQb1IEMfFzqYn9rk5aDif3WbhCKJO
	 +OfPAuBMVIYMe7CMt3hFcdiwM2CkLxLATCYwvI7Zdkdi7jDYjAssa3rphmVw7HxmnY
	 SEUqKdoC9sZXTyDqoylZZB6qmTCdd4o27PYraZ7BVAd4cyqPfLlk97bl4ewhJJ5Wsc
	 KrcFnscQY8HLr6b2ZJaOaKjL0Ny0zfnqZNv1pfcmABvkQnDoXO3yD1X3KVSSJMFkWd
	 z6lvela8xepMQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 sdf@fomichev.me, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, alexanderduyck@fb.com,
 kernel-team@meta.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, asml.silence@gmail.com, axboe@kernel.dk,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org,
 almasrymina@google.com, mike.marciniszyn@gmail.com, bestswngs@gmail.com,
 razor@blackwall.org, dw@davidwei.uk, aleksander.lobakin@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, stuclar@meta.com
Subject: Re: [PATCH net-next v1 07/11] xsk: Deliver provider chunks without
 copying
In-Reply-To: <179443689590.2199510.9741809616593174859@kernel.org>
References: <20261110102039.1002605-8-bjorn@kernel.org>
 <179443689590.2199510.9741809616593174859@kernel.org>
Date: Sun, 15 Nov 2026 20:23:02 +0100
Message-ID: <87fqx1hpbd.fsf@all.your.base.are.belong.to.us>
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

netdev-bot+sashiko@kernel.org writes:

> Should this be gated by a flag? Or should the commit message describe it
> as a UAPI change rather than as a device property?

Neither, it isn't a UAPI change. The headroom text predates
multi-buffer, when a buffer held a whole packet: "the packet will start
N bytes into the buffer". A continuation buffer doesn't start a packet,
and the room in front of the packet, for headers or metadata, is still
there in its first buffer. Userspace reads each buffer at the address in
its descriptor anyway; XDP can already move the start with
bpf_xdp_adjust_head(). The doc change only spells out a valid
multi-buffer variant, and I'll say so in the commit message.

I'll also fix the commit message on the old copy path, and give
net_mp_release_page_pool_bulk() its own page_pool patch.


Bj=C3=B6rn

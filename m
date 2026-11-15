Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794771545;
	b=ht9e48ECeeIMNUqO+SRYsM/BmzBRrlj9HEetx5xgSeK9e1Pr9flttt4fE0Rj/X3byksg
	 7Ig3hjz4aMw7jH/cmNiz9GPrDs/q+LLev7lZz2JnEW+CUukGFg1lplAfmWfjFu/5b8urH
	 U8n7G/j56i2srEiI0eId/aDUoVHdF5Lq5MlopxZD0Z0YaOpZfdryHU98DNpux4hpy9q67
	 jKfgsTZz/b2f0V7qLuh6vo99MI4AvSUkcVmAb1Yd4fErYQlU1Usy50QDBHraaLKiOADjQ
	 3o8gPouYIMIByJ5oRcbL5/q7NcfYODzyPzEKAB2/fR8JJ9wB7E1k5fM7ggxZDtgruNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794771545;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nhfeoYtF7WorX7zGjUIuskRdAMeUM/Fthys1xBCjJm0=;
	b=nOxt/zB4e2MAd88yK2g6LfDYzNXqU2MvfapAk8CsotFrau6kNJE6jd2C4FpfLSoBibwx
	 nwaFAItza7ciyuNcjDA1bqIGJj1ifKkikkjg/D8uztDgjs6+gGHXii6+23VYWCjUEAAOm
	 +L3RdHRMjSmCGAEnCxxzffrq03qLuCrZPAh3pzKjNgf8XqddbUcxBz0RLyoLiBZWLYnrU
	 D/wmyfYxkQ1qM01MKOW06kkeccG6Lp5+28SOPJA1C39o6iDqXs2416W6pwfljMUdzJgrz
	 TcXduxZsgFgd4ym2bKWQVc5tcRIflntz2Vg5ZDx/KjVyYDUPmWY36P4PHOme6Bt9OtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVa3kJOZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CA606A333;
	Sun, 15 Nov 2026 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVa3kJOZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8141F000C4;
	Sun, 15 Nov 2026 19:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794771544;
	bh=nhfeoYtF7WorX7zGjUIuskRdAMeUM/Fthys1xBCjJm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dVa3kJOZBz7IO1OByxjM4DlK62AKKz9Ka3JoFzukyf8Mtt0WvAaVeywOTe2Oxg/b8
	 pJyd/Hcb01G5boe98nFycm5mUUClT8X7Ntu/1hFxdikFhRyhtf5j8ITJmO/TeBJjtn
	 MllBZTZzBOIQzHQks6G53m4E5EztR9RrlaTTKls1hOvK+K0NTFkTZ0W9xoU+OfWydr
	 ehuUkkZB4od/5R7m6mbCjNblOJ3ivYl6FVgGGrPUx9aJuPBpos7I+xoq6QBgkYsa+6
	 gWd3jR4JLD89gS/0b1XfIfCvKSoESH/3bKWJJBKhwwBrXXZ7j6EIEV0axeTCYXQoLi
	 8Uf7b4PEUNkjQ==
Date: Sun, 15 Nov 2026 11:39:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir
 Vdovin <deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Donald
 Hunter <donald.hunter@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Chris J Arges
 <carges@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, llvm@lists.linux.dev,
 kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
Message-ID: <20261115113902.4834dda6@kernel.org>
In-Reply-To: <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
	<avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
	<CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
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

On Wed, 11 Nov 2026 01:07:46 +0000 Tianyi Gao wrote:
> - On veth, an XDP program removes software GSO from the peer, limits
>   its MTU, and can copy skbs from the peer.

Could you remind us why you XDP_REDIRECT xdp_frames to the veth
if you end up allocating the skb on the veth, anyway?

I thought that was to let veth run its own prog before skb is allocated
but you're saying that you want to avoid veth having a prog, so clearly
it's not that.

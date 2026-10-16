Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40446D2DE;
	Fri, 16 Oct 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149142; cv=none; b=u+D8bJrYtOiH240URDUuMtYMszk2dxBaN26tEiaG37RWlNIh8Qbw7jW8KfgGVueZqJ2xEyds14ayomNVyvCqev0GjmeOEzMhTUIu/W6qVZAqESdZz7eSMlu/NoN2G1dnbLXDzZI6ymNaL58uPnl4+vzAurPDvmDp2Gd0CnCbffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149142; c=relaxed/simple;
	bh=nQeGa6ePgDQWppiG5ep93YVGe2TcsFV2EN9BB0d0v24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hCXUey37JtgMLtTI4WZDG0umEstUNw0WIPYHsXr3aM9/UUeZ/uwzQeSNE5JZqk5RpYzkZhBFxXx4ql2uSSCx4SA3pzcSno6LmGIBFJNLishULaX/s5btPvP1UWnlJNB7RPpnSgSXRO2L158sGACFJj3l+dyvbrAJ/S255G+wNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNFop8e0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNFop8e0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADFF1F000C4;
	Fri, 16 Oct 2026 11:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792149139;
	bh=nQeGa6ePgDQWppiG5ep93YVGe2TcsFV2EN9BB0d0v24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=TNFop8e0BS3+5aetzmNibUVX2aE13TX47Hebcd8Gjl2C5kNq3GfCoP9vsU48ZBtwp
	 o009JiyVgAt+YM2oK9Xe91IXSgptbYCSfxpdtU9bxj2m+GUOyK03lzx3cUWPiU7q6w
	 EAOBlRa1dt+hEMReYwGhDMf1UtKmg0cmF3nBZQWGnvGsnAdVZq5cRbuAS1+F4w6c4E
	 58tIod+IKEaVuB7U1Pb07smBoJa4zjZntPiDF0RmA/UKxB41Wv+BLCzB+dfbl+QHMN
	 qS5FBUbI1vTn59svbua5fzfJ0p8tKTelRHplu2q1VekwDkrwArxQmssNSzNMejdn1Q
	 qatTrGxMKz3mA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 io-uring@vger.kernel.org, "Mike Marciniszyn (Meta)"
 <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mina Almasry <almasrymina@google.com>,
 clecigne@google.com
Subject: Re: [RFC net-next 01/15] xdp: Size zero-copy skb heads by their
 contents
In-Reply-To: <atEVQXajVzoWSFzc@boxer>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-2-bjorn@kernel.org> <atEVQXajVzoWSFzc@boxer>
Date: Fri, 16 Oct 2026 13:12:15 +0200
Message-ID: <87y0bx527k.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Fri, Oct 02, 2026 at 09:00:02PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> xdp_build_skb_from_zc() sizes the skb head by the XSK frame size,
>> which leaves no room for skb_shared_info. With 2 KiB chunks, a
>> 1514 byte frame overwrites 48 bytes of it. Both copies also round
>> the length up to LARGEST_ALIGN, past the end of the new buffers.
>>=20
>> Size the head from headroom plus data, copy exactly the data, and
>> drop frames whose head does not fit in a page.
>>=20
>> Discovered by an AI code review agent. Reproduced on fbnic in QEMU
>> with AF_XDP zero-copy from the page-pool series: an XDP program that
>> adds metadata, grows the frame to its end and passes it gets UMEM
>> bytes in the skb's shared info. A new xskxceiver test,
>> XDP_PASS_FULL_FRAME, checks this and passes with the fix. The test
>> will be posted separately.
>>=20
>> Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>
> Late on the ball here, but I believe this is the case Clement reported and
> we rejected it as the reproducer was OOT module.
>
> https://lore.kernel.org/bpf/20260629072300.1664622-1-clecigne@google.com/
>
> Should we proceed with Clement's fix then?

I'll wake that thread up!

Bj=C3=B6rn

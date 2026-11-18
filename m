Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961139;
	b=ycetRm9mOKvVWIkbNAKlQcPJalOhohwBanQt/vT96KaGbaQbPggryirZjI7KRybcTR72
	 nZOeJeW0uw8c+iZnyqhMW6gsHRmgkgyFSs/wcCVnX80uG7HUOfVASBU0vEj9rh+PEm5WW
	 LiWHjuAjY61KOm5EWMtPmxPYdjvKGFK3He8FmxXDuKu69XyO2UpboGllBoKK33luwV6t9
	 QfMfq1cPhW0SE8vxW1RreeAXtLTcjNwpx4fnzNOxSl8I1cd9PbnnwjhDESEnBKlNSnKio
	 daWuVC/+xacEJVpdbv2FarTtA3w8lJ2ddMp4LPWdlYN4lqAY3GqFz5lXIEoWpjHktgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961139;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CiaEOlN3DliPTegWH/OxBrR4pZjxHdFZsot9BUcRetk=;
	b=XKENBPHq0z4ErIxwmA29C4NrvQSsaNd6NOT6B9z1WPgmAw8DEkPrYft1JuCAxZ9yE+7U
	 NadVtN5EErxZ0fwg8NXPKnsiso0jX6S429tdjFMvfEe+cjLTyKcr3IeRL74UMd+7ii4w7
	 BCCxhoWlQhwqXoIUJ6oZyxkpH6Oj0MA4hjPYz97+7+UskHuEiblkbI9uaOkFNF2kEJqra
	 1AtT/ey2mBj6u446TSrnhStUa/bdmrbGecbpvMHAMyqXiGSIQH9b6/NqtWcB/hcZf8VPI
	 VpBZ8jx4sHxjVRmdwIxcUBZTHbGdgsqdVCTH8qq+3/lkPG01jB6LygAidfIKZ4UDXng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8Z8uMXb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D79606A31C;
	Wed, 18 Nov 2026 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8Z8uMXb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117E81F000C4;
	Wed, 18 Nov 2026 00:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961138;
	bh=CiaEOlN3DliPTegWH/OxBrR4pZjxHdFZsot9BUcRetk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H8Z8uMXbbN46/Dz3D2RrmXrHgVu5ybahMNNXc49qnRx6z5esm+e9cQXQNXAkFRcrN
	 XjmuwGX7gj9Rh1y79PoI4NaK0mLI3lCX73yjdRDoB+D1y1WklzIy2e8f9mS3q4u+l/
	 dLFiO9fYL3E7KTmVPPiOfWsjTNhS0YMv7GMyaIDCQ+pKEm8Lgacu/lrndDp8B7MNLx
	 YwMbpf7AFMyuj1PqggDvwly759kt51eULOFCZw2i7JDZG6WT+TRtdZa0B7IB2fTULb
	 hB4c/bZDmJWQPPjQJHU2uC878bQxQs4xyl6w8kaik3Dq8UI1RItPx7q2mDRwt/utdd
	 +sV71LPdCs9XQ==
Date: Tue, 17 Nov 2026 16:18:56 -0800
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
 kernel-team@cloudflare.com, Tianyi Gao <tianyi.gao@linux.dev>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
Message-ID: <20261117161856.6f6c2ce9@kernel.org>
In-Reply-To: <CAG4wq-cDYa2GkpWSYeOLwEPv45BtucZk+r=N2b1Srd=gUUO4MQ@mail.gmail.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
	<avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
	<CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
	<20261115113902.4834dda6@kernel.org>
	<CAG4wq-dhd5a5zxQcSShaKifYd2z+pMpHaCYtZJRX1QCxEH4dfg@mail.gmail.com>
	<20261116142710.347e8571@kernel.org>
	<CAG4wq-cDYa2GkpWSYeOLwEPv45BtucZk+r=N2b1Srd=gUUO4MQ@mail.gmail.com>
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

On Mon, 16 Nov 2026 23:55:42 +0000 Tianyi Gao wrote:
> On Mon, 16 Nov 2026 14:27:10 -0800 Jakub Kicinski wrote:
> > The question is _why_ you use it. Let's leave the cpumap case aside,
> > you provided no legitimate reason why having an XDP prog in that case
> > is a problem. With veth - you are right that attaching XDP causes
> > problems for pure skb traffic. For veth cases, however, there's no
> > strong reason to delay the skb allocation. Hence my question.
> > Why not let the driver allocate the skb if we know that the
> > redirect target will need to allocate one, anyway.  
> 
> Sorry for not being clear enough.
> 
> On the setup we want to build: an XDP program on the NIC does the
> decap for all traffic. The services run in namespaces, so the packets
> must be delivered into them. Some services attach their own XDP
> program to the veth, and some do not. The host does not control the
> service's program.

The host doesn't have to control the program, just know whether the
program will be attached, and therefore whether to use TC or XDP.

> For a veth with a program, the skb path has the problems you mention,
> so the host uses XDP_REDIRECT. For a veth without a program, we want
> to use XDP_REDIRECT too, so that the host delivers to every namespace
> in the same way.
> 
> In a minimal benchmark, pktgen sends UDP, and perf stat counts the
> cycles on the RX CPU. bpf_redirect_peer() from tc costs 3% more
> cycles per packet than XDP_REDIRECT with the checksum status kept
> (mlx5, one extra __netif_receive_skb_core()). So one XDP_REDIRECT path
> for all namespaces is both simpler and cheaper.

That's noise.

> > Since your patches are not a natural / clean extension of the existing
> > infrastructure - we should step back and make sure the use case is
> > practically justified.  
> 
> Maybe I am missing something here. XDP_REDIRECT into a veth works
> without an XDP program on the veth. To me, it is natural that the RX
> metadata also reaches the skb on that path, without attaching an extra
> XDP program.

Sure, nobody is arguing whether in an ideal world the metadata would 
be magically available everywhere.

Inventing a new way of storing metadata (either in this set or Alexei's
simpler proposal) doesn't integrate naturally with HW drivers.
And duplicates the information. Fast packet processing at HW drivers is
the primary use case for XDP, we should keep that front of mind when
designing.

You want to cross from XDP realm to skb realm, after frame left the
scope of the original driver, and with no BPF involvement.
These constraints are unreasonable, and leave only clumsy and
inflexible solution on the table.

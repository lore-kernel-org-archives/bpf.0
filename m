Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64543275AF0;
	Fri, 13 Feb 2026 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771014887; cv=none; b=K+74p/5ErKs8t3jLx3UGOWOJbAJa55mnUjzxM7ZDO4qQeHrYwXH78Jd+lEYZxmwe4j3Tm7SqT3KH4VaSUw4kxlhESflJUVD1EIAtGlqHd/nxTHkGAqKcotX1RT11cCQUYN5hCzG0AIHq0ofTe/Itmr6VrAd5i5d/Y3qFAFhlWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771014887; c=relaxed/simple;
	bh=XxUt9o01tkl2YeDC894gfSKrSV9JalAY+MmXygvGPhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnE3EgMBX6eDeMquIR35kb4+5N3pA1+M0m9RpraZNLcVrQY+tXCPCpjUuc53WKXPdrftEU5XuDmZfgTKegJ0v+sMvNbjTdGf/9pBHjbnCLM9OD3/0u4uLrB4S+c3W0KrZ2MJukyUtXp+KG+5Uo9gzKqFJJbYBaI22Q0jcQfvNck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDp60Yyh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDp60Yyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13816C116C6;
	Fri, 13 Feb 2026 20:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771014887;
	bh=XxUt9o01tkl2YeDC894gfSKrSV9JalAY+MmXygvGPhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hDp60Yyho4yXiHjPDWqvFUJnMKAiJv7mwRpUKs0th2GCzeNB+Froz1yzy6qvMW7MR
	 Fau2WLI+fY9sPaBEFU577fpBUmaZt3TjJWBWKloUV9JpEkQCxPt+RgCRzP/0X8byCs
	 lzxfCwb6bpODUIUEXWbcP3isLC9l9yuvBc6EbJWmqOkEwf4Bqvp5lbEuHNCj4VxcXU
	 QUNKJeQTF2nRqwHbO2777R+lSnwQsn4FBRGdnE7kVFQOAFKzfg4/l+FyQbHOYu/d9E
	 /YdFBaoWReY6379kNQ03msQ3Hhdrw6hwdAu2GYoFe00CPDhnxuOEweL6qsXDXBt9QF
	 9vuP2MXDPvBUw==
Date: Fri, 13 Feb 2026 12:34:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, "Bastien Curutchet (eBPF Foundation)"
 <bastien.curutchet@bootlin.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>, "Ricardo
 B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>, Eelco Chaudron
 <echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Toke
 Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH bpf v2 1/9] xdp: use modulo operation to calculate XDP
 frag tailroom
Message-ID: <20260213123444.12fd433e@kernel.org>
In-Reply-To: <20260212183328.1883148-3-larysa.zaremba@intel.com>
References: <20260212183328.1883148-2-larysa.zaremba@intel.com>
	<20260212183328.1883148-3-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Feb 2026 19:33:16 +0100 Larysa Zaremba wrote:
> -	tailroom = rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag);
> +	tailroom = rxq->frag_size - skb_frag_size(frag) -
> +		   skb_frag_off(frag) % rxq->frag_size;
>  	if (unlikely(offset > tailroom))

Acked-by: Jakub Kicinski <kuba@kernel.org>

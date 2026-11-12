Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446560;
	b=M8lo5HtYKyGTqSOHi1+llV2Y2cPrlXEf54KCCyl9hxHfIgGYx9Mzg+sXk6e95fb/8yDA
	 boiWmVQdtAtfqjFSeZYxFal5sp1/ebmKaS6luFWmrAZajsF7SOo424JCHrOCETwUkRUCn
	 lX+NTzd6qoBY7AFrykiDuX7UTZkVdBp/BIc6EXKAuJAujtUnTOXJzIEd4nAbJ1A7Vwet2
	 TNR5MRCo1znIREfkBobfTXEU47SMuo8jux33a77Ocrpl0KrSsx4G3DZOn9lNbwsbp6HEp
	 uSCYAYex3awgZZOrd3FacaHi+obpSUW/Z9/FFn+LfH32I2Y2zYHKFv3jVdurmF8Tauw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446560;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yMgbUplGc67CDT49oiQXFHdtB0XBP/ABTmNCDVt654s=;
	b=THMVN4//9VD0Oib+XPxi28GPGXX6hHICylBLvZDqTDZQ+OLqx7RU+0pINnhZc2gnTkxw
	 7yTMWq/liF7naddFpQV0RrFrrUIKe9lO7IJ7ZPiNatuhYOyJZjm3dVBzQ7GuZsDXcfk39
	 TitSImjnsqaCDjSBtDq83LB8LqWFIq814WJW05QRN5hRHLZ3DGxHo9wHal526sTTNNPXs
	 jd9a5jN5CeViNDjlTHdq5jL7rE7KLlJoAyl5bNwvx5mhJ0DGLZ0vbz2B9lak/cfKIHuar
	 WpHyBqzr2y2LHSC5z5qjnc/F4S+yNi+LBTcJOVSe4hErohkJQA5Ko3MWXPdLgDxL2fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsL424JA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285B0606A31C;
	Thu, 12 Nov 2026 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsL424JA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014821F00A06;
	Thu, 12 Nov 2026 01:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446559;
	bh=yMgbUplGc67CDT49oiQXFHdtB0XBP/ABTmNCDVt654s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NsL424JAQYNS49/xxqD5d2o9VWjbWTUkrnj05TSe/ZCiOBHpLLgaBGZJolIMiEYOa
	 rQGZJZ5E3tdchZ4z6ED8TBuui8XcshgtTU2kRl5we0KZ3kRXdwm97qPect0o//6vp4
	 MQQ3lj3hEUnYi0MMJiyofLq7oSO0JJngff5g+cNFziZf6+9obvdaYVFnl0IMIRMsMh
	 e/JZPi/1qUD+aXR/K0Unmn9R+ht2TOK3lYusaJAh7ZByzqgklmtfApHkqVLBgeX7M7
	 2Phopcip5EYZsVcvTsGzLoiVyIt9wELfLn9Y9lZ/74UfZjt+AjwNWB/wv5+yGS9son
	 kRt+YTzL6w6dg==
Date: Wed, 11 Nov 2026 17:22:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexandre Cassen <acassen@corp.free.fr>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Ido Schimmel
 <idosch@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/4] net/sched: honor
 TCA_ACT_FLAGS_NO_PERCPU_STATS in bpf, ife and skbmod
Message-ID: <20261111172238.506fb9ce@kernel.org>
In-Reply-To: <20261109124618.933149-3-acassen@corp.free.fr>
References: <20261109124618.933149-1-acassen@corp.free.fr>
	<20261109124618.933149-3-acassen@corp.free.fr>
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

On Mon,  9 Nov 2026 13:46:13 +0100 Alexandre Cassen wrote:
> -		ret = tcf_idr_create(tn, index, est, act,
> -				     &act_bpf_ops, bind, true, flags);
> +		ret = tcf_idr_create_from_flags(tn, index, est, act,
> +						&act_bpf_ops, bind, flags);

Now that we modified all actions could you take a look at removing 
the unnecessary API variants? tcf_idr_create() has one remaining
caller AFAICT, so we can probably rename tcf_idr_create_from_flags()
back to tcf_idr_create() and make using flags the default?

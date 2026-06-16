Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698D248886;
	Tue, 16 Jun 2026 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574824; cv=none; b=uHNMVcvrXGgiHCqpUFaJ3ggglXHVn5Y6hjBKUyLnfaTh7b8LqUC+rG8jS2EzlHEWneqZZnG3hw+B+aXfdweL21St/dK/r3AVn4WGjp4Rzjc1ESOgo4wvNIQS8979MH37HmunC4z3bVnNaiTtdXKERtWDh+4RpXJ9oORokgQEjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574824; c=relaxed/simple;
	bh=kNeCfqEenlY04WlHne1AA7F6OaLYPtklWk5bpmTB1Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTOi71oxTXwyGNNaTWG58uAr1yo/V+8Z0DK95oDJlVH38ADm6pooTkHU8eT5XgRdhTqdbANVCi/RCAlUSiBaN/TUi6/GI9BCMBCYj5Ua+PyltXKx+T4tYuPl98yY3jKnBr7dv4BetMqbPJmuyX7XyJ/ujnPpcYRP9eTrwfIl40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1fwelov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1fwelov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439FD1F000E9;
	Tue, 16 Jun 2026 01:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574823;
	bh=cC/Qq17Q/gmbCF8jfLZDR9hb9OX1RM4b10Kgps4ijI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k1fwelovHEcxdGS4GGIR0EPViVWaXXA79N1xszdfnw4umHPw9c/8FiwX3tB3vG5UI
	 NanEBVxW6cIstuX/34IHyW9Q/GAduANP0rFzwIM/em6UzV7JsaP3+oWYH3tneG0ANj
	 yE4cZyzE3RsHdIyR/ZPCQXEWnzzeWW78EynuAyXfyCfWXrM/Eo+5IG4NNQdq0OXQjV
	 L36/lMPQLL3zP+689zpC14rC/MOuK4yLsS6LPGyj8kkc8eCpDJLZVLd8z3WsWNU3hY
	 AH0VdMLa6yXC8wMAFRWDfG5ohMI8pDpwuo8u/rrpWdAn7+9FFrVgPH85EmT8geOsoR
	 SNWHPyAdFuC2Q==
Date: Mon, 15 Jun 2026 18:53:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: hawk@kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com,
 simon.schippers@tu-dortmund.de, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Chris Arges <carges@cloudflare.com>, Mike
 Freemon <mfreemon@cloudflare.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@toke.dk>, Jonas =?UTF-8?B?S8O2cHBlbGVy?=
 <j.koeppeler@tu-berlin.de>, Breno Leitao <leitao@debian.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/5] veth: add Byte Queue Limits (BQL)
 support
Message-ID: <20260615185341.339a4dd8@kernel.org>
In-Reply-To: <20260612083530.1650245-1-hawk@kernel.org>
References: <20260612083530.1650245-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 10:35:23 +0200 hawk@kernel.org wrote:
> Subject: [PATCH net-next v7 0/5] veth: add Byte Queue Limits (BQL) support

I'm calling it a day and dropping all remaining net-next patches from
pw since the merge window has started, sorry. You know the drill...
-- 
pw-bot: defer

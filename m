Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E764E80BC;
	Thu, 24 Sep 2026 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271894; cv=none; b=RRPytfwWXWmAVcwP0KSqdkZEcdQWG7bz59owHQcOV/8FXOwC/5Gi696e3sJlgQWsndIhmx992Yr/7KZGpFqvJQRid/rVPJkqNOX/sEjh+phcXGOzsAaFqbjj1UTvM55SRBwXAVetxyS3Y/o9KRLJd/6zU6DxmGii4toTIs3E0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271894; c=relaxed/simple;
	bh=EchcdEmFKHjIOxyspAG9iACSeu3zFRS6fVKy9RGVn9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9obT1eppEbTD0TuduTXztMkQdV1tgz6+dUXst90Z3VRO7DG54QSYSRYrYjSpH2EjNJ8/KT81oUxQLPB1vvNUqXcnAK8c3KnIEfgPOCJQj6hXLrop0TAJsuLwiymQGwiiNat9FSYvyROtu53JitS6v7rvLEffaeU3KXJ/fq9XQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCtEBfvX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCtEBfvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EC01F008BF;
	Thu, 24 Sep 2026 17:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271891;
	bh=EchcdEmFKHjIOxyspAG9iACSeu3zFRS6fVKy9RGVn9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UCtEBfvXjQUle5VXq9I42EgblWltmHBcA7/v0iRl/Wa/3q2VHnYypHuEsBaKilmux
	 u37YpZspDGkIkVoI/U/4zWGB1UUFWcmxggn75AspGB5HDxLiFysHL4UqQfRKM5JokE
	 icwgh0r4EGr742bQai5H7+Q+t8/+CokWoCVuaN+Iz3oA7A4hVjh7//iN5PzEqZxPU9
	 lwD++GcUJWpHL2F7rouFeism5uhJTtnoDOvw8CA5qfGC9A8Ybz0J3ru0qszZJc71Yx
	 VwHVGT5TeiCey0YK6WCJA0i6QRfau9ybSlbeeAY9PWlq6Gt/eZWmJamMyh2J6FfFmA
	 f/hQUBs/vqpfA==
Date: Thu, 24 Sep 2026 10:44:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Toke
 Hoiland-Jorgensen <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net v2] net: mvneta: clear XDP pfmemalloc flag between
 frames
Message-ID: <20260924104450.239dc351@kernel.org>
In-Reply-To: <20260923-mvneta-xdp-clear-frag-fix-v2-1-298693a7ea6b@oss.qualcomm.com>
References: <20260923-mvneta-xdp-clear-frag-fix-v2-1-298693a7ea6b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 12:12:41 +0200 Lorenzo Bianconi wrote:
> +static __always_inline void xdp_buff_clear_flags(struct xdp_buff *xdp)

I think calling this reinit_buf would have been a better API, we may add
more fields that need init in the future. Let's hear from others..

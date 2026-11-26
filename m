Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.217.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795716432;
	b=pu+uv91yjTC3MX/eieOkKI70gmTQxDXG8peYkt39vcZojphtSuSvHZcEPtGGQmAE80a1
	 rq1ROi18RA6QK/lkKWjqGjxRoI/siavcpTPxKim0YkyaDyuTXf6IR3raH//38QvwPOQtE
	 /hX2+siz4nbG68h79sbBpxTfkGTGtz/XOTZfSwZI4Af/jWhH98IOjCZMoWt5aEwD5aIO6
	 Nuz2rLGjqvnW/EsSzDkSwjPtfNTSmajbUeDRgCmgwnRxBVxsapfsMIqD4PhOmtNpFrlXv
	 eP/dFcIBbUhRGQYMTe+A7MzYloKN1VC5wyOOi/FSehnvGzI9nzAEqJnmgA2z8VhEKkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795716432;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6+hU3UA5s6I/NTpkLAZ+BjhMDXENiELATWgF9iF0YoM=;
	b=FJ5h7D3wJmO/wDm7yAAZCXISybHjJwAQrmqyDVBbugYCip5jbeG8AMtXBnkJWYoKWptR
	 fQ7lUZ+MeOdqyUw4TGUbQKKkEmsMC9u25ltxvx8xCIKp1W4syhZB58tAuKct9uXOGhF40
	 x7Y9QK2X8Jj+FFlC2oT5mAkvobjKN82goNCXgTX0uAWT4hxvfg2KLUxvx39O90W2OCpJX
	 8rH04NKd7kYGAEQHJcwr7ajcvtjTuu2LlpcKxLtlnqW1sf6HbgSypk8LVQm09oUHdko8E
	 oQOiB2Q2YRFYFvz+93YJWVHAUHYSg1x1rt/h17qiM49Pr6eRg81D5K0JRXGbuoA48/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-dortmund.de;
	spf=pass smtp.mailfrom=tu-dortmund.de;
	dkim=pass header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b="l0/9dwIa";
	arc=none smtp.remote-ip=129.217.128.51
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0765A606A31C;
	Thu, 26 Nov 2026 18:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0765A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=l0/9dwIa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1795716398;
	bh=6+hU3UA5s6I/NTpkLAZ+BjhMDXENiELATWgF9iF0YoM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l0/9dwIaZpv+KDaKcRsCxtAWIRuftNDPPiORFqoPlZoL7yzV18Gps4cON6/XbGalv
	 vyAgqxPfsb/Ti3JyD7/YQS1FVU7T0CMMz7blxT/0EkCi4Vvz6Xj5+WHzwtoS+lgRjz
	 XPL5rSlTFdgjSRLunmb6mqGyOtOUbqB2ZgCZ/wcg=
Received: from [129.217.186.54] ([129.217.186.54])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6AQI6avb020167
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 19:06:36 +0100 (CET)
Message-ID: <61e80a8e-320a-497d-a24d-708dd1acff10@tu-dortmund.de>
Date: Thu, 26 Nov 2026 19:06:36 +0100
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
Subject: Re: [PATCH net-next 0/3] veth: earlier txq wake and stop under
 backpressure
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261125152311.805325-1-simon.schippers@tu-dortmund.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20261125152311.805325-1-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 16:23, Simon Schippers wrote:
> While working on the veth BQL series [1], I noticed that veth was
> sometimes faster with BQL enabled than without it. Debugging this showed
> two reasons, both in how veth handles a full ptr_ring since commit
> dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce
> TX drops"):

I looked at the sashiko review. Both points are right, but they are
low-severity comment nits with no effect on the code, and addressing
them would only lengthen the comments. But I can change them in a v2 if
preferred.

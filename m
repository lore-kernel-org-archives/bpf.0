Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE930D3F6;
	Thu, 11 Jun 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172418; cv=none; b=tWeOpLs6SJ82o645CRjqYVnBdi+OcYrEfIIBEDTZ1fD3THa/hwt66Njx/HEWWW2j2On8gUVpbU6frfza4fEWrDh4aE+GBwhbknxOvEC5v/n9qVtho3dQ5xfoyiUP2Rqc+ooc7//B0NzOyf1VTtFbPgWIalQXFiPS0TfuZ5DLMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172418; c=relaxed/simple;
	bh=/xieWpnKuXWj9p0SPPFhKAnvmB1gDQbHe4Qyz52Ad1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKCZ8qDm43puOW9dNVv5AGb7Ma1WDCzM7nDEcu35i2g8xt2DTMges9J1E2led3nCQT4/yNJQxnpd02wlYP8btUHcIc9odx0Fz24TOvqp+sfglAcUN74Fvl7u4kIGJOYoRuJao+PxcgX6ERVRWF7xsHouMDHKeE8jGsrSyAMuB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcCMiKa3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcCMiKa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043241F00893;
	Thu, 11 Jun 2026 10:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781172417;
	bh=XFwuBdFthRNbSJhoPE5Av6WikZCj/iG5U1ef3fg+vqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BcCMiKa3EwgwcWdwol5h4vv2R8bv7E9XZN2ahIsMR3Ca90/qo41MO9/9TQq4qlsD4
	 j/u2fhHtAzbu0MxpJZ5Fiy1dYdgTzBXoRQEyR6cbSjg6CxdnW1s7i2I+LVpcMOWh92
	 /I/zczmhi6SrlXDbJuwqn3xb0S4ReBOXe8xwwSnVw77uoRBHHhxvkaGCPTKVWgUEEP
	 9EsuJshHGTYsjKWq8Ya3C36VRGCDM2zyZ90SHW7ZtvanoqNVJEQeHYB/jnjMdskJa0
	 dyIRxQ1558vrAAg0C/Vvd4Z3cAdSF6HhZmT8X6Q70F8z9qMaqZTPwk4h6775mKJ3LR
	 xKmuv/+zNFv/g==
Message-ID: <95916189-8a5b-42da-88f7-9f26891419d5@kernel.org>
Date: Thu, 11 Jun 2026 12:06:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] docs: net: fix minor issues with XDP
 metadata docs
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org, skhan@linuxfoundation.org,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me
References: <20260609201224.1191391-1-kuba@kernel.org>
 <20260609201224.1191391-2-kuba@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260609201224.1191391-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/06/2026 22.12, Jakub Kicinski wrote:
> Minor updates to the XDP metadata documentation:
> - s/union/struct/ for xsk_tx_metadata
> - document nested request and completion metadata fields
> - point capability queries at the xsk-features attribute
> - fix grammar in the XDP RX metadata guide
> - typos
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
> CC:corbet@lwn.net
> CC:skhan@linuxfoundation.org
> CC:ast@kernel.org
> CC:daniel@iogearbox.net
> CC:hawk@kernel.org
> CC:john.fastabend@gmail.com
> CC:sdf@fomichev.me
> CC:linux-doc@vger.kernel.org
> CC:bpf@vger.kernel.org
> ---
>   Documentation/networking/xdp-rx-metadata.rst |  2 +-
>   Documentation/networking/xsk-tx-metadata.rst | 30 +++++++++++---------
>   2 files changed, 17 insertions(+), 15 deletions(-)

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

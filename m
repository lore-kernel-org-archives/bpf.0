Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447437;
	b=ZT9XaxJqgJu81v/+7Y7B/FItj/tIOUGtjfTqaDvWPelgc4phgXkTKILID9qvbRsd8XDB
	 n8PiPhyfH1a/hXDyABtvX/Yqud01NqUMGLBblVbEFHc1gm4DJfSnAFXmm9W4bAqCSGccj
	 b/1spEhi0gvH9qd48rJbKM3O2Wlp834tV+Duh/aSAfL62/YpNWfwDOH6SWHGpbQL6Ye9F
	 1Ss59sTmh+Q9URUZlXUM1WKuPLvmoj8eLlGhS6hK9WfSwhBgucK3s+Xy2YFG9lxqW75Kk
	 F0tWyY1sm88ol+PL6DDjfPxgUjRYsLD2tE9tQZ3T7uF2j9fL7FDQCVOJqJqyCbUYi9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447437;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=btUPWx1UcmpMZ1wNFLhAkAK57tox2FcAT8+j9g6x7RM=;
	b=Y2dfEZPcncADqzXvCIGNgP6Tr6NEwN92m6c/3Kgko8IWaWC4j8PcTuPC7W7U5tLCAM5v
	 wTOscnsx+nPC6DnCV1ghqACzYYGg0oXRGh3z0OJCDgfHIh4JHZsiAFxr5zAZ9SEq4fdQf
	 yizRKkjqLdPqC0G7WI8SGJJwc0wsBju5OxMtvyB/61Tli4DyGpBbfbF8g9wTepQVAfNv7
	 vCLHzERynGc32n5HQ19bfuIJ/eROg640dImf5gJnc03Tb98vl+qzzTL7YnWXSDBUELlxY
	 wDz0LDCZg6YYI/AoVmnsHP5EhpVGrtGFJRAYptL7YKuq3yikZQIaaO3cv2vgFutuRjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWGOzBnY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DB3606A31C;
	Thu, 12 Nov 2026 01:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWGOzBnY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3507E1F00A05;
	Thu, 12 Nov 2026 01:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447437;
	bh=btUPWx1UcmpMZ1wNFLhAkAK57tox2FcAT8+j9g6x7RM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aWGOzBnYNa0wVY3pMutI6+4BN31XNpQd4GlZTzAz07lsL0KwUtBb0lgZ6nVvKze6F
	 M9w2uEqj+wtz6a6Ww83J/b9Tol/gqGQcPRgGd8Hqn85BgIyleFGK7zi+JCGmEyvR5E
	 M3dOXdjmq6lvympxiICUmANRGPspFpZq0jRylkE97o5VxM6HAGPj3aDMl3HTcUvek8
	 ZS/G34DyqhyDR1stf3cbqOtS1e0nxdC28q5zxbow87lTc4D9q3KGteJlGd5vvQaVOk
	 XaYDgIf4oVx0BrPT2CV6vUDc0AKIo87i719Bc18b2GUBHeJw+gRyhYGs48kNFm0/+0
	 qaWLKBH4AQJDA==
Date: Wed, 11 Nov 2026 17:37:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marcin Knap via B4 Relay <devnull+marcin.knap.vecima.com@kernel.org>
Cc: marcin.knap@vecima.com, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Magnus
 Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, Simon
 Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, jtollet@cisco.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFQ=?=
 =?UTF-8?B?w7ZwZWw=?= <bjorn@kernel.org>, Jason Xing
 <kerneljasonxing@gmail.com>, Nitin Shetty J <nshettyj@marvell.com>, Joshua
 Washington <joshwash@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Bharat Bhushan
 <bbhushan2@marvell.com>
Subject: Re: [PATCH net v4] xsk: Do not free ZC Rx buffer when the Rx ring
 is full
Message-ID: <20261111173715.75bccc04@kernel.org>
In-Reply-To: <20261109-xsk-zc-rx-double-free-v4-1-24e00ac221a0@vecima.com>
References: <20261109-xsk-zc-rx-double-free-v4-1-24e00ac221a0@vecima.com>
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

On Mon, 09 Nov 2026 12:01:14 +0100 Marcin Knap via B4 Relay wrote:
> This covers redirects to an XSKMAP. A zero-copy buffer redirected to
> a devmap or cpumap is copied by xdp_convert_zc_to_xdp_frame(), which
> frees it before the enqueue can still fail. That path is not changed
> here.

But what's the plan for fixing those redirect targets?
I think it'd be much better if we had one series which
addresses all the cases, which AI can review...
If there's consensus that xdp_convert_zc_to_xdp_frame() 
can be trivially handled later let's document that (and 
how) in the commit message?
-- 
pw-bot: cr

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837EE364E87;
	Fri, 20 Mar 2026 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994400; cv=none; b=FCZ7WMJlzIr8QnNisxb8SUb18zF0TM4dB6xTPzDjTiT2vvQX7/peb2z3rZpjS6OtdpVPMPTq0qXKcVbAKAj7u5mBCt1cpyZeF5dILPsGQMm0V71KBkKx4gaEZKoKNKLHqH/0wbYv+NLalkObogCq9LANRXNt43UWTcX+5foC8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994400; c=relaxed/simple;
	bh=b5xDM7DwkSZAXjttSN7ldY3nBQRjJ46emdFic4xKHA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OKxeIPRs57X+fxl8G0y/PAmrcNEbDMuzavqSQ8etIax/TjyREzUKuFSeYAnDjJ921dZj88bEYI4IhJFOPGb5+kXrL2TJslViGc7YB7xiW0A8iUIRDfYtNw77zZqCh6ZIWJas7minpbUw6avImwQz1dd2WuVCl1wCglgxZicSVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c38OZKt1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c38OZKt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C616FC4CEF7;
	Fri, 20 Mar 2026 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773994400;
	bh=b5xDM7DwkSZAXjttSN7ldY3nBQRjJ46emdFic4xKHA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=c38OZKt1HdfyMO/J9O9SvP1x/LXvgPbUsUO3cMP3+u1Jvqd+xyKnVB8HFz5MLXN/b
	 SxgOty443lhX21IBZrRlveutNxSS5/NnVToaX5wDH6iyj6AoDDNCD8mcHsA4tvFG1V
	 DDkr70Pcg4CbhNUPLgw7N7WRwKnFTgTvvUhienGb0GOW6HB31fS/J+OxaRgGjuPbbK
	 9qWwcjPWyP1ARceHm+dkA9NwbMkxygfPCpAlxNtKcsa0vc1JnWWL5WaF0nJU8w1VwJ
	 yYFk1pVFC2dCGUiEaVu9wKs2Z9C/Olxxhomcfa/1QeLzaLOo9vg8WRDzURKorWLQqu
	 DHGa9NqVETBww==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net 1/8] xsk: tighten UMEM headroom validation to
 account for tailroom and min frame
In-Reply-To: <20260319175538.479139-2-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-2-maciej.fijalkowski@intel.com>
Date: Fri, 20 Mar 2026 09:13:16 +0100
Message-ID: <878qbmq5pf.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> The current headroom validation in xdp_umem_reg() could leave us with
> insufficient space dedicated to even receive minimum-sized ethernet
> frame. Furthermore if multi-buffer would come to play then
> skb_shared_info stored at the end of XSK frame would be corrupted.
>
> Multi-buffer setting is known later in the configuration process so
> besides accounting for ETH_ZLEN, let us also take care of tailroom space
> upfront.
>
> Fixes: 99e3a236dd43 ("xsk: Add missing check on user supplied headroom si=
ze")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

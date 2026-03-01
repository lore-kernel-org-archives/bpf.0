Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25008175A7D;
	Sun,  1 Mar 2026 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772389828; cv=none; b=L9KdzklrGWX2NaVzNdkiGVKm/f+tMU6O7p+CvrTGadKqML7wBP7wvTMVLjAlTJ7aJnOOpohCSHH23YrLg7/hXfX4vVEGCZPKAGXUYhU8NeY9aSfNn7l8WqhNBib6OWRbcRohGUowlOud2niJ3UbK8+LATyMG7xhIKZ6k3iNdVYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772389828; c=relaxed/simple;
	bh=vGBT1CRkaStGJJvFrAHCByqOWl2Xsq8KpNcMMUGtREM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syp1FnUtWWy06mQD7fmwhhLMDUK19Yeniwi8LzekaCwz0xP87WhFvA25WDar4peznT1hsHKc7Zti0a84kllW5qdeTQekXLfOcPH5wbJQRsUf25bWn1jQKndF9kJpSe4TwrVywCMQiQQ7Vnc3EHBT0pTDyKFMyFfsRVyAKzyExSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1tj63Le; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1tj63Le"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F451C116C6;
	Sun,  1 Mar 2026 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772389827;
	bh=vGBT1CRkaStGJJvFrAHCByqOWl2Xsq8KpNcMMUGtREM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1tj63LetdqMY7WPcDH0WBVp+mGiFlaHWkFu+ZO/eUKLQJlecjS4dIpgN1NsJJ00E
	 HeN/rI/nvTUK5+p8qbwUcquDiW8szvu7cPINpGUKmeIHO6RUp7nx+Rz/s3oxDp8CYT
	 vqI0MfOd4RhaQmHKInBARPsvNoM87+/s55MIIlxW51D5IfWwghEO5iE/xMPCWy4O6c
	 ibNgDUzS1SL1dTpahCDeKdP+S5hxNWu+vi6iOEf56dTy2Vg0R+wKzE4X8KTV1kMIA0
	 nIulaYaayTW64Zh1QWhJ2JCRml49ux39r1Vg/D39dc+UX5Smo/8oxu5ri0UQLrIwt6
	 /b4T8Ucjye0+g==
Date: Sun, 1 Mar 2026 18:30:21 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paolo Valerio <pvalerio@redhat.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: Reset prog ptr to NULL
 in case of error in mtk_xdp_setup()
Message-ID: <aaSFvfXen4XnmPpP@horms.kernel.org>
References: <20260227-mtk-xdp-prog-ptr-fix-v1-1-b73d7588b645@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-mtk-xdp-prog-ptr-fix-v1-1-b73d7588b645@kernel.org>

On Fri, Feb 27, 2026 at 04:52:11PM +0100, Lorenzo Bianconi wrote:
> Reset eBPF prog pointer to NULL if mtk_open routine in mtk_xdp_setup()
> fails.
> 
> Fixes: 7c26c20da5d42 ("net: ethernet: mtk_eth_soc: add basic XDP support")
> Suggested-by: Paolo Valerio <pvalerio@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

...

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A543101A5;
	Wed, 21 Jan 2026 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961332; cv=none; b=QcncV/3TMfjTviuFaYHFlZfkil65DvKnZPVmcSq0HGjAbIxwnp7JkaNKSD3zAJwNQicxhtB6zMHL228gcFSJSsp0ljFrX12WLCzcWKFPgS2V0Mkk6F6YVodlo9zUeB49/SDmo3PigYnSAilRaSSpvmc9Y29tS6RtiwoqyPNEWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961332; c=relaxed/simple;
	bh=ZIVqkn7aaWPlZO+GqB+e1APPFmE6QxIG8Nb50lWT3N0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+rUQkN5Nn9PBN/1v9qNzVOk3qWsli/W37RXmU+AHN/pSxr8nOKBkABKiOcepkjdMC4W/BZazjz5h6bi2fekRTAjQGw1W15zL9OsLTbxxkuKoM2tyK/5r7R1fST0ujO2qPhBjbjfjmHjlfiWm3pBllDwOQJLtjosKI3y2wAyG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckifaalR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckifaalR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B79C16AAE;
	Wed, 21 Jan 2026 02:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961332;
	bh=ZIVqkn7aaWPlZO+GqB+e1APPFmE6QxIG8Nb50lWT3N0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ckifaalR4goMe5fZSVZsJfJOmxD5aIqoeFoGb4bi8cGfISyiSNIKM1fFDuX55O/6d
	 X4gJIU9T1VDa4s6F5wA1sowCSQjpdyiV26RrB7AA1m/L4r7H4WNct8Rygo6829LNWi
	 5JPS+rrEx6MLqDlOKDAitaljGN5nU2x7SCHd1PamCiX1nsPwfuIP63xgBrUEPXddZw
	 0RaaKbk1n+9HKG8BWSAoXl3ty1eFjJT73vNpvCTAmQypNufpEOkCYBNjJZOHfx64mp
	 Sn6tSwc7yuAQwqTX4wpMchPtIza2CSEdbDqTC3o2NdcSDJ7ZCsEnOSTp2iGzFq0W+z
	 seXZObBs7w0WQ==
Date: Tue, 20 Jan 2026 18:08:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 00/16] netkit: Support for io_uring
 zero-copy and AF_XDP
Message-ID: <20260120180850.45ae4214@kernel.org>
In-Reply-To: <176890982554.757566.17882816780312694183.git-patchwork-notify@kernel.org>
References: <20260115082603.219152-1-daniel@iogearbox.net>
	<176890982554.757566.17882816780312694183.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 11:50:25 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
> Here is the summary with links:
>   - [net-next,v7,01/16] net: Add queue-create operation
>     https://git.kernel.org/netdev/net-next/c/a5546e18f77c

I'm going to revert this, I sort of promised Pavel I will pull his
work and he has the cross-dependency with io_uring. Y'all can rebase.
Plus what this series does to "the code I wrote" saddens me deeply.

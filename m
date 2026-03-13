Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72327B4F7;
	Fri, 13 Mar 2026 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407436; cv=none; b=qEHTePaPAGqnGeSOYTfPgIqUARYPpkZ+KaoNPKsMM7Gn4gzppXc2wF9cKeHjlw8LQW+99AxePf+fEr3RzqqJpBGxH8re6ZEQp9ezpFovf8RVLaMng3d7Laqky520mYNXHC5BoqOMpR/hjhRjKKLbuwQvTr6rKjzCKs+dqNyDikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407436; c=relaxed/simple;
	bh=vwogDLBb4glPRani4L2Ss2Ekn/HoYwTUUMhHpHLV/mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRYCrQzwL8XRebBt0oc+yj4PWJZ2aZbHG4QIILD2faWwtpYS3jQ9pLMP65kCzsYWSZTz4h8yBYg2scLSGzj8KjxBSppNyU/nLvXTcxk4qzMjHNI6cUbzrp1U7fuy1wZFmLVWbTEfwXiEesaeWGMgaY9RLxCmzFCkHd0l3J4coiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNojZUh+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNojZUh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F77CC19421;
	Fri, 13 Mar 2026 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773407435;
	bh=vwogDLBb4glPRani4L2Ss2Ekn/HoYwTUUMhHpHLV/mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNojZUh+gFaH2QRXBucakHU01BghXFsWk19vCgkM6aew/ebFi5ynWio67QbZFkXY7
	 TCSO3KMjYnEJIOr72QVQ2fRJyHGJGGSFuuGoVhrq0ZRPPdtby2DECkB7hVr/6Wehe1
	 HyKnhRCIY1AlzPWyCpddwDe/y70Npx+H3p7dKsKq11RK0yaA4FbE7tmi3ihbHW2uVy
	 M/IKbO5V7DL8HVxyJUPUwU8lQVs6/3X2pZNnB1oxz5Sjv2N3gmJqG3fKtqzCKtwySo
	 A49STKw1eLCTjH45zFraS5RBZnxV90Jx9o7p9WiwMzn3nyyLW7b3kgbx0n+6yHZjkH
	 OBx7grXCjImhQ==
Date: Fri, 13 Mar 2026 13:10:28 +0000
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: vadim.fedorenko@linux.dev, haokexin@gmail.com, jacob.e.keller@intel.com,
	sdf@fomichev.me, john.fastabend@gmail.com, hawk@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix memory leak in XDP_DROP
 for non-zero-copy mode
Message-ID: <20260313131028.GA1311528@kernel.org>
References: <20260311095441.1691636-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311095441.1691636-1-m-malladi@ti.com>

On Wed, Mar 11, 2026 at 03:24:41PM +0530, Meghana Malladi wrote:
> Page recycling was removed from the XDP_DROP path in emac_run_xdp() to
> avoid conflicts with AF_XDP zero-copy mode, which uses xsk_buff_free()
> instead.
> 
> However, this causes a memory leak when running XDP programs that drop
> packets in non-zero-copy mode (standard page pool mode). The pages are
> never returned to the page pool, leading to OOM conditions.
> 
> Fix this by handling cleanup in the caller, emac_rx_packet().
> When emac_run_xdp() returns ICSSG_XDP_CONSUMED for XDP_DROP, the
> caller now recycles the page back to the page pool. The zero-copy
> path, emac_rx_packet_zc() already handles cleanup correctly with
> xsk_buff_free().
> 
> Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>

Reviewed-by: Simon Horman <horms@kernel.org>


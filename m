Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C81F78E6;
	Fri, 16 Oct 2026 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792188576; cv=none; b=PqyPY8FfBzM8VwZSFGMUAz/RvOBW45natVHIHosejgDQ2mTknrbnn53qCseZZ97F5V/pLwlgg1GfolMa7LRX7PnbX3jfn7qJqcOLN+N2GsdY1KwG2gRdciT8obrP9MVzDh2u88p7qMVQxp5A76nJkwK0n+y86NNbSUtWVQxrTyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792188576; c=relaxed/simple;
	bh=GLwbzJas5PXKArHxep2FQ/KdeesZycyGODfzWDZ5zOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTLCsnN7SOSiZha7tL5pSfK73WW6eXLDGm7atV6PO+g33p833RDmdul9phYHTT8xbbCmTnSvMwJzVKJ1If4MnYNy+9MHdj/M4I1DFJmjfmkXHGu/04prBmys912272qAKM11b+kITmItIIq+27jmzRDD7dkJJQC7UgIQ3dXBmug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uqXedRqQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nVby1LuX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uqXedRqQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nVby1LuX"
Date: Sat, 17 Oct 2026 00:09:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792188571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H/2ADdDbuj4BQqbOm4loAw0ifhUty9QJDOLv9sli7hE=;
	b=uqXedRqQ7v+qOd01Fzv6lYfprhhQ+l59Try2TtMDKRs3mkIZIgzMOtxiB1YyePzkIVHgob
	pay/ewdXZ4JwwDOCAdUa1WuV6vBFZUabo1qyqkhnsBcKhhjv2PbrIsDO4zbVw9W7lT/bWJ
	CE0iwC1elZmO+j16+oxI8u5NQzbigRAAm940ZcYswKsYhUGJAh7clLBXIC/52YJzvOaLs/
	XpdZNiWk9guUdIDZ5DAXqx81uspDrCio1qBxzqxOpz4m+4ZpGY+Blz9OmsV0lyoiZ9Ho0d
	NUmAENPWxHqeMZdmfIiAdq0dAiAlVTIGdG8FvdA78o6yaxjU2SZA/xxVnFhn8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792188571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H/2ADdDbuj4BQqbOm4loAw0ifhUty9QJDOLv9sli7hE=;
	b=nVby1LuXwCCsFlqV/iLSSj3/Jnz6IDAHVCzBax6B3X+/P7ufsmH7vr8ikS2vICfZj81NxU
	s9qvsNLH+ChzqTCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
Message-ID: <20261016220930.i32JEcqe@linutronix.de>
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
 <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>

On 2026-10-12 05:04:34 [-0700], Daniel Zahka wrote:
> Keep packet, byte and drop counters on each Tx work, Tx completion, and
> Rx completion queue. Report them to the core via the rtnl_link_stats64
> interface.
> 
> Rx completion queues also count errors. Frames the device marked with an
> uncorrectable error are counted as errors, and frames that fail for any
> other reason are counted as drops.
> 
> All packets cleaned from the TWQ during mpnic_flush() are counted as
> drops, though completions for some of them may have been DMA'd into
> the completion ring between the time mpnic_poll() last ran and before
> mpnic_wait_all_queues_idle() returns. This is done for code simplicity.
> 
> An RCU approach is used because ndo_get_stats64 is not called with the
> instance lock.

Why do you have the two mpnic_base_stats and fold the stats into into
it? My guess would be that on stop the counters are reset and you want
to preserve the stats.

> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Sebastian

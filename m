Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5E4825BD;
	Thu, 15 Oct 2026 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095296; cv=none; b=cXMsgvc6ZQUo24vLBZVYsJn38hN0ZG0D7DWU3P2Ses9NMe3HiRLw+oPFe4Y1ytecIktblwx0a+d2CHQUe8Mb3xnVG/YRVr7Vl3Xlnu/Oq8x8sL1SD3hDNbiR/cEl5a0nhOwiT7rdOWzGgc/6Aya5/GsMNFDMVoQvOkMe7VaIXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095296; c=relaxed/simple;
	bh=MtqwEqTLnBybTkfcTIdJIP76E/6EHeJJw1rtd1xVvfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDP76fi7/TJ6va3+rNB3voIJgVvxSJVke+FICLnNnUHdNa2Npd1mK3Nt30KD4CPe3bFUy4vlnPNDNt9XNHitolVjijSuR31Fz9V8e/5AYYO8Y7sGRFPcXN8KeRWaz21gUuNtJco0wM0PqmbvJzWPE0OQzVAtuPPlvfa+eDMr9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt1zTWci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt1zTWci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA2B1F000C4;
	Thu, 15 Oct 2026 20:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792095295;
	bh=MtqwEqTLnBybTkfcTIdJIP76E/6EHeJJw1rtd1xVvfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mt1zTWciR80TXGVPQ14uTq0MwrcGNYSN4/tgLbddamkPYvovM5CkCfUnM5VuWAUBD
	 8aLkanOg9hkfsWNY5IApIfrlLNGXaX/je+fMeghCs407FL3Ht93W5+Eug0LbfG5qIE
	 c6NgDUKI4jK8VRh4gGgpDgE5WnUFg7Fx6wagmXyI5bO8ByJk9FSQIwfB6EIOIJJ84N
	 NZ4tlhlHcz8IaBlHNUYp/4m5LhoRIeAymeZmzvs0+V6rgZl2YH+txb5Msds0s9Q66X
	 r0hDH5bKMmkgMT5IyD/dvSTEux3WAEfz5YLCDpGcTetBGoUGq1S0ATWlvrGfrs3qzP
	 D8kneJVOGM9Fg==
Date: Thu, 15 Oct 2026 13:14:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Irlanki Sandeep" <irlanki.s@samsung.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <edumazet@google.com>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <ncardwell@google.com>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <corbet@lwn.net>, <linux-kernel@vger.kernel.org>, <lorenzo@google.com>,
 <maze@google.com>, <sporeba@google.com>, <motomuman@google.com>,
 <madhan.raj@samsung.com>, <srihari.k@samsung.com>, <g.pokhra@samsung.com>,
 <r.kumawat@samsung.com>, <raj.kumars@samsung.com>, <ts413.lee@samsung.com>,
 <ramyashree.s@samsung.com>, <daeil2.hwang@samsung.com>, "'CPGS'"
 <cpgs@samsung.com>
Subject: Re: [PATCH net-next v6] tcp: add BPF kfuncs to set per-socket ECN
 mode and AccECN option
Message-ID: <20261015131453.1337477a@kernel.org>
In-Reply-To: <117401dd5bb0$8f05b2f0$ad1118d0$@samsung.com>
References: <CGME20261001132701epcas5p2da9b0fa7ca3bcef1ff84a62f255bc573@epcas5p2.samsung.com>
	<20261001132759.1076145-1-irlanki.s@samsung.com>
	<20261007170028.318acb6b@kernel.org>
	<117401dd5bb0$8f05b2f0$ad1118d0$@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 13:19:31 +0530 Irlanki Sandeep wrote:
> Awaiting feedback from Eric and the TCP maintainers.

No luck, and 2 weeks is the patch retention in patchwork.kernel.org

Please repost v7 with the minor tweaks.

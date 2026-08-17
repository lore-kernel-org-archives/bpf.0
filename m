Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090424477F3;
	Mon, 17 Aug 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981335; cv=none; b=MtKzM3amSeQSG/X5q7ZFX98UzcKE9z+Q82hxbO5t9bdTdAaUK1l2FSMiY1EFMw3pP0wQy4EDO8rGeZpoO4LmaSU4I+HND5bE78OI5H6FNCeTFIS4Hy5sR2t1bJFnuG93h8ngLLRH4jzn6iwfSgjzxGmLt/ygB7hD0Q+bi1thrTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981335; c=relaxed/simple;
	bh=1ys36Vg5YcU2OdIf/DVZlC+1RdDqPRd2ODZ26tx7Tfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TW58qc2JRIbyEkYfxz2d9ZF3PnW96frs5gB561zuBDiJd4yeFvxfTeC+jGq9QC1MM3aMkvtJ1aRGkojdmI5nvjnbNNIlDxRjnHT5XAjIkzrOXU7SHRERcSQou7CsAoubf9Fyp5K0VSlQJEx06d3e5f3du+uHopTHRDtuJHRCzoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez3w20DR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez3w20DR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813911F00A3A;
	Mon, 17 Aug 2026 15:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981333;
	bh=OFCThpN43BCrp3QQd/Jt/lrodI0z5XJ+QKjLYxxozfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ez3w20DRrwJ8y4M/Wb+USEBgBqR1kZqQAVNMUerk/mVyyE5Z2Q4bNdZvpIz43To3V
	 w0rlh+jmGC+XSnvYR6x4lDWk1RrapfxuFc1s1+zP0/tRcAwjRADy4ZMAvoOap7Hq8B
	 bHufDqf1bVdj0t4grQesTDajWmlq2BxR/EkVydNal8ZJiuc5dNOPfhQF2VQcGNifiq
	 J1vTaqQd0Ec7ajCMW11YVSqDVTZRJBgz7RNvuoo/lIHY/5+5zXbnGWZq3+CAtNQobt
	 WgB5hosRytdb0E6MIgx80I632vhTi4m1qTCDoZR/O6j5/NF4TIRWxDNA08XWjBvpDN
	 xKmbh6Wx0ROBw==
Date: Mon, 17 Aug 2026 08:42:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <pabeni@redhat.com>,
 <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v9 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <20260817084212.5d46a501@kernel.org>
In-Reply-To: <20260817032747.1765883-1-rkannoth@marvell.com>
References: <20260817032747.1765883-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 08:57:47 +0530 Ratheesh Kannoth wrote:
> Subject: [PATCH v9 net-next] octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


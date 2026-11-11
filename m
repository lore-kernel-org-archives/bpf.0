Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359337;
	b=xyyw8sV4RospbN6JUOaXQMMp0xgtnFQcZiVOXNVLWkOC1GO2twiWOb30mj7Ww2T7Ei7O
	 PoP8qaMt2s6WRB7T5mACJTCL9y5tRMQOh6vsFW6a4Xv7Y04MKGOkUJAK/3zyWYPiCLgcp
	 9Zx5UD2jSxf5yZBS5IJqpflg8xCAX8PzuBbbWW/jLXe0155MVSsYMrGN+2LSlzNCvf1Y6
	 4IqN4l+r+EO9k7WEGgvemTNqBYBBoLa61dQD8n7wTqKxeJzgO3fgWAsz+4+94OO26SZjW
	 lbuBP5u/xbGyLy31RVOom3WBqdPXzpyjkR5nYoyJKwTk/Kgcir0GmLw7Thi115gj9kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359337;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TtYY5H+Y2SiCvwprj/5Tw0V7c61Jub2+DR/nTLQbuyA=;
	b=xZH1hyaYl3WZWHsxwiLv+Ekm/3z7Jnupt1pfLuNhY7iQDb3Ee+6dFcyhPWvpJeb077OQ
	 QjEW4fG+x67mCaKtsOpHcQvi201OfOD6K6r22eOHPylqnHfLJtd8m/OGcpd3cJQznUHWy
	 1w8vAAfThlt79Q3PYtkkwEViKTN5foZ7scWCX72m2I8kR61ASuojaQ+FA+AXM2yrdqDDq
	 9n+/hUwiu/BEVmAijFNJ5zWK9McGxqe0pk7j6gm/C4EdSlbQ0wDoUQJvhhCgl5EZtLFo6
	 G4B43eXEjw+kw2H/VGMGSogcq9VFagHHxmD3q8803WqXZ204AeDcwXHFeQc0AlN3EpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjwBpwU7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43C4606A324;
	Wed, 11 Nov 2026 01:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjwBpwU7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014B01F0089F;
	Wed, 11 Nov 2026 01:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794359337;
	bh=TtYY5H+Y2SiCvwprj/5Tw0V7c61Jub2+DR/nTLQbuyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SjwBpwU7dqWZdRZ4kkbA1nk+poWewJqXfHR2dyQNqVzIavNmA26qBXraIdwli3SbI
	 NsJfySyhbnv+zgW5selm++whA9SAhVFwm8Qw5c7maCNztHb/MGRJXKSvPc9NQ3WUne
	 AjsXg8O3BGQdUTJ16iPQGl7ZC/TEXQ8/vlwRySFNVrP20b3IsQ2ia3/vjYDJERZCUf
	 QC+j3Sig14Dyl85Vlya7AAy7uwoYT5Spu7oyL/JLrxYmcNvo3OCfwgi5blymiXJ/Lw
	 V9MSquHwhnIBDj+CXUR4Si09Xv7qkQhs7zcdleFWcBlYk4TvSGEBmuibdaqi6kpVnN
	 z2t4uvr8k/DiA==
Date: Tue, 10 Nov 2026 17:08:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, toke@redhat.com,
 lorenzo@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 shuah@kernel.org, hawk@kernel.org, kernel-team@cloudflare.com,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, linux-kselftest@vger.kernel.org, jiayuan.chen@linux.dev
Subject: Re: [PATCH net-next 0/3] veth: link RX queues to their NAPI
 instances
Message-ID: <20261110170855.5b05db3c@kernel.org>
In-Reply-To: <20261105143356.17062-1-tianyi@cloudflare.com>
References: <20261105143356.17062-1-tianyi@cloudflare.com>
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

On Thu,  5 Nov 2026 14:33:53 +0000 Tianyi Gao wrote:
> veth does not link its RX queues to their NAPI instances. queue-get
> therefore reports no napi-id for them. napi-get lists the NAPI instances
> of a veth, and their thread PIDs when NAPI is threaded. It does not show
> which RX queue each instance polls. Userspace cannot tell which NAPI
> thread to pin for a given queue, or which NAPI to change with napi-set.

The test does not apply, series needs a respin
-- 
pw-bot: cr

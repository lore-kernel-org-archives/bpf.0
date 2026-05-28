Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029EF2DF6E9;
	Thu, 28 May 2026 02:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779933772; cv=none; b=BXozoqFa0M3TMT//4SzbwxptLemsYLIFuVSuNpHi3Ez+cVJ2lQcgCL5eFBLaGvKBBGpE4/3g/ZdPU5HhHD8KuQNR9RRWL/cSucx6GtJHop+RaV7sJnqJjist0mTtpPUp6Z06z4qcBfelDY3Dhu4IEQiJWidttp1zh+bgLiU9VpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779933772; c=relaxed/simple;
	bh=sdEM9fHLlBUaq6iWQM9rEm2DqBl0Gym20sdRpF3nBjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7V6oVSR98ItQzugGBy5zVa2hVdeohzfVbL6Dqdr78ZB2yUEaXnDSzma14H+tf6UJQaGjwXzONntcqyxB9Q/0pMzC/LKL6RJlCNp0nbAzbv8CiBVnqSIsHsvt60Jqz8LRVP87HpNtWyVPeI4A2Ci2HUqMT2IsxKpIYO+Ynby7NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQxv4F++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQxv4F++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEF61F000E9;
	Thu, 28 May 2026 02:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779933770;
	bh=b5aqKBiPoSP1skkwuu26lNOnHKIU/K7yusumXc+fDng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BQxv4F++Y6gqFzjgsTJXKYJZQDE8Ok8L/Lk1tPRcuwRltSwAXUQek7so4YXeQjE1C
	 sIGfuuieLPcNKxZI+E2ZF4DgaAWoCaq7q6qf2bHRizwEgreUxyinat0FthC/hsZqNU
	 0Ie1UcnKFdVWV+Dkp+OLSwIYqnm9pmU4RZ4v6DBCYJgsD5V0KBw+FcPnACQKhHBP37
	 1/U9mBlTidCVvq6VOgTAGYrMN1vqJgnOwzmksyCZOFZ0Pt9AWmB9Jm1yvWtPg14GRm
	 PbJGEf7oFklNWO7ieEvl7PFuwXuMGEUr7UXmBTMVt9DeF1IbnM77g3F82hcv7YyGh4
	 JTnnT4zJPE4Ww==
Date: Wed, 27 May 2026 19:02:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Til Kaiser <mail@tk154.de>
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com,
 linux@armlinux.org.uk, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, mcroce@microsoft.com, sven.auhagen@voleatech.de,
 bpf@vger.kernel.org
Subject: Re: [PATCH] net: mvpp2: fix skb not reflecting XDP modifications on
 XDP_PASS
Message-ID: <20260527190249.0eefda22@kernel.org>
In-Reply-To: <20260524122334.1730451-1-mail@tk154.de>
References: <20260524122334.1730451-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 14:23:34 +0200 Til Kaiser wrote:
> When an XDP program uses bpf_xdp_adjust_head() or bpf_xdp_adjust_tail()
> and then returns XDP_PASS, the driver ignores the updated xdp_buff
> pointers and builds the skb from hardcoded offsets derived from the
> original RX descriptor. This means any packet modifications made by the
> XDP program are silently discarded before the skb reaches the network
> stack.
> 
> Fix this by saving the post-XDP data pointer offset and length back into
> rx_offset and rx_bytes when XDP_PASS is returned, so the subsequent
> skb_reserve()/skb_put() calls use the actual packet geometry as seen by
> the XDP program. When no XDP program is loaded the variables retain
> their original descriptor-derived values and the non-XDP fast path is
> unaffected.
> 
> Fixes: 07dd0a7aae7f ("mvpp2: add basic XDP support")
> Signed-off-by: Til Kaiser <mail@tk154.de>

Other than the checksum complaint Sashiko review looks legit.
Please respin and try to fix more of this issues in one series.

Could you try to run:
tools/testing/selftests/drivers/net/xdp.py
it may surface other common driver bugs.
See: tools/testing/selftests/drivers/net/README.rst for instructions
-- 
pw-bot: cr

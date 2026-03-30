Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061D23958D;
	Mon, 30 Mar 2026 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913360; cv=none; b=OYSOPx+mkluO5y2Vx3x9pz4wQRVMVpM9QxIQ8voy4luN4TuJtJAm4B/rIkWM9d3WUyyrUKAYvDChyDwNEDAWsPhDZQ4wcQJjsh5ZIYhqk6eqp3JdHoXiccQUjcDRyR0empL3ek2SAyxYmCD3hFNTr1a7RoPNpJ+zfltcJ2z6pA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913360; c=relaxed/simple;
	bh=rgFeHuvrzx05E9IWEe4+gI1vakv26YPRNrDleApKK2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmSgv+gC7bOFhjQp6w0R8h+6QLMifC3hN+arHGnuLQB7xnSXtqT8cmda83YWrFA5Wao557PjE8WHIn/ssxPCJq5Ew4K2t9X+93G2t6SdqeG+hCR+7JQ4nY/hUCi398u8bfphpZR5FPCM6alNPJ75sl4DOS1FQEQd/+ABmBGeZ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dg2ZbBXt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg2ZbBXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD31C4CEF7;
	Mon, 30 Mar 2026 23:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774913360;
	bh=rgFeHuvrzx05E9IWEe4+gI1vakv26YPRNrDleApKK2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dg2ZbBXt9U0rMEKQ4DPThSEqKEFlfBynjIOmP1hoyFjckAlJFeAzDUawZQGAIaR9j
	 zC//c76MwaqUrj3W3FJCY3kUI0JjjU+DNyyL5Lm43PIHnOZgdOwMpQeqLu4y3/cULU
	 +2sNaL0jKoPyZaon2OKwFzEFHBWAmaaA4EZKQi1hihUWW7inEdSxBTBB9bCFM6EiRV
	 35WtQiK+vgvFPkBF3U1Dl7iQ4mQRvpaAnORYKEzear5SExQgIsEx3GwUlaNU7urax1
	 IEqL9w4z9goUA18W24v1WYASXfIkhapyb5xlG3YSdt3ElY6KQvcMdJCZOLqpzpYz88
	 ZmQhWRzCD+Gmw==
Date: Mon, 30 Mar 2026 16:29:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: test that dst is cleared
 on same-protocol encap
Message-ID: <20260330162908.7413feb1@kernel.org>
In-Reply-To: <3532664e-1f62-412c-9819-b048f62da010@iogearbox.net>
References: <20260329180428.2657785-1-kuba@kernel.org>
	<20260329180428.2657785-2-kuba@kernel.org>
	<3532664e-1f62-412c-9819-b048f62da010@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 10:03:46 +0200 Daniel Borkmann wrote:
> On 3/29/26 8:04 PM, Jakub Kicinski wrote:
> > Verify that bpf_skb_adjust_room() clears the routing dst even when
> > the encap L3 protocol matches the original packet (e.g. IPIP).
> > The dst selected for the inner packet is not valid for the
> > encapsulated result; a stale dst could lead to misrouting.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> For new tests we should ideally only be using tcx links and not the old
> qdisc approach unless there is specifc reason to. Any objections if I
> fold this in while applying?

Sorry for a late reply, of course don't mind, thanks for handling it!

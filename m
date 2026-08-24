Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A537C118;
	Mon, 24 Aug 2026 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594931; cv=none; b=kAqwhdXKE3f/blEfhh6sZWMz9o5mrJRNtc+emKGNZObuxT+EspnimXVP9aOwRwpzwnQi5qlr5rf06i15D4mhaiA6eo3ixG+wvjh3iewHPXiqHdA022/GzmW/1ro9oI4ywTpVUa66bA7F6x5+O38dPbW8At9zO6KDmJSgWQ/QKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594931; c=relaxed/simple;
	bh=nCbyD0xCwlGciz8TNKSnSu8zfJc3S1aAM9DU+Vfw/TU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuyElK+PHeapnRqZUmRzZph4Mtgp0rzVITinX+1Ln3Ki683M7ugaG5KoG064i85KrlcCwsNwcUQT7QKppGWXKPf4cof9LoaXlFMs/F7Fra2hUntK81b49kACZVx920GhHRl7Xp/fY/Aup2R1i84g9827Q0w/2xh+5BISuatjoso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lItfKtJ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lItfKtJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A281F000E9;
	Mon, 24 Aug 2026 18:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787594930;
	bh=3wa0Fwiet/V0RXNR0iS9UGgnBhQWF3AGWDwTdNxkCRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lItfKtJ89RQ0gsi6u1JF8waAKxtGC4yz/uDv38U3j0WDh7u2LRKBzrbolc6BFMvEn
	 D74JkBAtyQ8o7/8RmzVedTAlXCRWrBIB90XlOVhiytVtZK4/pNtum1Q8O3PJMKBvOn
	 NZI0h/oNBxZL47bI0aDsKV0DbThwkFWAqR82ihR6D0EwxLaE3oxmy108dcdY3cI/N4
	 KdoTLdZnMJUtK9Qgpg93hasEQcEOElzYnPOhEwKOhs6IGnzwz37quuIE23tk8Dmyrp
	 s0tBP1yZdqL82l3+iblNL0Eeyve3QL7zP1biI45MHNmuKz9nX+50StI6J8vLO8HL7U
	 oBKf1zj9mGqnw==
Date: Mon, 24 Aug 2026 11:08:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, horms@kernel.org,
 dsahern@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 stephen@networkplumber.org, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, donald.hunter@gmail.com, kuniyu@google.com,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com,
 Mike_Rudolph@comcast.com, Jeff_Howe@comcast.com, srichard@netapp.com
Subject: Re: [PATCH v8 net-next 0/2] Explicit TSO segment count
Message-ID: <20260824110848.480286c5@kernel.org>
In-Reply-To: <20260824163139.990734-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260824163139.990734-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 18:31:37 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> Subject: [PATCH v8 net-next 0/2] Explicit TSO segment count

## Form letter - net-next-closed

net-next pull request for v7.3 has already been merged, and therefore
the net-next tree is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

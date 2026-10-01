Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18F380FEC;
	Thu,  1 Oct 2026 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816410; cv=none; b=QUf2EfoTRAPkV/DuQIhQ7ItOIMCX5mV0+M/0EcuCHYLWWKFZGzyCWPLJ+WZVkEdMqEjdNmmHkJ2sHDn1MF+7Tlcc4k7cz9rs1fZbwtq27iC2sq1MBZClXSg88QAMpTKQnz2crYX9WHsB0jeHkCsXRuLS12/lprtvELNC9j/7j/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816410; c=relaxed/simple;
	bh=QjssFUNjMN3KBzmvOcgGs5iYtKlGXG4is9xQhbkfNKc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kddm7vXsLf1Dac/1fYIzXUbluOznbWsYQnzKMekEpUTMPxeFRM8h2z21RXvX5oj5B23C+1QMtwMDv5dwWJnATNw3mFeRrKQVzK8Wmcg50JLZgMvZcTijG/Xd3TkZjKb2qvcx+K5npStQdocrDfYfu1rOIsqZRSS+5XqewARqYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRjCZHaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRjCZHaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28D21F00898;
	Thu,  1 Oct 2026 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790816408;
	bh=2CogicdfEkwx200vrji5gm8Gm5bp6TU5jjflpxx3FBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BRjCZHafzgG0wGwUiKYY0UiDDXDnV21PBqKIzjhgoCDqvauYWuOR+uI6UU5PtZ6IA
	 1zSqdAaNziFx8ZBTPJic8jnbcZZdEgbWWzhstrxb4PqBcZ8mgCKxCyNXnlXptrgsem
	 QUiJMmMqKWNhqwM5+luKQdT6Km4HjbvtXqP6zIAfkRiRj5SGqZd8umY4nXF3TbkVOv
	 BpNAbtD1aB0gvmIxJmnArpEgjECCQRxvdxlpDVvV1fkJx+ybX3BLUd6Wd4WDpNC1Q3
	 QOsGDWsemYsQdqFoixQzEhX9gwRKqo+nDFkMN0/nZpzDe53cc6oGNIqLsvLQqCSjLL
	 69T53CZ4Wabfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B42D23AA6A61;
	Thu,  1 Oct 2026 01:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: mvneta: clear XDP pfmemalloc flag between
 frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081640728.2197065.5595924340439650729.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 01:00:07 +0000
References: 
 <20260929-mvneta-xdp-clear-frag-fix-v4-1-1e63b25eeed8@oss.qualcomm.com>
In-Reply-To: 
 <20260929-mvneta-xdp-clear-frag-fix-v4-1-1e63b25eeed8@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, toke@redhat.com, lorenzo@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Sep 2026 15:43:03 +0200 you wrote:
> mvneta_swbm_add_rx_fragment() sets XDP_FLAGS_FRAGS_PF_MEMALLOC on the
> xdp_buff when a fragment page is a pfmemalloc one (page under memory
> pressure). The xdp_buff is reused for the next frame, but only the
> XDP_FLAGS_HAS_FRAGS bit was cleared at frame start, so the pfmemalloc
> bit leaked from one frame into the following ones. mvneta_swbm_build_skb()
> propagates the flag to skb->pfmemalloc through xdp_update_skb_frags_info(),
> so the skb of a subsequent fragmented frame could be wrongly marked as
> pfmemalloc even if none of its pages are under pressure.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: mvneta: clear XDP pfmemalloc flag between frames
    https://git.kernel.org/netdev/net/c/8f1c2a10500a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602419;
	b=5J/FMAANVdu6qvZBxTGFLzcbGPWFP20fiSU595+nd1DNQcr8lr8AG2UIGuHVsZ07L0sQ
	 vy4z8qd1hrp/IceFF8kHlmd9DqO/wtzi1QDkkB1Lnbja//f7ptet6DG54Q7z0TTqZ6RzK
	 xP8XAvUKKjwp0tgPm3B7lduYHRZb5WhueJuTxVgnadEkUpgen+jbLbOvdg5HUcyWxUgdN
	 3P9bfxHR412GmwMtngeDRnqlltTVvCxYopaFZpNkksQuuZ40w//pX9Z5m9jIfEuu9eb0K
	 RzlWgP610YpEeryD0gukEb8OBlk8ZkEuwse5qSCI7nXyC1d1kugv1br4cC9+Hs+vlCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602419;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=DQFBpfIuZAOPErOT1+mfJ2r1j1dUaVfapvVbsc/r20dF73f3yOP6eYogP/mfHqWIuNHt
	 GggtgzHyxUpRSZk3Xn4BLS4ly3j6fz++3mR3WMKI391zpCDer7mOQYd/kQnVl+NZVAcTp
	 UeCfZKCy8tKxUAzGl2IClUreR9eqNsBVbp87hLDQb1X1PGmdWSwnVjCcSMdKrfdaMTg1S
	 bkdN7lPXXoDtGnnrXlBjP8Gfhdn24FKNVVMAn8CT3FC4Se8NfC7Eofqbf53B/5Gf99B4R
	 crXrTqbmuG6XkP6ud7ElRntK29yhr2lKvzUOt8xk0rqkCHoeEY0p2UrLi570DrZFg6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvUJaBs7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CE606A324;
	Mon,  2 Nov 2026 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvUJaBs7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B6C1F000C1;
	Mon,  2 Nov 2026 06:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602418;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fvUJaBs7lfPCACkKBdxWR0Fg5hsNAIRzZ3UcW7g4zZ1cSgwb1CxfWNpRFUDuoToYt
	 P3h9Zrg1QIZktv2LzyayhTIeQJgKtks6pcvNQZskksNaXUFUcHaPsuMcjth+7gcrsO
	 f2b+WncZnOO8YtnbAL7543GfW5X3/8Jvb/UVWgYfKdck2TCyqkS+qip+TbZyDZPhKM
	 l+kFJxCE+NqSq304jpvmOe0krHl7RHez4xF4spAFugoLCGo0N8X+e4X1Z5jrLhhrM1
	 MeXCStAre2ja9hBn1ZqFPOcra3eAaS2r0X9VKO4OOUisp2XXDf/E1lnaoKKQeXU4W2
	 afCds6Fcgkzfw==
From: netdev-bot+sinfo@kernel.org
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, bpf@vger.kernel.org
Subject: Re: [PATCH net] ipv6: Check the Home Address option again before its
 address is used
Date: Mon, 02 Nov 2026 06:53:37 +0000
Message-ID: <179360241747.3286.1195676536832321611@kernel.org>
In-Reply-To: <20261102064922.2636027-1-alexei.starovoitov@gmail.com>
References: <20261102064922.2636027-1-alexei.starovoitov@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609343;
	b=eE53xA2KQVTydSH9j615qQ4AXy5MXoVffYcK4J/wOOndggIZzXgysh9+1WYkG4SGsgjS
	 guQmyFlQsmqILDw7UFtr3iHRGSsevioFavCGDx9TqEcIlnBGXNN+zYqtve21vQuv7Jl5W
	 qMieqapVj3/YGSoQrccnKIZA1MJXlz5gLNEA3iYS2t5GzArfH79niKA0A9+TpLn3b9Crs
	 f9RVKn7bdAuaOCceT6YFHnuTA0mLzB1KWb1rPsdQUTKi2QSQ5mTrfy8GxYoAgsWRfQr8V
	 9GdEJ/OWdQ4K3yDyqHjDHNPAPHr4s0eoi79xbNSQQT8Oos8ejjoWtfn34yrEdmi/Drw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609343;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=34x8k3BILyFQXfa+Cj9ZDh203xOni6Me7ls2zsZs/7mm+a9F/dTazZLxE8Orim5pWC0E
	 pO8FzgGlbfXXl1gOYHpJVITOKhVBEfj8sQI7NpoPOvnovXiyp7+zKpZb2B28W5CsJ4qcq
	 ARae6ukPt1K5xGu0CPWKYEoku1AfOCoD3LxLPtl0TxcLkGX1XTShpy7UwEz1orC2/gRrJ
	 STPKpwq172cHTkIR6I62YezuzZG/L0wktEBYh7aNezhrblxzCMCtnAU/uUnj3DXUpms1n
	 C95tNTCUaPvjjjXq5qX4fI3Vj92tKIKTKrehdbRvy9RnyvlS8V33t6gR7JHDIMe/wjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMmrJsoa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799B606A31A;
	Wed, 21 Oct 2026 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMmrJsoa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4A81F000C7;
	Wed, 21 Oct 2026 19:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792609342;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EMmrJsoaqnV2vXTQv7DZQb3z1iycoCAHYneLgm+sp9ZrRWZboD2qV769ldCX7eOL4
	 XUDm0j+2r6IYWcU87MaHdAmKumT0jidU07X7vzQT3JL8Ki1aeY/WLIVz6KftyDdc54
	 JXe1pzrTKEJ3FVemrXAvq+0laoh9udJhkKesn8jGYZQJvB7MNaSaCgA5WI58P0W+WB
	 jMGyx6WNbKhZlUDqpFXDweWL5T9QOozPjRvYhHv7fbbmM1NTq//KU4u4cfy74rsxuS
	 20mLZpYKDZQDh4G0WyOYUuu/FenD23Fb3YgNySlSebYNB6MtpOdLWi15y8LEcZwHyF
	 4rQ3vuJVl2Nhg==
From: netdev-bot+sinfo@kernel.org
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, edumazet@kernel.org,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, jonathon.reinhart@gmail.com,
 vega@nebusec.ai
Subject: 
 Re: [PATCH net 0/1] tcp: release congestion control reference on rejection
Date: Wed, 21 Oct 2026 19:02:21 +0000
Message-ID: <179260934140.3290.12382990945643523195@kernel.org>
In-Reply-To: <cover.1792607608.git.zhilinz@nebusec.ai>
References: <cover.1792607608.git.zhilinz@nebusec.ai>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

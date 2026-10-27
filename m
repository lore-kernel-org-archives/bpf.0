Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793076697;
	b=Kz50rVJi+FYJaPaAyWChL2pvdzmI5BPzBcojkZVgoRvRoq91MjIa+iUoIlD9g7f/m7UP
	 DMS1SiKuJL5PRjrpIuUrdM2Fs8UoXw3O3xdCJEr4BnLbCMwle7zdzMvDiAhvLHSbmXtyG
	 cB2dHRELjFAVaAY+eFcUxFhyCoAhuXTxcW06M+K5tcCQ/I2FzoB8j1+Nqmwb0H/29szIH
	 eUBV88A/9LFu3cLvHoqEm4Y6lya0F7j9d50Ic1R9Xxl35mt2ixiD17uGoD+WXnaY/jTFq
	 vg3mRAo8fPx6pLjDyG2nkSzwjyQ03QNYA8+suheidQ6YKCiv4gtVKwAokb0vrKNjvFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793076697;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=oz+TjJFgYpl886F3MasxIw2TQ5vlVle6GHx3GPHh5fNesjBtzIvdHRl7hL7jJdRVVcZ4
	 RbYEOjXdhPVKF7kfcWPA/lArvBe/akXWrA5G+iHy0Qe7JzwLxNXd8/IwC34XPgk/yZgn4
	 FKSQaWRrxL1v80ETTT2tLogqf7z5gYX828kpKEo0zCJqbLiWEMOyMPCkqgpmEAPZi3xP0
	 JMBNIA60ltFyz0Dt0KQ4yvXRa+8LWqWQjTc2B9vHUek+6vGcRQLAlpbVDLHaId/9zAMy3
	 XLSmxsUlDUnnoDaTbEx1vEdpj9QSAbZImwXBIJ2NV9RdhVu/P97fBisdjinOc+Ehy6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gb2Fojc7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F950606A31B;
	Tue, 27 Oct 2026 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gb2Fojc7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA181F01825;
	Tue, 27 Oct 2026 04:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793076697;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gb2Fojc7fwfLI7dkiic+0QLYi7rNpHnOlRGICmV+UBDPI6QHY2ASym8zS/ey1IjyP
	 KC5XMLhd2edQIar2oflKF5RSZqw0J/8VzTwrEYU0GbQ6dInYtoeb+DIiH03ktx0DBR
	 TNEc/6RFJP8xrq7seQNV+tJaeCu64RBVYKH+Cg+BAZfUwcLy9LqglaH1mTZ/pX9VnO
	 7rbx4/fJCXthq4jMktPmkguA+U0ZnE1qVFgOVKA9KqDQokrLriczS+lU66AqLt8boe
	 DxdewLthUlE9MbjeQ4XtCmYmlP2h278HIAPjDuyynKsMs4eCZOwdecFvu7phLVrZ3t
	 mdqhqJ1h7RmLg==
From: netdev-bot+sinfo@kernel.org
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: edumazet@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, jonathon.reinhart@gmail.com,
 vega@nebusec.ai
Subject: 
 Re: [PATCH net v2 1/1] tcp: check congestion control restriction first
Date: Tue, 27 Oct 2026 04:51:36 +0000
Message-ID: <179307669618.3327.10896657466319560651@kernel.org>
In-Reply-To: 
 <71c142b2d45af6a2fe7fc6cd4a5ca52c53afbe23.1793075984.git.zhilinz@nebusec.ai>
References: 
 <71c142b2d45af6a2fe7fc6cd4a5ca52c53afbe23.1793075984.git.zhilinz@nebusec.ai>
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

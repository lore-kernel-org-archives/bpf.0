Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334228;
	b=IQze3yh9L+eNcX2sufbsUDV9mzRJo6q1vlUoHckVnn3Kk+dEBhAJR0TOWLb85GQ3CWDe
	 KUXWxrwxLfD29Cflu+p+K+R5h/o/DDXDL8Gh4pt9r4zzr1zwCOGddF5vlxgZLP15MzGvt
	 whpMQoCl4uY+OYvGLIEuwtKN6t9MZDDR1yGvMRLv2+G3uAiVVHSWLZuJPg8v7zXOquReo
	 or4ZD4Vsrf2WhjLdV4I/vy0kwpf6kbwLuxLad5tLugKXOA6WeKLqQhrEIhAKaXa5fqfGx
	 nNPzpf9T7C4uZdGBPOk/RZRgKNnQ44ucBr9tWtNxNOpihhZ+mNw8Inxno+3riG49/UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334228;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=yBXktEuMgBb/Q5yA2sRm7obGrkp94VCZBAcRKbx+2oaLc9/Bvvldt+nIJbQW5luo9BYp
	 sYBPNoM9caxJCn/QMY1M0tWpKkqQtVUt/IaCl2PPyZyAfFdGI7s9G2+HMOSvjBcwLtfSp
	 q1medAjwkPBfDy5ZDo3ZHG/0QfcYUdw62tH+0UNBOfSAlC6oYEo7xopJ6n24AvW2JhY/4
	 cg61bVY5exwLb6dvPXAitScbSPfoWkuNiVHG3OtYTReTwih/GfETEzgH446a7gj3GeWRS
	 Lh2VPDkMekVNmcwX4dnve3aacytXoNXbIYwr8zkevdDJmGq35tRWwx3KvHYcp+emc1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKCk77vb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87317606A31F;
	Fri, 30 Oct 2026 04:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKCk77vb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A891F00A02;
	Fri, 30 Oct 2026 04:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793334228;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YKCk77vbEnCDm/3hafk42FB+ujcwoH4CAiN6O+ZZId3m5CtJJl6hD0STmsKSZKnq0
	 Dxo1yTP8zENlm9e7FyQG632GIZ8qOWMqPWhbywjDPlKfaB7M9S1Ksr8bokq5dv1aKk
	 Nk0cM3e4/DkCtHjV8aIoL1KiMVCxb5aRKaDR/FZ1PGD+upRDdv5FrZerStb1Kwo5Pt
	 rle4gBc5JG5z0S/NHY0Qew4i4Gc7hXYO4+V9Td5XPQXLgj5H2Echpt38Gur6bHsLIc
	 PQwWtY5sno5MQGiteyEfNYUWrx5KP3sdHFIPIqbIqB6QF0EMsczMqrnxD2da3Mk2/C
	 h/XFDxy/YalDQ==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com
Subject: Re: [PATCH] net: skmsg: fix copy cursor when coalescing clones
Date: Fri, 30 Oct 2026 04:23:47 +0000
Message-ID: <179333422728.3327.13825386669493302144@kernel.org>
In-Reply-To: <20261030042138.73739-1-kylebot@openai.com>
References: <20261030042138.73739-1-kylebot@openai.com>
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

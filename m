Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016340;
	b=y6n+tG4Y6KhwoACB/MZtiUI5r59gNWK3laaMyNurcVOjww66qOzb3ODbwTomuIuA8zqR
	 Ra7C6BX8qUyDwlDvvXcpQqFSW/ACbETn04ZHSCtY6Nvn0jVB1QJBL3Dfg0Ku8G0CbA4pz
	 WVG812mVNCSmGC7N1tePYCZmlSzBzhQaUY15jBczxqBLhHjfpDEaUoJHsmvnhz9oybQys
	 UKN+a7aW1NPktTLgbTMG8SYvKOCxV7o+WNztR0lDoJ7kNfvpRZr1KijYnzlQJ9PIk08q2
	 D5bXAmIYpgHfcDAGgZsiTDqTjzwmOnp3xPyOaF8CbterbQHuIIr5xl0inaEON5UOg9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016340;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=J9xJH7UOdNVzaEw2yx4r3SFmAMdQvVI3ijnC4w0pbK2dhhGyTZjLfeslh3rKxf6HS9AF
	 CuAvPXXqYhsJjfesplEON/6spLVdnW6xY4b3JOZUquUyn7BXzH2Y3gz0MbSxLka3clRBl
	 PUumw2DjkjRtXp25upYQNp42qcxzf1pNhESgAa2xpEpg60ExVGjuDBo8agZlzsD5izExn
	 1SfyxGaoMQANu5ueGtzLY0ADN20kBptWl9ORwVdtDmi8pd6hM+K1PKRlwmZw9UXcgJxHA
	 5foOw1mu2WtIHMLHbD/SPv2fuVbm4+Z6npQCoentOZ913yqkXPkFvvqnEXvCHy5FIqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LD3szM85;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BFB60A2604;
	Wed, 18 Nov 2026 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LD3szM85
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6091F000C5;
	Wed, 18 Nov 2026 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795016340;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LD3szM855ntbv269Tk8KAQrNfmItImQFPawBmU/XdCMEoCboFX9AKjw4Y69NASp4M
	 JDizky2kZZVjoi9MJZfFmieVVGAC0UJdgwcdJqSK1qs16C6rMAJTXX+ifSHfqXWPbX
	 T686ovGlajfTBe9IbcUXvKqknWirP2keb1W0KdnyEZWsk+rtvA9cSCm0YmUjhP0KoT
	 vZXVF2x5LWVUR7weMs0gqefO1P3g06KxLOrTiaE6Kk5SP8gdn26jPzpDAEucM2+qk0
	 8AEYVM/xbdoJdL58yESAErzIMBjVPCcgKGGNMXVzqZfll7Oc1zvN+yeF+Sh428mVLH
	 PUlSSFvq+EOeg==
From: netdev-bot+sinfo@kernel.org
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, edumazet@kernel.org,
 kuniyu@google.com, pabeni@redhat.com, willemb@google.com, davem@davemloft.net,
 kuba@kernel.org, horms@kernel.org
Subject: 
 Re: [PATCH v2] net: sock_reuseport: check program type on the migration path
Date: Wed, 18 Nov 2026 15:38:59 +0000
Message-ID: <179501633912.3291.17401318621323558939@kernel.org>
In-Reply-To: <20261118153541.172499-1-shlomojune6@gmail.com>
References: <20261118153541.172499-1-shlomojune6@gmail.com>
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
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

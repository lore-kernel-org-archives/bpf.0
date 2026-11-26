Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711383;
	b=q+JXt9T8WpKsTAXoPb0Kis467J26mMFimB19//wpxO9jEg0WRsytrO1CnAlfKxV3o2SH
	 HiWUoKAGDLFZYPw1ugzqAHj2fyaZ8+8poG0vfw3LhzAs3GTEN8J7P029vDfGzWXCFAsOS
	 pAhvipR4x8R4czHEqYmnIX4mkcd7cLhrSFracWkXD6EDPPctJb6Xr2LQTvFLM7Mso7bOh
	 aE95zdzeLDdAbZ+4ckSo64bHzIoPyVIJcD3izWWE2dKhzTEWvRXJvYa7wtxwUpZHFreM4
	 ZnB/jh5AGfjeu2A+FX4j/sE3kPohol+Q/n3ClE4g7Ga17G4WQCYn+OU6yHlM6EdYpCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711383;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=bq80SXzk1kPVIZ+obMhD0LGS05kMINy6henvGqcIMeJSCh1C9s5vNYH63ef+EQn6p/sq
	 iGt1gekLyxm5cYQ4qBzAEdKkdz1gySGfWP4zg0OKocd4YciVE6mo9IvEpnjvcNAe/4Ym/
	 FHaD9pR57UWdHqShag0oAF1l722j+mpN6VPa0JrVIABaaBf9yHboJ/8tw4E8wN3JHZeH2
	 Tx2OFl8Wev3EspVbuZjTbX1nll9BHJEh4GN2zZ2bqqVtsnugj9Fs5jXjmj8of/nq2GrLP
	 8kotsDG0OIgOCGFOvyyvKp7tMf/hG5QQeRV4QO0NCBhmkxJzobBBASy7mlH67mn/fhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8rXnZOs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86713606A321;
	Thu, 26 Nov 2026 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8rXnZOs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD111F000C0;
	Thu, 26 Nov 2026 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711383;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X8rXnZOs5Sy5YEpAvm8S1MoWA0TrTlbInhXAlUBY07nPnYZIVk6bjWfnmux+ATWpI
	 p82gXHy0WXDyo6lEa66jkHMChVaa9S5JGlP/6DcCqgfj9Lwj6lhHj7Z4ppwC7fTGGu
	 ngulBlmGmKUrSoXm/mC5j5uJdlQgtDrNkp+9Myspq5BSBR7W92RotT6vnmsKPPh5YF
	 htsrpADrIVdzREpxP7D1aOxqHTAN2e8vToQaFJFWFW8BR78GDiijw9mBS4C0ktyRjE
	 +e9PGSK9ySSK1Afq+lSJShQXxgj9xiGNFT490BBqn93rJrjtju40EjpoauP+JOdKtN
	 8dAz0kDDwI3zw==
From: netdev-bot+sinfo@kernel.org
To: mdshahid03@gmail.com
Cc: netdev@vger.kernel.org, edumazet@kernel.org, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 willemb@google.com
Subject: Re: [PATCH net v2] tcp: fix division by zero in tcp_cong_avoid_ai()
Date: Thu, 26 Nov 2026 16:43:02 +0000
Message-ID: <179571138225.3294.2517991084445980874@kernel.org>
In-Reply-To: <20261126164150.8838-1-mdshahid03@gmail.com>
References: <20261126164150.8838-1-mdshahid03@gmail.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

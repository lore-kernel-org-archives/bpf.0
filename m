Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792911297;
	b=L/uyj+s0TlvpMqqOvBAuzXayDTtUyxkX5NqsxS9ZqUU2zl+JWTdfSqcXkdn/7FfO4ucb
	 33rfvi1d5tL1kV3E6C6bYlaBPRijNrFJp55+LKW0/fAfsZEu7nlHkfbziSCjqGd6R/YnO
	 3yyXu4jzzQUF1aEe4lyDRcUIS8NgNmy4jcbHz4O2mYyBpjBkxyMs04958dE/xgGylj/x9
	 TTfejaYJmFWcdZuv3gfJ6H+cMuxN/+44YihsZLdmMPTy18Jn2Dhqazeh/LaR6sejskixo
	 oQk1Eii6V5eoeDmftJfgocw7vRgYvvNzBiUh8ahIPJ0BOCNO5IkMx6KK94Y0BxZS8RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792911297;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=jvKSmq1E+niMC4qsGngKABoNCliNmvrzWx6QPea/M2eaN1QjsO+6UE9qie5cSuKQ6iPV
	 Fguqq5O08x0+5do/rULipwG+YOc7gheqlFrPtXawH07ccUEZiJUM+TfGy3b4TcKOijeqd
	 ARFEbKGZYWhZPM7TO3yBKKx4+K3caRkJckNsSQCpjGw7T45iaaDYOy0lM6zezuk0NwJa6
	 NbhIpMcxdkAFpmNIPqjuhrpIDIJQc8+VdbB9Kyr+wNl1xC2GY41sx0OPUInDMgHUIQzN9
	 8C+MN9u09OaCwxZMhaB+NioyHHh2iFbteY1vbYnPzhtoUyc7YOE/FbBejK1J9uXKEbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUuObwtx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69270606A31A;
	Sun, 25 Oct 2026 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUuObwtx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC381F01825;
	Sun, 25 Oct 2026 06:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792911297;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eUuObwtxlCS5ixSyxR/x30C7Nq5o4ZSft39jpn9B6wt6S21EsmPwPqoZZpk0ftxSR
	 vH3dXWkRzP08YTm/2ZBS/VXU+RcJBjYVV3ExXw4AarQJ2FN4gAhrsikGBTiKF0ajpX
	 gMe9eW9gPMv68NkempL4taQIZdhI10ynO0Dmt5CUoD3ry6Bn3FKMvc0dF1N79zC+Oq
	 dznpag+W7uzKpEM+h6z4rKmSgGAgh7VPz6du/9qarE9BiE/aERNzHXdUdZwJSroQIu
	 3yVtomi9E5QS2x4B1SYGobZ2JtkAjwATAKlPjx622L5SWSpdWx8Upqb7tW1R8tQzCx
	 a79BtE+4LLpSQ==
From: netdev-bot+sinfo@kernel.org
To: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maciej.fijalkowski@intel.com, vedang.patel@intel.com, jithu.joseph@intel.com,
 andre.guedes@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] igc: track rx frame boundaries independent of skbs
Date: Sun, 25 Oct 2026 06:54:55 +0000
Message-ID: <179291129544.3327.5095110589717245850@kernel.org>
In-Reply-To: <20261025065154.2037149-1-p@1g4.org>
References: <20261025065154.2037149-1-p@1g4.org>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2A4470EB1;
	Mon, 12 Oct 2026 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823256; cv=none; b=pTFWvIP5mV4byb+hMxRKvKzRA7LBAAB4B3mWu7nfmL4ggMIApx5PL/0IZqtyM8SXGOTYNTvwIdWwllkzcKPry/ketpzAUpTcUynDWuyYhcTlp2uTqkg3vEAI9UvjMDXv8NTdmViLZUQtPqUjUgea6xiyoejEy8ktvOo4yedaBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823256; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rti9RdgASqaA+N0TI5XnVK/tfDxljW/xIXyxd3yuSimqOiHtJTJAcoruiXlYWBoeZt598HBoXFgsITRWpCbdbW7AXjxZeX0dyr5gxCv5BAIgxFnByfD10XmZE2K3slCtXwggQIMK0umbsFoC4QkVFdzo7fmHUBFe5Pwif2ZcVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1+WXors; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1+WXors"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525651F0089C;
	Mon, 12 Oct 2026 16:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791823254;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P1+WXorsaaQdv37LdBPSi90JBzVC/uWfv8BkmoXBrT6mF1+GuFVcCBcUvi1kZVboi
	 5D1DuJHXnOMcUf/zHf05TLdoZp2/5XIoflNTDHwNMn6JtcqBlvYfcQrRN5BAuD3qgk
	 keIP1rL7IX3mzrbkgYbTJzsfx9ptOY4ugjguzWgqpUTHe6iKCMcZPBijeVJy7TJ764
	 j9EhuypWJeU/VWTFWHMVepeodPu0bDOi+3Zqmc/zCNFrickBFq/A+qSYDds9gsTxmi
	 5h9tA/njwp2kK+Ehcdthg0B7hqsSRk/YMTgp0hXXAdqU2YEZAXPpdgfWltDKyTTYl+
	 nUUVDNfQlkDkg==
From: netdev-bot+sinfo@kernel.org
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Eric Dumazet <edumazet@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Kicinski <kuba@kernel.org>, Levi Zim <rsworktech@outlook.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] tcp_bpf: propagate error code in tcp_bpf_sendmsg()
Date: Mon, 12 Oct 2026 16:40:53 +0000
Message-ID: <179182325379.2527009.18375770857714239457@kernel.org>
In-Reply-To: <20261012163619.47528-1-dmantipov@yandex.ru>
References: <20261012163619.47528-1-dmantipov@yandex.ru>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
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

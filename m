Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3811FA272;
	Tue,  6 Oct 2026 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308396; cv=none; b=HdwJwkkIULC4ndoZa8xdzL+zhAUvzgVg34xSli9Ql8ta2GzszOu/n3jK/S8RUD8/U6KJ0ZIYHog887APNF/YrbmpB04gmZkYPu3he0hG+QPOksYqRq62IxKQfauG+TUIsqTZEW2Cxgj3icU4cMuYt5L6WGM7VQdxAVwIla2tP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308396; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CKWJV2Y3d/mwFT73TR8E8T/epICAQ1CqpwwMfO6HGJGTZ2JPu+3CHNZ4M59pSFjrSltm1f1b4e10k4RBqMucjrV2zOxSCJ6YBTt+75CBodRRnbHw+WirImROlMIreEwgO31wurwy2M4fIU15jQnBZo3Zl9+7Lon4tP/gJxg+Odo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs6ONi0i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs6ONi0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97701F0089B;
	Tue,  6 Oct 2026 17:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791308394;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fs6ONi0iGUMg1dSot+IBJm/Ni4qjY2Dp14k907srt1r7jHJ9z4cgJGHW8vXqS+K/b
	 DuHC+/4NscMagJ5W2KYkYfz43xQuJlpjoDDbXynUGvKiREBaeM2HjYDknTed6oPVuR
	 Cij6pfi9X7oBfYLzfcNIHuyY09HnpbaoHCtADUd9jN/1A6Mdwce54Ujma6H1dvNFqE
	 jOmkWsuZzcooPMT9nbnBtH+D1ymBIurhT3kN3Du3MD8G+ofJIlWHXWl9plxcitAFuQ
	 6vQkbeH/qlhgHkrYm9wHJtJi4Kdg6cFY7Ebk2woQwJfCRljOuiYLkIBZ1XU48yYs4l
	 r24yPIqlFXlOw==
From: netdev-bot+sinfo@kernel.org
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, toke@redhat.com,
 lorenzo@kernel.org, horms@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
 hawk@kernel.org, kernel-team@cloudflare.com, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 0/2] veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO
 is toggled while down
Date: Tue, 06 Oct 2026 17:39:53 +0000
Message-ID: <179130839329.2231598.14859340679278349582@kernel.org>
In-Reply-To: <20261006173241.65945-1-tianyi@cloudflare.com>
References: <20261006173241.65945-1-tianyi@cloudflare.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

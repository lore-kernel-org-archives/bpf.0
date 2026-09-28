Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87B2C2360;
	Mon, 28 Sep 2026 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580323; cv=none; b=ZOGWVEPNGegubpOcNB654s/oDXkNlYAgIbyN6X855Noyie5p1CVvoSvBopO/agCSNEnYdfyv2qsHBUVWKzIw6e53VdfU0iuiueBcMHqkd+wlNVKuVDmd1IzWz3wEfnJnotjoGOnP4v+gyMQiqmo28NM4q6DP4OzFyfMk/FjAKFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580323; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cd8XZsTmnAcIreCluvFC94y+CEW7afNisd/0SwIUXlkIYn8cXx0pZZTGB3o4G0XoD+OuN5ozS4WxncLvxpUM8GI8QclUpk8cPL7H/w9OWCBnywq0OdsCrpPNBgVDIkZqPZwaqwBP0gEpOj6wdpetKew1oEK/wvLM1nvybR9ndz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzDYzvWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzDYzvWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550DE1F000FF;
	Mon, 28 Sep 2026 07:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790580322;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KzDYzvWkSbJfgveOKipBJw9LXdb1DGXJXQ656zt7CSVN9JBho9jsPjpKA/iqwLpFQ
	 icPyhctrXnrXoCCxmKdiZ1TKbKThYsufVXdnwai+rjwtoM5x/GUglpBmjhfmViR09d
	 YijWKu9SXsLt5rAcrjwgv0GxhZb/9/poROLTSlxk9j0Zn3a+h/mTAxoOVBmNjE0XRv
	 r4adiqZF1ahPHLgQ5Yy7f0PzqVxIeti6DcBx2DEENBMchoigMrG9RobgCQ6TbAQTWy
	 WgPF1swAkI+1Hfv1zu0GYQuerwsA6SMvqEWqmCTIizJY/6IKygoXqir9hnJxEQRxyx
	 CpUGoFgx9ZYtw==
From: netdev-bot+sinfo@kernel.org
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Toke Hoiland-Jorgensen <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: 
 Re: [PATCH net v3] net: mvneta: clear XDP pfmemalloc flag between frames
Date: Mon, 28 Sep 2026 07:25:20 +0000
Message-ID: <179058032080.31693.8972342678184563371@kernel.org>
In-Reply-To: 
 <20260928-mvneta-xdp-clear-frag-fix-v3-1-af4a51499eaf@oss.qualcomm.com>
References: 
 <20260928-mvneta-xdp-clear-frag-fix-v3-1-af4a51499eaf@oss.qualcomm.com>
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

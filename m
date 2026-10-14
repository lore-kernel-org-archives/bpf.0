Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2730D3FD;
	Wed, 14 Oct 2026 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983751; cv=none; b=OxeCn8UJPxHystg+fwfZtVpjVvAy8Y6OeIbvDlFMuin+decS+fdKEWP3/L//4kJYq6Y/BGIhbbgFN6b14uk9utHVSYAOhzvIIfJaabhZDDJpVgn0XCJXvIBh7k0AIfk1N54ESutBgdUbFf9ONvLtfHFtzgtuums54Uon4qIXgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983751; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AFrT7za1plw31Ze42LlDrqAj6/vLdVJg2DReRXhiiaOaRrF6iGZV82uHHjNY2Q00O+gYjkmz9Ph5wjICPCBxE91xyx7nVCI/3h/IyGkRCgZ3+EM2IXVTfMfPje5uDtn19GqeZmDVfAMXH7qZdnKOqb+8wl9zGV4tVxBMNB6iKyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI3Vs5g2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI3Vs5g2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97221F000FF;
	Wed, 14 Oct 2026 13:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791983750;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bI3Vs5g2cTAt0pA+fCkxvmCVcJ3EDcyeVDFZNUshQAfs40TWr5WVp6TMdoYuTmQD+
	 bYHutaEsJpojwyCWp+PNjtFkUC2P9zEOYNX9/WTaa/BOWocm2dQKnyiKLYR4YHTMwO
	 sBiOPFUX7JDGCqlbBgK6vEhKr5Z5z1aKg+/JeckHY+jy9+W6xv8I4P2zG0RjgQjR1o
	 0rWnzSV/9XWsVO56U8Lb0c9VhUeqcJpA+qpcRgYrNMjlx5QrAMcXM3Bxv/fp7P5aBI
	 sKK3rpyaX2EynVotIeXFGrWAog6ETAPoJ+TvfDTN7+UYka02EM0HSwR3gdDMGAPW0R
	 WAof7Spo5NmCQ==
From: netdev-bot+sinfo@kernel.org
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 James Hilliard <james.hilliard1@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>
Subject: 
 Re: [PATCH net-next v7 0/4] net: stmmac: introduce XDP rx multi-buff support
Date: Wed, 14 Oct 2026 13:15:48 +0000
Message-ID: <179198374828.320699.17103999780938670424@kernel.org>
In-Reply-To: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
References: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
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

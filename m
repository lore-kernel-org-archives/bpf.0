Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1B3DA5A9;
	Fri,  9 Oct 2026 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541826; cv=none; b=sUhQLSp/JY9HunkNIrVlwWc0q2QzOHXr+b+VO0lLdcujpwUjh4UtbP0dNmg0sB458LkxOQE4azoWK4NZmFBWDF9qaASVsBXGI/rX5QKhyrFtqpZNoORWkUHAUujvpFYNTHxi911+TM71Yy8CzzLyhQCWvGWw/3zE7XjznDuioNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541826; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBhCpvtS/+SsqYoRBAjOeFs41obHWYQp4eiZ2QzRBtwujnYmyN2gRpeZ4c2yekFJcVO1wz3xqPA8DzbBMff7l4D2tsX6TEM42MWTjxqoiO0K+37Z/mA5XQ2xZIb8Grq/zH4W5eu2snKZupr7OPjvF17MmH4ObvFT/3NdzNuX+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJVRWBF/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJVRWBF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CB71F000FF;
	Fri,  9 Oct 2026 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791541825;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DJVRWBF//LTZ9A+Pw0aZTVccxYUuh3vpa/X0StCzB3z/L0c8lzEzWvgpK9SOoS4k9
	 FrX4U8ErewvwMYftLDk2pdQADpDrB/nfgEUAF4uIB6rXLU44ifNwVIT0tLRRegRJkF
	 rSCqc096EJ1a/iaHcEBrg8mI6PUMn3UnJkUms68jyxfNIgzQb5UkRwd7ebaT1zMOsr
	 xg4iZ3ZAXCkp3IeoWWc3/Rn4uIrLssdjZ08SZE5gTpZFp7RPOAyt1pUB1Bmoaa64bm
	 7yLgyCbBv+DQW9x2FZkwr64VYEuTTHm+AdulHtZQWYiTIORIoNjspoa+OF22aDyI4e
	 4mRmRxuAtyDnA==
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
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 James Hilliard <james.hilliard1@gmail.com>
Subject: 
 Re: [PATCH net-next v5 0/3] net: stmmac: introduce XDP rx multi-buff support
Date: Fri, 09 Oct 2026 10:30:23 +0000
Message-ID: <179154182368.2527009.383686573505818394@kernel.org>
In-Reply-To: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
References: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
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

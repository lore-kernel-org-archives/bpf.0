Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3A3DB632;
	Sun, 18 Oct 2026 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343294; cv=none; b=arEbs9ZucASCl9ylySH6TRhC8tQ+KJj/XXrbepyQKR80kWm6sadfVYu/y0IRUK0hzJ3JrslsuL4GVOpSU7N5LS18TLnnoNPRhyrHXh5DIzNj3Enl+2jrW8Ryw8AA2205km+acvp1YBJ9EWvqAwJbMX0j0yFVeOeCL9nWhI2BnpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343294; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jhWaZfGTo012xKsZr61MMrMuq41pqJzKQVol47JK4WqehCEyLP1FcI8fQiNensl5NI3wyIjWbxRRprb/T81jAOcpiZ+vPZV8q95fnK0KwIUMUeQYlGez/QiZxDCs0YO2qU2TT98e/3ZtKgv7+wjQl1zZcwZlvSxmGUWWot98PsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlbIYCJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlbIYCJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C38D1F000C4;
	Sun, 18 Oct 2026 17:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792343293;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NlbIYCJeSiHmKgJtDxLjfnn2vYxKh8Bw0KVVXzmCjP270pnYmi91kb6mAmLk26GGj
	 W1zyyJnHBmwmyLvMhpPeB4xvRbctFPNBxWvqhcvZ7QlmxMYLwwNlU/if8EJjhTLbip
	 k2MfCZggstZ77jpojfOEs9XYSs+17ExX3QdC33+aT7EkHeDF3KRvxAt+76J5qCUv7h
	 QbIevnGxaZdEff3QM121Sd6+uCyuC9ChHceOxsqYkGKYcIIYCPh0ksqasLW8DBxrua
	 n51O5Ssk8mIvX439sipsoWrXI/getdCWjXxuyUChmRYGJhLRRMxkOc37x93Rd4h/L/
	 nvW0N84Ye2ECg==
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
 Re: [PATCH net-next v8 0/5] net: stmmac: introduce XDP rx multi-buff support
Date: Sun, 18 Oct 2026 17:08:11 +0000
Message-ID: <179234329183.3290.15960565045054355734@kernel.org>
In-Reply-To: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
References: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
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

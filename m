Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A734A7C90;
	Sun,  4 Oct 2026 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791146953; cv=none; b=GoMo6VkMJbkDInbhgDznpNlgu5dUtXJdF6T1fw+Db51L8rO/6JrqMBDzjX/e5v4TZwi/JN+7cYJ9tmcPVkUitJ7ZyEmcCygSn1q+qG0CFFt/XbiBk31wUIL/k8X3xQOPsv0rGUCub+8wxc+2LDl3YXu7sU3fuu+JA2fFvMQITPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791146953; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=in4QHYHKnPFgocRNERAYgnj/cpH69GjjqdPVLglMSnsPw5VDS8xxU4laF9rsFkzvwPuQdK18bGJ7sbeTucuZNLnmqZFEetfAjShHE2Yd8h4A0i8wYi93+L6AfefGTwNWh8rzeg48Rl99XxJc3/fJ26SijiDU4vB1k3So2o4mJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQPFG1eH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQPFG1eH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE661F000FF;
	Sun,  4 Oct 2026 20:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791146952;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bQPFG1eH8MlS1WdA1PL227LgKW3ijDNeLX4a/hFg3A5tIJBs2R4L2pQmbea3oPOZ9
	 uEDR4AFrQIH2K1vLGYWUh9CJMilLz4E6BfOfSRGJBSKzGh0ai4XccVHtFU6p9/ZPmb
	 zkXGKzgGu6nyO1i3CB0N1mEuKvjeK2c3SZ+afifpbsSmpQNl7s0q4Xolxb9ZbixSaK
	 IrCM3I0AbmC79vbvGNwfeli07npEC5loZOsPRkZqR3AiJaGnd5fZ48u+7ZdggW7ZxL
	 bWZZwWBGsoE/EdM5OcyLiL0gcZNQjTdhO7pOrHjhZQZvDWVeZoWg/F6hqXGvZxN28T
	 +ceI17KlLvYSA==
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
 Re: [PATCH net-next v3 0/2] net: stmmac: introduce XDP rx multi-buff support
Date: Sun, 04 Oct 2026 20:49:10 +0000
Message-ID: <179114695065.1402591.17659606391395950626@kernel.org>
In-Reply-To: <20261004-stmmac-rx-mb-v3-0-50fa171af9ec@oss.qualcomm.com>
References: <20261004-stmmac-rx-mb-v3-0-50fa171af9ec@oss.qualcomm.com>
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

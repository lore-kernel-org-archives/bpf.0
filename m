Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F359C3EC832;
	Mon, 12 Oct 2026 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823854; cv=none; b=Jc9iGmMkveFd6dPgTE5wqVhe/748WsO+13L7LI2yAaVpHx6j9jw0QQAEUuFfxJplQY/3l1js2Nc4Y6qWPYTbMtKSZEk4eDQTdEgGWNBIYdEKbnc7jCV8W+B8WK7GUGg38r/OI3nZg6DAZHZzSC2uWfPZTPGEQ8tznTOCuiUmOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823854; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGPAIbwcsD+Pd1tTqvgKeciHUDQPvX1ZKDXcB99p/+npFK78S3ssH1M5rqRoGYkrDnyhKMlPw3+vy67Cpo1hPxpRNFLtFFgJvTJ5u6oy9GBjbaLHRI/ymw7P2gZA/FO3BIgFaaJTBcVYdEV5pQ0G/TalDf2cbUE9gRFGENOuO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ1Ha96I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ1Ha96I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6481F0089B;
	Mon, 12 Oct 2026 16:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791823851;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nQ1Ha96IJ566DWSumPsm1fyyjKEDtuXzozQ1iJe7SbD1KDMygCf4W1woZIHznWIjO
	 mJC54gMuDBlxFQZ+uDbv/XbuDfOoZunVXfPoNQei0A+nRXncJCbaaO4s9dmIK11zp1
	 PxpGrunoEh0Nt4mQ3ENx7K1aYEVjLX5VSw+4KwBPUJfuNW10cY9jZpKUkduSAF5frd
	 9z4zqRI1NWXHUhMlpeEvu9CpS6hX76Cw9ERdb7tg+6vMRwYg/eLPdfgTxcEAD8fkia
	 UZC70MBEnc48sL9wfxZUH7ftANv/qCwOnwdQxhbrIQnNY34XgCdSQq3epqNQnFlzRB
	 wu10JHFkTvT9Q==
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
 James Hilliard <james.hilliard1@gmail.com>
Subject: 
 Re: [PATCH net-next v6 0/4] net: stmmac: introduce XDP rx multi-buff support
Date: Mon, 12 Oct 2026 16:50:50 +0000
Message-ID: <179182385023.2527009.17648648661045341604@kernel.org>
In-Reply-To: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
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

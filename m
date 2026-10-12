Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136514A0923;
	Mon, 12 Oct 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819050; cv=none; b=smyz5DeeMPetOodv/0deeLCAjOdDGIKfCx55RaYz/UPqV4EFxfmUkH3Hl2WJ3Aes2p8cIf74h4YO70fdrCPy1y8EHAnLjzMQ7PLrbUecYBdKV7lGLdFORVnJADgCfNInrfHpx8o/rHSKnRq0wVH0z7wLVkkDVEI1qkvhG5aBvL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819050; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pYf74UyxkKl2ZTahWjpGuDaRNJZbh2QcOmeKfWXTxUi9dXOFNtafq8tAdDbOVYg+gjFS7SUa2fF1K5nONSO+UIaK7N16p2CUc3DBJ9fm8wRlyo9N4kRhyKnMp8xztujicj0loZ24aZZweVGxm+Q6J62RnZ7byGrKgDaAYR14PCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKkW2znF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKkW2znF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41501F0089C;
	Mon, 12 Oct 2026 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819048;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hKkW2znF0TQvi5ugzZKk3qwCJSKhgDn4ZbnNdIwbIibdCq/pKY99M/ZLYeb8txmQM
	 GNGFiFMtmBC43gCUqrptLkqvs5u3CyTnRk5huMQq7q0iP9e6oLxiCyrxpdNqtTE1WD
	 PQMXUU6UP3Iv54/gGqCM22HbgQ9Bm4Pxd90ix+6wRvtJuXCBzDEGt7P/5dlRtxvUfJ
	 YNEIAPB4bcpNdgVP4Mj5o7YsVadjXVyGY7yrjSl5ifvumoCaFWJKX+vT0ZIFnbmfMJ
	 k/7H6CzeFz8HxCfvW/NtEtwNjwphmiYvsfHq+/MYs+tNV5h8ViAnxnG/x2mz6z1US1
	 Hl6itQDYej2rw==
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
 Stanislav Fomichev <sdf@fomichev.me>,
 Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] stmmac: some XDP fixes in XDP_TX path
Date: Mon, 12 Oct 2026 15:30:47 +0000
Message-ID: <179181904740.2527009.16307700795539761723@kernel.org>
In-Reply-To: 
 <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
References: 
 <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
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

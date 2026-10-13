Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E085427F3;
	Tue, 13 Oct 2026 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924002; cv=none; b=CcT0rjG9vgowEkY+kOXz1tGex3glcY0rPTUjkYrmFHdf6E61Ijembxc2QyhGC/jgWo5GXNIJn5TDYdweYnY8BL+b+wbVf+Wu3jTN6b1jnTbqzim0Tcs9eTI8IjDkttAG2GI4zyHwDIgffNWbUsM/wmb0Asp3TawFasUEz8z0LTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924002; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LSBSvzziozpD4WTE2nNzsawUB+jqsx49QdrRhCViEEdsd9t0tA257R6KS6QWAXWPGR3Y9paVvQ67kEOd6qiSEBaStXISiMRRpiC7hs7XjKj7wdqw7AlFOzDF/2ZQC+j+mN7HPNWTzUarq3hxTa9iB07on5VwNWCE0xzL6374+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEsHE9Ul; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEsHE9Ul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C421F000FF;
	Tue, 13 Oct 2026 20:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791924001;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fEsHE9UlJiPlgGv9Engklk6RpJzvQTOr4OzD5TzGvSLuJVS/IRRnBQNx/fjrMRaaE
	 KIHuzgnrrTESZJxlGkVyIDS4AsRpFL+eSOCFW6npGwJ4yGzm+li/rpSUY4oA+pOr9K
	 LD71SbrXfhs2SCKGFDPf5qEl1n5vu0i0ykc7i+P2dDL2IANYhwHjErp2X4HEyuXpOe
	 QeL0Bw+qcoEAEjwpLLOY4hUEieJWpjzkOJz2u8oOL464++sMkPMGqQwbPW4z4Gn1zC
	 fdbLk4uqEaAi29loB63nKJDLPGwxBfEmspoYP+SK/O8BW52Qtu+zy/okpN1ph4+RyT
	 jKTm0X/PDas9A==
From: netdev-bot+sinfo@kernel.org
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: avoid duplicate XSK TX completions
Date: Tue, 13 Oct 2026 20:40:00 +0000
Message-ID: <179192400014.160550.9046457038671470723@kernel.org>
In-Reply-To: 
 <20261013-submit-stmmac-xsk-tx-completion-v1-v1-1-f21b9d098e62@gmail.com>
References: 
 <20261013-submit-stmmac-xsk-tx-completion-v1-v1-1-f21b9d098e62@gmail.com>
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

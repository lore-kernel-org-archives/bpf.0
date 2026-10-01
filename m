Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C67436B939;
	Thu,  1 Oct 2026 04:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790828352; cv=none; b=TlEIMV5/bxa/DTzI9fJKvikmiznl+15BfzovWhiKRYD5IBupetUoQaQpOrACrKb3GZRXXl1adghH5qrbNYhC5wvXR2/Fbe1oDzesrbnp+ouIprXSVm3iSThloMlx8jVY7NAQsiQyDb9ZZ6gDAtiZSshRhewTOEjdD5wE1NgCklo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790828352; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NBlWr3fb5mUaYislaRHnRPvWmHof7dRcRyIkYvC2vW9MmF5R3P3Oq6OGSssmfGl2GnqueXaBbzpKC+4iXFpBK87ZXKlfIhX7/VVv0uYF4h1U1mAO/LsbRvMRkUiIPhRkUEa2iaMxPNThwIKJnXmsKYceqbbtDAbA1Xgk9Xy8yNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5WY8oxF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5WY8oxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4291F000FF;
	Thu,  1 Oct 2026 04:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790828350;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U5WY8oxFU+kgU+M9TbzFPgVIxNdS2RiMNjxWlzHpx5wp9JuRYVFNlE43Stt+/R5P4
	 8qkYt4LOVDwMIE47dQfLYKT78I0aETx5meS/J1AuT0pbGSqWVUi30q3MoOVeI1fd2S
	 liXiWqaiMALLCElTs73KQ/fOquE6R8Q/57YsTMNHccGcH9HARnIXYB+ZX+mzsOTaeQ
	 sX0PmYv+09s3fOt6Gph+FRn7XgCf2994xYdd3z/EwEeP6HzxP+UeGTJcIDlgAHd3iu
	 DXfWCa1nVv6LiZ+fcnTG7VDBsAkG1MSVhvIDxfFU1wF0/7yR6l0MaOlGgfdSIZT0jw
	 mjq9Fo9B/4Alg==
From: netdev-bot+sinfo@kernel.org
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Serge Semin <fancer.lancer@gmail.com>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Richard Cochran <richardcochran@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Rayagond Kokatanur <rayagond@vayavyalabs.com>
Subject: Re: [PATCH net-next v4 0/4] net: stmmac: preserve and restore the
 installed EST schedule
Date: Thu, 01 Oct 2026 04:19:08 +0000
Message-ID: <179082834895.31693.4009727999698761506@kernel.org>
In-Reply-To: 
 <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
References: 
 <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
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

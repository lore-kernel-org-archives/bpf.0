Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618421;
	b=ehTPHEXW1+1MkotExpEtFl+Azcok2q0MaF+Ksh7x844da5FBT+LEg6nIMsAhxwwcc1W0
	 2yovO6zpGgBUi8E9Roe7/d2O2TqfHf8jwPdnJ73QBGtVDnUtBFGqdNugxSvqBn3OFSKVQ
	 uDfpIpXupANXZY79jNeFhWkLNy9IyWi+GIIKggb5Rt14e0toOSbpVF4bKMTFUsZE0nOYz
	 9G4HClCOYIu/kZZUm1q98vGjYfNkY7AN7bpZyUme+I7ioSO+bol+tt/0Sxzb0kiLAY95M
	 1sHTOUkvj3483bLDKZwXIIkL4bCe0EuFrjZfnanlKyTpPUcrrhSvmX7ABoqNnZ6JNZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	b=wbk/Ioeq9qggqcq3kuUNiG4votShZ28W2Jpnu7KhQYym+LYVdiLB74v7XR1zNyT2MqP0
	 REKc/FZK8q70CVmbZU7ztfKpogxJmJFFkESLLzAhD83GxdsRdTbDXybPUNYnd77BmH7TO
	 LYeeyoNwKTczKxqV4uFnCSa5oyIht6IYl5AGA6/LKpSHqJ53BDSL+z6eB90EhgC2KYLpL
	 s7eiH3DM6Elxvk0fwqHgzlpRtVAUlKuuDxPgOGWJZNGAj6Px44dv9af+3FsJ8HP1kBd+L
	 kReENeZbqrmoNuGh6zlcF44li3UjlFq38e/NiRmMCVLL0SHtnjjmjnJt/GOJ5iqIgTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObxxMsXT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58ED606A321;
	Wed, 25 Nov 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObxxMsXT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDC11F000D1;
	Wed, 25 Nov 2026 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795618421;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ObxxMsXTHaoaFPQhWWEGfwnxogsmLHZtVXKBYFNP22toPMnIbQuqA53EnRDOCjnkN
	 SLXhNDLmz7jNDtxCy85uwFN+oPhfph01qr3uqvrM3tCtfzo9rJntomLnx8g4syN9TA
	 3Ay0KJDKcYK5Cda8DQAJLwpeDOpEWJ8VQFxuLzY0TmnsGHpA1p2kbyJLf7ToGalnVc
	 gn7f+O8ZjtdDqFkLM9nW4Pf8CiZikgIeWBG5N2CwNUEyRI44b/bElD7DOP2euqNoyW
	 JFsQqQzFYo7P5vbOFcRrpPB4tZQ5GhoUWgrN6jpuYOSrEkhiC+0f5BoqNhz49auDmh
	 ce2dgweQR6e/g==
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
 Ong Boon Leong <boon.leong.ong@intel.com>, Simon Horman <horms@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Matthew Gerlach <matthew.gerlach@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 Peilin He <he.peilin@zte.com.cn>, Nicolai Buchwitz <nb@tipi-net.de>
Subject: 
 Re: [PATCH net-next v13 0/5] net: stmmac: introduce XDP rx multi-buff support
Date: Wed, 25 Nov 2026 14:53:39 +0000
Message-ID: <179561841924.3294.5101937008242312303@kernel.org>
In-Reply-To: <20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5@oss.qualcomm.com>
References: <20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5@oss.qualcomm.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743141;
	b=xhTTECJ2ic1KnXv8F5qCyP0HBJ0XBz2bqw1FQKxUE6SV3E6mMtvbS1PM/PtzaYF4z5R3
	 TXHqw4PGnuWVMqZJiFDnfE0nAHEx3i8r2dSNX0h8zqJZNol5mAQM1EsCDAfoY4kjDcHBP
	 iP5WUPfWdihoxeihDBjlfoR1YfaFGRMN1yB/S9fTFokTQhANCfn0fAUqx6LGkFYUJSdzF
	 e7nxZuwYSyBXqpQ1bFFoYfY1EhaRQeeYbRRRUR9TPsW0cUvpRSwViSE1844ObBMglY2C8
	 j6sc/7wGVgBFXirokp6dYYjxBWWAhxMVMz9iGRTi+C4DzXPAT9e/SQdmQc3BlzMpJmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743141;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=yH11tId+atonAqsLHWwxbrQ07NYh8JcXmyv8DQ6q7xO4RBH/4DIzUVZ4l7WCmbSUOKb/
	 a+yNflWThES4b1ur+TONVNQW7a0N8gYw1kJoDhCawgnRnWUU8ePs7G2Z4BUv+QbSbg9gF
	 r5NzGZzQU1DVNx+v4Mk2PjxL1laXJUfmIj73SoZGqZs55RCmmOjDcKXPzqYqwRByDL9nD
	 TBDuYGgp2YMSSCIEa+ENSjnSP1O7S3BNorqG93cLRURuYFLXSDcq1sIEwxOvhRGfLHvYZ
	 facjNxzKc+ifpO5vGdDIXv/uG272hMdDf8kPj/33Ux1wv43QlMtnSXvQeT74zTTrS6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZlK6vdx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266E606A31A;
	Fri, 23 Oct 2026 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZlK6vdx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333081F01825;
	Fri, 23 Oct 2026 08:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743140;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WZlK6vdx8A1HfliNHee57h1C3Bca4ULGvVKHCPI8fFmOA+Dh7p+5En9JAsHEJ/gvK
	 8xs3aS3WCECle14NJ1fVPJ74KSF0ACwidMpsacpIn8gTSkTIxUxSEMXcg8sLrgEHXR
	 iU94ZYK2AaaNaL7Jz3NqZ8ncjJdf0VAuzCCgctCwL9OdI7w8lOVM/NOJyaRAw8QM/W
	 o+Payx1PgxzoRyHry081qIZsaLUTBQSncmzg7SFIeRwQJpL6YIrix3Mc0jIEytXf7K
	 vFEbJQ+Sq6EGIFvD8JU2QKFYw70gHRe3v/fXg6oNs6uZPdw+w5qS6QtkViVvEhMl53
	 wKG+wB5RIimlA==
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
 Ong Boon Leong <boon.leong.ong@intel.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 James Hilliard <james.hilliard1@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net 0/6] net: stmmac: XDP path fixes
Date: Fri, 23 Oct 2026 08:12:18 +0000
Message-ID: <179274313871.3327.10475535220969393247@kernel.org>
In-Reply-To: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
References: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
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

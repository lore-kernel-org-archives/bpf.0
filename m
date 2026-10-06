Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4093DD847;
	Tue,  6 Oct 2026 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281131; cv=none; b=b2PBiKdtMglaWQWP/cYc0Ejsc+2n8PeunaPTsII3emt0WrlVWB8XeIHvibYeBgjBqsJr6t+dFcjAJWh2ckookPepceaNhu36ztNqGxbX2RiDKDeCXDG+CL+jBBVKJrAmV3YCVIyTZeoSN1qR+5M080jOOJfUbxB/WpETKrYDWzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281131; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oZ95B8f2apsrtfy5u3jtbJcisZ7kTsXlwkMqneC9MGJ92O6/hTVXeALEir7XmriaJvl+aZoe9QHbDZhfP/Jl+6LhwBuUHy+DeqQ6GI54trZsrL+iKokknSwn+DnsXvToGLvYBEWp8A5qztCM/Qz+IXYHbyVlz0iKYg2a1qMw1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c56DuBcZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c56DuBcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BB91F000FF;
	Tue,  6 Oct 2026 10:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791281130;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c56DuBcZgAV4WH5REJBc5z2aOk3I31dn71zLwT0yLPkTYcNrM7NigXV4hajNci48q
	 me2Xfa3ey9M0lTttQrqo8Iy+nW2u4l/Vm9ETvb3fMKe1aesk+WbRiDXCZCqXmEmFc2
	 S5rZDpZpWh/KU2GIgMkK1dwna/FKf10V2iPrRPsi3Kw0Du0n0AcuWWDuijkXp/ZN0V
	 uubCnozaj0SApyNfrLW4sUPc+cjolx1V2iJBBc2soemjsxEM6F6EomZ6DgMwNfllKi
	 DEtaKhIIqK7JTpUJWlgYrN68HcgzGu2qeu4J20aNGh/3/xRR54lpfdxW3KkP/qE7qb
	 dnJCXAMUvVpGg==
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
 Re: [PATCH net-next v4 0/2] net: stmmac: introduce XDP rx multi-buff support
Date: Tue, 06 Oct 2026 10:05:28 +0000
Message-ID: <179128112868.2231598.3214023601488420681@kernel.org>
In-Reply-To: <20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com>
References: <20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com>
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

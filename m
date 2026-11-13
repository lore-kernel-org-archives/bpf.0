Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579100;
	b=UN1ZnMYfwzmXDtt0sadCCZ8lSPLyMdZLEIXtw2pWo4ORUj/frQ709S+EDhddmMgfEjQZ
	 7Etr7v/LQ43oL2ObTi75f4hES1nUbChypM3EwWQW6YTkp+roTlxSfwWLeUnjOg7X80Cpe
	 bsXossCX5WfjeHG7Vp+0FYL3yBVucd0b7gzODVU3u9e/qd1tJb5fI63Yj6gzNJ7gsdW2A
	 Ukzp/xuNtEo6EC6g/0FZetd3FmLLvmg1Ost56sP/chNlXv2lQBEySUeY6JLHi0N9npl6g
	 hUs4LSY+ZuJVxPN+BfObVrOArbLsyzQX09sEbGh7M4dp9MKQ2X5na/jd62DiyAZVeSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579100;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	b=naIjyHT5mpzxopBqTICWbBL+KOrTCQra4F82s8FAxEkuffm33SQmi1dQynWhqksLGPNS
	 1QoJPiq2e4dptMwWxaQS6WxwIBDkRarej2w4nwE21HlsXyyvd283uAj9Iii+QX2yVdmfz
	 aShVD/guwub1u5vj5vnVV5375Nwnb9HmN5Lf7ZHrXUvbU8mng7XxkNy4M6eHZz/TjAFuN
	 Q7xl3eor6tOUjV7YdLXpe+bUrOUvLwF2yUN/79T0S59ZLnq+qwFeS+BVtUrxnDDXh2uzI
	 Sz/hQKWPbQqjez3ADdrnka+w0XbTmzhsohSzDKqO0tAKd1uqd2zNgXAtyCoXCDkGpuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LFiDLwd1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13866606A323;
	Fri, 13 Nov 2026 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LFiDLwd1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C221F000C7;
	Fri, 13 Nov 2026 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579099;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LFiDLwd19eqv1M/wfh/wfBb1Udo/ZBY+O8dwghW8LLPfnonRIb6IOMNHskBISKFm8
	 2kkRLMFOAcZ6ypBiugXQWBX8Lvg1LzlxJeVeR7ZSHOLRGM5+XyWJRoZYI7wVkaDxOo
	 AaB0yI1Dlouv/rLVUReucII0ea7DsylKK5ZmYnL3upraoh+slvDe+93G/sBm7A7CsH
	 frgWE8izxpik2L+2beVpbeO36Fa4Ngtm5K2TcuqMs0ogLXYCakREFOQ/yz251INW2R
	 rcAUGv3a2uzjYis1MGFCNTBqIK/1iQC/w3M9YhNl5Eya3hc091Qnir7NZMGtJtf9fz
	 TBujsBdYUikLA==
From: netdev-bot+sinfo@kernel.org
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/6] bonding: refactor bond_enslave() to fix XDP
 ordering and error rollback
Date: Fri, 13 Nov 2026 14:11:38 +0000
Message-ID: <179457909841.2168702.4398846656468541262@kernel.org>
In-Reply-To: <20261113-bond_enslave_restruct-v1-0-364c549e78db@kylinos.cn>
References: <20261113-bond_enslave_restruct-v1-0-364c549e78db@kylinos.cn>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

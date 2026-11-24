Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528091;
	b=CdSm0CSeXN7IfCSyns4cs9ks6xV7aAORegQA2+UJwSJmh8o6VH5F7K9eCCwVp75Ebpp9
	 OdSIIxUfikWL5H6E+G/hPv5Hs+i2OPO4Awdf3qwBd5odJIaZ/sRcsXYN5NRUPpMgPME+W
	 JFtrjsqfjPvRXNuWcuYb2TYp+jUyQiSCpV4px1r3V528/39UKo6rhgMhRQAf7xaMFx3AX
	 CxA9sXvaBna9NG/8qbSuQl0YZ9LCqzhEQvyNOLJDITxIOjovqn1rM9+bioL2+io+29aKH
	 nHG9bUakWgxPiIjLzLw/ANV74muVCT3hJrH+wwGBa2hyIMUIlthmWxc+K1bVmxcTuVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528091;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=kvpRMvQvERjBXr1WTspn+MSqC4VvEDkjayqY6xSgQmpUKKOpfPf1Izloy1tJBCF2/ndq
	 FabJteeozMnIX80z4gyxT9ERbEtGVHLFse5aTTl9mLU13JIgOe+PeKExXjuywD3UTqIKq
	 UNEcbN3DV6gKeMR0SF6Q0aUE3NYiSb+X952cFlr9Q9yoKVEUgUPFjqBpu++Nd5hSLG283
	 UkDDvH0yJJ3XrU5JLHTGEI0xUYF0Ob0t/WAW5C5ZN9kcg4YMEh86AiIdgSfXoPY/UJhy1
	 YnnyChMaUqqCzYaCXYykcgMuqnJ8164ApJewc8DoB1LFFxbxpEm7pQJ7irN4aUJ0azA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nNLXjrZK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FB4606A31E;
	Tue, 24 Nov 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nNLXjrZK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49261F000CA;
	Tue, 24 Nov 2026 13:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528090;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nNLXjrZKU0KPp5cCUzh35q0ds0kxGrTKVZIKVDO798cpN7n0kwTAOkUDiHn7kCGF+
	 NqRftmVVcX9z6FvIgiCSXAB1JKwZjHmOOSCI40Ssr11O0vbwmvDIMdJ6+JqgxcqSbO
	 Fy2qxB3d093ltYsDpfHerjlVk4GwAAVEnHFnwzNN3h7BLOQ1JQQaZ9ckh6ATwe/MZu
	 N0SprfwBmQwbM2S3a+bIFcYXl/TG48mGrCEtNFuDLqjV5CZ9nIu3RsKmzyQC/J+IGU
	 NMgvjz7gW3SiRudfb9OzsT1Qw+mpNFdDoMXXnXdXET2yXBvNyXF6vNVBwM2z31yZuM
	 D7a2lldDpU9nA==
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
Subject: Re: [PATCH net-next] bonding: check XDP support before enslaving
 changes state
Date: Tue, 24 Nov 2026 13:48:09 +0000
Message-ID: <179552808917.3294.9587885907238376998@kernel.org>
In-Reply-To: <20261124-bond_xdp_fix-v1-1-e67983924324@kylinos.cn>
References: <20261124-bond_xdp_fix-v1-1-e67983924324@kylinos.cn>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

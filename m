Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615415;
	b=1STyQHZJrHmQbN4QSEmEoFs+N8gLvkq4KjT6D7lfeKrNSFTGv7Chj7JLleNRij+JZx3J
	 1SK31aWFY2uw3gnYbth4yDPNO55lLWQICm4313b2+a/YySOucuwpJyElZ1+7DQl/dQ6LQ
	 IURNMC8UgrbRkLNp/ve44ghDzhtUjEPA9GC6xSezhmCidsBdHMqDBKphIH/FxJloxYXnw
	 zgqiP1TWcotFsRvGJVJpO/GJWVa/zHClRnaf7x+hu+qjJzxYavzQrkFdstI1oKqeB7RzR
	 Hd254Yc5Oo4ueB6DsBzv/HDd06NldPOEUsCScx5Yv9SkZIK09kxBeP3AOCv05yXJ49Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615415;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=4gn6ztCMBdO+LQm5wQ++thVC3QMSH5UJF9fhsCY4ocKZBIfFmeAMVPCBiAjJ/uMk2RsA
	 FF2Xsu2/0gqHJ3+A/m63O5sVfpvXefZw+vGyBnDaqilIyH2r7zbZ5okO6l4wXeoyIJ4W/
	 felcv8WmyJKLMBhugL65yIAVDzQtp5vm2yiCFWlHY4GxoN3QtlYfX+y+sJjgL7TRz2IdJ
	 Qc5wQ8j5YI3Wc3wDqscjHF52l+YQ3fh/WyyMdgeS0EhXFUS0oRpMxRfKw8W+dVENCGtE6
	 R7ghZ8H8WJN9QUQQgwMddYB+WVddEJzy6+F1MTFZvwrWE3oczljxvRZpReoptNAsDyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QticCuTq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FCC606A31E;
	Wed, 25 Nov 2026 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QticCuTq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC9F1F000CA;
	Wed, 25 Nov 2026 14:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795615415;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QticCuTqsKZK90iY+8jiekHpMUEt1WrfnYjb5k11p7hD1Z9bbLap8UgV4Mz04TkMa
	 dJpEXiaWsfwpADfpgk82BzQ/XzxQK9pk5e3Lw1oSpGO0uIW9gukkx6N2DcKcZgCxOp
	 f7PGUqzYw7QaYqqfOVO3cuLJtJUzw05K99JqrAQjWT5hgN002Yzdjmm+v8yccVIMk/
	 oZ6lrT/aGOVczNdCaPZjviyiNeLRyRcE47cqBtd5fJtumGUpEIJxl9+E49cb1DxJx3
	 4K9TdoL846mSAS7zqKTJyciwhxr1INA7tmtfzzaDTbFYfAJq7ry6QpUsROpiqx/EN/
	 35Aj4r1Rm8N5w==
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
Subject: Re: [PATCH net-next] bonding: undo enslave state when XDP setup fails
Date: Wed, 25 Nov 2026 14:03:33 +0000
Message-ID: <179561541390.3294.1758182107540555022@kernel.org>
In-Reply-To: <20261125-bond_xdp_rollback-v1-1-35dddaa337ba@kylinos.cn>
References: <20261125-bond_xdp_rollback-v1-1-35dddaa337ba@kylinos.cn>
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

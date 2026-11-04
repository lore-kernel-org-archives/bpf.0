Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761122;
	b=HBW/SwO2epl/DAtO4Tu5FKXD6pkWDH6Lhi+255Ooo3hvASwXSMWwy/YYivb+cBYzvX5E
	 ELg3mwUbRUhFI3JprCWCqAKjMvMZWipfiuJD3HSHHUyQXNaPcpzYJuaDV4jonlJbmLNng
	 FNIzd0KXvHdOg5+zLeapCt6UvHQwgSHTvNTs/4hf4gZuKQa0weYyKlEAPnsNJr9wJRkYJ
	 9IseqLkOUPRzBovms04R+00Aa2NMheZNCmg9CZ9UKYQKNWy6nt/9h58wQR+E85J1qjVke
	 GyGBQljtOE0erVTJ8Fub4WfIQkk1UbP/kNSgXG2tdyuHQzTVziMb7iaEQgmRIP+MHoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761122;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=HdqrZ8qGs8DTPeQQ82GJYcaZNGTahLuZV7iOrSzxsNj3NrqB2ZOdJe3VjpQ/a7K2mMhf
	 vMWx7uggH7RSLTkvT+BHtw3XaMviorzBhh2qkyeU35zg0bvZOO5JTqH9e/dkmac20ZEle
	 MpzmraPhsOKidtUzcLpDI+3Tvo0iL5QVEB8ZmWt/5LR6KHJfSKrDFmo89uc/lkK5Dz2qN
	 HJiwPZd+IUxam2y/kQ8x/jEeriVqFnzF2Fb0478Q7E+1lw9l1jQ0iTnuJnJApHZ41F2/7
	 t4dpa0Fm51X9l6MiXm3i6+PhhFyYYMu0sPd5nJpDmLAxOL+7L2LeWq879U9JEv0FrrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V92RrUXk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ABA606A326;
	Wed,  4 Nov 2026 02:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V92RrUXk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934241F000C1;
	Wed,  4 Nov 2026 02:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761122;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V92RrUXkes8jC7W0ma0nXdbMJh+Jw3cQQV3MevMlfBhA5/HQ+wwwb64DbSm3flLQ8
	 xtMog8btn41pEMVdjvbE7tE3KdI+XNwLTAS7eWHV4V9gvIKyfv0BOolqDVttNB9hYV
	 kv45JdN8785kZfK9ohHe+NSAwa9PyC5A9dJN2Q9JAnosNfWApoh/TNncnfJzPlG5yJ
	 lHpE+O4xm95WdU0CS4KjOeLBQOBpO+W5/3qEmk8eE9b7O35+trEka9fFxGSPqlKbdh
	 ZTTva8s34dsdw6Sr8qpYfkt7Ks7Cipl0JMtfn8vh8AejrRw1VgmckmWRmb9dU+5QTx
	 PhBN/0WLwEsWQ==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: 
 Re: [PATCH] net: stmmac: unwind the XSK pool when the initial wakeup fails
Date: Wed, 04 Nov 2026 02:58:41 +0000
Message-ID: <179376112114.488859.12792693475372171240@kernel.org>
In-Reply-To: <20261104025342.1527441-1-vulab@iscas.ac.cn>
References: <20261104025342.1527441-1-vulab@iscas.ac.cn>
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

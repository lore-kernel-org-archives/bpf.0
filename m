Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347143;
	b=do3XZy9icFCgxE0JP76XCdJUmtgMcagPDyI7CPISjoBeN2lfVKq1DoJHlEis1hwygQku
	 XgX4KC1ET8cwqsLnid4nZj1J4mvdN9JoupZJdIX8atiVK2uV0ka6BlHTeEC0A2bOBGcGb
	 CJ+ZdGXed4klNxXlqOYTr5qjH1oIp2NU+2G0ZE8vEYJsIC7AseiBQ02Btto/TaPxrydGY
	 7M49u/pXs6RNtIwpN9m2OUCiTyxVw6DNmdx9iYp3rDbLSeZpCa78z+27Y2KU9eGXd7J8P
	 0KW5wplB+eQwt617fvceoJNeYj2wdE+5oI/tcietgbXjHca1JKCCiguKkXrK1TQ3nlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347143;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=35fQk2prx0lBB02/47r4mEUB8fpBOI29YWOfBrE+Kf0=;
	b=kMaNSjdu44hStqcU+0GE+wmxhODw62KKr+FO3Be+rLExyefVf3YJcE2STcTnpahaKsRh
	 Owe08Bn89tNsI1FGm9EXZ7jLNLwpOg9Qgm39BJmfBnZrO1Bvs6r03/VNhnjYsUGHbsc07
	 Jb2pkTtAmogcC/0pG5vghz02GbEz/bsEItTOZYecctCoIMTuHVtA969NSo3fYZ//7E2EA
	 rzqgQLJl1eMseubAsPz3XtCzUPF3wF099sV/xFodcDr7xUx8BlPGApzve3Amvr6DLgWAw
	 Z7P2wFiusyrsj7iTrdsNL2UDzAIH25RW7snzROfEYZfuRsO8h1o1nzfG9Yq4y2Km8wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kymx3Z5Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85DF606A321;
	Tue, 10 Nov 2026 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kymx3Z5Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBBE1F0089F;
	Tue, 10 Nov 2026 21:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347142;
	bh=35fQk2prx0lBB02/47r4mEUB8fpBOI29YWOfBrE+Kf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kymx3Z5QuLjhVt9c5TXAk+kfoV9+Q69m2rh6gKaY2iciQySjWz776ENyyzO76ntE/
	 /uzWTdV8hdYbQdh1l4IyeQ5fyyv9r2cCWu0qjO5wH2a+J4S0bzy6nNaTA6trhTE0GW
	 /L1dwdPvEztraG/h+sVCOy641h7Uk/TMwO2q4hRzVBg/Rkxmb7cReJ+LatfFNQPTkP
	 6patrVaXaDmYcM/GxuvUQx3acPjDDOm/3QA23frVW+hN4rGRkeHMgbj+Hzf1wrVZRK
	 Mzim6bafAA11Nz4YojXw6wG9MXECjIaGYV2Ai4JM+kIAL0NrS4PfdlrklEcr67vMyR
	 y6wV8M99tyxhQ==
Date: Tue, 10 Nov 2026 13:45:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ding Meng <meng.ding@siemens.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, florian.bezdeka@siemens.com,
 jan.kiszka@siemens.com, wq.wang@siemens.com, p@1g4.org,
 gerhard@engleder-embedded.com, Jason Xing <kerneljasonxing@gmail.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri
 Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
Message-ID: <20261110134539.12d860ef@kernel.org>
In-Reply-To: <20261105071706.7043-1-meng.ding@siemens.com>
References: <20261105071706.7043-1-meng.ding@siemens.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Nov 2026 15:16:08 +0800 Ding Meng wrote:
> +  interface index will be returned only if CONFIG_SKB_MARK_NAPI_ID is
> +  enabled and the driver is using NAPI. This hidden configuration is
> +  selected automatically by busy-poll support and by drivers that need
> +  skb NAPI IDs to resolve deferred hardware timestamps. Drivers that
> +  use deferred timestamp conversion must select it so the networking
> +  stack can find the device and call its timestamp callback even when
> +  busy polling is disabled. The struct contains also two other fields,
> +  but they are reserved and undefined.

Just take napi_id from under CONFIG_NET_RX_BUSY_POLL instead of
complicating everyone's lives.
-- 
pw-bot: cr

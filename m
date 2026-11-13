Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612504;
	b=nezlaTuwxRrv92+sNoKyNGIrUg9walaDAbffk+zar0LPbAtYGSv57SvNhXzkqGr2zbFT
	 bgxPOCvINYwUi9t4P+WD2f23tCcL5RHLTEnSHdHhPe5iOgruZGZ7C8mMuKXzTe9PEsYpo
	 Q3f0/odWL4fGlbK3YKO25yjIRJv0LwHehgQecrC+KmRZUe4W/Mpv46/OZpouuBC4c7Jiu
	 0yfqhwwAcqvQvQcKaHgebPTP8r/MZmwB+ydVf8bOs9lxBqBMOGb2h2qsOZuCiLx5ht4wY
	 FyPLwRYfduNHA56S+yxpV5RoAFokUtFee4EqfQP5Zrjr6LCuPSvrPP3L2nTdMi5icyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612504;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MP44A2UXd/wSnusowTnecNPA/CsL40YpZ+6cXn2Yq5o=;
	b=Sq5txMwUbRcGJx5ttnQLWn6OD5y7q2rqBAWaKvjSWRLTOM2yUQ4qQCCFrNZ+XXwfnKzt
	 6njcjO3AhrEg7egMoYfMoBpEAy+1eDecl73tUJKQztEgiehr9Bb2ib03gXOPwh6HdbiTR
	 4albzVmDlrgFJno7nRjw3vpNxTcjm+HyPbAVDmuawqqrVDxmrRQpMrmNdCeKJJhJN9kwr
	 UWHJNkPTTKufBAAkEvHUy4vvyVNEwsosut4x5SfI/orlsEaqtYJ2V90HBOvXy1sbm4iYH
	 lVGbmOzYbfsyEE0ruun5vO+Q/7qFpRU0oGVuZKcs/LwMNtP2FNZ4qW5rq8zI5P1+byw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFmsfKiM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52857606A327;
	Fri, 13 Nov 2026 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFmsfKiM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BCF1F000C4;
	Fri, 13 Nov 2026 23:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794612503;
	bh=MP44A2UXd/wSnusowTnecNPA/CsL40YpZ+6cXn2Yq5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BFmsfKiMNSSguxngG5T8TrvzhBZikBS8lfNfuEiBlybN5vaxLk351fbzf17HP53qs
	 KNUCvlZMeITfQazmYnj5eztC02HQcH9cnSPy0tTc7P3gvsNrNyd+9EWzuoBQR6F7wP
	 qOH9TJmA3PVAhoimmwyWEDtxiDgat5iyUjNjRct/FDqggt18zC6NYyBvmiGqljqtQp
	 QCSyGIE4sQ50KkB1Aggc+ity1nl7SdzXHTIVUTLYeafC9xkDtFahIjvAbVbJFtXDSA
	 DvwsuK9aIJE+5t5x2PZ1DQw8KG+ez35Km2Fcn8vT+g6qFT8Tis0pg3m/c6XwCy7JFk
	 ILuB/iQ+Rm2/g==
Date: Fri, 13 Nov 2026 15:28:21 -0800
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
Message-ID: <20261113152821.47e9d219@kernel.org>
In-Reply-To: <4pqljild2fp6eotiicvwbwu2wfw66fzd4qamwt6utirdjxlaok@iiu2f3k7azrp>
References: <20261105071706.7043-1-meng.ding@siemens.com>
	<20261110134539.12d860ef@kernel.org>
	<4pqljild2fp6eotiicvwbwu2wfw66fzd4qamwt6utirdjxlaok@iiu2f3k7azrp>
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

On Thu, 12 Nov 2026 12:33:57 +0800 Ding Meng wrote:
> On Tue, Nov 10, 2026 at 01:45:39PM -0800, Jakub Kicinski wrote:
> > On Thu,  5 Nov 2026 15:16:08 +0800 Ding Meng wrote:  
> > > +  interface index will be returned only if CONFIG_SKB_MARK_NAPI_ID is
> > > +  enabled and the driver is using NAPI. This hidden configuration is
> > > +  selected automatically by busy-poll support and by drivers that need
> > > +  skb NAPI IDs to resolve deferred hardware timestamps. Drivers that
> > > +  use deferred timestamp conversion must select it so the networking
> > > +  stack can find the device and call its timestamp callback even when
> > > +  busy polling is disabled. The struct contains also two other fields,
> > > +  but they are reserved and undefined.  
> > 
> > Just take napi_id from under CONFIG_NET_RX_BUSY_POLL instead of
> > complicating everyone's lives.
> > -- 
> > pw-bot: cr  
> 
> When BUSY_POLL is n under PREEMPT_RT && NETCONSOLE, igc fails to get RX
> hardware timestamps.
> 
> Then, drivers that use deferred timestamp conversion (e.g. igc, engleder) must
> specify a busy poll dependency if they want to obtain the original net
> device upon consuming the skb. However, this dependency is far from
> obvious, and annotating it for future features of this kind will be very
> hard to discover.
> 
> Configuring the skb napi ID separately
> from busy poll seems cleaner and more reasonable.

"take from under" == make it always compiled in

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558577;
	b=29hxy6/5+7mA88IV0sF4TChLXTvjBBu37HQr7/y2RQycI67EeyL/6GShQInl8w8aPwMc
	 umqQwwbABWoUnRvMK3/jDHHm2pPCEmjTTuCnYeNapB2W1+faa/8f89vWVgJbIdXiWtzkR
	 cQgyLosHZIbdF0/BdkNO5Nr5ldiQGMpt3RncnVtc+zPcsIYc+2LpxJB5hscj28wEPJXbZ
	 DfnVlNoNQnGELDZZ541vXcUXdt9bjchBGvHEDorzhRS0VEF7QdEQc0YiB2mqmVhLIGqSc
	 s/A2UkBPMPdhUpf0VUqWZqxl0tb3P8Rt2p6BjZ7WPfZX0UXRMYGsoFqjefNZmzsltPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558577;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=1mYFa7xxgjAJeyPToTySUaczpeeUgBwhkLFQ6YEU7hQ=;
	b=YBzsROxk/vkvRTGTxqXLp12ZuYghr9U/gWGdD2hWQniLwBmUY5GFquiNEz6rR47Yaacj
	 JdVtOSljB5BL3C7DJ25dwjI2Dbk6u0vNgCzptEpXEp6433jgLV7Nau+om+Nh6HVdZqwFu
	 If2p+ac0KncP3EkYTj+EzP6AOWzbZb+abEZzHzoF/747Duhtg4qT+SnF0ru7HlXQiL1MF
	 Sogn9FXG01mtkDKaqOMm2wmKynss4aXtQZ+lrnBNnF8f4Lx40WSFy82umeDtjaZCncrRy
	 cvxgRyz1N10TLAGI193l+mjlAd0eOsBQECi7G1GgLMMuhh5MKXkLjUEYVsxtJUA2s3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=Z4pVlkPr;
	arc=none smtp.remote-ip=109.224.244.117
Received: from mail-244117.protonmail.ch (mail-244117.protonmail.ch [109.224.244.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0560A3838
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 08:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1F0560A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=Z4pVlkPr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1794558573; x=1794817773;
	bh=1mYFa7xxgjAJeyPToTySUaczpeeUgBwhkLFQ6YEU7hQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Z4pVlkPru5cQylQgYvXMOr49LFb2OHKQRpwgqEsPQ8IYOcp5mY86PTpezXkfEXJIM
	 TSWPAC6obDhtBNj8zBxGTMp4LunDoLDgHI8CkgfsnlwI90lWB9o6nf88ZWXy5JTsyJ
	 oyg4WoL4zZxN7i4Q4dYHhxADPMk3sh+uRVhA6rIsjYPzgl+bzhDT/FttGFSsPYvf5B
	 UZxLMtao3ZKqzEClyme06nK7cG5P1Vh00IoMUU72thYfI/lkBUMkmXeqLlIgi6RL8Y
	 GlCImxsZ7xBP1myXhpZBT84h2pzXJ9nbLH4rhzSnwNydeyT9lMMQhmNIm9Y6BzKyC6
	 E8DKtqW7gMFxg==
Date: Fri, 13 Nov 2026 08:29:24 +0000
To: Ding Meng <meng.ding@siemens.com>, "gerhard@engleder-embedded.com" <gerhard@engleder-embedded.com>
From: Paul Moses <p@1g4.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Richard Cochran <richardcochran@gmail.com>, florian.bezdeka@siemens.com, jan.kiszka@siemens.com, wq.wang@siemens.com, Jason Xing <kerneljasonxing@gmail.com>, Simon Horman <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
Message-ID: <Fhn2gT70aJ-2_eak73NBZYuXuKtVb64PoD8VQ9jwm-S-K0RhZilAg9iwSBJ0RlaiSrRvM1vPw1aHvGPjcktu9GmdBuvFk9244-q2IVOrFu0=@1g4.org>
In-Reply-To: <4pqljild2fp6eotiicvwbwu2wfw66fzd4qamwt6utirdjxlaok@iiu2f3k7azrp>
References: <20261105071706.7043-1-meng.ding@siemens.com> <20261110134539.12d860ef@kernel.org> <4pqljild2fp6eotiicvwbwu2wfw66fzd4qamwt6utirdjxlaok@iiu2f3k7azrp>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 8667dd8222532892df754a88db7395758801c657
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


>=20
> Then, drivers that use deferred timestamp conversion (e.g. igc, engleder)=
 must
> specify a busy poll dependency if they want to obtain the original net
> device upon consuming the skb. However, this dependency is far from
> obvious, and annotating it for future features of this kind will be very
> hard to discover.

The "deferred timestamp conversion" was incomplete is what I'm saying.

This started with 97dc7cd92ac6, 0abb62b68252 and 069b142f5819 were built up=
on
it, so maybe Gerhard should decide the path forward?

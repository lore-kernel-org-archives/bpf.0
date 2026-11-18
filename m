Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794962103;
	b=EdowqCE7apHOPyE5iDJNTHrOydzGmfv+AfDjrm9a4/7f4sI1x2NqKtOoA+Udjcj+xV+i
	 iZ/O2tw95SbK0gIHKGadAURYN+WxVoSp4ySEZZt8qwN8QLmUdyNZDgeKeS9ZKD+iYMSzX
	 byWT7c0zQfmzUf/NlqrSYAR8W/YVUpvP5jgthqDimOTBWxhVITEkQKfcla4INyD3u404X
	 JnlAZnKi0kFXcfEGIDqwvPtFPwWWHH1c4hKvqPdlxeeReVK/ez2JmDt2wD2Y6w8vIxKsg
	 2wQIXINyAF6DSJIp30gJISNvTruHvnOAXPklktkr2savNHlWMPc6BoUVKKgPC2YEQjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794962103;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VgMyiF3aoeCpbyadb6K+nSJ1MEgNf4FaQsw83jeO3OU=;
	b=HR2eNfprTmEqCe+8Qyd5XX8ASsXw2IGpb9751YQmnpOw0RJmw8Odlks8eWW9VbsCl1AA
	 +KBcv7x8ZHOyVJ2FGfu50/0L/x6qxtPRWAaD4QxU9OEWIBIHX/sXM3Gh/XGUtktQN/WYk
	 izvCpROFSv3R497pOkvwPH/gj7pCrSDuM/DCVTGEmFgbMRHSDp4BuCZooF86/4esEF7hE
	 0M39sdN2Jan9VKLSI4D9NjD3YeF23ek1SHRwvPUlTZjf6sAMXeMSuNPExvPm2AE68NH3N
	 OJ5/4Oc7gZ7XaE8YwWRoP7w5XZ83aevdvK0pUZ+BSI3LqNZTjYzoc9Dnfa/Qguj1tEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfYWL+LO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D37606A31C;
	Wed, 18 Nov 2026 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfYWL+LO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4791F000C4;
	Wed, 18 Nov 2026 00:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794962102;
	bh=VgMyiF3aoeCpbyadb6K+nSJ1MEgNf4FaQsw83jeO3OU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OfYWL+LOLJ2u+qULY9cJBoNtsqLIdb/wqbSKgQtU0N9a/8fCQuriXv9wBzxv2wz0S
	 I1M36vyB4T4Ly8OOGZ05B4RxUO7v3Z5P++XW53BNSCN9461fWnXM0PBuznXKPHN5yb
	 6bHo1REbFVmZXrPgYzzTsSEiRqJpnrV/2kgoqHTprNqxE3mrt29oc663+jVPC8AZEF
	 +Rt5evDuG2o7ts4KShpIXpfc/aC91p+t2sq49VO495OmVxU1SItEN3IvYdbrKkp/yy
	 OnJn1mmRXIVz8xAD3S21OFZQdtOaZBzzXjapeJlRWMOLEpD4M6jGsTz0vdxLX+GVfy
	 mbr25MNMS5iEA==
Date: Tue, 17 Nov 2026 16:35:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>, Jens
 Axboe <axboe@kernel.dk>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org, Mina
 Almasry <almasrymina@google.com>, "Mike Marciniszyn (Meta)"
 <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 00/11] xsk: Zero copy through page-pool
 memory providers
Message-ID: <20261117163500.63593c03@kernel.org>
In-Reply-To: <20261110102039.1002605-1-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2026 11:20:21 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
>  38 files changed, 2159 insertions(+), 225 deletions(-)
>  create mode 100644 net/xdp/xsk_pp.c

This is much larger than I expected, and doesn't seem to be a natural
extension of memory providers. For reference - did you vibe code fbnic
AF_XDP support without this set? What's the LoC?

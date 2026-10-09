Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F7D38F94F;
	Fri,  9 Oct 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557665; cv=none; b=Rtyo+65lwBUD6V4J1ZnfzGFiG14DQr9sawMv+AFAEPsWdovGK8AiNa1uVk5+C1ux0FunFcv114OcYSm1OAYhTw+5BwPbItKzlJyov12MKaeEKZZLhXtkZ6ozUuVm83lUDCRnxJ6CTrlMcxIg/sTJ8Ok9WIfND9cj1gkxvu4pXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557665; c=relaxed/simple;
	bh=mjLRswS6bYNfNkqCUU3C/HEsiq7eO6CnV8GdKO2vuFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UkTd9sdMVEN572eX7nqVwTeKgJCw8B720gSixBu719Qs0J9TYSeWh0HezwPqk/MYT91tHTrm9IsUv3t0f2wU8MOtW1FdS2FPdiKTatv43g1v32JzR04XcOd4kG4r3405JuAjumO/eHbNbngQ3vM1/5HHV7BTboKzwKk2CVUjzIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N453kPhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N453kPhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D700B1F00893;
	Fri,  9 Oct 2026 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791557664;
	bh=mjLRswS6bYNfNkqCUU3C/HEsiq7eO6CnV8GdKO2vuFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=N453kPhcceyGWefpyyMkh8h9XNCBS2zyx62fLFCZRLojtnDUsuAvNuscHX53gFm3s
	 IM1CCByH5Tjo8ZftWEx2BWhhWgfCQiJf6R/N1J5CNQtEIkPYX0fuTCQEY+96lpkm/V
	 LysX3sYmqrMmYl/WoitGXFB9HBGQ2JhmyBkQAyMgkgNIKvli4t6LSjnGOxcqPBlLeK
	 yoa4+nK87WviVIJbuBSYG/hc7yw83vA0zitOFAt8XRHSasbv0q9CqQSBVesQ57fRXi
	 5dGc/vpGcRPbgap7ZChLUq9K+QwoakuIsoGHYItI0pyBE0OP/LM6BygspXkHlvq//v
	 0ACTE6QqbckhA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Mina Almasry <almasrymina@google.com>, Luigi Rizzo <lrizzo@google.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org,
 "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi
 <bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, David
 Wei <dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 03/15] net: Add memory provider capabilities
In-Reply-To: <CAHS8izP1vXB9ro7coamL7MUvTJu0kWzej71T2o5y_GYpJzFB+w@mail.gmail.com>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-4-bjorn@kernel.org>
 <CAHS8izP1vXB9ro7coamL7MUvTJu0kWzej71T2o5y_GYpJzFB+w@mail.gmail.com>
Date: Fri, 09 Oct 2026 16:54:21 +0200
Message-ID: <87zewmq602.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

[...]

> Thanks,
> Mina

Mina (back from LPC, sorry about the delay...)!

Thanks for spending time on the series! I'll try to address all your
comments! Need to think about the napi kicking a bit more...


Bj=C3=B6rn

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E5377A85;
	Mon, 12 Oct 2026 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812151; cv=none; b=A686UbDryzNrlKL9HMdLxNIScI/JpU6ZkT8I6LCB6znHqbNDRrdtVqm1kYGRhINvHIW13Rz0bVfAuAFiECqcKZibfnqdOO/CWu8Qfv2iiiecXkV6lzrmYjXCmYdhNGitlJRCTm+eUrGswaq4mIRGRYGA5H9ZXF2BK8A62QP9fxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812151; c=relaxed/simple;
	bh=o+uCDYJoalpmAuog8NV49AnsAlRF13+Piyp8UDICu2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o0K9VbVfkZ2dznuqWrpw99P+pPYXdwDDGWZl9iJ1Hic+CsljEEmf5IzyQe/3WDFPz1sSoETkBJKrEFVFa1yuEz9878nBgrOHEearklapm7r6dj3tJ8UbBDqtu165nAioyPV36k8Bh01sJA18o6dKsRryqSsIWPQHovnBoIbdhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/2WL+e6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/2WL+e6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995621F0089B;
	Mon, 12 Oct 2026 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791812150;
	bh=o+uCDYJoalpmAuog8NV49AnsAlRF13+Piyp8UDICu2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=P/2WL+e6tvtsoWcuP1/W1CbAFCWX76eSnnRd2rI+MdYmKTxpUvBBVRAfO43q0jIbd
	 cyCRRSikZj4+Rv+LoAffYF6r+6ARwS2V2SDiKtPLNLydcTSC4Jqp9cg6Yag5yZxIO7
	 sleoR9wlkoYUlKZd+9/uZuxGXDfV30ece5Yhc7xNNTq7h4dmRs6GYiA+KoJ7vlh4Uq
	 vJxTo8Xh01DqDP9QoGGDFbm/NigqCIeOOB2J4NcBnwc0vAA76p+aQk9+aduExqYJvi
	 wHmP9EhPEr96f3I0B4Bw2XGSQorxdja748qwIRzBJl8TdmsCNcMEbnqTXkUWhPNkXy
	 YIhX0N8sy9lVQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
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
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mina Almasry
 <almasrymina@google.com>
Subject: Re: [RFC net-next 04/15] net: Let memory providers set RX buffer
 headroom
In-Reply-To: <asPVkD_QwZtqVLs4@devvm7509.cco0.facebook.com>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-5-bjorn@kernel.org>
 <asPVkD_QwZtqVLs4@devvm7509.cco0.facebook.com>
Date: Mon, 12 Oct 2026 15:35:47 +0200
Message-ID: <87cxtfca8c.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> On 10/02, Bj=C3=B6rn T=C3=B6pel wrote:
>> AF_XDP lets userspace choose a headroom in front of the packet data
>> in each UMEM chunk, and the kernel adds XDP_PACKET_HEADROOM to it. A
>> driver whose buffers come from an AF_XDP memory provider must put
>> packets after this headroom. The driver sees only the page pool, so
>> it has no generic way to learn the value, and nothing checks that
>> the driver supports it.
>>=20
>> Add rx_headroom to the provider parameters and to the queue
>> configuration. It is the full headroom, including
>> XDP_PACKET_HEADROOM; zero means the driver default. Add
>> QCFG_RX_HEADROOM. A provider that sets a headroom can only be
>> installed on a queue that supports it; otherwise the install fails
>> with -EOPNOTSUPP. The driver checks the value with the rest of the
>> queue configuration.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>
> This is also a bit confusing to read on its own. Do we not need to
> convert existing users? The next patch does not seem to use this new rx_h=
eadroom?

Existing providers leave it at zero and keep their defaults. XSK sets it
in patch 9, and fbnic uses it in patch 13. I'll fix the split so the
users are easier to follow.


Bj=C3=B6rn

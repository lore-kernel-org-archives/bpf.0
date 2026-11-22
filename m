Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378001;
	b=WXkgGGXwBWYtmSU4BXe98bMErn/87HIXWpBHXHvZdEH5ERv/HQSwfOLigbRJRZXd2jb2
	 c5sQrmbMbwuKdn2yCMHLVt9aYz5rQOb9dGe3ZjbdI284G87zBcfsiTx71UlbEZRE7j6YH
	 hFCliY7em3FPbx9BGDfi4C0l13DidsLXeipZYQ6Zm8OSQT/U5iBtgjtQ55mT95zPNGaWn
	 EUBG0n2fxV5s0deLNKRQQ+B9lxC2BL30Vhcbu90Pf91/RF8Dvpyj2ou6CEj9AfaxBIChZ
	 TRfo1bNcwzpR7oUgDfQ5/fqCEdHoURjBHnEtM4V8BbxAQVEtu+WKFAhJo1FjD0yxegQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378001;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4nZXt2cwakB2qfoko96Emq2FYBKfcAcG/kqO1hX2/v0=;
	b=Xwk/RrAEQ2ubdiD6C8uVzOkr1v8I46QS6IKVKPOrGxCMUmn6/62Rech7chAH468z8fDp
	 WBwyILss0LEE6L/LwKyHWgxJQ3K7S4Z4HYvOjhghLP+3cHPFQJReudoqPJjyt+mXC9igX
	 PIf8qzpFre+OcVA5Huq0aenABaroWD3qHpIk8JDbJuIuzNEDLhELaurj1JOLls66tBH9z
	 SxaJADKUmqyty+N7z0c6KSoKWxDAXBcaaQKlel6BmzXBBCntOIGfNbD/DAvjNQjLDKESO
	 CS7z9PL3xO4S5IdXv1S2+sF9OwHn9BMdY1nupE1qg+qaNCjNYNgNtbrRxfdMOZuSEKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpJzzCRY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1C606A31A;
	Sun, 22 Nov 2026 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpJzzCRY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360911F000CF;
	Sun, 22 Nov 2026 20:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795378001;
	bh=4nZXt2cwakB2qfoko96Emq2FYBKfcAcG/kqO1hX2/v0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kpJzzCRYkLXVPm+/+a1xii8POsvyUm6bHBOkcPkJoOOF0FQWpmGqNNb53QxFHMzre
	 xVdgY9fbS2afsmFm15TstV+GmIbjG7xvGdYlYrivJhrOgmqQHABi4C9p5o+42AefBc
	 wBbT1PUcaX6hM9is8vuebEz4tQzDlZElrgT+yird32s8uPqsejXNj33r7A5Hb0v5IX
	 pfBXGkz6kCcKCf8amkKitieeMD2jpSeW/CdbtmBl7AnzQ8xDNO+jb7d/bb/DIFcEy1
	 i0XGYRS1nfffSW4+b1KiKimnQoj5gjcOXwU7BAIfsKJBmmUsBUOf1WSs185L/CGh39
	 QljeTkIVxTOlA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Alexander Duyck
 <alexanderduyck@fb.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Pavel Begunkov <asml.silence@gmail.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, kernel-team@meta.com, John Fastabend
 <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Weiming Shi <bestswngs@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Bobby
 Eshleman <bobbyeshleman@meta.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next 3/7] net: Admit native XDP on provider queues
In-Reply-To: <av-TQztlq185q6VW@devvm16445.scu0.facebook.com>
References: <20261117164700.2157816-1-bjorn@kernel.org>
 <20261117164700.2157816-4-bjorn@kernel.org>
 <av-TQztlq185q6VW@devvm16445.scu0.facebook.com>
Date: Sun, 22 Nov 2026 21:06:38 +0100
Message-ID: <87qzgc1vht.fsf@all.your.base.are.belong.to.us>
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

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> On 11/17, Bj=C3=B6rn T=C3=B6pel wrote:
>> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
>> index c5335e935b7d..4f6702b284b4 100644
>> --- a/include/net/netdev_queues.h
>> +++ b/include/net/netdev_queues.h

>> @@ -229,6 +234,7 @@ struct netdev_queue_mgmt_ops {
>>  				    struct netlink_ext_ack *extack);
>>=20=20
>>  	unsigned int supported_params;
>> +	bool xdp_unreadable;
>
> Any reason this is not a new QCFG_ in supported_params ?

It is a driver capability rather than a per-queue setting, but I guess
that doesn't mandate a separate field. I'll use a flag bit.


Bj=C3=B6rn

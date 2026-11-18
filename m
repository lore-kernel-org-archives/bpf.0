Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961980;
	b=tMfmFCRbTYD+MVZYWdopWZZHjaejNvQIFRXTYRXM1cw9HhcugnKB/l/wIHOJiAYbNYKO
	 3Kfus2Jw2Wd3zYCUVm+5hXYJsGef9fHPyVZ4RH8Ct3G6vEZykD2R5Otc0vUPbaHSy3LDC
	 LfxJi65PhZtqHqBVVOmfSdBB2WY1/T6LT8LYNFNexTS6vMf7pz59+V/nkUaeNeX/iBFFC
	 CnMYNuelWG4zd56q2LaIEyPEIAcjCSOhalY0Tis98OJdaWMS0dhcjrpq8CrJ+JuH+wR+L
	 BCbHPIGWod2ACZ8HAIgbeFQSk5cDhOwpBM9acPVzH3UdhiXL/4DVPOclIeZD6t3oYuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961980;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WrMWW3SDQuTYveumv1s0qvBg0urq2O5dXdgqjDAwdQE=;
	b=Tf/QVfkZgWmKRx+RlF8WHHYKOAqp54mZ16lCZrAs+KcWlisk/ROfO1u4rCvuLY8eB+//
	 yqHih7/6FCk9nSUG6FtUwb890jAphuHxf4YM7WMJA0pyK4ImwZNIC0uc1gUftKCkKEfMW
	 z9sCZqrn8BGoAPgyJNs5apPsPSymN1RQGg5fbfbcREdtfy9H8QaOhwbc0zsRMTUpu8vtS
	 wX7tCllrhJwwaGmzQhEKKFHS/M4BIOO5EJsosrBlCYfLvWKiiLlyx4IuRk//LXSfzQyri
	 inq3BJwtURfHnWaV6oEL1/tJ5umMcRefD7lsfty3Hxe7e4QtAE8y4iOQNF30ATqv+YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lk4AwVO2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4B606A32A;
	Wed, 18 Nov 2026 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lk4AwVO2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342F21F000C4;
	Wed, 18 Nov 2026 00:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961980;
	bh=WrMWW3SDQuTYveumv1s0qvBg0urq2O5dXdgqjDAwdQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lk4AwVO2HBWZ3onOdeP+RP5VJDhfEkRUA/45iStCPEDAHQ7xTVNRXjEH2PLsecq1w
	 MkFqP3Amj6vdR6c+9Iw5lLVDCc3Q4uPqBq6rJx4CkdC6iIlUPHc6WO3XcyMXJsXHd9
	 k2JGvv35OacEXCU/QULyoss/SmCTdsx7XCRxYrj7dJhzFGCG/IRVN1qAJlCYczeo1i
	 M9gAG1tdwTXDJ7ySUAB9OU0gkoxKee5ftF81/KWLH/J+S1E2wDThzJSBbkcXzTNotP
	 k7TWztca0esadecq5JSkL/+GzpRQiLA43QCAzGQLWOnrpav1FSiM9f+zgIspJEKwaZ
	 f7ScJNUljQIig==
Date: Tue, 17 Nov 2026 16:32:58 -0800
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
Subject: Re: [PATCH net-next v1 01/11] net: Get skb fragment addresses
 through netmem
Message-ID: <20261117163258.446a0c45@kernel.org>
In-Reply-To: <87wlqcg85c.fsf@all.your.base.are.belong.to.us>
References: <20261110102039.1002605-1-bjorn@kernel.org>
	<20261110102039.1002605-2-bjorn@kernel.org>
	<20261115131314.2d3ab96f@kernel.org>
	<87wlqcg85c.fsf@all.your.base.are.belong.to.us>
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

On Mon, 16 Nov 2026 15:31:27 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> > IIRC netmem is supposed to be used for frags and memory CPU never needs
> > to access. =20
>=20
> netmem covers pages too, and netmem.rst already allows readable net_iovs
> ("Decouple net_iov from unreadability"); the in-tree ones just happen to
> be unreadable.

Ugh, slop got in :/ I really don't think "the in-tree ones just happen
to be unreadable." I seem to recall being involved in that design.

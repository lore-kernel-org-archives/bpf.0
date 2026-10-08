Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87B3C8719;
	Thu,  8 Oct 2026 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459224; cv=none; b=fqqYbcfPzHBT31ilJ/0SaiM0qNW9sMzC1DM7cM3WaB5Gqn00sOFwAMWOWXB5Xad9Xe6FrxxaGyZ9BngcSJNDHh8ZLZglAzeEGIJNVOIcI4AH7iPYDU+4HKFDhUF6/XE7CePbYGAudI9sZjpEQsYT7L9zCdmDnlif2qQBDwGzxZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459224; c=relaxed/simple;
	bh=ceUkDeWmmPei+btmcM9zEt7TCvFIZ6Dhd+ti4P8PXBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ow3iKqH1fDnVs+8nprPlo7FfJWuTpTLzgbXHwBIES75cIXFHYS/p5PUl9u3zzVzOMFX/WlxLbkWDn6tDY/zF4Jb2oyTQE38rtOLf1aLd7XmAyMB+rFhNz9yBwhRZHNfOZkcr71di4FZyYkUvIfmQb/xCJy7NQ4F8s2HxixSqK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjOVT4gk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjOVT4gk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE491F000FF;
	Thu,  8 Oct 2026 11:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791459222;
	bh=ceUkDeWmmPei+btmcM9zEt7TCvFIZ6Dhd+ti4P8PXBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mjOVT4gkvYM0zsUFBgnn5cRXTx3RR2GtLJ5oArAU1SYGay+hDJtn2B7v6ANmBlIG3
	 QmcLytEWTJ6Mm1YX0cSolJItAIS8GEuLEFSP99eDrkOry674u1nF9Z0ZlLtN9Qmtp+
	 D9MEhKbP/dDys6UWTKyJq6b7gXuILLhKHvF4N8ia89TPNgYXUgYstkOvtDjOlWnsB7
	 3gV0md5tYweGFmD/vsB9bqspxG9ae1k+6LNIgVN7zq/UGL9ZNz1/rKAflKwMA9rzhN
	 aKYUxhPdnR4hg2YFkyxfb/mGvRcHUfwqYZimkFuRBg6pD2kI8FgsTi4f66fEdcPJ1e
	 w4pTbbVJ+i46w==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Luigi
 Rizzo <lrizzo@google.com>, Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] docs: netmem: document netmem and
 memory provider design principles
In-Reply-To: <20261008023030.1089616-3-almasrymina@google.com>
References: <20261008023030.1089616-1-almasrymina@google.com>
 <20261008023030.1089616-3-almasrymina@google.com>
Date: Thu, 08 Oct 2026 13:33:40 +0200
Message-ID: <87a4oo2zqj.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> Add a Design Principles section to Documentation/networking/netmem.rst
> covering the netmem_ref abstraction, the prohibition on direct
> downcasting in callers, decoupling memory providers from net_iov,
> decoupling net_iov from unreadability, delegating provider/type logic to
> memory_provider_ops and netmem helpers, and the homogeneous skb fragment
> memory type invariant.
>
> Cc: Luigi Rizzo <lrizzo@google.com>
> Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

This helps (helped me at least!) -- thanks for the clarifications!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

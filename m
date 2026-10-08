Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3044781C;
	Thu,  8 Oct 2026 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458956; cv=none; b=O5puCGcgMpiI+v2oPl/GO4BdslNx6T3FX04O4dlEmVpeYsyom0qnMWM8nfzsOOc9R/pJ2VPFI2Z2mRXmWbW8zSAJXpFMcBpz7cGRm5BT0ePNEbV9J3NsG0W/t3/gqPcjbbU+zQ9j46xp0gSzOSBBKSW+bn1/XhHq6Frfu0wfr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458956; c=relaxed/simple;
	bh=CF4pxX9x1pl5xQ5PgbAjxKy8EZmkJx8mEemm3tSXWxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fvJgCjb9h7pduxSf0PoWJJ8mISHsORhwpbL0omvlWLMUlqJ8NTTff0wWXY+PyUc3+B2gWZJVSgIbaP3ny2w5HUybdwhnn/ZfMIB9LcYOOyTt6zpbPn0AiPbvu2QewCMheEc8bFGVwDx3QZXOqtPpL7V8oXU0a8R7pma/hqEzBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpnJ3PLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpnJ3PLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1301F000FF;
	Thu,  8 Oct 2026 11:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791458955;
	bh=CF4pxX9x1pl5xQ5PgbAjxKy8EZmkJx8mEemm3tSXWxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RpnJ3PLC82D53WwAyunL7eXzJfn3cUNAluOpF2p6KaAxFnyTKMmCz8sfyfXLWQb+f
	 JCeNAUBIIDjAgZD2c53p7RNBAR9eE4zcQtXQqZkWZ/3S1WNBfu18pDir/Qa0i0mivQ
	 9vL2A3AA9mpBWHJZPktzUmsbHPSLhvAg+uuJ75hx2fTnB4tUcYBje7nxa+C8afgVly
	 nBsqoixiGGmAvxmNpfT4eDRgGIj39YikhEzeddS7WDzZiGz7Au0k24pH6l2pgtaMvK
	 CuqyAyaKm6roCOFJI06qHcxEqMAWpRdoHSjmESJf87ro9A+nCwBKuLspKNxDzLeTIv
	 30an0ExLpfrQQ==
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
Subject: Re: [PATCH net-next v2 1/2] net: netmem: document netmem and memory
 provider design in comments
In-Reply-To: <20261008023030.1089616-2-almasrymina@google.com>
References: <20261008023030.1089616-1-almasrymina@google.com>
 <20261008023030.1089616-2-almasrymina@google.com>
Date: Thu, 08 Oct 2026 13:29:11 +0200
Message-ID: <87ece02zy0.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> Clarify the netmem, memory provider, page_pool, and skb fragment design
> principles in header and code comments:

Thanks, Mina. This is helpful!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>


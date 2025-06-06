Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553F1A5BB7;
	Fri,  6 Jun 2025 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749189911; cv=none; b=PgGBOENFRW+gCC07Snj4ah16lt04dbtoGMCkkaclG/E+ESnxpIF6pmBrkijIk6zMk4n9YWAAL6JNAj6j/o6+kajP+dTx+/ZA14FDDGATvUDQaf5fw7bZKniDGPO/sDh5mG/wFsZ16yYwCMkS2IJSyTT88Zdb+fsO7GseGR8RLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749189911; c=relaxed/simple;
	bh=DTzL7DH5w6RieyjzqD07L9LNs315gRs2qw8zCLb94/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoS73HsJScGaK9OSdO12NYWe0K9hVlkWUz4R3V56vqVhleN6D8LdJUjSQg4YTsEMLTCNidcaKc727MGLbH/N4g0+MMYLIPs4nyrkqAWmxcmJTsQgJPfIHPKdSqLIyaydpJJXGKWkoBqzYKDFXqzDVfGJKPgvOmtdNQA6/emyESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zisg+DrU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zisg+DrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2643CC4CEEF;
	Fri,  6 Jun 2025 06:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749189908;
	bh=DTzL7DH5w6RieyjzqD07L9LNs315gRs2qw8zCLb94/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zisg+DrUcu+dtFL2LRXv292Qiq5YWXVFY18by/5ETlckTfiAEsP35H4yv5eZxogg/
	 Tb8L7G6msi6VLJMysGTo5+0TEN2637NOGT3hCKwF6I0yHfm+4VcIjoc4jutZ40LD68
	 I8LaNQ9Pnq2YSIoH8VUA2i2Gj06n/haivsU1se+E=
Date: Fri, 6 Jun 2025 08:05:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Suleiman Souhlal <suleiman@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ian Rogers <irogers@google.com>, ssouhlal@freebsd.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [RESEND][PATCH] tools/resolve_btfids: Fix build when cross
 compiling kernel with clang.
Message-ID: <2025060650-detached-boozy-8716@gregkh>
References: <20250606052301.810338-1-suleiman@google.com>
 <20250606053650.863215-1-suleiman@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606053650.863215-1-suleiman@google.com>

On Fri, Jun 06, 2025 at 02:36:50PM +0900, Suleiman Souhlal wrote:
> When cross compiling the kernel with clang, we need to override
> CLANG_CROSS_FLAGS when preparing the step libraries for
> resolve_btfids.
> 
> Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." logs
> when building tools in parallel"), MAKEFLAGS would have been set to a
> value that wouldn't set a value for CLANG_CROSS_FLAGS, hiding the
> fact that we weren't properly overriding it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
> Signed-off-by: Suleiman Souhlal <suleiman@google.com>
> ---
>  tools/bpf/resolve_btfids/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You forgot to say why this is a resend :(


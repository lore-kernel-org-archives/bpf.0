Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142479;
	b=OnyGf5LcH/OK73OcG9J3z5ph/+VRRdYRV5hbdr04Qm3piYW4q6abgsBW4kFgdhvG96ks
	 k3r9b+19ZhpBvAp6kuQzJzn5xxkbsWww2oXAHIKBKqbwHYd92QwR61rvzvFivEnVbBI89
	 tpVQ9MCyHkVt3fBe6o/BW2+uHJTCvnL5Q0K7h33MyzVRYU7QyCxnvKbYUzYLzDazw8lyl
	 hdikqBee3cWrd1D/RTwwBaF5B2uJFvUSl8iQhy8IuxlB5iqXM19lfHddgA5TOe/YOpYnW
	 1mEzYLLoDkOuy8T32mFG4mXlBvzYwz2vylVnkeC7nYNQ0QNQvAenyM8kENxegWgSI2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142479;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IVuFIsJbsgegBH5kqR571iYmpn3DyoU4q4NKVBRMb/U=;
	b=yRCJWJP8Cg2PKTPe4N5nOmk22C9RBnX3IaB/KTT2KjEfghGE2k9QZ8Zjp58hQWBloOgf
	 XMUD1amo438ORQWLGmJxARBhHU2HQAQIpjcTtYChVFr7hPdONWSw4MNzoZsdnlTIuPjIC
	 Gxyz5Bfg+VUz6P1mxzeJgdbWMjL1SGctNclPmW9aUHh80GSSFCnLwYcfvvSxX8auc7tRm
	 w6eG01al876Jh09yU1AcW1Bop0ywj1f289Gwb7af7nxLiJj/VM1PuN0FgrHf2mD3xKwbs
	 YA/YLf2H4mzojRt4+/TvsIwgEhIAmXNGcOBNTI8/lkxGY/wh+KeqSq1X+c3dBae4xnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k/O+0z3B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A3F606A31D;
	Tue, 27 Oct 2026 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k/O+0z3B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EC01F01825;
	Tue, 27 Oct 2026 23:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142479;
	bh=IVuFIsJbsgegBH5kqR571iYmpn3DyoU4q4NKVBRMb/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k/O+0z3BXM6P8QtTO0ZHCQstIDSnJcWpv8j67xsrrZWVNuGGwjG9Q/vi3mZbCtkzj
	 qXjvdFZkgc0A8rZ0Zjp8EffxmKPhOpSCoF1A+3KYBbNaL3TQkynByZxiIr1QvmQ9lx
	 ajhPS/sYfwFq1PLqXkZdC2hWGfyFths74tTBOOZBdaBhZQfNqxXGdhPERzOeqo6EVe
	 Lwj3aWapFo8FDTeIWqjmT3uh0jlYVtma4O5W5Kk7TgQ8swdjUeWCZrO27rxl2mO1HV
	 N16ceaC5xwAkkbI1+NUC+UIeNeAQp0POqNqbRqeAu4m8ONg7k+t87vgM7D7/rpbWHo
	 hyU5684NERXNw==
Date: Tue, 27 Oct 2026 16:07:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan
 <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Masashi
 Honma <masashi.honma@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/6] bpf: Add syscall common attrs support
 for xdp link_create
Message-ID: <20261027160757.458c606e@kernel.org>
In-Reply-To: <20261026154948.99408-3-leon.hwang@linux.dev>
References: <20261026154948.99408-1-leon.hwang@linux.dev>
	<20261026154948.99408-3-leon.hwang@linux.dev>
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

On Mon, 26 Oct 2026 23:49:43 +0800 Leon Hwang wrote:
> With the syscall common attrs support for link_create, add syscall common
> attrs support for xdp link_create in order to report the invalid target
> ifindex error and the underlying driver's error.
> 
> Instead of passing bpf log to bpf_xdp_link_attach(), pass an extack to
> receive the underlying driver's error message. If pass bpf log to
> bpf_xdp_link_attach(), it will introduce bpf_verifier.h dependency for
> net/core/dev.c, which is not acceptable for maintainability.
> 
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E52471D0B
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497616; cv=none; b=kymNteSYC+m2hKLma2qQOX4ZNcAz1x5yM9V2fQbznJ5mpoQ9HkWEbS0U+JWjR/ZWR4Bhkk2oYpiQI3AQGsTLHHV++f/+pLUwt9XpJJ8rMjRXqY6hHj5aKWYC9N6Jx+bJkDzxyhTWiMPE5F1SC4qGREhnWfVlGO9+N0nrN7FSTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497616; c=relaxed/simple;
	bh=XjYDGK6HjNLwEE9cDyH2fc69s4zSLCXy5ifqkE4WBvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvqCdYnMHWG6q5O1MZdU8i/NXyQOIB4IwiAU9wK5QsXO3hDjpacJhJDUE+m+a/+HYpkAFSprZdC5ClBZYcT9Tb4XdBnmwa9+XGN6b7MO/qOr9fjPtYwpp4HKWL1phnpQ/c/qdNzrX4mdba1PxqQQE//Kzfpq7L0nFe/zm9ePLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LU3v9Y1s; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LU3v9Y1s"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3ab37ea4798so51006a91.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 15:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791497615; x=1792102415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xYUkTZ2E/cQovSHZnIL45VAnvbrCQ4bqpYzguwLnWtg=;
        b=LU3v9Y1sBFAWi14azj+hZ8+uKUGHK+iHXT9E5DabT59rhOMrKRYi4ByVn9p9czzMvK
         s+H1n9B0N7lfHAebeEJUw0BVe2mdfMmAyep4day+N6/kBXwf8y4TnPe3jpN+adEB1f7l
         qokHOGwU6LpmF/hyd4UxUTq5tvG2zgZFIy6LkRRytqaoNVYbZF87qCN9e0mlXWKS3YBR
         oantabML9eyhpdCfv3X8QLvGTNHcQFdsMZrXCsVhLG0cY3ftllWhJxqd4wb0e9y9CTDP
         MLv3sTFFmN+7JJ3SMrkAdJ1z3+AnFxguUvmCJkreFm602lTV43fT46TQ8j18BqPqo+4i
         iBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791497615; x=1792102415;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xYUkTZ2E/cQovSHZnIL45VAnvbrCQ4bqpYzguwLnWtg=;
        b=D0gbSZBSAEh/UHHIf1X8ztAT5Mb+UgiLUr+KBnM/hqB70KFChTHsQQkGBw58XameW8
         mVdATNn2G6lJ+WDuloD6YQTLna8HZfV/KOGMaCMKIhlOQuS2bAES+fPYwhr7zHMHDaLy
         zdGVa26uqpOJ+KVTIqMnl9a8qYwh5dxI7HwXMYv8UoHN9fMv5o+051C5ds9PVox5DkaB
         ptej2waLiue6Bf3PWCbZp0h2pdAklospVrNm1wzH6mzZkUuROQbqkzAwZbiPwgQLVMjj
         wCo4+FTwFM6o2KvbUu9JirPmDuZP1YCVC8sbZFhUVvI/YWkPW+l13OMkoxawVRorbwW6
         fCrw==
X-Forwarded-Encrypted: i=1; AKwUvByaW78Z+okVa0Uua33x7OL8D43Sjd8HdQHSlv8vNb3fcFftiS+Lfx6QxI8PVQ7AIGDg00o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJn12mAE71fmy3L7sxZ0LngnPHr/AKFM0bb7N6thZ3iOFr8OG/V
	ngZQwmxbDZRK7caKL7vwQGs4i5x1X16+QC8yw1F/+KNqp1Jxq/DgFAfg
X-Gm-Gg: AYBFou1sSgyZXX+jBDdMP/Br/IEtJOTWIhZzZy9dtRg+N5fagnUIJb8hQvUm0JYCyNc
	uYLdSrgdn9z7I/mRavp5Vw3c4c6id1T2ctIraJa/F9kDMcT/tUzfFdXS8tEPAOUK0jtkGeZMQZ3
	cLp/c77Y/JO44uuoINtJQ0MaDKVHMc6BQQliLlLbmTAYPsKuyTd3CoHjtZvHbIsr6B0Nk0wIckQ
	lS7rxlX2J34TIvMDxSY3rt8Ycu578iA9z+iQ2xGzCUsfN7IYQ6/i968Ij0WX3qavLky8q/rMmle
	YhuRJcDhaWGoHHallVTeqwN99/OOK0Q8BoPiOIGrf71/RzJHIrWZGUgTY8NDMjzYPUVbkzum03G
	/cg1PwiFVbskysXGx97wX7dgjMeflqpYz2YXQd2uohh2y8QodjBbiV0D4dFlWKd6xyjZyzbHSr7
	NEXh2qlLidK1B8UYGlrcucOwtn//6Jd4BxYR09azQynv72gtU0oEPyGEme675tob8=
X-Received: by 2002:a17:90b:224c:b0:3ab:2ad1:f10a with SMTP id 98e67ed59e1d1-3ab3a0ef48emr192835a91.0.1791497614574;
        Thu, 08 Oct 2026 15:13:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab32d3b4f7sm375490a91.0.2026.10.08.15.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:13:34 -0700 (PDT)
Date: Thu, 8 Oct 2026 15:11:05 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 bpf-next 04/10] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
Message-ID: <asgU6X_PcuUf8SSH@devvm7509.cco0.facebook.com>
References: <20261008031604.256498-1-kuniyu@google.com>
 <20261008031604.256498-5-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008031604.256498-5-kuniyu@google.com>

On 10/08, Kuniyuki Iwashima wrote:
> bpf_tcp_ops.{parse_hdr,hdr_opt_len} are called for every
> incoming / outgoing skb.
> 
> bpf_tcp_ops.rtt is called once per RTT, which is every
> incoming skb in ping-pong workloads like tcp_rr.
> 
> Even attaching NULL callbacks in the fast path hurts performance.
> 
> Let's guard them (and write_hdr_opt) with the new per-socket flags.
> 
> __bpf_tcp_ops_call() and bpf_tcp_ops_call_flag() are added to check
> cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) first and avoid accessing
> tp->bpf_tcp_ops_flags when no bpf_tcp_ops is attached.
> 
> Note that bpf_tcp_ops_hdr_opt_len() has 3 callers and previously
> checked the static key both in tcp_established_options() and inside
> bpf_tcp_ops_call().  Now the static key is checked once at the
> beginning of bpf_tcp_ops_hdr_opt_len(), and the redundant check in
> tcp_established_options() is removed.
> 
> tcp_bpf_hdr_opt_len() must use __always_inline, not just
> inline, otherwise Clang inlines bpf_tcp_ops_hdr_opt_len() to
> tcp_bpf_hdr_opt_len() instead.
> 
>   $ llvm-objdump -S -D --disassemble=tcp_established_options vmlinux
>   ...
>   ; 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
>   ffffffff8251270e: 41 f6 87 20 0c 00 00 40      	testb	$0x40, 0xc20(%r15)
>   ffffffff82512716: 75 47                	jne	0xffffffff8251275f <tcp_established_options+0x1ff>
>   ; 	asm goto(ARCH_STATIC_BRANCH_ASM("%c0 + %c1", "%l[l_yes]")
>   ffffffff82512718: 0f 1f 44 00 00       	nopl	(%rax,%rax)
>   ; 	return size;
>   ffffffff8251271d: 44 89 e0             	movl	%r12d, %eax
>   ffffffff82512720: 5b                   	popq	%rbx
>   ffffffff82512721: 41 5c                	popq	%r12
>   ffffffff82512723: 41 5e                	popq	%r14
>   ffffffff82512725: 41 5f                	popq	%r15
>   ffffffff82512727: 5d                   	popq	%rbp
>   ffffffff82512728: 2e e9 42 03 43 00    	jmp	0xffffffff82942a70 <__x86_return_thunk>
> 
> bpf_skops_write_hdr_opt() is still not free, but it can be
> optimised later if needed.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v5: Always inline static key to tcp_established_options()

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

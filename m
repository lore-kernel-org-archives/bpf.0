Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A63AD538
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506715; cv=pass; b=dlQGtFjp6SJEENz7kn1X2tRnNHPYPSkJ6jmEm+QEgGGpE04vLwnSeO1fxkqTP11mpmWdfraEjuifUxP4jZx6LxUDCPMf1Tnsn/HPEW9dtpNH8wDGx+cf7IBc6pLeuJX0nODoP2192TXhpvhv/L/G14TPrbMrkxHjsxEZMByONLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506715; c=relaxed/simple;
	bh=HXwE5QE2AygpKQCNKUenfAe+L8jeFrlMx2EkQ7aQSiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ov4JVm3SHR2dGbSJXlCHLrOjVu27zvL3gSaww2YF46ofZ/7IXtDvoqC3afRRiitHWrmYfKxrWBLsblQXDkt7F1lNxBv72j8vEPztb19oDhF3WEbpf+EqcNMNxBEIHNDl1ZzrKlYUqelmCsHCJbhoq+4loQsLj6157b95jp166pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vgzm9yi6; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vgzm9yi6"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-139eea1aeb0so653813c88.0
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 13:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782506713; cv=none;
        d=google.com; s=arc-20260327;
        b=kMaD1zFxp0kqZOtz4dEj6EHZug4HxHDUAL38xwyFtiCwwl5Q/SC04PhC61afJQIQ2a
         kDVeeLi7s4g40N+M58vq2P9fTqeTjQcWmTDTtalzJEDCFFuU5dzfl5xXW5THyXXva/2u
         X0tnMQAu3ecZf3OGBZqhQM1d5CXPw8OUOoLtgu6Cpri/wMnvyKNCO5sMARNO3/Xf9IU6
         Q2TabKIZJGGGfoq4vRaKbz4GX7ilGCDepnPVsqtPRK5ngdA1PygMLu+RTlS/uMnw1IlI
         lNtmMVNepjJ2fYwBhyRxLlwSodypW4wptTTQKwI3l6jl0P4mIUTh0gIe8f7yacwJZVTJ
         C8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I7hKSiMuJoFJUDE/f83Nn28oo6Runy3fp0E90qXAz6E=;
        fh=j4rG9dJP3q6t9LHuVkDP/cKdan4qdo+pRTc1MPeYbGE=;
        b=P/YlCMAsNqwdo/xS477MBsJikBRoakUJc06T40Xz6zk4P2j3kranTSzTjO0u8LG+aF
         LNIpNPZcS6NE72O3p0wxSTqa7xXi9R+UBd9OvjvW+Gkmexcy64gY4CD5XSjN6OPef7Re
         f2m/ayzJ7JJJNBFR0qM1VxTG7ivV4vsV6foV4CP6PnkZJKlLSOlfImw+aI9/oNTofPlW
         9l4UecJ26axRLH0claMAnNCsiV6vWXPgCc9FyMqXctnpiLnqSVdWEPYt3p5qOZZLTX8z
         F9uzp6X4fWlj1N/dMO33JGyMZEjGskpmuHoCz/gEXayCxW2CJ+p68pxdjv3Z3S1e2h+P
         xasQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782506713; x=1783111513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7hKSiMuJoFJUDE/f83Nn28oo6Runy3fp0E90qXAz6E=;
        b=Vgzm9yi645IYFY3FSgjzxuRZfiZlZ5yvyVT2Ix8SBGeoHRTY+e59da8NCcApRaGIVA
         DIgyCP0LKGxMjINreahD9gO4WoPDXLkYAvqD+/3xu9MR0lZ9FPcO5WKF+icH7Zadux4Q
         LG1hlRMJn1Ee/NudgV61xHXQHbvqaRRXmUJ+i2361joqbPdBr2WLzt0M43QwUCzUwPcb
         hbKLpPpSYoiblfw2Dh4A3mXFmlnpM/o4nEye44Md/wYXfcZptfMJAr4UyYBVLYym6UVB
         dYyl7CAldB6B6xYsDQ0iV6fAgTSe8YBFfOWFrzLC1k0IEebnu89bXivB7ouZx04xiPbE
         +zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782506713; x=1783111513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7hKSiMuJoFJUDE/f83Nn28oo6Runy3fp0E90qXAz6E=;
        b=DKxTr7Ui6ZHTcwH0b2BfD0SBQjey4jxq+2HNiB5yCesssduxqK9JgBpxvh8MOX7lr0
         gXwF9q6oP6UvnZ8StTvLSinW1bjVfp/wT/4/O64DRh1GdfQ9XdaOLITMQOjz4SjUm5ll
         iCz1KOikiLuqwzK7DkOklXj8DOuQIBfrUcY+Mbp7wm3lZKqZ9REIqQjr6tT5zA+Bz3PP
         ln7UA37kLZXBIypC32TZA2PO2c7yLHm3YL5trcPg0uxnMsgl1i4SxQAXgJnxgitsqM35
         HlY8zEi64QrTHKTPc8K7eMvUedQKedu6kI4MFc2N16GL2VOwCrI8fUb5duUyHekR5ONK
         bjJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/TkXOy2lBrg0fpOA6eCq07NSSeEegnl9ks0k3kMl7v0u6qSkIiaKK3npVryF7OuRbWsZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyduNbOnHaa0TAArT1ooEKXWqwGXDS/LF4xb6wdY6V07WSjlI5
	XRH+51542fviCGsMoDE+V/CxhiR7TuPCqKGiv+WWpPVWGEyHNKYy06GAZozpPypBmOu3AUleT2m
	10U073/sRvBbKqQGF8n66n0WQtffERGvHfIrDwSvA
X-Gm-Gg: AfdE7clzF7emJK7m46wXNiWNovcn7yA7FHb7TUJF0MWGwO0gyIFYVa6zPgYzp8QcsFj
	BZTg7bD+JbL87WtvAO7qGYpwJ/qVcCPeZ0+tEanvF4uctLsLtDLsk649XQ7vhaxRuVOGu9iyvDS
	1uXktUVDFaRyGXzSakC5gTT7N5tB1ALRHnTZK9foQLVMdR+hJPkdh98O2eNEsqqQYCwPlkjmQJn
	hxFigsH40Qdsr38Id1mwAHtEXsUkOflVMWvqrrE/Re6gaq9RhLiaVBiX8fni7u7q4ZAagwLrb7a
	SeKHooVyUfPuAgHyPCkzDdDlJ1EwcYtu2tjzH0pFS5eAIxWRJ7/jlw2FLVFDHe5RH3p/xhr1kb7
	/o7yOfmkZBQGAwm02sxQDj+94HqXi0AMLRA7DXMs=
X-Received: by 2002:a05:7022:41a0:b0:139:b977:9bc5 with SMTP id
 a92af1059eb24-139dbb2ea4cmr7763842c88.17.1782506712014; Fri, 26 Jun 2026
 13:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co> <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 26 Jun 2026 13:45:00 -0700
X-Gm-Features: AVVi8Cf-y03bJ43WYYvw9v-GEe05G2Y8Afs3h_aEIlBR5CD6DchBEBYz4DVEdgo
Message-ID: <CAAVpQUB-hMuVpT0dcTcDDsSeDLXgBmNuMF4HTniHhJhVuxbFqA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:37=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
> sk_is_refcounted(unbound) =3D true, while sk_is_refcounted(bound) =3D fal=
se.
>
> Because sockmap accepts unbound UDP sockets, a BPF program can increment =
a
> socket's refcount via lookup. If the socket is subsequently bound, the
> transition from unbound to bound causes bpf_sk_release() to skip the
> decrement of the refcount, causing a memory leak.
>
> unreferenced object 0xffff88810bc2eb40 (size 1984):
>   comm "test_progs", pid 2451, jiffies 4295320596
>   hex dump (first 32 bytes):
>     7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
>     02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>   backtrace (crc bdee079d):
>     kmem_cache_alloc_noprof+0x557/0x660
>     sk_prot_alloc+0x69/0x240
>     sk_alloc+0x30/0x460
>     inet_create+0x2ce/0xf80
>     __sock_create+0x25b/0x5c0
>     __sys_socket+0x119/0x1d0
>     __x64_sys_socket+0x72/0xd0
>     do_syscall_64+0xa1/0x5f0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Instead of special-casing for refcounted sockets, reject unhashed UDP
> sockets during sockmap updates, as there is no benefit to supporting thos=
e.
> This effectively reverts the commit under Fixes, with two exceptions:
>
> 1. sock_map_sk_state_allowed() maintains a fall-through `return true`.
> 2. In the spirit of commit b8b8315e39ff ("bpf, sockmap: Remove unhash
>    handler for BPF sockmap usage"), the proto::unhash BPF handler is not
>    reintroduced.
>
> Historical note: this issue is related to commit 67312adc96b5 ("bpf: reje=
ct
> unhashed sockets in bpf_sk_assign").
>
> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagra=
m sockets")
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Looks good, thanks !

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

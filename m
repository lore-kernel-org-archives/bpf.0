Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE613D5221
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733085; cv=none; b=MagfiZuSQXm7R+jhKAKEDLp/KHsocrG6VB07wfHfZbTGGAEMZoaONZ6LkXeBgcucvLvJ2DWgHDvCK3DN+m0jVy8VMJizQLofssvvlTs4UFSLoqBnLIuBGGIPJAI9s0ODnJCOiuzLMq87ElqzmZRAjgs+Z82BGFGL/bA7Wl0f6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733085; c=relaxed/simple;
	bh=hlmaqdyJeKGEvjfmMwcdchUWTlUnrqFhj6hHVaVVdRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZS1V8RJvoQ2D4v/S2mZHs8WUbu29qOWUc3CZl090OLTUNEoeRMoJO+3GEYkNA/8Vu/ft5iYFQW71ojhtIl3YNozAlAQAk3fifIwUI6nRAnPDE7hCG+ZqLsWpeKauCfDd6NMB1LlCVEVxH5aiJ1W296hMFOV50Su5tUS2kTFvJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Gkk611Jv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Gkk611Jv"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1254b73d63so152771566b.1
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782733081; x=1783337881; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4j0J7ecW2SntxG8Jcu8wz/94ArS1e5wO0N1ClDdsWM=;
        b=Gkk611Jv6oFA/Q0Dw+AmY9jQBJXLxe/qb/Ws8V2rB3CJaQVuTRd7Bs82oHrwF1j7My
         xtufsjTZCUIJwm9QeqOBY+mxkvkvyQOuPk8IgiSDA9jsueDcmacO2c58mprdYpsK5dQJ
         pzOz4BMgAlkbUUTDvB1I0zdopvHtgsHsrG0nzSooYV8V/7Hmf9Xg3Pw0HzOCGtE/Lsbx
         kCumAtwPGgG9Hzhgy31vRBITqtLYzY3kfUvJWrIVHylHDamquuoZH95+u8XVi0bLNEb6
         xxhjeeYODQdqqHBk1ro/SMiQozlRyXtsjPARftMeI4m1b6xBjuKgJl7GHSuIkoG93ifJ
         ZFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782733081; x=1783337881;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q4j0J7ecW2SntxG8Jcu8wz/94ArS1e5wO0N1ClDdsWM=;
        b=QMhCOwN0VzVCG/HX2vS+9EnNpNilAWAxR4bBKcKeXmFtoYjJffNGYSxOWfiGe+pzv1
         wxTHkPWwwuEq8rKHy5MuVwukC2lYeHn+cIOeKvXdy7YjX/kdfCzpIH7GpTRjA4bFuMvE
         VC9ngFQxC50K4J58enwneQYJI9qqSgTkrFGWuUxajM7LcWz2tPKPNFPW3jUPacnTeGr4
         NkfIyOtbHyyR8JsoRaxesXNY/HtW/5nziaT3tnF5NM8tavdsHh0DL4P+XsfoAdZUic7O
         ZWX4KEF1mNeMCQSWnxxwkJ+P/bm4qyRvlH3ztPGO1hi3H1BMW/J+bl0JbGGBjUlJ4lbF
         Q14w==
X-Forwarded-Encrypted: i=1; AHgh+Rq+qmxVggI4tvIjBt98bWmJUMwKrEyN110Hp/zZV1EF5n5nXaRoCp3tZdhEnOD2OrNo1gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsC14DG8VN7//eCYscLUdd44WPIEzDrpI6BTvj+W6B1c8BXNDz
	Wf3VXK5fnnjqWSA6trPfX+wDPqHpH903aCNByHLY6rW8Z1aJ8AZlj+sJlMDVCBepmRk=
X-Gm-Gg: AfdE7cnjUCgZhMdjU282Yu915YtOGzUIukSNGMSlIAM1fGvZIf1446ZJPzv6JBUjJjg
	fDWNVfjDpe6rh5cHB8STV66gmSRBMnDk/lG3GvJWLY2KZ3HYdEAvFfbw9l9JVDdQ4p101y8MJxU
	yrOuIP4NsLqxnLCNWp3faXfaklHByJRGc2OV6uPn1Ee8BFeF4XeXGUsfYOL9JwJZV6VtazBbFiB
	9KOJUiS/l8iQjsIBK1eoJEV+aFw0lp24MysvAf90GfKIju+xPyp2e9hNRJGhwL6/RgLlqTH8Y0K
	7Chd5rswjYVZ9Q7LY2Moi3Xo4yKORiYT57hZxZaBaBWLLC7zCnerboFrcgl21Xa8UjU7wvNz5PR
	ZLaGldtzJ4Eutp3+R2W0ZzdY1kuSm2KcHfwxVnKL/t1YiKaELawO1hwuVxPOBtZmlOLMDqcPJRK
	1tG/2mPFXXjADcES8=
X-Received: by 2002:a17:906:f5a2:b0:bfe:ed06:5a20 with SMTP id a640c23a62f3a-c12061a4554mr955436766b.53.1782733081465;
        Mon, 29 Jun 2026 04:38:01 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1268fdc5b7sm142329066b.30.2026.06.29.04.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 04:38:01 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>,  Kuniyuki Iwashima
 <kuniyu@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Willem de Bruijn
 <willemb@google.com>,  John Fastabend <john.fastabend@gmail.com>,  Jiayuan
 Chen <jiayuan.chen@linux.dev>,  "David S. Miller" <davem@davemloft.net>,
  Jakub Kicinski <kuba@kernel.org>,  Simon Horman <horms@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Cong Wang
 <cong.wang@bytedance.com>,  Daniel Borkmann <daniel@iogearbox.net>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong
 Song <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>,  Emil
 Tsalapatis <emil@etsalapatis.com>,  Shuah Khan <shuah@kernel.org>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
	(Michal Luczaj's message of "Fri, 26 Jun 2026 22:36:29 +0200")
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
	<20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 29 Jun 2026 13:38:00 +0200
Message-ID: <87pl1937c7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 26, 2026 at 10:36 PM +02, Michal Luczaj wrote:
> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
> sk_is_refcounted(unbound) = true, while sk_is_refcounted(bound) = false.
>
> Because sockmap accepts unbound UDP sockets, a BPF program can increment a
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
> sockets during sockmap updates, as there is no benefit to supporting those.
> This effectively reverts the commit under Fixes, with two exceptions:
>
> 1. sock_map_sk_state_allowed() maintains a fall-through `return true`.
> 2. In the spirit of commit b8b8315e39ff ("bpf, sockmap: Remove unhash
>    handler for BPF sockmap usage"), the proto::unhash BPF handler is not
>    reintroduced.
>
> Historical note: this issue is related to commit 67312adc96b5 ("bpf: reject
> unhashed sockets in bpf_sk_assign").
>
> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

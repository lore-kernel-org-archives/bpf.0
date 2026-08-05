Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E68330644
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 05:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785908586; cv=none; b=tN4g5KAfxoeuoJ7ImO4J/OhDtzeLF2izReiwyP9x+iwNIiduVctpLByxyz+PH5aL9LRubqjJq7ee8uzrOgNr2/bqGB1aOlFL81z9Ncr4+M7avn/GVR7OdvssPIn5dAwNBT8XN7RKboqnStvQTriSIlNp+rkHK8K/CekemMSdqOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785908586; c=relaxed/simple;
	bh=SIHctkUs9lHO8yn6cE/oe//bJ/B/RXckthLcroKvRWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FXOtzP0jLg3S6uCZIcfSxgHzsjfphD3fb8Kv10InsrlJRPwbYP9gHpfVuZOw4o4MSzgmwLZOiqCnbVz0zyUxHQXxanhslI2xHdvNKlw8Aq8JBb01bjQAP7oAtLl7/mX2MOhtxYtgu0mQpWsfpPPzuVLwBDkMSnHlS7lIuuMdmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/mz+BIN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/mz+BIN"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cacb8416a1so6758885ad.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 22:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785908585; x=1786513385; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FfEer89cAo7Is+IW4nJHvY4G2ApEuGef+4eiu3kuxnc=;
        b=H/mz+BINnihgoiwtQy4vyboIShOS56E1k753gYok5DuiMpmThBI+Y7XsPzjYAy6pbw
         QuvOnS86goZcm+PDT/C77/oKNBp/1/5hqWdOZ4rA+hb+O4IRRF3MmLYpuJ1y9DMy3tyw
         YlaED3NqVJT3HOeIaLskIVEFe4kx1PJHRb1pk3w9m+XlUeRwfl6kvDdRhCW5oS7HpUIm
         K9sJlRkpYB+2S7he4Q2AEphqoBR5xLfFAEhgzW39T/GUny0TUfx30nnDEgcxzMti6n5w
         MQVYbsRJXWZy/Y1AraKobAha0Lx1pXsAMafcgHtlpfOx/JHZzHS/HAOR0xseL99DsZrm
         NRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785908585; x=1786513385;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FfEer89cAo7Is+IW4nJHvY4G2ApEuGef+4eiu3kuxnc=;
        b=qLRtjdSl86pA0ryFxJHQTITukPOEGYJJNcvcm0WdklE/4xagIU5yv9IyGDHrdBkKRC
         cLRJRTFImHIq4Qu4CgBA5wlQlSH/beKbzFKdH0zEFaN/PKsewYTlgbsNkJsFOEo05k/q
         PnFzQJMwBIEOQ6ZL7uyyrFznSMnYEhH5Ulrc8XuQZfwWRi48ZZFF1s+muYVt5GoX1qr+
         qWOI3fg7VvpWQYPqkKjAokClMa6PHgpSsQbTkEaJmPBsqcpUDqPuduTQEUeE/My8f+7c
         jFZyVnPHhHL7nc8p42Yc/UivN7nghmT09a5qLT6FgJKJopBFvOCCPSey8XPZr/ku4tyV
         tTpw==
X-Forwarded-Encrypted: i=1; AHgh+RoWHqKhL+eb1z7YGHE+FE4Wqxx0u8PDi//Nc8fKjOTFy00BPY4kLPkykgGxgncJ4hjY1k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZXecm8Hk9WVlwLdAhUhbPFyMy3GPPK7cWkEOmhNSoZjkxixBr
	nezbJeo35dHkjyx1eZvV1ilixZcnWTEfs1OU/jXwIcjUqG4DKG/e8e/NCPMmhw==
X-Gm-Gg: AR+sD10t+qmdb5MNRuMRDU83WmkdSYuvRSModL7FL7NnJuSvyk+Lfe8raiYu3XuIkan
	tlAW1KdASaDfcsD9FmGACv/jZ+4ZYwCtpDlg/cVVCoIf+HWY/Phk7DbbrQujspU2AfO35W56/bN
	mn7kj+h+nigZoY5w9enNsvm24K9qBUqLIluV3M3dWNtYOmdJriz4nNZJ07jzV/UBYCH26gXoASu
	FGku/eUOQq+TxVFkl2mirwwcQXxUJK6NN6HptUFLjRqgQcP4smK2e5oXa7tpjZ7V3FZVgkh9+2Z
	8775/ipaoHzkvlYuqyRllftmUJMyp9dWOzZ++Ofu2ZqHgNAjj/EvdAPhbbw6CGXeju4pt0fJgiy
	4xCWbJ/mrimKZdNW95YNc4tOq9gCmmMBU4F7n9Iseg29gxuKHehugVwENOQ11hu4uw9tOl75o14
	wGOMiB7PNcfV5Z1DOwTBF4nspKMuGvEmspTGE433mpEKrLBAhuwnkbIdhTEWpUx5/j+c21qAne5
	bR0FGRz9hIoQhzS
X-Received: by 2002:a17:90b:1b07:b0:36b:77b9:5c8c with SMTP id 98e67ed59e1d1-3903c5cfe5dmr3899932a91.17.1785908584529;
        Tue, 04 Aug 2026 22:43:04 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febffb349sm3326643a91.6.2026.08.04.22.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:43:03 -0700 (PDT)
Message-ID: <fd056d7be63d69f0787ee04d550793c42cbcbb9a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 6/9] selftests/bpf: Add JIT-sequence tests
 for __arena kfunc arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 04 Aug 2026 22:43:01 -0700
In-Reply-To: <20260803125115.2264733-7-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
	 <20260803125115.2264733-7-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 14:51 +0200, Kumar Kartikeya Dwivedi wrote:

...

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_kfunc_jit.c b/t=
ools/testing/selftests/bpf/prog_tests/arena_kfunc_jit.c
> new file mode 100644
> index 000000000000..2359cde24c45
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_kfunc_jit.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include "arena_kfunc_jit.skel.h"
> +
> +/*
> + * Runs with full capabilities: resolving module kfunc ksyms requires
> + * CAP_SYS_ADMIN, which rules out the capability-restricted runner.
> + */
> +void test_arena_kfunc_jit(void)
> +{
> +	RUN_TESTS(arena_kfunc_jit);
> +}

Nit: please avoid adding this file, and instead put this
     function under prog_tests/verifier.c.
     There are multiple tests there that invoke RUN_TESTS
     instead of RUN for same exact reason.
     Same applies to the previous patch.

> diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c b/tools/=
testing/selftests/bpf/progs/arena_kfunc_jit.c

...

> +SEC("syscall")
> +__arch_x86_64
> +__jited("...")
> +__jited("	movl	%edi, %edi")
> +__jited("	testl	%edi, %edi")
> +__jited("	je	{{.*}}")
> +__jited("	addq	%r12, %rdi")
> +__success

Note that __jited output generates labels like this:

  50:     89 ff                                   movl    %edi, %edi
  52:     85 ff                                   testl   %edi, %edi
  54:     74 03                                   je      L0
  56:     4c 01 e7                                addq    %r12, %rdi
  59:     e8 42 5f 40 00                      L0: callq   0x405fa0

I think it would make sense to match L0 in this test.

> +int arena_arg_jit_nullable(void *ctx)
> +{
> +	stash =3D (u64)bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	bpf_kfunc_arena_cap_nullable_test((u64 *)stash);
> +	return 0;
> +}

...

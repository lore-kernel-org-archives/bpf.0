Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B511E3346B5
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770231922; cv=pass; b=EmWHB8aK0uZxvROcnseMu/0lQbX/IX/R5D+dUR530CiRElEScZo3xuoyQ5B9galwNZkcvgSnkRLJcluX9C+U6ZyBX+cMgb+cz3tm6ERtAjG+ykOe0BZQhxjRyuhQ9a0OEAJico94+mU7D2sdjs2C3gW01SXVzGMIvsSHfI8BVo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770231922; c=relaxed/simple;
	bh=SLv+i/uowOZdIzzgD53bs7FT7DHh4IXtUrkqJZYulLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6qDQkAf2E7RCNRR5FnqkJ7w22LDiXCl/P+5Vfe5LUV1D30SaND7LauQT10Am20JwSlaL/7oF6dIXIdIagSmvBjb9PKxqHesn/HOHS31cL5t0SbnREsmBkfNhKWbv7GVLjOWCytJXjlHIOgIGfSTiu3Ge6JZjHPgV8XeaQ6hBdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeuiKjby; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeuiKjby"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35338b3dd31so13238a91.2
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 11:05:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770231922; cv=none;
        d=google.com; s=arc-20240605;
        b=K7Ox/JnS1rcJ4VCSyAQk4ESbKc0KCf7M+poVWaTndZbMkNZOeNpTIy9bUayF9d2Qoi
         XoVUjQiI/U9cCGJ4z4rMiUWumNaoZ8hn5Fr9yPF8Kzla1uNADIj+kIT12X+F3TgxtTy9
         gpWlVdZWjFj12P2iWvyuuAw4T+9muLmrFvVGTlpFbr0t/sZetfPPz+VB7TBRCWYoIsRo
         Ayrb7uKsASCVZnD/Y+Dvpm6tGCu4MIxLUr0Cc1k2gENS0Td6JIraAToqC4xUoVM/3wPF
         1t0znimpgQZn3MFZqrOq92+jdvqmKC+5zpY93Yqf+hIOz4p24XMIWhvJCSDc+y9mbCgM
         DHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MzwGZHzRP4UEU2ZnVmONLCtGE+i75cYH0c1sOGrN9zk=;
        fh=qkjOoXQbOrzD2LJSw2no37Jm+ghVmNS90pEwZA3G03o=;
        b=F4JrY2+lw/0uIwh9h2plL5xdvfRdUk+Gaa9BWiE0Sap3/1OtSraJ2bugiLYdsoD69F
         YGn1cSMcXaumugMiUUqpTM69DfeSUA0pHXY1vlN+E/dJnt3xaORwwAnBD83gF0qeutru
         05O7c0Mh9QjdaWDNQISX2GSvWlf06eMpFRxMtdGBGYQLt26YlLwvB1IrUW6xPKeeJZZl
         +D6VwidfezfwFQz8tNVITU5MxkL+lc4ZEiL0g0LYuM31qXKKliSTZ1Sy25QCJxK/ZFlW
         VRBEtlmogdwIE0f4ude3qFKVioP0CavlFxxK0Ozs/tmnLmarlUQntUKkNjp+/acPh6M1
         nnoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770231922; x=1770836722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzwGZHzRP4UEU2ZnVmONLCtGE+i75cYH0c1sOGrN9zk=;
        b=OeuiKjbyvSsC+LGnZirfM8e4eZuAKhDwxTdwOQSTNwLjbl/1ISFyQAv8I8aPt6w4la
         lld6B39YyhH7Us6rHfqXOXtbrt1wTCjBO1y/6mPQZ6m1NzhJR+Px6KHLb6fS14FO/GCb
         9yNYAdUncyxVAk0WZRIM4HkB0nQvwqPY0jTvYunORi0PFXJRm+NmyaLkYC88xsktM0US
         vyg7H926z2kDAVo4lybni+wesNUhFvOBlvo4HUj0I1KaYTKX3cpXod0LGsuo97c4848J
         Cqrddy0epK6RC9QwnVBO7POtS3E42pTaibiFzpLnpD6xJnaMW4N14yei8vatuIC86UW9
         QLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770231922; x=1770836722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MzwGZHzRP4UEU2ZnVmONLCtGE+i75cYH0c1sOGrN9zk=;
        b=hSl83fI31W9PI3W62Oc1blYcrOBytjOX99E0XneJl6AC/GN9M1pizUXW7mmBi0kBZ5
         uQGZAi5MCP1LZvzaZNyeOxFbrK+2E0/zgWHYpTFdzOoK/m+DwLFHJ8NI3NuZRJymMYKL
         2f+vmVPwNYeDQCDOyc/A7w6TQ5JNFEln8KXt3C1itT43qD0Or/w3jYjkHsjz3q1Aj+v5
         /mAdjKePva4h2vnk6MsBxsGVcXKCWwR/aTSxc7qRC7xsHKWf4vFY+TeVsB9VqHIfjIXZ
         u8Q3xYr/i1EnIby0MhqBKwRFdTyQyu8kbL4JF8gpib3t+aC075doXzil2pk6DpBp2N0L
         YiJw==
X-Forwarded-Encrypted: i=1; AJvYcCUXK+EG+gbnrqaOvC9MZev6qv7zMult894XiCx/kff0mKtfkEM1hF1Z0PVs+BW04TyZchc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlUnVicS2HB79HcqZElH/aGuyVbuifg8hCPOq8YOoR5lRQ06z
	/XZp6JHBXNX02yVYdbv7iukRGafaqS9Nz/4mTABhC4ArdEPr24ZT37saP6uw228XTZXi0/nSRZg
	nMw4JVUmCwNrKUQAIFIThCJDFNfN2i1o=
X-Gm-Gg: AZuq6aJ+aaUD27PrTfCA+1TGaHEdY1usrU+KVzxo9IuMDrOQ7JUDrIGFmcBY5EzlFZk
	y/LAiF9ffiuHvvXfWNd9Em9Ex9pVD+nQysf4usyZ7l7zCeVdxVXGhNK5b0+p+f5QdI5cUdcVkEC
	KxV5ceCWOY9f0610fjF3OdZMukDPSj2Qun5dbTNhisybQ+gdbapeJwBAOINoFTJ/dBKjA2sbuQB
	DhVAuDvei1NW/yC4M7ISnGMo2hAcV1ARiSz2xfWpza9oG3sKa0Cye50uje5tsiMEhmAbyeQPps5
	OHXbVaoRnSL7uDYAAcWKeA==
X-Received: by 2002:a17:90b:2f90:b0:352:f2a6:334 with SMTP id
 98e67ed59e1d1-35487102a6bmr3735022a91.16.1770231921980; Wed, 04 Feb 2026
 11:05:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <20260203093819.2105105-8-jolsa@kernel.org>
In-Reply-To: <20260203093819.2105105-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:05:09 -0800
X-Gm-Features: AZwV_QgaQpMZ0tpIpyAEJ87GlKt-GPSr2xmV-LTtnAWWeELD4WudclagqaBx5gg
Message-ID: <CAEf4BzYsE3W8QvtKBOZZWGudFjXJ-_szUZOejT-Ab5v72Sei+A@mail.gmail.com>
Subject: Re: [RFC bpf-next 07/12] bpf: Add support to create tracing multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, Menglong Dong <menglong8.dong@gmail.com>, 
	Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 1:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new link to allow to attach program to multiple function
> BTF IDs. The link is represented by struct bpf_tracing_multi_link.
>
> To configure the link, new fields are added to bpf_attr::link_create
> to pass array of BTF IDs;
>
>   struct {
>       __aligned_u64   btf_ids;        /* addresses to attach */
>       __u32           btf_ids_cnt;    /* addresses count */

cookies suspiciously missing?

>   } tracing_multi;
>
> Each BTF ID represents function (BTF_KIND_FUNC) that the link will
> attach bpf program to.
>
> We use previously added bpf_trampoline_multi_attach/detach functions
> to attach/detach the link.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/trace_events.h   |   6 ++
>  include/uapi/linux/bpf.h       |   5 ++
>  kernel/bpf/syscall.c           |   2 +
>  kernel/trace/bpf_trace.c       | 105 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |   5 ++
>  5 files changed, 123 insertions(+)
>

[...]

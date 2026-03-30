Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC737473A
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913673; cv=pass; b=Yw7NVh6dHFg6rEUJfF6UoNwk65YQtkDQVit4ZevcKWqZ2LB631jsVfKn97BXVvao5gM8FpXgT25w3RP6bIm99JYtjScCtQqHtm4orM4E2vZ2nBrUiuX4I49DId5mhtFFAnGrSt7YR4AvudZIGk2m5y36YlpbHqJwMTp34UkuXH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913673; c=relaxed/simple;
	bh=SAxEy06W79JCO+w30VQ9h+UQIYphNKdH/jmUTdyMNYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hjy5lfFEC8Aczzo7UZSSAA5Jf1Weg+gLiJU61s98IXUrOeA8dab7VIM1bN6VB6VrtRSPUYGOE4npl4VHGhCgBcWfK0ilFY3p8h99anC9dDTS863JiXU6FS8kTfWmdqID1IXHQGUSv4K3NVbg+UDfzxcdgrmZRSLW5LF2FRQn6f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXDu05TI; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXDu05TI"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35c206f0481so4692985a91.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774913671; cv=none;
        d=google.com; s=arc-20240605;
        b=PZWiyKCvgvfNC3pQDsM5wXRigvtKDg/2MGt8e7fBRR6zuFQYV+S5R6ZAuf49EqC3Zp
         ZPagg7Tto43MaC0VDycIwXH0P2ulq0CUydiGdQED5v4blERheV1A7dH1Mwdmlqvif//4
         ufxXzNRyCjKphxVOgcDH2M/Z7rrhmepviga4oOQX2Ge+LnllO1jLAOavd8Fpp5WDtnAP
         naTRKuHrCAXNaXLG519puUuwC0K6awhQYbztXwmb2i11DLC2X3U00fXqI/F9s6ZtN17/
         cSAqSbgqXhBPZAj2RRwxa3r5WNqN8ZrQ2TKBxMI34AQRrx7vBCQD3V56E3dvXbbTDp9l
         LghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGgiEQ8kG2HNSxXMJq9igh0u05YCeWn6JpGjYKbMaiQ=;
        fh=3JFULSt81QhP9ARgOVVWpn+UY1r04WcyvJhNnAO9JVY=;
        b=KoDMaCt/fOKupad7uQTr51SrKgY+ostCP+qcdo+IXEBnbsCQYkovpgjXiXtj//hlch
         R9iHWjdbLty1Cia3Z88BGL+eYhAc2AVZanyIyQ02uUvgVBAqAf/bwfNFbz6vNZpiwsH5
         Rc7DBmbbM2tlYBsyyTa9TVL8+hSEgbYfSmr4p2LTcCBq6fFg1ioJUB0gfqm3Z7EXNREa
         oFtKQlfoJ289oExNoaoNpYgU4YZJ8Aym4KU4yxR8G8o6YuYBKpzuZZRb04cWPjY7Dzw7
         Om0HoxwygnORI8Qys4SvY7aKBCsB4xBbuVi9yGsuqXyQpvFig3hU13pjNjoyZ6HDFqC/
         k7gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774913671; x=1775518471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGgiEQ8kG2HNSxXMJq9igh0u05YCeWn6JpGjYKbMaiQ=;
        b=VXDu05TIEqQaM1Zmn/7GCI9XapATcjhN6KoJmpJ/hNyecgqijvno/amauUQ9ci7zas
         aIRmFUwMgf7dC6ur0PcTinQu3jO4Qqe642z3rWvqOKMc3n/APy8B0KnOE9W4qKXI19H+
         Fi8UQIIC1k0JlXklcXb69J4FhNQ9QGiikwcw0S+CAxZrFPEQyQcA8n6nAHBEvE/xRQcr
         R223PX01l2sWGaG5FjwfwXkWsCuFYjr80TFX9Crg2FjU+xGk5KASU/ZXdYoTW3WZ+Lw+
         ik6LC8hOoHpWVBw0KndFYY7JsiwTZe1Oz4OVNgvVbTDG7X8XBrzpcXiCT1JBdUh8yMU5
         jXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774913671; x=1775518471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGgiEQ8kG2HNSxXMJq9igh0u05YCeWn6JpGjYKbMaiQ=;
        b=fiN+pzGMJ4WUXsk6fSoHaORGLsDQv29g6KK2gsq7E/Z+kZpiyKYcN5ggngMqTk+Swx
         wcKDebr78YlPu8O86S9dgC+cVFCrDG55ruF3Gz2t0WpQs2gXMsEnrpL7Jq7rl0+MO+mx
         uV74z8TWuSXH+4HB0aT71TnYj+HzNqOlMTUj1u9R7InEb8dlu6NUfNFELi/3u3OrQNPY
         Ls+f9ZCZXiiEXgwWuEQBGL9+WQPvbzJ9ndhT+NmJlOV5IdTT9EFIDbrGlPvA1X6wRDo3
         xIvsKxX3lfa7WXX9t5vh0S+clP8gbfcjoyciYSm/xPzTDXrUeotNAOkqRkOH4QFgs2Xv
         LmJg==
X-Gm-Message-State: AOJu0Yy9jqhsfWPSuolnW3CQP17u9an2/gWX8rOGVtC11zVDpg9fkymU
	pAPqnr0bzu09KKBW0BiHkZIbQpS0frMTXe4nC/BsXIOdZ3idqA/CjUxHdWU80R7rvprE2lmJM28
	3maoE+J/EHxzcnHCSUnmTDfiLC8Al1f8=
X-Gm-Gg: ATEYQzxwKwc7kwxWdocYdVFwa6AS2nSUdnJXUIGvVwByxBJa1xHUgRiJghVkcY5n0E9
	SI/3vO10z4xc4YSUjDBraUk8eaf85k3+H1t+/QRMVqQDwiJwxSil+GuOxhUsgXE9VLl01XMhX8Q
	tBUUv5ORrMQja/dKnEj6BG+7bWrna6sbrmSSjy4SUdorguMtQVJuep7XhVAIAXOeQ5Xre7NadwC
	I29yf1JR8LJqob16dFSyMXapgbQ4YEQIlnomKv7leNUQtn9BOGuWTfkSg6OUeuDktg39n9e6AlK
	onSbljesrE1A6YSRoKjW74s=
X-Received: by 2002:a17:902:cf0b:b0:2b0:708f:4dd7 with SMTP id
 d9443c01a7336-2b0cdcdd018mr141278155ad.38.1774913670938; Mon, 30 Mar 2026
 16:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326151111.4002475-1-puranjay@kernel.org> <20260326151111.4002475-4-puranjay@kernel.org>
In-Reply-To: <20260326151111.4002475-4-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Mar 2026 16:34:19 -0700
X-Gm-Features: AQROBzCZXxK7bLebpcvBqJ03lSi5EPexlCRQwy43dliPS2HjOlSyHNc1CtlW2Kk
Message-ID: <CAEf4BzYePQkvwxt7UaFbFivaTg+K07LRNg0_Hkvgmt_oFPJ4xQ@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf v5 3/3] bpf: return VMA snapshot from task_vma iterator
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 8:11=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Holding the per-VMA lock across the BPF program body creates a lock
> ordering problem when helpers acquire locks that depend on mmap_lock:
>
>   vm_lock -> i_rwsem -> mmap_lock -> vm_lock
>
> Snapshot the VMA under the per-VMA lock in _next() via memcpy(), then
> drop the lock before returning. The BPF program accesses only the
> snapshot.
>
> The verifier only trusts vm_mm and vm_file pointers (see
> BTF_TYPE_SAFE_TRUSTED_OR_NULL in verifier.c). vm_file is reference-
> counted with get_file() under the lock and released via fput() on the
> next iteration or in _destroy(). vm_mm is already correct because
> lock_vma_under_rcu() verifies vma->vm_mm =3D=3D mm. All other pointers
> are left as-is by memcpy() since the verifier treats them as untrusted.
>
> Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs"=
)
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/task_iter.c | 42 ++++++++++++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 12 deletions(-)
>

looks nice and clean
Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

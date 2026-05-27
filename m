Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CB3DD50F
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877853; cv=none; b=nmIrS+36K+ZwEKsu9VsbVEUOWRdOvkiFDeR3bOfIFO+KmPQDtDC63AJnzolCEyVGmFpHlEEq+ExMpcCJoL1u1RZs1H5Xb8MfygdurPRUuADK2YTpuNIgy54vv19WShS+MW8f2145XSvyl/GJxrNikYIj7LoA6jas/TwNERwTXok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877853; c=relaxed/simple;
	bh=B16uzisEYVTt1mKPen1Eb644qOsbfxkQqNJIXJMGZho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lRVvJXppM3NrOlEYK+DDKKcj7LmEphKnvHB8PXc4t/dm5b/Hyt9f1Bai4IKDaSPNTUGDhbzrU55XOf6hFRjAl4DnhV9GRmYO3BmejgYHRrUK6URtV8aXw8/WorCtgkUs15N/VD7IR6RZ8icuRuhfv8BQcmflY56sAZ8mLKGo9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Wnoyjt1m; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Wnoyjt1m"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6886be3d39bso8644535a12.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 03:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779877851; x=1780482651; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I79utP1h0CNYWtTS0jF9Ax99eFp9KB4mFuHXUtB08CM=;
        b=Wnoyjt1mC6HZ2f6ZRI2TIAuHRkjxS3xek4hR6Ggs+s6aOGvvEuSr6ZYjqeKjadcmze
         j/Ls5hw6wWu6oOKqHn0MGGq0Jh1a63FKczjBAi1iYth/qETSrT53f1zPyLncBs58CFsB
         7OI5727/uf6pYd4trnzOIEMaBdDYJaEviZs2WNC9l4Y1l6vM2AmNDBfJ629jX8fCNtej
         TDH4jo2gwU6lqMVtFjcFpPYLCEc5HsNpZfDqtmceYK73C0t4p1EFUg5nM27Lu7RVgrx9
         TtFLXX9K8TfvnMBQIiHy2SMLrvcZxMFRowwIS9Fqvk4l7dqogElmnlsOaxUc80Zbnj2c
         1aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779877851; x=1780482651;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I79utP1h0CNYWtTS0jF9Ax99eFp9KB4mFuHXUtB08CM=;
        b=NLmIrOSHj6ApbfzYK9gzdA//nsg1Pe1Jofw2BPi1IgGUDsvDZHAqXoub0KdWXLoTxg
         +DKvREzscvT2h5n8qDU40RIqNyd9NDff1EOwy/xO0DxFoij+qmKf5B4II1wXYg4ywbQ6
         4euKKtC6+PblK+zJPQ2FmRjaWhC5xSGhDlawGOqTwpDtP+UmKmAqSXR+OoOBPjAIKph7
         f4PJR5vGJx5OeBjESFQJcrraB9qsIBH1MI6Ihj2qzAtoI3QHrsFvZC46CuRqhqv5C8T6
         sx96jTH6CNOo/YCeYkGn4KYr5Ptuo6jrUBWes91ifaZ0R2AKOc+WBh+YDBAiKR9YfLXJ
         Ke3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+oblKsq6A1lgzxYYftKNKL81cOtqWsC6Y2UTj0ijPqKllSjdaS/M1gpSNziz45IsQHUOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlWH71vGrRHoGWz5px7+Ghnh3+D2bSDvTMGBKJZVfWWGJ8QW+o
	IdWfvI7WGoja0XuFdRWzmq9ZSV07bbS63PUk/vpVtjlyCCqvEXfNxBAQUY20j0no77Y=
X-Gm-Gg: Acq92OGKBGta+XlHQPeSaAaUb42hfvOgu7OZdJm7kw6HpmVgm7092hRF6Yd04odkujZ
	VjuoQuMCMZi7jREl1JAxu31TmniLcZULHfCXs4+hl+2E5YkoK9urDeH5A/qQTs8qxYFICNQvS2Q
	a43MoSernAjY135zJAgAuAcwPXTIC+iHuVfxe0odRCUYtTwvs/s0QkL30F6LbAoSaCKUZVLjKMH
	SyMWLtQzgGcVpyAExvcmonz4tu+ic/+RfUIvD4Y22KIT/kznbeVPQJj58qmjAlCNG4DQjpR1WcN
	ddkS5YOR6OXLT19YrM8mzBK0mK6t1TG7BHOaGfE6dGzFvwB7phCgnVFkVI+lJsvk88r5x9GYb+6
	Xb+ehhLhXGVy752Ec899SONhxEJyfFgyc97Q7PH/92WRkHRUOwNPdczuexH6kZgM2UrykSqaoMB
	DxI4Aaskf0u+xle5mFRbWVzZEJ/MiKXyXnIl2N
X-Received: by 2002:a05:6402:4029:b0:687:50d3:d9d7 with SMTP id 4fb4d7f45d1cf-6889c432e3dmr11086372a12.4.1779877850730;
        Wed, 27 May 2026 03:30:50 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68a6fa2a017sm623876a12.0.2026.05.27.03.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 03:30:49 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  bpf@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 09/13] selftests/bpf: Change uprobe syscall tests to
 use nop10
In-Reply-To: <20260526205840.173790-10-jolsa@kernel.org> (Jiri Olsa's message
	of "Tue, 26 May 2026 22:58:36 +0200")
References: <20260526205840.173790-1-jolsa@kernel.org>
	<20260526205840.173790-10-jolsa@kernel.org>
Date: Wed, 27 May 2026 12:30:47 +0200
Message-ID: <8733zd6t60.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 26, 2026 at 10:58 PM +02, Jiri Olsa wrote:
> Optimized uprobes are now on top of 10-bytes nop instructions,
> reflect that in existing tests.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

[...]

> @@ -430,9 +432,11 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
>  
>  static void check_detach(void *addr, void *tramp)
>  {
> +	static const char nop10_prefix[] = { 0x66, 0x2e, 0x0f, 0x1f, 0x84 };
> +
>  	/* [uprobes_trampoline] stays after detach */
>  	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> -	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
> +	ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix");
>  }
>  
>  static void check(struct uprobe_syscall_executed *skel, struct bpf_link *link,

Nit: You could just do `memcmp(addr, nop10, 5)` to match the prefix.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

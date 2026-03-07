Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D728B7EA
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844999; cv=pass; b=mNo9vvB9R0ubGmF410pYHaBxslDPxZD46oS7AtvjlKvt9y1dugrdNkfkrVbW74j4TtNMBzEfCtzIiBxD1wchlEEFhy8PREFzeICnAPkSfkO/cQ9lhUTOHa2xgjJCkToEUTnTbzovSwhE+oZcLWa0U4GuEuZZUwHdMb/GXu5KLhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844999; c=relaxed/simple;
	bh=+8GRz2caGy548arIAyzhC11nVwUrHyX0e2MeopJ2r7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrBdDgQO0wUGJTMbZrYqkIq+8O+h12sVh1CapScOjUYAOS47lFDR3mF4mUyjb4Tu+hYXFfocBX8Br430wOkTw4s57Q6npAD2/Lw7PaZvpKX4A0xuazNIGB7HqsWLiYL/usZsnc5zUfKoHj3Enlf3B4gz4N+ph+2VLVurCVPeNlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCYE6epZ; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCYE6epZ"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so321145e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 16:56:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772844996; cv=none;
        d=google.com; s=arc-20240605;
        b=AxBeFDbLlvjHuC8xm5blHiPXuX5xIZjyQ+t3DmlU7SPLSIcwvFU2VEJno+uL40sOwv
         Vax5x4hJLNSWi7L/ak7ERzK7MmTgl35q2xqDngKg0utSHsOTDgVuAYqLDOFJEem3FyoL
         JMruByjuFm6A38jZ9HZJNvubDdN3EWCS4rZGX1CoWaPjcNn5j1bgvGsBvNVQUew3eq/i
         ivX7zM5WAi6VO+C02YkU3x9gKI9le8F6BKhDpexBhYpL8T99MezMd6G7jvsWf/2fyqfN
         IX1GL7yiVfl0t/1fJmf+fCW7DH6HnApoUzEznLfeYUd+iW7gHq3YzxH1Qz4SfuWjEx0O
         68rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A/0/2al2xO9sbeA/Xr4TJ0UiGgGkfc9xsAxGMQTLP5U=;
        fh=ePucOlSpCAVQAbf7RgBML1Uc9jYEHmjXtvjiuCLfkgA=;
        b=RYkYsuxw0hO902GuXLUJmdIog8gl5FKnOoBZCN2kft9TVLr0RNqjlhrS1BJ2y39lhU
         1loDwpHQRjfWufDAYpODW25zg6XTVoXr2EaXiDaIpQHuaffzub8O2G/Tn/OnjjWa5h4t
         s8lNFHyUZiepOJwxY0orjM1ZcmyDnYTLZ6JUO6M9DtYAlO5l5BKxSrqzOFm8hwqkH/oG
         5N8NFxuMoAIgIFIAAu0nJO6ZSbi0G9OPfihfMRWuLJpnpaEcX5q1ghGxCkV/NQZx8Ae/
         ys5T4oQB5r5BOqSehZVKNYAgbKJLCG7BxkX09WXl6LgWY1gHgCr8efa50vQtfD7QNgVR
         f/0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772844996; x=1773449796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A/0/2al2xO9sbeA/Xr4TJ0UiGgGkfc9xsAxGMQTLP5U=;
        b=TCYE6epZt006TsJ7NGWGhgbUdfLup+rJ+gCbHfwBBENOpY0/AXdV65UU8VJUyRyBPg
         e8MrOt+Z8T9+X5sclmosigEfLX0YInQw4r1+0pLPx1RgyItyBPjqzvJNpgzbEiuUg63k
         /5yOPAb2URTOt/jmV0brTKHsArl70nBsClU2oXGgWSl4t7Pn3Xhh0XHCcejgn5csBhAB
         nWdTtEj8jaWbjyucPu2iRbKa9yaAPbqIjsCeMSugLIEw3Co6G1cGKR1i8H2nllqal9WX
         FzbMBJZ+5AaPlaw4XxZ8/g070VWNTxcmYYHexhLjJieIa5D7oE8Y4UlbO0yRLGYAJPr5
         bwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772844996; x=1773449796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/0/2al2xO9sbeA/Xr4TJ0UiGgGkfc9xsAxGMQTLP5U=;
        b=BHlU8Tvd6xAydAL6znc+Zfr++u3/72Qt20vOPLgAPTlfXKtRSNfHtfl3w3fOdVgD+q
         xqxNS/6BLcyziILxzNcKCw0eZ7ZJqg89AVznUn+zLz8fOZYlussVUzlSLXH7cAh1I5Eh
         vS5uN5c9/rxXbWNEnEf6rn5mNa8u5bSIcq2WFkHMOqortWwa8W+ISmJBgEgDqYWN7ebY
         yWlp2HmhGWXmUMosJwVfuVQl12oCL9OXUBPCx81j4EhFn6w8Y6XI1OdDI8zMw9bMi3cz
         7oVe/7tpHmR1TJ/xvNIWLTSJnHkamzyvOqouEeZ+mV0+TOiC/HhjDtomGDGR1lDyK25E
         iIpA==
X-Gm-Message-State: AOJu0YwdIchUK2rQDBCQTMeODLHe9OSfdo/eOrv1N+6P/vNGM/iiu7Z+
	wJp0LMqiPcX4fdYDnREnl4qsAB1oU6cXct1/aYzoaxtJ+m0vU2VmmEijIy+4HPBQOWtyzbKBiCY
	ZpdOKXwTZ8jpJoxTKrvFS+I3pdgRzQjA=
X-Gm-Gg: ATEYQzxq8eXpf6IayRJ7edIYbEPKxrH805fsJrWbjZcECQEO2r2JneJazP9LJEqE7gy
	rBRy+ThWeoqU6PzI658XuWCOp/UDJNXi7mJqQqwzRsZiWbpIaDIiN7DbJ1cjNVUZrfMb9QKfUMR
	sQWb6RXPWLTaG/rYUent402oFq6WbRALB9ErtIQQ0e1HUJYACNJdMJeTK6hYavbNaamfixtYtDE
	wO6Qv2+rbwwPEleOJG03yocb3PySsqXE8pDhGsQdDMOf2CmpQph6hvYxnOUnQLJm5i5NTzGV889
	nhGttEqHyibdVfJpanOAAf1g3Xjokr7HQArMq2vqDkyONpCqYZotFOiR304=
X-Received: by 2002:a05:600c:8b5b:b0:480:4ae2:def1 with SMTP id
 5b1f17b1804b1-485269305e5mr64022815e9.13.1772844996325; Fri, 06 Mar 2026
 16:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305084306.283983-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260305084306.283983-1-sun.jian.kdev@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 7 Mar 2026 01:55:59 +0100
X-Gm-Features: AaiRm51cFu-TADM5c_-toVdzeKsQa6GWl6bmDW6GmP601PRDzOkWubzzwpXTou4
Message-ID: <CAP01T74HhFM0NY+DR+d2+CoSZHDCOytubgFqutxNPAxh3+aTJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: perf_link: avoid failures in
 concurrent mode
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Mar 2026 at 09:45, Sun Jian <sun.jian.kdev@gmail.com> wrote:
>
> perf_link creates a system-wide perf event pinned to CPU 0 (pid=-1, cpu=0)
> and also pins the test thread to CPU 0. Under concurrent selftests this
> can lead to cross-test interference and CPU 0 contention, making the test
> flaky.
>
> Create a per-task perf event instead (pid=0, cpu=-1) and drop CPU pinning
> from burn_cpu(). Use barrier() to prevent the burn loop from being
> optimized away. Drop the serial_ prefix so the test can run in parallel.
> Also remove the stale TODO comment.
>
> Tested:
>   ./test_progs -t perf_link -vv
>   ./test_progs -j$(nproc) -t perf_link -vv
>   for i in $(seq 1 50); do ./test_progs -j$(nproc) -t perf_link; done
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---

I tried reproducing the flakiness when removing serial_ prefix without
this patch for a while, but wasn't successful.
That said, the logic makes sense to me, the bit about burn_cpu() being
optimized away can be true, and I think it is an improvement.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]

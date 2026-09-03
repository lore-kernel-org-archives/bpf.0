Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2333E929C
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431297; cv=none; b=HWEF8nrPFDEwCXz5YcC52mjdT9Hkm6hI82eI6RGLgoGQwEJFxvM6KWl8A1htot4UYHNu+hMoOwan1ZUOkdFwciDg71TPrqxPa0YKBAaVJ6EqH5CnS1P47N2XvNDc221bdYSO9AN/20Px7SZ3FakP69sFW4W2p3SsgdB1z5LWoJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431297; c=relaxed/simple;
	bh=R6QiVXyfDnZp7grBLDcfQEBndQb7JG5ApckURY+PZ80=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TG/CUizv4enaJPDCyQSzh3Cp+AAfCO8FS0niWmm7h9azWA9pslx7EXn/Z6kvROuxSjZdrnzey1HOQ+V49HGokTniZa7bMdqKJupFSoJxV7QhGpO9M8j3R3cELCfpBEql4oA9f4rV621DF6eOoeN1yj75txNUUAGg+AXNrafeHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTsobjnF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTsobjnF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971021F000E9;
	Thu,  3 Sep 2026 10:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788431287;
	bh=2PnPwdV3xzo2DTBNx7Xfq6fOPv6g6tCNuhPwaZJO2Wc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RTsobjnFkdFOVwvhk4sk8rKUSUejLytuNc+0gnF89vunOG09pNp5bjuV7ErLHAJfF
	 US2eNJ0ztl85j3gRgMIN2e7s+EZRHMQfqidE0roMnTylisHZOa0cssSOtZm3bpxIEi
	 b7yzRE6hxE2gmXuPeXqq6dwEuLgpa+t/AxEgRyI6WyFO/xPMQcvuptzS/QMTw71DAM
	 TZ5QpO5O2BRVbuICqALfsuLK9GsLgcMl/qBg6NuqUomO1CxxWjN/tXPKnLArCPGFMi
	 XJv5vEkDbJYk2tknP9dCXxmhuMeVjEGutFoe71wR+zXWXnccT+zi9LD62RwNqQHLlw
	 +oEQ/uhYzftkw==
Content-Type: multipart/mixed; boundary="===============3188801726045122680=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <99c8e7294e6461d00086cdbd2ea8f7eeb93a9e36f823d65b1178e88e45b17ffe@mail.kernel.org>
In-Reply-To: <20260903092039.477827-4-jolsa@kernel.org>
References: <20260903092039.477827-4-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 3/3] bpf, x86: Add support for jit dry run
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,rppt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 10:28:06 +0000 (UTC)

--===============3188801726045122680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, x86: Add support for jit dry run
>
> Adding support to run jit code generation in dry_run mode that won't
> store any code and only returns the jir code size.
>
> The dry_run is enabled when __arch_prepare_bpf_trampoline is called
> with rw_image argument as NULL.
>
> It's used in arch_bpf_trampoline_size where it allows to skip the
> image allocation, that gives speed up for tracing_multi attachment.
>
> With current code:
>
>   # ./test_progs -t tracing_multi_bench_attach -v
>   ...
>   serial_test_tracing_multi_bench_attach: found 55227 functions
>   serial_test_tracing_multi_bench_attach: attached in   1.563s
>   serial_test_tracing_multi_bench_attach: detached in   0.256s
>
> With the fix:
>
>   # ./test_progs -t tracing_multi_bench_attach -v
>   ...
>   serial_test_tracing_multi_bench_attach: found 55235 functions
>   serial_test_tracing_multi_bench_attach: attached in   0.798s
>   serial_test_tracing_multi_bench_attach: detached in   0.258s

This isn't a bug, but would it be worth expanding the changelog to note
that the dry run intentionally skips the emit_patch() is_simm32() check
and the trailing WARN_ON_ONCE() overflow check, and why that is safe for
both arch_bpf_trampoline_size() callers?

Also, there's a small typo: "jir code size" should be "jit code size".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33739511576
--===============3188801726045122680==--

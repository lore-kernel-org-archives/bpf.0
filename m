Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D52DFF04
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268273; cv=none; b=UwPQRRdX8hOyxeFWejnsP8up/z0u/rRp+Pg/nxQJjSeQwfB5Ri5gKOP7b+KNvt0gFZaM6mLA+2ZGSr51IK3gSRSjNcsMtvlUPEKma1K8uOYLXFg9ZlmCJk4OY/Shs0PKs8iL6LAcigKgJQ3C9nEyLRu/oNsCQ407b99UuWkn8so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268273; c=relaxed/simple;
	bh=wpp8uuDtTu4/aDkphwV5Osyyga5qI5NVNjKOJkXsUZA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JPdHZwZlOp/DAcTkMHSZ6r11LMAc/M8wJS586eLTyZfgO/3fjDZ6StxJXCr6vrqncAvY/YbXu4X0tYUR+ojMgpL7fNmPbg9jUYtm5Yxdi5igeFa2bZZ9r+PdSYnHoNbxeALKlw3vHmKGEsrZAdJE8rskvTMaYzSyK7uxTdaOxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHhLyWhi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHhLyWhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C678BC4CEF7;
	Wed, 11 Mar 2026 22:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773268273;
	bh=wpp8uuDtTu4/aDkphwV5Osyyga5qI5NVNjKOJkXsUZA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=LHhLyWhiTbM/NBKU1FjTR0zK8vQuhDTtiABdMLbuWgycVU0K6IlxHxdOs2UmSTEzS
	 rShRxry+rzY9XTlQ8s26gF9YNohIkJ2b5h16Fztr65pzXhoJK4hIomUMIGmQcVB35o
	 6Wh9XDJSXlU9VZiM7NoNA6cSLRtbGaKdvQT6Bp1k7qdKUnNCdpL/WWDAfgCcbmWgir
	 rT+1wqnlhyGLjz0dYY7qlCaZ91mrL0LULkSXwh1cwSSRh5bxqXw49RN3PN1prfNX6j
	 Lf8GYbiVXhJtXKyaaXlXLeHuxg0EwrY1rLVwnONdD1rjt9l37jWuM3SWM746OFZE9h
	 5CHGbge+4SRxg==
Message-ID: <17f99931-1ea1-4940-8810-0a101d6cef81@kernel.org>
Date: Wed, 11 Mar 2026 22:31:08 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v3] bpftool: Enable aarch64 ISA extensions for
 JIT disassembly
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com,
 Yonghong Song <yonghong.song@linux.dev>, Leon Hwang <leon.hwang@linux.dev>
References: <20260311222608.521549-1-puranjay@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260311222608.521549-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-03-11 15:26 UTC-0700 ~ Puranjay Mohan <puranjay@kernel.org>
> The LLVM disassembler needs ISA extension features enabled to correctly
> decode instructions from those extensions. On aarch64, without these
> features, instructions like LSE atomics (e.g. ldaddal) are silently
> decoded as incorrect instructions and disassembly is truncated.
> 
> Use LLVMCreateDisasmCPUFeatures() with "+all" features for aarch64
> targets so that the disassembler can handle any instruction the kernel
> JIT might emit.
> 
> Before:
> 
> int bench_trigger_uprobe(void * ctx):
> bpf_prog_538c6a43d1c6b84c_bench_trigger_uprobe:
> ; int cpu = bpf_get_smp_processor_id();
>    0:   mov     x9, x30
>    4:   nop
>    8:   stp     x29, x30, [sp, #-16]!
>    c:   mov     x29, sp
>   10:   stp     xzr, x26, [sp, #-16]!
>   14:   mov     x26, sp
>   18:   mrs     x10, SP_EL0
>   1c:   ldr     w7, [x10, #16]
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>   20:   and     w7, w7, #0xff
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>   24:   lsl     x7, x7, #7
>   28:   mov     x0, #-281474976710656
>   2c:   movk    x0, #32768, lsl #32
>   30:   movk    x0, #35407, lsl #16
>   34:   add     x0, x0, x7
>   38:   mov     x1, #1
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>   3c:   mov     x1, #1
> 
> After:
> 
> int bench_trigger_uprobe(void * ctx):
> bpf_prog_538c6a43d1c6b84c_bench_trigger_uprobe:
> ; int cpu = bpf_get_smp_processor_id();
>    0:   mov     x9, x30
>    4:   nop
>    8:   stp     x29, x30, [sp, #-16]!
>    c:   mov     x29, sp
>   10:   stp     xzr, x26, [sp, #-16]!
>   14:   mov     x26, sp
>   18:   mrs     x10, SP_EL0
>   1c:   ldr     w7, [x10, #16]
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>   20:   and     w7, w7, #0xff
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>   24:   lsl     x7, x7, #7
>   28:   mov     x0, #-281474976710656
>   2c:   movk    x0, #32768, lsl #32
>   30:   movk    x0, #35407, lsl #16
>   34:   add     x0, x0, x7
>   38:   mov     x1, #1
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>   3c:   ldaddal x1, x1, [x0]
> ; return 0;
>   40:   mov     w7, #0
>   44:   ldp     xzr, x26, [sp], #16
>   48:   ldp     x29, x30, [sp], #16
>   4c:   mov     x0, x7
>   50:   ret
>   54:   nop
>   58:   ldr     x10, #8
>   5c:   br      x10
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Acked-by: Leon Hwang <leon.hwang@linux.dev>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you!

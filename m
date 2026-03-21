Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142929DB9A
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774131916; cv=none; b=Had1Krdk/KH+PulnvJFsirUnDuuYJ6ie/R+SFturAQ8SwZDPoU1tC4A7p4V9QR8yF7btCnw5HvMYy06IEuWAwLhrQkeI53b2lOELCSpXxRIPEk8z1wOjSp6zGK5lm2UsM2jiTcPxBFSTZdOwJzpgKZrz6L36M7XE1zwPDJITXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774131916; c=relaxed/simple;
	bh=sInpjiLLZTOzCcfhSuqf3JokDHCs2JpOjeu9J1hYlRA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=s6GvS1RgCxD2Lz4GDjvToQ7o6uuFDo3OdZ0N9fHHRL2R9JfKf58lRmiaFEK7DcD3pNArofugyg6BaAmbH2KD1YxVP1hcbCZYvambbuLtxF4vPTHN8ycjzoh7K1161otUoHIvTWswsBrVozJOAdykuwQcXl+J0LkWY88rviZ9sv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=VRV7MFfJ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="VRV7MFfJ"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89c5340fed0so32598936d6.0
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 15:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1774131914; x=1774736714; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOHeDiWZc+Ts5dDNWiNBJ6LXTX+EzKNXWWZfywhcOxo=;
        b=VRV7MFfJ/pou4ZYAwoKrETQSjz+c2tJAUvlFKleBIFi34mQ8JXbexAAe6NSJ63Mkru
         OJM09cPZ0K5fJcCtQuEUqbEPZ0d3uKhpuEopXbyl8JreccBYFFVreqFKO8JtsLcRUOzK
         Fr7dyMw0hto/QZMyhX1UXRGFI3ia5N+ikLHuGHmnaeZujO5gwQqHRnNYQbFzyh2KCRhm
         1SUnBpkvAcASfCko1V97upNR3Vpk/mZtP9okBzg7M1uSmVsGqJSD2ijHGm/LiQJtKkjJ
         mN/X1FoSWLYcIG/dyOl6+3I6KrtkJ3RQuQg+cQSLwnwSG4Zv+KS8mZGPsAUNioJW97ld
         UL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774131914; x=1774736714;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOHeDiWZc+Ts5dDNWiNBJ6LXTX+EzKNXWWZfywhcOxo=;
        b=otSwbB4qtj7UkDU69HroGBUVv7VqttHa1a6rM1Xn5tBvm/0oJ6C1tXBuMBVO3ni8Ck
         MsFEOwnfj1/eBnizoXI/IUPBUmgZ2VMmRRUdw6K+X4EA1mafCdzkOOqs2Mml3rYPJzyB
         NeOXz/XFBTgqdZI9L0jf0QBaEjaA/6NId57MCaNMkSCmhtQIc4w+pv8ly9seqXIL8qsD
         BwGwck5YYW4zIHKlj8NaLhscJHJGxI+yjIpDIpmm0XLvQCAECtC/N5QYlZ6vQbrnMo7/
         9ZUG5A2wPaWwj8CeMihoG7/E3TMFIkPVQH5Yiw+DFyTtaaC0wAw6thts912S9JkrflWo
         grhg==
X-Forwarded-Encrypted: i=1; AJvYcCUs76AVSwbPwXbzYudliZOswzMlCDLjceb5uYPg8fN+oB2m6z/dP3/gXg3x19J5nR9c2qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvjvM8D0bAIiCor3JZS+3m6c3x/dVHlMe5r+IwaI189Fh6rfEz
	4z90+/N/EtJEnvcs4yUk5ujQkIwjrjowoprZXBy7cA9uP65RNYUXfYDlIG9p002lO1c=
X-Gm-Gg: ATEYQzyjdhkktve2xNxayHJPnj8Ys2gvbnSr91ofVopd1OSAh57++y7tX5raFITZyJl
	GjjMUYM7j6/HzDtRnaLi8YZhjCNrV6s8G79nHR1X3iz2A28yLYkV5XCLCMrAJKNq9tmSINAXFRG
	62UYMB0xeOa7gp4ug1uqb66A+oIkbp1v8fDsDx3bGp1XEKV72+WZSQmxqzu26CZH4OwUZRU8StO
	M1hm0P1pMKb0p9xnQzpCzEgeGKURTHshCLSbft4YIMao0wE+1rxbw74d7rIJ4Rsvm2R+XHEap5K
	P5eO6gAFfdr1e5yxfqS5KfErkHuce0n6rhZVHqLB93SXsArF4ukYAOPTJHHHYFJeHE1kKA0dpJ9
	CDyzrCj3bC6B8IC6xo+HJSpVFS+B4faBmRJNZTya2huwkrtDnWvcCjSrAL5YX9/p1GeKvEkm9z6
	NnHCPTAZ6tmLO45ZL6zols8SY=
X-Received: by 2002:ad4:5ccd:0:b0:89c:7ba7:c081 with SMTP id 6a1803df08f44-89c854f13e0mr117238946d6.25.1774131913538;
        Sat, 21 Mar 2026 15:25:13 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85251e32sm52455116d6.16.2026.03.21.15.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 15:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 18:25:11 -0400
Message-Id: <DH8T9WRPSRPY.264HCXDHAQT23@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Puranjay Mohan" <puranjay12@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>,
 "Quentin Monnet" <qmo@kernel.org>, <kernel-team@meta.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Leon Hwang" <leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v4] bpftool: Enable aarch64 ISA extensions for
 JIT disassembly
X-Mailer: aerc 0.20.1
References: <20260318172259.2882792-1-puranjay@kernel.org>
In-Reply-To: <20260318172259.2882792-1-puranjay@kernel.org>

On Wed Mar 18, 2026 at 1:22 PM EDT, Puranjay Mohan wrote:
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
> ; int cpu =3D bpf_get_smp_processor_id();
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
> ; int cpu =3D bpf_get_smp_processor_id();
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
> Acked-by: Quentin Monnet <qmo@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
> Changelog:
> v3: https://lore.kernel.org/all/20260311222608.521549-1-puranjay@kernel.o=
rg/
> Changes in v4:
> - Add acked by Quentin
> - Rebased on bpf-next/master
> v2: https://lore.kernel.org/all/20260310223456.1706712-1-puranjay@kernel.=
org/
> Chnages in v3:
> - Fix bug in usage of strncmp() (AI)
> v1: https://lore.kernel.org/all/20260306163906.2870529-1-puranjay@kernel.=
org/
> Changes in v2:
> - Fix coding style issue (Quentin)
> - Use strncmp() in place of strstr() for detecting aarch64 in triple. (Qu=
entin)
> ---
>  tools/bpf/bpftool/jit_disasm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disas=
m.c
> index 8895b4e1f690..04541155e9cc 100644
> --- a/tools/bpf/bpftool/jit_disasm.c
> +++ b/tools/bpf/bpftool/jit_disasm.c
> @@ -93,7 +93,16 @@ init_context(disasm_ctx_t *ctx, const char *arch,
>  		p_err("Failed to retrieve triple");
>  		return -1;
>  	}
> -	*ctx =3D LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback=
);
> +
> +	/*
> +	 * Enable all aarch64 ISA extensions so the disassembler can handle any
> +	 * instruction the kernel JIT might emit (e.g. ARM64 LSE atomics).
> +	 */
> +	if (!strncmp(triple, "aarch64", 7))
> +		*ctx =3D LLVMCreateDisasmCPUFeatures(triple, "", "+all", NULL, 0, NULL=
,
> +						   symbol_lookup_callback);
> +	else
> +		*ctx =3D LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callbac=
k);

Question: Are there advantages to special casing aarch64? Shouldn't this
be a no-op for other architectures where it seems the JIT doesn't emit any
feature-dependent instructions?

>  	LLVMDisposeMessage(triple);
> =20
>  	if (!*ctx) {
>
> base-commit: 77378dabb50f593c756d393d8eacb0b91b758863


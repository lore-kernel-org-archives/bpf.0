Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69A4ADDA9
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734828; cv=none; b=HZectkMNnpA9m+B8FkXcbezAVPJ0Lm0RKtAPOfZjcGWutCSCC009PhetSLI2bU6PARNm2HyPQ/NfuwXjh2PtDn+/LJmSFeeZgB7rkBarh0vBulqa+42lWCmKuf0f069z7v0p9AxvaqTlbiptMxZxILGP8T0/PzIJRjHImegtT4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734828; c=relaxed/simple;
	bh=e+F+dz7Vrd/NGRB76Hc1hxy6p+za7UBrVqp+7mia+u8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHNfrEQYcIEdYl8r17xlmYNid6Gm9y1d2ZlpRNzgnbEYRvdkqypR5oacVW37OIJ/4DsjFTuic8y/sscXPQw6RRnZ5qZd/P9dUCoZPMfvHKmqcms/Y2zuHNE8JlrJC69NY6tLdwYWhVxDxLzp43/kGp27P4jbaWXt6az2Uf70AuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMPRUNkY; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMPRUNkY"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbedf433a99so1261758a12.2
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734824; x=1787339624; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OPiMr7zjTaHIEwhTowE7X+rM4xtbxseCHAGSiq8mAZ0=;
        b=GMPRUNkYCJhxjtiAecgL27jmQ3Gn9HjecoyuhybCL1rzbRldPTXzJKQAoydk0Vejzz
         3+sXXmWqvFJvOAIly6t0/arQb9U0gYkj1rkoTomH6/LLnEgS2RfPc4C++E0hbHOAo/mE
         lbGCAG3xb6vS4F/Hxtq7fRQi/n7GFJIt+PaxaD5DSc8VtHbOhySwX1l3Uzan6UZ1Xrcz
         OujvlLYDpMXND1TunVx9e8KTaK9CoZF4Jpdp8iQAqYi6cV8CAm9xWN5lbG9L7dHhSHVm
         c69DTcEoYZBq8JHKlFIKxvvkcAHQd+Vuw5KF4fc8fIhpl/1PnbbxfnJ1utSmx21QlVqi
         mzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734824; x=1787339624;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OPiMr7zjTaHIEwhTowE7X+rM4xtbxseCHAGSiq8mAZ0=;
        b=MlONdHqQEqSdu3W1EDWUYwGgp0TWQSSedwxIysBJGgLiyskBFxdJ1UKd7snDOMFRXF
         Vnmk83Uix+jVRMkSDLgE3ub+Rc/XwlzC4DFOwPHHqY/cXIDV7pNpOw48A29IBn0SuoGH
         hKhiR6Wz2O1iumSLcEECjCaE8lRQqsQAovcvDhJQ34JgaLpAwDcBZeZp0nbBLC97GKxw
         EmtEE8fczsug5R0X/6TXvqUMQt6xX2ZBQY647egtJt84WVYjYl7zz+IG6gSGcx3fKXNP
         OgqtsE9uf+QIzGfn2zaZU2l69v7QXoFQpHxC1F7enPCZsbqyNITIiHa8MYvcUczjloex
         l28g==
X-Forwarded-Encrypted: i=1; AHgh+RoaYQ3knzgZI8F3qXlUmq+F3hwsPc2RYGfNvCIw3m4iD/n5omVjKu2I7neVvN2raLBkRvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmvKbKja0hAF33oBn/SEFdFCs9ckXSKMffWgIJ7xrVQceEgp9H
	pPmaxnIYWRJACtPpqzSRgRBZveFoPlCCSIENTVpkZPjnrUnoAE9hzeuF
X-Gm-Gg: AR+sD12+IhQ6gqW0OqcrO/tOHRhdyelCWvkQmY8dEUtV/XpzNKy+3QW/1C7OeiqcYQt
	gkmXADZ+knZm8uMT8BBDwzuED6vml245zhS499MFsvgDtgQhaDGApdN4PrkDarNBKjhCLaosh2y
	5qexiiuxqickTL20N/d+PCsbHU7BhQAZfZWrUR/n4+qf25sBA+/m1jKNgXVNLnifNJgj9Cxoc/W
	L5XBFu5sv2SAlaGlUAkCdCJ6W9yhJn4lQnAeYfYAKH1tWUAj/GCZmL18YYfn+zuVC6WaI69Tfid
	7yl7WPHijlEAnu3Hus2ZLETk+m597skoPUkbmREnhlMvv05JtK/RizGXfgF6PjyZ/A87VLfw+sx
	+IR/FWjVzu0LYAzOggDwVcizc1bcNyfdtSSQvETpvyEVxTXwgycKXrzOI1JXYyQ9KmIuuVuWH7s
	vUSbDlddfCGDFIyYttW4auto/41SOtA1TI6qr94mE1Xr1sxTs7yEm3hHnNPKfluLTFY93O+V2ix
	xs1b+Vee+o6vPI6I8p9+UD9yi/F52yi+Jlrh5XwKc0d
X-Received: by 2002:a05:6a20:e613:b0:3cc:55ed:dbfa with SMTP id adf61e73a8af0-3cc71cd3ee1mr10223981637.27.1786734823591;
        Fri, 14 Aug 2026 12:13:43 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b77:bdad:4587:c682? ([2620:10d:c090:500::6:84a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320e9df68ccsm7403359eec.14.2026.08.14.12.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:13:43 -0700 (PDT)
Message-ID: <5acb321999d7cc7ebd945c519495a8762501e3cc.camel@gmail.com>
Subject: Re: [PATCH] bpf, x86: Fix per-CPU address resolution into an
 extended register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, x86@kernel.org,
 	stable@vger.kernel.org
Date: Fri, 14 Aug 2026 12:13:41 -0700
In-Reply-To: <20260814165557.3405518-1-vineet.gupta@linux.dev>
References: <20260814165557.3405518-1-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 09:55 -0700, Vineet Gupta wrote:
> The destination of the per-CPU address MOV is encoded in ModRM.reg,
> which is extended by REX.R, but the REX prefix is built with
> add_1mod(), which sets REX.B. REX.B extends ModRM.rm and SIB.base, and
> this instruction addresses memory as disp32 with no base, so the bit
> has no effect at all and the high register bit is simply lost.
>=20
> Every is_ereg() destination therefore resolves to the wrong register,
> picking whichever one shares the low three bits:
>=20
>   R5 -> RAX    R7 -> RBP    R8 -> RSI    R9 -> RDI
>=20
> With BPF_REG_5, whose reg2hex is 0, the emitted
>=20
>   65 49 03 04 25 <off>	add %gs:<off>,%rax
>=20
> adds the per-CPU offset to RAX rather than R8. The destination keeps
> the unadjusted address and RAX is clobbered, so the program goes on to
> dereference a pointer that was never made per-CPU:
>=20
>   BUG: unable to handle page fault for address: 0000607e386a8894
>   RIP: bpf_prog_707837aafd2aa9ae_update_percpu_data+0x93/0xc9
>   Call Trace:
>    __bpf_prog_test_run_raw_tp+0x2dc/0x7d0
>    __flush_smp_call_function_queue+0x1e9/0xc80
>   Kernel panic - not syncing: Fatal exception in interrupt
>=20
> R5 is the mildest of the four, aliasing a scratch register and faulting
> at the store. R7 aliases RBP and would corrupt the frame pointer, R8
> and R9 alias the argument registers.
>=20
> Use add_2mod() so the register goes through REX.R, matching how
> add_2reg() places it in ModRM.reg and how emit_priv_frame_ptr()
> hardcodes 0x4c for the same instruction with R9. Encodings for the
> non-extended registers are unchanged.
>=20
> Problem showed up when trying to resurrect BPF_GCC CI (selftests built
> with BPF_GCC).
>=20
> This has gone unnoticed because clang reloads the address into R1
> before each per-CPU access, so the destination is never an extended
> register. GCC keeps several per-CPU addresses live at once, and
> test_progs-bpf_gcc panics the kernel in global_percpu_data/init, where
> the address of a .percpu variable ends up in R5.
>=20
> Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to r=
esolve per-CPU addrs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d920772af7d5..1a9fb530adc3 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1935,7 +1935,7 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
>  				EMIT_mov(dst_reg, src_reg);
>  #ifdef CONFIG_SMP
>  				/* add <dst>, gs:[<off>] */
> -				EMIT2(0x65, add_1mod(0x48, dst_reg));
> +				EMIT2(0x65, add_2mod(0x48, 0, dst_reg));

Ok, so the argument is that because there is a SIB byte in this
instruction, and the instruction itself is `REX.W + 03 /r | ADD r64, r/m64`=
,
operand #1 ModRM:reg, operand #2 ModRM:r/m, the encoding should adjust
REX.R to extend operand #1, not REX.B as it does now.

I think this is correct. Could you please respin adding an inline
assembly test with __xlated() matcher, to verify that jit operates
correctly?

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

>  				EMIT3(0x03, add_2reg(0x04, 0, dst_reg), 0x25);
>  				EMIT((u32)(unsigned long)&this_cpu_off, 4);
>  #endif

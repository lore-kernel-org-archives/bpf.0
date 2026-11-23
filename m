Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795454911;
	b=Y4aX5qVR/B3bHUoRGvi6bvaipjTP9XumL/78l69nOSbGVse8/OoPjnz1F3F6kQSb0fmT
	 AmlyegkkjD9uUN151D55FJ9v8f5SCRv8QiYB2lyjMi81M19YVHn/zmMn3aCjkYrnyJyRe
	 YwtiW6tvz4qWE2bG8G90J0HgOjBwcfw7OAljQkBfKWud9KT66FO0jhKiTv7PlLMdzQCUp
	 y7p6u/snKf89pQeJ2HKpgO9MB64PwBpPseFWTuWUh9/VryO387nLMAxq5rk4ppEFgu2i2
	 FA+UD84wdyRWgVJ4k+8yUG45xB/989mgozTq6p0AAZHufVNEdzX4YlE7EB7jl5V6www==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=fUTLM5WJXPLNS5+Y8pJq/Dz6CXEKl6FkzhodnqK0iXE=;
	b=qchhXvpMYm9JB5GbVzjqQVfK+i7FV/jCd98Efo8T9F1ez39fez8pbUWuUBlPllVLYAlV
	 64gnhLAIMCE1/52OuAyQkN+g+9LzbZU31bh8vWCfX+Aj9/KRVMVpHdGRxN0PRL3tHjTM+
	 E1ZeF/9rToPdr+RTUy3NlA40mchmV+J/aEeALLca4oHgsu9gA42LugacMFsFMjdExu4WM
	 d0v6kS4J1Nc6D6qKu5IHPgRsjYOTgYgowiiGcMyJVLyW976JKo67ncYOWyOfh4PAiUdJe
	 Vb3KUQ81q4YugeIboHUWm8rz2l3ceqCcnSV6E8aTrMAY/pApdB3Qtgd0gIQCsIvIV9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GS3NKWWJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2429606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 17:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2429606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GS3NKWWJ
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49814d35686so2491315e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 09:28:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795454909; cv=none;
        d=google.com; s=arc-20260327;
        b=Bx3d9X0Dq14/NF0l71ff5LlkGvj2vF24945htK98hsLYPhdS78oD2bcdde0LMNC0N+
         VyXM/twttDF2m8X4JXXzAYmMNFLfOO7+OKUZADxbz7TnjHFGlY6fsZRAHlPcek5maclG
         YtrfVh9p1g+MMse97RuYcwm49mEfpbbEptGLF/MtaQRJuj+5d5uPGJLZLVy1zxl9qsJL
         cel1yoQrH6K8IYBFjHQeTaeFvpaq0QY5sJY+Mlw5U/Hcm0/PY/ji/l5Hk1T3NFKY8Ecf
         SC0IT770VQbWUdqIhAY3c5papHDcaSCGtd6wnygr5UZGx+8Ot3Dz3ZMdYaIDvI7anoxy
         FGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fUTLM5WJXPLNS5+Y8pJq/Dz6CXEKl6FkzhodnqK0iXE=;
        fh=xo8Vf6dBvDJ59GjUOoqXcl8onGgvchEtZ5FGNONPi18=;
        b=IoOy5bcjQvrOkCaSgySw0QEcmKot0t6RFIEDKuEmyTDe1K+4bgX34gJX41mOG/cSvn
         8ieJ/7+w45eSNu/hfY0zBEK2RVZBBH2YmY+ILFdL/dLh2UHhdecSfGvzGfb/6k8SIraI
         Nbq/WbX2EsBjMlKNM38QSt/gL55Joc5ppLcrW9tNB7KFgIGr0g1+Cm7R0ZVMmQEQuCKW
         FTxyO6bFnMt0LuVI5wi0afvredRDVs5JIdCUfxfmturGxvakri9ekdxGch88/rFUw+mt
         2vARy+gCzyaxsQUjMjHgAOsYTaZiGOymDxUDi/9MlQpnlwlTEqL5Gy51HOmiNbXXRMR4
         1a5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795454909; x=1796059709; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUTLM5WJXPLNS5+Y8pJq/Dz6CXEKl6FkzhodnqK0iXE=;
        b=GS3NKWWJfPDqc2UNc3jugC5XbOFW/zp1xuPTPQHkV0RXiniW8Y7TCiM7WhcOdCCwu4
         Xe+O+QxQZafyvI2nRpFVdDor7OAeTXLHwfvYyeXbdilCL4yedPQK56vNiQFeQgthu+M9
         TBUMrVCp82S5ik+t631L0zf0y42b4HK4uOyuPM1yNK9goNVOoSrWb4s1esSU7RBnT9rJ
         Neo3wQpHH3ZstOPxm1aFirdm5AzUyxJyrIZkJZaikLy6IGILAAHRYl2cYayxZn3Gt8kS
         NaGiG2a5bmye+Ki0o30OMVzQKQNpKd4zl2bhZRWj2umHx/jL4yAyU471fE8r2T634cN4
         1rdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795454909; x=1796059709;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fUTLM5WJXPLNS5+Y8pJq/Dz6CXEKl6FkzhodnqK0iXE=;
        b=mTEN+YxvtXGNcUZ8CyvI8w5yDZ5jqN2D4BNbVbsvKQ2m3e/YD9HTsKHsGq3cb9BSs1
         gWcaWGHUtBC++JzS59+vEQBG7FT951OAhnHmCtu2jVyaWIr/B0KsvVtQaVy9Oo/yBW+T
         +5Fn1KKMlL9TNHaFXpim8w+MqFJDAkdzSTpkDH918epys3kv1orfjNWFxMYPtA6PocCt
         WS6l9RGALkKlZFAVUH9oXR8fdX95rJ8pmCxQDCQXZhu2tVMmx0N6/iOSpBFRxQb92ImI
         lvR3mtmgcN2a2r4D7MbNGEIj6yFnWRgmE/rd494br04X/y9P1uSuV8MoxP95sAoW7c6D
         FC9Q==
X-Forwarded-Encrypted: i=1; AL+hErGltyrDbbBXcpzBKomAyTMi004rUMg52ExHt9t1or1oyl+iNMSv1ev72oqVy8PZX27krII=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7uyG569DjbqOP5OrCp3BK1dpr202PeQw/w9sSt7qbeei3cPm7
	8GCvieQqoKLQeXdTrsG/jMHjAXDjWsiS83D5e6u8IhCh4LeY4FGHwBt+ekx1ZaYjz4O6bvrARfC
	ZofhtekInBDSQM8yPF37Q5E9mAyZVCmc=
X-Gm-Gg: AZFdTZcJjJgHydVHuhiaPyOkiTf3udpXQKGbXOH2Zhjfflef66E6C9EuQuU1phDGe2/
	UmwVFsPhE2EOOhKKu6HU9Re1LU0fmQOc3+lN/y32qriNc60ScoOkUsQ5qxsSa9m02obQnNsuqWb
	FGqcPXwyO/hf4kWHty6A2YSbpfGGU886iNTjHY1HUK0lhodv0VOXCWZb6u9ykBDycwFA4pC7euL
	1UadHLofE1CXGaFa7O+Zp4Qy+X/FQN7CtmIIi7oU0uA/rD6F4stH6jtGhOvFrXRNHXdCuEhVjzt
	JUjGpKFnzGxi7sUjhXUA8pAQ+sfsOicrtSGan/9iTqSThACWMFOY10OZmM7vNinRcje4mIesIP0
	YtEV6DIEzNXtOr6Lkv6Pin296SyqxnDyDAc1lQFRPW3FoN7UgM9Ct51ilLvNsDAKoif8u5himPW
	Kvt6SI8uLQ5mYcDCL7oCiYRhjUjK6Q1SvykpKgAuCFmc6D9RLP7rul0Svn5lFaId2FsBa/BgNge
	qb7QXhhoBQ9ig6A
X-Received: by 2002:a05:600c:154c:b0:4bb:6a78:7c42 with SMTP id
 5b1f17b1804b1-4bb887c3428mr259862695e9.1.1795454908811; Mon, 23 Nov 2026
 09:28:28 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009024925.3169077-1-memxor@gmail.com> <20261009024925.3169077-2-memxor@gmail.com>
 <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local> <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
 <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local> <CAP01T746W=8FFiJJUM3H-Qv09uRO6-XEi9B-8pjSgtpAPBx4EA@mail.gmail.com>
 <20261123003036.GCawOJLKK1iX47XTDm@fat_crate.local> <CAP01T77EgbuyhP=zU9L1hwYL6rHaSbrqQZGJR_+9AQgSWLe7Nw@mail.gmail.com>
 <20261123025529.GDawOrIQcDOPhgWwF6@fat_crate.local> <CAP01T75Qps8bKFZAU2gN-3UJTB1aWw46NG5c-sm6K028rSc9sA@mail.gmail.com>
 <DN2E8Q9V38IF.3O738M7NGLSAL@gmail.com>
In-Reply-To: <DN2E8Q9V38IF.3O738M7NGLSAL@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 23 Nov 2026 18:27:50 +0100
X-Gm-Features: Aa3M54oRD3bvjk2K9lSlhPKXQEMcK417pjhjD1KAKu_5tFbn0tvXJL_H-YxjRDE
Message-ID: <CAP01T74K7YG1mfQzKsHA-Qo4WzhFh41Zxs2VZOT7k4DMGPfsFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for
 user address faults under SMAP
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, kkd@meta.com, kernel-team@meta.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 07:58, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Nov 22, 2026 at 07:56 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > On Mon, 23 Nov 2026 at 03:55, Borislav Petkov <bp@alien8.de> wrote:
>
> >> "the only line of defense is for is_bpf_text_address() to really DTRT."
>
> Boris,
> SMAP stays on. The SMAP branch in do_user_addr_fault() runs only with
> AC clear, after the CPU refused the load.
> A wrong answer from is_bpf_text_address() can hide an oops,
> but it cannot expose user memory, so your concerns are unsound.
>
> > In fact, for kernel address faults, we already invoke it for exception
> > handling. This change would simply extend that to user address faults,
> > optionally for BPF code; otherwise, we panic as usual.
>
> Not quite. See:
>
>   fixup_exception(regs)
>     search_exception_tables(regs->ip)
>       search_bpf_extables(ip)
>         bpf_prog_ksym_find(ip)    progs only, no trampolines
>         search_extable(ip)        exact match of the insn
>
> Here is the alternative
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index aa88370..9fe8705 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1263,7 +1263,16 @@ void do_user_addr_fault(struct pt_regs *regs,
>                      !(error_code & X86_PF_USER) &&
>                      !(regs->flags & X86_EFLAGS_AC))) {
>                 /*
> -                * No extable entry here.  This was a kernel access to an
> +                * The CPU refused the access. If the BPF JIT marked this load
> +                * as one that may fault, skip it and zero the destination.
> +                */
> +               if (!user_mode(regs) && !(error_code & X86_PF_WRITE) &&
> +                   ex_get_fixup_type(regs->ip) == EX_TYPE_BPF &&
> +                   fixup_exception(regs, X86_TRAP_PF, error_code, address))
> +                       return;
> +
> +               /*
> +                * No other fixups here.  This was a kernel access to an

I guess this is better in some ways than the is_bpf_text_address()
predicate, since the condition is tighter, and since we rely on the
exception table entry type itself. I am fine with reworking in this
direction if others feel it is better.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573089;
	b=m3ru0hjH83zxCKLG4LtR1bezAsJqYCjKPChwlTrejcF0Tp1C1OLkh15eHscm9X6bRriJ
	 1Te/oukzDC4tfC2xgh5zQ4fwaRlYk9TFmSF/WRbV9WQCpZnqx2J4mauSyp6fTMsc0tIed
	 o1v/sY8Scbhwne5yUzjh2yWnZ2R/cYV/RPLiGIulvZORBMsDIDGdaFMC8jR4Y/N99MoW2
	 DXKNChTGJgpKWaxBHEYXMwSgR7HSzVhgYYQNl63mYTEQHppkNT/SpoH0XS9H95wozaSYD
	 XlCDOpoajrA/i1E6e11cM3zyY1wlywWWjx/7os6sWsrRfKlByKgacTwOOSeDQIPiSLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573089;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5BmiEAABX0YkZtzL3ymjPboNK9Dk3Xskgw0XpD/U9ic=;
	b=4NxbPQzDxCW4WDDYv8Zm2SY+3M+/+NOyC/lD2AjCdsw5pPKa97EonK4URroXd8Eypyvq
	 5hY225jEdn31mrBBg+mxrCGf3C3XChSxMU9c6m/MJKnwcfdJvQZnHPiLepSPpGuud3rGS
	 IquysPiq+wT4xtA7ZfAeZFxezPKHIqikefqZjqxPNyLP/ds8Ase1KyM2cr5J1Mf+Nzmkk
	 TIJz04HFuLCoJ0kHCSSUKI/oawfhJaI4qBO2j2fRb0lJ0VABF2/GcDFvrgVZGnZPhM/Ku
	 uheM4YweGoZ/K2CTm14zCRxEeiyqinCceyY8pOrTuTtDOQsBfjbVyMlu6pAgKDr/Mmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=SZ0zxJnS;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D3D606A31E;
	Wed, 25 Nov 2026 02:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08D3D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=SZ0zxJnS
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9FF9340E01E1;
	Wed, 25 Nov 2026 02:17:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id h4jS9kRgljvp; Wed, 25 Nov 2026 02:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795573075; bh=5BmiEAABX0YkZtzL3ymjPboNK9Dk3Xskgw0XpD/U9ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZ0zxJnSQ2E9IDoOQnutqoDmh1YGpIbtrhm7bo90SpFTCs9Wcqt8uAhHF+Nta9qTx
	 UoQhmJ4LkwoRpI3zFT89TK7JFfxDoGMXqV/roY8bkPUI1uC3dG2uBOwn8dKtn7B97B
	 MaTPUft5Dw+rw1+dtTeYZixRQOhpwbx47ZHpmqXH51gVpgPskatWRiUP2PI8kuIkc+
	 gF9ReAOqzKuIzs7wpjYmbJf9ZT7CH9z4NZ7sCGVqjRm8toJXfWiF3nJqq0J6Ogq3Vf
	 2ukP0MjEsFoiuzQGzlBzRHzOSiXqy/sa0MOqU902b6KDYOAwLAyFdwciK7v8NOm9t+
	 wqTPO2+hwWFo6WFe5VCgbGA+Se36lLIT1eEF49uhBodo4LeSmTFKB2dUE6MCpkEoKE
	 tFO/WrC7h5x9V+5MjmGqAHWhfOFRs7aqMZYnxOTmOUEg44J49lb3PHHJEXLeczqwqU
	 ql6ZeiPY+OP289YMlvPLAvlujGiptxTrvEAUNaLATcxUrgXF4b82xCeAGOvNBRAO+Q
	 R5E4GZniXeS+RAJLn+BQjUa/Hysnd274bdbhfq/VfAuuYIbCc69jDl0mrRjh2DxPl7
	 efo2bbRe2DR5oxlGqDSKJMFBu9Isxot18loVSUJQoDaDr+Q7yGVHlznnt5zw/jrW16
	 i052oh/x/gw31YJKXZ0HksRY=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2106840E0218;
	Wed, 25 Nov 2026 02:17:37 +0000 (UTC)
Date: Tue, 24 Nov 2026 18:17:33 -0800
From: Borislav Petkov <bp@alien8.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	Puranjay Mohan <puranjay@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	kkd@meta.com, kernel-team@meta.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for
 user address faults under SMAP
Message-ID: <20261125021733.GAawZFPYeXUtqNINJ2@fat_crate.local>
References: <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
 <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local>
 <CAP01T746W=8FFiJJUM3H-Qv09uRO6-XEi9B-8pjSgtpAPBx4EA@mail.gmail.com>
 <20261123003036.GCawOJLKK1iX47XTDm@fat_crate.local>
 <CAP01T77EgbuyhP=zU9L1hwYL6rHaSbrqQZGJR_+9AQgSWLe7Nw@mail.gmail.com>
 <20261123025529.GDawOrIQcDOPhgWwF6@fat_crate.local>
 <CAP01T75Qps8bKFZAU2gN-3UJTB1aWw46NG5c-sm6K028rSc9sA@mail.gmail.com>
 <DN2E8Q9V38IF.3O738M7NGLSAL@gmail.com>
 <20261123185124.GAawSLLMoWwJ71nq5j@fat_crate.local>
 <DN386F271FUR.35EWQWGMEMX7K@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DN386F271FUR.35EWQWGMEMX7K@gmail.com>

On Tue, Nov 24, 2026 at 06:25:45AM +0000, Alexei Starovoitov wrote:
> On Mon, Nov 23, 2026 at 10:51 AM Borislav Petkov <bp@alien8.de> wrote:
> > Look here, our mails crossed last night:
> >
> > https://lore.kernel.org/r/20261123043409.GFawPCQT2M-hz0mvZP@fat_crate.local
> 
> hmm. I thought my diff answered it already, but ok. Here the answers spelled out.

That's very much appreciated - much better than telling me that I don't
understand BPF and I should not ask questions.

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

Ok, I see the JIT is marking exception table entries with that in those
arenas.

So if someone would try to exploit this, then something must've jitted
a binary blob just right in order to bypass that complex conditional.

> SMAP stays enabled in that case too.

All I mean is, this is the first scenario where one can bypass it. The
exception fixup thing.

> The fixup doesn't touch CR4.SMAP or AC, and it doesn't retry the load.
> ex_handler_bpf() writes 0 into the destination register and moves regs->ip
> past the load. User memory is not read.  A jump straight to that load with
> a user address in the register gets zero too.  The range check gives the
> same result today: zero and no oops.  My diff has no is_bpf_text_address().
> It checks the type of the extable entry of the faulting insn.

Yes, I guess, even if it were a malicious blob, what ex_handler_bpf() is doing
to it is limited so I guess that's fine-ish. I mean, if the machine is already
loading bpf programs from userspace, the risk is already there.

> The diff has one check, and it's on the type of the extable entry.
> error_context() does the same for #MC with ex_get_fixup_type().
> fixup_exception() has EX_TYPE_BPF already.

Yes, that's a bit better.

> A JITed bpf prog is not a user space program.

I meant, it is a user program which gets loaded and runs in the kernel at
CPL0. We're on the same page.

> It's kernel text in ring 0 with an extable, like a module.  The bar is the
> extable: kernel text, an entry for the faulting insn, and a type that says
> "load from any address, skip it on a fault".  That's an inlined
> get_kernel_nofault(). It isn't specific to bpf.  If you prefer a generic
> type instead of EX_TYPE_BPF, that works for me.  Then get_kernel_nofault()
> can use it too, and copy_from_kernel_nofault_allowed() can drop its user
> address checks under SMAP.

The hurdles are more, which is better. I guess we can try it and see what
catches fire.

Next time, when you decide to touch core arch functionality like the #PF
handler, please include us in the design *early* too so that we can chime in
and check the sanity of such proposals.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

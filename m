Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4A3537CB
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774712172; cv=none; b=N/1eOG36yjfEiwTRR90ewdSYN6jZEZk0lOyCjEja+8w+WB+Pb1oY3sat3bYFPbWaiYTwrZrzEPPGHMg13yb0Zn7CC50XJ//reTQuYyiCVXKmrwZqNsAWqUCdZvS4uhHY54Yw6Gue+AFOnVicl5rbWdfz6HwI/w6Nm0Rb48ehyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774712172; c=relaxed/simple;
	bh=/GEXZkmKX4s9b/SmUpPLX93M0m6mbEsjeCZUiizWuRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i46xRLLcYQsagbTMFam93vaLKW/ffG4RjGcbn7GZDTEPnvZ4TyIZwNR1VMix5AnS418DR+ByZivQDB0W6yRyqg19aGvFQTv778/q7pX1HfsgbJCivn4s2n3u7KpzmaDZPvS7r/+dZJYr6bwAYhaEeWeXmeRDmjsxqzOObqLHW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeceLkWQ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeceLkWQ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38ad26e3992so24413951fa.1
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774712165; x=1775316965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/VNplDWWCZzS7/n5RiNsPZoo6NH5P9/pGe+zWFZeD0=;
        b=DeceLkWQBs7xX4ntad3gj27hkYmkCpFROGPk8Bsm5iA1WLg5LBzVrTzakHD+1ZbZru
         R5pELq7zDVoDVkfjiQg+zZ7eOuOVQIzmiZ1FduT6yXveyTCBbetx5HER9ebEBup78SvO
         zrqyHbQcJoRQ5OyswdleO+ixgeP0+ghGof3mMe9oUJgpgz20QYlKKe6+bo4Yx5h9xOsR
         s20HKZFz01ipbkafzlhHoMJBNopCrq+dTRBZr/HIGnV+ohfos/1q97ZRmKriw6KRSYRa
         58OPlHanNRDgRO7McEf//HAA6SXya1rh5t2+KBp03z0g1++vjA+uopMG4TLfW83IFfTG
         3lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774712165; x=1775316965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/VNplDWWCZzS7/n5RiNsPZoo6NH5P9/pGe+zWFZeD0=;
        b=Us6xqH1xG0QSrakqvA+trPpmvZuegKrmMQixhsqySn0uXc1YNWrs/VpjoPV03bORkk
         wgiFW4/8Sv5o+TRj/Q2UoTgm9gmdg0WbPJQebFm8mxCUSRErRQ5XEHw1n4t9z/Mg55WI
         ozjDFwtO5jrI+4PSQPngLlm7b9oWcT98JKlWnrZ90oezWRp3+SCTtjo9wT0eJdkGYDMq
         p9wkyl2WK+C4dcYanNuof1DJyhWvRGdY51k4qQx7Iem4fBeq9UZ+WVZeDN8UgaFpEE47
         jvQfcH76FNHg3aB9vTNOByX+dQSIEaWy3qH1kn18Etne86gmOvw6pivo7IYhal+iPiAR
         W3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcw8xcqtCbJUJUURK0WuwLSV1mqyhXHzN30BmFKRO3mWrHCcqTK8eLmn4GRqRgpjBdP9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOJSCvZGjc+B5l7SBv4kPzWrmX5AmslEnGPOvSwsXPLS6S0Q+
	E6J1vtmkYclB3qh9e9hWRynMq1Dy/whb52u+HcraGQaJ2EAvJXArTA1FiX1H2ONH
X-Gm-Gg: ATEYQzxeNG5tFwnvXmqBPmszySNUUrmjwR02OuWtBLpxW3EsXznvJmXzvLlw6rW14pN
	64Oi7d6pod7LemBpk4agowEZ75HEExztD7g73JB0EGmezejTZjwf7W8hKHZsPmLQSLAHrdS+dZG
	bnwjNFFmHhChA9WzfwyYtqmkjY1py9DOIcXQ8aoAZYm9TQ4jjwIIWsEsgHGcshMwj2rGqbEaXT0
	WoX12uOZRGXPxtEKeKupwbNVeJibQCsUIEQvPQkvUCIjqv0Ik4m+MaUrqb6lSkGR005bnrDQ+h0
	+FoxobKoiGxARUvbEmSe/WoXvC91d1eloUf8xuVL1pL8PBeMoRuaXvQskki5u4AWwC7l9u798tm
	zHGdOCj/QwP1SqcotGbewD0RhiL0AaHdjfsGWzyqHi3PzXNqieF6zoSCQxhkRSxjx9UNFOeVQFb
	V3xIRxar9s/KVxngCd+LVw7BBVf1Si1ty09QHOWHTwzaxlca6K9Oli3P0Sy9xrsmnI
X-Received: by 2002:a05:600c:828a:b0:487:338:b4df with SMTP id 5b1f17b1804b1-48727d8818cmr86841645e9.15.1774692519962;
        Sat, 28 Mar 2026 03:08:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872716799dsm32314725e9.25.2026.03.28.03.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 03:08:39 -0700 (PDT)
Date: Sat, 28 Mar 2026 10:08:37 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org, Jon Kohler
 <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, Sean Christopherson <seanjc@google.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP
 Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern
 <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Asit Mallick
 <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260328100837.7e6dc7fe@pumpkin>
In-Reply-To: <20260328004256.mm2ttj5iwvu5kdpa@desk>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
	<20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
	<20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
	<20260324221308.7sh6afdy6r6tsf4w@desk>
	<20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
	<20260326083934.fk4wyhe6rgiss34z@desk>
	<20260326100120.GAacUD8BVziYzLxZHB@fat_crate.local>
	<20260326104557.24295cbb@pumpkin>
	<20260326202931.wlggnd3nfj6hngpb@desk>
	<20260328004256.mm2ttj5iwvu5kdpa@desk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 17:42:56 -0700
Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> On Thu, Mar 26, 2026 at 01:29:31PM -0700, Pawan Gupta wrote:
> > On Thu, Mar 26, 2026 at 10:45:57AM +0000, David Laight wrote:  
> > > On Thu, 26 Mar 2026 11:01:20 +0100
> > > Borislav Petkov <bp@alien8.de> wrote:
> > >   
> > > > On Thu, Mar 26, 2026 at 01:39:34AM -0700, Pawan Gupta wrote:  
> > > > > I believe the equivalent for cpu_feature_enabled() in asm is the
> > > > > ALTERNATIVE. Please let me know if I am missing something.    
> > > > 
> > > > Yes, you are.
> > > > 
> > > > The point is that you don't want to stick those alternative calls inside some
> > > > magic bhb_loop function but hand them in from the outside, as function
> > > > arguments.
> > > > 
> > > > Basically what I did.
> > > > 
> > > > Then you were worried about this being C code and it had to be noinstr... So
> > > > that outer function can be rewritten in asm, I think, and still keep it well
> > > > separate.
> > > > 
> > > > I'll try to rewrite it once I get a free minute, and see how it looks.
> > > >   
> > > 
> > > I think someone tried getting C code to write the values to global data
> > > and getting the asm to read them.
> > > That got discounted because it spilt things between two largely unrelated files.  
> > 
> > 
> > The implementation with global variables wasn't that bad, let me revive it.
> > 
> > This part which ties sequence to BHI mitigation, which is not ideal,
> > (because VMSCAPE also uses it) it does seems a cleaner option.
> > 
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -2095,6 +2095,11 @@ static void __init bhi_select_mitigation(void)
> > 
> >  static void __init bhi_update_mitigation(void)
> >  {
> > +   if (!cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > +       bhi_seq_outer_loop = 5;
> > +       bhi_seq_inner_loop = 5;
> > +   }
> > +
> > 
> > I believe this can be moved to somewhere common to all mitigations.
> >   
> > > I think the BPF code would need significant refactoring to call a C function.  
> > 
> > Ya, true. Will use globals and keep clear_bhb_loop() in asm.  
> 
> While testing this approach, I noticed that syscalls were suffering an 8%
> regression on ICX for Native BHI mitigation:
> 
>   $ perf bench syscall basic -l 100000000
> 
> Bisection pointed to the change for using 8-bit registers (al/ah replacing
> eax/ecx) as the main contributor to the regression. (Global variables added
> a bit, but within noise).
> 
> Further digging revealed a strange behavior, using %ah for the inner loop
> was causing the regression, interchanging %al and %ah in the loops
> (for movb and sub) eliminated the regression.
> 
> <clear_bhb_loop_nofence>:
> 
> 	movb	bhb_seq_outer_loop(%rip), %al
> 
> 	call	1f
> 	jmp	5f
> 1:	call	2f
> .Lret1:	RET
> 2:	movb	bhb_seq_inner_loop(%rip), %ah
> 3:	jmp	4f
> 	nop
> 4:	sub	$1, %ah <---- No regression with %al here
> 	jnz	3b
> 	sub	$1, %al
> 	jnz	1b
> 
> My guess is, "sub $1, %al" is faster than "sub $1, %ah". Using %al in the
> inner loop, which is executed more number of times is likely making the
> difference. A perf profile is needed to confirm this.

I bet it is also CPU dependant - it is quite likely that there isn't
any special hardware to support partial writes of %ah so it ends up taking
a slow path (possibly even a microcoded one to get an 8% regression).

As well as swapping %al <-> %ah try changing the outer loop decrement to
	sub $0x100, %ax
since %al is zero that will set the z flag the same.

I've just hacked a test into some test code I've got.
I'm not seeing an unexpected costs on either zen-5 or haswell.
So it may be more subtle.

	David


> 
> Never imagined a register selection can make an 8% difference in
> performance! Anyways, will update the patch with this finding.


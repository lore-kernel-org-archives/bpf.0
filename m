Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A93CA4A3
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034132; cv=none; b=m8FLlrUemYFKMRzMP6ROGtsWP2KME6qs5tx2oTF4JeJfyWbKHgOvPAs4kDl6HTaGCwAjXKTjfeM50/Bzea1OnirDgTw5VdXAN12dLoOCbKlAkTMA386Re1U5TQVUTwGgGfh5xoXERnwEa6FE9rE5ZsM5ueJ8rsdA//rCJG7+/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034132; c=relaxed/simple;
	bh=snMRgRGjpC36TXmqL3DygrIC9Al4OWoVAUjguncqfQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGxC6zYdpEwpX89C8fv9KIJUOlOYY3nV/SEyTtxuCuIAdwufag9DBKikg6FHODJ+rCmqqjcC/ZPdaOxPojiM1Sb5Z0Ra0TfRHEgUxW+/zIltpiISc4ptBzZWT0IdiNysVnSOzp4F5yTcTwC+2b/PgsbC/iIR0ksxGpNvkng13sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCdru6Jl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCdru6Jl"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486ff201041so65159835e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775034125; x=1775638925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myMQb7tPU7Rdb+G4SNs48523Japx5WaCvk8cAgSpAfQ=;
        b=JCdru6Jl3Z56rrGehTPqOr6kRJFmS7/ZwqUsAoUhlgRVf7Mtje16YfP1gHP7q7v0P/
         jGAYNX8pwjTR0rJE5PmcqIrugImy9HXls4tkk/EguNdvkGYWSgSzWhlMZ5mmLBYdvWsn
         EbeOq7+7HH61yWMG9TrNmDZ/XnNvjg6fpzbLj5Ad3YeTqCMIUfIRnRSW9w994cHoFjpg
         6tirQE2OlReikrYoknoI/szebEeIM4Wtioy4WmonEASV6FqihIThPKu7ZyoV4wdhZZaC
         1S+8+ifSvaqtY72SKjgKyQN3DAeSomPzpeJbrMNjkcmJBInzCXY5scqyxC6jqbMtJILm
         +RCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034125; x=1775638925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=myMQb7tPU7Rdb+G4SNs48523Japx5WaCvk8cAgSpAfQ=;
        b=WBQAxuslvLNGlnC6RTndHhKSZDu1oLFtkl+Gbd9/NyGS9CT0UBFrzu+wBdUsWsINRr
         9BtE9sFgAZosml7HGrFyg1JNrOcCw6ax8M0P/0YwJNJuqUvnuQ4fqkvwR+1AbRTGuuVI
         S03vSuD2Rs6vzw8Bqoru1tx5URiSlGsR4m3H9xEVGHZzeJwui99DMEl3gDevDBfyRBW6
         0wBHkE20f8kFYB3LzxRMzL2+Ged46cGFAr4nU1gtGKL1acdh0ICmq8spphOTG0qfqxJL
         w8NxJLi2dkghvezRFKJb0/UpYbAC37LGI/qFe4o1f2NbdyvW0Zg0mhMtb7B7gcYB+LAI
         p5UA==
X-Forwarded-Encrypted: i=1; AJvYcCWyWKYabWWc4/dn4Osc7PyjPMd6wz3vZvDydlbcsBzjp7kkyrgFpoZeWxeoFQTnVPd5Upk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk6+0nP5502zStIIBjiVFsAu0lNuIwdnzE1nXKSqSYTLJdoHxb
	ytz2ZmWMuTDfvzMY/hg+OBfNULf1C/EsXEaF6PVRUhkEok/sRQroZbF4
X-Gm-Gg: ATEYQzzrDhbObtjFE5X1kapzfbir6JrvKt19yuNqUTsLNrb4sT1JvhlP0oPs7DNzhhJ
	e3w0swX3RZ6wvtN/VRwFA++UjLmj2iZPCGJFLrVW5foOxDft9MMw/5P5vq3V5wVIMr2ZTEtE/Pe
	FfmQoLvNy2sJAc9TNwZywoUQEXeCBM3UzfVw2dgS3cec2FF0bJfrItBjnVlp1GTkz0NTWhohYY0
	+bzeXUQuca9RizT2AlJfacdgz42d2VGTuToGqNycxtn/l7nHnoBbPMr7lUTmpsuMBl0YIjXK24D
	qVN+2ydEcVn/UTkwCedhmWEeBivnHK/wE3eMIpyeQmaUxIGxr83gj7+Cn8o+kIqJNRgLfIZrrLg
	P8qAVJU1OniG7tth6+oONnZO5/oUvoDqW/FZITpK+1Ffz9BOMG8sV+BFVx9ehBz7YY0x2vieWC9
	QrRWyPdvAvpWdq83nrQm5zGxmk2J411Qir4CKCy7k7cXED/Ed5+No/BDti+hsn
X-Received: by 2002:a05:600c:154c:b0:485:4eaf:eb54 with SMTP id 5b1f17b1804b1-488835920d4mr43563045e9.20.1775034123881;
        Wed, 01 Apr 2026 02:02:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm125095615e9.0.2026.04.01.02.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:02:03 -0700 (PDT)
Date: Wed, 1 Apr 2026 10:02:00 +0100
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
Message-ID: <20260401100200.5b347628@pumpkin>
In-Reply-To: <20260401081236.3rjp2wigkr6w3nym@desk>
References: <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
	<20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
	<20260324221308.7sh6afdy6r6tsf4w@desk>
	<20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
	<20260326083934.fk4wyhe6rgiss34z@desk>
	<20260326100120.GAacUD8BVziYzLxZHB@fat_crate.local>
	<20260326104557.24295cbb@pumpkin>
	<20260326202931.wlggnd3nfj6hngpb@desk>
	<20260328004256.mm2ttj5iwvu5kdpa@desk>
	<20260328100837.7e6dc7fe@pumpkin>
	<20260401081236.3rjp2wigkr6w3nym@desk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 01:12:36 -0700
Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> On Sat, Mar 28, 2026 at 10:08:37AM +0000, David Laight wrote:
> > On Fri, 27 Mar 2026 17:42:56 -0700
> > Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> >   
> > > On Thu, Mar 26, 2026 at 01:29:31PM -0700, Pawan Gupta wrote:  
> > > > On Thu, Mar 26, 2026 at 10:45:57AM +0000, David Laight wrote:    
> > > > > On Thu, 26 Mar 2026 11:01:20 +0100
> > > > > Borislav Petkov <bp@alien8.de> wrote:
> > > > >     
> > > > > > On Thu, Mar 26, 2026 at 01:39:34AM -0700, Pawan Gupta wrote:    
> > > > > > > I believe the equivalent for cpu_feature_enabled() in asm is the
> > > > > > > ALTERNATIVE. Please let me know if I am missing something.      
> > > > > > 
> > > > > > Yes, you are.
> > > > > > 
> > > > > > The point is that you don't want to stick those alternative calls inside some
> > > > > > magic bhb_loop function but hand them in from the outside, as function
> > > > > > arguments.
> > > > > > 
> > > > > > Basically what I did.
> > > > > > 
> > > > > > Then you were worried about this being C code and it had to be noinstr... So
> > > > > > that outer function can be rewritten in asm, I think, and still keep it well
> > > > > > separate.
> > > > > > 
> > > > > > I'll try to rewrite it once I get a free minute, and see how it looks.
> > > > > >     
> > > > > 
> > > > > I think someone tried getting C code to write the values to global data
> > > > > and getting the asm to read them.
> > > > > That got discounted because it spilt things between two largely unrelated files.    
> > > > 
> > > > 
> > > > The implementation with global variables wasn't that bad, let me revive it.
> > > > 
> > > > This part which ties sequence to BHI mitigation, which is not ideal,
> > > > (because VMSCAPE also uses it) it does seems a cleaner option.
> > > > 
> > > > --- a/arch/x86/kernel/cpu/bugs.c
> > > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > > @@ -2095,6 +2095,11 @@ static void __init bhi_select_mitigation(void)
> > > > 
> > > >  static void __init bhi_update_mitigation(void)
> > > >  {
> > > > +   if (!cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > > > +       bhi_seq_outer_loop = 5;
> > > > +       bhi_seq_inner_loop = 5;
> > > > +   }
> > > > +
> > > > 
> > > > I believe this can be moved to somewhere common to all mitigations.
> > > >     
> > > > > I think the BPF code would need significant refactoring to call a C function.    
> > > > 
> > > > Ya, true. Will use globals and keep clear_bhb_loop() in asm.    
> > > 
> > > While testing this approach, I noticed that syscalls were suffering an 8%
> > > regression on ICX for Native BHI mitigation:
> > > 
> > >   $ perf bench syscall basic -l 100000000
> > > 
> > > Bisection pointed to the change for using 8-bit registers (al/ah replacing
> > > eax/ecx) as the main contributor to the regression. (Global variables added
> > > a bit, but within noise).
> > > 
> > > Further digging revealed a strange behavior, using %ah for the inner loop
> > > was causing the regression, interchanging %al and %ah in the loops
> > > (for movb and sub) eliminated the regression.
> > > 
> > > <clear_bhb_loop_nofence>:
> > > 
> > > 	movb	bhb_seq_outer_loop(%rip), %al
> > > 
> > > 	call	1f
> > > 	jmp	5f
> > > 1:	call	2f
> > > .Lret1:	RET
> > > 2:	movb	bhb_seq_inner_loop(%rip), %ah
> > > 3:	jmp	4f
> > > 	nop
> > > 4:	sub	$1, %ah <---- No regression with %al here
> > > 	jnz	3b
> > > 	sub	$1, %al
> > > 	jnz	1b
> > > 
> > > My guess is, "sub $1, %al" is faster than "sub $1, %ah". Using %al in the
> > > inner loop, which is executed more number of times is likely making the
> > > difference. A perf profile is needed to confirm this.  
> > 
> > I bet it is also CPU dependant - it is quite likely that there isn't
> > any special hardware to support partial writes of %ah so it ends up taking
> > a slow path (possibly even a microcoded one to get an 8% regression).  
> 
> Strangely, %ah in the inner loop incurs less uops and has fewer branch
> misses, yet takes more cycles. Below is the perf data for the sequence on a
> Rocket Lake (similar observation on ICX and EMR):
> 
>   Event                     %al inner      %ah inner       Delta
>   ----------------------  -------------  -------------  ----------
>   cycles                    776,775,020    972,322,384    +25.2%
>   instructions/cycle               1.23           0.98    -20.3%
>   branch-misses               4,792,502        560,449    -88.3%
>   uops_issued.any           768,019,010    696,888,357     -9.3%
>   time elapsed                 0.1627s        0.2048s     +25.9%
> 
> Time elapsed directly correlates with the increase in cycles.

That might be consistent with the %ah accesses (probably writes)
being very slow/synchronising.
So you are getting a full cpu stall instead speculative execution
of the following instructions - which must include a lot of mis-predicted
branches.

> > As well as swapping %al <-> %ah try changing the outer loop decrement to
> > 	sub $0x100, %ax
> > since %al is zero that will set the z flag the same.  
> 
> Unfortunately, using "sub $0x100, %ax"(with %al as inner loop) isn't better
> than just using "sub $1, %ah" in the outer loop:
> 
>   Event                     %al inner      + sub %ax       Delta
>   ----------------------  -------------  -------------  ----------
>   cycles                    776,775,020    813,372,036     +4.7%
>   instructions/cycle               1.23           1.17     -4.5%
>   branch-misses               4,792,502      7,610,323    +58.8%
>   uops_issued.any           768,019,010    827,465,137     +7.7%
>   time elapsed                 0.1627s        0.1707s      +4.9%

That is even more interesting.
The 'sub %ax' version has more uops and more branch-misses.
Looks like the extra cost of the %ah access is less than the cost
of the extra mis-predicted branches.

Makes me wonder where a version that uses %cl fits?
(Or use a zero-extending read and %eax/%ecx - likely to be the same.)
I'll bet 'one beer' that is nearest the 'sub %ax' version.

	David

> 
> > I've just hacked a test into some test code I've got.
> > I'm not seeing an unexpected costs on either zen-5 or haswell.
> > So it may be more subtle.  
> 
> This is puzzling, but atleast it is evident that using %al for the inner
> loop seems to be the best option. In summary:
> 
>   Variant   Cycles     Uops Issued  Branch Misses
>   -------  ----------  -----------  -------------
>   %al       776M        768M           4.8M         (fastest)
>   %ah       972M (+25%) 697M (-9%)     560K (-88%)  (fewer uops + misses, yet slowest)
>   sub %ax   813M (+5%)  827M (+8%)     7.6M (+59%)  (most uops + misses)


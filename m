Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135925;
	b=rvmD3lbdFoF+mGGU+OY6r9Z3PJANujWO3Hm7+Oz24bx8lD0JWVmklsNweAE8F6UX6VmZ
	 UZ58+JWySdWxbgNEVwmW8A4vq1ILpHmylmtGBZknRYkf2/TQu85NCZT12PX0vk66AR4nR
	 /jJQ2fIRfUeUUO5riI1KvADyKAPbZwmrrnHr5bFPYtBHHdkqUbsVQZyuP9VCervHTN2in
	 S3kLXkvRt3DryZDbtXvMfugGi+bY3uZCo6AV20wzA3IcpWrP6X4sldCF+ZMJ+pz0KYjDd
	 WdlRTLwvJzhyo3jtmW+kQdtHmi+o8tjg4rsWmqTw5RaF0G3WEZawm75i4+rLgprtb8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=qUMx95Z2/FLv64tnydT/x/C4fd+wJMNdslwBEILinGo=;
	b=ThBkREjG7ghCyQvS4q/HqrwHRCOR4gAMo0tql6rAcGdW3SPewwK6Fp6lypt/IEafhyeM
	 MsqqXHqUc83Pqyg8EDK4c2e7eeijeDIgVC/Gar1Rgvvhbzjirn2ZH/9Fx/ZXOOH5LARB/
	 AeVN14gEuUO90B7wQDTncaUEhHvJhcjShXRKJclfoBD/DiHMPusM1qiLZayFlME1N6LSN
	 jPBpVJ8+tJ/P3p7iNFYUPwVeH9Eu4gIR/xfg+WZsdG0NtU0vW/sVvHJR4O71q7uZSjdW6
	 qPotyHGCjDisn376AbDwArJ7CUHTOQ4lzgkHyXNgspJ7n3ODUBJ0I51sk3DNa4FiaBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O9t1oNxh;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C4D606A322
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78C4D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O9t1oNxh
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3aaf955db5fso413719a91.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793135924; x=1793740724; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qUMx95Z2/FLv64tnydT/x/C4fd+wJMNdslwBEILinGo=;
        b=O9t1oNxhj7Xw67fxZOhJmZ8vNAdxWgxOGEEZGK9oId6/aVHLsnFtQlbNQ6bzhC9B0E
         f9O/mJB1tznoMWpJP5vr6IAfWd7OYL3+vqog/K86lyrB9hPII1dxM6rPxBJ9Kby9+ucJ
         q3hnsiNT2ru8vSf8egpVYYGw35wKVG80Vu3ezvTOK/2hErKcg9OsAoYftXOMXvmgvOsE
         USSlpzb9cbn2+MUY6DGfb3+M18AMUDB5o3XD1HYrd07vSA1sr+KPFgLsCAHlt3yIU0CJ
         46wb1/8vXqcmincC/gKw4zIHqOkFMeY2f47UtXQrgsFIIglqeYn4Rz2uN2mV+APvhSlW
         0LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135924; x=1793740724;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qUMx95Z2/FLv64tnydT/x/C4fd+wJMNdslwBEILinGo=;
        b=Yrz175fK92KyrULPCJU/R1Uz3ZyaakUgyi0DeqHiN6zutYG5oRLY86rqF1vq8tRCi1
         pVmhIzxyVqsdRF/qBB25urRsQer/orTnN2ii2LV1R810UYp9R4wAXMRl/OU5N8cIMzPL
         7qpj4ZJiRxpbmCFgJ+UvXO0suoNiZgRVJhyxqSTuEAVfW7JbQXn58fqtzFhV0XOml2So
         It61Y1GKUJ+mhBq/semPVTzZzOasOMrtdL9wP6IXJg8dlKzkaNv4t4xl59uEfrO8qXpF
         cObxBMJBUhPKXsLHvj9k33A0ffft5vmOv2DVR7YrSLuQzfQVXAtsKE1l36Mygkuzl8HJ
         JIZA==
X-Forwarded-Encrypted: i=1; AKwUvBxCuALOqrOR4IP2tqrEALJIgBNLMqGpjCLWmB+V6Yo9YxNwSgbGuWTtPdMS6zEcNsFbgcg=@vger.kernel.org
X-Gm-Message-State: AFq9FYITBK6mldyUWUQFVbwdxB5UZo0bXH/brrR2LbtcQ/Gwkp+awnOw
	oKb8aydr1+Y11p0ry4Jvq+JmD+bI8lteJqTqDRbZznBhYPTCChh9wkDp+kJGIpNBRb7Q+Cj/qw/
	Low9ycA==
X-Received: from pjvv8.prod.google.com ([2002:a17:90b:5888:b0:3ad:850b:6f1c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:288a:b0:3ac:9706:7739
 with SMTP id 98e67ed59e1d1-3ae5819e5afmr211698a91.17.1793135923585; Tue, 27
 Oct 2026 14:18:43 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:18:42 -0700
In-Reply-To: <ac22215d-3e58-4aab-851e-47c30836e058@app.fastmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
 <14f5f919-55bd-47c6-a1c8-6f1445cce733@app.fastmail.com> <CADrL8HXQdzcroeGN-ACjyy-jSAdBNHiT1_BCVVe0P+Y8ZueiyA@mail.gmail.com>
 <ac22215d-3e58-4aab-851e-47c30836e058@app.fastmail.com>
Message-ID: <auEVMrMDqVuKtDqh@google.com>
Subject: Re: [RFC PATCH 00/10] uaccess: Refuse and warn on user accesses when
 current->mm is NULL
From: Sean Christopherson <seanjc@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Houghton <jthoughton@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 27, 2026, Arnd Bergmann wrote:
> On Tue, Oct 27, 2026, at 18:29, James Houghton wrote:
> >> I would think that user_access_begin() is a more natural place
> >> for the added checks, as this should be called exactly once for
> >> any function that accesses user space and also stays out of the
> >> way of the copy_from_kernel_nofault() etc.
> >
> > user_access_begin() isn't used in a lot of places that I want to
> > catch, including the KVM case. Roughly:
> >
> >   kvm_write_guest_cached() --> __copy_to_user() --> raw_copy_to_user()
> >
> > There's no user_access_begin() in there. :/
> 
> Good point, yes. After the changes described in
> https://lwn.net/Articles/1102061/, I had assumed that all
> __copy_{from,to}_user() are going from common code, but it looks
> like the series so far only touches __{get,put}_user().
> 
> There are of course few enough of these left that I think
> we can consider doing the same thing here and turn them all
> into the checking version:
> 
> $ git grep -wl __copy_'\(from\|to\)'_user  drivers mm virt
> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> drivers/gpu/drm/i915/i915_gem.c
> drivers/gpu/drm/i915/i915_query.c
> drivers/usb/gadget/udc/atmel_usba_udc.c
> drivers/vhost/scsi.c
> drivers/vhost/vhost.c
> mm/kasan/kasan_test_c.c
> virt/kvm/kvm_main.c
> 
> > I do think user_access_begin() should have the new check though, so
> > I've added it in the v2.
> 
> I had the details confused here. Seing that user_access_begin()
> and the other accessors always call access_ok() at some
> point, maybe that would be enough?:

It would help, but it wouldn't cover everything, e.g. KVM "caches" the access_ok()
checks well in advance of actually performing a user access.  I don't know that I
would fixate on KVM too much though, as KVM's memslots infrastructure that begets
that behavior is quite unique, i.e. it's unlikely other subsystems will have these
types of bugs *and* elide access_ok() checks at the time of access.  And KVM has
natural chokepoints for these accesses, so it's easy enough to harden KVM itself.

The counter-argument is that _if_ there are other subsystems that are caching
access_ok() checks, then those are probably the subsystems that are most likely
to mess this up and thus would benefit the most from common hardening.

> --- a/include/asm-generic/access_ok.h
> +++ b/include/asm-generic/access_ok.h
> @@ -33,6 +33,9 @@ static inline int __access_ok(const void __user *ptr, unsigned long size)
>         unsigned long limit = TASK_SIZE_MAX;
>         unsigned long addr = (unsigned long)ptr;
>  
> +       if (WARN_ONCE(!current->mm))
> +               return false;
> +
>         if (IS_ENABLED(CONFIG_ALTERNATE_USER_ADDRESS_SPACE) ||
>             !IS_ENABLED(CONFIG_MMU))
>                 return true;
> 
> (plus the few extra copies of access_ok()/__access_ok())
> 
> As a quick fix I would probably start with just the 'if (!mm) return false'
> bit here to get something merged while we still discuss the other
> details.

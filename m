Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FB4470133
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785264766; cv=none; b=VO0LViW+VxWDLWxsLkt7aTTnjdhYp1AR1/J5WirMFOy+upNlIwWMgaCPSULEUKeGULex3bT786MSc9u9i7TK08A053fchUG7mam9CkoE7qNrhvghMZrx1mqIfTJDxv1GPMGpWFn6npVuJ1rH6m1NYQjYbxtOlD+6GDLCCG3+jZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785264766; c=relaxed/simple;
	bh=l2Es26jUxus/pyPxMghMUP1yIXuAWO7tK+rKBlkL2CE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sSqodSjSB3S9TGZ+M+FmP2AK8N7v+vtYn9ZahzXOZ40IztaEUM7axsTjxyI24aueSdiK0mzwgOSGkFeoQiZgsjR/IbV+XpdCC9iIW9khomKDbyVrKSsP3ruhqle6oY8U9hpGGCJY9rfG8j/NrvHCD0XA/KHXSmMzhAdXFws11MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nUxq8Dhq; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nUxq8Dhq"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfbf3e4a63so5097665ad.0
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785264762; x=1785869562; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EURzVSWhRSOOgqb3RqZuisJ1IP2IjYHX1FhuQfx4G4s=;
        b=nUxq8DhqIxUAbFbipxgS79prGPpoMB7vH9pEPhKrlJv0iGol0LVoyR/7SbZWKE2qEq
         U2gpHp0APz8HkhJEpOl6P1gDmcDoUtq/6gJFQKQrJWLBn2wXkcS1tnzWrXp1pBuZ0GOi
         xV97Z6wGae3ZHgMmFRErLmFpo2h5PxLdUWY09qwPam2C3OTWWQv3Y6b0UyN4kPL4mWXp
         wkRKwV8EqTGg8CUEFGZN8B3bcOdfx4CQsBJanI4+5sANPCCvGTqlgDQzlqU7eK9FW0E/
         a/AQOdGnEshSlHR932LUj4GSQsg3wUVrsJC8MttLEf/xsp61wM6A02JCmu3EfKpjMIIa
         xxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785264762; x=1785869562;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EURzVSWhRSOOgqb3RqZuisJ1IP2IjYHX1FhuQfx4G4s=;
        b=TLHCeYWesuRrjx4X8AXcFF1vCwbq11BX+HEqnD0YiQ+uZT/xcCGK34iCBSnQrSkKfi
         IyVYlgJXerQ6WX9SKhjxja2grNn2Y6CLBgxtdZkMRfOEiHxibdJP6fqwOczTmxuVEVVP
         3LuOrXN+KjL8OQj8YTP1XyVR6nG9vQ7IZYzt+/chEByhQi2fKgOFljqPSsu5WYQl+SWa
         LD3RpvSxo57l4kDH7JcxgM9SSxpifx186xOwr6c0Q5wfaukNuGy5RmVHIq4eSZiIPD7k
         MOAsd0UxO/IvJsB7WyRuQg0dVJp8kk8MMBemcaeyydCwFrbqzM9f5u780+fq3/YnDKX5
         pQjg==
X-Forwarded-Encrypted: i=1; AHgh+RoU0qDV1LojTSxmeX/hoNkfkzAelfe7HgOe6pnQyzRyzyO/aruSir+Lfjh6x2pWbW1vSwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWHPou+ejcjLeQsNfJQiwkkrp/UQxXtBVZxCoIjtGUfG5ncIq
	aa+u8S1D2de/aEJY3He0cNhAOz8G33/+eS2cDH5K9CEo/AXvH9tRpAZuI66ll43sGE/8rRl9HAv
	0NjN0fg==
X-Received: from plec7.prod.google.com ([2002:a17:902:f307:b0:2c7:f19d:bb15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f710:b0:2ca:a03a:29b2
 with SMTP id d9443c01a7336-2d015c9c0c4mr48784125ad.8.1785264762144; Tue, 28
 Jul 2026 11:52:42 -0700 (PDT)
Date: Tue, 28 Jul 2026 11:52:41 -0700
In-Reply-To: <ajvUp_kPJBRZ7k_p@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-7-76cbda0ae3e5@linux.intel.com> <ajvUp_kPJBRZ7k_p@google.com>
Message-ID: <amj6eYOs70WUPGDG@google.com>
Subject: Re: [PATCH v12 07/12] static_call: Define EXPORT_STATIC_CALL_FOR_MODULES()
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	David Laight <david.laight.linux@gmail.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>, 
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 24, 2026, Sean Christopherson wrote:
> On Tue, Jun 23, 2026, Pawan Gupta wrote:
> > There is EXPORT_STATIC_CALL_TRAMP() that hides the static key from all
> > modules. But there is no equivalent of EXPORT_SYMBOL_FOR_MODULES() to
> > restrict symbol visibility to only certain modules.
> > 
> > Add EXPORT_STATIC_CALL_FOR_MODULES(name, mods) that wraps both the key and
> > the trampoline with EXPORT_SYMBOL_FOR_MODULES(), allowing only a limited
> > set of modules to see and update the static key.
> > 
> > The immediate user is KVM, in the following commit.
> > 
> > checkpatch reported below warnings with this change that I believe don't
> > apply in this case:
> > 
> >   include/linux/static_call.h:219: WARNING: Non-declarative macros with multiple statements should be enclosed in a do - while loop
> >   include/linux/static_call.h:220: WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > 
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> >  include/linux/static_call.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> > index 78a77a4ae0ea..b610afd1ed55 100644
> > --- a/include/linux/static_call.h
> > +++ b/include/linux/static_call.h
> > @@ -216,6 +216,9 @@ extern long __static_call_return0(void);
> >  #define EXPORT_STATIC_CALL_GPL(name)					\
> >  	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
> >  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> > +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
> > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
> >  
> >  /* Leave the key unexported, so modules can't change static call targets: */
> >  #define EXPORT_STATIC_CALL_TRAMP(name)					\
> > @@ -276,6 +279,9 @@ extern long __static_call_return0(void);
> >  #define EXPORT_STATIC_CALL_GPL(name)					\
> >  	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
> >  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> > +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
> > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
> >  
> >  /* Leave the key unexported, so modules can't change static call targets: */
> >  #define EXPORT_STATIC_CALL_TRAMP(name)					\
> > @@ -346,6 +352,8 @@ static inline int static_call_text_reserved(void *start, void *end)
> >  
> >  #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
> >  #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
> > +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods)
> >  
> >  #endif /* CONFIG_HAVE_STATIC_CALL */
> 
> Drat, I forgot about this.  Exporting static call trampolines for KVM came up in
> another conversation[*].  I had already put together patches to effectively default
> to exporting only the trampoline, and also to deduplicate this code so that the
> CONFIG_HAVE_STATIC_CALL_INLINE=y / CONFIG_HAVE_STATIC_CALL=y / CONFIG_HAVE_STATIC_CALL=n
> implementations don't need to copy+paste the same lines of code.
> 
> The attached patches touch a lot more code, and will conflict mightily with KVM
> changes I want to land in 7.3 (more use of a static_call in KVM).  But if we get
> them applied (to tip tree) shortly after 7.2-rc1 and provide a topic branch/tag,
> then there shouldn't be too much juggling needed?
> 
> If we want to go with the more aggressive cleanup, I'll formally post the patches.

*sigh*

So the patches build, but they aren't fully functional.  If kvm.ko is built as a
module, trying to load a vendor module will fail due to the trampoline => key table
only tracking built-in symbols.

Given that all of this is KVM, and that it's far easier to export the static calls
if and only if there are vendor modules, and only for those vendor modules, I'm
going to drop the aggressive cleanup and abandon converting KVM's exports to only
export trampolines, at least until someone else works up the motivation to add
support for modules.

> [*] https://lore.kernel.org/all/ahhoDGUz39KSGZ6o@google.com

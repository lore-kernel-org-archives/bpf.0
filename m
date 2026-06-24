Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B0262FF8
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338608; cv=none; b=p/5o1Dbqn+5SgwdSw6ptQ2lXEwCx+vr2jIpTxzFtLovHoW03qsdr/zUP4dn+WrCSHu63LjohSDyzKBjcnboyIk6SWe6w5E4huLOL2fr8v3xSFVZ8PfLsLiBxm1aIZOMlqYZsmCqUp4DWebE9bCXB5l3C9tQjJrZjd9n0P3ed0WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338608; c=relaxed/simple;
	bh=r5g6+V2Amp0yxvechpGrRZ8S0WXq2V+a9zpffLkRRbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jBab5BFwkjQih2/cSEMCafPTLKu8G/bi3vJSegNgz15gz55N0/W/3rNkk57ROn2r/3f6Wqx8uP76cRO/4T5mwVSGONRueKObQRJVQVTl02COFbU5WX6ueBBNLW7e4BNJswsxVRcV7bSh8RB1VwsxWTmyKcuZ77KwZboQq+sG+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kt8Q55al; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kt8Q55al"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c2d0a8b5beso12873755ad.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 15:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782338607; x=1782943407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LrxdfhnpHc3n007Ugb6QRVTz2pRJtP7mIebzaELjk+Q=;
        b=kt8Q55alaDwoCFWKoa5bV7LcIVUuvYZ+cxeB620+DGabur7nuY8PEpVyhUSxvSnco4
         OSwgjFGL9Eu0eZVhBoN19wU18B6Zd8Ea0vlTaDTPYK4VpqcUoKGVSZdsrtK/VVYBxi3m
         LOhFO78H2yV26E0pldjYBn/V1VvlesUVLbaVSI4LErRM9eVH488NhvbpjAglQjz3wxX2
         F25V9ad6yPEW03J1fq69n5YEhpiMbb/ikzkY+aBne+O3cwFts9p045oRm2sQP4pem8LF
         G7rXCZ8D0e3jIfuOEACMzP5ulS7A5gVxxS+BcFHQyMJZ4QTJ15nam/3pnnT8VQBwOQ8l
         FZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338607; x=1782943407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrxdfhnpHc3n007Ugb6QRVTz2pRJtP7mIebzaELjk+Q=;
        b=jcg+/bXBIE8MTe35h9SDoa6TZD3jbtG0dc2WCKwr/+JDr5SMk7iB5OnyT3MYs5RxqZ
         PMKpQGMx4QbFlEf/Yd3aU9mS/2BnRgCVF9cKvCQfuCYJXYbB2NBP0sSytQgGmpanZd+g
         wizNJBVm9KJxmRHg7Xo3t7t8o7T5H/HcO6+pYAKU4gmfkazDKMu+Vse1aI9JXulBOWig
         BDwbDoGbaxGAam7g9G2z89f+e+kh4UeQ6/WoW3mGHKy9Iu6aQhGcNtef5dhj+zBvhynN
         X48ugE+IT5vLKh8Z1t66r54fjiuApZLlv/oLQa6yGTaMaMU5bCf+WW3bvNP5IjnklCj2
         2tZg==
X-Forwarded-Encrypted: i=1; AHgh+RrbNy9W9+RpluL6OfJCq9o5KzuMngX0Zjtau0TejB83oPMl3qkmW+E/pRlCuNl9N8tzpo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoac4yYaDuxiQ9nMjSb6mgYa8X5hlmsTOVdnxbsoBhuMLqLDgt
	RTlIzk0tfDw5gC6ItGh2jGPlRuWWiAkVxHx2++bxsREKINYD1fKVlEGHGmN1bWzMYGxt70BH7Vc
	LLscvhQ==
X-Received: from plbl20.prod.google.com ([2002:a17:902:eb14:b0:2c7:e126:e2ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4d0:b0:2c2:21e9:5a7d
 with SMTP id d9443c01a7336-2c7fc8a9b4fmr173895ad.34.1782338606050; Wed, 24
 Jun 2026 15:03:26 -0700 (PDT)
Date: Wed, 24 Jun 2026 22:03:25 +0000
In-Reply-To: <20260624214955.6kkivefeuapcocib@desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-7-76cbda0ae3e5@linux.intel.com> <ajvUp_kPJBRZ7k_p@google.com>
 <20260624214955.6kkivefeuapcocib@desk>
Message-ID: <ajxULasZkCS57NPq@google.com>
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

On Wed, Jun 24, 2026, Pawan Gupta wrote:
> On Wed, Jun 24, 2026 at 05:59:19AM -0700, Sean Christopherson wrote:
> > On Tue, Jun 23, 2026, Pawan Gupta wrote:
> > > There is EXPORT_STATIC_CALL_TRAMP() that hides the static key from all
> > > modules. But there is no equivalent of EXPORT_SYMBOL_FOR_MODULES() to
> > > restrict symbol visibility to only certain modules.
> > > 
> > > Add EXPORT_STATIC_CALL_FOR_MODULES(name, mods) that wraps both the key and
> > > the trampoline with EXPORT_SYMBOL_FOR_MODULES(), allowing only a limited
> > > set of modules to see and update the static key.
> > > 
> > > The immediate user is KVM, in the following commit.
> > > 
> > > checkpatch reported below warnings with this change that I believe don't
> > > apply in this case:
> > > 
> > >   include/linux/static_call.h:219: WARNING: Non-declarative macros with multiple statements should be enclosed in a do - while loop
> > >   include/linux/static_call.h:220: WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > > 
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > ---

...

> > Drat, I forgot about this.  Exporting static call trampolines for KVM came up in
> > another conversation[*].  I had already put together patches to effectively default
> > to exporting only the trampoline, and also to deduplicate this code so that the
> > CONFIG_HAVE_STATIC_CALL_INLINE=y / CONFIG_HAVE_STATIC_CALL=y / CONFIG_HAVE_STATIC_CALL=n
> > implementations don't need to copy+paste the same lines of code.
> > 
> > The attached patches touch a lot more code, and will conflict mightily with KVM
> > changes I want to land in 7.3 (more use of a static_call in KVM).  But if we get
> > them applied (to tip tree) shortly after 7.2-rc1 and provide a topic branch/tag,
> > then there shouldn't be too much juggling needed?
> > 
> > If we want to go with the more aggressive cleanup, I'll formally post the patches.
> > 
> > [*] https://lore.kernel.org/all/ahhoDGUz39KSGZ6o@google.com
> 
> Thanks for the context.
> 
> Earlier making the key ro-after-init came up as an option in a thread with
> Peter. Does it look like a good option to you?

No, it won't work for KVM.  kvm.ko (owner of the keys) updates the keys only when
a vendor module (kvm-intel.ko or kvm-amd.ko) is loaded, and updates keys *every*
time a vendor module is loaded.  So for KVM, the static calls need to be __read_mostly,
not __ro_after_init.

> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> index b610afd1ed55..ea56da8fb446 100644
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -200,6 +200,14 @@ extern long __static_call_return0(void);
>  	};								\
>  	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
>  
> +#define DEFINE_STATIC_CALL_NULL_RO_AFTER_INIT(name, _func)		\
> +	DECLARE_STATIC_CALL(name, _func);				\
> +	struct static_call_key STATIC_CALL_KEY(name) __ro_after_init = {\
> +		.func = _func,						\
> +		.type = 1,						\
> +	};								\
> +	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
> +
>  #define DEFINE_STATIC_CALL_RET0(name, _func)				\
>  	DECLARE_STATIC_CALL(name, _func);				\
>  	struct static_call_key STATIC_CALL_KEY(name) = {		\

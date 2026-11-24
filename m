Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795501548;
	b=rCLXki1ojLsQIjQVB2bZw6jZ97CTGpNZz1OnHLOqrKN0EUbvwqjMw14QyR/kMBbPnUNS
	 JNp1+Qp7sZXoR9P/g3sl0jMGXVmVMMXOBu7dDwB9UKN14/2BWQpTjhpWqGahn6pVRHRUL
	 toMCr5CqPyRmUv8U1CLpocBTXpq3HjLcWgjmx3rWTpE6ElXG9YTwjqy71GZ8lH8DHyJY0
	 Hpx/ajVdjVpTmClUjsRbSeWZ1gda6chfNMFqDfAtQ7ISaM7Rum8nKV/hTtQZY/NJsBDnb
	 2P6BBK/jPFl2ouxbDMazDzy38DleYUS6eGbXUe9RkfoZ9Z3sVs6cLaUtuoXkY1QBLfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=mpGQvJviYasWyAsTrcg7sxjiOrvcQ5Fx+ssD1xXfttI=;
	b=bWfC/3MPnvtoJ5i5BHPlif3TPIkdgD3A87vqRWkeJdq/exx/inlh/ixoOmMw0m7qpVWA
	 HRPPE24B64+4XCLAXS7fdLSkUmqLV3unOlmTnbcZ2c0fbaH6khQmlSMCVzAC9xUfonlgC
	 4+g/3dj4ovBV9nLax8COYEyqxTQ9Z3JxGyaOeej9EUgMoEF4FHhOfLS/P8IE8TWQzvdA+
	 OtxiWHP36XbdwJUaHu+VrRCmf2RPkEOwSNdm3oit+3w0ODfMMAUNM7h1CQzzl6XvjgZyP
	 hQ/pdXD/WbCm+/WWF2155D82o3zv/WonEpuIAuTZoJJl+xzMTI4ce6WfTZYgnYR0zoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fVbxuTR7;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200D606A336
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C200D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fVbxuTR7
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f04bea9a93so35071055ad.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795501547; x=1796106347; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mpGQvJviYasWyAsTrcg7sxjiOrvcQ5Fx+ssD1xXfttI=;
        b=fVbxuTR7ZvuW+s7OVdaHHBV+7uPpbE/pl8CKCM5mFwmDpYqUn5GAUER+witBpDuc1E
         pLrpfLGFEPeOstvVIaYTpDqMLXxVKhD23tM/jotQvTEJ2Uz7KveP5a7/oXAfoA/x6tAf
         ywKEojGyO7UoKutiDgj6/sTXSaxXGIIN/YmSQ40ymKzAKx7K/GmOn/+lbfty6ikWTuHX
         8kQMP1GdKMwYdt2Kq+Hb+sYWnSK/B9/wnKbkL2qyPyYd0DT/17Bsvle8xxMncSLot1th
         QkOqBpAyYBUSW8bMER00RQ6IjQrVb/lz8eJME4+ZqGo6goHIxKKVLk6j+mBhwotfCWVQ
         4rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795501547; x=1796106347;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mpGQvJviYasWyAsTrcg7sxjiOrvcQ5Fx+ssD1xXfttI=;
        b=IK1LuqVW2huO75XRDsLbDoGydRWmco6xQcOJTxBdjg8Ba+pKufXm1ia70pAGjOMUMU
         JpzS48nmnBJJYQfHixbxMQ6HhHavNLRSmz2t9Ktu5zeW+gIPxLsh54/P9fZhyGZcfwEx
         VGKQLs5bYFPEnJhyOIDDEY0GrWQQYeOeCSDwdEGRXsrmHERJSRuqulxWI/Pj8Ob5wzyf
         YzTDyIMOiwNtpWzd5dZkJOVevEqF//P8X03MUhm/QgKpRY+/ZysBF075hPO1eN1sLUj6
         XLES6GNfcXD3mYix6BOqZ7dG3Nl4MkIjxruzLzD2zwcidYCwWI1PcU4/zzEt9aeu6xD+
         teIA==
X-Forwarded-Encrypted: i=1; AL+hErF7U5dlZhzBJBq++wms5A/Wt8i6k9ux7on/5WVYc7vmm8y6yGD48NujZ5l31IcCFf3AbFk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iCCSwP2Roak0bCQxC93reAP/YKDIPrcOE0v7N/LYF+++Z77B3
	yeUW0JYIkpdKrdjh1ONCLbcZ4HjRD7mzhbpq9oRmAfKwDh8i0BH/lDJI
X-Gm-Gg: AZFdTZcbuEaXZZ8hB3fqztl8aL6Iw8gfjai25PQnuqBGb1mSXKkkUZOOFkQ8MjTFfIG
	KekU7uNJc/VQTqngzl+2T1npeiZQvzkSECRqlaVoFdFxF8q9alRafYndb083xOVqTi/UCn7FXEt
	FlCE1B2N1HyAbyma7y4gcdDGfY+7ZKjP20te1MJ1TiJce1cK5C90LIeTVuwVXhU+87l+Hf4iLIW
	nsjeowSDWpr9mX02D0jHba6+u5+CiWmOzLt+GklrgDl4s+Fs3t4kf0tE0OgjOp8uaPaKcXUF90d
	uuOY0CO5Q8DOiXisM8Ce0NPFFaLqYVfCB7PdxSmLdHgVBVpF+vrITH9+DGRoWygVWcuxgQB6zLY
	Sfjqm9VfibHUXn7aEqbFAldl9WnYPSLhZVqNFfwAOFFlGIhP2iLG0gv3jLUAF1zZY0Sdt5u6EX8
	t3Yr4Xa7ifaztKNOBRx5wWEhdS8bG8r1HUvMr4CM0D5vdpHmZD91iLNp3tgsCB27pp5gBQ7IWBO
	qKEcKClmw7mx5Q4OEI2sRcpNYI+D1+U1GwqSZVw+oZtv3C/TWw7O+WdukGgD7IpLiJgfhDxytp1
	BFGUK5wEmopGvUwafLQOZn/x0PnznTq9dzzN72a0Nkh29VHOIrkYqr47n+uYMKc0mjlbQLzOY0W
	N8XOI/OJLXphQJ1o1rlxnPEfItQBbOMitLg==
X-Received: by 2002:a17:902:dacc:b0:2ed:472:b9d6 with SMTP id d9443c01a7336-2f03efb1397mr149727415ad.2.1795501546773;
        Mon, 23 Nov 2026 22:25:46 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f191464sm65713305ad.1.2026.11.23.22.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 22:25:46 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 06:25:45 +0000
Message-Id: <DN386F271FUR.35EWQWGMEMX7K@gmail.com>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>,
 "Puranjay Mohan" <puranjay@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Andy Lutomirski" <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, <kkd@meta.com>, <kernel-team@meta.com>,
 <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups
 for user address faults under SMAP
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Borislav Petkov" <bp@alien8.de>
In-Reply-To: <20261123185124.GAawSLLMoWwJ71nq5j@fat_crate.local>
References: <20261009024925.3169077-2-memxor@gmail.com> <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local> <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com> <20261122200848.GBawNL0FcQoK918YDI@fat_crate.local> <CAP01T746W=8FFiJJUM3H-Qv09uRO6-XEi9B-8pjSgtpAPBx4EA@mail.gmail.com> <20261123003036.GCawOJLKK1iX47XTDm@fat_crate.local> <CAP01T77EgbuyhP=zU9L1hwYL6rHaSbrqQZGJR_+9AQgSWLe7Nw@mail.gmail.com> <20261123025529.GDawOrIQcDOPhgWwF6@fat_crate.local> <CAP01T75Qps8bKFZAU2gN-3UJTB1aWw46NG5c-sm6K028rSc9sA@mail.gmail.com> <DN2E8Q9V38IF.3O738M7NGLSAL@gmail.com> <20261123185124.GAawSLLMoWwJ71nq5j@fat_crate.local>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 23, 2026 at 10:51 AM Borislav Petkov <bp@alien8.de> wrote:
> Look here, our mails crossed last night:
>
> https://lore.kernel.org/r/20261123043409.GFawPCQT2M-hz0mvZP@fat_crate.local

hmm. I thought my diff answered it already, but ok. Here the answers spelled out.

> 1. How reliable is is_bpf_text_address() and what happens if someone manages
>    to pull off a hack which bypasses it? In that case, SMAP is basically
>    disabled. And yes, "no one can hack this", "can't ROP-chain around it" and
>    whatever else is not a good answer. This silly function becomes the last
>    and only line of defense.

SMAP stays enabled in that case too.
The fixup doesn't touch CR4.SMAP or AC, and it doesn't retry the load.
ex_handler_bpf() writes 0 into the destination register and moves
regs->ip past the load. User memory is not read.
A jump straight to that load with a user address in the register
gets zero too.
The range check gives the same result today: zero and no oops.
My diff has no is_bpf_text_address(). It checks the type of the extable
entry of the faulting insn.

> 2. Is the rest of the arch code going to get "if is_bpf..." sprinkled around
>    it because of some other performance argument?
>
>    Because long time ago there was a pile of patches which did sprinkle "if
>    (xen)" and they didn't go anywhere. The point being, special-casing
>    something completely unrelated is not going to fly.

The diff has one check, and it's on the type of the extable entry.
error_context() does the same for #MC with ex_get_fixup_type().
fixup_exception() has EX_TYPE_BPF already.

> 3. What do I tell the next userspace program type set which wanna do "if
>    is_Y_program" in the #PF handler? I take them too? Because I should not
>    question their design either and who do I think I am to question that?

A JITed bpf prog is not a user space program.
It's kernel text in ring 0 with an extable, like a module.
The bar is the extable: kernel text, an entry for the faulting insn,
and a type that says "load from any address, skip it on a fault".
That's an inlined get_kernel_nofault(). It isn't specific to bpf.
If you prefer a generic type instead of EX_TYPE_BPF, that works for me.
Then get_kernel_nofault() can use it too, and
copy_from_kernel_nofault_allowed() can drop its user address checks
under SMAP.

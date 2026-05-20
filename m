Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726593ECBC8
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287505; cv=pass; b=bATkpKbZvGgKy5gIk+yaGHIK3a4FJ5ZN9vsXEPLajm7minPTg72fOJEx2fPIyougkOFpimT6BPrmiEIzKloYsXVNFxMKM86B7QqF+ETCfA3GAtukCLfhxojuBs+B4wT+iWLGLgSBpxuIsjSY6t6JG6ElhokIHqp6LHWb/aAwmUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287505; c=relaxed/simple;
	bh=MUi278I1pZtdv5LA/JQWCWwV6SHMPrlqEfIbohqCo7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTa5HlENhmchrRXH4HYxPh9G2Bu8Lt5on47BYRR4OJk78p/emmJmEREKBlhvZLQ2ON5L6Q2kpgluznUrooHmUr2fDcNYzrtNXo7Up2eruTZtwfj73RF+4BuhmiEzyl+9Jo2ViLi5EgCGMEQqvHisFX0g9322HB4BzAMd+taBfi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxgn1oYq; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxgn1oYq"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44a74032ff8so3573748f8f.1
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 07:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779287500; cv=none;
        d=google.com; s=arc-20240605;
        b=gpPhlIX6KMoR90wZCznCPW2nhrqaud2iCRLCNUMwRWPy2buDLnCZK2v08lZfGOBoMn
         tdUGE0l5JIsM+Kiehvp2sdq5m8CNs6xojDC34E3oKOh+/S02Nh0Fe4RHYJIq8LWonArE
         TwMEWV5G4MLiU6kIMGtRwie+wGHjbrq3JpBsL2o9aXvYQRSiTCJbXjDyA0OTPNo1Wy+B
         u59daTiObOHo2ZjLBdCaCyqYkeIsBf+0V6ZSYuaU+OyA+OgZ9rTwFsOOHjpnoih8QTtH
         SRIRdhENK6cIXkOxOnzboBWfXjosIvwagyitg5gBsbihYgD/hJYS54H+jVyETtnfykJ2
         d4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l+wF22bF5EmTZVPtYuYx3YYi/+1MmDMRoeQxqbotBDA=;
        fh=2s4OnOL+Fu/e956YtZ+LpdSSyIyAfs1TfYkL6LV4G/8=;
        b=eEFgmUs8prk2J4gV65wnJ+6saeaPQNsqa32wsl1TZD6O3w/NrikNZq/r84oPD9OQ6b
         WCm+l/P2reoIpa0gQhnkmQpjkNjsyW88G82HVt2ztLy4w63/fNieJm4uwC1EGC578LED
         26RByb0+SxQJpc1aAzvOkdyGXEw8Y6WjqnegFpx4n93+3+LsMzbwnvdmqU4rCz/kxAfM
         4EwRDuLttuB12FXu319k6uXCDSmksmPatLBmLxVoj2vaC3a/ouPAf/D4g8u74v0IDRhw
         4vWXR1DCfmOjgxYjwCSmvd4W02g6O6UBZl88SFys8x88SR/xnC+04MlIBtq6C6vIDUq+
         rbbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779287500; x=1779892300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+wF22bF5EmTZVPtYuYx3YYi/+1MmDMRoeQxqbotBDA=;
        b=pxgn1oYqzk6NlYkQx9eGTB0Qi6NHXoH1cFHSVHWjuHuM4O5XtEYQ0SCdnQ6BOSLsgW
         FjT6PGNEyL2anhdJPbppcIuBQOkqkrMQVij57qMqhnn4IY85PCzcqiwfzlvG4bCo599H
         AXhDBMhAmMjH3BNQE7LG2+DPwYPyBQ4yshPIZjT06NurzfC108Y6P4J92Kgq0p7RaoW0
         /C6featBXNvsgpokC6slirkyuvYg4eXot6TwalMMnx4uVTNFJWXwkdLwx8+tHoi7EkTz
         hGkToi+FQwDwHZ8w0RSgxl8e9NHozCedWalymcOHmVKbS8Kc3xSE/ly7/ilKUwim5lSP
         S2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287500; x=1779892300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l+wF22bF5EmTZVPtYuYx3YYi/+1MmDMRoeQxqbotBDA=;
        b=MD7FoRcJHkVpE09euAMWa8RtvutYEjSpiaDkmmoRSqiRU96MqlPd5vk87fzgxr5PU4
         LwXoVH8ONAqJJXkh0t2k4mC7U4imaf2iQTm3+O1vo6yv9bzlvmFFWf4/ShJTm5Uqqgiy
         2lmHh66MRA5LsluhmG+4iWVR9kQgWusfFixTLkjdUtCHAt9/DhtdZmJwYQV1AmdMrkJ3
         0RVwe61s2OiE9Tl1SRtvHDcUUSnbL2AX4CHv3q7+O54WA1t/yTd6+HvcpT1thAvZVe80
         OitNHqSIkROPWIGDZaIv87sHHt7oyGH82js/FHZMxEmSVB5hFg8ZpXIIEf8mI/mtRwAt
         0hmQ==
X-Forwarded-Encrypted: i=1; AFNElJ94t+WyGl34UCgcfMXI81ZqKz6hrmIC5Nb6DFULIolpHEYbIJL9+sTVR9pe9M5QJ4FeRqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykj1J122N7lp1jtfwfYPrcu7HEcAUQpuzXJEW6fDl7XpD9sG7v
	2DzqyymmWxjrV5CpotLjBT9VZbCqAHv6YmGjM1OmIOa07x2x8GJYq4mrbcFNc6Av284v61XWZng
	lzGE+Wgn0r7aJynQ+Cf14v9+APtf13ZQ=
X-Gm-Gg: Acq92OG5qhuxkMiCEPrjtxPw7PIxIlrRrWUMlZp8lmbqrKEz/EZ604LO4eIkhG/cpCG
	FCfFvKnSOoZfc4p96N/k/oWfNKQxKvhwdlJvtlY4sn9YU59WyEbdE0Jl3Xz6sHzsiawRcHO4uD5
	soxf7iSBowuWG5FVuAUXjCUZnnzf/YOC3a8r/2nTyzFOR/2RHuXDGUYNhaaOsJ1rMqXdDeJIAk0
	hOprm9fR/hoI8MFlmLg5EGKe5D9eS/TLgxb3Ka3Un6giqUjgNaXIOOmyxuxOpoU6i08wVRa72tz
	zifd1TYC9XYZpPtUmo0ZBOMuZoT3YTy60Bf1rNFOTkOWEJt8RC7qgpapEsxWhWkRK3XYhJVmj/Y
	oBHw=
X-Received: by 2002:a05:6000:2489:b0:441:36b7:725f with SMTP id
 ffacd0b85a97d-45e5c57d4c7mr39111981f8f.5.1779287500133; Wed, 20 May 2026
 07:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517211232.1670594-1-tj@kernel.org> <20260517211232.1670594-2-tj@kernel.org>
 <9ba50fd2-077e-4291-9276-9adb18186873@kernel.org> <agtuPrgIDNKSu2Oo@slm.duckdns.org>
 <2f02d90d-cdc9-48ef-abe3-99e00f22595f@kernel.org> <297658c4ae2d6e7103f5968efc936224@kernel.org>
 <04b03066-86d3-4c0b-b077-307fd0f3bc9c@kernel.org> <5590fd3d-dae1-4070-b52f-bc40982ac678@kernel.org>
 <agyZxmHoueGwBAQg@slm.duckdns.org> <CAADnVQJt0p7hSn2G074QZRh2LEdthy3RKYJ9j3w5yeJ-e8UQLw@mail.gmail.com>
 <fb889bfc-af0e-491e-a69f-38c2abf88d22@kernel.org>
In-Reply-To: <fb889bfc-af0e-491e-a69f-38c2abf88d22@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 May 2026 07:31:28 -0700
X-Gm-Features: AVHnY4Jfl2x_h-7nV11QrGsQRKElNx9baYm9fCq6a9rlTD86qFRr9_qH0Fp83GM
Message-ID: <CAADnVQ+j4o0Xy+cykSdx9txSqCouy0yHFaA09qTJp3OVF3VaRA@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: Add ptep_try_install() for lockless empty-slot installs
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 10:41=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 5/19/26 21:04, Alexei Starovoitov wrote:
> > On Tue, May 19, 2026 at 10:11=E2=80=AFAM Tejun Heo <tj@kernel.org> wrot=
e:
> >>
> >> On Tue, May 19, 2026 at 11:40:48AM +0200, David Hildenbrand (Arm) wrot=
e:
> >> ...
> >>
> >> Wouldn't it still be either or with both cases being okay?
> >>
> >>>
> >>> ... or can we run into similar problems with kprobes? (I am obviously=
 no bpf
> >>> expert ...)
> >>
> >> Yeah, I mean, that was just the first TP I found scanning the code. An=
y
> >> kprobes or other TPs in the path would behave the same.
> >>
> >> When this fault triggers, the BPF program has already malfunctioned, s=
o it's
> >> not going to be a high frequency path and performance isn't a primary
> >> consideration. So, anything that can ensure that the kernel doesn't cr=
ash or
> >> lock up would be fine. Any better ideas?
> >
> > As you guys already figured out the trylock is not an option.
>
> And that should be carefully documented.

+1

>
> At least in apply_range_clear_cb() one could similarly switch to
> ptep_try_install() to at least have both these paths handle races in a
> reasonable way. (having to handle when ptep_try_install() is not really i=
mplemented)

You mean to use ptep_get_and_clear() ?
Makes sense to me.

Also noticed bogus defensive check there that should be removed:
+ if (unlikely(!d))
+   return 0;


> Anyhow, the documentation of ptep_try_install() must clearly spell out th=
at this
> must be used very carefully, and only in special kernel page tables, neve=
r user
> page tables. There are likely other scenarios we should document (caller =
must
> prevent concurrent page table teardown somehow, and must be prepared to h=
andle
> races if other code is not using atomics).
>
> To highlight that, we should likely consider adding a "kernel" in the nam=
e, like
> "ptep_try_install_kernel()".
>
> I am also not sure if "install" is the right terminology and whether it s=
hould
> instead be "ptep_try_set()". (set_pte_at is the non-atomic interface righ=
t now)

I suggested using the ptep_try_set() name too :)

> Further note that last time I talked to Linus about arch helpers, he pref=
erred
>
> #define ptep_try_install ptep_try_install
>
> over __HAVE_ARCH_PTEP_TRY_INSTALL

ok.
I guess __HAVE_ARCH_PTEP_GET_AND_CLEAR is legacy ?

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793060330;
	b=XXozwZZJX3S059Z1UVO5K2dPifXNndeAXDSSFVqrr57K5O1/5IyiJY0ACkCGI14E9x6e
	 n2qEwbME1C996d78auZSBAVWI87mG0jB9LJbxFdsjxW+LcFCRp3a9AAmbFqee5xwzHxZd
	 kI25alFnEZHHJcjB9k+QzqWa4MjzIfJSqjDBCuxSpZ9r1pzmiFyiAH0KOmXEm01eoEY1/
	 Zco7FhsG+E90pqPHnZQRSc2dLvvd1z9138yhxvj/bSFA5eSBVHAEqsq2tbja+weila3M/
	 N2/Ji5JNZ4VF+nhW9S9PqpZWEjq7GqdlvUXZ6TQyBW/C9U+RQsL02HdTsyDNtGkrciA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=lvNHjFuK7gK6C7+v5tfwbMd32JFC2NAT9TkLomtYJqc=;
	b=3Pp/NauZxLe93+7BEOR4WaWVyAasBkDg/dfccBNqtdo9aUBF98Usceatr7vy2dL1m8aW
	 UDIDLlZRNCbASyxAuekebcYjWViPi+ZyPamVsEAqT6twTM343ua6l/VqB5tH9YsK11zPg
	 eSkEmK1FOZRm++fsEZOth87Jde5xQvruX4eqQEjcUbjM4YaRX1aBa4F6NuHsD0dmz0PMx
	 p5mC7Gb+PmPpLZ0zIk8UxQ0l2QqZBoX5ewNNTwE7BWIRZU1YvVIEn8JNvtw8AEbC82Bdk
	 6E2c2K4DuNj6kCCLcL5XyAKmYvwBBDJvG2/zW73h34S4/OHOGXdn6C6jj8L52wfSQ0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="jkxdLN/b";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.71
Received: from mail-wr2-f7.google.com (mail-wr2-f7.google.com [74.125.225.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3A606A31E
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 00:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AC3A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jkxdLN/b
Received: by mail-wr2-f7.google.com with SMTP id ffacd0b85a97d-48e0c9bc8f9so1697717f8f.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 17:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793060329; cv=none;
        d=google.com; s=arc-20260327;
        b=HYb90+tg8Lor6WP6Mf+Zyv90pheB1l+BI9aR3MESLr+VrekWJA1Cs/zasuIodMM1Qy
         zbWcRE4ayz2AV+8KqqAc87eSBhn16n4Oho7Z99CVwUbAgwUbcAL+f/F59M8fD3DF4sYq
         l0/yCR+kArU75CSfj1s5d7BvC5qzNgGKn6wpkFlwXrkCYmyofMmOX/cA3V/zG/TH4N5e
         ztj7nB5NoB6AP4MILpLfrB0Z2ILLe42ul/HuTaTN7kEB9fI5fzHZssKLYVfBqvK6kCdy
         oWVuhXNm1RE3ShngqNe97McMHeqomJiHES68WnQOHdnWhNq9d/iw2cCYxb0Y8lu3ypCv
         yZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lvNHjFuK7gK6C7+v5tfwbMd32JFC2NAT9TkLomtYJqc=;
        fh=nK4o+E/nKAvNbzKwQovufHGBef//cfTPEviVumPIXzA=;
        b=NouqPGPDGwPViHdhi8OKdGJ11SXEFZU2Dw+mD7xsFPlxmSU7J+5ugv4QI0xvZkdgM5
         JnwcUqE7tGvgfzg334e4fta/X7iQENDGolLI96z+96T0hutrWCTTxEr3pOrJ5xlDt+A+
         imzAi3AX4j3w5tvdV9dF4MAS5oc+969soaa+1I/A912RiSfssBfcE+eEhAG8l6tS2+Iy
         ZQiyF7nE4Nfvb38s1YWj+kCuH1Btj3ktdES533PaslpuMGIMbvVZU3Fd+6YvkFsHVEgn
         1tLb+yoVf8Hx8cAGCEifv2GpS6EkIhQ+dMfpp+AmF8YJ5ts0wUMi0bzh03IU9ObOFJbF
         e3tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793060329; x=1793665129; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lvNHjFuK7gK6C7+v5tfwbMd32JFC2NAT9TkLomtYJqc=;
        b=jkxdLN/bY8nH/RhTARTGhy9jHqSRcnhDSIWUjZFAIP96VkQ5Ad0BSWXkh7WDn2+R9Z
         6h/jQV2VV/Z2jNiMg5qhFcwfahkR+GHugg8o65uQGUsAVo6FIEDm0jIvdDl04ar/tQp/
         O4TLP74eIx+xSZ5Ak1u9dzF6x/ARo+Kiu0wflOwwg7GBG9HR+a1pv2/GZ/GSfSMY+Xfv
         iZNNnGRscZ8i5rA1K9gmriTu+cx4ao6IKQP+5Rv6lt4cL/xr7HGOXqWFuhm+IXquDkPM
         2wLeaXiv2eP2vpRtA5GvaODXDmAcUQ4x0A4dsAGSNM0/tT14Myn+hvu+ZfCF61vDRCGd
         UXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793060329; x=1793665129;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lvNHjFuK7gK6C7+v5tfwbMd32JFC2NAT9TkLomtYJqc=;
        b=dDZrtcnRGWph1JLZQjcNgXis5d0Iocs9KbERv1hITCYVvnArvfDymnXur1QhkkzCFK
         RFBxD+ilBp+KaSRXJ5MHY43+pRD+q+VWOnXbznlfdSR0FSdzNQYKbGrT8mM5rGbd7av+
         5hpYrtDuzjo3PoluqXX6752ByenrtWtHnNQOIG6svkPp8XQk4kro0iRFpQndeaCamLHU
         KOvxWR9rXG53Q4Bxgsg+CShiDLwrdt8oKRHNmeC65YPXvElFnX3H7B5iStbBDBsmdQXK
         Lgq8QCOyXrq6lQPcY6qyKDVShRbspLU0RA6/J0brlac1aWVdZi3Sb2pg9ASapyT20dg7
         zVqA==
X-Gm-Message-State: AFq9FYKIkB7ECyGKMRW1SMDulicRx/P+bZIT19QiFy1iYKJdaCxx4L/a
	2fnk2N0CZcWph8tV9pOPyISvayskZ008p1DeCb6gxquJt8btnPbCTyV3/mgxC5QlcHUmzo8shwj
	ZNQ5La3kfQiYCRSaeDSPGEo+td0WK4wY=
X-Gm-Gg: AYBFou2wVcxYZVZCzujS2qX5WvePRkXZZHwf+PH6Am2Tf2e2C64+z14WkN4udSAQWBQ
	GSQcS/LAmCMJ/pfXyNcxU3YnljJkxdwWgmc+Wj2Ho/okXvGXfyGv5BrQJtHC3UxQt19kqqar668
	aJQFR2Zw9gQSEk4s8dvzp6Zgmpt0qdirl4WK9RBsvofXWo8ztePtFGC41HiXBpJHIaZhNPO3ojJ
	HekvILYRYZ4y5abb53pvylgnX7oNAESWacKqk3FcNAfH+yuJ6gthdSIly8TfClJ9tC7ID2eMbjK
	KAp+YdXdf9eRqLEhj8PQG6iQtoq3YgLPfogpTPreRLBfWdHC3qUH0I8ZIU9s/isGicAJq/YRSFe
	XyzLgC8i+tax4DAUmiR8UL9kCBHK5lampM3kMQoAU6CEhhX8rnRSOurTWbJo9uRGa+5sFLMiY0K
	A989bXhYPj+yvw2jgubYN8dQk09zB4ZT5QyKRb8Fs2TYW1G/74BCEW1mSuACriK44vxqKJprNZB
	HlNannwYdOB8SJ3
X-Received: by 2002:a05:6000:2905:b0:48e:2a6c:153b with SMTP id
 ffacd0b85a97d-48e3eb912e7mr17820010f8f.35.1793060328666; Mon, 26 Oct 2026
 17:18:48 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <20261026025943.404450-27-alexei.starovoitov@gmail.com> <CAP01T76dRouzrPOZS8AQ4TMnJ0GzyRm8cPJ8RYUTu01bQgf2Xw@mail.gmail.com>
 <DMF694XH2TJO.P59A31VE6GWP@gmail.com>
In-Reply-To: <DMF694XH2TJO.P59A31VE6GWP@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 27 Oct 2026 01:18:11 +0100
X-Gm-Features: AclHuK_rQq4aY4gLsmwJk3J8RAbW9XhaCVV0eE7gQiX4v19sFSvLD7gCnwNjJcw
Message-ID: <CAP01T75HAHkP4bzdGzeazN4n_FNd5w1Pckd3GBN68V0n1PNe_w@mail.gmail.com>
Subject: Re: [PATCH bpf 26/81] bpf: Support BPF_REG_ARENA_SP in the verifier
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Oct 2026 at 00:51, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon Oct 26, 2026 at 5:47 PM UTC, Kumar Kartikeya Dwivedi wrote:
> >
> > Some initial questions without reading the code:
> > How will this split stack model work with trusted objects whose
> > pointers on the stack are taken and passed around (dynptrs, iterators,
> > etc.)?
>
> dynptrs and iterators won't work in rust. No need to drag old concepts
> into rust ecosystem.

I am less optimistic about this. For certain things, like open coded
iterators on kernel collections, there is no other choice. This is
also true for sched-ext (where we iterate over tasks in a DSQ in
various places). We also have bpf_local_irq_save(). Likewise for
certain dynptr types that touch actual kernel objects, even though we
could replace them with slices/fat pointers in Rust for normal memory
accesses happening in arena.

It might require teaching the compiler not to move certain types on
the stack to r12 relative accesses, but it just feels ugly. Also,
unsure how various assumptions around address contiguity get affected
when stack reuse occurs, e.g. where a buffer created in same slots
previously holding trusted contents whose scope ended get reused for
an address taken buffer. Perhaps the compiler pass works around those.

Overall, I think it is less clear to me (or anyone looking at patches)
as to why you did things this way. You've mentioned the problem with
conflicting JIT for the same insn seeing PTR_TO_STACK/PTR_TO_ARENA
before. Are there real patterns that existing stack tracking simply
cannot salvage? More information around the motivation and examples
would be useful in understanding all this.

There are a lot of patches, so perhaps it is explained somewhere that
I missed, but otherwise existing explanations are very terse. They
tell how the implementation works but not why certain choices were
made.

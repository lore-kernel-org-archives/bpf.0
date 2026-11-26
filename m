Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671518;
	b=Q6+kFo+pSTlh+hSoPv8ofV6IxOVSWK83rwm0MS/syVzaCpncYyr8za4soQu2XXkx1wmm
	 PNm2Jyea6pCjVFHEjuwoAplRuLE39VJEWe2TsyOsrZdQRzE38vH32T8kAOEoz5/FP4P2S
	 kzOpPU2hrSjuNVxU7eD6KUXYKxTpI80fojFzRkFcLYmuptByw0D7l/V+N7MqhpolkrXIb
	 8qRb3J7LU+I9lqxXwXOOb5AC5NRSRQ+GvsRjsMdk3Zii/msNC7qKEsCmFF7qf/xw7U4sZ
	 MWCKqYlrjdrQZjaxWGgokv4uSx8YBcPZ4rVhAnGhO3MsSYzkZ4D4IWHFi1SUfKzWFSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671518;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=fF6iLg7K5hOrnySQEXPXyu/mTZlnOMFRavzCIW+zF9A=;
	b=DheCAEjLKGXVTzw7BHlBdO7Voucrpx32Jjm0u+4ek9ky9MhHmF4LzyijWGsT0Wb4X1lp
	 8xTdicISoqq9QLiqnrwfF7Z2R0vm54Sp9gMvJR9bECzmYF2gE9ThTFRASziOhUk5/Sp2K
	 qBmJakQIQ4nxafsD5dm0aFzQaarNQeQtp3aXw7MkCJFgBdfzsUZ909bNfVd7xmyGzW0Zg
	 WOtD8HBbZL18nNRUI1RUPCm76GwfAgvdLNm0D/2tfIrkUQiis2cc9JnoXVS2IKyleeHaG
	 S+coizLD3JmgHg6PbMs7JSIsMBBGjgIJvOFuxmXmxnqCFi1oAa9TEC1qKqFrytPKl8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Axn59QpV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37CF606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 05:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Axn59QpV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0951F000C0;
	Thu, 26 Nov 2026 05:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795671518;
	bh=fF6iLg7K5hOrnySQEXPXyu/mTZlnOMFRavzCIW+zF9A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Axn59QpVakGgNyL3YGUW2y+MNysVDkwBJwXt2bwGyGWwJ6ppuSsBM4Zxfg4d3RUgm
	 ZmzaFNR1jJs0kRTyIaq+asqXVGWJbqAFIUuAvgvdi+CxOJPSI+99urH075WOGpWR5n
	 btoW38OJ90yh1Pq22faxdO2hg9i5LN5e9GVqN5mqfXCqTVsvWV9Y2E1MU/0UcE0zKK
	 W47NgC+oNZtYAFJxl1K/BoKbNNjeV2gDoAXGLv0c/aR6HUSjKGzzf17uJA+85EgoSa
	 OhdqMBwHBthbwBLQ809oKm3F5SETXI9ear00rgGHcxJyAEdOuSbwEwyyCpMIm3fBcX
	 Hvj7PSW9DfsdA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id BC164F40066;
	Thu, 26 Nov 2026 00:38:36 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 26 Nov 2026 00:38:36 -0500
X-ME-Sender: <xms:3MUHa7CbtHZzfdflziH6xls68Rrs3Ac3bam82QjuBPNiGD14dMPm_Q>
    <xme:3MUHa8U9ldCHfoskHzX4Aypah4SgmbGNhcmzs6etnkA_98WpiiRWAM6kTwd8aW5o0
    TmM0ysbx786avnAnM542Q_kGQw4KFoPVviyz27LXlgZSV-K7Nthfnsf>
X-ME-Proxy-Cause: dmFkZTEusPZhsxb8yJH6h7uBLIaqXnUP8bHmTmhMylIFaKiuE+AYYytkULIsfUoy6qXeN8
    b5i0khJN7OXjg9Y+Vdo6TGyEjxYxp3vthssDQSyfalzXvwM5CG810DESHYIdDhLfQX+nAp
    ruBI6+93JhwIWUIR29iGTKRP1dnHJKBJUA8B4pPJ4AxAQKUtNwHtvIKhqnXmyZ0jKqMyaA
    lomV5mfFKhNe0pGHdRKtq7fZJv72Z+/AP7zsXEdeWZ5JaiINZRy66AyzTAJYrD9vN0OIdO
    jHxeqP7JNDRJ6EQtsfoKnnAkCrHl/ALsOpMS5TsQFoCMG3UDHkGIsMcBpEW/PReBlc7BhZ
    1WZnufz006UaAyz07e8soRVwBaFQBd+Dx0Wz1CzjECXa/2SbG5k4dsw64OQiq407WfILXy
    SHflvqaniiyRYV0ro7jYAGbfL6BGr1hBfEbLHELnIQ9IfsHNJLrCV+9oyIV2HMOm4cO6LR
    z4KNn+mQDHhCesYPHISJCVXBo/BJQ3o7Dvum/KhxYs7lSGEccyIxW+4P80udGtkeu7rgFa
    L1+kSA4jIJvq5faIO9MITpcIAaIChF8ykGcya5tDZUxioigMae5YmTFi0J5atqApDbkpkH
    HByhlxFFUeEfuYDuXXDtEKaSec/O9mtwo6uUsLlfpvn5nIeFjP9OWuRdg/NA
X-ME-Proxy: <xmx:3MUHa5kmJpfNEXhXclAicIQDtXsCiCEhXkOR_NpfsHytb_d8GDUMkQ>
    <xmx:3MUHa6UEly84sxWDGeXBwqWF-eqxBK6T3r2vrNQXz6iRxlLT8pZFRg>
    <xmx:3MUHa3_Pr7FJmQXGsh9-nIfZkqiyzcAcqPG7cyrnpJu4F6cwgk448g>
    <xmx:3MUHa3oyEqPra-P40x4dkETp2mAwcfPXwiFzlnjIg4vqPpPnq2yKFw>
    <xmx:3MUHa5nQhyAnrF4N44sdgnPk4dnAPvREV4ebdjQpXE91AfgHgDX-0ASW>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 979FA700065; Thu, 26 Nov 2026 00:38:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AisSLPdYCdlo
Date: Wed, 25 Nov 2026 21:38:16 -0800
From: "Andy Lutomirski" <luto@kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
Cc: "Puranjay Mohan" <puranjay@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, kkd@meta.com, kernel-team@meta.com,
 "the arch/x86 maintainers" <x86@kernel.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Message-Id: <5f46d1c1-fdce-4f3b-9d56-675a822b2d65@app.fastmail.com>
In-Reply-To: <DN437OYZ5FGP.20VLV7ZEXQ5YY@gmail.com>
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
 <df69ab5d-bc97-4651-8668-a2b3e4bb272a@app.fastmail.com>
 <DN437OYZ5FGP.20VLV7ZEXQ5YY@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for user
 address faults under SMAP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Tue, Nov 24, 2026, at 10:45 PM, Alexei Starovoitov wrote:

>
> The range check is not a heuristic for "safe to read". It's the user
> address part of get_kernel_nofault(), inlined. You asked for that in 2021.
> Its job is to keep user addresses away from the load. SMAP does the same
> job. With patch 2 PROBE_MEM reads the same addresses as
> copy_from_kernel_nofault().

With copy_from_kernel_nofault(), I can grep the kernel sources and attempt to determine whether it's being used in problematic ways.  With eBPF, this is not really possible.

>
> In both threads you wanted probe_kernel_read() / get_kernel_nofault() to
> tell MMIO from RAM. arch/x86/mm/maccess.c has no such check.

Okay.  I randomly sampled a few use cases.  I found some that are only run on paths where we're already crashing and lots that would require an entire separate major screwup to point to MMIO.  (The most common pattern appears to be reading regs->ip in a path where *usually* regs->ip points to kernel text and, if we have gotten so corrupt that it doesn't, then at least we want to crash cleanly instead of recursively.)

x86 does not have a special syscall to do copy_from_user_nofault().  If we did, it would be a pretty obviously terrible idea.  But eBPF has an actual API here.  I think it should make sense.

Off the top of my head, I see two possibly severe problems:

1. MMIO and, more generally, addresses where reads may have side effects.

2. Really nasty information leaks.

Let me elaborate on #2.  I'm informed by reliable sources (a chatbot) that a common use of PROBE_MEM is to read from pointers where the verifier can't verify the lifetime.  I bet it's not terribly uncommon to find progrrams in the while where it is genuinely possible for the program to follow a pointer in a data structure that has been freed.

This gives something to the effect of:

u64 value = read_nofault(foo->p);

where foo points to freed memory and value is either the actual bytes at whatever address is currently in foo->p or zero (or a MMIO screwup that will take down the whole system in creative ways).

And the author of the program thinks "well, *usually* it's the right value and I'm just collecting statistics".

These days it's easier than ever for a malicious user to write a cute little tool to put a value they control into foo->p.  And they can point it at *someone else's* memory.  And they can get that memory leaked into the statistics.  And probably find a clever way to extract the value.

*If* it were somehow deemed that #1 was the *only* major problem with PROBE_MEM and the feature otherwise made sense and it could have well-defined semantics, I think that x86 could offer a reasonably performant way to do a read that's guaranteed to be side-effect-free.  I can think of at least two ways to do it, both nontrivial.  But there are a lot of ifs here.

--Andy

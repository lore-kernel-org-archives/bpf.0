Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714281;
	b=qA7VFXbviE3QpnwBdw9qv7+NBqWlERS7ZfkoDakzdu1Ox1geCp09WR204i1z6fEmjogU
	 weU1c+pWln74ELUt2MdKi5oRes5225kA+tw2GHPQyV/TubTmXNYFX+ioGnyuj4ZNxZbQT
	 c+XExE37xV4hFajcpH86cIBCPcHaGHoViwJtMzq65A75k3AXXBRPEV1IvsyJiqF4Sgh+3
	 b7ix5k+Gptqj86CcOZe9ubJ0Qk/cQ4itrlk2FlLP4h2qY4ZHK303LWZPvux1wScFj74DR
	 Bd6idmqrWSsks0Ibw0X/U3lQbBID1ZpsvGUwAVysBABg41XfkvXEvgvVfB3dmv4Dwcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714281;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=XC0tYPkdCm6kGN/Ew1gyQrp/x++CM1FLir4uyY3gB/I=;
	b=LJ3brA0JCOlEZNP3gMAaMw23iFSMe1IAEu1bwjMY4eqxqLSn3LOHNLLgc0OzoSbv/xWX
	 MBeJxG4qPU+iyZhAIxDMVbi8+++lfl2jtobWMzyUN2cSugFgssBeJnimvdnsUoGB+sXoN
	 TkeAwFdzt8UVHhMn++BQDy8YI3t4z5YoL6Tzi7JI4QwcCfKKVT6IGz4wx5mGbISGpSBKg
	 jcLcKHwM6TC6j0f3g2mmKhFxjqMLO79UQav0IuuB183D4Beo05UzN87QP8Z6F5q/h+tyA
	 6djxRlOSTQ6+rnIOpu2/e6iR+1FLXQKNBFXZOIEoS1M35EhH5wpiOxiQjf3V0hYfQkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6ku6es5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC96606A32D;
	Thu, 26 Nov 2026 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6ku6es5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3711F000D3;
	Thu, 26 Nov 2026 17:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714281;
	bh=XC0tYPkdCm6kGN/Ew1gyQrp/x++CM1FLir4uyY3gB/I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=A6ku6es5BhZaXCUZHJeX4E+fECuAGJLyoJnbpNRInPYL2zJH8lSFjASKgC3Pc7lre
	 yR28eZCBm7RncuAOu+t8aWRWmiNH4D0RPmhhFIxqWXMVapz5gfDetiPtFLe+DXh8p/
	 65S68viBPUCTDz2qLzZaRjspDkdy6xiSbDn01ebELpGBRxY8W5Q3tRtqdx3xz0LUaM
	 BrbZSmw/1bfWrbQbeXD9xtv3iblEY2gRLX7B0c/P31gP78r4grhTq+tkLd90Ys7R9K
	 v9u2ernUWIfeDiQ1erWAAUt9pmEmlXCsUB3JH9cJm4nMZQQb+JlyONFqQCGkSwlD6t
	 bqwnzKmdvTDrg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 75EA7F40066;
	Thu, 26 Nov 2026 12:31:19 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 26 Nov 2026 12:31:19 -0500
X-ME-Sender: <xms:52wIa-hIhGTYe89nE93XuNhHYj7TBp9eIlqVZ9HO8xTmr6NvIA61Nw>
    <xme:52wIa51OQud2TkbqaD4yqJb2DGYTEolP5FZ854z7VTl4Kar57XnR6npOEQsgpx3kp
    IExxauO9sHKZc2Vx2vOdmlUxg75xC1CPOOXrHFtyl0jsqQbncJyl_3l>
X-ME-Proxy-Cause: dmFkZTEbZCTNDtjI6GW/AXTo8xe88AYyIddrmGGORnQ3FG0M8kuGY2NmaC2ZZvpmhB8u65
    wM5A4gHEX9DR+FhQwaw/3rSwcz1Sr3WcM/J+Lu8YyxAIoOHBea4rIY8wO0tFLLSIfZoqO2
    uxxo54pNRLPABuuarl/bRrN6veMm4l5MO3oAsTtxASsIeRDtVCxZMKCQxvZ95BIO3c5TCG
    xRvxAdgRgLnYchrsqBFmXWZvgDYcWi4VfL5GuNVB6/0MP4IRAmK/jFpky/l8OFGhKO4JRl
    GY9oYptAZprudJhOxvo64o0O3cSJsQHTLIvXYFU8uUAq6TunuaR3aXiE3D7RTO98JLpYs3
    asuzt+H53W9vBz1RoCPPly9L2npjYJsWnHbK+h0gqsA/tbwLCwsW9EiDuEGQgvFxqHyNCP
    TjQ0ntLXFbXO/pNeyL5U8Lyb1ShRqxnVG/S113UiQ/rsMLbVqdbacymGx1p040GmWfGGSs
    1M7ngptAH00GP7QgrWophierBgvIboafMjx2KerjtnkIj1W7epOqcoc4zQvoBQ6y7M/+2A
    6VanXuVz+1jj4xDf9AbIYv1uPxhQoUP2yJ6LW3w6qrsPECVwf+RyQkgo6p0XmbRzjaOHMF
    xdUNtiLg7eTukh/8Sj903zkA1w9ZBR3px48dQcXW3PcwfVOXf1JT+xvWuBpw
X-ME-Proxy: <xmx:52wIaxHmwtxLWu15hBqNEfDkqfcdmxSAV4lFLXZWNJpTW_KQGmzrkg>
    <xmx:52wIa_HWg4wLoBN62XOfsIwvbvZ7g8-l9-moWTiNLYg4eqY_8rB9RA>
    <xmx:52wIax0qCrbqnMCK89R2SEYH_LTSx3tydxesNbh4shXqP6MNsOi39Q>
    <xmx:52wIa5eTAP_onmvVQz8VSMWKhgCI_nG6VxEELJcVJHof1efoeFE4Lw>
    <xmx:52wIa7JAw7RV7eVrOiN2QMJe34KdlHo0Aczr-CnHcJ8uhU52BYUymF4Y>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4FE5F700065; Thu, 26 Nov 2026 12:31:19 -0500 (EST)
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
Date: Thu, 26 Nov 2026 09:30:59 -0800
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
Message-Id: <03275761-8de2-41be-92fd-8e3012a87eeb@app.fastmail.com>
In-Reply-To: <DN4X9KVYMONH.VHKD1QED1BUQ@gmail.com>
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
 <df69ab5d-bc97-4651-8668-a2b3e4bb272a@app.fastmail.com>
 <DN437OYZ5FGP.20VLV7ZEXQ5YY@gmail.com>
 <5f46d1c1-fdce-4f3b-9d56-675a822b2d65@app.fastmail.com>
 <DN4X9KVYMONH.VHKD1QED1BUQ@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for user
 address faults under SMAP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Nov 25, 2026, at 10:18 PM, Alexei Starovoitov wrote:
> On Wed, Nov 25, 2026 at 09:38 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Pls wrap your emails to ~80 char per line as the whole kernel community does.
>
>> With copy_from_kernel_nofault(), I can grep the kernel sources and
>> attempt to determine whether it's being used in problematic ways.
>> With eBPF, this is not really possible.
>
> let me google it for you without bpf :)
>
>   echo 'f tcp_retransmit_skb f=sk->sk_socket->file' >> dynamic_events
>   echo 'p vfs_read v=@ADDR' >> kprobe_events

Fair enough.

>
> It does the same walk by BTF with one copy_from_kernel_nofault() per step.
> No locks, no NULL check.
> The second line reads any kernel address.
>
>> x86 does not have a special syscall to do copy_from_user_nofault().
>> If we did, it would be a pretty obviously terrible idea. 
>> But eBPF has an actual API here.  I think it should make sense.
>
> sigh...
> the kernel has that API since 2009. bpf is not the first user of it
> and not the last:
>
>   API                           since  the address is
>   ----------------------------  -----  -----------------------------
>   probe event: @ADDR, +8(%di)   2009   any number, from a string
>   bpf_probe_read[_kernel]()     2015   any scalar in the prog
>   PROBE_MEM: a->b->c            2019   a pointer field, by BTF
>   PROBE_MEM: bpf_rdonly_cast()  2022   any scalar, explicit cast
>   probe event: a->b->c          2023   a pointer field, by BTF
>   probe event: (STRUCT)x->b     2026   any value, explicit cast
>
> Every row returns the bytes at the address, or no data on a fault.

Okay.  So maybe there should be a nice patch set to *fix* it.

>
> That would be good to have. Every row of the table needs it, so
> maccess.c is the place for it. What are the two ways?

All the ways involve identifying mappings that are safe for no-fault reads.  And then one needs a clean way to access them, which could include:

1. Walking a little list or table to validate the address (which may require some sort of synchronization and obviously needs to be NMI-safe -- for systems that use TLB-flush IPIs, blocking interrupts could probably do most of the hard work, and otherwise a little flag set while a read is in progress that can block the change of an address from safe to unsafe would do it.

2. Allocate a PKS key for the purpose and use it.  (Only works on systems that have PKS.)

3. Use an entire mm for the purpose and treat it as a user access.  This is probably the cleanest solution but it will be slooooooooow.


Note that there is no strict requirement for #1 that every address in the list be mapped.  For example, the entire portion of the direct map covering ordinary RAM (and sparse-mapped areas, etc) could be allowed even if they happen to be unmapped.

--Andy

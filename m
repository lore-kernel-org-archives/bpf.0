Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673883;
	b=WALaeDOkjcti4SP8g3dMBg+yOKqGrtbcuKVGlAEEfzDEUPa8n95xpDkfHwa3EY3OLOrT
	 /ye3svvUzNJDM7+F+c6Spb3Wpni8aIfvDROExMpKZAV7HzQI0qMqpCsjL0U729f2JuVAF
	 DrGEO/WS4wUgEAl2PojQnYMK4b6NjmeAC/IUeq2NYpI4a2oVODWzeydUReN8VvOcSSLQW
	 dWVYpSb8egq1xaJiWr9nNE9O6HPwd0K9TrXffwvw+sCSIVU1xeLQmwZAoPEINiRMt+BA3
	 Mizm5E06hjXsAq+NUADJ06rImD9Z208l54ZUWbuEYN+oPJI2jY6dDZzHzX2zDPSCEAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=a/5pYkYKOsm3brGJSfZdj7PKFExG2uNyudUHdVdQcU8=;
	b=qitUKLkA+rYMiF8w0QqXnylcs1TCslTG55KAOBY5Bb3T3sOMUGAFx1IxDxCSahfjR0ZB
	 UMB6y3oJpy4FTzOJMqbYhW2c4A1pWCpq/PRBzbQhy2XRPKk3LP1VUr3NdnJjRARYINvUX
	 ybAlW+8iLTgM+MaWmjD3XyBPSQZTnzxRsE0fMf0i5aS9ZiplUNUwyFCPc6OVo4OazOa/I
	 mec3ZvqvIF7rVmrdaT+iWiMriTHyCyK8t04sj5VVuNwif1Vn2X2CKIZ3lv0l+dQJVP9ZG
	 1hD0qNr+4FbqmebqEtsfyBv7k0FAcEUiU4ulDVv8odx5F6uFc0pVMxTL0yttsRJvGUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fpiGeSTb;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA030606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA030606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fpiGeSTb
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so4873937b3a.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 22:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795673882; x=1796278682; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/5pYkYKOsm3brGJSfZdj7PKFExG2uNyudUHdVdQcU8=;
        b=fpiGeSTbvNmAV5CWLDvS4NJVnUMnRXVypsIzfoy6m8QkCmQSkqoNLDbPC40D8ofUC7
         3EmklIRyEe6QKFMZSk8uopBf8Z9xKtNnkQmU2D11s8YWYB1q7jWfiRGEBltBsedObCoQ
         lNOnDgaxtfDUymxyffWK07DuAaLxu387WFBBqkqN4ji7lBciNvpocLCxS7uqUCJugn2J
         Xi4O8hWQq5ljgxtKZm2KpWXnlbAoYwcuMgCWWisjK5E/+2BAZBrJ8/Y0VA/aufG7/IQW
         k8gWL7ydUO4LxQo6UG5lBIE2QjRChr8gkYXkVc1jgX+WkMtZzK+RE32YW3SV/PhnKJKa
         BPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795673882; x=1796278682;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/5pYkYKOsm3brGJSfZdj7PKFExG2uNyudUHdVdQcU8=;
        b=tPomrqddMVN5GU36rSc16u95kwgFAbt7hjC8dzjUrD+PHupM3P3yzo0OEw6jg7xWio
         S4pqX6Tqj0e3jo5TmcwAisxAcjwEJ4r2KsC2p+F+2DZfB5bLp0xmxdiq31za4tOhvtgC
         eKpgApKiJyKXG/evMSax636eP8xbkw/3gZxtKdIp3KIFQwqAovn1TWfq50lW+fsjcYjt
         zD8cfxZVZoGHRYKpfdFWr/X1mnuHY3rek1C/SnZvmELBbvL0Uu0//Sur5kt1DYerTXKo
         0a70a/YUw2VR6BqFZQV2FTQtyagUYRkaQEkqxq6Sesz0POMjys9J4K+ieGopq8gslSKd
         kd4g==
X-Forwarded-Encrypted: i=1; AL+hErHJ89EyEMkJ8/tZOBcRXeU5Brz9a7mTNfXtPUos/RTia1CUGNlzvV7ttHrbmPRyyCyyxyc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mF0jWRwl9RUmZSrseaulTc34dtsNgP0TEFq8JfHYHZhXmkUco
	RpY+z6MxVECodKjfk1cyXaPu+AC5HeF3V7PkyZPdW6lO9xo0U1E/PwDi
X-Gm-Gg: AZFdTZfS52DDSSzP9cI3/mFbsodpzjMgR2XZzcIuP5/uuVMYgBclhcJplHDyIYGG1wV
	T9sEp9AHkDs12wQXVPz7kALoiB1Bua0VFHZ/cNsZ0psSWMaYejs/EGmnyDF/uaHm12J83RU80xX
	/FhcuFJS3Q3zQZfsLYI8KgXtgM5l85j8/NM5WuMT6MHJ2m6bnwjxRpF29yDDHTsj8vpt3Hq7v0d
	7pIn5u5/d1LQ72enJqlKdscD78CHydVRowmGk2A4yKz+KdX3v2TPg9kji+gfJ4YI0tT2j5U8Y3+
	x1QjPtCCG7w57gagSbeFjE1I6FSZAAOoFgBYeNEbAtJ61OOzHDKHkJag/BSbsj0qczIHptbhdMb
	iBx00Y5FR0YHbvvGV/OmQ4gPcAAYEsJp6woJEpTAbVIX4ucQVUbOHvZLAlSfF+x5PmZ025rydoZ
	Hiauqajq/Y/GLeRl7FFRPaPxC/SNc4ZzfRrmLH1mlwbUz5ez5l2wpYchc8t9uK/fJ7bI23/AdA3
	0aaEmh6II+QFOkBL+5xLQYdOoGYkx1r5dU9IGAbdJ0QzWa6JcaV2QyGsnKoygPeCF2QzRH8znFk
	aDANHMNeNaSoWjUntoul67qfT83u/uhiOFnwy8WAAWqGXhWtg3ntLjtOOoP4sioEb50XX8dpZHG
	ZbhB4D5n/1y8FyWS4/Tk5KbKyVa6liqqU1w==
X-Received: by 2002:a05:6a00:2d8e:b0:8b5:9654:d331 with SMTP id d2e1a72fcca58-8c87663d9cfmr20655511b3a.0.1795673882121;
        Wed, 25 Nov 2026 22:18:02 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c89dsm10016201b3a.13.2026.11.25.22.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 22:18:01 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 06:18:01 +0000
Message-Id: <DN4X9KVYMONH.VHKD1QED1BUQ@gmail.com>
To: "Andy Lutomirski" <luto@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Puranjay Mohan" <puranjay@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, <kkd@meta.com>,
 <kernel-team@meta.com>, "the arch/x86 maintainers" <x86@kernel.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups
 for user address faults under SMAP
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <5f46d1c1-fdce-4f3b-9d56-675a822b2d65@app.fastmail.com>
References: <20261009024925.3169077-1-memxor@gmail.com> <20261009024925.3169077-2-memxor@gmail.com> <df69ab5d-bc97-4651-8668-a2b3e4bb272a@app.fastmail.com> <DN437OYZ5FGP.20VLV7ZEXQ5YY@gmail.com> <5f46d1c1-fdce-4f3b-9d56-675a822b2d65@app.fastmail.com>
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

On Wed, Nov 25, 2026 at 09:38 PM Andy Lutomirski <luto@kernel.org> wrote:

Pls wrap your emails to ~80 char per line as the whole kernel community does.

> With copy_from_kernel_nofault(), I can grep the kernel sources and
> attempt to determine whether it's being used in problematic ways.
> With eBPF, this is not really possible.

let me google it for you without bpf :)

  echo 'f tcp_retransmit_skb f=sk->sk_socket->file' >> dynamic_events
  echo 'p vfs_read v=@ADDR' >> kprobe_events

It does the same walk by BTF with one copy_from_kernel_nofault() per step.
No locks, no NULL check.
The second line reads any kernel address.

> x86 does not have a special syscall to do copy_from_user_nofault().
> If we did, it would be a pretty obviously terrible idea. 
> But eBPF has an actual API here.  I think it should make sense.

sigh...
the kernel has that API since 2009. bpf is not the first user of it
and not the last:

  API                           since  the address is
  ----------------------------  -----  -----------------------------
  probe event: @ADDR, +8(%di)   2009   any number, from a string
  bpf_probe_read[_kernel]()     2015   any scalar in the prog
  PROBE_MEM: a->b->c            2019   a pointer field, by BTF
  PROBE_MEM: bpf_rdonly_cast()  2022   any scalar, explicit cast
  probe event: a->b->c          2023   a pointer field, by BTF
  probe event: (STRUCT)x->b     2026   any value, explicit cast

Every row returns the bytes at the address, or no data on a fault.
Every row is read only and needs root or CAP_PERFMON.

PROBE_MEM has the semantics of bpf_probe_read(). It came to replace
chains of bpf_probe_read() calls. The risk of MMIO was one of the reasons:
https://lore.kernel.org/bpf/20191016032505.2089704-1-ast@kernel.org/
bpf_probe_read() takes any integer. In a->b->c the verifier checks every
step against BTF and rejects a load through an integer field.

> u64 value = read_nofault(foo->p);
>
> where foo points to freed memory and value is either the actual bytes at whatever
> address is currently in foo->p or zero (or a MMIO screwup that will take
> down the whole system in creative ways).

Yes, that's possible. It's possible in every row of the table.
The first echo line above has the same window.
foo->p is a kernel address here. The range check passes it, and so does
copy_from_kernel_nofault_allowed(). The series doesn't change that load.

> These days it's easier than ever for a malicious user to write a cute little
> tool to put a value they control into foo->p.  And they can point it
> at *someone else's* memory.  And they can get that memory leaked into
> the statistics.  And probably find a clever way to extract the value.

The value goes into a map, a ring buffer or the trace file.
An unprivileged user has no access to them.
Their reader has root or CAP_PERFMON and can read all kernel memory anyway.
A tool that walks a freed object and hands the value to unprivileged
users has a bug. It's the same bug with a probe event.

> *If* it were somehow deemed that #1 was the *only* major problem with PROBE_MEM
> and the feature otherwise made sense and it could have well-defined semantics,
> I think that x86 could offer a reasonably performant way to do a read that's guaranteed
> to be side-effect-free.  I can think of at least two ways to do it, both nontrivial. 
> But there are a lot of ifs here.

That would be good to have. Every row of the table needs it, so
maccess.c is the place for it. What are the two ways?

It's a separate topic from this series. 1 and 2 are about loads from
kernel addresses. The series is about user addresses. Today a compare
refuses them. With patch 2 and SMAP the CPU refuses them.


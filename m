Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589102;
	b=hBDSsNFMbKb7Z0Pku/rikPaHPCA7LpkWgjdI8Gys/vYPTOxvbEi5puTHR/eDp090dH1c
	 +1UbxZm6fuuQWvo7JvC238bSPR6rEmyc8wLJ83yR6/wABGHu8NW6xEopyO4mzgO3wb9Vi
	 dfMIj/62SEBkYpilr/y+dhwZV6QMvKL8FMWAoPfu2JNWkUxEiJH6vs42to2PZl8uymH+K
	 BJVr2q2iK5JdZOtzH09w/sGx7XeYr3YDV+gpxjRHK7UZuY2ohYO9LODVQ7o7QtQL3JfPw
	 RbkWOLt2YrqtKk9IxQnl2TIlSk3I9lsgjbqaMiZGIAqp1q3nsI1BtbaYm74mWEE77SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=R3sbzhOnYUrS8wYvSIhWCG5ex9jxl9wVxRyhTnmBIp8=;
	b=bQLyyF1v3gmjVLL3GYigLfIV7VRHKC1g4HIg1VzX5TuyyBoh+ZtkC+Nv3hehYmeK0Bdh
	 oikD1WB6iJ2O0KOu1zzpBqtiIlmyRCTJeH2A4O+Te2R3z2Huz5eZ9YsvXSCbDIZda8GOH
	 7WDFlvjOViX+3bBOMnVKu6am/tZCTBzMI2Q2uCl9OwfqO0VA4atqhftyVdbS3XBxJwN/a
	 RHGPQ+HbNSv0gIb740qny5xXesrd8en9OmLuez68STM+Y9r9ombsa0KzdV9ODwDnwiSZv
	 q21iw5om911PtXx2sswbnFJUf30KZ/kCipZT/TkyQAOHxfgab0gIpqQpa/d0KUukj3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d5dyiyT1;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D4606A32C
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 06:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 113D4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d5dyiyT1
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cde0daf3a2aso2294744a12.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795589101; x=1796193901; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R3sbzhOnYUrS8wYvSIhWCG5ex9jxl9wVxRyhTnmBIp8=;
        b=d5dyiyT19Km7tDmbpxJjL4rEnANFAC86v3EYHetyWOXfRhF8nqTd1zj3BIgDx3qhR3
         Otfrb/bMHdn/BzzA2hn4O8iQ8rCUMUo5W4QakiPooXQ5Q3ftn3MxeYEy1Hj4Clx9pPzq
         6zxqQkKGx18KdULbG8PpcWWJHDQORxn+D9AZtMYg5AkJvOaq27sApC9cOwzgmJcQ5+8e
         FzVqdhPMdbb/LCv1i9hsjVrKHje9UQq2gZYH8geza2XNhS4XLpqnaCrtDJnExFAhPVHJ
         PklcmdBQqSgLJ5VGJFFXC66xij/lzTqgjLa6bkNrx7Vv/zG5xGwGotjjb7FdXpnCVFN2
         /zzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589101; x=1796193901;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R3sbzhOnYUrS8wYvSIhWCG5ex9jxl9wVxRyhTnmBIp8=;
        b=Ti64Mj2i/poCi2tfc5EMh/M2OYPVQUo8bG6lVVDXoTbBbuIAhCJrQfei0SXqR45i/R
         Vl2ma5CswHcys2B8e3IZD/EyaDgOMoVLXgwCem8j4e9zrkJbF13OB7rCs7VKibRsY+O3
         vXwTJw/Ie+DBnBRoqm6D2skFIDwHGhEL1GghtSBsqR8Kse4RmxN491W8fbFbpQcVdXpj
         4NZXBDPEedu1zqNT9kNcrC8aHC/aJfyu96z4CoVGsLyrogaa4sK6BWqHL7CLflPXLNH4
         njSIIO6npaID+ake3eOnSj6eKDkLiWhcbKTqweRouLpTJD5MhNxxZLi4ESzHqnMCD17E
         RrfQ==
X-Forwarded-Encrypted: i=1; AL+hErF/rxe5mtl0waJjmJtzZQPcbniQJ+GkBbYOutEbY8/Ts0PGvgNMfvTF6bWnFQ/wxnjwTEc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8K7wKFVpi9ZjgG5XLmWQ470widtSyYQDTESBMOZ6A8zvjDZ1WJ
	2i2NGf7Pj9gdxCc2H/nZACBmF+/aCgcSPQR16kJAcUImfpxUWQhM5Jep
X-Gm-Gg: AZFdTZcsdqbsi6oigXUPMLkdc4+VYpUFFRuufhe4V4/cduEtp/yuTYxOWMDl3rMBzCE
	9626xRJaM0ymbHJ5sKg0H8mL329umkT49HPkLARyA0MXPFWzproe3clsSWtGZUVT3GyBEEAZpVD
	tQr35hVcDVPwRsSerg/MHvU4xR3JQxiVWCp1V1TeaHaSh+XIvqJCzUGZ6o3AkdHVclShsz5tdvB
	d0+a6o5kAz1zBigthuX3xslkGXcP4qbZYlvm9e0eSi+UzVM9wjU0vJCVHDIcNHqmsM4hMYdkZpw
	wq8kHXIz+x3xmb5MJaOEwVwVPS3ByBRs0DkDr/fJnG1xjm7Bm8PN0omC6Mp1ZwcmCrWw8kwDkOk
	3fORdErGDuUA9+j8nSyMg3hO+P1z8BCHHCgHHB74Frh6arfEdIEs49KwXetIbRuG+P+egRGs85V
	AhQjRKW0fPHQk9KJ6xr9cJ4wKEHr/+SzWUC339n9teES0BM4/TjNgglAvA5G1tv61T9y8sejtgn
	eO0g8vmoRUHasLNC7L+dVkC/mVAmv1XeQPdpBYqTnwPLUcF1Xl03Bmjr8m9i7P8mGYuzzckgJwb
	D9bTlupiIxZLzBtOa/0pw1q3gQ7B1/kWs7hr9655nUj66OVMGQ+dDFquwUhu+WwXrc2+AT2Gg5n
	xSPVsUpT51ULZmg2vn7oaq6aQouTvmXLMHg==
X-Received: by 2002:a17:90b:1b09:b0:3b4:d6a6:e5b with SMTP id 98e67ed59e1d1-3b4d6a60f6dmr3827042a91.33.1795589101097;
        Tue, 24 Nov 2026 22:45:01 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm28789109a91.16.2026.11.24.22.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 22:45:00 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 06:45:00 +0000
Message-Id: <DN437OYZ5FGP.20VLV7ZEXQ5YY@gmail.com>
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
To: "Andy Lutomirski" <luto@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <df69ab5d-bc97-4651-8668-a2b3e4bb272a@app.fastmail.com>
References: <20261009024925.3169077-1-memxor@gmail.com> <20261009024925.3169077-2-memxor@gmail.com> <df69ab5d-bc97-4651-8668-a2b3e4bb272a@app.fastmail.com>
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

On Tue, Nov 24, 2026 at 08:22 PM Andy Lutomirski <luto@kernel.org> wrote:
> Didn't we hash this out a decade ago or so?

Twice. Feb 2019 for probe_kernel_read() and Jan 2021 for PROBE_MEM:
https://lore.kernel.org/all/300C4516-A093-43AE-8707-1C42486807A4@amacapital.net/
https://lore.kernel.org/bpf/CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com/

The problem in 2021 was a CPU without SMAP. There the fault handler
can't tell a PROBE_MEM load of a user address from a valid uaccess.
That part stays. Without SMAP the JIT emits the range check.
With SMAP and AC clear a fault on a user address is never a valid uaccess.

In the 2019 thread Linus proposed the same for __probe_kernel_read():
no uaccess_begin(), SMAP refuses a user address, extable returns -EFAULT.
https://lore.kernel.org/all/CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com/

> Can you at least explain how a non-range-checked pointer read of a non-verifiable pointer doesn't have a problem with, say, MMIO?

The range check doesn't know about MMIO. It refuses user addresses, the
guard page, and VSYSCALL_ADDR and above.
ioremap() space is in the vmalloc range, so it passes the check today.
It passes copy_from_kernel_nofault_allowed() too.
"compare" and "CPU" refuse the address, "load" reads it:

                              user address,  kernel address
                              RAM or a BAR   RAM     ioremap()
  --------------------------  -------------  ------  ---------
  copy_from_kernel_nofault()  compare        load    load
  PROBE_MEM today             compare        load    load
  PROBE_MEM, patch 2, SMAP    CPU            load    load

A BAR that is mapped into user space is a user address.
The device sees no read in all three rows.

> Does anyone have a compelling argument as to why the vsyscall page is any different from a PCIe (virtual or otherwise) BAR other than the fact that the x86 arch code will OOPS you when you accidentally read the vsyscall page but you will just possibly deadlock or otherwise screw up more subtlely when hitting a different inappropriate page?

It's not different. The oops is the only reason for that check.
syzbot hit the oops through bpf_probe_read_kernel(). Then 32019c659ecf
added the vsyscall page to copy_from_kernel_nofault_allowed() and
b599d7d26d6a added it to the JIT.

> If not, then I think this series primarily serves to make x86 complicit in papering over a problem with eBPF: right now eBPF has a heuristic that is wrong, but with the patch set applied, eBPF can make the heuristic even more wrong and x86 will paper over the cases that it happens to be able to detect.

The range check is not a heuristic for "safe to read". It's the user
address part of get_kernel_nofault(), inlined. You asked for that in 2021.
Its job is to keep user addresses away from the load. SMAP does the same
job. With patch 2 PROBE_MEM reads the same addresses as
copy_from_kernel_nofault().

In both threads you wanted probe_kernel_read() / get_kernel_nofault() to
tell MMIO from RAM. arch/x86/mm/maccess.c has no such check.
bpf_probe_read_kernel(), kprobe event args and kdb pass any address to it.
So MMIO is a problem of every nofault reader, not of bpf and not of this
series.

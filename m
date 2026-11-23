Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477749;
	b=C5jQsx3vr7mQ3nxy9u3clmgqVfb66Mc2N2USIC6tqPyw750MriVLzYbwBG0ogWc2QrZA
	 WNI/prEDV/mnK+4D3ythzfzxcYywW+49SbpVxzy9ntHxVElqrbIRoh1IbhOCYpM/ef8Ac
	 98Pn9LQG6cG4GxCHG8o3Ep5WyoRkOacYKiTr/z5i4nNiEIOutu4Xyjtd6ADb3IP2ozqkq
	 pjv/wN87aHHqruoXHnr2n7IzVO9VfhPJJJjGn7vJGVTIMhtJYAP/PQsEvO5T17K8J0ItC
	 eZeVIQq2VGRcObCjU7G/BUNCAevQpjP0yFwrQVumoRAX0zQ2LrY3avW9voS7XgUXMeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477749;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XvAgZF6CkwRKo3VMFZxbR36QgXiqw9zi2A6dGkoweNA=;
	b=k7Ryw1+mRBXUMnZXqSOkpAGiMPaOY1DP7aIAi7DNeAJli8P6JTKHxDiRKVchlpWzmGsL
	 wIH93BGblEUXGMEYibdXdsZJOIWj+0Vy4wzQJMARRiAmUEdrBKU91gDRwF2Crv9duCpaC
	 h3SU86gYmVqOJ9PPuL3/GUNZiPwmcBWj/veXv4GYca6pfBbkuRVQn4PTSZ1iSbHE1bGMf
	 o2PoXqgs2UlP31VuDPqtAWo+CuPd57i2Md/AqH9LIlKD5udzSnz8b9I+nssWtJXDIObMc
	 a/3WExj6oDuRCDbU1V0uq/v2a+wEqy+ZWLHIjuhsuP7t7AOs/Hq2l9mU1SY9vheJC4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=foft4ovj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9C7606A31E;
	Mon, 23 Nov 2026 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=foft4ovj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F301F000C6;
	Mon, 23 Nov 2026 23:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795477749;
	bh=XvAgZF6CkwRKo3VMFZxbR36QgXiqw9zi2A6dGkoweNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=foft4ovjFmNERzm+RAv+xWpfSO5wFzXeA0DrrAVZ6tOR7ovm78/E5KWERujlMYq/X
	 Y8arbrbGoK90ZC3t4uMkSgIy7+xxwHOsgRctIsGR9k45sa+s9uOFBk46OaPeiFvtF8
	 v/Z/qWFAZCm6slfIfs7Z1PfCyTNJoYUxXHj1Radbk6nsWF9pgI4iRNtRtYXpH2sAkv
	 6q9U8MYJfG1fy01Ux6Jna7v5iOoK/xKb7DjC88fvr7VKgY4kIbft8UwvEgUzRaf9KV
	 7G9tkA+3hZOb2WsHOT0qrjdjIZwZOutEUsGIwXGncft595bJUDJbVyXa4kTwgX6qSu
	 Ohe9HrrUdGX8w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCHv2 1/2] kprobes: Increase the kprobe hash table size
Date: Tue, 24 Nov 2026 08:49:05 +0900
Message-ID: <undine-1795477745290490698-99e2fcc5c9b45beb@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261122200239.1481088-2-jolsa@kernel.org>
References: <20261122200239.1481088-1-jolsa@kernel.org> <20261122200239.1481088-2-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sun, 22 Nov 2026 21:02:38 +0100, Jiri Olsa <jolsa@kernel.org> wrote:
> The kprobe hash table has 64 buckets, so with many probes registered
> each get_kprobe() call walks a long chain. With 20000 probes that is
> more than 300 entries per bucket on average, and every entry is a
> separate struct kprobe, so the walk is mostly cache misses.
> 
> get_kprobe() is not called just once per registered probe. On x86 the
> registration path calls it for each address it has to check around
> the new probe: get_optimized_kprobe(), __recover_probed_insn(),
> __recover_optprobed_insn() and arch_check_optimized_kprobe() all do
> one lookup per byte or per decoded instruction, and most of these
> lookups miss, which means walking the whole chain. It is also called
> from the breakpoint and ftrace handlers on every probe hit.
> 
> Increase KPROBE_HASH_BITS from 6 to 12, which gives 4096 buckets and
> cuts the chains to about 5 entries for 20000 probes and about 12
> entries for 50000 probes.
> 
> Time to register the probes with the kprobe_many_example sample
> module [1] (insmod with nr_functions=20000 and nr_functions=50000)
> in a KVM guest, mean of 5 runs, for different KPROBE_HASH_BITS
> values. The table memory is the size of the static kprobe_table on
> 64-bit:
> 
>   bits   buckets   table memory   20000 probes   50000 probes
>      6        64          512 B         4.71 s        29.99 s
>      8       256           2 KB         2.05 s         9.90 s
>     10      1024           8 KB         1.39 s         4.63 s
>     12      4096          32 KB         1.30 s         3.64 s
>     14     16384         128 KB         1.28 s         3.41 s
>     16     65536         512 KB         1.28 s         3.38 s
> 

Thank you for conducting the testing and evaluation. The results show
a trend similar to that of a study I previously carried out[1].

[1] https://qiita.com/mhiramat/items/1bbeb309ee5dfbc979ce (Japanese
article)

> With 12 bits the registration of 20000 probes is 3.6 times faster
> and the registration of 50000 probes is 8.2 times faster than with
> the current 6 bits. 12 bits is where the curve flattens: compared
> to 10 bits it is still 21% faster for 50000 probes (6% for 20000),
> while going further to 16 bits gains only 1.5% for 20000 probes and
> 7% for 50000 probes, for a table 16 times bigger (512KB vs 32KB).
> 

I personally think 6 bits is too small, maybe up until 9 bits (4KB)
will be OK.

> The cost is the size of the static table, which grows from 64 to
> 4096 hlist heads, that is from 512 bytes to 32KB on 64-bit. The
> functions that walk the whole table (module notifier, arming or
> optimizing all probes, the debugfs list) are slow paths that take
> kprobe_mutex and now scan 4096 buckets.

What I still fail to understand is the use case for employing such a large
number of Kprobes simultaneously. If the goal is to trace individual
functions, Fprobes are already available and offer better scalability.
Personally, while I might occasionally deploy around 100 probes, I cannot
conceive of a scenario requiring 1,000 or more. Would you have actual
usecase maybe from eBPF?

If this change is intended solely to improve performance for an extremely
unlikely use case, I would, at the very least, make the size configurable
via Kconfig.

Since this change affects all architectures, those working with small,
embedded-system chips might be reluctant to "pay" 32 KB for a use case
that is highly unlikely to ever occur.

Thank you,

> 
> The sample module was posted as the last patch of the kprobes
> lookup cost series [1] only to demonstrate the testing, it is not
> merged and is not going to be.
> 
> [1] https://lore.kernel.org/bpf/20261109195827.1091410-1-jolsa@kernel.org/
> 
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/kprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f14f7ff45961..47ce0bfb7298 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -50,7 +50,7 @@
>  #include <asm/errno.h>
>  #include <linux/uaccess.h>
>  
> -#define KPROBE_HASH_BITS 6
> +#define KPROBE_HASH_BITS 12
>  #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
>  
>  #if !defined(CONFIG_OPTPROBES) || !defined(CONFIG_SYSCTL)
> -- 
> 2.56.1
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530001;
	b=3IILh/5JVNDetWL747rj7Zi6qB/uit5n1bvZe9xhBHItq40it/ObGqBZdz+6nXKaCQO5
	 gktRO9U9dDm+TLNVt/II45dIJXSSbavlN0oDPALfHk3R/LujIn5bZQCRNwK3ZB4wtnyb3
	 tFGS1nH/0CsEESctsPrnomX5F70TkFyvPrHLRVK4/ZH7hnW8+gQE+rVY/z7s9WoBiwtmh
	 QU2gktigzlCLrPXovUzQgMKOljOyeZ8L8oM+EJPtO3Ce8wGe5vzVUeEj4tddR1u9gz4WE
	 TmcWIV6dZHYnHV4kSUbOUdDeNJfI3bP/eBvq+gIlMFiCYVhJBTceWxwbrzuDZJryEqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7+zJ9wEzRWTT/HcA8h9WG5wBBTJExWPk/UTv1pPJ3a0=;
	b=nU65cKC/yoGHxAOfY+GZHfNKSwzutEp3No9H+uM7EtOKTUnUDL/awTMCki1B+4P34z3v
	 V1Q5ra/xXcursy6tFk4qdPH9YwsNQXbrIzmV5ksvCHwztjSQ0j//vnlVNjJIo3a1kFRN8
	 q+oGxi60ACh/rD6zzJhn+fSExTxi2OtdlKeflgZzSBEI/lVuTcznUIGwUfgvXzs/px4oK
	 Owvy7i3nKdI1vuGLQN2SU9rOTJ8EwNqLNcrAhdhRjZjPtfLSrXyNdnEvMR4xXUKkYr2g+
	 tEj6iYLMWiI0SGHZTnQbrE+ih4fnCaVI4T/FYRxTYff8YEbJQVXCN+PpuZxummq4piQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IZ7y3J9H;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB30606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AB30606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IZ7y3J9H
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48dee593f18so4344095f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795530000; x=1796134800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7+zJ9wEzRWTT/HcA8h9WG5wBBTJExWPk/UTv1pPJ3a0=;
        b=IZ7y3J9H93IKqopZTq2ipF3e9s9TFYfJrLsd7BOXZRROtROjngdzYrcxanU8HCuZOA
         Vkl+OUtO4ikHhIxZiqvGiJuxspFZSu7uIjYM7Uwxn735WIPF7w6DBUcRdP7uv4m+46jH
         yPCcyA3HM3mtJK9sfDrUQIxu6UiLj1lsOLAXwwzhk+pWXKwu+hCJPD+FHpB9ThwehL7t
         UBOgA0lc29OCJQId/wjvBVjRDqN/7wq7ipxDR0B+2Ve/5AJG2jiyF1Ykym9MmS2qrGH7
         ORNuwljXAdyQAqLZLGDq/EVqjwumbG5fIoGYC2nRkT4MgKByvfsH/s6/P+921XwToQbx
         5mkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530000; x=1796134800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+zJ9wEzRWTT/HcA8h9WG5wBBTJExWPk/UTv1pPJ3a0=;
        b=URMXnTrTTdEKBifFCm9uxdoWL6FpP4J+PV3Hl6Aut6zyq4B3YnIL5gtJ/Ryl8aZmF3
         0MepVQdjmRKlHAUX6neEO/oWcghldvuL27gNfCl51OAU3aOg5orUuG97OPTP7RdaWrgf
         k7riydLCo96T8AtfKfCPlyA7bwhauBPQfzoC4TRGFinvhd9UbyUVPMdckpu3Cu7D0XtF
         UOUo6kYuKOGeD9SCaxyZ5CQ1MVLwWOHfvpdun3VhJGEOd3uUHCdfeEkjpTCBAIIDx/3+
         UFJquSKUpDcY1xBTOeydmkoMr42sNl09iNpRcUqmlyAMgwm9Zd5jV3/FTnNy9SIMgwG8
         U97g==
X-Forwarded-Encrypted: i=1; AL+hErH8TPdQZKTiFbaSx/pD7md3Izt1eL9Ac3b1uALXNSuM1Qj6ieSZFFggg7LR6T7ohtN0J6c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+b8x7hfrdIKsySZJDa3uX+optqP0KIUbcMFxSbfbmiSBmjlLpM
	yzpwISH4YWmHa6elhbpxUXfV+v2O9MnnmZPLhgY3c46o4t3o7CDczRXU
X-Gm-Gg: AZFdTZcqvgiTv6jLvHx/FzBijYS5prFV0BV5l7js0eFfn3M3L+lM7CFqr4dyvOXymHj
	FhAVe8WGcpyQhAHwtrhTwlKtKYSpqDFZr4/ZB4yGpzYdK4i50QVtWvM8mRWyIXtvyJ4zMCfDr4D
	sfQgKrAR/jX3ZXPrU1YoStv+Skw40wJYtIKs4exXUvzdGylrkP7RPQAtjQxZfhgvU1nuo/oXNrh
	QKyrmhSkqCnkBJGX43YNyugA3k3y7p+jOtVwlZcbf6VqrLCt/baDnHq9i5UslpTGtjp9P0ej2Ik
	VdtmgC6eBCWZGek27ihUuM55Aybo9zOs8KrzfByp7DEXGe6jRcJxLx5WoWPu3WpWhXmcBS9rWEu
	8HNIXAs4gckJE5YF5XP+vT2guhkBS437mJYT5b0xRWYRvgX4X0baCCaTikQffR5cJLRqDSh6c/r
	ITwy6ySdopg96kprN97PUJ8N7xwZhEA/OkjCuhmy15E3HK4ZQYYelIfeNxdIrwUDRQ5r8qj6Dql
	68KqoKpltdjDH0gX/8GpzQ6pFz5Cr6PXdGxhQihBa56EnxOhHHvidFPXW4/JAlJfcvg7EdwwTIP
	84ccm8fyY9JvIJpB
X-Received: by 2002:a05:6000:299c:10b0:4a7:9630:7b5a with SMTP id ffacd0b85a97d-4abb47b2043mr20944271f8f.47.1795529999684;
        Tue, 24 Nov 2026 06:19:59 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989e3sm28314153f8f.52.2026.11.24.06.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:19:59 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Nov 2026 15:19:57 +0100
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCHv2 1/2] kprobes: Increase the kprobe hash table size
Message-ID: <awWdDfj1fknA8fuF@krava>
References: <20261122200239.1481088-1-jolsa@kernel.org>
 <20261122200239.1481088-2-jolsa@kernel.org>
 <undine-1795477745290490698-99e2fcc5c9b45beb@undined.local>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <undine-1795477745290490698-99e2fcc5c9b45beb@undined.local>

On Tue, Nov 24, 2026 at 08:49:05AM +0900, Masami Hiramatsu (Google) wrote:
> On Sun, 22 Nov 2026 21:02:38 +0100, Jiri Olsa <jolsa@kernel.org> wrote:
> > The kprobe hash table has 64 buckets, so with many probes registered
> > each get_kprobe() call walks a long chain. With 20000 probes that is
> > more than 300 entries per bucket on average, and every entry is a
> > separate struct kprobe, so the walk is mostly cache misses.
> > 
> > get_kprobe() is not called just once per registered probe. On x86 the
> > registration path calls it for each address it has to check around
> > the new probe: get_optimized_kprobe(), __recover_probed_insn(),
> > __recover_optprobed_insn() and arch_check_optimized_kprobe() all do
> > one lookup per byte or per decoded instruction, and most of these
> > lookups miss, which means walking the whole chain. It is also called
> > from the breakpoint and ftrace handlers on every probe hit.
> > 
> > Increase KPROBE_HASH_BITS from 6 to 12, which gives 4096 buckets and
> > cuts the chains to about 5 entries for 20000 probes and about 12
> > entries for 50000 probes.
> > 
> > Time to register the probes with the kprobe_many_example sample
> > module [1] (insmod with nr_functions=20000 and nr_functions=50000)
> > in a KVM guest, mean of 5 runs, for different KPROBE_HASH_BITS
> > values. The table memory is the size of the static kprobe_table on
> > 64-bit:
> > 
> >   bits   buckets   table memory   20000 probes   50000 probes
> >      6        64          512 B         4.71 s        29.99 s
> >      8       256           2 KB         2.05 s         9.90 s
> >     10      1024           8 KB         1.39 s         4.63 s
> >     12      4096          32 KB         1.30 s         3.64 s
> >     14     16384         128 KB         1.28 s         3.41 s
> >     16     65536         512 KB         1.28 s         3.38 s
> > 
> 
> Thank you for conducting the testing and evaluation. The results show
> a trend similar to that of a study I previously carried out[1].
> 
> [1] https://qiita.com/mhiramat/items/1bbeb309ee5dfbc979ce (Japanese
> article)
> 
> > With 12 bits the registration of 20000 probes is 3.6 times faster
> > and the registration of 50000 probes is 8.2 times faster than with
> > the current 6 bits. 12 bits is where the curve flattens: compared
> > to 10 bits it is still 21% faster for 50000 probes (6% for 20000),
> > while going further to 16 bits gains only 1.5% for 20000 probes and
> > 7% for 50000 probes, for a table 16 times bigger (512KB vs 32KB).
> > 
> 
> I personally think 6 bits is too small, maybe up until 9 bits (4KB)
> will be OK.
> 
> > The cost is the size of the static table, which grows from 64 to
> > 4096 hlist heads, that is from 512 bytes to 32KB on 64-bit. The
> > functions that walk the whole table (module notifier, arming or
> > optimizing all probes, the debugfs list) are slow paths that take
> > kprobe_mutex and now scan 4096 buckets.
> 
> What I still fail to understand is the use case for employing such a large
> number of Kprobes simultaneously. If the goal is to trace individual
> functions, Fprobes are already available and offer better scalability.
> Personally, while I might occasionally deploy around 100 probes, I cannot
> conceive of a scenario requiring 1,000 or more. Would you have actual
> usecase maybe from eBPF?

the use case is the kprobe multi link support for inlined functions,
which I have in this branch:

  https://github.com/olsajiri/bpf/commits/inlined/

inlined instances are not function entries, so they can't be attached
through fprobe/ftrace and each instance needs a standard kprobe

number of instances gets big quickly, even for a single function, some
examples of functions that have both an out-of-line copy and inlined
instances in my x86_64 build:

  function                inlined instances
  __list_del_entry                     4144
  list_add_tail                        1196
  folio_put                             629
  put_task_struct                       373
  percpu_ref_put_many                   273
  kmemdup_noprof                        207
  fdput                                 189
  sock_put                              161
  migrate_enable                        131
  migrate_disable                       123

attaching to the list functions is not necessarily a good idea,
but other functions have a high number of inlined instances too

the goal is not to attach 20k functions, but to make the inline
attachment fast.. user specifies just a few functions by name and
has no control over the number of their inlined instances, so even
a small set of functions can end up with thousands of kprobes,
and the attach time should stay reasonable for that

> 
> If this change is intended solely to improve performance for an extremely
> unlikely use case, I would, at the very least, make the size configurable
> via Kconfig.
> 
> Since this change affects all architectures, those working with small,
> embedded-system chips might be reluctant to "pay" 32 KB for a use case
> that is highly unlikely to ever occur.

I can add CONFIG_KPROBE_HASH_BITS with range 6-16. I'd keep 6 for
CONFIG_BASE_SMALL, so small systems don't pay anything, and use
10 (8KB on 64-bit) as the default otherwise, which gets most of the
speedup from the table in the changelog

thanks,
jirka


> 
> Thank you,
> 
> > 
> > The sample module was posted as the last patch of the kprobes
> > lookup cost series [1] only to demonstrate the testing, it is not
> > merged and is not going to be.
> > 
> > [1] https://lore.kernel.org/bpf/20261109195827.1091410-1-jolsa@kernel.org/
> > 
> > Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/kprobes.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index f14f7ff45961..47ce0bfb7298 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -50,7 +50,7 @@
> >  #include <asm/errno.h>
> >  #include <linux/uaccess.h>
> >  
> > -#define KPROBE_HASH_BITS 6
> > +#define KPROBE_HASH_BITS 12
> >  #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
> >  
> >  #if !defined(CONFIG_OPTPROBES) || !defined(CONFIG_SYSCTL)
> > -- 
> > 2.56.1
> > 
> >
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

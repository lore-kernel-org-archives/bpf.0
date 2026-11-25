Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644332;
	b=NLz/Zxw6M37Q3VzDqwy80NWbIOamXe0g7qZuZgC9Ut6IKGtSyLRr+ghDtav2QDJ0AhP7
	 ENgQykNKcv0uQJFlUAFpQ17ugT+dKQJOs0QIZnDQj47zPeUUdDIXd4nrf3hfqA4DmGkaK
	 dbwtS7eMNNCRrf8llX3xoNHM1pXQdgSZ7O5WUMaq4Qb8Az1T4WEgcFBh7ESDjTOQDJ6h5
	 bn7teksdcWwEQ3NN/QNi+6FXmeZACpaFRB5PLWQku2W9IA8yhq8rlRB8b0B8SilSRVBZl
	 8xZ+Tj0ZwKZKje+LLwGQ+r2qXT4lW58frw3h9AmLFdjeiEikUY9l0S4SJs3R0N4PZVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PFMx5gcHoGq+aybX24krgUmTqr/EIcl1w7rEetCl/eM=;
	b=q9sP4JXScUO3h/DHYQ8rR6KHG5bsrHdDtmMPMxuQANUb2PWpEBP/CP83sF4nSJaMLHir
	 Hk0YRYVlhZdTXNxbdN8KccKAEkv9X2jO7EiTZ03lTSdH9tP690zqOV5hIRMiED7DhbUJE
	 pU5XHn9IBPPjPT7IcjNC5xIgYZhZDSUq5QYtWOLXRxkJEXj/xJSUReNC/i1+3dyHTszUv
	 wRSgumo6kjsMUO8OuYtxokTtcRqefVBIDc057QIF0YEiIsU/8eqVMVO+twEwsFqdVpp6g
	 9Ii11Sji/eGWwMUFwUDWzinDoPIZHPUTGoeWWwiMUE1QerAh/9ekORppeWyWu93FMKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hRsY6FcO;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA49606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 22:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDA49606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hRsY6FcO
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so53585745e9.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795644330; x=1796249130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PFMx5gcHoGq+aybX24krgUmTqr/EIcl1w7rEetCl/eM=;
        b=hRsY6FcO9VKK/UOP2vT1k2XjTWekQ5+uV5pYD/ykGM2TvFCyGMhb3aYmmesN/XrDM7
         /xa+R5z8TfXWB8q3iC3SJujbwY+KX79yguFoL2/rHEyUduY3s6a2Pv3F0n15bbHIg4V5
         WR2l8gEtzHyz0zdHGDTbTcthKXhlzTX2niHKXed5ySIIvuMR6lYDsV9apaFFC1GKGY0B
         yK6xEfP/kLAM90sSgP4FCwuj10gbhEo45nAoZhvn9+4Uwebuq3G/4Bvae1/F/7yEu/vh
         2FVnxNb/1g8JkQLKE1FsLRvC8Y8DAaiw0iilY6hXNScPUtyZmYfE/0UxFKB10RD4OMv4
         CLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644330; x=1796249130;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PFMx5gcHoGq+aybX24krgUmTqr/EIcl1w7rEetCl/eM=;
        b=iupM03yKHUxJimumaYnS8bGZ4l3QhuPTVlxy8k7WDKIeXcLpneckVbzXW8g66wo6s3
         q4k96bg4NE593JHOR8CEuMCWwz6dPPPc2TaUXXB5RqItnMHSVzJai+W1D8RPYsh7Uca7
         BGXpn3K1FKOazzMw/wqmCURdgoy1fM1m/RABLiWZDTNZFqkNxxCCzPFLWEbVABelXEWm
         lOxY6Y8IxBQGr44KlQUiHbLndThlZ85m4ci+MVJISy3dAsYm+X4uUeVmO/+jwyHbVRGN
         3bhPqPG4y5/0gRtSxbhZESy2fWRMyH15njKS2ScLJrWeTf84Hs53dvNX+q/d9+wiKatr
         rUSw==
X-Forwarded-Encrypted: i=1; AL+hErE/GsfhQ4mz4ZeDcJp5QbVTeplKT2uXr8KAZKFXNHZntTlWjuCZ2KNUiqJwzxiTz0Jojhk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jmIWMh7VU9JVI50f1az8a0ZfnA+1gkoP05JWKmphyZlsVby64
	IUhfW4ky5ATZt+HrpLeUg9RZnRc1ou/bXApizL3WNyQxky7TbORHJd1R05sg+g==
X-Gm-Gg: AZFdTZcl7WlqVyPF031dxT0LC8/bnpCFE2fhLB2CHCWYv4ZHFBTwhBuR/yYau6xxFEe
	w3V9WFqdRcavtt6bNJJR3cLGX+fRAca9mzL0ThpNYWp9T+db5WatUQzBbzwC6wsfhYGmBdwc43B
	A9fe3sL2+7qy8uNr4S0bleAX4Ez/FH/b3RppgK9hNd2DphHtawCjWPMI8Q6PvUxm45RzMR0mXHF
	NWypt4OINdt3g7sZOKeH1CrP6uA8FI2AQbIyee8KKcG9Re5MF1P1YjGDz1M1mKtVRbmJsBsdiVI
	7le4yfUgfEhtEA6TNwpTXJfZyhiFH+8u5POGyFvMiICB3KtDzLMKOZFML9ed5+l1hx0AA11Ew3H
	HeXbQuoQAd1cpkUNaIyWtHh6rm1q3nYgeSo87TLGn1vx7of0puh0J8U4l/6n+gypqjdtaoIGUjg
	Sxe54in5+XpTS5tGFIjYd16ExOZvBmvp+Te3/CpN33mmMIZ8j6Q76NB232eeZYxgryU/T/FXqGl
	ReWoC76KVVteQeOlZ+kvlnX07uAotGDPDisu5y3pkvefKigJzlXW1oLXV3dcr4TjPUS4PooB3Xa
	dHQ6w6lLnjGQwdc9
X-Received: by 2002:a05:600c:e549:10b0:4bb:a60a:fc8 with SMTP id 5b1f17b1804b1-4bba60a11d2mr42321925e9.35.1795644330050;
        Wed, 25 Nov 2026 14:05:30 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm1016582145e9.4.2026.11.25.14.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:05:29 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Nov 2026 23:05:27 +0100
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCHv2 1/2] kprobes: Increase the kprobe hash table size
Message-ID: <awdbpwBAyzIdG9tL@krava>
References: <20261122200239.1481088-1-jolsa@kernel.org>
 <20261122200239.1481088-2-jolsa@kernel.org>
 <undine-1795477745290490698-99e2fcc5c9b45beb@undined.local>
 <awWdDfj1fknA8fuF@krava>
 <undine-1795616480318619368-1be7e961905611b5@undined.local>
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
In-Reply-To: <undine-1795616480318619368-1be7e961905611b5@undined.local>

On Wed, Nov 25, 2026 at 11:21:20PM +0900, Masami Hiramatsu (Google) wrote:

SNIP

> > > If this change is intended solely to improve performance for an extremely
> > > unlikely use case, I would, at the very least, make the size configurable
> > > via Kconfig.
> > > 
> > > Since this change affects all architectures, those working with small,
> > > embedded-system chips might be reluctant to "pay" 32 KB for a use case
> > > that is highly unlikely to ever occur.
> > 
> > I can add CONFIG_KPROBE_HASH_BITS with range 6-16. I'd keep 6 for
> > CONFIG_BASE_SMALL, so small systems don't pay anything, and use
> > 10 (8KB on 64-bit) as the default otherwise, which gets most of the
> > speedup from the table in the changelog
> 
> That is good. If you introduce the inline function support which is
> enabled by some kconfig, that kconfig can increase the hash bits. That
> should be more reasonable.

yes, good idea, something like below, I'll send that as part of the
inline tracing changes

thanks,
jirka


---
diff --git a/arch/Kconfig b/arch/Kconfig
index 1163736de1f9..350144df6863 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -141,6 +141,23 @@ config KPROBES
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
 
+config KPROBE_HASH_BITS
+	int "Kprobe hash table size in bits" if EXPERT
+	depends on KPROBES
+	range 6 16
+	default 10 if DEBUG_INFO_BTF_INLINE
+	default 6
+	help
+	  Size of the kprobe hash table as a power of two. The default
+	  of 6 (64 buckets) is enough for a small number of probes.
+
+	  Attaching to inlined functions can register thousands of
+	  kprobes at once, so the default is raised to 10 (1024 buckets,
+	  8KB on 64-bit) when the inline site information is available
+	  (DEBUG_INFO_BTF_INLINE).
+
+	  If in doubt, keep the default.
+
 config JUMP_LABEL
 	bool "Optimize very unlikely/likely branches"
 	depends on HAVE_ARCH_JUMP_LABEL
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f14f7ff45961..eba446e8ae37 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -50,7 +50,7 @@
 #include <asm/errno.h>
 #include <linux/uaccess.h>
 
-#define KPROBE_HASH_BITS 6
+#define KPROBE_HASH_BITS CONFIG_KPROBE_HASH_BITS
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
 
 #if !defined(CONFIG_OPTPROBES) || !defined(CONFIG_SYSCTL)

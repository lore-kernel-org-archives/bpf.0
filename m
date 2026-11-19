Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052304;
	b=k2B9F1XG/tL21FSk1JuOLEUHV/gAiPJDkGuyUm523tKnyCSKToMD5hPefoYL8ZrrZ6fC
	 VBxJI1d8++/lKrX5tYVNi5XQP75qvYvDhO1BO2+90+9EmjMFziASQUyjfBxu2/N3MGsG0
	 18vzwfGXNz+1RjrsMB6o4dPGmuswQo1f+RMwSg8ba/ZlB5PKeDZaEXmayN7FB8RHv8XHM
	 FdmWisNCraACT5lN/R8sDmxfmOJJ6uN7beX5eOegcJSZqfar0GaCRdR5lE4E1D4G2oQKb
	 VTEp5wxLW5HMswbERBpcxr8y9N07L47vxMVSagSRciPqG/2C1HjzZ7LgO9LMJmNAuYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=EISx+aUN2h8+Y5wGuLkSbChaUhZOj0j975QB4nl6i2Q=;
	b=Nuk9UG0gpZRcL+S216bSU0L5qsTqZZoxM9ulWw51YO8PzOOsdvgxK7VE5T02JTq3zLl6
	 qnmLI93dXJV42mgr1O33fb5jmxV4CrgVBZrECf1DpNSwIj5lISkop1WmbnXg4Quq/vp0E
	 icwjGa3VZPODyOgWYaHNrXeo4rJnic7t22F8Sm6vwxMHhEWi9BEJCvnOzDLRKsGcIg5Ni
	 KzXo9Odd5dJYjwj+3ZlFA6HODp6SU8qfMleNNbE0rhl6rWsEjHxYWSROs5j0weiz0iYa5
	 A9ZX9rJiBTb4ThkDT92y73qqqaxnPEQR0WDiLPJPmTdDgV2rLhTmVn+uoz+tPqaYkqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYxbWfXv;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2425606A32F
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2425606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYxbWfXv
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so957374a91.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795052303; x=1795657103; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EISx+aUN2h8+Y5wGuLkSbChaUhZOj0j975QB4nl6i2Q=;
        b=hYxbWfXvJ6ud+jAQmE7BAwtWAQsm0YQ5MB/3jHgNtwVyCeGJaHuRdKjKEpkEDf+4Vy
         2wOvLl91USwMMQ3ILsmBrnBPXmCqDdApOFUKhuGcNAdkNhC7DvOLDdZNbZULuJsEVYc2
         lDNdOPFKUmTvLw8DrN2WD7B0N36RY4LW6Q3tQ+EZBFBDuvG1ZHBKHXbSSE7SMZA5abjr
         Qein5V9+Gx3pyZ3TMjPuz/gNXAFFJOlrzfmBm8r+iplCQXpg2VY32j2u179MXh3DPOqz
         JLKwJkhuetD8OOcyHmotTHfgrH9Ebx7IdqimtrSQFNNyq0KgjbM9T4LefnnjxUC61zsm
         Q6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795052303; x=1795657103;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EISx+aUN2h8+Y5wGuLkSbChaUhZOj0j975QB4nl6i2Q=;
        b=V9JLky/svDDVySUccwjoCWOPM2uDG4VPmBhEtnYFEFepElmx00TvFr1/u8ZwhAObZw
         plNwkKqkcmxr2Av39nSDH7iM0INX1lcXy4kNaxIv4NzngRJyppMDUy/ldaQM1dEstsoo
         HxRcTRQ/lOLInpKCZ8Go4UqnJTfNak5bn+Q6XXvK65dE8AS7nRS7X3ArKNVkFt8zubi7
         iO+Wr9yen78FfaxnO4r41OKBo3tMkDFR9A0lTwVpjdK+DrfquajZPVdkumL+T8CXbZDB
         jh8rTqEz6jWXn9k8cIIk+JolrHQiK/rTB6yHhnCdTLayLB4MMw6f/ISCD0o7RUvjMaTL
         jY9g==
X-Forwarded-Encrypted: i=1; AL+hErFFukaD8rfqHGcfHekjk91qhGrhObjd+HPuIIRFs6Kd5G+xPUo0OSOlsFgoBSIPotRbvJo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fOszllTVUwOFopkkZkwAbwSuTAfFMKNIcIIALj1o5RmiIFa8I
	vGqwrAzmiGKL1wxUekz2D8NvOUl8xHsKUr71UyIP5KxAmwphyMIfqm2P
X-Gm-Gg: AZFdTZfW8F69cUt+wQVUAWhFgJlN5Mzcbo2//RazFus6SDpb4e90X9U4wVwBh+gL6iF
	P5VC5sOAGzeRAjqphRmfVscRamAT812G+irxYjLXbSXXoDPgEa+Ib+pDfrQWYqGu4Nv6LtsI7cc
	czQoDevcYlfQLTu8PoYlx/1q4/MH0jFauG9SeEVDNvk2MayHcXBuEs5iNXHHwOI+v/t/7Qo2F9I
	Ux9GPnNP+P1h9UVQkFUgNHO7J8137E/zXAGuX4C7082FM+wxSohTw4DPfHPOkm0//zFc6qP9o0D
	+UfQlBgHNbKFxNz5kJfmcJgxQ+HT4rtBtby1DB6Mtt690mffCvacvfaNBo7XU9+lp9hq9uio/yl
	l7T3T7qD/oVlG/ckqxW48lD99D9yCsgoJBVMOsAb0OI8n6Q6yQcNuExsrUDr1Afn0wDjJWOBUIB
	YvSatcn+fGrxXOvnmOEVx39QoyS71+gZAUq0uM73L1jUXBV6WhiqeKG3DfjQI0+n+6S/ZuI1ofY
	b63mUbAdERDbLJp/xtL1tpX6rg3U4vCkTlgF3DZNilIbCkXAgF+Pd2fanWKTWkMxf48lv1FNDOd
	PUv59JTinAPhn4+aw3bMTNyh7ds23cS2T59XWxgSFWupsAZt25pqrtdnWouRp19uCNio02JKspq
	AtyK0QXqHp5Pdythl6wKOZ7sRuMaifCD4HA==
X-Received: by 2002:a17:90b:2890:b0:3ab:5832:72af with SMTP id 98e67ed59e1d1-3b3d07b99a8mr3639797a91.32.1795052302815;
        Wed, 18 Nov 2026 17:38:22 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3fe0b62e7sm685981a91.11.2026.11.18.17.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 17:38:22 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 01:38:22 +0000
Message-Id: <DMYSXNCMOF26.38XGLPOW4K29X@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrii Nakryiko" <andrii@kernel.org>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Cc: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
 <linux-perf-users@vger.kernel.org>, <peterz@infradead.org>,
 <jolsa@kernel.org>, <rostedt@goodmis.org>
Subject: Re: [PATCH bpf-next v2 1/3] arm64: perf: Don't report the caller
 twice in caller-regs callchains
In-Reply-To: <20261119000112.2377949-2-andrii@kernel.org>
References: <20261119000112.2377949-1-andrii@kernel.org> <20261119000112.2377949-2-andrii@kernel.org>
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

On Wed, Nov 18, 2026 at 04:01 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> Do the same on arm64. Set pstate to PSR_MODE_EL1t, which exceptions
> taken from the kernel never have (the kernel runs in EL1h, or EL2h
> with VHE), and skip the leaf regs->pc in perf_callchain_kernel() for
> regs with that mode. The unwind still starts from regs, with the frame
> record at x29 walked by the unwinder.

my bot thinks the following will be a more accurate fix...

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index ee45b4e..7c5ab65 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -13,11 +13,12 @@
 #define perf_arch_bpf_user_pt_regs(regs) &regs->user_regs
 #endif
 
+/* PSR_MODE_EL1t marks these regs for kunwind_stack_walk() */
 #define perf_arch_fetch_caller_regs(regs, __ip) { \
 	(regs)->pc = (__ip);    \
 	(regs)->regs[29] = (unsigned long) __builtin_frame_address(0); \
 	(regs)->sp = current_stack_pointer; \
-	(regs)->pstate = PSR_MODE_EL1h;	\
+	(regs)->pstate = PSR_MODE_EL1t;	\
 }
 
 #endif
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 3ebcf8c..de394ff 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -357,6 +357,13 @@ kunwind_stack_walk(kunwind_consume_fn consume_state,
 		if (task != current)
 			return -EINVAL;
 		kunwind_init_from_regs(&state, regs);
+		/*
+		 * With perf_arch_fetch_caller_regs() the PC is a copy of the
+		 * LR in the frame record at FP. Start from that record.
+		 */
+		if (processor_mode(regs) == PSR_MODE_EL1t &&
+		    kunwind_next(&state))
+			return -EINVAL;
 	} else if (task == current) {
 		kunwind_init_from_caller(&state);
 	} else {


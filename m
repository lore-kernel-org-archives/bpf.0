Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801843;
	b=bUSSKluArsUjgr2Tou6as/AwyYvN4tDUFnLUXwN6KULh7oY3cRaOXoOgcRlAyREPXNVE
	 lA3Iu7HeEc+2YZjH42bQuRcQoxZ3ELtgoz/IvRCTrsuYSc6ZL5SwSgVRyKSAQ9O9/jo2/
	 n2j9RdMdPtd778uWCoxgF2rJ02STmKpY48Tx/yjYjvboK/Bn44mDKPUv4SCSUOyq2qJYm
	 P3WLlmO3VOKYp3/0f20fp2+iqJDdmf7UgcK/ly/v6MbUrGH5xCLPoD9/0gZXajOdiyGD5
	 /kZKglLlw+Us0uGIXLjgquYmI7L5R9ehEaw3bYosE+gy1M1C3o7lG+MuvQPtHiBknzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=eVZCOLw03br5YUlMx9orhQGagROEEA6FD/VBYsNEPBI=;
	b=F44dUtXITiye/tYXIHMlelh9Zl9OIH7Vl182F6lYjCTozpnnKfdDa90ADQPsdUJBQLdL
	 b+V842PXIqbhFmyvYufaUec3OtYW5+iE1qHAikr7dirNn7ZC8yb+e8VTMXTkwcL5zCVHw
	 QZEjTIxUdiW2ZHBvKiK8sGr0UHO+oDxBGHc0s0wX9LjNzD4kfvx8nkgiFPly7uWO71mx+
	 TRg3r5WgWytPb6bSWGLSuT9l5+HfRKe56Bw/ZcLGWJ1cgBBz5gHx+BypNZDEBGrOnf9FW
	 6BSCiq7nL3WdmL5IRLAM3tPBIGF9XB8m7TNWfoblVbz0TswD+JWQbyd0+jXPdEk5peQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hUTx3CSX;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873A606D80A
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 14:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7873A606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hUTx3CSX
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-490f38e9688so4341f8f.0
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 06:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793801842; x=1794406642; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eVZCOLw03br5YUlMx9orhQGagROEEA6FD/VBYsNEPBI=;
        b=hUTx3CSX5cNx2Bwf3kW49tSxzYbrjR9l/xJJSGCUS5Ik0GfKOktuljV1Z9QcHy/HCW
         l12sqIKI6+mJd7Bt1soRc/+vAs7cmxAkOX7oJNjiOiLuf0GMMctjurdx7/eQFhZ7k8cq
         1nU9L0GDiV6dxcRMA5sYMoIHYSqCpTn5Ax6Lew2bCWPSB2lXiqNjsr0PJCAkOasY63os
         +9XnkS/FlAJNFu+4vlt1sF2B9CQxckegf5HTdSJMXZyzJhy4oV9xmhCPSeyjbRRPdBW7
         8F8p+3sUawCELYJz7PR9TTrI08/J8tvAr3xSrDAM+XCv2DY6vI48XTAKnJaloUb7IAgp
         7vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801842; x=1794406642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eVZCOLw03br5YUlMx9orhQGagROEEA6FD/VBYsNEPBI=;
        b=ildMIhJKFhpiJI8lAztOZ8AIcZywIoq/7Gq/FyFp7zfoC2148MpZV428QidJos2G8M
         AYo7s1iRlZLjeaWYtHOsiNzqwEPl6LtGiJzsKiQmFgVNvWs07lTFY4UBfflPpXD2KMDz
         oWXiqF7iqWXzxbepQdSsqhukz/JuDygSDEng4hhFC2N8xo5/chrosB1zyFIdyY1hIO5M
         I2iCXMQYDQpPbixqnYxqPYzRdfXtZFWeYs80mi3Z1BAaYxxsTDZWxBr0UgHxhUOIYqMR
         0qZAQ0ygj8HlX0p17pJxm+B6QeoPqoXonSaB099pMEMXeyPtt3uJyJiYyJTDmOOWx7nv
         4s3g==
X-Forwarded-Encrypted: i=1; AKwUvBzsoWm6d3MXnocMDpDroOavrHyT4Qeq6Fc/eRadf+YVEGZpyfCWG+uSE0GDdWmMEV9bmp8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SVummOMTB3DFfhTU5j25UarKcD3krkNaUuZ9yeBkQxeZ/crxD
	YjhJmWHjZcWUDUo5cBuNOCxBCMNBr7so/89kqcQA6oTcMNsC+eaNvJiA
X-Gm-Gg: AYBFou1nFCBFG9aR6SehBTnvh8XKg6XDJXQZ5GGMeCGOp4P1k1CTEKbSMb3TmCBqm9a
	pIF7ZVB6igH/o5W9++t0ye+X3fnUoRbKmmy9sQs9y4HA89vXSJZj1PjAQnlC8GUkkuxpLKjRyXu
	8UsW3lEjL/U31KhajibIQEo9bX5muAU2ZrHqQlhrEr7oQNxYxQI+tkT5gLcEUsMVkvqhpuwPGCP
	+Q0axEhD+JAT8Npj6huKaw1jRl1u33+6c1KHFf1I63AI7Xv9AHPrRwnV0rBPQ8TNxi05vqBG4Al
	YZEPGEV6wKrDwoNZaDrR1NvsoqfTBCa7G23w3MkciMFeuPy7xR6gw2Vp8rK+yWMyvDDAqs01Fg9
	SprdTZf1ZM3fhqWjGJeqk4R03TS9K6ZN6x7TXunGQxgLQPRLGocJr618KrTU3b+8UKxdYlxJstU
	Gs1bFwKugO/FOdG+zKrQXCzajkcRKxxKksjb+1UvLvuMju9nIoWwc5xe21lSDnmM9eU+xs7ritA
	arRv9Kmx7Mz/CSQ7N4UMayZRJ2SUPTgYE3+ObzZ06lATRf5FcI3PSvhq6Z8U0vHVu4Ms/lOZpzX
	PIprex1EMTS/HN1F10emgmI=
X-Received: by 2002:a05:6000:2185:b0:490:a481:7ada with SMTP id ffacd0b85a97d-490a4817d19mr1482450f8f.5.1793801841556;
        Wed, 04 Nov 2026 06:17:21 -0800 (PST)
Received: from krava ([2a00:102a:5067:f545:7390:bab9:2c60:c1bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feeb51a9csm4152909f8f.59.2026.11.04.06.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:17:21 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Nov 2026 15:17:19 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	HyeongJun An <sammiee5311@gmail.com>,
	Christian Simon <simon@swine.de>
Subject: Re: [PATCH bpf-next 0/4] bpf: Disable private stacks for uprobe
 programs
Message-ID: <aus-b8Lo2oCw_cGd@krava>
References: <20261103093400.112178-1-jolsa@kernel.org>
 <DMM59LNY80FW.36KH8ZKL94T59@gmail.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DMM59LNY80FW.36KH8ZKL94T59@gmail.com>

On Wed, Nov 04, 2026 at 04:33:32AM +0000, Alexei Starovoitov wrote:
> On Tue, Nov 03, 2026 at 01:33 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > As discussed in [1], there seems to be no known compatible fix for
> > private stack corruption in standard uprobes. This series leaves that
> > issue unchanged and adds the BPF_TRACE_UPROBE attach type for new
> > standard uprobe programs, allowing the kernel to identify them and
> > disable their private stacks.
> 
> New uapi to fix a bug is not a good tradeoff imo.
> The bug stays for every loader that doesn't set the new attach type.
> HyeongJun's tracer is one of those.
> BPF_TRACE_UPROBE is also the last attach type that fits into
> u64 allowed_attachs of the token.
> 
> > - disable private stacks for all KPROBE programs: protects uprobes,
> >   but may reject existing kprobe programs that rely on private stacks.
> 
> can we do that for all of them except kprobe.multi and kprobe.session ?
> A prog without attach type is either kprobe or uprobe.
> The kernel can't tell, so it gets the kernel stack.
> 
> Without the private stack the verifier sums the frames of a call chain.
> The limit is 2 Kbytes on x86-64 and arm64 now.
> 
> The options for standard uprobes:
> 
>   option                   untagged uprobes  what stops working
>   ------------------------  ----------------  ---------------------------
>   BPF_TRACE_UPROBE          still corrupted   uprobe and kprobe progs in
>                                               one prog array
>   reject them at attach     can't attach      uprobe progs with 64+ bytes
>                                               of stack
>   no private stack without  fixed             kprobe progs with a call
>   attach type                                 chain above the limit
> 
> Row 1: a prog array takes progs of one attach type only.
> With patch 3 SEC("uprobe") has the new type and SEC("kprobe") has 0.
> 
> Then no need for the new attach type, the feature probe and SEC_UPROBE.
> 
> PERF_EVENT_IOC_SET_BPF doesn't check the attach type.
> It can attach a kprobe.multi prog to a uprobe. Hence the 2nd hunk.

fwiw this will fail via perf_link (in bpf_prog_attach_check_attach_type),
so it's just the ioctl problem

> 
> Something like this (compile tested only, selftests are not built):
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 935b163..9003330 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5706,6 +5706,15 @@ static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
>  	 */
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_KPROBE:
> +		/*
> +		 * Uprobe progs are preemptible and don't check for recursion.
> +		 * Two tasks can run the same prog on the same cpu.
> +		 * A prog without attach type is either kprobe or uprobe.
> +		 */
> +		if (prog->expected_attach_type != BPF_TRACE_KPROBE_MULTI &&
> +		    prog->expected_attach_type != BPF_TRACE_KPROBE_SESSION)
> +			return NO_PRIV_STACK;
> +		fallthrough;
>  	case BPF_PROG_TYPE_TRACEPOINT:
>  	case BPF_PROG_TYPE_PERF_EVENT:
>  	case BPF_PROG_TYPE_RAW_TRACEPOINT:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 457d75e..f2d4f8b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11856,6 +11856,10 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
>  	if (prog->aux->kprobe_write_ctx && !is_uprobe)
>  		return -EINVAL;
> 
> +	/* PERF_EVENT_IOC_SET_BPF takes kprobe.multi progs too. */
> +	if (prog->aux->jits_use_priv_stack && is_uprobe)
> +		return -EINVAL;

should we also ban all kprobe.multi programs in here?

checking only jits_use_priv_stack on the entry program may miss a
private-stack tail-call target, like:

- load a kprobe.multi entry program that tail-calls and does not use
  a private stack

- load a private-stack kprobe.multi target and add it to the entry
  program’s prog array. Their expected attach types match

- attach the entry program to a uprobe with PERF_EVENT_IOC_SET_BPF.
  The current check sees that the entry has no private stack and allows
  the attachment

- when the uprobe fires, the entry tail-calls the target, which runs
  with its private stack

rejecting kprobe.multi and kprobe.session programs on uprobe events
would prevent this path

jirka


---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e3f87d5df922..8b288729d47c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11856,8 +11856,14 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
 	if (prog->aux->kprobe_write_ctx && !is_uprobe)
 		return -EINVAL;
 
-	/* PERF_EVENT_IOC_SET_BPF also accepts kprobe.multi progs. */
-	if (prog->aux->jits_use_priv_stack && is_uprobe)
+	/*
+	 * kprobe.multi/session programs may tail-call programs using a private
+	 * stack, even when the entry program does not use one.
+	 */
+	if (is_uprobe &&
+	    (prog->aux->jits_use_priv_stack ||
+	     prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ||
+	     prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION))
 		return -EINVAL;
 
 	if (is_tracepoint || is_syscall_tp) {

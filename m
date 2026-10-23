Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739606;
	b=nBqfDIMCBNnD4gnSDKCDs6G68bH6jNNDtWdi1CJu2MbV75KnLwHT44H+nrX93MHm5h+G
	 DRNXQOwjk1v5/eiBPCzKhXTaWWSuQscTzjnfXuEp/Vy3xj5sHx+2x6uz4zhdXAAbe+bBz
	 XUTTqOjmrq9nvHq7qZ3rzFgn7a56VADLCmKp2QFO0dFYSQ0Do/ecV4kZUZwSOYL0LxUaS
	 HqUFnY+GbX0wM4L04xI8HIf+1oK+ssGw5nFjM3QyHXkV0DpNYvhL5J6b4k9jWZX/1vSQq
	 n8dtC93QHHVGtsBhHau7XXkgPdrrdW3KhtPmxfb5hoq1thu6QUIrM/VyMgA7yliRtfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wq7uJPFcmgA9r58RX9y8WD41guFgFXDdj9tzjsOmuN4=;
	b=ZtFGoOL6+aegBTyZRYQ7T+bH0KKBsQq8x0/UOC8yAhBmvdChXPpvh07qIB+FEHeVE94w
	 D2kLAowt0FgoODCUkAzgWaj/4ighPD3WSmlfQFBm9R7J129A62hPCJiHcsaxs9eNmI9tK
	 RvUpgRXE9gee2j81K0i7yj9kHZ4ybfAx5U8fxBlMsSIv0VLEOvHkan+BU1gPDgIYV7GBY
	 q3jYGGgcqWv4IelJkTS0kA4TPVsArr9wyycdytCBVKY5eqo5tqMcBtcAd4pECC5EcfCdN
	 FH+gUzdo9jb3Oga0Vm+TlPos0Ye3C1vSfCvdUgrP6MlK3gtVegQfFsNnpbl/d3oJN7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P+OLg24T;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3E0606A321
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 07:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C3E0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P+OLg24T
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e00eee27dso302027f8f.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792739604; x=1793344404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wq7uJPFcmgA9r58RX9y8WD41guFgFXDdj9tzjsOmuN4=;
        b=P+OLg24T2DE6IMHyEqMBpfaLZ19LKpR99sGMlJRmiYlyCBdb0kxRQwF4u/Uew8jBoE
         Kd967OujE2M3LR224GaT+vNY7a6ZVHhrYJaukdiTOprNNmrWe53mJkSvCILgqLFmUbFR
         xAKVDBE62GKFuNc4XlUB0vJSlY8sWaBxty6dB2u00s2qirUGX8n35La49WgHBOgYh7wn
         o5YV8/MG448i6CwxxFKntlyeREqUinFv328e9m465xH8Mu84saZRUnUVglkRJmqlz5bA
         uPmq6WOxIxjriPMmY9rWdzTIfjkHiONHvkGU/mtHlDPEfQiHG1ckLYBc+S6X/Fbln8qO
         yQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792739604; x=1793344404;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wq7uJPFcmgA9r58RX9y8WD41guFgFXDdj9tzjsOmuN4=;
        b=WVk7gCQoUWqZa4wAJirrccMDLZQQ5PwMTMazzM6p/p2hprD0/tMlUJAgnh0GShfWuY
         Vdyi2P0zGyShZ6NV0admKPSEGyFb2UMxggTCp+AG57rTxpOfiQ3p9oZfadVYRjmgv+9O
         /KX32C58uts398euwqradBuVWfZ1oSt2GU/yYQScnjdqcxhC6ZkqKfuH2ztCy89XmmBC
         K6YRh1xz5bvDqdvfyr+qhV+cf/wT+DNbLF1BYBCQAxHiHrg/4C9irzfcr7mcQ8bbZgjY
         JwloOfu+Aj0yhi7paLF/QztWjuX4ZKOigDOb6hnMOhO4sFIBBUhUFVEe244Z8Zo/z+RV
         2AHA==
X-Gm-Message-State: AFq9FYKyK6WcQTrCjNg6MIGBl7Lk6jZEN5T3qZGkjn34FTS1/iLT7Q/3
	5W9SqGXzkaJXj91TXwR+javuMawkU7QsZ8cMdTsprbx10kHnFb5yTHvL
X-Gm-Gg: AYBFou2b0PKo0ctTcP1LaMwd766H7hbKqOLguPaD/i61dR7AfUZ9munMfDW7seGSR+l
	O6ZhrgKJuIphGx6nJUbN35EwnOLN1tBhuDO0bs/Wvr06bbcoj41vPwpa3hQ0SLUxfcEfh0a79fh
	MinaqvLhNS1jj8B5PC0J343ByS5ynhjnMzv1hlB5MIzrFdVLZrInsJB4K2/HcxFVcaMLJcSe0Gk
	1RHmGiozuM8E8gpZ6qUU6exX8iuRSoar3UH1v1EecrVUqOHiUTcv2jeQABUmUerg5X8iDIhaFSx
	lyta2vs30XEmVUalIl3IKTtGXbwXcOf/r/HIVU5chYFBxEroi91ZnCcn8TuLMgJq83k7Ivv5GU3
	OilMyjZr50XpEok3gMsGE041vAALpHGajSWNi080E0ErWYg/ta9l4Qv/suH1b/CrFoupy0j+2Hz
	tUXqwgVdfD0k23SI4rukGbLVGyO5Vh+ckIub4NTziNF1SVnOrTcgA8Fk4h/eY8nljmMonpJhdsj
	josYLMwuQFcdA0nIF0FQy8oKLlv
X-Received: by 2002:a5d:5d03:0:b0:48e:3b48:6f1 with SMTP id ffacd0b85a97d-48e3b480974mr340715f8f.54.1792739604164;
        Fri, 23 Oct 2026 00:13:24 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38025d76sm3155877f8f.13.2026.10.23.00.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:13:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 23 Oct 2026 09:13:21 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com,
	peterz@infradead.org, mhiramat@kernel.org,
	akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org,
	surenb@google.com, david@kernel.org, vbabka@kernel.org,
	jannh@google.com, hughd@google.com, kees@kernel.org,
	mingo@redhat.com, tglx@kernel.org, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/9] uprobes/x86: Don't WARN if an optimized
 probe can't be written
Message-ID: <atsJEWXk04C4oz4R@krava>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
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
In-Reply-To: <20261022015712.1297331-5-alexei.starovoitov@gmail.com>

On Thu, Oct 22, 2026 at 01:57:07AM +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> __arch_uprobe_optimize() and set_orig_insn() do WARN_ON_ONCE() when
> uprobe_write() fails, and user space can make it fail:
> - -EINTR from get_user_pages_remote() when current is being killed.
> - -ENOMEM when COW can't be broken, since memcg is at its limit.
> - -EINVAL from __update_ref_ctr() when the process cleared the semaphore
>   of SDT probe.
> 
> Kill the processes that call probed nop10. It warns in 8 of 8 runs:
> 
>   WARNING: arch/x86/kernel/uprobes.c:1186 at arch_uprobe_optimize+0x291/0x3a0
>    uprobe_notify_resume+0x1c3/0x4c0
>    exit_to_user_mode_loop+0x63/0x4e0
>    exc_int3+0x1f3/0x250
> 
> The next patch calls set_orig_insn() from fork(). Kill the processes that
> fork and keep mmap_lock busy, while a trace event on nop10 is enabled and
> disabled. The kernel with the next two patches and without this one warns
> in 3 of 3 runs. The whole series in 0 of 3:
> 
>   WARNING: arch/x86/kernel/uprobes.c:1161 at set_orig_insn+0x161/0x170
>    register_one_mm+0x154/0x180
>    uprobe_dup_mmap+0x61/0xb0
>    dup_mmap+0x149/0x9f0
> 
> The callers handle the error. arch_uprobe_optimize() marks uprobe as not
> optimizable and byte 0 stays a breakpoint. set_orig_insn() returns
> the error. Drop both WARNs.
> 
> This depends on the previous patch. Without it WARN was the only sign of
> the bytes that set_orig_insn() cannot restore. Hence no Fixes tag.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  arch/x86/kernel/uprobes.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 62bbe41c6466..33c35bf07801 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1170,11 +1170,8 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  		int ret = is_optimized(vma->vm_mm, vaddr);
>  		if (ret < 0)
>  			return ret;
> -		if (ret) {
> -			ret = swbp_unoptimize(auprobe, vma, vaddr);
> -			WARN_ON_ONCE(ret);
> -			return ret;
> -		}
> +		if (ret)
> +			return swbp_unoptimize(auprobe, vma, vaddr);
>  	}
>  	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn,
>  				   false /* is_register */);
> @@ -1197,7 +1194,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
>  	if (IS_ERR(tramp))
>  		return PTR_ERR(tramp);
>  	ret = swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
> -	if (WARN_ON_ONCE(ret) && new_mapping)
> +	if (ret && new_mapping)
>  		WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NULL));
>  	return ret;
>  }
> -- 
> 2.55.0
> 

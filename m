Received: from mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9814431ED93
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576582; cv=none; b=q9PNsQr3U557HNpx4LFUGrhQHppMYwgpJwnwTr8cVeWFub/Us2nqE+LOYuUCtvYSHBJuWP9si7S1xtZ98LiTyzAPW2g7vniwPdFztxmfaShxnRewijBbX902dXe6UaOpZQvJuwcVNg+HFiLgY/jCA30aKAPbt9vOyNob2fg0bLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576582; c=relaxed/simple;
	bh=nWDpy78G4I2O3Sf5NQQKazMcmVxLo4DzM+EqJrLv9/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YT4kpIRu9l/6DafQxrRB0w9uOnSVPjFFm0KH/FECg5Y33zr5TucVkfkVZrFLt6ZXFFMOGHGSDup/G5o8+9V6ALxkaGGIal6S5fo/rCxradItU+WS6IYr+fjsPph5ovedCNcIkeFEZKUiIc9bUPAKhzvdxpFk6KW18towFmjHKkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bd7u63Qu; arc=none smtp.client-ip=95.215.58.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bd7u63Qu"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nWDpy78G4I2O3Sf5NQQKazMcmVxLo4DzM+EqJrLv9/U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786576577; v=1; x=1787181377;
 b=bd7u63Quk3hGSsFQqz8HEJu2ZQ068BeB+S/ZpznFKJmxAd8IHcflH9ImHIs4FP9JXM6BKva/
 E79eNtI2uH3dxgocq/Sj7uB3xXzr9tnTu65RfxCj3gXUBdYqUHp+aUCI8HBNSn1CPqPfZtfY7EF
 siD/5bl7ob1ojAXfhr5BKd2I=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:125c:1:c4d4:5d0:c3b3:cab6] (2620:10d:c090:500::5:f7a3)
	by smtp.migadu.com with ESMTPS id e54556f8fac35e5b;
	Wed, 12 Aug 2026 23:16:16 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <fe199e37-5231-41c2-b80d-c60a6907612c@linux.dev>
Date: Wed, 12 Aug 2026 16:16:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Fix arm64 KASAN false positive after
 bpf_throw
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260812-hello_world-v1-1-c3c2ddcb362d@meta.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260812-hello_world-v1-1-c3c2ddcb362d@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 7:47 AM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> arm64 passes zero as the stack pointer while walking BPF frames, so
> bpf_throw() leaves stale KASAN stack poison after jumping to the
> exception callback.
> 
> Use the frame pointer as the fallback stack watermark.
> 
> Fixes: e74cb1b42213 ("arm64: stacktrace: Implement arch_bpf_stack_walk() for the BPF JIT")
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

https://github.com/kernel-patches/vmtest/actions/runs/31634900957/job/94290630981

> ---
>  kernel/bpf/helpers.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6388b6b23e49..bbad75895331 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3395,11 +3395,13 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  		WARN_ON_ONCE(!ctx.aux->exception_boundary);
>  	WARN_ON_ONCE(!ctx.bp);
>  	WARN_ON_ONCE(!ctx.cnt);
> -	/* Prevent KASAN false positives for CONFIG_KASAN_STACK by unpoisoning
> +	/*
> +	 * Prevent KASAN false positives for CONFIG_KASAN_STACK by unpoisoning
>  	 * deeper stack depths than ctx.sp as we do not return from bpf_throw,
> -	 * which skips compiler generated instrumentation to do the same.
> +	 * which skips compiler generated instrumentation to do the same. Some
> +	 * architectures cannot recover sp while unwinding, so fall back to bp.
>  	 */
> -	kasan_unpoison_task_stack_below((void *)(long)ctx.sp);
> +	kasan_unpoison_task_stack_below((void *)(long)(ctx.sp ?: ctx.bp));
>  	ctx.aux->bpf_exception_cb(cookie, ctx.sp + ctx.aux->stack_arg_sp_adjust, ctx.bp, 0, 0);
>  	WARN(1, "A call to BPF exception callback should never return\n");
>  }
> 
> ---
> base-commit: 53cc65185a51fa9dd288cd1137a21467eced2df4
> change-id: 20260812-hello_world-2b03ed2aa5b4
> 
> Best regards,
> --  
> Mykyta Yatsenko <yatsenko@meta.com>
> 


Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414374611C2
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754378; cv=none; b=Rg8jj1JNLmoLBAC609rHXkknGVk41hEazNHLq7uvI/yc02eHyHa3PEox7yMMYN/1JCA5z/+W4sT+ISYghgcWm1WuAueWBDrKu7D65qhoA/rEsrIJ9D3WRvCzVTjQwyFx3RpIojyAvzmukLFOPh4ZzDn92Lgh5Lj+87T5buhR0xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754378; c=relaxed/simple;
	bh=H2ewWyZoTUuSMbvTqm7kRdUUeaX6ArFU5bbm3PW2ePc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=FEInRXTDSASvgAyVR1IChI+cZgdr3rrwptBGylmNly5YgXHnVbKo5H2R7hIYG8uKbWhuv88zd+HwjcrOzu2nq6wDre6r+930Pnp9LkBNChj2Ykc0OM4jx+SqOLaRLl3oCthVwa3r8sq2WOZpj1Kwf4vHPb6ywYpZJL4yqU6D4Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+TYcg/m; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+TYcg/m"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86b90133ae8so826297b3a.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789754377; x=1790359177; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5pI5RH2G6KIV3wXGdA0IQ/j93krFOJLQpi1nXbIewQs=;
        b=O+TYcg/mNMrepe2+sZmrVbzWLLxQ03tSO8PErWeZXE4oVMv6r/gkklc5754FvU6BdH
         RD21sbLIqNyh8p9M8pyYOFbjhiaVypkDd0B93cNBZP4NvmlYxYgRrl+1u6X/wgntsVLq
         5JLDU6dXsn6jowB7KcVax9sfA3+1arFn2nVMhJQYgld8Zc3Lhy/VJeTT7f+B+Hr87qsg
         t+PL4Z86xN5v/7zR3JwbIPNxWYsaPqvfy6A863tVpCB85bFlCah0chCMxh/TWsg0VSDZ
         QjxvLd3dwy8qkCLx2aOFolZVN9J4SxAGvstiE0/hjgxm0ewFZxtz+0SiXttMTRUvVcvA
         1W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789754377; x=1790359177;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pI5RH2G6KIV3wXGdA0IQ/j93krFOJLQpi1nXbIewQs=;
        b=Yrc+2nFMRqvT6KJyPrPIyjm5xYy8YWVXzIPq6KIQIE2qVhkp1xLM7qWL9j+VoUdCtk
         r8cCh4zLLpCkOPy61lCTrUSmT55eQ12CAWERmAh/KXumVOnYPxzh1sMZobkLVU8ahJVb
         wHqjzumA2023gjsZvAW+C3RCbu2CjibmIJf7B6hdYFSxqCxAKf4IGXGw02QZr+pD8K1g
         cnN6J/+SJNH+OSyoLYVBT5toOt+GehU/B01cU9FItQD77N/Zn2TSwNXXmEKiMXNqeJCH
         o23JrCpe6CfkhDhdDwWrwbDNYZdiP0tNL+0hyy5qwZIOHqaDjmj/a+0GOgaJtuaf3867
         aIBw==
X-Forwarded-Encrypted: i=1; AKwUvBxnSoT+i0Imzjn8ZGpjJac9nGNWYkbUqG2eCrzGYuKhyt4cYPkkDmUebJWIUw0OyRGlawo=@vger.kernel.org
X-Gm-Message-State: AFuF++koEJkNsr/SskktcdTyYQS8Ik23ayfof2umFft9h5RrZvijATTl
	R81t9nwgVP39INMxHHOn/dWa9QoP6xpTl8IlwdUimson1YMbCDZwS/RRCRWuOw==
X-Gm-Gg: AYBFou2VFHU2V852481wl+TTtqZ98DYfrnm+5risTy+OwhNtJyTnQdAzvDuXrjBiWNw
	vXcDiuNQhD5R1ij8Zxy3ASlKQUd8xBgkjTTyGtSRudrz6kIFh3W90pzBuUwiToqP88J6EoCCFsZ
	sphLMkVXptjlf/wlsghVtcIBuK5vLu6Vn9u+7KQr1X/Cm3bwFPZbi2xljSkL2qrE1Z7ro2NvvP0
	NtI2fUiQEGD/GwM14G7ykp6LC8LJrYcnk9JAutlEcaShdPGKmpKORXvak0Wuw2tihoQFZZjVvQ/
	i24kwXNPnAnwHZ/fRoBpwbLlKyLJ2t3l0MUyen7MAWS1KpoYTJOr15vrm0FG16gw4GCwKIXi0pf
	Im/9apmp94SqKBhv398pvdt6bFbX3hsyOTddI1NzH8LkgG6bZVQKhmTAIja+XrjMtWAhv2SMuaF
	7vMIOdTauOaC0coMLTOoB0VsGRds8Gwd4fV0/q5uOjMmHCbZzfuxKvsw9TrTacZNKfGcDMe82yz
	lvnbGzfgK+Nk5YNQGFS+YuYOKbhpONkBBTnYqRhI+UAwuws2u+ThVGnoRblSq6Co1RaXuMwHy7e
	8uFC
X-Received: by 2002:a05:6a20:3d06:b0:3dd:85a8:cacd with SMTP id adf61e73a8af0-3dd8c47dd66mr7132147637.36.1789754376511;
        Fri, 18 Sep 2026 10:59:36 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc5c50b0c93sm1410710a12.14.2026.09.18.10.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 10:59:36 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 17:59:35 +0000
Message-Id: <DLIMZ5I345V6.2VWICG8UTQD4D@gmail.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Shuah Khan"
 <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 1/3] bpf: arena: allocate the fault-in page
 outside the lock
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20260918084123.39477-2-jiayuan.chen@linux.dev>
References: <20260918084123.39477-1-jiayuan.chen@linux.dev> <20260918084123.39477-2-jiayuan.chen@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 04:40 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> @@ -489,59 +490,108 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	kbase = bpf_arena_get_kern_vm_start(arena);
>  	kaddr = kbase + (u32)(vmf->address);
>
> -	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +	page = vmalloc_to_page((void *)kaddr);
> +	if (!page && !(arena->map.map_flags & BPF_F_SEGV_ON_FAULT)) {
> +		/*
> +		 * Preallocate outside the lock so the allocation can sleep and
> +		 * reclaim, which the non-blocking allocator under
> +		 * arena->spinlock cannot. __GFP_RETRY_MAYFAIL: reclaim, but
> +		 * never OOM-kill in the map's memcg, which need not be the
> +		 * faulting task's. On failure, fallthrough: the locked
> +		 * recheck below picks up a page a concurrent allocator may
> +		 * have installed meanwhile, and otherwise the non-blocking
> +		 * fallback fails and we return VM_FAULT_SIGBUS. Not
> +		 * VM_FAULT_OOM: nothing ran the OOM killer, an
d the fault path
> +		 * would just retry it forever.
> +		 */

I asked for one line comment. This block and the one in !new_page
branch below repeat the commit log. Trim both to a sentence or two.

pw-bot: cr

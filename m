Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD82E7383
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720106; cv=none; b=XQqk300PiAakg2N4LIGo9xTmMl5TOj15t3lPmZglBq78B5V6qCBZHp29ZMv3shxWc3RC4hkpnQX/ahgHQtb1wQBhdYy4ftNxZIbtmtgOxcbUlvOD2IdjbLZOCWYOAT4TSkj0TVviNU6MpexTd2uykeDA1ZLHi4o4H0Hml1HfjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720106; c=relaxed/simple;
	bh=VNo+XMcqYzfsyjDQpadV1uocU4uj3LbEOTQZgrPg09k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=vDdUWH6wmjiKB/xawF/RY3uVO2jrcJKYbaARWjLN2VvlkqzzPkI+xjNt94tLxpFJZNbCJvMZ/r/IGO9PIh9UKOZIzUZuk5owcuPKFIugOgAkkqUHlsfYmlGxQztSQcjmuCj/f/8CdVxbzXRuHB3G6T1So6MM+UOZFaf7zf1EXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J84zgguP; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J84zgguP"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47825ef4012so1540709f8f.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 18:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785720103; x=1786324903; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QdqRShD9VZDhrLxatfTV4kRkPg0UGmMhyIWhN5tmL0Q=;
        b=J84zgguPM+jh9G5qGMLdcWYD+21oS3l/zqGhGQVBlDcbGseNTkuuZMDaz/fSJ2CxEp
         M3qEcVWSr2vMejIeUvAEueursy6kV30kKaOCwxr/8tVwsfLZvvfy/uAjTlI+8YhnLTIb
         NC9Hzwh43W39/c38rw3Md2IVzq41JidLE7/3iiaLH4R/iPxasISOyX++GVDV0/jzHHKD
         cXYrDLGR2uSgd2BqeXVo3/yDsUoS4W8KS0qhX7H58AG7WSFLJ1+frwEJdLjtQqx3xGA6
         uEJGgM7wXYLfWFa+/hsKgFQrLgb76fnZCWuOo44UxEW7heOR6sWj9TE3l8HIEGfZm78b
         +R/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785720103; x=1786324903;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QdqRShD9VZDhrLxatfTV4kRkPg0UGmMhyIWhN5tmL0Q=;
        b=CEafbzvqH9oB9P9J5Bz90WrkbGh1CkYOWCtQXDoKd1JqEjKR3lUPmHL/Y8T/Tuhv6z
         CovcNot7zIoT9wDKzhxjuIgUmRTkewS9e5AuR3IhSCaveaBiwYXC6KVyRc3zHe1hnoHo
         EzewhZdtODKs0EbU4/UE8cX90SxbR4j50CK9ZD+PdjCA/oSDxWSskHEPPT8hs/NVivhn
         yuxYcs1Zvu5cz/+B/cRNu/4wa8TjYI5OEsz1w5UVbrh9ignNKHXktBYg9Dw3yu6pn1en
         n2qRfbdxOE/UVSMXOPtlXXQSJqQgCdU9Z3dFCwXChZIFXT+G1/nEUJ10bmfLDiz3p7S0
         uLpw==
X-Forwarded-Encrypted: i=1; AHgh+RpHfeUNHe8Iocj/0laGjxqAxx/U/dEfNmHvqc9uXDVLFpcQX5WIBVAaXOUsAJG0NeSOp0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJMjuqp53bwfi3G586v6ykT4aEGbS4yUWRedRd+b2Fovtdpp2W
	N1CFgDYrw+MJRZXmYmr4NI4d0yDnpUbQ4uCuTcZDedM01FehDzdnq0aL
X-Gm-Gg: AR+sD11ynJr3ust/b0l2bRkEde6iKI3TL10hZFBhLEMXsESMujvg7aF+4QAN/4CRtwT
	9SaRNCoK6JL72krIVdo2Bg+GUcoSRNB8gX4OhJR9HX21iFL90w5kB72AZH8CtxwRoPGqqle0eT3
	zJlU9oN+Bu8GR7+49sk+9LDBhvDtqTle7OqFxmnRok8wSlKI9ThXlAYb8WgZDmdHUlqVaByyCuz
	MNWdq+aT6U3bhvpdNXyxMKwfWQaIGp7bU0ls3nipmd9vNSdwqaHbfRPhHISt6NuVI2z/YqYSJiV
	ADbkza9/nzhYLU/PctAq2QGFqbp/ZbZTLvGzYhFzlFO9UdUNXCjsF1RgAZ6M05eoEw5kEboSzbA
	qgI/Q6c941TvlOAq66xwu+t6OkhLHF+08sjwEuy7XA4oCSIhPm0aD0Ln9dbCEcCfiuL298lC5q7
	rbjpIRyhylYWx/6UBq4hM49bQy43bdvgjoD3qHFSp2BVBDMUQGUNEmYnPzWfkXPwYWij8HyvDXI
	HwXeqjJ6w4zWkFN3hN8yzzpnHROHa+WEOsZVBvsUN5bSbr9gGf/vgpWjzLuP21vMIG3pv2SLpj5
	6pUmzfwYe+9A236120Dcpc0XvuU1YLSTOKOWVg==
X-Received: by 2002:a05:6000:25f3:b0:46e:1815:6a83 with SMTP id ffacd0b85a97d-47fd72f1666mr20060691f8f.29.1785720103309;
        Sun, 02 Aug 2026 18:21:43 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458adc9sm29487799f8f.27.2026.08.02.18.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 18:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 03:21:39 +0200
Message-Id: <DKEWY0MJHZ64.ALDUTQQ1RPLG@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Puranjay Mohan" <puranjay@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: arena: fix mmap_lock deadlock on arena
 lock failure
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260728060517.95183-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260728060517.95183-1-jiayuan.chen@linux.dev>

On Tue Jul 28, 2026 at 8:05 AM CEST, Jiayuan Chen wrote:
> Reported by the Sashiko AI review.
>
> arena_vm_fault() returns VM_FAULT_RETRY when it can't take
> arena->spinlock, but it never took mmap_lock. The fault path assumes a
> VM_FAULT_RETRY handler already dropped mmap_lock and re-takes it on the
> retry, so mmap_lock gets taken twice and can deadlock:
>
> 	do_user_addr_fault()
> 	{
> 		fault =3D handle_mm_fault(...);   // calls arena_vm_fault()
> 		if (fault & VM_FAULT_RETRY)
> 			goto retry;   // re-locks mmap_lock
> 		mmap_read_unlock(mm);
> 	}
>
> Return VM_FAULT_SIGBUS instead, for two reasons:
>
> 1. We could keep VM_FAULT_RETRY, but then we'd have to drop the fault
>    lock first and cap the retry ourselves, the way __folio_lock_or_retry(=
)
>    does.
>
> 2. A failed raw_res_spin_lock_irqsave() already means a possible deadlock
>    was detected, so retrying just hits the same lock again.
>
> So returning VM_FAULT_RETRY here is overkill.
>
> Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> ---
> target to bpf-next since I think it is moderate.
> ---

This looks ok to me, but after staring at this function for longer, I think=
 all
kinds of non-recoverable errors should be using VM_FAULT_SIGBUS vs SIGSEGV.

The only case with SIGSEGV should be the flag based request to disable
allocation on lazy faults. That should include the scratch page case, since=
 it
represents a hole.

SIGSEGV: BPF_F_SEGV_ON_FAULT, scratch page.
SIGBUS: lock acquisition failure, range-tree failures, page allocation fail=
ure,
kernel PTE install failure.

All of these SIGBUS are almost improbable, but I think it would be cleaner =
to
keep semantics clear.

Could you follow up with this change? I applied this one for now.

>  kernel/bpf/arena.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 34f023a537fe..555ee2531ef9 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -490,8 +490,12 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vm=
f)
>  	kaddr =3D kbase + (u32)(vmf->address);
>
>  	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> -		/* Make a reasonable effort to address impossible case */
> -		return VM_FAULT_RETRY;
> +		/*
> +		 * A failed lock means a possible deadlock was detected. Don't
> +		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
> +		 * the fault path would re-take it on retry and deadlock. Fail.
> +		 */
> +		return VM_FAULT_SIGBUS;
>
>  	page =3D vmalloc_to_page((void *)kaddr);
>  	if (page) {


Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A7199FAB
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 02:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776219684; cv=none; b=uL3Eudm0XMoLLA9lVxwdkdfK0P57ViW+GX2Hm/aQaz+UfW62MBus3/2MiLR3NK5vws6KP179qmryekT5j6UW/3fnNxWmbKfhHuTioTtFERFGicYmjIBwVb/QKvcUmHElpK8uLw23tI55b1iKZpqzs/WH919Kkp6GD7qaRttSVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776219684; c=relaxed/simple;
	bh=2ZFni32DwSOQD4lldbN0qLdvwVeFCqmDKNmGNbSJl9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mheb1qJhz3asJjuR0ZNDVgVK8f+py1CdXQ3pvOUmB4oTABtTeU1eKjhfoUzJZUlsTS5ICcYLrSyw7Tir0cKGhDMOwOk5fTPayI+87r/cCG2eInqUqXL5E4GJ7NnsuDE8CIHLyrW5j2c/zlPpMdT1AwuxSxMR9+yecUAKuLry7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6fsn1pQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6fsn1pQ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso4025963b3a.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776219683; x=1776824483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HS7cWqMUFC2ao4CR2ACvoc0MZzkDPRRg6tci7itXNa0=;
        b=q6fsn1pQxUKjXkwUy78zVNhbxK+3677whZ0ya6r/HFa4jretumVlPBkat0itKjMoLy
         GzNkso9MkjzEQlZY2lKvcNA95vOxMzhms3qhc16T91JOG/M/PFuBqxRP5WmU7tCi7Y2K
         TFjczCTWQmG/3TcO1QEHHQeTfUivm14UZjsQ2cy/7LKv27IcOx3ufYqZAC8zp2pdZ9S4
         Y8LHBfdGhk7kEb1fKVTVhi26U6DLIbxQW6/Jh/MbsRn+Dwlj9Wr+FHNYNJHgh7cedqKT
         wGsk/NHP0A+kML2DPZMQVHiMKHvGwxreieBBg9r4hwwSfg2325s5Cz4DBaswNYtntMec
         vNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776219683; x=1776824483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HS7cWqMUFC2ao4CR2ACvoc0MZzkDPRRg6tci7itXNa0=;
        b=Q2vUdaaTc11AhcpuUpSrlq5r9byVbh0MGi8aaGz2GN6xyk4HeccHWRR/umf8sG1VpN
         4tADwvud/paLcd+afNJBhPZPX0P3zPMQ3zQWpmhEu87FKSlgxkqk9myg/7KQ0QC+5Cd1
         TnVvwGVRL5ABlc2lQZdhYH2Missu4vKfPrBz/Vr6kcy5LTF/8KR4toxmCr8M4jI+iSCJ
         +vliIWuOtObIt8hU1Y7sW3elnCtoXuqjEUfihN9DIGsRCCayLbamG4opGfxageFg1uCp
         6G0iv8YnkhQ9DMNFyCBIs2YEjQokTvQFQR3XyE2Oe/jVpSlQC/iCAcYSKGoSgJRyufut
         lyVA==
X-Gm-Message-State: AOJu0Yx4Fs3XD7nFreOJvRfbtLqq0lZZ0pyWhz1TlnitxltNkDOMp83f
	iIyTv/KMLhq/75XfbGXk0N20miBxePoEoyUdkTjMN6m/OBJ2T7HDSufX/IRVww==
X-Gm-Gg: AeBDiesKWpl/pClHvcXk75QMgPpFuqsVlT8rpF0KGE9EIkejmvr4SN+kbpkFyduQEKS
	FxNvKbjckOQBtbmQhvTjg7s+AxgXrnprFiqkWfi9gHguyReiQ8whMP5CqNuRkipTY80V4A7YDQ+
	EOUMJgdCyOwfoibhUHcmIdMfOhqi2VRa+Qlhti+ccWv5ELr5d2wXe5unBDZ+CWHd8Lz9BqA6GBt
	NbB8C7Oslwl9BSabVyN0zwMfMNj5HTWbeJ5EbmgjJglfpd9fBiq8cRRyOhuWFHMrHOS5h2JNZJH
	6JKfE6khdDUFgsVrb8H8Vd/iC3SZl+0OwvcWlrraUnwY4wOkmk2ZA3PLlBVipvdBa6cqNIvYlxQ
	BE/VK8mbSYGEQzDo0UBa6wtB9lbVicX7sWTiA0zVx7STCeO105aiXQOe4tL7CmtvrECSWhUVKyM
	z0GV5Jg3Lf3v4Id4CfeIjU4UcCrKAgzYBtpUXFZCnyanwOXhqD9LRNb/6moJC3RI5Q7mLuyRy7Z
	C74/afSdVmUhTEioH5TKIGbOTGK8aTkdISQguN8cst68Agvi2AUSR4OCCnV5lFjXxqYDSI=
X-Received: by 2002:a05:6a00:3907:b0:81f:31c3:2e34 with SMTP id d2e1a72fcca58-82f0c29fed7mr20322572b3a.25.1776219682729;
        Tue, 14 Apr 2026 19:21:22 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6743f375sm368483b3a.51.2026.04.14.19.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 19:21:22 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:21:21 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com, 
	qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next v4 5/8] bpf: Update per-CPU maps using
 BPF_F_ALL_CPUS flag
Message-ID: <l6hz6k6ecgmgcwsqt63ozobbzeryupq5os5oay42tlyqom776d@z6gq7eq44eua>
References: <20260414132421.63409-1-leon.hwang@linux.dev>
 <20260414132421.63409-6-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414132421.63409-6-leon.hwang@linux.dev>

On Tue, Apr 14, 2026 at 09:24:17PM +0800, Leon Hwang wrote:
> When updating per-CPU maps via the lightweight skeleton loader, use
> a single value slot across all CPUs. This avoids two potential issues
> when updating on an M-CPU kernel with N cached slots (N < M), especially
> when N is much smaller than M:
> 
> 1) The update may trigger a page fault when copying data from the last
>    slot, as the read may go beyond the allocated buffer.
> 2) The update may copy unexpected data from slots [N, M-1].
> 
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/syscall.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index b73b25c63073..f0f3785ef57d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1785,6 +1785,21 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
>  		goto err_put;
>  	}
>  
> +	/*
> +	 * When updating per-CPU maps via the lightweight skeleton
> +	 * loader, use a single value slot across all CPUs. This avoids
> +	 * two potential issues when updating on an M-CPU kernel with
> +	 * N cached slots (N < M), especially when N is much smaller
> +	 * than M:
> +	 * 1) The update may trigger a page fault when copying data from
> +	 *    the last slot, as the read may go beyond the allocated
> +	 *    buffer.
> +	 * 2) The update may copy unexpected data from slots [N, M-1].
> +	 */
> +	if (bpfptr_is_kernel(uattr) && bpf_map_supports_cpu_flags(map->map_type) &&
> +	    !(attr->flags & (BPF_F_CPU | BPF_F_ALL_CPUS)))
> +		attr->flags |= BPF_F_ALL_CPUS;

This looks like a hack. It's not addressing the actual bug.
If there is a bug submit it separately with fixes tag.

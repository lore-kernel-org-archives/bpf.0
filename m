Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A44854FE
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792238346; cv=none; b=tAIPmk825aa09iCFDSenccpChXkEHu8VNz25wIh2MtzA4huVzOlHayHZH/B7zeGYqbje6eq8orLvrI7L1UiYjnos2HDNUfEsIJ+whGxwqq7ftGTT4Cwo/rgKMBe5j8gH6Ohtp34PVb6j+KgsE3wSqQ8XJF3Av5/hLja6siC0LnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792238346; c=relaxed/simple;
	bh=/5W7yfQWUjlhg2PznHzgMrn3QOe0WSW70S1frAhCr9g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOjHj0jaEFo76gUKHWyT2hOqUZhC+uki8w4iiwmNf3OLtzYbmnkGJa1ZpN0SEQispVuepJWDbMQo2xREAZtlXBxjXJYT/Rm+EVvSZS4+QR55uc3SliO/lP9bFz2liDkhpo/iEITBCNZwwBeEnxQuE/qK72UufIqD8xua5rmG/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8/qKdxg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8/qKdxg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a01933b584so5759425e9.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 04:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792238342; x=1792843142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F292idQfENMQMCSk/GPruM0KbknrhB8tHsls8DaLCOg=;
        b=L8/qKdxgS2/C3FT+FudZ0elNUze86D5NBHuVTdbeWPAm7wrzx2g4d3Dc7LWKWzpzE5
         K7gblef1szJfk0EPgwSRhxWsqsTKg3yh8mHshzfEPX8PukvXVPwFTWwzZH1El8/6CpIE
         ChupKjWsX+dAvRJXCBZc5p1ttrRVH3A96+c7WoyxmmkucdBEUi3ga/UP2+uAcktUsFon
         rL+KJBCYjI58NlXNWv9lyg6h6CI73KVEmC1YFYGSZW14WqpDiEpxqsU83GJJlxeLgVmc
         Q8qVq91In6VAlknB9+/mu7eiTjMFc9wmOBfUntIM6Gydz//wOh4v41oLa4oroVdPDVvs
         wHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792238342; x=1792843142;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F292idQfENMQMCSk/GPruM0KbknrhB8tHsls8DaLCOg=;
        b=hC/gmWCNbxl1VfHMpUXAyuBGM0TRgM3J+W64j4jCOEKXqg+FTs+QlqkV7Pht3jdV03
         KCnK1lB9+Ft35EipUO/ONLgiz3S/+WcK04XXWT+aVIgpYEsRoKClfkycuPMGjuuZboDs
         v/H0++BXktJZRlpjEMKU3duZyGVkLfVtzOdqE7KmYoZvejQYUfJDmz9hotk3iM26nJBv
         JbdHSUArTe5EcZEMJtOck5ARX78U1Mh0RgnUx7ltDJJTdCQtKzJ9iNAze0N3ej6qtze5
         jjVlYYxQmXxHdULNK0Q3vNR8EcUF55kGDZ9IAhHgRR2SjAr/4wfHcLMR4L6gn2jAshw+
         Yd+A==
X-Gm-Message-State: AFq9FYKQffxPtJNUmWLvY5wwb5NjxeiGrSNTV4K7Nvent5+wlqCG20qi
	3o1bLiebu22NqYIj7egYdmgUmhgtodbgAVA2LkMg4OLTIeEM/dZTdlnA
X-Gm-Gg: AYBFou24WmuhW8r7ssPjx4jw46yQKB89z/37XczgMoA3dKkwkn0w9dmg0M6N1sl8B0V
	gUXgLWjnEvjAHcqL7tFH7FJPSUVxuzCrqQuHGeNAoPLihiLAaWXIqUwaAHEpIBaP5jMJBYXym53
	6iJWO3HJbRxgtObuQX3e9kxG0deFilk4vOrnEOUrK2TJtbiCyHYt/LFGtYXINsu3Fcavjx3/h5A
	cppMSgSPGc9Hvl/2QwkLhfoJnmsl8qP9bqVBB0Ekri4rQZzqUJIpVwEu9Es3ZF/IhC+9JutK01G
	6fDIA/ff8TxFS3U1u3jxK5/sImWvz3wMcXYFIhowIxQVhGk7whgQJnYBat3jheXuDQJy5EzVFYh
	ROpWQAatckEA3f1UPXxeTGpiz8Z3AFGDXXnMS2JzuzRhFjni3dduMJiYnvRndPudcRJlA6+6nkf
	bKknfYGef1hFRsludbR+tkExrwP4fAeuFQuf1gtekSd8hT
X-Received: by 2002:a05:600c:4503:b0:4a1:985b:83a9 with SMTP id 5b1f17b1804b1-4a1d75acb11mr60015615e9.4.1792238342202;
        Sat, 17 Oct 2026 04:59:02 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d7659805sm76775585e9.7.2026.10.17.04.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 04:59:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 17 Oct 2026 13:58:58 +0200
To: Woojin Ji <random6.xyz@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Zero-extend the index in inlined
 bpf_get_func_arg()
Message-ID: <atNjAqRLEIlZsmvp@krava>
References: <179221432098.1890560.17043109037413683447.get-func-arg-index@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179221432098.1890560.17043109037413683447.get-func-arg-index@gmail.com>

On Sat, Oct 17, 2026 at 02:42:24PM +0900, Woojin Ji wrote:
> bpf_get_func_arg() takes a u32 index, but the inlined expansion compares
> only the low 32 bits of R2 with the argument count and then shifts the
> full 64-bit register to compute the context address. R2 is ARG_ANYTHING,
> so nothing guarantees that its upper bits are zero: an index of
> 1ULL << 32 passes the bounds check as index zero while the load is
> performed at ctx + (1ULL << 35).
> 
> Zero-extend R2 to the u32 index the helper takes, which is what the C
> implementation does; that path is still reachable because LSM programs
> with BPF_LSM_MAC are not inlined. Widening the comparison instead would
> reject indices whose low 32 bits are valid. Since the check is 32-bit,
> this cannot change which programs are accepted, only the address.
> 
> Extend the existing fexit and tp_btf tests with a 64-bit helper
> prototype so the upper index bits reach the expansion.
> 
> Assisted-by: LLM
> Fixes: f92c1e183604 ("bpf: Add get_func_[arg|ret|arg_cnt] helpers")
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
> ---
> Validation:
>   - Built the modified objects and both affected test programs.
>   - Disposable x86_64 QEMU guest, clang-22 kernel with BTF, tracing and
>     bpf_testmod: both tests pass (2/0 PASSED, 0 SKIPPED, 0 FAILED) and
>     the guest dmesg is clean.
>   - Same tests on unpatched ff47652a4b66: the wide index faults in the
>     inline sequence and the guest panics.
> 
>  kernel/bpf/fixups.c                                |  5 +++
>  .../selftests/bpf/progs/get_func_args_test.c       | 36 ++++++++++++++++++++++
>  2 files changed, 41 insertions(+)

nice, please split kernel and test into separate patches

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> 
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index d6f83521fc78e6c6a82d1969662f1eb52f64f4c3..005ed9279ebab60a8a774c4e6937232ab4f38962 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -2255,6 +2255,11 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
>  				cnt = 2;
>  			}
> +			/*
> +			 * The helper takes a u32 index; zero-extend it before
> +			 * the bounds check and the 64-bit address math below.
> +			 */
> +			insn_buf[cnt++] = BPF_MOV32_REG(BPF_REG_2, BPF_REG_2);
>  			insn_buf[cnt++] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
>  			insn_buf[cnt++] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
>  			insn_buf[cnt++] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
> diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
> index 1bf47f64d0967a3543739841201b58b14b4036a7..9b0beb58d88d5bcf1a36a0598695fd02a2cebbcf 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
> @@ -6,6 +6,40 @@
>  
>  char _license[] SEC("license") = "GPL";
>  
> +/* Keep the upper index bits: the inlined expansion must truncate them. */
> +static long (*bpf_get_func_arg_wide)(void *ctx, __u64 n, __u64 *value) =
> +	(void *)BPF_FUNC_get_func_arg;
> +
> +/* Both traced functions are called with arguments 2 and 3. */
> +static __always_inline int check_wide_index(void *ctx)
> +{
> +	__u64 a = 0, z = 0xdeadbeefdeadbeefULL;
> +	__s64 err;
> +	int ok = 1;
> +
> +	/* The index is truncated to u32, so these select arguments 0 and 1. */
> +	err = bpf_get_func_arg_wide(ctx, 1ULL << 32, &a);
> +	ok &= err == 0 && ((int)a == 2);
> +	err = bpf_get_func_arg_wide(ctx, (1ULL << 32) | 1, &a);
> +	ok &= err == 0 && a == 3;
> +	err = bpf_get_func_arg_wide(ctx, 1ULL << 59, &a);
> +	ok &= err == 0 && ((int)a == 2);
> +	err = bpf_get_func_arg_wide(ctx, (1ULL << 59) | 1, &a);
> +	ok &= err == 0 && a == 3;
> +
> +	/* Out of range: -EINVAL and no store into the destination. */
> +	err = bpf_get_func_arg_wide(ctx, (1ULL << 32) | 2, &z);
> +	ok &= err == -EINVAL && z == 0xdeadbeefdeadbeefULL;
> +	err = bpf_get_func_arg_wide(ctx, (1ULL << 32) | 0xffffffffULL, &z);
> +	ok &= err == -EINVAL && z == 0xdeadbeefdeadbeefULL;
> +	err = bpf_get_func_arg_wide(ctx, (1ULL << 59) | 2, &z);
> +	ok &= err == -EINVAL && z == 0xdeadbeefdeadbeefULL;
> +	err = bpf_get_func_arg_wide(ctx, (1ULL << 59) | 0xffffffffULL, &z);
> +	ok &= err == -EINVAL && z == 0xdeadbeefdeadbeefULL;
> +
> +	return ok;
> +}
> +
>  __u64 test1_result = 0;
>  SEC("fentry/bpf_fentry_test1")
>  int BPF_PROG(test1)
> @@ -63,6 +97,7 @@ int BPF_PROG(test2)
>  	/* return value */
>  	err = bpf_get_func_ret(ctx, &ret);
>  	test2_result &= err == 0 && ret == 5;
> +	test2_result &= check_wide_index(ctx);
>  	return 0;
>  }
>  
> @@ -162,6 +197,7 @@ int BPF_PROG(tp_test2)
>  	/* not valid argument */
>  	err = bpf_get_func_arg(ctx, 2, &z);
>  	test6_result &= err == -EINVAL;
> +	test6_result &= check_wide_index(ctx);
>  
>  	return 0;
>  }
> 
> base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
> -- 
> 2.47.3
> 

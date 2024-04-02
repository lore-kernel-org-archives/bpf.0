Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616FBA2D
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022194; cv=none; b=VczawDo5fof8EQl/l1VVGWqz7j3edqXpIw43naApDnnGbBVemO/w4jnAhU7tBo9hog7rPpWWza+0/YcpFuuLqgWoMJ7oYwa8hIopF66uCvSc0oBv7lSBeMsFLvXdx+ZIwx/S8xsRV9obgK+a8TS1vcHB3Vspr+tvPKHU3wkDpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022194; c=relaxed/simple;
	bh=9lafj426yYoxdGJQQm8DP5OfR16+bP6HF3zltbZ5cY8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Et65whtfl8Kf3Hpzh4y5f4GhwYRQKAP1P661ueuXGdm5I1qHrO8J6jq/KIOe/wQ0yCckXXnEj7B0neL2l6JvjbxXyOg4dXOB2r0PI9vL4Qv9TsZdPBHeQyoAa3FTl7B/CvRLcGn/v+uY9U6KE62VXWtKT1dnxbMFfRRuqMM+xsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJW+60AM; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJW+60AM"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e6d0bf038fso2344968a34.0
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 18:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712022192; x=1712626992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgF46DkrDWAF4rHUC9bnEai9bqS4en3KICvQe/n3UtU=;
        b=nJW+60AMqwyznJwVOlRTj01DSEcPOJ2NrbApt1I+xqkaVWWTZHy3sWI4+fMhFz6Pfr
         22HLr9P8Mnfieca/fbMImuEZjhlDfukxP0Avx2K55s4kW5r/z5E33yiNUa4sToIF6oxp
         hpcwi790PNfZ5J6yes56Mdy9jH5gqJ2AdNoXffg3HEcLWYPVTXorrhZ3nwpL2uvoxAHi
         tLMIGNELHzU8eG0fic2myYgHXyaYcp6V58YLDdJPWCWX4/B3ROrZ9vycyx+p30JjlrRn
         l/KSPGodltFkMyAHpJxHw3iNiiOHfY12p2D8MJHrjzE7PQIzuRcSxMoXf05/QICoAIzy
         1lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712022192; x=1712626992;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JgF46DkrDWAF4rHUC9bnEai9bqS4en3KICvQe/n3UtU=;
        b=GW9BXYu1L+0mnXRyi3F3//IderIf4I45uzVEnf85HauvBXYorfg3N/JIea+lK5XLZH
         iVWy+ffgnxk/+VHWokc6tQChuGFw5MKPoFUno5dvqKIdeXLNpUBE6BnrrUJoiI7nd5Qm
         VzjySz8l5ABBFV4Jkuwv2Qt6ij0wnaYe+SrABkvgLyXeZBBW6eNsajpUtQKN5oTIB75L
         cCB2980iHZSYE35nf0m+KQerNkj0cqDoPHHJ8v5/YNZoVWqbKCB3eg/risfTv5vHv9io
         YiUV1gw31+sMEATWBHDHaDckRl+KHiLPGlFroyIpuFrPdquZ8XF7g81Jdy3poKmq8gfl
         MaxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA93VMpvbNwxOUEhfskv3LM94Md1zx3s0jwL7OuSbu+jZmy1FMJQk96BBrPGzEkOSF4JuQvR9m5qoViGIWfZawmc1Y
X-Gm-Message-State: AOJu0YxrtQDi5JIvrmr75smLXL/9evz2eR9hjtkeYBl4m4eqZfVIPjiM
	Bm2UBueV0f3osP5iAAZgkkOFSOkSxHWaxTgkkq5m2p/a1GlwVbFQ4OfuHGtU
X-Google-Smtp-Source: AGHT+IEZVed4uZBavwT+zLIFANUPP9oo+8Hqk2OriTE3Ly6JORNeJapcDDsVYYXEyoc6QupaeNHemA==
X-Received: by 2002:a05:6870:4629:b0:221:8e01:4c6f with SMTP id z41-20020a056870462900b002218e014c6fmr13117346oao.36.1712022191995;
        Mon, 01 Apr 2024 18:43:11 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id w25-20020aa78599000000b006e6b7124b33sm8515756pfn.209.2024.04.01.18.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 18:43:11 -0700 (PDT)
Date: Mon, 01 Apr 2024 18:43:10 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 kernel-team@meta.com, 
 andrii@kernel.org
Cc: sinquersw@gmail.com, 
 kuifeng@meta.com, 
 Kui-Feng Lee <thinker.li@gmail.com>
Message-ID: <660b62aed55f5_801520863@john.notmuch>
In-Reply-To: <20240401223058.1503400-1-thinker.li@gmail.com>
References: <20240401223058.1503400-1-thinker.li@gmail.com>
Subject: RE: [PATCH bpf-next] selftests/bpf: Make sure libbpf doesn't enforce
 the signature of a func pointer.
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kui-Feng Lee wrote:
> The verifier in the kernel checks the signatures of struct_ops
> operators. Libbpf should not verify it in order to allow flexibility in
> loading different implementations of an operator with different signatures
> to try to comply with the kernel, even if the signature defined in the BPF
> programs does not match with the implementations and the kernel.
> 
> This feature enables user space applications to manage the variations
> between different versions of the kernel by attempting various
> implementations of an operator.

What is the utility of this? I'm missing what difference it would be
if libbpf rejected vs kernel rejecting it? For backwards compat the
kernel will fail or libbpf might throw an error and user will have to
fixup signature regardless right? Why not get the error as early as
possible.

> 
> This is a follow-up of the commit c911fc61a7ce ("libbpf: Skip zeroed or
> null fields if not found in the kernel type.")
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  .../bpf/prog_tests/test_struct_ops_module.c   | 24 +++++++++++++++++++
>  .../selftests/bpf/progs/struct_ops_module.c   | 13 ++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> index 098776d00ab4..7cf2b9ddd3e1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -138,11 +138,35 @@ static void test_struct_ops_not_zeroed(void)
>  	struct_ops_module__destroy(skel);
>  }
>  
> +/* The signature of an implementation might not match the signature of the
> + * function pointer prototype defined in the BPF program. This mismatch
> + * should be allowed as long as the behavior of the operator program
> + * adheres to the signature in the kernel. Libbpf should not enforce the
> + * signature; rather, let the kernel verifier handle the enforcement.
> + */
> +static void test_struct_ops_incompatible(void)
> +{
> +	struct struct_ops_module *skel;
> +	struct bpf_link *link;
> +
> +	skel = struct_ops_module__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.testmod_incompatible);
> +	if (ASSERT_OK_PTR(link, "attach_struct_ops"))
> +		bpf_link__destroy(link);
> +
> +	struct_ops_module__destroy(skel);
> +}
> +
>  void serial_test_struct_ops_module(void)
>  {
>  	if (test__start_subtest("test_struct_ops_load"))
>  		test_struct_ops_load();
>  	if (test__start_subtest("test_struct_ops_not_zeroed"))
>  		test_struct_ops_not_zeroed();
> +	if (test__start_subtest("test_struct_ops_incompatible"))
> +		test_struct_ops_incompatible();
>  }
>  
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> index 86e1e50c5531..63b065dae002 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> @@ -68,3 +68,16 @@ struct bpf_testmod_ops___zeroed testmod_zeroed = {
>  	.test_1 = (void *)test_1,
>  	.test_2 = (void *)test_2_v2,
>  };
> +
> +struct bpf_testmod_ops___incompatible {
> +	int (*test_1)(void);
> +	void (*test_2)(int *a);
> +	int data;
> +};
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops___incompatible testmod_incompatible = {
> +	.test_1 = (void *)test_1,
> +	.test_2 = (void *)test_2,
> +	.data = 3,
> +};
> -- 
> 2.34.1
> 
> 



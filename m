Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8423DEFE1
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242798; cv=none; b=S4ZYpVJ5Jcm7s9L9Qom71jH7P8tA7hPa5Le2CAG2UYR69voB4LpQD8TrS5T9uZISImzJBOpyYcUs+VtIxZSix/LhRYLCKTVA71ziZMbGboCmInQMr6bHMTcJR9ZoIaef9JASksXPJwgtjvCVMP4LbgkSI/RHkH9BFK7W745alSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242798; c=relaxed/simple;
	bh=Ogmo8lAWGR7xwaijtfYuplaPa093NRJ7ZgbTzbnG5J0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iipKAQ6X2wohVzzaT5W3/PJJoeJSYeZuyxvBSzcrivriIClu7cw6iGdfmjNhiPDpMpjP0GbRanNxF3zW+Q5VP3lMONzqGDD4j/WBF+tEYNNM89Ei7oBairkOV9IhLbX5u/N4WTcS9nh2JdWg8dASxuJchqGzPNEVV5VVzJN8Pls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdHdiuLe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdHdiuLe"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439aa2f8ebaso7152879f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773242795; x=1773847595; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eS744gcGkNHKNUI99cJyO4KVI3lVp7bb2Qfj3UT6608=;
        b=EdHdiuLeLkie5oeqkJoXjTpgQTFjSQHcPKpzMArNYjh2HXxa3Ln+x+SDJnnvutOMsH
         f6j//+TDySlKwJ60J+K9SMOquU2zdGZOoWiT14beiUM8v5hvaMCZr78/a0/+BMtCvzaF
         7rYQD+enEmOsTVYEQ1RKtdVvUh5lJ5gfGZdhqTFU/+AeVrR4bO6/c3uu8KvBZZRmn8GD
         AVHjFab7vHe52t/z96eeLevlpvvBZG6KKG1aWPR9alRtrrU+5llFD4BYz7eRx3IsZ7Ph
         ml3ix0/PkczXN9cI7WOl7H1M7LwPqUjTcIEdg8GvciJ/NIYzDRRUU0vKgjlqbR6XnXEs
         s2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773242795; x=1773847595;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eS744gcGkNHKNUI99cJyO4KVI3lVp7bb2Qfj3UT6608=;
        b=EBCmP5eVg+5u2ek3jljgJxWTvO9d7vycOezK3yHkbmj6hHhse90mhEskhbDhnp57Zg
         tNOkIeQIKAhwazg8hEkYHpnTF9R6H8etCJ/D41apWwhScpIAdlMv7Q01rYizIr5Lh2Kw
         yCJ2mkitjn7hBjH6Zvn3mRQWda9WbXtGSXB80lfbcBgsMkqXFFE7LcenEvukLo/Dxc8b
         wjQQWNys/2DXNMsyxifRRtuCs1WjIZpTL8f683ScooechpyCO9JaEfjICVx8+3bhAmIk
         mbEPMRUf5hbvT+z37OQNbhoc/HyqgSIYwnMKo0FHHxrqyL+awng/lZiaF0lO/87ysbxt
         kXQg==
X-Forwarded-Encrypted: i=1; AJvYcCXuGFISYowko/yQBlxBBSwFlKnpwAk541nQ5VmFZLAQnApbJb1BhYDZoBgDScJr6DtVR04=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6rr33SgsbUE0mWZZQzihAs3724kXsj+bvopfwOpDqXGQNwGh
	Q3UQDlYO9B/SALYeon+iAYB4So9VqNRvwC9lprunfavbH0wFFutvPyIOHFDXQw==
X-Gm-Gg: ATEYQzxC3R2dU86QSDl+Ijp5/tUZFgSU+FmBsr1vdzy6GQTNvEr34/DnBG96AsHH/Hn
	4xwZPrZ78uNo3zi8wMrZO9FiFmqRvzXMyEXZOFh/6FIzJ6XWIQbviBiQ05jc/carx4hHw1vOiBN
	+DwWViswBxOd2WQiZ8nMpOjTvB2CaDIrUSIZRtVhhnBsiuqCpqflbI3ZO6PVgodUPlkob7Am+1R
	KoxmJMlYosahdo4nZbxH9fRwxBTbn3cb3g80ib4sXv1WSZtqnYSLFfeGS5clgiHINfxR3wzniap
	RWlqtvlbmXxXQDqYFlQyhAaOiDDJAdlnVcxKufLowrRVkvYdNN6vp8wRvotJ8WI+99GD/MBLXnc
	N6Rn/8Juqp8xOrAu5kI2d5rJRVhLxf5ESv0RLh50PGANZRsNGMoEnkD3e1HKnLXFtlRXT2d5/o6
	kVn56P+ew0K3E7yj7AhpsA41aVVCHNeEpLZLldYg==
X-Received: by 2002:a05:6000:184d:b0:439:ad2d:99f8 with SMTP id ffacd0b85a97d-439f821b6b3mr5685512f8f.30.1773242794679;
        Wed, 11 Mar 2026 08:26:34 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f818d5eesm8699344f8f.1.2026.03.11.08.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 08:26:34 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 ameryhung@gmail.com, kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next v2 02/11] selftests/bpf: Test passing
 CONST_PTR_TO_DYNPTR to kfunc that may mutate dynptr
In-Reply-To: <20260307064439.3247440-3-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
 <20260307064439.3247440-3-ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 15:26:33 +0000
Message-ID: <87ldfytmja.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amery Hung <ameryhung@gmail.com> writes:

> Make sure for kfunc that takes mutable dynptr argument, verifier rejects
> passing CONST_PTR_TO_DYNPTR to it.
>
> Rename struct sample to test_sample to avoid a conflict with the
> definition in vmlinux.h
>
> In test_kfunc_dynptr_param.c, initialize dynptr to 0 to avoid
> -Wuninitialized-const-pointer warning.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../testing/selftests/bpf/progs/dynptr_fail.c | 37 +++++++++++++++----
>  .../bpf/progs/test_kfunc_dynptr_param.c       |  2 +-
>  2 files changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index 8f2ae9640886..5e1b1cf4ea8e 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -1,15 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2022 Facebook */
>  
> +#include <vmlinux.h>
>  #include <errno.h>
>  #include <string.h>
> -#include <stdbool.h>
> -#include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> -#include <linux/if_ether.h>
>  #include "bpf_misc.h"
>  #include "bpf_kfuncs.h"
> +#include "../test_kmods/bpf_testmod_kfunc.h"
>  
>  char _license[] SEC("license") = "GPL";
>  
> @@ -46,7 +45,7 @@ struct {
>  	__type(value, __u64);
>  } array_map4 SEC(".maps");
>  
> -struct sample {
> +struct test_sample {
>  	int pid;
>  	long value;
>  	char comm[16];
> @@ -95,7 +94,7 @@ __failure __msg("Unreleased reference id=4")
>  int ringbuf_missing_release2(void *ctx)
>  {
>  	struct bpf_dynptr ptr1, ptr2;
> -	struct sample *sample;
> +	struct test_sample *sample;
>  
>  	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr1);
>  	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
> @@ -173,7 +172,7 @@ __failure __msg("type=mem expected=ringbuf_mem")
>  int ringbuf_invalid_api(void *ctx)
>  {
>  	struct bpf_dynptr ptr;
> -	struct sample *sample;
> +	struct test_sample *sample;
>  
>  	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
>  	sample = bpf_dynptr_data(&ptr, 0, sizeof(*sample));
> @@ -315,7 +314,7 @@ __failure __msg("invalid mem access 'scalar'")
>  int data_slice_use_after_release1(void *ctx)
>  {
>  	struct bpf_dynptr ptr;
> -	struct sample *sample;
> +	struct test_sample *sample;
>  
>  	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
>  	sample = bpf_dynptr_data(&ptr, 0, sizeof(*sample));
> @@ -347,7 +346,7 @@ __failure __msg("invalid mem access 'scalar'")
>  int data_slice_use_after_release2(void *ctx)
>  {
>  	struct bpf_dynptr ptr1, ptr2;
> -	struct sample *sample;
> +	struct test_sample *sample;
>  
>  	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr1);
>  	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
> @@ -1993,3 +1992,25 @@ int test_dynptr_reg_type(void *ctx)
>  	global_call_bpf_dynptr((const struct bpf_dynptr *)current);
>  	return 0;
>  }
> +
> +/* Cannot pass CONST_PTR_TO_DYNPTR to bpf_kfunc_dynptr_test() that may mutate the dynptr */
> +__noinline int global_subprog_dynptr_mutable(const struct bpf_dynptr *dynptr)
> +{
> +	long ret = 0;
Why do we need this long ret? Do we even need this function at all, why
not calling bpf_kfunc_dynptr_test() directly from the
kfunc_dynptr_const_to_mutable()?
> +
> +	/* this should fail */
> +	bpf_kfunc_dynptr_test((struct bpf_dynptr *)dynptr, NULL);
> +	__sink(ret);
> +	return ret;
> +}
> +
> +SEC("tc")
nit: it looks like most of the programs in this file are optional:
SEC("?tc").
> +__failure __msg("cannot pass pointer to const bpf_dynptr, the helper mutates it")
> +int kfunc_dynptr_const_to_mutable(struct __sk_buff *skb)
> +{
> +	struct bpf_dynptr data;
> +
> +	bpf_dynptr_from_skb(skb, 0, &data);
> +	global_subprog_dynptr_mutable(&data);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> index c3631fd41977..1c6cfd0888ba 100644
> --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> @@ -33,7 +33,7 @@ SEC("?lsm.s/bpf")
>  __failure __msg("cannot pass in dynptr at an offset=-8")
>  int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
>  {
> -	unsigned long val;
> +	unsigned long val = 0;
>  
>  	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)&val,
>  					  (struct bpf_dynptr *)&val, NULL);
> -- 
> 2.47.3

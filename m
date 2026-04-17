Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779E242D6C
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776452773; cv=none; b=TFytDiWrdBxpTnFmwHRC0TaHsp/B2bTWWLY2v4oug4myzNQ2F0IsJgmZdpbYPSnC3NumhzGniYlWBRGP96bPVUKkiqwfljECq+lNLSyUbFxZdlB6QVvmkws9JnGJZZ+5AK9ouWnaTQ/NxISTUO7kjqt5OJSZJXQKcj6c92B6BA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776452773; c=relaxed/simple;
	bh=oiwNIeQ+/soz/GMdcWJ1DChG9aTiTISpONG7hWVSAuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVEmVxLTe62uuAYMo9ShJpVH+gWJ+YsaWfxEpVKUCX7RybBKiSGCwzpZayXPLjh/ik1cv3EDCdUNmTbnBn8kFgjyw/F28h/WTRROFT+XcamqzHRTMKMSrjPdO2OsthEkVMNukQE+YJVncUb5EagQdKfl6CgBwhlQsf2kKATWwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozOK7Bcd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozOK7Bcd"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so15111305e9.2
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776452769; x=1777057569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6SLK5eDHl4RX3XXdt4XzP0BAoRN6edvAAQ6upqBPYs=;
        b=ozOK7BcdIWmAHoxCujaFVLyvp1EgYSTUedIJsE+CawlO73vhLcFlwyeX8QYkh/VZko
         LZqTr7EAPTgE+ggUPZLP5BfwlzXA7qBzxznXHMOpZAj5lBghnOoiIeZWqUnJWCFqgpGi
         s4RBj6f9GW9BW40LRYpBLGJTdHhUYmNAdQUCw2vKE2HSdeHQDXBjv0Pl4bfSGw/rh1sI
         mWyPmpczuPHxTBsbXvlNWtaxg4fPTjcfMbKMoBs19WqsuAN+Zyn1bfwq8IJRYPmvfbza
         3F6J6RpSNXLZg+IcEmOX1OZXSTVJwuYI8RgcjlodCSpiSmMMeG4ViHPZKHrIFCntMYud
         Oxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776452769; x=1777057569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6SLK5eDHl4RX3XXdt4XzP0BAoRN6edvAAQ6upqBPYs=;
        b=Sxvj69OmvSqrN15FcQ2I7MNmfgwQ/HvvVIEj+mgbd3OT+bxP16sRLiC2SVdNQcPaFK
         yVQDlHBIxbN/QD/zOiZ0O1mEjBh6e22cPVTsb7Cbj8CyP2JP1sObiNb8mcUsUoMMx6M+
         sks2EHdKg7Xp/boli4WKkh6ridkK+dkmwaUV/mvNPY6dmroN3alqvYtcRZEb+z5TekHt
         geBCeyPjZMvzlANG/W4KTXScqIfXtMOl+ANohdefvPLp7vdYGbMdOFEeNbBdZDB+KIRv
         C2BKBC7Mt2HoIdZDHK1w4GCK8gieW74PNZC1pSrobvwMEq+kCHvtIR1AK9D/BSiUxTlF
         uRdg==
X-Forwarded-Encrypted: i=1; AFNElJ+2wOQVpYvtuvCjjrSbbVbW1uvcxHJg4xmSTQBeh02A0QyKVtO3d1VOYli7KvBZFmFdjeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKqESsLFTd97KHU/NaJhHzIEt5UfIFU600ZMYmxOd8PtSiibyN
	T90K1uilqDVo/ed43RAWrTP8CTPN9Fq6/9+GHPcrw/SMX0hSc2kuow3l
X-Gm-Gg: AeBDieuJ5so+ibjlHwwIxXqbiAg5HS2zo8756lBGSaNwbeXqd+Z3nqNbpuMwhYZjFKH
	kd8x5ck20ANdr35Yq9/o0wkh9HPtrJrrdHimCu8FvH1XMTP0Vv+T90+brcu+Oldk1YIMp1xu6Ya
	FcK1b/hXPhZMMGa46hb9W3rlwg2y8gJVH9Gcm39r4Ax0tjx2nM2iLwwjUpZX4MH7YnDIiWHbD4m
	o59Vdr1KpbjwSlnKEpUJpmUCl5p6j6QbGgh5bxSwEe2TLhGh0G69NwA6cOSwB9nUhky25chHv9Q
	9Q8eN9H/vXnyptO2rkC/5WQ8WE5yn/iZL4sFh0WFEzwOY4xJGNPh9FoEY+05pkZk29y6CuUk5ZF
	V8rss180HlOEPG23/0U2N+sQnhyClFgcWhgbMAFg9ucsRfkeUGSPIRaMxmNQRPktJaM72ryN6e3
	OXKYp6CjuuXqBgtsaiw7twLHxmn0atGhvl/GZffLf4k96V2tz4HVvJXMeMcGZUvmQwEO/3jNA/n
	sJLHqu1H0l+KUTEN0oOCg==
X-Received: by 2002:a5d:5cc4:0:b0:43c:fc5c:aa0b with SMTP id ffacd0b85a97d-43fe3e13c5fmr4949881f8f.42.1776452769020;
        Fri, 17 Apr 2026 12:06:09 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1249sm5697762f8f.5.2026.04.17.12.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 12:06:08 -0700 (PDT)
Message-ID: <57c7dabe-6467-4e8c-b066-0cb62625286d@gmail.com>
Date: Fri, 17 Apr 2026 20:06:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 5/6] selftests/bpf: Fix up __u16 vlen
 assumptions
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
 bpf@vger.kernel.org
References: <20260417143023.1551481-1-alan.maguire@oracle.com>
 <20260417143023.1551481-6-alan.maguire@oracle.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260417143023.1551481-6-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/26 3:30 PM, Alan Maguire wrote:
> Fix up a few cases where we assume vlen is 16 bits.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>   tools/testing/selftests/bpf/prog_tests/btf.c             | 2 +-
>   tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c | 3 +--
>   tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c     | 3 +--
>   tools/testing/selftests/bpf/test_progs.c                 | 2 +-
>   4 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index 0cc347e32db3..a9de328a8697 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -8092,7 +8092,7 @@ static struct btf_dedup_test dedup_tests[] = {
>   static int btf_type_size(const struct btf_type *t)
>   {
>   	int base_size = sizeof(struct btf_type);
> -	__u16 vlen = BTF_INFO_VLEN(t->info);
> +	__u32 vlen = BTF_INFO_VLEN(t->info);
>   	__u16 kind = BTF_INFO_KIND(t->info);
>   
>   	switch (kind) {
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> index 5bc15bb6b7ce..6bc31236805c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> @@ -487,9 +487,8 @@ static void test_split_module(void)
>   	for (i = 0; i < ARRAY_SIZE(mod_funcs); i++) {
>   		const struct btf_param *p;
>   		const struct btf_type *t;
> -		__u16 vlen;
> +		__u32 vlen, j;
>   		__u32 id;
> -		int j;
>   
>   		id = btf__find_by_name_kind(btf1, mod_funcs[i], BTF_KIND_FUNC);
>   		if (!ASSERT_GE(id, nr_base_types, "func_id"))
> diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> index 469e92869523..5064aeb8fe67 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> @@ -253,8 +253,7 @@ static int find_field_offset_aux(struct btf *btf, int btf_id, char *field_name,
>   {
>   	const struct btf_type *type = btf__type_by_id(btf, btf_id);
>   	const struct btf_member *m;
> -	__u16 mnum;
> -	int i;
> +	__u32 mnum, i;
>   
>   	if (!type) {
>   		PRINT_FAIL("Can't find btf_type for id %d\n", btf_id);
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 7fe16b5131b1..cc14b13e23fe 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1257,7 +1257,7 @@ int get_bpf_max_tramp_links_from(struct btf *btf)
>   	const struct btf_type *t;
>   	__u32 i, type_cnt;
>   	const char *name;
> -	__u16 j, vlen;
> +	__u32 j, vlen;
>   
>   	for (i = 1, type_cnt = btf__type_cnt(btf); i < type_cnt; i++) {
>   		t = btf__type_by_id(btf, i);


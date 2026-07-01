Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45E38D40E
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940415; cv=none; b=hj5aakRjBQFyxB8n0gVYpETsttboTm6cbDiZ/iNSWrHhpTK9e1Gd7u1ciyRdkLPfVhxNv4gwbNW/BmP8/yYp24xyILLi83aZJW5XclBLTsUdOVcxWm4fyAwfI/S3IWcFJKO1fnHWJwzKHSc0w4Vfxn+rhxYqPRuI4VSY4Hu5TYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940415; c=relaxed/simple;
	bh=ixq5iPSr6lESeemFDQZAkXkMKmcyRqci45TX352zPc0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bPQcxFRNbzYZJsciRG1o1n5DeUjv8YhhsipOJclKkj1NwJlo+66gW4BsyH30PT+ICljtzzO/betS5YaULz2AK5N4qshw38/99gheW8gnJpOs1ZCsXlns3nY/el+0MPNQK04rdKdcUYSgR7B86DOlQdfSuvcOHCv/3YL5EDbuWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ziCf3MT1; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ziCf3MT1"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51bfbe05683so6936691cf.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782940413; x=1783545213; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjeDKyLKBZcUrNcouKdVLuX/5CVGzH0NAqcX61nIrwU=;
        b=ziCf3MT1mC6t3eZjzKPwBOQhxxXNVyCAXHfuW7yuekhEovINnoB67ExFfaPgT0An2F
         n18q59b2weTI6L3JWBH0zmm/Ux9/t2uVpEfB5t8+uaIfpazYhZFEmU5GB+TxrGbjklsF
         6WksxwEAJKGe+yO5WCY2OpO+UxJ2srJnCB1iAN3Ih02yyZ3hi2hHw0F6O6/AvqIvCiYE
         J7N/g2dLwGM1uUsaTpWBIng3GqNOoi+/y1xptCo8SJ1WUL/+Dtl/SLTt0erAPChx8zm0
         oWc4k6Ri0pcjdRDbs0E7TrPm2XyoFYXkTZwu2+grBCrLDp02i4g+DzVb2SJYQW7fvC2W
         0Bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782940413; x=1783545213;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjeDKyLKBZcUrNcouKdVLuX/5CVGzH0NAqcX61nIrwU=;
        b=JSZZDzolTmwvtfLNWM1yXBFgncKy+m36IiLyvQozVmlAc0QjTCUO1uAMdiAzFQMsxk
         VToTbDlVr+VD0h6akZ5ng+VTXsX8/vjpzEcFNekT0KsDWUmmVMSdOLOZaW3NmGvDyMd4
         OCzhaeAkCInJ+F23G63rZJuOl+btGKCPnszNOHvBl/XhCG7r9Z85fTFaBuShgCw7HlpX
         HcYzUK0KW9zWt3s2VIeaVH6fBsIREFyZFidxdOCPupoRH+CKqclhYchZ7cC35cy+V7m3
         6AMgCQYBpQD9dksJTKHhoqVm61nBjLrwaBPADRdNoUaDWRqy6Srsf/gDLlm85dp4HYKH
         xTHA==
X-Forwarded-Encrypted: i=1; AFNElJ9z80/8xd86Lf096NJRGeucHJMTwHYN3Iw+AcBL3YsleUTJyHYG8Y9eshyKJkO2mn8IG2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfPx4bRDHkQYJQ8gtuHTcMoDBiVQtQ6V75pUQxUE+bmdS4uEKr
	+6pFzZvaD0I6pl5r1gxMlCkiTI41lHw7nd+LazM5IhOLkWtoareZrMc1bjL75/7pXU4=
X-Gm-Gg: AfdE7clmdzr8nVZJgAIV44wnxtkzs5TVjzR/8KNaECl0hHy7AgtIng5m1NHnKnuhKvW
	wOvKeidW9yMqCLp2qIcYQkK23oEnFwEPOSHwbcCbgQUliYiXIx+fECCdSiA0zwAFajwrE7jujWZ
	XCw/Ubvi3Wv378rWZ/5mQpUGEJtMyl+m5vNJc0XvA2PxBd5hFRd5MmiinB0TMztRty6/iZw2JhB
	QIn/Q9HnJkZWq8M0W659qR5VPKisq+bsZH2JWxqoYCxvpmMjNN99GFkLkOTKXyBHqY22pQCYc/2
	dGXU9rR0hRvWvwMtUET1PqPqpO5izdHABtc77HwP8TY7BK0NDq0aEesV0MH5s4cuOetGYqPkCsY
	KhJYt26zdU3W3tJ/1w/Bvn4wS0KDv9ZeDYtfbkymezmeZQUapnUyuz8L5Xj9Bai4S6wQHBbr01/
	+HcrVPJDq7ty8=
X-Received: by 2002:a05:622a:116:b0:516:e152:7a59 with SMTP id d75a77b69052e-51c26b14343mr45276931cf.42.1782940412547;
        Wed, 01 Jul 2026 14:13:32 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d53fsm8562786d6.5.2026.07.01.14.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 14:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 17:13:31 -0400
Message-Id: <DJNJMLHHX9UQ.PEYCIU5HPCR2@etsalapatis.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover scalar arena frees
 below the base
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <cover.1782813442.git.chenyy23@mails.tsinghua.edu.cn>
 <e4226ac143315bb584dfedc79693ccf813ac56b0.1782813442.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <e4226ac143315bb584dfedc79693ccf813ac56b0.1782813442.git.chenyy23@mails.tsinghua.edu.cn>

On Tue Jun 30, 2026 at 6:12 AM EDT, Yiyang Chen wrote:
> Add a verifier_arena case that fills a two-page arena, calls
> bpf_arena_free_pages() with a scalar address one page below the arena
> base, and then verifies that another allocation is still rejected.
>
> Before the runtime guard, the invalid free can repopulate the free
> tree with an out-of-domain offset and the final allocation succeeds.
>
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Nit/question below.

> ---
>  .../selftests/bpf/progs/verifier_arena.c      | 41 ++++++++++++++++---
>  1 file changed, 36 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/t=
esting/selftests/bpf/progs/verifier_arena.c
> index 62e282f4448aa..b4bd134646607 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -12,15 +12,17 @@
> =20
>  #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned=
(8)))
> =20
> +#ifdef __TARGET_ARCH_arm64
> +#define ARENA_VM_START ((1ull << 32) | (~0u - __PAGE_SIZE * 2 + 1))
> +#else
> +#define ARENA_VM_START ((1ull << 44) | (~0u - __PAGE_SIZE * 2 + 1))
> +#endif
> +
>  struct {
>  	__uint(type, BPF_MAP_TYPE_ARENA);
>  	__uint(map_flags, BPF_F_MMAPABLE);
>  	__uint(max_entries, 2); /* arena of two pages close to 32-bit boundary*=
/
> -#ifdef __TARGET_ARCH_arm64
> -        __ulong(map_extra, (1ull << 32) | (~0u - __PAGE_SIZE * 2 + 1)); =
/* start of mmap() region */
> -#else
> -        __ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * 2 + 1)); =
/* start of mmap() region */
> -#endif
> +	__ulong(map_extra, ARENA_VM_START); /* start of mmap() region */
>  } arena SEC(".maps");
> =20
>  SEC("socket")
> @@ -93,6 +95,35 @@ int basic_alloc1(void *ctx)
>  	return 0;
>  }
> =20
> +SEC("syscall")
> +__success __retval(0)
> +int free_scalar_below_arena(void *ctx)
> +{
> +	void __arena *page1, *page2, *page3;
> +	__u64 bad_addr =3D ARENA_VM_START - __PAGE_SIZE;
> +
> +	page1 =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (!page1)
> +		return 1;
> +
> +	page2 =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (!page2)
> +		return 2;
> +
> +	page3 =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (page3)
> +		return 3;
> +
> +	asm volatile("" : "+r"(bad_addr));

Why the asm volatile? We use it right underneath, what does this give
us.

> +	bpf_arena_free_pages(&arena, (void __arena *)bad_addr, 1);
> +
> +	page3 =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	if (page3)
> +		return 4;
> +
> +	return 0;
> +}
> +
>  SEC("socket")
>  __success __retval(0)
>  int basic_alloc2_nosleep(void *ctx)


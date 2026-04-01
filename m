Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02B3E275C
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083095; cv=none; b=ZXM1NpOPa+caO6nTaQapbBrQT0An2ZzMEn2kpqdBewdRhiIVipCMvXipEEUzCafnZhAddT+A/mf2qHtHGiN4n/bid+md452GOHFstfmo8Rg25PHGbqqdTTJnzWaJg+tg4IVCTWCtolwPlpEh6ctJnqjxwq69b+4y/bnuuVCnEts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083095; c=relaxed/simple;
	bh=VEopQ6sXn2fWBMK64oy+ORJ79nDXHlb9oCXBznWQpVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mxtRkkA1ycT+cjMP2am/RNI/13UiLC4slrBzo9+TDpq93EhSNWEpJH0rPmd2BD3PtD1ZlSsf8vcM7fdHiwcumItqh4N0NaQBga0xSWMQounHm1rzNvOLTRTFoB5olYPovAfUo0GpkavhVlCLHTQIhfQu8UrGu3d3VSRNU1QMku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn8kDPFw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn8kDPFw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4888375f735so1619785e9.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 15:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775083090; x=1775687890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZEI0lu5ovAeU6GbsH63w7tJK6jkkYtH4a4Zc5Kuvujc=;
        b=Fn8kDPFwzJI8OtQVVUz5y7ro0OUl89z8lUcT+vJcEqa7wyXRkzdS6U2tcG11ZDPDa7
         8B/jDkofFijlyvCL6bmXuoAIaOhHzyLV7KjvZ071eJircYl7tnJH2lfnT8H/sKc0A/Cu
         EtILZBW/2RBlgFGJio+cXOsavcA2qxtttfgMApb7ecCQ+wkuspK0zzD5Ww4oecAv14Fk
         9M0rrgoOh7wakMVxdH3VO8rTdUn1gXRDkiCxzr3BfELtUeyM6boraWhUi4bI9d3ltcWa
         cBryxJz0wcCY/OKZvuE/UWY/nlSn5bxqJ2UuCHfWQQ/Fpx3Bs5MJ81FPnYWSA5I/RdGx
         rPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775083090; x=1775687890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEI0lu5ovAeU6GbsH63w7tJK6jkkYtH4a4Zc5Kuvujc=;
        b=jJxF0jiEpDiS8b3F4j+w1uWrFYjZvQWSOJDLlFQJVDzL9JnAj3y3OTM8/obkegAEPf
         AN4+Y9L8tdepZ9VDSUxqJfOVL3k3/dF8UruEWKfibGTCJpA3UWJ50mEwBkZpGfeI/Cgm
         qrqUnpl6cs/PZm8PVAtffUaqniaSM/Nz8sdffSrxF/ME7h9SIyNN+7K0EMFY+isl96LF
         XGNHxJzjJmJl+4hv2ttxLd/oCptMoDr/kEa9QdaateZxWCyzoBm+kdmLbEkfohA2MZcD
         YU6nWf4RTQV//LhJYOq3vsTqGobmv9vG6L5Qnwk141+h4FsXjvTdpN3FC0ICRVHZbRKG
         651A==
X-Forwarded-Encrypted: i=1; AJvYcCXUdd8s6SSMGtQ4oFDk8WwvUk+WmLs1pHeVfk/biNAPrIQbTyWPdMz4g6w9ZYHsJqMSuUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3YtQHkjLJOqdm/QEPIwtCjtK+qt8NQfz33Rl8rEVCAwNs/6IY
	cP4aWqtbKG1nkgRUhTSZ4C21pYyeBnlq5O1JCj/P6jJTH3KZyn39yrRo
X-Gm-Gg: ATEYQzwcHLotKHtvMDl/+8QObmbpVrS21AzpYVqRmcyi+1Ukso+gOG0SzyiVyGir3kN
	mCg2Oxw+rTt5HZMQoM1oMDyGl7SKNd73Y8tEVaX+2tjLGsRXSZdPABlsx3qCQ08VYlgsNNFajxh
	Kdu8YxJD3rrso4TKkh4pS464eF5q06c4cth/Hu95TTHSnWGg832stQtfb48ShNkm8B4u/uuLG0x
	z7Vm3d4UrKu5VHLOWdXQLltmUJWsSq8EiAYiZffAmqnLken2BAlmhqly8XYNssM7sSO1idihFr7
	5p1cG3g2zRSSgdtmhS9q1/tXR92xth3qoUiMzeTsaosKwdIDxtqHb/8ABGLez9xiz8j/lrqSLP0
	M6FrdsFv0Rukyvto/6IHhQy3CmqmjzHB9QCNRtllSeaTmmoYlJ/JQlWeGKvIcQuqqrjiXTogCKg
	apmczfOzPwyLUr77bTTnY/e0QUcm6lqvUo3Oi/FMRQ6iI0oXnpqfEaoHs8ZdyikUKzSEsM1s4YG
	/VHDUvdvN0=
X-Received: by 2002:a05:600c:c87:b0:485:3c8f:e4d9 with SMTP id 5b1f17b1804b1-488835b7813mr80740505e9.26.1775083090010;
        Wed, 01 Apr 2026 15:38:10 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e9630ddsm136102055e9.13.2026.04.01.15.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 15:38:09 -0700 (PDT)
Message-ID: <680e35d1-04bd-403c-9aca-f2b8a0af9af3@gmail.com>
Date: Wed, 1 Apr 2026 23:38:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add more tests for loading
 insn arrays with offsets
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiyong Yang <ksur673@gmail.com>
References: <20260401161529.681755-1-a.s.protopopov@gmail.com>
 <20260401161529.681755-3-a.s.protopopov@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260401161529.681755-3-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/1/26 5:15 PM, Anton Protopopov wrote:
> A typical series of load instructions for a gotox looks like
> 
>     r1 = &map + offset1
>     r1 += offset2
>     r1 = *(r1 + offset3)
>     gotox r1
> 
> Here offset3 is, normally, equal to zero; but this is not guaranteed.
> Extend selftests with tests for non-zero offset3 and, while here, also
> add tests for negative offsets (the offset1 and the sum of three offsets
> still have to be non-negative).
> 
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_gotox.c      | 114 +++++++++++-------
>   1 file changed, 73 insertions(+), 41 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> index 75b0cf2467ab..594adf698fdb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> @@ -317,7 +317,7 @@ static void check_ldimm64_off_load(struct bpf_gotox *skel __always_unused)
>   
>   static int __check_ldimm64_gotox_prog_load(struct bpf_insn *insns,
>   					   __u32 insn_cnt,
> -					   __u32 off1, __u32 off2)
> +					   int off1, int off2, int off3)
>   {
>   	const __u32 values[] = {5, 7, 9, 11, 13, 15};
>   	const __u32 max_entries = ARRAY_SIZE(values);
> @@ -349,16 +349,46 @@ static int __check_ldimm64_gotox_prog_load(struct bpf_insn *insns,
>   	/* r1 += off2 */
>   	insns[2].imm = off2;
>   
> +	/* r1 = *(r1 + off3) */
> +	insns[3].off = off3;
> +
>   	ret = prog_load(insns, insn_cnt);
>   	close(map_fd);
>   	return ret;
>   }
>   
> -static void reject_offsets(struct bpf_insn *insns, __u32 insn_cnt, __u32 off1, __u32 off2)
> +static void
> +allow_offsets(struct bpf_insn *insns, __u32 insn_cnt, int off1, int off2, int off3)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	int prog_fd, err;
> +	char s[128] = "";
> +
> +	prog_fd = __check_ldimm64_gotox_prog_load(insns, insn_cnt, off1, off2, off3);
> +	snprintf(s, sizeof(s), "__check_ldimm64_gotox_prog_load(%u,%u,%u)", off1, off2, off3);

here offsets are int, but printed with %u.

> +	if (!ASSERT_GE(prog_fd, 0, s))
> +		return;
> +
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +	if (!ASSERT_OK(err, "test_run_opts err")) {
> +		close(prog_fd);
> +		return;
> +	}
> +
> +	if (!ASSERT_EQ(topts.retval, (off1 + off2 + off3) / 8, "test_run_opts retval")) {
> +		close(prog_fd);
> +		return;
> +	}
> +
> +	close(prog_fd);
> +}
> +
> +static void
> +reject_offsets(struct bpf_insn *insns, __u32 insn_cnt, __u32 off1, __u32 off2, __u32 off3)

If offsets can be negative, should these arguments be int rather than 
__u32, also matching reject_offsets?

>   {
>   	int prog_fd;
>   
> -	prog_fd = __check_ldimm64_gotox_prog_load(insns, insn_cnt, off1, off2);
> +	prog_fd = __check_ldimm64_gotox_prog_load(insns, insn_cnt, off1, off2, off3);
>   	if (!ASSERT_EQ(prog_fd, -EACCES, "__check_ldimm64_gotox_prog_load"))
>   		close(prog_fd);
>   }
> @@ -376,7 +406,7 @@ static void check_ldimm64_off_gotox(struct bpf_gotox *skel __always_unused)
>   		 * The program rewrites the offsets in the instructions below:
>   		 *     r1 = &map + offset1
>   		 *     r1 += offset2
> -		 *     r1 = *r1
> +		 *     r1 = *(r1 + offset3)
>   		 *     gotox r1
>   		 */
>   		BPF_LD_IMM64_RAW(BPF_REG_1, BPF_PSEUDO_MAP_VALUE, 0),
> @@ -403,43 +433,45 @@ static void check_ldimm64_off_gotox(struct bpf_gotox *skel __always_unused)
>   		BPF_MOV64_IMM(BPF_REG_0, 5),
>   		BPF_EXIT_INSN(),
>   	};
> -	int prog_fd, err;
> -	__u32 off1, off2;
> -
> -	/* allow all combinations off1 + off2 < 6 */
> -	for (off1 = 0; off1 < 6; off1++) {
> -		for (off2 = 0; off1 + off2 < 6; off2++) {
> -			LIBBPF_OPTS(bpf_test_run_opts, topts);
> -
> -			prog_fd = __check_ldimm64_gotox_prog_load(insns, ARRAY_SIZE(insns),
> -								  off1 * 8, off2 * 8);
> -			if (!ASSERT_GE(prog_fd, 0, "__check_ldimm64_gotox_prog_load"))
> -				return;
> -
> -			err = bpf_prog_test_run_opts(prog_fd, &topts);
> -			if (!ASSERT_OK(err, "test_run_opts err")) {
> -				close(prog_fd);
> -				return;
> -			}
> -
> -			if (!ASSERT_EQ(topts.retval, off1 + off2, "test_run_opts retval")) {
> -				close(prog_fd);
> -				return;
> -			}
> -
> -			close(prog_fd);
> -		}
> -	}
> -
> -	/* reject off1 + off2 >= 6 */
> -	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 3, 8 * 3);
> -	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 7, 8 * 0);
> -	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 0, 8 * 7);
> -
> -	/* reject (off1 + off2) % 8 != 0 */
> -	reject_offsets(insns, ARRAY_SIZE(insns), 3, 3);
> -	reject_offsets(insns, ARRAY_SIZE(insns), 7, 0);
> -	reject_offsets(insns, ARRAY_SIZE(insns), 0, 7);
> +	int off1, off2, off3;
> +
> +	/* allow all combinations off1 + off2 + off3 < 6 */
> +	for (off1 = 0; off1 < 6; off1++)
> +		for (off2 = 0; off1 + off2 < 6; off2++)
> +			for (off3 = 0; off1 + off2 + off3 < 6; off3++)
> +				allow_offsets(insns, ARRAY_SIZE(insns),
> +					      off1 * 8, off2 * 8, off3 * 8);
> +
> +	/* allow for some offsets to be negative */
> +	allow_offsets(insns, ARRAY_SIZE(insns), 8 * 3, 0, -(8 * 3));
> +	allow_offsets(insns, ARRAY_SIZE(insns), 8 * 3, -(8 * 3), 0);
> +	allow_offsets(insns, ARRAY_SIZE(insns), 0, 8 * 3, -(8 * 3));
> +	allow_offsets(insns, ARRAY_SIZE(insns), 8 * 4, 0, -(8 * 2));
> +	allow_offsets(insns, ARRAY_SIZE(insns), 8 * 4, -(8 * 2), 0);
> +	allow_offsets(insns, ARRAY_SIZE(insns), 0, 8 * 4, -(8 * 2));
> +
> +	/* disallow negative sums of offsets */
> +	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 3, 0, -(8 * 4));
> +	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 3, -(8 * 4), 0);
> +	reject_offsets(insns, ARRAY_SIZE(insns), 0, 8 * 3, -(8 * 4));
> +
> +	/* disallow the off1 to be negative in any case */
> +	reject_offsets(insns, ARRAY_SIZE(insns), -8 * 1, 0, 0);
> +	reject_offsets(insns, ARRAY_SIZE(insns), -8 * 1, 8 * 1, 0);
> +	reject_offsets(insns, ARRAY_SIZE(insns), -8 * 1, 8 * 1, 8 * 1);
> +
> +	/* reject off1 + off2 + off3 >= 6 */
> +	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 3, 8 * 3, 8 * 0);
> +	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 7, 8 * 0, 8 * 0);
> +	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 0, 8 * 7, 8 * 0);
> +	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 3, 8 * 0, 8 * 3);
> +	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 0, 8 * 3, 8 * 3);
> +
> +	/* reject (off1 + off2) % 8 != 0, off3 % 8 != 0 */
> +	reject_offsets(insns, ARRAY_SIZE(insns), 3, 3, 0);
> +	reject_offsets(insns, ARRAY_SIZE(insns), 7, 0, 0);
> +	reject_offsets(insns, ARRAY_SIZE(insns), 0, 7, 0);
> +	reject_offsets(insns, ARRAY_SIZE(insns), 0, 0, 7);
>   }
>   
>   void test_bpf_gotox(void)


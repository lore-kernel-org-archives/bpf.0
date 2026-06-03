Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFCB3B6BEC
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499859; cv=none; b=DJ0tzvXz7o+ofdpTTpTOgXDl3WilsEqU9XZU1x9T8d5rwQzsAcdcJe6erNx5s/tLkouQEoE6M6rsHHeZVRMB5JJwX4rW7P3ep/EwhCettPe3FsM/U7yQos/hQdrohlWoSEtOm0wu44irCgHxfJ+shWp44l3GcegXfcU79r0P3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499859; c=relaxed/simple;
	bh=yKBQM/dYhJDWNF+XWCSKcsh0LWE/TAYU2zGm7ql6dk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlapEjsoL+N0njIQ+G6KfWaYhY8JjWUQvkI/cbnLE5uUgdi7ulxFmBBydT2fKiai4q/f0VPFFeZe/MBoe3jKu0ojwOzBxNLF0g0fxRcdJ5oHJYCzY8Vv216zebG3PZPcE8ogMGTYd7UU17NwYlOHGxNrEwqH3r6QBdfmQTT0t+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXVwvOeH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXVwvOeH"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ee6d32402so3771747f8f.1
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780499857; x=1781104657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnkH5xFEJ6g6oqedeDPHM9btk1uLc+DnFLjyYvq9sR4=;
        b=PXVwvOeHCVsO8ZIndw/CBezw1mtKNimrhl3s9nxoxqr/czz2Nl116bwsGnoH+wLaTM
         kQMQbyG0fFmwhz5i6NNfKarEQiXRd8x/YqIrT8t9vygU3C80KmED/VRttMn2E1NtV496
         j06JToVoDde3yllo03QPh/9hYUGTVdC/UJ+QYD37x3OiplBtsPKduaTI9m2SHaFhsJrs
         DuUlEAsf2gdlxZZl/yDhqD51aHmCyyb2IoP+CSuDGKBWPn7CWKVZwSlS1pTqNeNOxnXI
         sgTuctBp0ASHD9KBfxOBSUdACFL6bIbwtOcFYjN+XIvW6JfpIW+7POBCSK2ZxXoqE1/j
         r6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499857; x=1781104657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnkH5xFEJ6g6oqedeDPHM9btk1uLc+DnFLjyYvq9sR4=;
        b=LeDp3QqF41L6Iify7tFdvQ8BinQrb1JLj2aKrZ9C8m554FXObxihRMGyQDYvIT+sZf
         ELhRLCdIKTdEUktpvGdeykmck4X6Lb5X50kOzubmhmldjmj6P67B7/UajaEnMTZ4b7PX
         qqVRRPOvs4xCa0WANxrJxYN81MWxgc+GCpzGQCkuSvjN8T4QO+5F9CJw5Hcr+P39eqvv
         h9oTO9DN2cOS9rAjirsDGQ3JXYeb0YIbICVujKcceGy/7NqCuBg/wx6bwlmLrVjMi8A2
         9nWLaw0uSrSK6JOZoWVLSgmSbRNEkSPE2gMe5i18tHXcx+zAyib/4638CzNYX/xP+DFo
         3aoA==
X-Forwarded-Encrypted: i=1; AFNElJ/PS8HrETUbgXsa9eZnuiATRJKehXobeWPyWdWd9dEVcjDc4fC1cRd3w2UF34g5pEPG3xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzN0fr3o5G+linrSVCqxZbL4P1Y9NpdSWHl8yR6RN46WiPH3Yi
	c/Bdi1OTUAmyvYJFcRH9lNrotMM8uFVO/cUSEpaJqZNK1fPS1xfWiNWN
X-Gm-Gg: Acq92OHGcGgtst+uXMaO8+gcnfstOiS1Tb7dl9wHqWkQMi6tzbkM56mYcPVOkrBz4OR
	P4XxceDHCW09kkE5T3hb279YHaybCrEHrXWWGpOwYNVCz6gRGv15+A7BQtWmBmmPFpYBG19kdnt
	2xxTtVqbIBxxQwEeDAwrMTSTXSGH/XjKTDCbvdjak605uz3vyiX4d3Ju67PoUQH4Kp+yBltM1CF
	AXj6/kLg4Hv/KKXXXeHHzu6OrYMDGdp9KCRAEc9pR8wavuw5gKPRds0Tj7G4kPO+qa+yZyUHKq6
	AOH/H/quBhHlthjgijZ88Joi9FHikcj6SSbHWqPp1k7F0YM+5WaAg4LgCfWcmAqwBUl/NBHsA5o
	qv0DnLWGj8t5OpLt7XuJLmU61NBhFFfr+mgV83Y+YhMLPS2eVPWJK1ZZuldKcdW7hEfzECnqgsf
	Q06VmPPAeosDJufxKwNO7XVIilvCrPLNscqqJnKquZW5P7UWIPJTMSKYQszbqVdtXWZJBPrzVXl
	WMQ/NqW+iE39UiyfIeiR2hpqB+0Wy+A
X-Received: by 2002:a5d:5989:0:b0:45e:e44b:313e with SMTP id ffacd0b85a97d-4602181fac2mr5917728f8f.19.1780499856561;
        Wed, 03 Jun 2026 08:17:36 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm8398676f8f.0.2026.06.03.08.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 08:17:36 -0700 (PDT)
Message-ID: <f1f18841-005c-4450-b289-2a052f5f3fb2@gmail.com>
Date: Wed, 3 Jun 2026 16:17:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] bpf: Check tail zero of bpf_prog_info
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Yuyang Huang <yuyanghuang@google.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260603144518.67065-1-leon.hwang@linux.dev>
 <20260603144518.67065-3-leon.hwang@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260603144518.67065-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/26 3:45 PM, Leon Hwang wrote:
> Since there're 4 bytes padding at the end of struct bpf_prog_info, they
> won't be checked by bpf_check_uarg_tail_zero().
> 
> pahole -C bpf_prog_info ./vmlinux
> struct bpf_prog_info {
> 	...
> 	__u32                      attach_btf_obj_id;    /*   220     4 */
> 	__u32                      attach_btf_id;        /*   224     4 */
> 
> 	/* size: 232, cachelines: 4, members: 38 */
> 	/* sum members: 224 */
> 	/* sum bitfield members: 1 bits, bit holes: 1, sum bit holes: 31 bits */
> 	/* padding: 4 */
> 	/* forced alignments: 9 */
> 	/* last cacheline: 40 bytes */
> } __attribute__((__aligned__(8)));
> 
> If a future kernel extension adds a new 4-byte field, older userspace
> programs allocating this structure on the stack might inadvertently pass
> uninitialized stack garbage into the new field, permanently breaking
> backward compatibility. -- sashiko [1]
> 
> Fix it by changing sizeof(info) to
> offsetofend(struct bpf_prog_info, attach_btf_id).
> 
> [1] https://lore.kernel.org/bpf/20260513224823.6494FC19425@smtp.kernel.org/
> 
> Fixes: b79c9fc9551b ("bpf: implement BPF_PROG_QUERY for BPF_LSM_CGROUP")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>  kernel/bpf/syscall.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 1007fb7c87e9..0c86a70d31c1 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5115,10 +5115,11 @@ static int bpf_prog_get_info_by_fd(struct file *file,
>  	u32 info_len = attr->info.info_len;
>  	struct bpf_prog_kstats stats;
>  	char __user *uinsns;
> -	u32 ulen;
> +	u32 ulen, len;
>  	int err;
>  
> -	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
> +	len = offsetofend(struct bpf_prog_info, attach_btf_id);
> +	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), len, info_len);
>  	if (err)
>  		return err;
>  	info_len = min_t(u32, sizeof(info), info_len);


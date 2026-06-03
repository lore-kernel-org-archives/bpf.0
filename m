Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E483AE6E2
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499805; cv=none; b=D5OFMb/McWAP678TKL53E0e0rEY9DQRALpFvbVUxAzuywF6jEdDWpIXE8Ku8hLOEgGc5Kv3ZYr+YV0XPurezTzh+0ERYkIhnha1ECEnCO35BWx1Hi5zP5BqpYRm4a5gXmq+Dx/L42/DWjz7ebFYKLt6rbOHSVXfVK2c8lZqbKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499805; c=relaxed/simple;
	bh=DQ8Y/4v5YdnUPcSKspvljjFWbGO8P2IvzlOPanwUzFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDAySmSB1EdL0Ok1XrUJxJo4CjvlO1/oP5+VK2oJNiuHHamBS7SV+k6onGvv2GKMYOZfy4GVMr2pbYeXnDjKyaBoDIbsfpEY+2qHlekl9NHZ6GT85Eo0MzOXXU3WMvcwaEELyO/m/AjvKts53VXrN6BL0QLNNb4J1pXT7duhlZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXzeewM4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXzeewM4"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so11226365e9.0
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 08:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780499802; x=1781104602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MaF6lWKR8sLzmWJlJ6QvlML1zUSvU9tppAwiknuVLcA=;
        b=mXzeewM4xtOJ/gda+ryVK+ko3W2upiC98RPQcZ1apTCi3Jefj7qsrABiGdy5VvNhbN
         HrHRpIg/r/71ddsJKVJTSyyb4PSfMHNKfwdm4xx/nQvqNfe59cysg7pWB/VZXTzkyGb6
         2fhgEZO0WFgIf0q6+moq0DbXvBRbG4IPlDYX+rTDw5kYlh3PPTXfMC3nZ/v/IlBKyr1i
         KT3efVhrr3qPbvZz7ap2TeVBnyz4RyD9EBqUHRYtDjXIgJ2pC1SP2/TIEx/bkY7KhpHZ
         3IG49jqTC/WPzpU8wXNq/gOUqc6/LxHElMGbpd0J+xQ3Ek3xYOcMr5qsDseeXtKUhoI/
         JN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499802; x=1781104602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaF6lWKR8sLzmWJlJ6QvlML1zUSvU9tppAwiknuVLcA=;
        b=aPnB+zb4GvqsIFadmW4xIRiifoj3yBd+6V4KFoI7XBogRQepvjzkPaS/ZmGT57GkL2
         cHBmT+JuH9ekYsZOgR4yHXfhnEA0KZf/MkrC6OTBc+z+fxYGBYhkNwIHJphDQPOSAPko
         4cgm5jJLND9IHODe/CtlE2rIXj0h66iBExegM4pXDCNJOA3c87sLfRnEoQ61JfIxYHWz
         4l5+a6Wyl6vJDU07Kv2OmF0IIhpUmhXrGChKaftJvCBs05xzeqwWMTCkmUtnuD0Ihzpk
         AXmCvI3Dhem8J4OkLstvE1wipaOb0rXC+uCMJQy93cymcEpcAfzokJ402EtRVN7pCN3O
         +gPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+e173RRCL09NREn/ppVeIpqUt/HX/HVgVWjKHnjm8FbDG/VNav8T62+MGVPIm6ICj3BHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2DDRN+QfhEb7KA/73/nBuTP9BStqYQta6rA+t+HS4GTqAPKod
	orEbRaOq1e/cLhqTARJAhL1WiMG9LLeioOMjvT6oqR/jISjzsQw0U2zy
X-Gm-Gg: Acq92OHt9ZDyBJbj7O4nlqaR2RUtCrO4WHrfWlqP+Fn3j409pazAPOHj0xy8P+Qcntj
	YGxFHyv46hZ1YHym5qCshY7NNNLM5Kn6VvFYnp1Kf6gV+BbGXn93z1FlMJzTJSY3ZVC/dwACC3T
	BVsTZS0sYSufd1+XpYQ6ELx2RQIYCh10jnMlim4Kjw5SxP6M75cFL5VClFbDWEA53djhVgXYewp
	OuLHlTkhZQfioNqN1dFLIEHdVGQRtRo79Uale290XEf08eCJEzqp47VN7SkAe7zNv8gHC1eaLFn
	Tv5bPPGgbyf/6MF3p+FUKwfmLvxycggzYAEP8Z/vcyHvWweA5MISg6/3YBoBxvG9ovVU6jH8tdS
	Cjb5lkrkN8MkA3pW8Ld17O93NBcAhixdwaRpd7zOoc4yC83XIt4WLgCOWatcQn5uyW8L33Bzp77
	IwDjQB3A6pWW6KfFTfhbSyvss4C4YzaGWeo0j4G05bsGKcHhoOjmMZJT0XbIeEDp7yi3q/DoHyz
	6SRTv0gCZwZ7chTi6PLkw==
X-Received: by 2002:a05:600c:8b48:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-490b5ea6ddbmr67495725e9.9.1780499802292;
        Wed, 03 Jun 2026 08:16:42 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344762sm9064550f8f.23.2026.06.03.08.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 08:16:41 -0700 (PDT)
Message-ID: <714fb4cc-2eb2-40be-9202-d82d405d82ae@gmail.com>
Date: Wed, 3 Jun 2026 16:16:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] bpf: Check tail zero of bpf_map_info
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
 <20260603144518.67065-2-leon.hwang@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260603144518.67065-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/3/26 3:45 PM, Leon Hwang wrote:
> Since there're 4 bytes padding at the end of struct bpf_map_info, they
> won't be checked by bpf_check_uarg_tail_zero().
> 
> pahole -C bpf_map_info ./vmlinux
> struct bpf_map_info {
> 	...
> 	__u64                      hash __attribute__((__aligned__(8))); /*    88     8 */
> 	__u32                      hash_size;            /*    96     4 */
> 
> 	/* size: 104, cachelines: 2, members: 18 */
> 	/* padding: 4 */
> 	/* forced alignments: 1 */
> 	/* last cacheline: 40 bytes */
> } __attribute__((__aligned__(8)));
> 
> If a future kernel extension adds a new 4-byte field, older userspace
> programs allocating this structure on the stack might inadvertently pass
> uninitialized stack garbage into the new field, permanently breaking
> backward compatibility. -- sashiko [1]
> 
> Fix it by changing sizeof(info) to
> offsetofend(struct bpf_map_info, hash_size).
> 
> [1] https://lore.kernel.org/bpf/20260513224823.6494FC19425@smtp.kernel.org/
> 
> Fixes: ea2e6467ac36 ("bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>  kernel/bpf/syscall.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 625a4366fe6d..1007fb7c87e9 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5400,10 +5400,11 @@ static int bpf_map_get_info_by_fd(struct file *file,
>  {
>  	struct bpf_map_info __user *uinfo = u64_to_user_ptr(attr->info.info);
>  	struct bpf_map_info info;
> -	u32 info_len = attr->info.info_len;
> +	u32 info_len = attr->info.info_len, len;
>  	int err;
>  
> -	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
> +	len = offsetofend(struct bpf_map_info, hash_size);
> +	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), len, info_len);
>  	if (err)
>  		return err;
>  	info_len = min_t(u32, sizeof(info), info_len);


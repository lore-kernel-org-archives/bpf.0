Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A87175A76
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663215; cv=none; b=arlvGbjhx5A8DCkDDKYbxCrQgBGnGP52R3BMwZ9Gznm9sAh1DeMwWm9DR1peV53lbUHn940iTNYpTCEhvi8+gLmGLOByu2H2qVqakXAYOU3amLXLcEktZSdvioFIGoGG4UzhS91+7FQN1R7XyVRxj/xi8Dpd/AEkmLDE/tjQut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663215; c=relaxed/simple;
	bh=DqKZA9cFq3kyvmRoQnAaZV3z64NTaQkVpKORId8Ls3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HN7p0NP/dXOflJFNYuz/IU/2owsr1h2U+i6+RkdEY+BAwJjRf01rmA7LIsKitNb4JeneXOuzocFsxDSzofVQvAfU/JEbD5z01XZA3wQqtU9Ona0Jphn9iu68oo1CSYg5cNzhG5iTsJc7KqCLKcGhFxBhVSjWVm2CU5/SQ9zVk+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdZQuEnZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdZQuEnZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso36285985e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775663212; x=1776268012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gj2DDxxZcu/buIaWE8IZ/uOpGptPMK8boRBWUu0FENU=;
        b=bdZQuEnZJcRQrPrBsaeSImBKCmS0wyH3UIw8+tlyRYdu3LTA2RS9eSF2KJrhL/9xmm
         rrGCqoheuBvDbL27hQ3tMKKToGieQeHCLdSFKsULbXHmEKDrF7JymHX6vnakZSPSyRrI
         RklIkAI6vrJMaViJDHokMHia6ypc8laa5hKy4gs59Gp1cfb+zU31nBgggJj8C7WjeY54
         WvhjkPkxlb1sYX7QQ4Euos1ZvhvHWcR1ZCdiqNrwPGR1FuvT6D2rL63en6Dz9D/FCtTP
         GrrILv4FfvQ5/WKjd8bAO86DwTHCw+1YV8m+JQXixLny+XOCua7LIE3SkT0YruYPBaMz
         oT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775663212; x=1776268012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gj2DDxxZcu/buIaWE8IZ/uOpGptPMK8boRBWUu0FENU=;
        b=De8ZmxG2mvb+l14xCQYTUvdEZ9ypfqgelNCFQZDHqmV6/qx4j3MdKdK88QHhKX5SYb
         Zg9DvjbGfXEs7uQTBL7kquGQ7vYMjoYX98D2c4CiZ1dkssFy6sWkPDERzzn85jYxWIBx
         A9s0omOm5qrYV8OW/6djNHVeAUwIXvbUWTycso5BTS7uWvfzx4Hq0dxWXQpEukmF5dwO
         teiNBWXeSaBCFwakDJsuhgjdiJptJdJA83upYX900Cddg62oMAtSG0tdmj2qf5n6Hfkx
         knCo+QUJJp1+SiRYsQdPdKo2jCiPbSKyhN2mLp1qTPEPXKWeCRBhUbvhDpFNDgW8JHZJ
         +9hw==
X-Forwarded-Encrypted: i=1; AJvYcCWFi9Tm6VyunZqL8/sdc0VY1sCsoNgaTPqu3brImnw3asUOUG2yCETDCkhNLuW3Z8w6TbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAyUOiEUZ/CVzOoB6gUxvST3jpefuTcdZkG6sr1EeFzOFoyUFn
	0rKj8HjY8fc86+jlFjbeATxYSW3Ycr1seQuFr1rXwtMEA2c0rlFIKQTi
X-Gm-Gg: AeBDieswOGOKSWJkA89XY6qaTgrSsisWdNfhMjunt4odr9xKd4LoGuOzLWmnd39+kkK
	CjU8SfR2ol0OhXeq8yV854fYcI5eaIzARjyUqQdu11hdqOamVoZeNM9yA+npwjvpvTaNcTz4LvF
	/WNaqmJwSWqb0xOoF8Iwiqmmn7chFz7s6Ckr2Xr/ymPrgDT7RA4seJHjVzN8DyoD0R+JpTMvpS1
	ujiESXmVPLx12+xBGI4+hHzC4p17eP28olr7WPPsVkdhRkQkqFkTN6GN8KtvoqRNkNI3+3oTD1G
	GXrr4DVI/geDkk1l6r7ugsEHoMbZpPFIDv7JQk7r5Cke8qxRKl5rpfdRzQvjHPR75u+Ha5dh0w1
	e2kEZqP9B/YzfpfgDpJ5N0+j9xg3T9F9pV2fakanGYvOqSffiWEyRYfN9w3sKqlo5rDLA/3i6XN
	TtwUCICAxw3S/1lwisHOV9VgMtbISnFY7zHT+ITG3fpuLWzXrEgpT/D8/RHGQRM42ajl2Fkl7cZ
	uGT6qb6kPQ=
X-Received: by 2002:a05:600c:a114:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-488ccfa98b5mr2432705e9.9.1775663212292;
        Wed, 08 Apr 2026 08:46:52 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e1c27sm57094443f8f.26.2026.04.08.08.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 08:46:51 -0700 (PDT)
Message-ID: <02c440cc-6ecc-45d9-97ab-16730a15fc80@gmail.com>
Date: Wed, 8 Apr 2026 16:46:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Make find_linfo widely available
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
References: <20260408021359.3786905-1-memxor@gmail.com>
 <20260408021359.3786905-4-memxor@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260408021359.3786905-4-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/26 3:13 AM, Kumar Kartikeya Dwivedi wrote:
> Move find_linfo() as bpf_find_linfo() into core.c to allow for its use
> in the verifier in subsequent patches.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   include/linux/bpf.h |  1 +
>   kernel/bpf/core.c   | 37 +++++++++++++++++++++++++++++++++++++
>   kernel/bpf/log.c    | 43 +------------------------------------------
>   3 files changed, 39 insertions(+), 42 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d8fb9d61f5ce..0136a108d083 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3945,6 +3945,7 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
>   	return prog->aux->func_idx != 0;
>   }
>   
> +const struct bpf_line_info *bpf_find_linfo(const struct bpf_prog *prog, u32 insn_off);
>   void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
>   			     const char **filep, const char **linep, int *nump);
>   int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ada76f997177..066b86e7233c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3335,6 +3335,43 @@ void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
>   		*nump = BPF_LINE_INFO_LINE_NUM(linfo->line_col);
>   }
>   
> +const struct bpf_line_info *bpf_find_linfo(const struct bpf_prog *prog, u32 insn_off)
> +{
> +	const struct bpf_line_info *linfo;
> +	u32 nr_linfo;
> +	int l, r, m;
> +
> +	nr_linfo = prog->aux->nr_linfo;
> +	if (!nr_linfo || insn_off >= prog->len)
> +		return NULL;
> +
> +	linfo = prog->aux->linfo;
> +	/* Loop invariant: linfo[l].insn_off <= insns_off.
If you are touching these lines, it's worth updating to kernel style 
comments.
other than that the change looks straightforward, just moving a function 
from one place to another + minor change of the arguments and rename.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> +	 * linfo[0].insn_off == 0 which always satisfies above condition.
> +	 * Binary search is searching for rightmost linfo entry that satisfies
> +	 * the above invariant, giving us the desired record that covers given
> +	 * instruction offset.
> +	 */
> +	l = 0;
> +	r = nr_linfo - 1;
> +	while (l < r) {
> +		/* (r - l + 1) / 2 means we break a tie to the right, so if:
> +		 * l=1, r=2, linfo[l].insn_off <= insn_off, linfo[r].insn_off > insn_off,
> +		 * then m=2, we see that linfo[m].insn_off > insn_off, and so
> +		 * r becomes 1 and we exit the loop with correct l==1.
> +		 * If the tie was broken to the left, m=1 would end us up in
> +		 * an endless loop where l and m stay at 1 and r stays at 2.
> +		 */
> +		m = l + (r - l + 1) / 2;
> +		if (linfo[m].insn_off <= insn_off)
> +			l = m;
> +		else
> +			r = m - 1;
> +	}
> +
> +	return &linfo[l];
> +}
> +
>   int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
>   			   const char **linep, int *nump)
>   {
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index c67fbbbd5768..48931d4e5a68 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -327,47 +327,6 @@ __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
>   }
>   EXPORT_SYMBOL_GPL(bpf_log);
>   
> -static const struct bpf_line_info *
> -find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
> -{
> -	const struct bpf_line_info *linfo;
> -	const struct bpf_prog *prog;
> -	u32 nr_linfo;
> -	int l, r, m;
> -
> -	prog = env->prog;
> -	nr_linfo = prog->aux->nr_linfo;
> -
> -	if (!nr_linfo || insn_off >= prog->len)
> -		return NULL;
> -
> -	linfo = prog->aux->linfo;
> -	/* Loop invariant: linfo[l].insn_off <= insns_off.
> -	 * linfo[0].insn_off == 0 which always satisfies above condition.
> -	 * Binary search is searching for rightmost linfo entry that satisfies
> -	 * the above invariant, giving us the desired record that covers given
> -	 * instruction offset.
> -	 */
> -	l = 0;
> -	r = nr_linfo - 1;
> -	while (l < r) {
> -		/* (r - l + 1) / 2 means we break a tie to the right, so if:
> -		 * l=1, r=2, linfo[l].insn_off <= insn_off, linfo[r].insn_off > insn_off,
> -		 * then m=2, we see that linfo[m].insn_off > insn_off, and so
> -		 * r becomes 1 and we exit the loop with correct l==1.
> -		 * If the tie was broken to the left, m=1 would end us up in
> -		 * an endless loop where l and m stay at 1 and r stays at 2.
> -		 */
> -		m = l + (r - l + 1) / 2;
> -		if (linfo[m].insn_off <= insn_off)
> -			l = m;
> -		else
> -			r = m - 1;
> -	}
> -
> -	return &linfo[l];
> -}
> -
>   static const char *ltrim(const char *s)
>   {
>   	while (isspace(*s))
> @@ -388,7 +347,7 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
>   		return;
>   
>   	prev_linfo = env->prev_linfo;
> -	linfo = find_linfo(env, insn_off);
> +	linfo = bpf_find_linfo(env->prog, insn_off);
>   	if (!linfo || linfo == prev_linfo)
>   		return;
>   


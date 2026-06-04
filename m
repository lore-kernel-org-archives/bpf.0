Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E083220D4FC
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598151; cv=none; b=tR4cpErS/Go8kFbDU4yBltXZYAdJPZqotMH/ZdtmYocsIeD7+9/eC3F+dRmIFwNBqYjVBVX4UQ7KHJNAyujvvWR7OO/Zhxyetn4qYFR8vdm5TNrP5wEZPcOoxOgesB4T9K40H1en6OPC/Jix6FHsPJ2C7vL9jMxtaxeNJZpl5Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598151; c=relaxed/simple;
	bh=/U7kAatvLUaFZbWGyJuSf/cnn9Ni+fRUhAa36t9GJYk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIgXRjOdqHtACog0Pq+e5JtEASeglR9f8rU+q9bAaAk1W5SHfn1bVg2NJX2zv7JSvXNBxW1EExDSjqMTvFWxbCMM6I7upcyT2q22kaluoDtD60B2x255s91kXtc30oByWhUJSO31i0zV+UgYZBi9tzw7wNCN/mCPoXLniYbN/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRmL4ZZc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRmL4ZZc"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36da8439078so999983a91.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 11:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780598149; x=1781202949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ5WmztWxvdlE2e4SguX0gd8FplLVEq8r2kQY19EHyM=;
        b=GRmL4ZZcYk3N+FX0121+nUWtJMqU50xww6ESJ3uLSyYrcaJCCOuPm5RP8xlrJJXLFC
         4kJHd1GJb7J/eIObXGuAJRBQHyLJKVTCl7cdeAbtSsGibcYSVmF1QfYQWyRU/HrHCYja
         q9tmPBJ0Y8Znv+Wn0cz3ztj/16rbnbFPAzzO+ZwN8kSmZ36Ho6E9/mPDmqeoFKBhbhXX
         OFk82yskHbyYf0XJ8vO+P8T3EORIrOr9UYggWwBSouTXltcj5fmCOGzJ8QJ0pyqVudAr
         fyVR6Hhg4/5BQndxAICovHguYMDKqSudKZgrgCHrEBum5C4VAASPludwvs5cLc2XZf4C
         E6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780598149; x=1781202949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ5WmztWxvdlE2e4SguX0gd8FplLVEq8r2kQY19EHyM=;
        b=REkgAGS18g2d7y7kcyMtuZ8OnHVi0+vKH3dKUb3m5TB3TFJ5Nw/wPUF3EPVW3LAU/w
         rI2FteVi0BVJfrLEOK2NuLzUFB9pzakqnMFIdvCT3aY+gND5v8F81WXKPDo69geJvr90
         83TbwmcfW+RHQv2VoVUp+Nmv/q1+mW5aQL0j/1kLnMDSNh2vQK4pvpOdQp5z9Kh126Sa
         hv9XozJuEFy2acR6XZ3JFwjMXbGoA6MS+Se39vMee3QtHatgPE2sGlTINo+VQNNZHWLF
         VQhdBygDmQllWeNi0xQbNm7WjkPMD/AlZXR5cSO87XQ2aIlC07vT40Yrno6Fj1y0SOCA
         D5yw==
X-Forwarded-Encrypted: i=1; AFNElJ8um6QMoLJXA9nDjPRj3fmv0uJjK0uZgpygA3owFiy6QIYHR4g3wjdbI+EQ59WbL5rNHv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCDvtHxk/Gk5t6rO6NSiRiznClk/JD198zWZ4k4PCuccbTXsZ4
	cOYy6NZn/gSLuHe2KdnCRMGlj5vKnY4dL2uz4XXB1J37NaFkV1gfYs6Y
X-Gm-Gg: Acq92OFy4IHDT3wM9uReqPPW5vjVnEDBqGdIsqo2qZX0nTnQe0QkQUxyt1dEusAhajB
	lgxH6aq6YP0UkPlhqWIJZtVT+S1QgJZUtY0JEUskFF9qCY6ghDHIDeC/XHLGVdGjTa5Qoh02i7j
	zf+K66y6oP/0jPZCruw1CHIUX8PmLFYZgCTOBDM/HYrU1U+bPJ50fSOXYikhCSB62AyvqTZNO8S
	3+FC90OE2BWsWCe3TWKj6LaG8uiWx+PJftLTStx7gZIAOgqRWJuoevOSo8yUaibKtC0fWpIEU2z
	4RpZZhjnafqYjufAL2jMzSjsbfWbSwMXlRhzyTkNKr3aOI4zrv3m/xAaSWHzKLlgvcScKvrKWYX
	THhjf6XT1utSictlS2uR27LrtiIgvWrSPi6kqZOzulim/aWHZbwnxOcM9EfTE5Te+d6nRadU9BG
	wmzmnMmjiPTFk+Y1jitHoog6yz7lpZyYIg3M1r/8Ojig==
X-Received: by 2002:a17:90b:3503:b0:36d:635b:85a0 with SMTP id 98e67ed59e1d1-370ee830376mr195838a91.3.1780598149272;
        Thu, 04 Jun 2026 11:35:49 -0700 (PDT)
Received: from archlinux ([205.254.163.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf830b2sm3554824a91.4.2026.06.04.11.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:35:48 -0700 (PDT)
From: Suchit Karunakaran <magneto712003@gmail.com>
X-Google-Original-From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Fri, 5 Jun 2026 00:05:40 +0530
To: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, dxu@dxuuu.xyz,
	stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Keep dynamic inner array lookups nullable
Message-ID: <aiHFbuC-nCAf-QLh@archlinux>
References: <20260604151153.2488051-1-gnq25@mails.tsinghua.edu.cn>
 <20260604151153.2488051-2-gnq25@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604151153.2488051-2-gnq25@mails.tsinghua.edu.cn>

On Thu, Jun 04, 2026 at 11:11:52PM +0800, Nuiqi Gui wrote:
> An ARRAY_OF_MAPS can use an array created with BPF_F_INNER_MAP as its
> inner map template. A concrete inner array with a different max_entries
> value can then replace the template.
> 
> After a successful outer map lookup, the verifier represents the
> resulting map pointer using the inner map template. Const-key lookup
> nullness elision consequently uses the template max_entries even though
> the runtime helper uses the concrete inner map max_entries.
> 
> Do not elide lookup result nullness for maps marked with BPF_F_INNER_MAP,
> because the template max_entries does not prove that the key is in bounds
> for the concrete runtime map.
> 
> Fixes: d2102f2f5d75 ("bpf: verifier: Support eliding map lookup nullness")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4d..bffe12d0bb289 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8471,7 +8471,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> -static bool can_elide_value_nullness(enum bpf_map_type type);
> +static bool can_elide_value_nullness(const struct bpf_map *map);
>  
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			  struct bpf_call_arg_meta *meta,
> @@ -8621,7 +8621,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
>  		if (err)
>  			return err;
> -		if (can_elide_value_nullness(meta->map.ptr->map_type)) {
> +		if (can_elide_value_nullness(meta->map.ptr)) {
>  			err = get_constant_map_key(env, reg, key_size, &meta->const_map_key);
>  			if (err < 0) {
>  				meta->const_map_key = -1;
> @@ -10225,9 +10225,12 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
>   * lookup return value nullness check. This is possible if the key
>   * is statically known.
>   */
> -static bool can_elide_value_nullness(enum bpf_map_type type)
> +static bool can_elide_value_nullness(const struct bpf_map *map)
>  {
> -	switch (type) {
> +	if (map->map_flags & BPF_F_INNER_MAP)
> +		return false;

One small nit: the can_elide_value_nullness() function comment appears
to be out of sync with the updated parameter.
Resending because somehow my mutt config got messed up with my other email address.

Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3C3E0251
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844358; cv=none; b=LEmBZhSshyLUV76jVsQJt+SNMq1jPAglw8RecUzZS0WVtX3QSYp9VeEbzjXuRqh97J7shxYyvK5bf32QKH9vM4Nq4vJR278rKMYBaoUeAF0HxvMhpbxqHrMzpNVu1Vkl1UGJsaoA/CqSIEWf4/x1itIHf2rugI96ndEOMfx+0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844358; c=relaxed/simple;
	bh=sM1wz5EArOoQdUNowIBU8vl6ByIPfqhEp+Lh4HvpLMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tD2NPT++8FR9iyJKJsfqYcAgSpL128EPI3SZ0pmC60Jp9FpOn4nFDFrFVZ9nW0WrcQvG008Qd131LbZQkN/6DLfwiGKq70dwxG1Qg3i/vLX8kpiUHRqqA8prj+5WBbmjae5cnCbrLYw8h5Q8ggKzIxxu0vQJX4bgQiG6zx079M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjShgunx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjShgunx"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso849343f8f.0
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844353; x=1783449153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jwGaSJfvXwwi2gmvOZ6+HNHrcdSzXT1GIfb82HOsI6I=;
        b=FjShgunx0rnygnd8vY1QHIr8hMlq22Qo8pyuDUlGBGaExZJ+TMQROApZw641UlX+v5
         PWIIt9mlUeuxnbX9Q/QanKZtSL2Slv/nz0awTKbtO2e4o6aZ6v8dOfbkdwaBI/gKrBAo
         PGwhhQJMKh3AqywpFinQAye/yk7G13Ue61W7HUoyLe03jfyIMMnQGBiZSwAMjVRwXIem
         /URS/z/Khmb5o8/vEgCZGULAyMInXwqZDJS7FsKAEkur2aMhAzu4H3xDfeGed/35VUs/
         qdFL+7jLGVzmDO+xlnYlLNkiNebBPoSizpKq8L7ybFFq4VE92hzsKI4/Sy7YCGRs6hd9
         2Pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844353; x=1783449153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwGaSJfvXwwi2gmvOZ6+HNHrcdSzXT1GIfb82HOsI6I=;
        b=olNBTcjyqNg3x8IpYyOA/0Zc5HzJ0SK+Ejyt8eV3fORYZ7fz0B8nOaS+wu4l8E4dKP
         UKKun+wrWPdZHILn2Hm2thTd/a/xAxQZayLd7oza8uzHK9llkfpdo8j3oFY5vHE/6umH
         DM0pqabUcXT+96O1xDbVo7P8TWhr/Bf9JiQphfZBZRJLGSP5R0/GNFHOQCRYVmZvlOdA
         kH9aM6GD98VUSyjuNRIPPgsIyxUnI9+nx2u0V74Fmd9suIkicY5bzwNG3R/LwO5vUfFF
         9OlpLg3EJHybbJKFfsFUdA7Or/laZ4Z/KTqRrb0E0sT8pmzYMxOR8aKkzqK0dcBYnw3q
         V+bA==
X-Gm-Message-State: AOJu0YywMAw7DLX5V3i7tVtpOMplH/mP1Wixwko8t/5ddJOHy52LVXNr
	AyhgZ/XbA+dvi7I30NeHVPD/MJxYIKU6Qq9KKBFcFYlue9JQymRZ6WTWeAfxtQ==
X-Gm-Gg: AfdE7cmWMEan8M2O4KK1HDZ06wAcXa89fma2mct6bqSSf5xU+B9SC5TRzEmEDwBZFyX
	sBQl40cqw3lHe0n5Kl51YDc2eFTblI71FXDzZXxT0bwInOxh3ukcMKkMx8RTTwahonfx4tLysis
	IRoKHTRjezRvl5/ERvAN5Pebla3IyhzRuzCoBJVTomgWzVmoBBuwXG0FDmFmfnrSsAuhueqpW7i
	zOtlphatPybJhZjJXdH1/2Z6+w/QDItBVr9qDpjcihCdp9UjJTd4gBF4dxG0USLil89YXRimsnh
	FPvRhDsGycdgndEZDW9rcLCP/alWazgekmmN8KZPU8I1SQwkdMsiOjZnMMTMbrMlTqYSnzvRfcR
	6w+Dmdo7Dj+XTo6VIUgE+w2t3io1Q05Di4x3L1YT+6DqtQF6JPDKKRSomtmAKs3fMlMb3vGjjaA
	S0zfJHUzxgVPy5DcXrP8Ddpk7yUyIW1tV1
X-Received: by 2002:a05:6000:61e:b0:475:f0c2:75a3 with SMTP id ffacd0b85a97d-4765ac65bb6mr2639928f8f.52.1782844353412;
        Tue, 30 Jun 2026 11:32:33 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567884770sm10323552f8f.33.2026.06.30.11.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:32:32 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:42:35 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Enforce gotox targets against
 subprog bounds
Message-ID: <akQOG9jAypDZCjHV@mail.gmail.com>
References: <20260628-f01-03-gotox-bpf-next-v3-0-b744432e1361@mails.tsinghua.edu.cn>
 <20260628-f01-03-gotox-bpf-next-v3-1-b744432e1361@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-f01-03-gotox-bpf-next-v3-1-b744432e1361@mails.tsinghua.edu.cn>

On 26/06/28 09:59PM, Nuoqi Gui wrote:
> During CFG construction, the verifier records the modeled gotox target set
> in insn_aux_data->jt. Later, check_indirect_jump() follows targets from
> the runtime PTR_TO_INSN register's actual INSN_ARRAY map.
> 
> This lets one gotox instruction observe different INSN_ARRAY maps on
> different paths and accept a target outside the calling subprog. The
> observed x86 JIT case can then enter another subprog without a matching
> BPF call frame and crash when executed.
> 
> Reject every target copied from the actual PTR_TO_INSN map if it is
> outside the calling subprog.
> 
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index eb46a81a8c51..05a996a5ecdd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17145,9 +17145,11 @@ static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
>  static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  {
>  	struct bpf_verifier_state *other_branch;
> +	struct bpf_subprog_info *subprog;
>  	struct bpf_reg_state *dst_reg;
>  	struct bpf_map *map;
>  	u32 min_index, max_index;
> +	int subprog_start, subprog_end;
>  	int err = 0;
>  	int n;
>  	int i;
> @@ -17188,6 +17190,23 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
>  		return -EINVAL;
>  	}
>  
> +	subprog = bpf_find_containing_subprog(env, env->insn_idx);
> +	if (verifier_bug_if(!subprog, env,
> +			    "gotox insn %d is outside subprog bounds\n",
> +			    env->insn_idx))

Can this actually happen?

> +		return -EFAULT;
> +	subprog_start = subprog->start;
> +	subprog_end = (subprog + 1)->start;
> +
> +	for (i = 0; i < n; i++) {
> +		u32 target = env->gotox_tmp_buf->items[i];
> +
> +		if (target < subprog_start || target >= subprog_end) {
> +			verbose(env, "gotox target %u outside subprog\n", target);

In the previous patch there was more info printed (at least, subprog
boundaries looked ok, not 100% sure about map id).

> +			return -EINVAL;
> +		}
> +	}
> +
>  	for (i = 0; i < n - 1; i++) {
>  		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
>  		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
> 
> -- 
> 2.34.1
> 

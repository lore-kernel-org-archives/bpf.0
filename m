Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B57EEBB
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269138; cv=none; b=Atmm22VIS6ATini64m6BfFzgWGBzylsxU78WwvG1Q1P+qWdlbioWmH4peCqzsV1YG454tWWZDHcvxeFeXR7AcuoCsj9eSEy6e58s7ewYMgkF82UktVCtU0GEbREBrPmgt9FylFNnC3KsRu9sx7V1kfiiDzKeG4YqYL8vnAomoRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269138; c=relaxed/simple;
	bh=PNbbiOaNcGHl2UMfM/KFHObdewCXhiz9WDMujIAl5F8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z30CGFz1ucEtpNJXZJgXKdNC7tR4NWf6UPrcxi33Gv+VZIYvXLjasLAE+XJOEOx+tYGvDQ8SbTH/uA6gHc8BRxW11r+TMsphX+K9QwNsATqxbLZjdT4eK3bxuV5+EQp0+xDqWeeUSF41l5tez3otBAbjCbTe2p0gN/AOdznukCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvLK79v7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvLK79v7"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so2948275e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773269134; x=1773873934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/Qc5twxAvR18BnVKuzO1KzLsNKi8PlkxaLqVdwZBnc=;
        b=KvLK79v7nQ6HCHRXIRDj/ncDbRTsG+KYgWveitetxuZI3KSgqDH4kK0v4gpuDXH4kw
         zyb5B9u2NSEq0c59UMRR2Rv30IyEEd/sQMa1Sop0+sFMzZCEiicqwJCxjKwO94AXCTpY
         1oByGxb1z8zVAujQc0aamFAw4Sgqev878EeZl5gacRvF/YwY577L74V7mTUenbzZ/LE3
         oh8mp/KJ7kfUpXxAuXadCuW08Evv0HBlHNwTERepFDr6HzFfuxiioIY05WB9iY9t1qYA
         r7gXm/xLwxnyLFcPzD7q7v+DKlZhlin3xjNdzQOGnzZHZi+t5C8IVIz1GsC8p1TGryUo
         rB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773269134; x=1773873934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/Qc5twxAvR18BnVKuzO1KzLsNKi8PlkxaLqVdwZBnc=;
        b=HrIzuocxNn8UyzEptfGr6JVyeTUo2qA+sOY4MwNrrnvVIoV6Ed/XuD+yyyYy9ldY28
         zAFTLt12lxYxjaPAXdD7vDAzpyfK8z19vnjkuK1EaSId49wk6R0AEU2ZKkzO8o1AadDE
         RTGWy7GBmAthYAE58OwX/rm5IsacxtZRvpq2j1D9tAbczkm65vxBlCHYcJwQvEc2zz4C
         iyyf3tIZHiYcS5ZXp7NMX55ZmiFg2GFM6ojvM6Q9xZIqZ4WSJIoQGbG2L0d+b7CQYYSd
         sm53sY5JZzXkjIogf5YaJm47Z7LZegNeq66fTmTRhqXhdfdiTE4McAacFhJ7c+RgylhF
         DD5w==
X-Gm-Message-State: AOJu0Yw6VI3GEME5tGaKhWUYFY4TiETLTFxFmTcZtnc0Xv0ilZVLRHqc
	JDzfJ+rVKTdwMVldXhI+yz47Jo0u+OorpBm1QfhLM7eP2iW4Z1ifcpVh
X-Gm-Gg: ATEYQzwGejcBRXpwOHG3u5oIwX7nTbcWX+zmscYLmMteOodO+q373KQ6FKU6vpaREX4
	k5lyzWhEa6t8IEF2svWC159kajcnYWk+5yWCYb8SILvxL+0YoEpVPmyPG00OSIXVbv9dps1ZUsF
	9HeXgdfsBZvrJuzeuTNhbpFvQt9SO3YFuiI4968joWS0yHwUbhF63vyuJGKKeEl1CCvjtsfH5QA
	T5YygblLyl+WHLv03lEsB0TX4mvAywSdSWj+VNhxYST0P2i72BFOVxpy8PvAbR7KMeOBygIGrXV
	XyOPIZ/J6K0RTTV2BZtO7zYGsJkXnuuPqzDUNEK8QUNHSPOqe7BpnJHUOr/KM/T5mVPRTBujGoj
	Z9TJdr2EA+3ZtdZjxQe19cvMqCrDShRrihICZ4zWPBsTBRDLViFxHf//BwStNMaCRkNyPjplQA0
	o4f8Ob2gbyHsU=
X-Received: by 2002:a05:600c:3593:b0:485:2fc5:39f with SMTP id 5b1f17b1804b1-4854b10d130mr72491895e9.29.1773269133678;
        Wed, 11 Mar 2026 15:45:33 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0c3878sm28827415e9.16.2026.03.11.15.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 15:45:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 11 Mar 2026 23:45:30 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
Message-ID: <abHwii5stH93Vz5E@krava>
References: <20260303150639.85007-1-leon.hwang@linux.dev>
 <20260303150639.85007-4-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303150639.85007-4-leon.hwang@linux.dev>

On Tue, Mar 03, 2026 at 11:06:36PM +0800, Leon Hwang wrote:
> Uprobe programs that modify regs require different runtime assumptions
> than those that do not. Mixing !kprobe_write_ctx progs with
> kprobe_write_ctx progs via tail calls could break these assumptions.
> 
> To address this, reject the combination of !kprobe_write_ctx progs with
> kprobe_write_ctx progs in bpf_map_owner_matches(), which prevents the
> tail callee from modifying regs unexpectedly.

hi,
could you please give some example where this is actual problem?
I'd expect it's up to user (whoever installs the tailcall map) to
avoid such situations.

thanks,
jirka


> 
> Also reject kprobe_write_ctx mismatches during initialization to
> prevent bypassing the above restriction.
> 
> Without this check, the above restriction can be bypassed as follows.
> 
> struct {
> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> 	__uint(max_entries, 1);
> 	__uint(key_size, 4);
> 	__uint(value_size, 4);
> } jmp_table SEC(".maps");
> 
> SEC("?kprobe")
> int prog_a(struct pt_regs *regs)
> {
> 	regs->ax = 0;
> 	bpf_tail_call_static(regs, &jmp_table, 0);
> 	return 0;
> }
> 
> SEC("?kprobe")
> int prog_b(struct pt_regs *regs)
> {
> 	bpf_tail_call_static(regs, &jmp_table, 0);
> 	return 0;
> }
> 
> The jmp_table is shared between prog_a and prog_b.
> 
> * Load prog_a.
>   At this point, owner->kprobe_write_ctx=true.
> * Load prog_b.
>   At this point, prog_b passes the compatibility check.
> * Add prog_a to jmp_table.
> * Attach prog_b to a kernel function.
> 
> When the kernel function runs, prog_a will unexpectedly modify regs.
> 
> Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h |  7 ++++---
>  kernel/bpf/core.c   | 30 +++++++++++++++++++++++++-----
>  2 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 05b34a6355b0..dbafed52b2ba 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -285,9 +285,10 @@ struct bpf_list_node_kern {
>   */
>  struct bpf_map_owner {
>  	enum bpf_prog_type type;
> -	bool jited;
> -	bool xdp_has_frags;
> -	bool sleepable;
> +	u32 jited:1;
> +	u32 xdp_has_frags:1;
> +	u32 sleepable:1;
> +	u32 kprobe_write_ctx:1;
>  	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
>  	const struct btf_type *attach_func_proto;
>  	enum bpf_attach_type expected_attach_type;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index b24a613d99f2..121a697d4da5 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2390,6 +2390,7 @@ static void bpf_map_owner_init(struct bpf_map_owner *owner, const struct bpf_pro
>  	owner->jited = fp->jited;
>  	owner->xdp_has_frags = aux->xdp_has_frags;
>  	owner->sleepable = fp->sleepable;
> +	owner->kprobe_write_ctx = aux->kprobe_write_ctx;
>  	owner->expected_attach_type = fp->expected_attach_type;
>  	owner->attach_func_proto = aux->attach_func_proto;
>  	for_each_cgroup_storage_type(i)
> @@ -2397,8 +2398,14 @@ static void bpf_map_owner_init(struct bpf_map_owner *owner, const struct bpf_pro
>  			aux->cgroup_storage[i]->cookie : 0;
>  }
>  
> +enum bpf_map_owner_match_type {
> +	BPF_MAP_OWNER_MATCH_FOR_INIT,
> +	BPF_MAP_OWNER_MATCH_FOR_UPDATE,
> +};
> +
>  static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_prog *fp,
> -				  enum bpf_prog_type prog_type)
> +				  enum bpf_prog_type prog_type,
> +				  enum bpf_map_owner_match_type match)
>  {
>  	struct bpf_map_owner *owner = map->owner;
>  	struct bpf_prog_aux *aux = fp->aux;
> @@ -2411,6 +2418,18 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_pr
>  	    owner->sleepable != fp->sleepable)
>  		return false;
>  
> +	switch (match) {
> +	case BPF_MAP_OWNER_MATCH_FOR_INIT:
> +		if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
> +			return false;
> +		break;
> +
> +	case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
> +		if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx)
> +			return false;
> +		break;
> +	}
> +
>  	if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
>  	    owner->expected_attach_type != fp->expected_attach_type)
>  		return false;
> @@ -2436,7 +2455,8 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_pr
>  }
>  
>  static bool __bpf_prog_map_compatible(struct bpf_map *map,
> -				      const struct bpf_prog *fp)
> +				      const struct bpf_prog *fp,
> +				      enum bpf_map_owner_match_type match)
>  {
>  	enum bpf_prog_type prog_type = resolve_prog_type(fp);
>  	bool ret = false;
> @@ -2453,7 +2473,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
>  		bpf_map_owner_init(map->owner, fp, prog_type);
>  		ret = true;
>  	} else {
> -		ret = bpf_map_owner_matches(map, fp, prog_type);
> +		ret = bpf_map_owner_matches(map, fp, prog_type, match);
>  	}
>  err:
>  	spin_unlock(&map->owner_lock);
> @@ -2470,7 +2490,7 @@ bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog *fp)
>  	if (bpf_prog_is_dev_bound(fp->aux))
>  		return false;
>  
> -	return __bpf_prog_map_compatible(map, fp);
> +	return __bpf_prog_map_compatible(map, fp, BPF_MAP_OWNER_MATCH_FOR_UPDATE);
>  }
>  
>  static int bpf_check_tail_call(const struct bpf_prog *fp)
> @@ -2485,7 +2505,7 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
>  		if (!map_type_contains_progs(map))
>  			continue;
>  
> -		if (!__bpf_prog_map_compatible(map, fp)) {
> +		if (!__bpf_prog_map_compatible(map, fp, BPF_MAP_OWNER_MATCH_FOR_INIT)) {
>  			ret = -EINVAL;
>  			goto out;
>  		}
> -- 
> 2.52.0
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C70B400DE8;
	Thu, 17 Sep 2026 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679775; cv=none; b=dk/wanf5OHvhA35+lgGIGoLQcNrxz8eChIUenAR6zjKlzaJXmVJP4trlc3/WkP0COIFV+H+yEjOU2kU3sCpWXLn84yHxFzWV2xNuhGIR4SgLc90CN3lz+gT8D5Vv35Bcc1Zh5y2Aar9ST0kZMvxt4OEoz78hLmREwTyfn1cYQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679775; c=relaxed/simple;
	bh=hpFcFaJzqru2JXdgMfr1/g1V1NYDhtgHkXHKQpXWWm8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YAif2Z0FDNrdf7u5HUpe/Eg3q549l2Qe4D7tQRLTTuqjmjyqPXUt42neSbEyX4dUgGWg8yGk8fdK1JRGDVUpT6NlXf7XqzWcks4XCGPGc8b3WRHhDpG5nAeoMk7CFs4xecMsP97m5O24I2UZ8YIfTSoy7XT2fMTF1aWOCpnLeho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiD+1OtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiD+1OtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A4F1F000FF;
	Thu, 17 Sep 2026 21:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679772;
	bh=WC+7rsLj4fYl82XgvSqRMlxe1PP22x0bb+mbKZXjHWU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TiD+1OtQwYm+pRvtFLKAZDZ2XqmG+V8V+/VhGroahRs79TPotpVSnqcIKZDcEQswC
	 U3UPR59XD7P4PKcrc59c3XUnASe4hx8pxBhsI6aqVut2ZWOIK8KPzIGIfxOF0CMJD4
	 thd+ovNN70h41IDRUf9RklmkHjcMbPj5N+lrXLvhh0Qy8OWW+RD0TB216DrAvy/E15
	 WjCfmBvPuOdo+oIsS096zB/X+RePaSffCYWL15m/8vXB8erDTUXCvP0cy0CRztjkGL
	 CxQCrGZFrITUTMsT/BsbV98pPOTk+zpEVyUDwOVZMvLgi8Irdn9Lj3NpN5Wkp0rdxG
	 XLHGnsiuGE6kA==
Content-Type: multipart/mixed; boundary="===============3478063305945732436=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <86dea9c47b45beb40c970a6365549f6013993d7b4b4b26c92ee7c4ecedf21dbc@mail.kernel.org>
In-Reply-To: <20260917200542.3689605-4-ameryhung@gmail.com>
References: <20260917200542.3689605-4-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 03/15] bpf: Add bpf_struct_ops accessor helpers
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,shakeel.butt@linux.dev,roman.gushchin@linux.dev,kuniyu@google.com,kerneljasonxing@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 21:16:11 +0000 (UTC)

--===============3478063305945732436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1198404885c86..90ab467d25a27 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2290,6 +2290,11 @@ u32 bpf_struct_ops_id(const void *kdata);
>  int bpf_struct_ops_for_each_prog(const void *kdata,
>  				 int (*cb)(struct bpf_prog *prog, void *data),
>  				 void *data);
> +void *bpf_struct_ops_map_kdata(struct bpf_map *map);
> +void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map);
> +bool bpf_struct_ops_valid_to_reg(struct bpf_map *map);
> +int bpf_struct_ops_link_update_check(struct bpf_map *new_map, struct bpf_map *old_map,
> +				     struct bpf_map *expected_old_map);
>
>  #ifdef CONFIG_NET
>  /* Define it here to avoid the use of forward declaration */
> @@ -2354,6 +2359,28 @@ static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struc
>  static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc)
>  {
>  }
> +static inline u32 bpf_struct_ops_id(void *kdata)
                                          ^^^^

Does this stub match the real prototype? The declaration at line 2290 above
has:

  u32 bpf_struct_ops_id(const void *kdata);

and the definition in kernel/bpf/bpf_struct_ops.c also carries the const
qualifier. The four other stubs added in this hunk (bpf_struct_ops_map_kdata,
bpf_struct_ops_map_cfi_stubs, bpf_struct_ops_valid_to_reg,
bpf_struct_ops_link_update_check) match their prototypes exactly.

When CONFIG_BPF_JIT is disabled, a caller passing const void * would see a
-Wdiscarded-qualifiers warning (an error under CONFIG_WERROR).

> +{
> +	return 0;
> +}
> +static inline void *bpf_struct_ops_map_kdata(struct bpf_map *map)
> +{
> +	return NULL;
> +}
> +static inline void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
> +{
> +	return NULL;
> +}
> +static inline bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
> +{
> +	return false;
> +}
> +static inline int bpf_struct_ops_link_update_check(struct bpf_map *new_map,
> +						   struct bpf_map *old_map,
> +						   struct bpf_map *expected_old_map)
> +{
> +	return -EOPNOTSUPP;
> +}
>
>  #endif

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35271288839
--===============3478063305945732436==--

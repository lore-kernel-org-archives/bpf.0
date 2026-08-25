Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85291339393
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695190; cv=none; b=qWwv9o1FVF6vV8kdBFT2Ww2I6q2BNaxqNZEuhlBnis4oG66QCIqR7ZJdXeiUKb1dhJY2K1DRpFCJyKGy8nnzfNQYoBdWv3zVlxEDVQ0+c3FsQMrXWCPXraXHBUrC2d65vYlFMWf7pZwDPkZnfBIzu8kYc5jIg06TMzyZ0FkaWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695190; c=relaxed/simple;
	bh=BDmkGX9BUrxgDGy5LksX+7if9Z2VPnDdxpDhh+Pb4vY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dzFcwewBraHgbjM1WxSGClYpE70fWUNvbMBP0aiBIGeLIJfJnnuzbrQqP3DoS112ar5UkkKQ9dmXw91ewGnRhjt071H5zO+Ta0cHG48AetkMw4XYgSKXQ4O2W9I+lPg8ShHZr9m0znAfcUsfVtOJULYIM2uMvQ3LkRbuVM18+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvtidMAC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvtidMAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB7D1F00A3E;
	Tue, 25 Aug 2026 21:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787695189;
	bh=60Lhk2PAeCFRyF0Vw4urbwH3qnz6XVjlbdZqQO4jC/g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JvtidMACUDbKDIC2q/DuuE0GwQN3FgAueziKYD83vn6a6zRn9ReX77MWFvhUSAXn1
	 O9uM+e+3RMS1JzNhOZSzDP4KWBp32fPGamJiteZF/zn163cINAkMy4PxGjTuMWHkCf
	 FXtF40WfdX08dk/qzFh/qJKvF2UuY1xJG810F2P+wD4J3z8IIwzL00FHo+t5hge1jE
	 nQmNIqYs3qeFMHbUPNWN1X6vVi7ohVH39AOpoc0Zbo2GrB9yavMmgah2tlWQKe6Jqn
	 ix1NwxTBpo8a5lo/IWcCl5ZCopdZ2rj9wLYIXcCBcX7dZVwgVd2eKDg9qp5lUrpikQ
	 /EUyQkgNA88DQ==
Content-Type: multipart/mixed; boundary="===============2116858904616773315=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bf7b20c25763c95f0438bd265d8a3abb1871c527882e6e7f0944be76f88d90f7@mail.kernel.org>
In-Reply-To: <20260825205427.1322594-1-yonghong.song@linux.dev>
References: <20260825205427.1322594-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 03/10] bpf: Add btf_type_is_arena_ptr()
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Aug 2026 21:59:48 +0000 (UTC)

--===============2116858904616773315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add btf_type_is_arena_ptr()
>
> Simplify btf_scan_type_tags() and added a new helper
> btf_type_is_arena_ptr(). No functional change.

This isn't a bug, but could the changelog use the imperative mood
consistently (e.g., "Simplify ... and add ...")?  Also, could it explain
why the helper needs external linkage, such as noting that a later patch
calls it from verifier.c?

> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 89d5a5c4f1171..ddd0f4f32d24b 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -235,6 +235,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
>  				    u32 field_mask, u32 value_size);
>  int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec);
>  bool btf_type_is_void(const struct btf_type *t);
> +bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type *t);
>  s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
>  s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p);
>  struct btf *btf_get_module_btf(const struct module *module);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 47d43eb983a50..280530d25886c 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3523,6 +3523,22 @@ static int btf_type_tag_walk(const struct btf *btf,
>  	return 0;
>  }
>
> +bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type *t)
> +{
> +	if (!btf_type_is_ptr(t))
> +		return false;
> +
> +	for (t = btf_type_by_id(btf, t->type); btf_type_is_modifier(t);
> +	     t = btf_type_by_id(btf, t->type)) {
> +		if (!btf_type_is_type_tag(t) || btf_type_kflag(t))
> +			continue;
> +		if (!strcmp(__btf_name_by_offset(btf, t->name_off), "arena"))
> +			return true;
> +	}
> +
> +	return false;
> +}

This isn't a bug, but since btf_type_tag_walk() sits right above this and
is still used by btf_find_kptr() and friends, could btf_type_is_arena_ptr()
be expressed in terms of it rather than repeating the modifier/type-tag
walk?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405
--===============2116858904616773315==--

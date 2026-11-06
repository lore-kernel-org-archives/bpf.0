Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000933;
	b=ldJWxPawOxmSEoxTm6hJgXiDAhlokGu59bs/pxsRYu3AjX+wsoTKJL6/5qvxToSxeYe2
	 SN5XJYWuR3OsKuvQ+eTLdJ3cjWScPC3t13LyVyqgfPYim9IKsInyKfE34yL9ymwEVcoOb
	 9//di//UDuGBHd4ZiN2VfMaOScQYS94owQ9VKXScANGoClMYhQJVlvibXmp9CQHiaHBB5
	 IAXqYOOYpN559H//Vs1vBgZRoBZuh27pXhbtGKHvLVVcDXybJtEtKK4gvj+gbC7x2uaCf
	 w+l6T2BQJj+RW4D+/GshHG9OX7N/qRBqEQLPY8OM56No8m+RLruaXI6fFXuCoLj3/KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000933;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=YCrphLt+9lCeh1bH3KOey/f2cVCez/Zl2KmCh4eHz/U=;
	b=xtEhumBTuvV154vsQlps+ZkfIQss8imhjUGqwozI95ho4u4/q6U7wuUIMtI8+uosF/77
	 PNo1rQ1HND77X3lq9VVyMmwBkhSXcqJzq02+a4O5B3Cj73A2o41TBJLcmOSs0u2HH0OwL
	 mAvBxxzsscbNsFh+5J2TbfC2niqs8OysjMBD1KRMlAqQBIVJivl6ZoOqud3HzMNLrANSx
	 8ox6IxuhJrYpTbjIhXWqc0hb3+58zr6XpQb1if/ESu7SHfCDmPpj1/zHmaGqJPnnWuWn0
	 R8nLKTidnPxRm9Ro8UqldHkFs/xstCYWui0vz89J2NoucOqmhrkGg4t2hDrgZwuzcrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGbRg0F4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1CC606A32D;
	Fri,  6 Nov 2026 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGbRg0F4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4021F008A3;
	Fri,  6 Nov 2026 21:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794000932;
	bh=YCrphLt+9lCeh1bH3KOey/f2cVCez/Zl2KmCh4eHz/U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YGbRg0F41PUeI6U1VB61IFDc8uQNuFTxVQxpVKhKZyixmwszu4wizS9V51MFROTT3
	 q2vF2V0uis5EtYVc2fuYEfoWap9412nnWnDEpiHHrnfzLC17eZvsKJ3fwF0VI+S/a8
	 9OuhfDuEgAOMg66amf/kzkqGiWoycfLe0l3P0z6y8D8AsIAhZLA8hBt0D+hX3BUKOA
	 9S4Ftmk875Ztf+saOUyQ6x9Ek4TRzC7I+ioyriZGDOFS2Ww02xjS0KzQ3ohQSQSGKF
	 texNKi2k8Y3mgl/8k8hk9jhRK3o4525C92vgMopncLNYq5JC+UFO11XjGCqXh8CUzt
	 iRw2uhJf08I7Q==
Content-Type: multipart/mixed; boundary="===============8578933871088959199=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <148800382a0df555432654e0021a940d6bcd283955b5e1ec88ba885d4f28cfff@mail.kernel.org>
In-Reply-To: <20261106210314.1767267-18-a.s.protopopov@gmail.com>
References: <20261106210314.1767267-18-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v1 bpf-next 18/18] bpftool: List and show fmod_ret targets
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,brauner@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sashal@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 21:35:31 +0000 (UTC)

--===============8578933871088959199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: List and show fmod_ret targets

TL;DR: Nit only: in bpftool fmodret.c collect_targets(), the
TAG_FMODRET_RETVAL lookup may be unneeded, since the only caller's list path
doesn't appear to read ->retval.

> diff --git a/tools/bpf/bpftool/fmodret.c b/tools/bpf/bpftool/fmodret.c
> new file mode 100644
> index 000000000000..0d2714ef861e
> --- /dev/null
> +++ b/tools/bpf/bpftool/fmodret.c

[ ... ]

> +/* Return the fmod_ret targets of BTF, sorted by BTF ID */
> +static int collect_targets(const struct btf *btf, struct fmodret_entry **targets,
> +			   size_t *target_cnt)
> +{

[ ... ]

> +	/* The other tags mark functions which are already targets */
> +	for (id = start_id; cnt && id < nr_types; id++) {
> +		const struct btf_type *t = btf__type_by_id(btf, id);
> +		struct fmodret_entry key = {};
> +
> +		key.btf_id = tag_func(btf, t, TAG_FMODRET_SLEEPABLE);
> +		if (key.btf_id) {
> +			entry = bsearch(&key, entries, cnt, sizeof(*entries), cmp_entry);
> +			if (entry)
> +				entry->sleepable = true;
> +			continue;
> +		}
> +		key.btf_id = tag_func(btf, t, TAG_FMODRET_RETVAL);
> +		if (key.btf_id) {
> +			entry = bsearch(&key, entries, cnt, sizeof(*entries), cmp_entry);
> +			if (entry)
> +				entry->retval = btf__name_by_offset(btf, t->name_off) +
> +						strlen(TAG_FMODRET_RETVAL);
> +		}
> +	}

This isn't a bug, but is the TAG_FMODRET_RETVAL lookup in collect_targets()
needed?

collect_targets() has a single caller, list_btf(), and list_target() does
not seem to read ->retval or ->target from the entries.  It looks like the
second loop would only need to handle the TAG_FMODRET_SLEEPABLE tag.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42294987431
--===============8578933871088959199==--

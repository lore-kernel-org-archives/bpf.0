Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC08535028C;
	Sun,  6 Sep 2026 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788718639; cv=none; b=XUgloSqqDz/Yo4yylr4EgSVSNouyqeKrQRyvVII2eqIAXS93wv1eQOVbNJ7Gj+u0Zwn/yghfF/4vH9ZbuXwuBOTNqWuFZfVU2gYZhW05dSdGFadfJ0PsbnZ5D417SYKL6K9+HthKX1VlzZyLRtHgOuLzxhc2sasReDjKjC00coo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788718639; c=relaxed/simple;
	bh=Sri5cwoa9jXxhPTga+k9z0P194cuRmtGhbEKIvZLHp0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=p0S8g7ZvqGOPjq71VfnT+q9EPs3aC6rkZYxwSJ25+v2HWAvxC9WjMLqKhWVlPEYQROQRa5Z24jxJvJwnErEVzsWLXtfRBGp3icDdAXktjt9eZ4SDuPN6Z3nEmEIVRwwB01wIKR4XLapmtZcOkALLsvrRkgjHjkc5ZZBhrJNo5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwfiVJJQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwfiVJJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD951F00A3A;
	Sun,  6 Sep 2026 18:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788718637;
	bh=uVERsCJGlx+uVFflvPHMDwWoQgR4pFdAHPwLTy/V11w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bwfiVJJQUyAdXxef5pcUF3ZKWexsBOxht0hxBx03uwtzPCFfM2t9fUiTkwEjOAy9K
	 3+pUoDSxy2HqbnvU/CRn3+3b594YMgDjVXchyBOltST09X3ZElYS/XDkbhGmZNYtVx
	 v67x5Mlj4Vg0+HrBZlQqh6kMHDLtfwK3FMztPKeOuf+MvI5hIjlcawgdV6XmFrSjfQ
	 WbMF360nJOgHuDpdV0LtFdqtGWAd7cV1U8IWBurEhdc21HMXV+xtmEM3g8Y0ZvOLTZ
	 /f9jKMv5Ds9z3LBwus4vuqNL1Az+cpG3nL3XxIBeEy+CX+o40uSo0sRaI5NIHKUsNr
	 yN3itA6XfGufw==
Content-Type: multipart/mixed; boundary="===============4227706866215804155=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d7cd223b492db152abcb27b5541b1c9719b4489d6ed94c59064674843d40cadc@mail.kernel.org>
In-Reply-To: <20260906170819.1212661-2-hi@tychen.cc>
References: <20260906170819.1212661-2-hi@tychen.cc>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Use batch lookups for bounded hash map dumps
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: hi@tychen.cc,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  6 Sep 2026 18:17:16 +0000 (UTC)

--===============4227706866215804155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 684a8fb72414..1eccdc0d1e96 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c

[ ... ]

> @@ -762,10 +757,108 @@ static int dump_map_elem(int fd, void *key, void *value,
>  	} else {
>  		print_entry_plain(map_info, key, value);
>  	}
> +}
> +
> +static int dump_map_elem(int fd, void *key, void *value,
> +			 struct bpf_map_info *map_info, struct btf *btf,
> +			 json_writer_t *btf_wtr)
> +{
> +	if (bpf_map_lookup_elem(fd, key, value)) {
> +		print_entry_error(map_info, key, errno);
> +		return -1;
> +	}
>
> +	print_map_elem(key, value, map_info, btf, btf_wtr);
>  	return 0;
>  }
>
> +#define MAP_DUMP_BATCH_SIZE 256U
> +#define MAP_DUMP_BATCH_MAX_BYTES (4 * 1024 * 1024)
> +
> +/* Return 1 to use individual lookups, but only before batch traversal starts. */
> +static int dump_map_batch(int fd, void *key, void *value,
> +			  struct bpf_map_info *info, struct btf *btf,
> +			  json_writer_t *wtr, unsigned int *num_elems)
> +{
> +	__u32 capacity, count, batch = 0, next_batch = 0, i;
> +	void *keys = NULL, *values = NULL, *buf;
> +	bool first = true, can_fallback = true;
> +	int err;
> +
> +	/* Hash lookup batches must accommodate a whole bucket. Restrict the
> +	 * optimization to maps whose worst-case bucket fits the memory budget,
> +	 * so a later ENOSPC never forces a restart after printing some entries.
> +	 * Division also bounds the allocation multiplications on 32-bit hosts.
> +	 */
> +	if (info->type != BPF_MAP_TYPE_HASH || !info->max_entries ||
> +	    (__u64)info->key_size + info->value_size >
> +	    MAP_DUMP_BATCH_MAX_BYTES / info->max_entries)
> +		return 1;
> +
> +	capacity = min(info->max_entries, MAP_DUMP_BATCH_SIZE);
> +resize:
> +	buf = realloc(keys, (size_t)capacity * info->key_size);
> +	if (!buf) {
> +		err = ENOMEM;
> +		goto error;
> +	}
> +	keys = buf;
> +	buf = realloc(values, (size_t)capacity * info->value_size);
> +	if (!buf) {
> +		err = ENOMEM;
> +		goto error;
> +	}
> +	values = buf;
> +
> +	while (true) {
> +		count = capacity;
> +		err = bpf_map_lookup_batch(fd, first ? NULL : &batch,
> +					   &next_batch, keys, values, &count, NULL);
> +		err = err ? errno : 0;
> +		/* Older kernels reject the command before updating count. Do not
> +		 * inspect the buffers on these errors, or fall back after progress.
> +		 */
> +		if (can_fallback && (err == EINVAL || err == EOPNOTSUPP ||
> +				     err == 524 /* ENOTSUPP */)) {
> +			err = 1;
> +			goto out;
> +		}
> +		can_fallback = false;
> +		if (err == ENOSPC) {
> +			if (capacity == info->max_entries)
> +				goto error;
> +			capacity += min(capacity, info->max_entries - capacity);
> +			/* Preserve the input cursor: the oversized bucket was not read. */
> +			goto resize;
> +		}
> +		/* In particular, EFAULT can leave count and the buffers invalid. */
> +		if (err && err != ENOENT)
> +			goto error;
> +		for (i = 0; i < count; i++) {
> +			/* Keep the alignment provided by individual lookups, including
> +			 * for BTF types whose map key/value size is not aligned.
> +			 */
> +			memcpy(key, keys + (size_t)i * info->key_size, info->key_size);
> +			memcpy(value, values + (size_t)i * info->value_size, info->value_size);
> +			print_map_elem(key, value, info, btf, wtr);
> +			(*num_elems)++;
> +		}
> +		if (err == ENOENT) {
> +			err = 0;
> +			goto out;
> +		}
> +		first = false;
> +		batch = next_batch;
> +	}
> +error:
> +	p_err("can't lookup map batch: %s", strerror(err));
> +	err = -1;

Could this p_err() call produce malformed JSON output when json_output is
set?

Looking at the call chain from do_dump():

do_dump()
  assigns wtr = json_wtr when json_output is set
  calls map_dump()
    opens the elements array with jsonw_start_array(wtr)
    calls dump_map_batch()
      can reach p_err() here while the array is still open
    closes the array at end_dump: with jsonw_end_array(wtr)

When p_err() runs with json_output set, it emits:

tools/bpf/bpftool/common.c:p_err() {
    if (json_output) {
        jsonw_start_object(json_wtr);
        jsonw_name(json_wtr, "error");
        jsonw_vprintf_enquote(json_wtr, fmt, ap);
        jsonw_end_object(json_wtr);
    }
}

So the error object would be inserted as a member of the elements array,
giving consumers an object with no .key or .value fields mixed in with
normal element objects.

This differs from the existing in-array error handling. The pre-existing
print_entry_error() deliberately emits a well-formed element:

{"key": [...], "value": {"error": "..."}}

And p_info() returns early when json_output is set, which is why the
existing REUSEPORT_SOCKARRAY warning inside the array is safe.

Would it be better to emit the error after jsonw_end_array() to keep the
array schema homogeneous, or to use the print_entry_error() format with
a key?

> +out:
> +	free(keys);
> +	free(values);
> +	return err;
> +}

[ ... ]

> @@ -869,6 +962,9 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  		p_info("Warning: cannot read values from %s map with value_size != 8",
>  		       map_type_str);
>  	}
> +	err = dump_map_batch(fd, key, value, info, btf, wtr, &num_elems);
> +	if (err != 1)
> +		goto end_dump;
>  	while (true) {
>  		err = bpf_map_get_next_key(fd, prev_key, key);
>  		if (err) {
> @@ -881,6 +977,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  		prev_key = key;
>  	}
>
> +end_dump:
>  	if (wtr) {
>  		jsonw_end_array(wtr);	/* elements */
>  		if (show_header)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34048943300
--===============4227706866215804155==--

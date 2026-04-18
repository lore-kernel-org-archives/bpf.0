Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC312628D;
	Sat, 18 Apr 2026 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776492653; cv=none; b=fQSiyAa0J4Qq5XxNxs6UUYgYLyifmTyaiOzRWgaudJlphwt9hFSSMKQfh5ijArLZpI5W44tuxiPzfFhG4MzX8hIeXml4Maxaxg9HZZAjC/sJOJphtiF+VBzYpMgkiSBOIdVVPJ/dBCQkmUJlO7AbQCEoHLek+gIujm6gijTrzMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776492653; c=relaxed/simple;
	bh=T0NAVgaZfmlosP1lgTIPzI8WMDLYTQY5dvpu5UP0VrA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KN16Vs3o39a7+VwTKIaWboFpJWmwyahp+8aebjfrwmZl607CKvtl7Awqy7Y+hIBzvKUjVk84hNvGmjVWUmZP0u9BEgurfKY9DP4XLaWcbGO8R6XqQNO9EiU21cMFE2LxGXR7jv0pEbQbYIpH1OxeWvPAR5O7ysuZo8pGFRKeOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+UNvyAh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+UNvyAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDA3C2BCB0;
	Sat, 18 Apr 2026 06:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776492652;
	bh=T0NAVgaZfmlosP1lgTIPzI8WMDLYTQY5dvpu5UP0VrA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=l+UNvyAhgVpoOmGO/zeWVc2gi0393TRzcZ5KIZ2g8qcLNa8Sru3clIY7hSFA+mTdh
	 8uxYAx6Ww7Tdmt7QsE72W6GU86FPNJWxxDB1pjggwJQdGkMYGmiTN9MXj70jd084Gd
	 F84Vm3ThSLYmWZpR3+GlhxHq6aXN9zPnToT8cyLdd1rLrAk8sof/r+Hd94tS2dwA+A
	 uzqp7KNXAgcHb2LxbVjIxkQAi+N8tSDctpod1CD5G0y5RAQfyk55JWt+u0Ya8Ip7P1
	 OPp45prwbh4Ql+rHTx9iQVTSE2F1UeWJeDobiejGcOm4JOZipi8LeSPHYbrJjz5ZE4
	 HgXAY543shUTQ==
Content-Type: multipart/mixed; boundary="===============2303882744649735726=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <14d32b2f6aacddfce59d73dc5e1c0ea423f84e373ca130f6830c3e26154e70b3@mail.kernel.org>
In-Reply-To: <20260417192502.194548-3-jolsa@kernel.org>
References: <20260417192502.194548-3-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 02/28] ftrace: Add ftrace_hash_remove function
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 06:10:52 +0000 (UTC)

--===============2303882744649735726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -416,6 +416,7 @@ void free_ftrace_hash(struct ftrace_hash *hash);
>  struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
>  						       unsigned long ip, unsigned long direct);
>  unsigned long ftrace_hash_count(struct ftrace_hash *hash);
> +void ftrace_hash_remove(struct ftrace_hash *hash);
>
>  /* The hash used to know what functions callbacks trace */
>  struct ftrace_ops_hash {
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1249,6 +1249,25 @@ remove_hash_entry(struct ftrace_hash *hash,
>  	hash->count--;
>  }
>
> +void ftrace_hash_remove(struct ftrace_hash *hash)
> +{
> +	struct hlist_head *hhd;
> +	struct hlist_node *tn;
> +	struct ftrace_func_entry *entry;
> +	int size = 1 << hash->size_bits;
                          ^^^^^^^^^^^^^^^^

Can this dereference a NULL pointer? The code computes the size using
hash->size_bits before checking if hash is NULL:

    int size = 1 << hash->size_bits;
    ...
    if (!hash || !hash->count)
        return;

If a caller passes NULL, the function will crash on the size computation.

Looking at how this is used in the later commit e77bc5ff90dd
('bpf: Add bpf_trampoline_multi_attach/detach functions'),
init_tracing_multi_data() in kernel/bpf/trampoline.c allocates three hashes:

    data->reg    = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
    data->unreg  = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
    data->modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
    if (!data->reg || !data->unreg || !data->modify) {
        clear_tracing_multi_data(data);
        return -ENOMEM;
    }

On allocation failure, clear_tracing_multi_data() calls
remove_tracing_multi_data(), which calls ftrace_hash_remove() on data->reg,
data->unreg, and data->modify. Any of these might be NULL if the
corresponding alloc_ftrace_hash() failed.

Would it be safer to move the size calculation below the NULL check?

> +	int i;
> +
> +	if (!hash || !hash->count)
> +		return;
> +
> +	for (i = 0; i < size; i++) {
> +		hhd = &hash->buckets[i];
> +		hlist_for_each_entry_safe(entry, tn, hhd, hlist)
> +			remove_hash_entry(hash, entry);
> +	}
> +	FTRACE_WARN_ON(hash->count);
> +}
> +
>  static void ftrace_hash_clear(struct ftrace_hash *hash)
>  {
>  	struct hlist_head *hhd;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24598000047
--===============2303882744649735726==--

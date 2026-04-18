Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9BE33DEE1;
	Sat, 18 Apr 2026 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776492654; cv=none; b=p9OgOHYJdhSKYe5KSdS7X/78vXenETDejR9De12W6iel/wRArptI+72fSjjyJYg1CmimXwzdzHo3vYUjRLNiuW9yG2syMzmJf3eHUWDL21wLi7TNlgUkbWDa+A0HOffAUOS25ppApaJXREnln0wMXNPzPgVC8eSQ0Uva1WxyH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776492654; c=relaxed/simple;
	bh=CrWDetpskeoyyujhHGleTEMzdDhf8rUXZa+1XJp4DlQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YZ+LdO+uWB7h5xIBn3W/Ln56YCH42fKZek3Gs4oVvdvXmVqnZFzfWzXZcFMdeHPf6TiowOZPhl8fGACMdesABetB9Nov7CKXzpUajm1vr3ugdrpp7S+XIRz0AW0GjZYkMRAOHGOsSKNlsm54B28O1ZUcJcjgzZ2hPmmPbVD51ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8dtwZIa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8dtwZIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E9AC19424;
	Sat, 18 Apr 2026 06:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776492654;
	bh=CrWDetpskeoyyujhHGleTEMzdDhf8rUXZa+1XJp4DlQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=h8dtwZIan0t3BqLvBv1TGRv6S45ntgGE3P9UOR4ajU/IjB/W2rQfYtnsgVsyc7GE4
	 8gO3kouR6I7umOesuiKYeoxwq8IS1lcsbAVkPQz472+pL+YbOaT94n65phWTMEDrFi
	 64diKh43IpSWWqt4kYGLFWyIsMYqT2YkSvCsf4hYQOCezz5Z1f8TdMcpnkntZ5r67L
	 wdkXJRi9vSFQrQH73e5eZ9aC2K305e++SikCTukOE+1BfJWy1gWFk4Kz+d6oOCZZ0r
	 ijIticSC6Tqg42ZJ7dt69uNDyqA5wgPXrI7yO68wlZ/dnZJb4/8R1MpAyzUqnX4ZC2
	 lV8qtcYMU9vrA==
Content-Type: multipart/mixed; boundary="===============0814596291070270869=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9a7aab4a663704ac2cb85de4387997ba7863b5d55792ae4119194cc2fed3b806@mail.kernel.org>
In-Reply-To: <20260417192502.194548-2-jolsa@kernel.org>
References: <20260417192502.194548-2-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 01/28] ftrace: Add ftrace_hash_count function
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 06:10:54 +0000 (UTC)

--===============0814596291070270869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index c242fe49af4c..401f8dfd05d3 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -415,6 +415,7 @@ struct ftrace_hash *alloc_ftrace_hash(int size_bits);
>  void free_ftrace_hash(struct ftrace_hash *hash);
>  struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
>  						       unsigned long ip, unsigned long direct);
> +unsigned long ftrace_hash_count(struct ftrace_hash *hash);
>
>  /* The hash used to know what functions callbacks trace */
>  struct ftrace_ops_hash {

[ ... ]

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 413310912609..68a071e80f32 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6288,11 +6288,16 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  }
>  EXPORT_SYMBOL_GPL(modify_ftrace_direct);
>
> -static unsigned long hash_count(struct ftrace_hash *hash)
> +static inline unsigned long hash_count(struct ftrace_hash *hash)
>  {
>  	return hash ? hash->count : 0;
>  }
>
> +unsigned long ftrace_hash_count(struct ftrace_hash *hash)
> +{
> +	return hash_count(hash);
> +}
                     ^^^^

Will this cause a linker error on some kernel configurations?

The function ftrace_hash_count() is declared in include/linux/ftrace.h under
CONFIG_DYNAMIC_FTRACE, but this definition appears in kernel/trace/ftrace.c
inside a section guarded by CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS (which
extends from around modify_ftrace_direct() to several hundred lines below).

On architectures where CONFIG_DYNAMIC_FTRACE=y but
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=n, code that calls
ftrace_hash_count() would compile successfully but fail to link since no
definition would be present in the built kernel.

This was raised by sashiko-bot@kernel.org on the v5 review:
https://lore.kernel.org/all/20260418005821.4F156C19425@smtp.kernel.org/

> +
>  /**
>   * hash_add - adds two struct ftrace_hash and returns the result
>   * @a: struct ftrace_hash object


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24598000047
--===============0814596291070270869==--

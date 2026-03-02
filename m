Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5922C175A89;
	Mon,  2 Mar 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467911; cv=none; b=kN0VDM9TEcpwmNmgTih90qIKWjWDHVmRQiq5hapCLkA4kI7AfgX7CZRhTLuSW3bHFSF4wf10RJTJT2hGgLgVqXCyh+Wm+AovXmyS7IWwkbGhn7ySQU6VTQwoE9L2O18UHvuU4tITFQ5SRRPcQmlO2c7GkGJNqVH2LDIXfOnAZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467911; c=relaxed/simple;
	bh=h13JpMWv25w7l7uzyZk9Y6yPZ31nnbx8aPMC70l/rbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pE5lYcK+SlyflludT+RJ9hlf35inJXvOMirxk9L22i7qYUNXb8S3DqE0+KIBDctk0/h1zVWKL1PP9gxhVi2IxCM318OAC9EZL51gOeKtZrac93nkwFdpPclkuuARDAJJoDO0ircF80ZZe0S5yhuyHB15v4zKKaZTikhIvvRuu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcCjVo32; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcCjVo32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00BDC2BC86;
	Mon,  2 Mar 2026 16:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772467911;
	bh=h13JpMWv25w7l7uzyZk9Y6yPZ31nnbx8aPMC70l/rbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WcCjVo32EHR3d2BMVHpoc7ElSrBEREEYwdQPy0nP9mPcys/q45jYtFnksuIH1hVjf
	 zi7dUg4awDPiLFQOHwqf3CLMNA/N84r6NDR4pc9eaPKu9iQcZwfdO197QAaqkcRaTV
	 KfgoaEXH+rG3nlwg5rsJydOTeqMyebkoQoQsR/6MQlXJpAVT1H9slZhAqbJONa3IQC
	 kdJrxblB2WhYKnqTIeD7dAs5q+mUHIymiA2qZQko9/zAeMlL5uk2FXn3RlfmBiulrd
	 UJWirgc8k2/Y9fb0xO/goiteICmrrIS0HSUa4sByQtZFPOjkhTzptKKJd3Jbb+WY05
	 FDZx/6EiwYUAg==
Date: Mon, 2 Mar 2026 11:12:21 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH bpf] ftrace: Add missing ftrace_lock to
 update_ftrace_direct_add/del
Message-ID: <20260302111221.3922e060@gandalf.local.home>
In-Reply-To: <20260302081622.165713-1-jolsa@kernel.org>
References: <20260302081622.165713-1-jolsa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Mar 2026 09:16:22 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> Ihor and Kumar reported splat from ftrace_get_addr_curr [1], which happened
> because of the missing ftrace_lock in update_ftrace_direct_add/del functions
> allowing concurrent access to ftrace internals.
> 
> The ftrace_update_ops function must be guarded by ftrace_lock, adding that.
> 
> Fixes: 05dc5e9c1fe1 ("ftrace: Add update_ftrace_direct_add function")
> Fixes: 8d2c1233f371 ("ftrace: Add update_ftrace_direct_del function")
> Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Closes: https://lore.kernel.org/bpf/1b58ffb2-92ae-433a-ba46-95294d6edea2@linux.dev/
> Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/ftrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 827fb9a0bf0d..8baf61c9be6d 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6404,6 +6404,7 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
>  			new_filter_hash = old_filter_hash;
>  		}
>  	} else {
> +		guard(mutex)(&ftrace_lock);
>  		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
>  		/*
>  		 * new_filter_hash is dup-ed, so we need to release it anyway,
> @@ -6530,6 +6531,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
>  			ops->func_hash->filter_hash = NULL;
>  		}
>  	} else {
> +		guard(mutex)(&ftrace_lock);
>  		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
>  		/*
>  		 * new_filter_hash is dup-ed, so we need to release it anyway,


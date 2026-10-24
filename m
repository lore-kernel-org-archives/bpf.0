Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858433;
	b=FAC9chK0eotIqAUmU4LVdDCnm5vnSGTuLq5dSlBOUYAGMRnQXhK1d/vB1SG4t04ynW/A
	 39EEBAoa/38sxBZypr1KUikAYCy9cGbAcGSuNKttgSKDcGW2JAKXFgzQyGyKxMGgjtWjb
	 W1OxaYmzGlYXqQNm+ydSp/FJw0cDvqTDqYARTHhz5nIj/9RPOL8wfA+dnaqTysEigDEWs
	 ticdeBBst8OAEnko1uxEQUUzFQQex6KYg3y89puXqHXMjve/T5/LYmZBvC7moCc7af3Sf
	 /wRz1S+X0TfKfVqBg6lJ73mBgz9cbTGk/nzm32gHEEpoMji2DAANBTPoG3BZG8nTiWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858433;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Py+Z5I/MajAjJGZNOZOZq0i/a4XelqMNOHlME6I2PwE=;
	b=1yck0dQ04RA9RSoTT17mDfm5UMu8EpUw6ThAEuokSTjCxAEVdyw7fUDUjfRCwh/t9rDl
	 tzrCo00j6IZvP+JzupGho+WGUPoxHNrI2PgFzi9r3Ek+xw9ZyztxRwdVxHc1Eu+Sr2NFI
	 0pVbPo/f7wqVfewx/+NTS/o6vUopfUn7c3ERdIBQW0jOeI6aSUnYD6yEjm0Xx4clap521
	 kSOKT6TdxjBx6MvvQq/sX665pfg98C9LsuM8uAulyJm9A6oOKFo/lmlboO6Do8KVX7EMk
	 2KeYV5i2TPXGXhkZLdOVIjF8UsWyd/pNUTE2q/cz6v0jCqtx89y8VP1wJf6U63wHxEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KCgrczlB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240D606A31B;
	Sat, 24 Oct 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KCgrczlB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571F71F01825;
	Sat, 24 Oct 2026 16:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792858433;
	bh=Py+Z5I/MajAjJGZNOZOZq0i/a4XelqMNOHlME6I2PwE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KCgrczlBlVN3/eYHL022erEAjqNxIylKBS+rv1PIHUkoS9gtD6TGfU8UCr1khuvQK
	 XfnHVDnrKZV4H4uoC8X5lGUvJFbrOta+CwKc62U//3rWHT5vGR1+I49KVEpm6lNzdA
	 s1DrJuAj4fTfFFAQ1NPEp2WpLa1zA7OX8jmIOYybhoi3CurGDEiWwjWwAxRkyldTi0
	 9uWVSkBBFSg9RxAOpllTsvkflpndKWbeXIQfEotQkhxcYod6LCx0agY+MaiBJa7eIn
	 4XLaVFgUfTgeh4S+Wjy6knO/vrCyjAGc3ljYEUtt+lSobTeJf/YviD9T5ZxEJksy+z
	 tRrfirMa0E+KA==
Content-Type: multipart/mixed; boundary="===============8738876045916716804=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5d94730579f232c7be1c83bc7287e91af9a858bcea83765e58bdd2fc3956a229@mail.kernel.org>
In-Reply-To: <20261024153608.58569-5-leon.hwang@linux.dev>
References: <20261024153608.58569-5-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v4 4/6] libbpf: Factor out __sys_bpf_fd helper
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,shuah@kernel.org,kuniyu@google.com,liuhangbin@gmail.com,mkarsten@uwaterloo.ca,masashi.honma@gmail.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 24 Oct 2026 16:13:52 +0000 (UTC)

--===============8738876045916716804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Factor out __sys_bpf_fd helper

TL;DR: Nit only, not a bug: the new libbpf helper __sys_bpf_fd() has a
misleading name and a different argument order (cmd not first) than
sys_bpf_fd(); a name like sys_bpf_fd_log() is suggested.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index b49822d212ae..9a2107d4f6d8 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -203,6 +203,30 @@ int bump_rlimit_memlock(void)
>  	return 0;
>  }
>
> +static int __sys_bpf_fd(union bpf_attr *attr, const size_t attr_sz, enum bpf_cmd cmd,
> +			struct bpf_log_opts *log_opts)
> +{
> +	const size_t attr_common_sz = sizeof(struct bpf_common_attr);
> +	struct bpf_common_attr attr_common;
> +	int fd;
> +
> +	if (!OPTS_VALID(log_opts, bpf_log_opts))
> +		return libbpf_err(-EINVAL);
> +
> +	if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {
> +		memset(&attr_common, 0, attr_common_sz);
> +		attr_common.log_buf = ptr_to_u64(OPTS_GET(log_opts, buf, NULL));
> +		attr_common.log_size = OPTS_GET(log_opts, size, 0);
> +		attr_common.log_level = OPTS_GET(log_opts, level, 0);
> +		fd = sys_bpf_ext_fd(cmd, attr, attr_sz, &attr_common, attr_common_sz);
> +		OPTS_SET(log_opts, true_size, attr_common.log_true_size);
> +	} else {
> +		fd = sys_bpf_fd(cmd, attr, attr_sz);
> +		OPTS_SET(log_opts, true_size, 0);
> +	}
> +	return fd;
> +}
> +

[ ... ]

> @@ -248,20 +270,7 @@ int bpf_map_create(enum bpf_map_type map_type,
>  	attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
>
>  	log_opts = OPTS_GET(opts, log_opts, NULL);
> -	if (!OPTS_VALID(log_opts, bpf_log_opts))
> -		return libbpf_err(-EINVAL);
> -
> -	if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {
> -		memset(&attr_common, 0, attr_common_sz);
> -		attr_common.log_buf = ptr_to_u64(OPTS_GET(log_opts, buf, NULL));
> -		attr_common.log_size = OPTS_GET(log_opts, size, 0);
> -		attr_common.log_level = OPTS_GET(log_opts, level, 0);
> -		fd = sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &attr_common, attr_common_sz);
> -		OPTS_SET(log_opts, true_size, attr_common.log_true_size);
> -	} else {
> -		fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> -		OPTS_SET(log_opts, true_size, 0);
> -	}
> +	fd = __sys_bpf_fd(&attr, attr_sz, BPF_MAP_CREATE, log_opts);
>  	return libbpf_err_errno(fd);
>  }

This isn't a bug, but __sys_bpf_fd() is a higher-level wrapper that
dispatches to sys_bpf_fd() or sys_bpf_ext_fd() after validating log_opts and
probing FEAT_BPF_SYSCALL_COMMON_ATTRS, while a leading double underscore
usually marks the lower-level variant of a function.

The helper also takes (attr, attr_sz, cmd, log_opts), whereas sys_bpf(),
sys_bpf_fd(), sys_bpf_ext() and sys_bpf_ext_fd() all take cmd first, so the
new call reads differently from the nearby calls:

    fd = __sys_bpf_fd(&attr, attr_sz, BPF_MAP_CREATE, log_opts);

Would a name that describes what the helper adds (for example something like
sys_bpf_fd_log()), with cmd as the first argument like the other sys_bpf*()
wrappers, read more naturally next to sys_bpf_fd() and sys_bpf_ext_fd()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40108748084
--===============8738876045916716804==--

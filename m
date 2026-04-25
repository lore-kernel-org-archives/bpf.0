Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C754723;
	Sat, 25 Apr 2026 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777076800; cv=none; b=FZpde1ik5B1KKpW+9dxLSk/5AR1OnnEVnWvBTu9OgAORzqHLPY6knTzL3zeMXhSzBcXy+YTQTcbT7yeYVtIeyvhSEiAs/l0wXcDUN8Nsf2lBR+E8J261KZvpDQ4+drszcuip1euphWQx9J7j5U8H1zwYfeBHBjj2exYFDy19Y4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777076800; c=relaxed/simple;
	bh=T0yCUFyad0Iay4ATupQDxxCtSOQ0P0MgRLUHt6Rh4bk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WZMR97uViWuK+UnmjGDdfCjIKpgPTzz/kZtLUVB7TueOl+KNSqd6yvXKakS704/I38dmZm2wrTlWFnLQocLo3WSAQAgoaDBauewm0CqSkdQbcMnG4fvn7j6gqhopHZq+mfS9NGlSz58SgXp7Ct5k5kRQlZvSsnz7ElZePmTa6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFZ+9q6k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFZ+9q6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AD3C19425;
	Sat, 25 Apr 2026 00:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777076800;
	bh=T0yCUFyad0Iay4ATupQDxxCtSOQ0P0MgRLUHt6Rh4bk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TFZ+9q6ku2Jbb4Uiqeu9COQuSbnBjobNC44s1qZIpj8OCga/Tbo8X06WSMIWqynyF
	 zDsVtwp3aIpXX0BZ+o/1zxTlrwgNM/HRrBy1F0by5ngTS+uGD3QPjpbqoVAIvg+x6D
	 RpYhm2GyWSn3WuRn2s7U5PqPaha+asre0SMOKVapLnLbJ8CxI9KMxpjowhYl1A3Rul
	 jNNTpiyUMyUtcB4tb9APAqSuMGhIQs6auNvbOCiDzpVIuwUx1uQ6wcG7Nc8KEx+T2t
	 /DCZPUzxz8sGyBcCzyITSIhb56AZA2AwAvNmV08qvijNok2FDZgBvK+8rBhuSPV9Ip
	 1qO1PWk6+M6vA==
Content-Type: multipart/mixed; boundary="===============5951464050820953645=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <407178e7c68a87a2a660badc2e4e8e8feae7b1767998649cb278ce4bde14371d@mail.kernel.org>
In-Reply-To: <20260424235247.1990272-1-kuniyu@google.com>
References: <20260424235247.1990272-1-kuniyu@google.com>
Subject: Re: [PATCH v1 bpf] bpf: Free reuseport cBPF prog after RCU grace period.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,eulgyukim@snu.ac.kr,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 25 Apr 2026 00:26:40 +0000 (UTC)

--===============5951464050820953645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index bc96c18df4e0..dba4c9340bb7 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1654,15 +1654,24 @@ int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk)
>  	return err;
>  }
>
> -void sk_reuseport_prog_free(struct bpf_prog *prog)
> +static void sk_reuseport_prog_free_rcu(struct rcu_head *rcu)
> +{
> +	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
> +	struct bpf_prog *prog = aux->prog;
> +
> +	bpf_release_orig_filter(prog);
> +	bpf_prog_free(prog);
> +}
> +
> +void sk_reuseport_prog_free(struct bpf_prog *prog, bool wait_rcu)
>  {

The function signature was changed to add a 'bool wait_rcu' parameter, but
the header file declaration in include/linux/filter.h and all three call
sites in net/core/sock_reuseport.c were not updated.

The three call sites are:
- reuseport_attach_prog() calling sk_reuseport_prog_free(old_prog)
- reuseport_free_rcu() calling sk_reuseport_prog_free(...)
- reuseport_detach_prog() calling sk_reuseport_prog_free(old_prog)

Will this compile? It looks like the callers will fail with 'too few
arguments to function sk_reuseport_prog_free'.

>  	if (!prog)
>  		return;
>
> -	if (prog->type == BPF_PROG_TYPE_SK_REUSEPORT)
> -		bpf_prog_put(prog);
> +	if (bpf_prog_was_classic(prog))
> +		call_rcu(&prog->aux->rcu, sk_reuseport_prog_free_rcu);
>  	else
> -		bpf_prog_destroy(prog);
> +		bpf_prog_put(prog);
>  }

The 'wait_rcu' parameter is never used in the function body. The decision
to defer freeing via RCU is based entirely on bpf_prog_was_classic(prog).

What is the purpose of the wait_rcu parameter? The commit message explains
the goal is to defer freeing cBPF programs, but doesn't explain why a
per-call toggle would be needed. With the parameter ignored, callers
cannot control the behavior even if they wanted to.

>
>  static inline int __bpf_try_make_writable(struct sk_buff *skb,

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24917377520
--===============5951464050820953645==--

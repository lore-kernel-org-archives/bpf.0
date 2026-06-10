Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5B29D266;
	Wed, 10 Jun 2026 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109032; cv=none; b=t7rOxq5luNrMCZqoa2iLfsQwEVY0CR4RcdHnpqQ9FfDj7Gwc5RIFsDS139/oXRAdrFac99YGhPY37C1h4sh3/wb0WtUzXiLL3GepBq06XCrAC7NDEA+0mkkXSZVh2KGv2y7cYqtiaHP4DXbmUcxWxEgiveKQ9blKQsTTZ6MYVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109032; c=relaxed/simple;
	bh=SLcGQ4ITzXYS4V2CWdBn6tCOCjjsrO1KlLsuijpZOOE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Rt+f8NLcd1T7WnWl4MweBT8mKL3GMDRNWtRjb2WzBG3voxBbob//wB9Gw0Qw93Ch6sx/sqVxfPUuIWGi7kgBJofCG9whFr99szIQ3dIuDbd0pUeZY0igoG5QGyMlmLoJLcqnW2zHEKSVrBDkMLFgnHrUQBHRPiAFm31lARprHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SshA315+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SshA315+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB45A1F00893;
	Wed, 10 Jun 2026 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781109031;
	bh=PmiNopTKELNVxRRz64d2VMjYn3asLtHGeFlB4yVILP8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SshA315+z0RBRhaZiWpl896ON8J7Cp7Ax1CAx4zvcfga7YpRoeqWysPUBkCVAcn6B
	 z5WSS/LRZSpN92VUTRfmtYxXkvKmyNL5QlXlH5iX92FX3SVsZgiExVUNH7UVfraBN8
	 RkElQ2qI180YX1RrECrgqDuXdQqfvyZeWvFFBKP1EaFJ4ibHLj204OUSJDHzxYZryp
	 jVdF0RhcglQ6PGHwu3zERtIwWNYbvTLA/Wzj3ZNAsUnUiP1jFjU2Z285vScp09o+IM
	 8pEXY/IOwTcuDD4jO0/aXYu0nKX4tirQtzlI3LtIN5gKqFIGJ4HeZhTgIGirtmDpaO
	 xoyKE5nOD/yIw==
Content-Type: multipart/mixed; boundary="===============4751957696987930576=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0131313fafcf415294f02e034ea77cc7c34108e5b9e9f542a4b9c8e60cc9d767@mail.kernel.org>
In-Reply-To: <20260610145059.113412-2-chenyuan_fl@163.com>
References: <20260610145059.113412-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v3 1/2] libbpf: Skip bpf_object__probe_loading() when BPF token is in use
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,chenyuan_fl@163.com
Cc: andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,chenyuan@kylinos.cn,daniel@iogearbox.net,eddyz87@gmail.com,linux-kselftest@vger.kernel.org,shuah@kernel.org,mykyta.yatsenko5@gmail.com,andrii.nakryiko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Jun 2026 16:30:30 +0000 (UTC)

--===============4751957696987930576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf_object__probe_loading() tries to load trivial SOCKET_FILTER and
> TRACEPOINT programs to verify the BPF environment works.  When a
> BPF token is in use with restricted program type permissions, these
> probe loads may fail because the token does not allow the specific
> program types, even though BPF loading is perfectly functional.
> Fix by skipping the probe when a token FD is present: BPF token
> creation itself proves the kernel has a working BPF subsystem.
> Real BPF issues will be caught during actual program and map loading.
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

This describes a bug fix but there is no Fixes: tag.

The probe-loading failure with a restricted BPF token came in when the
token-aware opts were added to bpf_object__probe_loading(), passing the
token FD into the trivial SOCKET_FILTER and TRACEPOINT probe loads:

    LIBBPF_OPTS(bpf_prog_load_opts, opts,
        .token_fd = obj->token_fd,
        .prog_flags = obj->token_fd ? BPF_F_TOKEN_FD : 0,
    );

which is the code this patch removes.  Should this include:

  Fixes: 6b434b61b4d9 ("libbpf: Wire up BPF token support at BPF object level")

In the earlier resend thread, Mykyta Yatsenko asked for a Fixes: tag to
be added:

  https://lore.kernel.org/bpf/2ec75142-04b6-4d03-9aad-7441b6350f2b@gmail.com/

  > Please resend your patch applying these: ... add fixes tag ...

That request does not appear to be reflected in this version, which still
carries no Fixes: tag.

The same thread also asked to include any Acked-bys.  Mykyta Yatsenko gave
an Acked-by on v2:

  https://lore.kernel.org/bpf/e23baad8-1709-4210-81c8-22741b9dfb3e@gmail.com/

  > This change makes sense ...
  > Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

Should this be carried forward as:

  Acked-by: Mykyta Yatsenko <yatsenko@meta.com>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27285576775
--===============4751957696987930576==--

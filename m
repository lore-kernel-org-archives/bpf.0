Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795666310;
	b=n+raWWunH1MqPyhB9SIrF+qiU+Wp3/r+n+jtl0Yzph9cYu0EwHQePOd+CGD8d5yyxikV
	 z0Z/4znYYhM3ib8VSsOLlGdN9Whgg5mn6h40DRpQraFt2dYm5ecNHllCfS1yqvr/3u0Fy
	 2l2a0tccOhht1UvuqumG/yqRDOki2f1YSXAqy/p+1Dfx/EnPOESQJ/giQ5EjU6HLT2/6u
	 PPImyNs74GKFQ5G7ceSV3MjBhScpsoOpj87oIrgxPRIu5CdYDxDNrAany3Dqq+EL/eW9M
	 Ju+Egcuj1d8TcDsoz0BdpcsRR1Zsc3OZBcg2dZt2I8yuUsSIoNHIpdRuT0uRkTq4QJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795666310;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=mqaXVF806bEBFiclKihsKv3GDGzjnKBVxKwRoY3HDMo=;
	b=272ExEoqMI716juscj//n32fhzvGwBf8zBGMqQu2Z5u4FGlTz5DC2yoR2QoZgQdZp6Zh
	 ilb2nTEd+4e0Fu+911wa80+kGft7m2OlK0KCQX44DSt/L9xJvMtcoRBOnVVEiHxiBNHpB
	 7nzAWag5ST9NQcgp86O+wuf98D0RVQOJPvQrFA0TjZnSt5Qz+zuXEWt599P7FsRpJN7YV
	 CCazh6CoVdOKSyMLSXplb/vrjq5f/EmbCWsaPzxzryITscrpuMZKHeIw48KbhStDF2tCM
	 1MwV5Hq8Z4Q7Db5kqglJT0ub2hbuCDwSCIhjBz3v8pIBXo/mX5g90Pk9zSVG7663WBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZZ1+Eag;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65BB606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 04:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZZ1+Eag
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6C41F000C4;
	Thu, 26 Nov 2026 04:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795666309;
	bh=mqaXVF806bEBFiclKihsKv3GDGzjnKBVxKwRoY3HDMo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JZZ1+EagPEPaKRyIErv5N9b131ft/UTaSNNGgHrNHMtr6B1oluneb5D2a9gUjz96g
	 qcbCNHB9ms3bWAAHRL9k/mRDOsxjKL0QiTMM2J5PhW2H4Vawmr/nZ+9bvQvg+D0Jyb
	 uwPy+9T+WMP7zfrX5eiKzeBvAX75sL3CTZlJxfwT/g/fl7HcALyBHxxcY/8LU7KxVM
	 OQQD8dzWAj11wJWzBNhlQ/wG6ZN5PJvTn+H85CFJwsP1379FiiOwc2yNUSDogzZgTH
	 Bvqj3yL+0YzfWpNr7XXrmgJMDkYIbFS757v6mkfSHodILxhXDsf2Qkn+JAIvsWg8Fq
	 K8rFdcNAvW1tg==
Content-Type: multipart/mixed; boundary="===============0234463303323365805=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ed60f423a7c104167720813c852cc837c289cf555e0abe8a5ec512cf0e3dfee8@mail.kernel.org>
In-Reply-To: <20261126033114.4111944-1-alexei.starovoitov@gmail.com>
References: <20261126033114.4111944-1-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf] bpf: Set the run context for async callbacks
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 26 Nov 2026 04:11:48 +0000 (UTC)

--===============0234463303323365805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Set the run context for async callbacks

TL;DR: Nit only: the new comment on bpf_async_run_ctx says current is not the
arming task, but task_work or a short timer can run in the arming task.
Suggests rewording.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> @@ -3440,6 +3440,14 @@ static inline bool has_current_bpf_ctx(void)
>  	return !!current->bpf_ctx;
>  }
>  
> +/* An async callback runs in no hook, and current is not the task that has armed it */
> +extern struct bpf_run_ctx bpf_async_run_ctx;

This isn't a bug, but is this comment accurate?

bpf_task_work_schedule_signal() and bpf_task_work_schedule_resume() accept
any trusted task, including the one returned by bpf_get_current_task_btf(),
and the task_work selftests do exactly that:

    task = bpf_get_current_task_btf();
    bpf_task_work_schedule_resume(task, ...);

In that case bpf_task_work_callback() runs the callback through
bpf_run_async_cb() in the same task that armed it.  A bpf_timer with a
short expiry can also have its softirq run on irq exit while the arming
task is current.

The commit message says the callback runs "in a task that the program has
picked", which matches this.  Would "current need not be the task that has
armed it" be a more accurate wording for the comment?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45750674148
--===============0234463303323365805==--

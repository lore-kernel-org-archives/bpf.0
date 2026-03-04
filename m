Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040B35E95E;
	Wed,  4 Mar 2026 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665347; cv=none; b=FhYzO4s4GBT9zxQq3aYUNpgL/mxHM45A2vplSxS5oKeRIEYsc0T7yp8ouEvQs422hlRaOl3eEXV5cvDrEQBIlR75j5OWD2fdofIbDbGiKLnc1PR49sHwbArgBJLQ1FtWBsUJOQGwF0yqm2W86Dj4Q/kXsLOFHZVyu27NocrtDcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665347; c=relaxed/simple;
	bh=N+qBZZr1qaYrZP5lLqkYzF8fzqHGz2kc/d1dvx4tpuk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hktxdSsGQeI8oSC3NmBf11ao8t0zSZR3OEabJaqAtI6halzOMY1GQrrgf34uy4bI2ozXoKnlxepefkAZtSV8IHwrsxBFrfweOeM5VPPAzW/Oa7UuZNId7Serx3MvQpyCCsPcqbAt4xgphqJzW32yDJ2JVeAO+9fC5dfZMOVBbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyzpxZ9A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyzpxZ9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA067C4CEF7;
	Wed,  4 Mar 2026 23:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772665347;
	bh=N+qBZZr1qaYrZP5lLqkYzF8fzqHGz2kc/d1dvx4tpuk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=HyzpxZ9APGUWMTxgxluefc9yFXwvo6YTxB6kfzdehOFEh1aNaz+IgckcIhR2Yfyqp
	 KQ/m7dJPzEfFm15XBr1P3k+j45me+faY36j6LjpxxjPNxwTWG33m/mNPaEw7nWVtFL
	 3LfnEVoSexkG9hcRyPQ549rjkFE4Q4pntraabh4vhtRfqFTJdpZkYa4bsggocS6bhn
	 5dG99orhgAcjB8cCQXihmRoeWHPtVUVaS43Qk9uC2CVCLrcOTW0tTZPYRWJKh4/y5J
	 VSRX82Ad6DeZ4Yg8Sjk2KYAzTBKTdbqcxKNMSW48/1pSeW6a2zHvVyUSqO0LuV6f/2
	 Ull8A9iAKl8jA==
Content-Type: multipart/mixed; boundary="===============5229869988091298520=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <77554f42f56834088eca284c1a787f51e4402907c616f8194942c82530a9ce6b@mail.kernel.org>
In-Reply-To: <20260304222141.497203-13-jolsa@kernel.org>
References: <20260304222141.497203-13-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 12/23] bpf: Add support for tracing_multi link fdinfo
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 23:02:26 +0000 (UTC)

--===============5229869988091298520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> +	seq_printf(seq, "%18s %10s %s\n", "cookie", "BTF-id", "func");
> +	for (int i = 0; i < tr_link->nodes_cnt; i++) {
> +		struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
> +		u32 btf_id;
> +
> +		bpf_trampoline_unpack_key(mnode->trampoline->key, NULL, &btf_id);
> +		seq_printf(seq, "%18llx %10u %pS\n",
> +			   has_cookies ? tr_link->cookies[i] : 0,
> +			   btf_id, (void *) mnode->trampoline->ip);
                          ^^^^

Should this be %18llu instead of %18llx?  Every other BPF link fdinfo
displays cookies as decimal:

bpf_kprobe_multi_show_fdinfo():
    seq_printf(seq, "%llu\t %pS\n",
               has_cookies ? kmulti_link->cookies[i] : 0, ...);

bpf_uprobe_multi_show_fdinfo():
    seq_printf(seq, "%llu\t %#llx\t %#lx\n",
               umulti_link->uprobes[i].cookie, ...);

bpf_tracing_link_show_fdinfo():
    seq_printf(seq, ... "cookie:\t%llu\n", ...);

With %llx, a cookie value like 255 would print as "ff" here but "255"
in every other BPF link fdinfo.  The hex output also lacks a 0x prefix,
making it ambiguous whether values like "10" are decimal or hex.

> +	}
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22692622038
--===============5229869988091298520==--

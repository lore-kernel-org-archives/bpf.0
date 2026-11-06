Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939928;
	b=kkrSAbE7yRlYHX9WevL9tgDVe6zaIfV2lyu2nwA55839BIWyJdXb7+rKMuC6smVb9oAD
	 WRAOv1G3+EWRk9BL2+M/wGKWPT5fR8lkK8zfGxNK2xip0qkbN8SjV4SM/Wny4T6M44Ia+
	 3RwFQRfE2mMdXYyGQqJu4h6PkbaIDNhiyyGttYIEZYRBS8XlUUdDtPMsF6eTiwJO25v1Q
	 MH5xkfd3xb/96HpumnGMy7paeCWWTpd7ANdZ5jh8AzxW2yiUBATh40kIcBBBs5k51qlPY
	 G+ck/xCXnIIM+sRRu1c2tXXx7sdqqKtbU1+hA9ENjEy3q8OddPGhysGpfOVZ4ftGuWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939928;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=fYrMb2a/FJaZxskYlQ7/sCAnuCRsT3RUzW80Qs42jFk=;
	b=pBEz2vk+2bQvkl/FlcRnVb6JV9MBXtYT8/erlBIedZ6qDPxotZYuFIoY60V6DR0/RJvE
	 O6f+je1YYvfKx8yBptOlssKOM/5k01ShCgKG6oUugPM9xx6lIK7mR338JtnGaePjdlrXN
	 BRngDbm7+n+toPRJPxtaupfrLBxV8/xKae/4aeEddd+M68kQRVPvbYQgD1ZoJxXyx5TV+
	 +MRzVLKHOByD/5qFJtEwGBlDtCLN2DKcUQqnCWGE//A+s8A0PEnsI2VN4600o9HygoVK1
	 +keRk9qKww5bq8OGGhMECdQIM5c1XxCYW4eQz+Bpq2I4peMFwRSbky3T8nJF82+OJqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eGiea4cv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601BA606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eGiea4cv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAF31F0089F;
	Fri,  6 Nov 2026 04:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939927;
	bh=fYrMb2a/FJaZxskYlQ7/sCAnuCRsT3RUzW80Qs42jFk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eGiea4cvISTqKUfWVkb5Eo7S3Op0lbzyuchDHVItLh/0BRusbO0TfmLLQF4nMmliq
	 r4168vN1M0Vgc9B4oK6H7tvX+WYr7UMgKRiFVFGm/OFRhZhkMhd5j67HTrPg9dXErM
	 3KNKPFaKyLTs7Bod5TSQbgbdXQS4ybN0InVi8wNTnoB1PszfCLhz8kPhjdzRkj9ixN
	 hnsxV1tpAAyv6X9oqeJaM2QSToau4gM2PwuoVfAPTk3yJgn4xS7fsoBzRgHTmndvq1
	 VrJsLD3/VjdDLjcajlnt+UhmuyeYc676XKgBaz6nn6TeK/4zMwwSNYQCFq0VK6qy5W
	 5IRy/eaE9OinQ==
Content-Type: multipart/mixed; boundary="===============2786048737656449612=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <296829c85c2d9abb43246b67b546a749b5ab817515ce21ecdaa15d1a5ef9a44a@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-2-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-2-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 01/45] bpf: Add may_goto to the loops that the verifier marks
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:38:47 +0000 (UTC)

--===============2786048737656449612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add may_goto to the loops that the verifier marks

TL;DR: Nits only in bpf_insert_loop_guards(): the scratch patch array could
live on the stack instead of kvcalloc, and the to == -2 case writes patch[jmp]
twice. No bugs reported.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> +	patch = kvcalloc(8, sizeof(*patch), GFP_KERNEL_ACCOUNT);
> +	if (!target || !zero || !patch) {
> +		err = -ENOMEM;
> +		goto out;
> +	}

this isn't a bug, but could patch be a small on-stack array, as
append_budget_exit() does with its struct bpf_insn buf[4]?  It is a fixed
scratch area of at most 6 insns, and the heap allocation adds an -ENOMEM
path.

[ ... ]

> +		if (to == -2)
> +			off = 0;
> +		else if (to > i)
> +			off = to - i + n - jmp - 1;
> +		else
> +			off = to - (i + jmp) - 1;
> +		if (off > S16_MAX || off < S16_MIN) {
> +			verbose(env, "exit of the loop is too far from insn %d for may_goto\n", i);
> +			err = -ERANGE;
> +			break;
> +		}
> +		patch[jmp] = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, off, 0);
> +		if (to == -2)
> +			patch[jmp] = budget_exit_insn(env, bpf_find_containing_subprog(env, i));

this isn't a bug, but in the to == -2 case patch[jmp] is first written as a
may_goto and then overwritten by budget_exit_insn() on the next line.  Could
the exit insn be built directly in that case?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============2786048737656449612==--

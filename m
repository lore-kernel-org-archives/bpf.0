Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386443AEF5D
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785386; cv=none; b=A1eYHpAWZm5UBJ2BU4mDfEFgnXA3rjmjL9TNnA0NBKu7ERUIj5PCorFsxYjLafCbsdlmG3td9Hwy78A58JDXLJGLX/rwQak0os7GR2nmXyWQ3AXrQU2/eDSKgrHzzxYNs8NliEseq/CBBFqYHtTl1sFLnFf1mLDXNMmLJaka7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785386; c=relaxed/simple;
	bh=0CaTlW11DwEhFqNyx+lCNBQy5qnAPNPWPOnVumZ42pU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ks3EujAO62leZ5DUQyi46MaO7P/fqHQdx1edIIFtT35umjSm6bZgcbxRc/k/KmUWNX/oYepJC0nBFW4PrwwpXYEff6Kl2p8w2pcKu0bawpqF8UNNdz3CBxd0EjtrdGLW2Xgf2cqHs51fx8t6K6sO/IAVGvurj5YSt5ugknMO52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmcNj6QD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmcNj6QD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C7BC2BCB0;
	Tue, 21 Apr 2026 15:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776785385;
	bh=0CaTlW11DwEhFqNyx+lCNBQy5qnAPNPWPOnVumZ42pU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ZmcNj6QDF4uNuCXcbLUwVNJVPyXmOttLhetbmboSKdo823Z4XRKbv8LbyJd1krO5/
	 eTljP2do5NcDZn0MR0P2upEAm4YDdByr2wTZ9iCXtnAkVjfDRJVr7hyNCzMMKR2LzP
	 I7BItXjc4vCg2uQ/xOIp2zYg5IewX15gZUqmGN90acth7EfXMEnRb/uGH+fwGlrqbu
	 kIXgPlJLhYP4Qbq1jjUkRUOSy1wmxvPOk3XJQHIdp3N5OCsmBf0BZfH8zXA9YuXKra
	 0wKWOTWFrKNwdCMPfhe0ggS40tO18eWPj8XjeB1zEQSprjg85gLvIy6q7AdKpFZGnK
	 487HNfno6q/cA==
Content-Type: multipart/mixed; boundary="===============2330413668541520795=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7e3963b44fcf235bd898c41fbf188f765bfc03c404aea0d6913fc6dd2a07e832@mail.kernel.org>
In-Reply-To: <20260421144504.823756-3-tangyazhou@zju.edu.cn>
References: <20260421144504.823756-3-tangyazhou@zju.edu.cn>
Subject: Re: [PATCH bpf-next v7 2/3] bpf: Fix s16 truncation for large bpf-to-bpf call offsets
From: bot+bpf-ci@kernel.org
To: tangyazhou@zju.edu.cn,bpf@vger.kernel.org,ast@kernel.org,eddyz87@gmail.com,emil@etsalapatis.com,puranjay@kernel.org,xukuohai@huaweicloud.com
Cc: daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ziye@zju.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Apr 2026 15:29:45 +0000 (UTC)

--===============2330413668541520795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 63044ebe5721..cdccb1b319a6 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2400,9 +2403,7 @@ int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>  	/* Prevent out-of-bounds read to interpreters_args */
>  	if (stack_depth > MAX_BPF_STACK)
>  		return -EINVAL;
> -	insn->off = (s16) insn->imm;
> -	insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
> -		__bpf_call_base_args;
> +	insn->off = (round_up(stack_depth, 32) / 32) - 1;
>  	insn->code = BPF_JMP | BPF_CALL_ARGS;
>  	return 0;
>  }

In the v6 review thread at https://lore.kernel.org/bpf/CAADnVQ+m2pFaPbRi=A+tsROKP2CPPkny_LXUKR3vUgH2+u1jRg@mail.gmail.com/,
Alexei Starovoitov noted that Sashiko flagged a real OOB read issue.

The author acknowledged this concern in a follow-up discussion, stating
that v6 inadvertently turned a pre-existing load-time OOB read into a more
critical run-time OOB read when stack_depth exceeds MAX_BPF_STACK. The
author committed to fixing this in v7 by changing bpf_patch_call_args()
return type to int and adding strict boundary checks for the array access.

However, the current version still lacks a boundary check on the computed
array index before accessing interpreters_args. The code checks if
stack_depth exceeds MAX_BPF_STACK:

    if (stack_depth > MAX_BPF_STACK)
        return -EINVAL;

But does this check guarantee that (round_up(stack_depth, 32) / 32) - 1
stays within the bounds of the interpreters_args array?

Looking at the array access in ___bpf_prog_run():

    BPF_R0 = (interpreters_args[insn->off])(BPF_R1, BPF_R2,
                                            BPF_R3, BPF_R4,
                                            BPF_R5,
                                            insn + insn->imm + 1);

If the computed index exceeds the array size, this would cause a run-time
OOB access. Should there be an explicit check ensuring the index value
is within the valid range of the interpreters_args array, as promised in
the v6 discussion?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24729984210
--===============2330413668541520795==--

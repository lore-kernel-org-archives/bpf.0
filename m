Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA45C2E542C;
	Sat, 11 Apr 2026 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918637; cv=none; b=DiqQ22NxlynpMoQqF7eNNfVEAVjXEnO7gQ6Giw3SVthYXSi1PN749CcG84R5KdSbVLKTtSHOaNtpYKoFCSlPReAM6CpPmiKL723KUt+LsQNL8FISVFoQ4mDPUc/x7Wjs2HZu8cLWSPg8ZemXfHCKZft5BF+j5i5VYyq00rjif2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918637; c=relaxed/simple;
	bh=M/Dd9L2qzIpcUS7ptFv5cCpukybNYsKNd5BWguxECEk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XsA09drPT8aJEiMyyk2VxgF5Hj1d9+VVlf8Gzql9LyZAwjearuXbiX9ZnpZhICmNNr7z/PeLpa5TlTkUZazdWWZqkXdJa8XytXbFZcbsuxb8JUlkgJbkzzmgACUsU4vRS/Kdk4eUfrnQqkCDf4fe8TDqX8oCZ9vTfyPrEF+yraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRZX0ydo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRZX0ydo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52AAC19425;
	Sat, 11 Apr 2026 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775918637;
	bh=M/Dd9L2qzIpcUS7ptFv5cCpukybNYsKNd5BWguxECEk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hRZX0ydodLTH9R6BYjIEK8XsOdnzoNi5oTgYU8qWuNLxrgBIDR1g+4BGewrHNxMst
	 puCgz1EAN4rN6byso+X4SmLml6V9aRSzndagIfsEQrw/OB1rq6wt4hxjwoxfwCadXf
	 cwlkhMbDZ8pmJyVA9ZwGv3hsLfkeZUXcsTcW1jtdIuQUCYOWZJI6QItnGmw1OBJzwj
	 4HYxbCfDXlRYqa1ulcTZ7kRZ1kMCpPjqq9keKahQE2gfHrKwnKy7NYGU6X7uZ6NRwA
	 ANUX4PlmqLTWBbCiiywDbbHQgJsmLnM1Ik7a1yHyzOcNKvkGtnRbOMr1Md7MHsfgwa
	 BEHfnaBoMiCSA==
Content-Type: multipart/mixed; boundary="===============1064452531770258080=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e7535d00be73466e4a09621be0cc898e0ab76422427a17996e4d34712d16fbe3@mail.kernel.org>
In-Reply-To: <20260411133847.1042658-3-xukuohai@huaweicloud.com>
References: <20260411133847.1042658-3-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v13 2/5] bpf: Pass bpf_verifier_env to JIT
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,a.s.protopopov@gmail.com,alexis.lothore@bootlin.com,list+bpf@vahedi.org,linux@armlinux.org.uk,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,davem@davemloft.net,udknight@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 11 Apr 2026 14:43:56 +0000 (UTC)

--===============1064452531770258080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3fa3c74869d0..bd96b3a01b99 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -2553,46 +2530,53 @@ static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
>  	return select_interpreter;
>  }
>
> -static struct bpf_prog *bpf_prog_jit_compile(struct bpf_prog *prog)
> +static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
>  {
>  #ifdef CONFIG_BPF_JIT
>  	struct bpf_prog *orig_prog;
> +	struct bpf_insn_aux_data *orig_insn_aux;
>
>  	if (!bpf_prog_need_blind(prog))
> -		return bpf_int_jit_compile(prog);
> +		return bpf_int_jit_compile(env, prog);
> +
> +	if (env) {
> +		/* If env is not NULL, we are called from the end of bpf_check(), at this
> +		 * point, only insn_aux_data is used after failure, so it should be restored
> +		 * on failure.
> +		 */

This isn't a bug, but this multi-line comment has text on the
opening /* line. The BPF subsystem preferred style places /* on
its own line:

	/*
	 * If env is not NULL, we are called from ...
	 */

> +		orig_insn_aux = bpf_dup_insn_aux_data(env);
> +		if (!orig_insn_aux)
> +			return prog;
> +	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24284268460
--===============1064452531770258080==--

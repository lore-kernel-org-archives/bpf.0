Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADFB33A02B;
	Fri,  6 Mar 2026 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838168; cv=none; b=sIGk645+3HgUKMWI510ORcZRddoOVmN0QEHNkx0UWjOhtX0K5z9SnMpb7ou1xu5pHS+Rdg18ge9z6G4h/1GiREGQs51/e6BACJE1akBjfC98roem+ovuqpGu1oxEgWqIu3gRzx1Ta2JWM7lgFetdZUz/uYMKyPGNOrdc7Xhdygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838168; c=relaxed/simple;
	bh=CPm6T4ngaXYOLjs5YXkxj5Gxxl3TQtrotGCBz2iSPl0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nvDU+cImJNokudjwyd+Mdr9oLs/Hqws+KxB84gxarslTcnpED4KG23SH+7bz61ztVxA3ElZWkxiotCYN/fG3F0EbsaZC2n0+oexbwdrsPTTYF1xJU6C7QhI73rZFBlwqyFKi0jFqjwXCQi8xgMD9m1aQOWLVr0b5t0PrYw1OITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XETr91dq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XETr91dq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D6CC4CEF7;
	Fri,  6 Mar 2026 23:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772838168;
	bh=CPm6T4ngaXYOLjs5YXkxj5Gxxl3TQtrotGCBz2iSPl0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XETr91dqPueusDckBKZsTB6ffl5LmLpXbyvgD/o1pVUldI6H7laXlE3gpv2/wH0GZ
	 99DsHeHormRbbW7aAg3fb+DH4DmgblFueJJJdvclrgCFXKaRa1hR+YZ28W58mOrJ8Q
	 6duam+bKs/o6rmPyFQAX6YE/z5nwFaokFQknmK+Sf10b7wJBPyFC13klr5TsE7TE7F
	 gBn+lnRFO6S4GOLe+HFAePe8zKHMraZEbticMfJM+97Hc+IKDOzsghU8VvXSrBN1WU
	 O3O0gltv95+9pKuehgIN6leVJvQVZ8OrjNqryVqY+ijP3DymDK/JGl1NG1cCw9+Faq
	 L0ORzlS9ieMrg==
Content-Type: multipart/mixed; boundary="===============4119359952923694821=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f4c177fb8f90a85b0b47de382630947ca8ac2d04febc56c7b8698041050355d3@mail.kernel.org>
In-Reply-To: <20260306221330.630971-3-yeoreum.yun@arm.com>
References: <20260306221330.630971-3-yeoreum.yun@arm.com>
Subject: Re: [PATCH 2/3] bpf: introduce bpf_jit_insn_aux_data
From: bot+bpf-ci@kernel.org
To: yeoreum.yun@arm.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,puranjay@kernel.org,xukuohai@huaweicloud.com,catalin.marinas@arm.com,will@kernel.org,richardcochran@gmail.com,a.s.protopopov@gmail.com,yeoreum.yun@arm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  6 Mar 2026 23:02:47 +0000 (UTC)

--===============4119359952923694821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d4a73a34c46b..68152dbe9a24 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -23020,6 +23026,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  	for (i = 0; i < env->subprog_cnt; i++) {
>  		func[i]->aux->used_maps = NULL;
>  		func[i]->aux->used_map_cnt = 0;
> +		func[i]->aux->insn_aux_data = NULL;
> +		kvfree(func[i]->aux->insn_aux_data);
> +		func[i]->aux->insn_aux_data = NULL;
>  	}

Does this leak insn_aux_data for every subprog on the success path?
The pointer is set to NULL before kvfree() is called, so kvfree()
receives NULL and the allocated memory is never freed.

The error path (out_free) has the correct ordering:

>  		if (func[i]->aux->insn_aux_data) {
>  			kvfree(func[i]->aux->insn_aux_data);
>  			func[i]->aux->insn_aux_data = NULL;;
>  		}

It looks like the success path should match:

		kvfree(func[i]->aux->insn_aux_data);
		func[i]->aux->insn_aux_data = NULL;

Neither __bpf_prog_free() nor bpf_prog_free_deferred() free
insn_aux_data, so this would be a permanent leak for every
successfully JITed BPF program with multiple subprogs.

Also, there is a double semicolon on the NULL assignment in the
error path above.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22784798570
--===============4119359952923694821==--

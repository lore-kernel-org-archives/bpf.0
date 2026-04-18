Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CEB2628D;
	Sat, 18 Apr 2026 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776492650; cv=none; b=WZpVdchRZM4oH3jlaxMR8ixY+6ZcawASKGqDj3JHUOpcJS8rqEew0UM6DpEVtTmotNgpCFpnzFmzEMxuG0W4jJPZXCrgJwQbjqQpKmpO4qfyYyjjoXqmjfYGZUNJL2D4Frit/y4O9RWWzA/5FgvHA3jmGx6//VVJcOZLiIoxQ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776492650; c=relaxed/simple;
	bh=NaZZsmLXUd8hYy5rmHRFvFVJMt0j2DAivE8Ef0a0g6E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Y3cor9wv+EIDwZXOg/oCBIUCLkUHHmFziwyp2ghQmi85lXzIwsRHCCkmFumAjwyWoIbrAQ/nNjpOz/q+7Gx5IN+OWYwS+sjYK19//1IDrnRtDhCr3O9ERlvXWufmjWW1EL1slDpb9NjdX2Ir9jxYrvle8WLR6sB6ce4A2SbrD6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNHyQpjc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNHyQpjc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FF3C19424;
	Sat, 18 Apr 2026 06:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776492649;
	bh=NaZZsmLXUd8hYy5rmHRFvFVJMt0j2DAivE8Ef0a0g6E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dNHyQpjc9EhZiLVW/X78zeQCsVMBJ8AawJeDjgtPpvPaNgjSzzTeQNjtQ0jbxdJrX
	 rYA4fpu19eKhjlAXu6XEYyvZ0LAHOjtC67SoZmdKR4HShMyrQs29FkbfHaoy4M040P
	 iyFAsSixO96K81ZrCFldTBXghEEPdX7LD1cGqxCGIyRALZG8rgJ1BxSY2BEldOB+3t
	 GxN7Lr5ceD6auEzk8TBC+pfNNNfpHkUGCrEl1/zPT2s58RK/nGbcEX2QDV9sdiaAaj
	 LuDdc40tjCa+qSicyld2DyhC/Lp/oLN9S273BDmw/qGyqe09TrItLWzHsITUIHqYoU
	 Fpy6Vb4Guy5wA==
Content-Type: multipart/mixed; boundary="===============0886689944044384329=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <040e57105845536dc2bb598fd51ebe9e0f7cc986efe497bef78870424c993579@mail.kernel.org>
In-Reply-To: <20260417192502.194548-22-jolsa@kernel.org>
References: <20260417192502.194548-22-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 21/28] selftests/bpf: Add tracing multi skel/pattern/ids attach tests
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 06:10:49 +0000 (UTC)

--===============0886689944044384329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> new file mode 100644
> index 000000000000..52d3339b430a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> @@ -0,0 +1,256 @@

[ ... ]

> +static __u32 *get_ids(const char * const funcs[], int funcs_cnt, const char *mod)
> +{
> +	struct btf *btf, *vmlinux_btf = NULL;
> +	__u32 nr, type_id, cnt = 0;
> +	void *root = NULL;
> +	__u32 *ids = NULL;
> +	int i, err = 0;
> +
> +	btf = btf__load_vmlinux_btf();
> +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> +		return NULL;
> +
> +	if (mod) {
> +		vmlinux_btf = btf;
> +		btf = btf__load_module_btf(mod, vmlinux_btf);
> +		if (!ASSERT_OK_PTR(btf, "btf__load_module_btf")) {
> +			btf__free(vmlinux_btf);
                        ^^^^

Does this code double-free vmlinux_btf when btf__load_module_btf() fails?

When btf__load_module_btf(mod, vmlinux_btf) fails, the error path at
ASSERT_OK_PTR calls btf__free(vmlinux_btf) and then jumps to the out:
label:

> +			goto out;
> +		}
> +	}

[ ... ]

> +out:
> +	tdestroy(root, tdestroy_free_nop);
> +	btf__free(vmlinux_btf);
        ^^^^

which calls btf__free(vmlinux_btf) again on the same pointer.

Multiple reviewers (bot+bpf-ci@kernel.org and sashiko-bot@kernel.org) raised
this concern in v5. The fix should either set vmlinux_btf=NULL after the
first free or return directly without going to the out label.

Reference: https://lore.kernel.org/bpf/1ab81cf709ce7d536a898695ffad30c15c8a6a7bf48dcb7271239952dd270315@mail.kernel.org/

> +	ids = calloc(funcs_cnt, sizeof(ids[0]));
> +	if (!ids)
> +		goto out;
> +
> +	/*
> +	 * We sort function names by name and search them
> +	 * below for each function.
> +	 */
> +	for (i = 0; i < funcs_cnt; i++) {
> +		if (!tsearch(&funcs[i], &root, compare)) {
> +			ASSERT_FAIL("tsearch failed");
                        ^^^^

When tsearch() fails, should err be set to -1 before the goto?

Currently when tsearch() fails, we jump to out, but err is still 0.
Because err is 0, the cleanup block below won't free ids and will
instead return the partially or fully zero-initialized array:

> +			goto out;
> +		}
> +	}

[ ... ]

> +	if (err) {
> +		free(ids);
> +		ids = NULL;
> +	}

This can lead to incorrect test behavior. The fix should set err=-1
before the goto out statement.

Reference: https://lore.kernel.org/bpf/20260418033438.03847C19424@smtp.kernel.org/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24598000047
--===============0886689944044384329==--

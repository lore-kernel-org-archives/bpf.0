Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890327702D;
	Fri, 17 Apr 2026 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776456622; cv=none; b=ulNzk+gM+I/gulQW5+IcLBzAhuu3s7gQ34lO9D61jEr5xlgdeYgDcnfxGDRhFtYIL89MB/uE44wBqAweGzIvO0huKPgdwL7jK4vGqeh4Eg0rFTbv3LtJhTwop+4zh7RlzfHCONImfjUdUdM7NzX4lRUyrCTawpzaOlzm85FYkdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776456622; c=relaxed/simple;
	bh=kdo7heYvf1YkbsWLuaiSm0Y+GOWS1XwBUXKrUZG9qzI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bDBRoH7KqX4kcdJqRCcUy3m2QluUzuXkChsysC1fYYyGL5Neukyt/k8AnXDYSSkswv+9+JVKM4w7DA6aQSGIFT5vtrGl73q4OLEJQJaMlTyf6/IEfgtXJ6vL+uuf9wkJZhFpJ3kG0m9baCLG0UlhjmUkFBXhCg5lio+cz859m78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0Ako4Ly; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0Ako4Ly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C9CC19425;
	Fri, 17 Apr 2026 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776456622;
	bh=kdo7heYvf1YkbsWLuaiSm0Y+GOWS1XwBUXKrUZG9qzI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Q0Ako4LyCDLkbUKnaVIsuz/4d0b+sSX+OwBi7IYUoT7DGcyOszJB5ndOMZGHIxNFA
	 017Jc4/xYUX9J6bBbeS6QylNKrxPs84OBBaRchRM0CmunCg6nY8rLpDXQ6/BRkjmWN
	 ZpH/D/uTXeLEAkoc95OJZFrI0qL//qf7FbD0dVyg0dS77qyxV6KOSgCEpqcDBH+Prb
	 KjHc5KopvxDQ65FlsHQmwpN5t6MP2OE7FM4BHBfZxhxVstWOLVHOSfER/zwhCf2Y6I
	 Yk0yka0gYeW28TF7A+Zu5olbZPKcLDAmVphIDxoogTEJw03q8IVdEENZtcYEnh4o/O
	 zJgmYn7hrd5SA==
Content-Type: multipart/mixed; boundary="===============7454562033090932895=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1ab81cf709ce7d536a898695ffad30c15c8a6a7bf48dcb7271239952dd270315@mail.kernel.org>
In-Reply-To: <20260417192502.194548-22-jolsa@kernel.org>
References: <20260417192502.194548-22-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 21/28] selftests/bpf: Add tracing multi skel/pattern/ids attach tests
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 20:10:22 +0000 (UTC)

--===============7454562033090932895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c

[ ... ]

> @@ -0,0 +1,256 @@
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
> +			goto out;
> +		}
> +	}

[ ... ]

> +out:
> +	tdestroy(root, tdestroy_free_nop);
> +	btf__free(vmlinux_btf);
> +	btf__free(btf);
> +	return ids;
> +}

Does this code double-free vmlinux_btf when btf__load_module_btf() fails?
If btf__load_module_btf(mod, vmlinux_btf) fails, the error path at
ASSERT_OK_PTR calls btf__free(vmlinux_btf) and then jumps to the out:
label, which calls btf__free(vmlinux_btf) again on the same pointer.

The first free happens here:

	if (mod) {
		vmlinux_btf = btf;
		btf = btf__load_module_btf(mod, vmlinux_btf);
		if (!ASSERT_OK_PTR(btf, "btf__load_module_btf")) {
			btf__free(vmlinux_btf);  <-- FIRST FREE
			goto out;
		}
	}

Then at the out: label:

out:
	tdestroy(root, tdestroy_free_nop);
	btf__free(vmlinux_btf);  <-- SECOND FREE
	btf__free(btf);

The btf__free() implementation in tools/lib/bpf/btf.c checks only
IS_ERR_OR_NULL(btf) and does not guard against already-freed memory,
so this would trigger a double-free that glibc would detect and abort.

In the current commit, get_ids() is only called with mod=NULL from
test_link_api_ids(), so this path is latent. However, a subsequent commit
(4dda98b9e4d0, "selftests/bpf: Add tracing multi skel/pattern/ids module
attach tests") adds a caller get_ids(bpf_testmod_fentry_test, cnt,
"bpf_testmod") that activates the buggy path.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24583317711
--===============7454562033090932895==--

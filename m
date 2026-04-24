Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08E284881
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777062766; cv=none; b=cT2Q5zBE6ERQWIPsnz6+4Y5TUbWw4ObH7SURmvDDKvsAklqP9RzJw0ze+1hBwUZVu0z7sqLyc+U+lopYQ8SvA+nY5koJxKzvK8pgHEj17mOiXfbcY493BGoaqXVH6dz9DkasJh7yQZwwNbrW8sYYlBjtXsoKKBtR6Z25vAitQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777062766; c=relaxed/simple;
	bh=p4AF3toD/3hAP2/DIcEurXPuR3putX++oIPOXAKDWiY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Z+qtIPrMIfclBgZCOPvU7yJu8SGwCC5FlNs0jUJifKmvXXhUMGhvL6/LD0g2yBYemoVAa9gV0hi3wGQCNwIPGSfgA426x9bzMw4gimpt0l6iTuvqRFCNqc1ZYgri5REJ5PBwNxlwSw4677rngVf0vk624/k9mj4PsTlbW/XimJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqKgeyQE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqKgeyQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFE1C19425;
	Fri, 24 Apr 2026 20:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777062765;
	bh=p4AF3toD/3hAP2/DIcEurXPuR3putX++oIPOXAKDWiY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IqKgeyQEl/ITM9x1bn95xej+y91HxNwqygfH1WTucfFJ38j4MLQQme0d5M7k21Ohf
	 jQtvX8xB/H2EZHFEj3QO8G1KAnUfekmOxae4o1BSm7B4/uE3o4Lun2kmDh0Cwm7PjN
	 ObOqEZw8+WZXKgsZvrzF3kGPsd9Jp/ROrJ7AVVLm7mEKYXCv0/EiexpMew24O58WR3
	 AH73jjN2+2JLPWYI1RBKVnFF3aBicrSnxkRLzJrAUhpxFP3jIAVwD8PkZ1ck4ikdFu
	 E14deD/9/p/dJclE9DeEF1+16GXi6n5Y+BJo3fOgZPUq5obBif8PCqUEF6imnfCl8X
	 kVebHNTkdYCgA==
Content-Type: multipart/mixed; boundary="===============5593332662778327395=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8102f81ce7492f7c827b2dfdfce0434e291b581a4e3df6fa765bb4f34795264a@mail.kernel.org>
In-Reply-To: <20260424-rhash-v3-7-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-7-d0fa0ce4379b@meta.com>
Subject: Re: [PATCH bpf-next v3 07/10] selftests/bpf: Add basic tests for resizable hash map
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 20:32:45 +0000 (UTC)

--===============5593332662778327395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
> new file mode 100644
> index 000000000000..0f6eec4fe1fe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include "rhash.skel.h"
> +#include <linux/bpf.h>
> +#include <linux/perf_event.h>
> +#include <sys/syscall.h>
> +
> +static void rhash_run(const char *prog_name)
> +{
> +	struct rhash *skel;
> +	struct bpf_program *prog;
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	int err;
> +
> +	skel = rhash__open();
> +	if (!ASSERT_OK_PTR(skel, "rhash__open"))
> +		return;
> +
> +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> +	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> +		goto cleanup;
> +	bpf_program__set_autoload(prog, true);
> +
> +	err = rhash__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
> +	if (!ASSERT_OK(err, "prog run"))
> +		goto cleanup;
> +
> +	if (!ASSERT_OK(skel->bss->err, "bss->err"))
> +		goto cleanup;

sashiko-bot@kernel.org raised a concern about the test framework potentially
missing BPF program failures. Can the test pass incorrectly if a BPF program
returns non-zero while skel->bss->err is zero?

Looking at test_rhash_update_delete() in progs/rhash.c:

    err = bpf_map_delete_elem(&rhmap, &key);
    if (err)
        return 3;

    e = bpf_map_lookup_elem(&rhmap, &key);
    if (e)
        return 4;

    err = 0;
    return 0;

If the final lookup finds an element when it shouldn't (e is not NULL), the
BPF program exits early with return 4. However, the global err variable was
just set to 0 by the successful bpf_map_delete_elem() call.

Since rhash_run() only checks ASSERT_OK(skel->bss->err) and doesn't check
opts.retval from bpf_prog_test_run_opts(), won't this allow the test to pass
when it should fail?

This issue appears in other subtests as well, where early return values like
1, 2, 3, 4, and 5 can be returned while err remains 0.

Reference: https://lore.kernel.org/bpf/20260424200255.D5C89C19425@smtp.kernel.org/

> +
> +cleanup:
> +	rhash__destroy(skel);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24909591959
--===============5593332662778327395==--

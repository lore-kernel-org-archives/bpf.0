Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1A3E7BA1;
	Wed, 27 May 2026 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886781; cv=none; b=qWPNhmDlLZtKHJTyJMFBYgr4gQoFCbfnWjQ42YNEpXbgPmm0eF5MDZYZtBa61DqimwtGVaDFXQ8YG2b82rSsa9Cq7wrhxyve5LTDhvpoKsljo9VPaiaDj/YOKA0NF9tRD0nj9Yf2oz3hQb8aKosu71ZDnCaWXKBXBYnt0oVrwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886781; c=relaxed/simple;
	bh=hRsTKlj1z8B6VmaB33Hh9TqfzDUZdL0tUKH5Nubnezg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=itMZ8UWuvqJ5m/UdxKRKuLFayVhwW1RRi5XGhFVypQ1T/0t2VjI0ZxovGLQGevULIsu83qfZuOgtYCOXZB/27Uwrb95XvDAquP3z67wR32PMfTAvpTSxZHl6BF7ykpJxm23KtofOzPdxtvMMVHtmmZlpz8b/k19mdFVJm3cvQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMeFZCR4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMeFZCR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786C11F00A3C;
	Wed, 27 May 2026 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779886779;
	bh=GqfqquZS6ekIyaZaDx7J1kLf9D0N1+DVp83GFMhUbQY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RMeFZCR4d1vXuncj7A+z9dnlvMhtjoJN5AYQPhan1Oe5gOCd0UYLZiaOxe/jr/Bhu
	 Xe4nKEcIh2K/ubIoRpM9Khck2slAeRK6dcqdh9ExuiECCL1LVizTivMcPUF4heS3TF
	 x1X1PxIO0HfbMV3Bi3hCJZWmxY2wx4qdzX1F29IynQR6ddrAE63cVOfmEHmggCUKsj
	 3ehmGD4Jp+tuj5uyTrN5QQLMeORBTkbyYIJteObA2t083grtFGMH/WOPibpo5qTC5H
	 b1MRjXvAWc3oEXfPqqsXVHnl8mi1QqMjWinOlhkdY3IP5CvQwhBRbVtmhTFTH3tAy4
	 q203gHom1uKLA==
Content-Type: multipart/mixed; boundary="===============5538619460622759254=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20af6dea23834f831d06cf601a91bf8848d78091b46a913ed1b24302576983e1@mail.kernel.org>
In-Reply-To: <20260527113951.46265-23-jolsa@kernel.org>
References: <20260527113951.46265-23-jolsa@kernel.org>
Subject: Re: [PATCHv6 bpf-next 22/29] selftests/bpf: Add tracing multi skel/pattern/ids module attach tests
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 27 May 2026 12:59:39 +0000 (UTC)

--===============5538619460622759254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> index e290513358d9..746a8398211a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c

[ ... ]

> @@ -241,6 +250,96 @@ static void test_link_api_ids(void)

[ ... ]

> +static void test_module_link_api_ids(void)
> +{
> +	size_t cnt = ARRAY_SIZE(bpf_testmod_fentry_test);
> +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> +	struct tracing_multi_module *skel = NULL;
> +	__u32 *ids;
> +
> +	skel = tracing_multi_module__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "tracing_multi_module__open_and_load"))
> +		return;
> +
> +	skel->bss->pid = getpid();
> +
> +	ids = get_ids(bpf_testmod_fentry_test, cnt, "bpf_testmod");
> +	if (!ASSERT_OK_PTR(ids, "get_ids"))
> +		goto cleanup;

This new test calls get_ids() but there's an unaddressed review comment
from sashiko-bot about a memory leak in that function. Looking at get_ids()
in the same file:

    for (i = 0; i < funcs_cnt; i++) {
        if (!tsearch(&funcs[i], &root, compare)) {
            ASSERT_FAIL("tsearch failed");
            err = -1;
            goto out;
        }
    }

    ...

    if (err) {
        free(ids);
        ids = NULL;
    }

out:
    tdestroy(root, tdestroy_free_nop);
    btf__free(vmlinux_btf);
    btf__free(btf);
    return ids;

If tsearch() fails, the code sets err = -1 and jumps to the out label.
However, the out label is positioned after the cleanup block that frees ids
(the "if (err)" block), not before it. This means the cleanup code is
bypassed when we goto out, causing two issues:

1. The ids array is leaked

2. The function returns a non-NULL pointer to allocated but potentially
   invalid memory, which will incorrectly pass the ASSERT_OK_PTR check above

Should the out label be moved before the cleanup block so that the error
path properly frees the ids array and sets it to NULL?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26509800686
--===============5538619460622759254==--

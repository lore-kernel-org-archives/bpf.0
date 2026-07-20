Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C49339B94C;
	Mon, 20 Jul 2026 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539914; cv=none; b=O8wLZD4CT/wYsMx1g0ebdjYakYojHPNgX34zcainIk+WcojsroY6P+uMGuWkxDzt7G+NpJ7Uvcg1L1fFGdukzHyFmsWPNTsxZWb1SsIecUJe3M0pUS6tMNe901cpTdIvfCwtAfwA7oHn2o+6X4x1q0a/USbAIoVPaWbq4oKwmdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539914; c=relaxed/simple;
	bh=xFnz9SiSSMQeEtCVLAv68dH68dM5Q7ntmY83nP9kChw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=t0tYhXdHeyQj9q4qOFKBFigYxvmT0kknSrlWt++Q+CcsDBJt6V0+kYW9HSm0WooNiB+NDA2Cj4FngUSLJ30EsRsWA56JHzYgGKVVIgDPF7wuJfpqo3/cHFyBT1pyyUrGpIPhiDy3lrEuJaS116rM+lHhjWXNea50Kpxe0kTC+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X11zD1uu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X11zD1uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0F61F000E9;
	Mon, 20 Jul 2026 09:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784539913;
	bh=ggksV444PtYmcpDg5+bsp0fpXE5Z8Q+aOsfwxPe8Qd4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=X11zD1uuOxvlLpy7LTAa8Pifog4wTCxUHNKPcBeYmqSO7tT5G+kfvI+0cyWNO/502
	 isxDFa9EJCOonqQEroOa6EKYuAGAEdU0f5Wzev4bFTTLe66ZqsCDvSYEcaN7Pzbar9
	 a24LA9t2TN1UwMgSbzoK7qHmYIrRzx7//PaXk7ePaUeZaH7D+/keN9xk5JofKq1bwk
	 3uFlGic0yJhq/+DaHvrNZrTDafBcqDeyH0KeYzSQAZK7iR/ZJyTf903n517LjC/z9n
	 5gQ5HFYkzBjdyTu/OtvvTCbI0d+jVK6ifSg23ue4+rzCTifnHOe7eIZ5hAJQjjCnub
	 2Ooa4nc98LY5g==
Content-Type: multipart/mixed; boundary="===============5683590697765501289=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8d53b168d2b9631d66ce6e0806bfa9c96ffd4de11cc4a3ca2c7d8855203c93bf@mail.kernel.org>
In-Reply-To: <tencent_1A540D31C1E052E8262BE0324005E7756D05@qq.com>
References: <tencent_1A540D31C1E052E8262BE0324005E7756D05@qq.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs
From: bot+bpf-ci@kernel.org
To: rtoax@foxmail.com,vmalik@redhat.com,andrii@kernel.org,ast@kernel.org
Cc: rongtao@cestc.cn,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,ishiyama@hpc.is.uec.ac.jp,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 20 Jul 2026 09:31:52 +0000 (UTC)

--===============5683590697765501289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs
>
> Add tests for new kfuncs bpf_strcat() and bpf_strncat().
>
> And remove extra whitespaces in selftests string_kfuncs_failure1.c.
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

This isn't a bug, but could the whitespace cleanup in
string_kfuncs_failure1.c be split into its own patch rather than folded
into the commit that adds the strcat/strncat tests?  The commit message
already describes them as two separate changes, and the whitespace-only
churn ends up mixed in with the new test cases:

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> index bddc4e8579d2..d432d4990f80 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c

[ ... ]

> @@ -30,29 +31,31 @@ char *invalid_kern_ptr = (char *)-1;
>
>  /* Passing NULL to string kfuncs (treated as a userspace ptr) */
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_null1(void *ctx) { return bpf_strcmp(NULL, "hello"); }
> -SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
> +SEC("syscall") __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_null1(void *ctx) { return bpf_strcasecmp(NULL, "HELLO"); }
> -SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *ctx) { return bpf_strcasecmp("HELLO", NULL); }
> +SEC("syscall") __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *ctx) { return bpf_strcasecmp("HELLO", NULL); }

[ ... ]

> +SEC("syscall") __retval(USER_PTR_ERR)int test_strcat_null1(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), NULL); }
> +SEC("syscall") __retval(USER_PTR_ERR)int test_strncat_null1(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), NULL, 2); }

Keeping the two apart would make the new test additions easier to read on
their own.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29729113722
--===============5683590697765501289==--

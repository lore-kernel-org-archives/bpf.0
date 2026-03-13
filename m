Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0B395DB4;
	Fri, 13 Mar 2026 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410154; cv=none; b=kNYO/7IGRgeYQ0I/h4+sb3K00FsypUDNzFZnHFh5DLon6qWWSyJ3p66RdSl8+a8O6+T/qsBBuaYWVR01rzM8I+sDGCvLeUCiEEQdV57qkrmgveaJVZuWNy4H+t9UxiK8I4RJlJC8R5uVqyrSKUnKOviSrqwlvFTwoUa/77fIawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410154; c=relaxed/simple;
	bh=5XgquXITh//GqOCMKE6k7J7OKmDp/7BA6OGr0xoLEJM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CDC396kE9Kf7PpO9+FA1csEbVxb+Ec2ELnzDbEX2HpuFC8ovQYzwZT6eXBXae35CFbBwrdafn/r6uyo0vyenDUbc3fpeqP60oUdrmaeNX69oeRI7565i5ZkFE0sSZ8G4L3AYBCT/fOd4G7Bog2vh3UXQ633gyknewRCI0JrLdhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPIxeMdw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPIxeMdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DA9C19425;
	Fri, 13 Mar 2026 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773410154;
	bh=5XgquXITh//GqOCMKE6k7J7OKmDp/7BA6OGr0xoLEJM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=DPIxeMdw+T6VpY0QBSJWd6wMA0tk0RWbSSmUVjlBXLFbjVPKJSsUoqKyTRlRyOKDm
	 OtvvHQHQKwZaHSlnoQBbS3aKWYFVf9FRtgU1XFlUFXyUODQUg5MUodlitN4YxHiUBr
	 dA6HZXTzz1DWEewNTKt/jc06Jee2vRjUZ8uLN6dvveg1mMz8c1Y3HwKszTn8E7BSej
	 G/WRa222FAX07cHGWBdJn3Cgdh85QQA/TiCsI99a4Xa4WuRym4ixlEemAmBqcjjF4h
	 N+OGj1raZbcg2qDQ11s1leKLCllkXb62DIvl+ICf4eFupVbWjRtkmFWaDKSMv++w0E
	 WA4Fdu2NTJ8xA==
Content-Type: multipart/mixed; boundary="===============1568194592782735568=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4955a2c6a7fff7f4e383149e3b699a2af5eab965e414f3f19443b1caa97ba53e@mail.kernel.org>
In-Reply-To: <20260313130220.18590-3-slava.imameev@crowdstrike.com>
References: <20260313130220.18590-3-slava.imameev@crowdstrike.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add trampolines single and multi-level pointer params test coverage
From: bot+bpf-ci@kernel.org
To: slava.imameev@crowdstrike.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-open-source@crowdstrike.com,slava.imameev@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 13 Mar 2026 13:55:53 +0000 (UTC)

--===============1568194592782735568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c b/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c
> new file mode 100644
> index 000000000000..b507dc850543
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c

[ ... ]

> +SEC("fentry/bpf_fentry_test_ppfile")
> +__description("fentry/struct file***: struct file *** inferred as scalar")

The description says "struct file ***" (triple pointer), but
bpf_fentry_test_ppfile() takes a struct file ** (double pointer):

net/bpf/test_run.c:
    noinline void bpf_fentry_test_ppfile(struct file **ppf)

Should the description be
"fentry/struct file**: struct file ** inferred as scalar" instead?

> +__success __retval(0)
> +__log_level(2)
> +__msg("R1=ctx() R2=scalar()")
> +__naked void fentry_ppfile_as_scalar(void)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23052798110
--===============1568194592782735568==--

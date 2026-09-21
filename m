Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5B45C704
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981591; cv=none; b=VLM6jJgXDqA0pgUeduPj4mTswxKqrc24RClh3wlkNhEnooOVaeVor/CRSNVmVpBwyPnL2Bu8E0JKpsJ7GDoVy9uV1G1B4pbzhq0MFrsFoeN+PGhTldUNtQE1R7lHUdHuwS7KVMYi51zAved22obKTI24AiaN23oV1UzM3wjIxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981591; c=relaxed/simple;
	bh=tVlro1mxPYIVUnNUDvsZIF8NEIu4RbXJVm2WXoxmNtY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ky5VOvcikcZkt09EcCpvTtJfLfkwWWC2ckjoSnScghWFeYu1b2UzpSoeLYJYeeVNYb4LNR+vadMma+ynX7xxBiSEtSIbEsRujNfT2CKdLX4gcNqsDUCk41jl7aSR8atrwvWYzuOVNjhaii17rwT1cAH8X7m9Dpw4EM6IpuClBO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzB1wltp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzB1wltp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27681F000FF;
	Mon, 21 Sep 2026 09:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789981589;
	bh=eshhrEvDusrRwQ+m7K/75nm+mEkZDOMx/vqXGp2zbEs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CzB1wltpgsSB+NUbM/iuOrEw1sU3zwbrgoqCtRsfowVeJ4N/tO/CDE6UG9Fbjak5D
	 y35W00uFbQTDw+PbIR8yYf3u6JL4l+xI5F+ZZdgfM6uawAUYIilMvbA75dZaTPCHQu
	 siHBp/8gCy+8WHntC4y1Ylu+Mskj6S+/jKm0SF+jlkoh6eNVqFAw0Bm1iRubPFfJ8y
	 d+ZCBxMpJtftwL909yp0L4smTKfSlGM5Oi3rbYCUdIVh7edmiNOCzh2EKVoN6cYGZh
	 DTt9HDb92zvblOsLue9Vr1xGqolWRU2YdLIuMeQLnGfexgjJ3tzyiH62ZqnG5zw/fE
	 slhxNTocBNfpQ==
Content-Type: multipart/mixed; boundary="===============1779954109252387989=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <447aaf4b6cf6a6df572afd5323e516ab32554c776b63c08639abde301eba925e@mail.kernel.org>
In-Reply-To: <20260921075855.2065871-3-nickolay.lysenko@gmail.com>
References: <20260921075855.2065871-3-nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v8 2/9] selftests/bpf: drop stale lines, restore two header dependencies
From: bot+bpf-ci@kernel.org
To: nickolay.lysenko@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,nickolay.lysenko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 09:06:27 +0000 (UTC)

--===============1779954109252387989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index bfb788ea65618..3606ee8ab7949 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -339,7 +336,7 @@ $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
>  $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_tag: $(TESTING_HELPERS)
> -$(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
> +$(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS) flow_dissector_load.h
                                                       ^^^^^^^^^^^^^^^^^^^^
>  $(OUTPUT)/test_maps: $(TESTING_HELPERS)
>  $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
>  $(OUTPUT)/xsk.o: $(BPFOBJ)

This isn't a bug, but since the patch is already retiring the stale
references to flow_dissector_load.h, would it make sense to drop the
TRUNNER_EXTRA_SOURCES entry in the same go? Only flow_dissector_load.c
seems to include the header now, and that binary gets its dependency from
the line restored above.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35577680350
--===============1779954109252387989==--

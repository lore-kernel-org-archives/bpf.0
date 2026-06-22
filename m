Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7C0B640;
	Mon, 22 Jun 2026 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141896; cv=none; b=O5G/tfpNtREq78HfjbNOeTDRCIvaV8dlrIvrfpBBPKeWKs4/0vJsVGvDQaqK+u6JsTexqfYGSYmQfkvagrwDx0tE+x3ZhoA09vkUIsT9kIp/LQILXciyxKvdLSr23nmpStoAPzsiP6SzvhXcj7DFxJFdZBrrGV/PThXxHhO6O9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141896; c=relaxed/simple;
	bh=Zb8qIWo8TFw1gFuuU3whWb2m5t7haUYPH+3etKsgLEo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PjXnpTEFIqWc2ME/X3gBNlac8u0fmHWlfS0ZLu2tp9WPFE+wgfpiUmQFdDfLMERkzY4xhwWlV+RE2F9m0STBnol28mypQAhe3lpUpHA488RVAsX7VL3viB4uahofY6XuHUfIT86K1MGIzon7HSpuCX1moutB4ZlWU9yqtRLXK4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DB4snIj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DB4snIj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDB11F000E9;
	Mon, 22 Jun 2026 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782141895;
	bh=/twm+vWUOXqgwH18v7Lzr7A1++2IXQ3ApHr8I/g/fYs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DB4snIj+/hQ1Dr4cQzFn3vwErcUjAAzQc1Rb7s8r7FTxn0tVIBWPtYdFeoV6Qu0fp
	 nprZYu6BuJzw8WTe53xXa4d9sDIN5nQyceJwusWlomyQKo8aAoNF3X/AJMYLh65Ior
	 JFmmvktmyxAl8Q01MbtPpOFrKJGWZpeYZ0ashqHwUgwX3HC5s/WTmzyPQp49TljQSq
	 fDsetxD4BCwvzyIjXeit7KpSIpJnhG/jskYjQADCSmc3b419DLaLlW8P8cPWzfrZF1
	 KLhTzRs/PplQKwxl54SQTqmhpCj6x78D6EdEBn/Fd0lbmLL+sTb95k01QqEFD/Bd4E
	 qwEdwHXBOyajg==
Content-Type: multipart/mixed; boundary="===============1624727152317273375=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <187545ebc349810d6458e4ea87a391e0e2f4fa6032363fe3416852db9c08f67b@mail.kernel.org>
In-Reply-To: <20260622143557.22955-12-leon.hwang@linux.dev>
References: <20260622143557.22955-12-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v7 11/11] selftests/bpf: Add test to verify bpf_iter for global percpu data
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 22 Jun 2026 15:24:55 +0000 (UTC)

--===============1624727152317273375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index e4c290492ff8..32734e1dbfb0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> @@ -279,6 +279,56 @@ static void test_global_percpu_data_verifier_log(void)

[ ... ]

> +	fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GE(fd, 0, "bpf_iter_create"))
> +		goto out;
> +
> +	while ((len = read(fd, buf, sizeof(buf))) > 0)
> +		do { } while (0);
> +	ASSERT_EQ(len, 0, "read iter");

This isn't a bug, but could the empty drain body here be a bare ';'
rather than 'do { } while (0);'?  The other bpf_iter tests in this
directory (prog_tests/bpf_iter.c) drain the iterator fd with a bare ';',
so a plain ';' would read more like the neighbouring code.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27961789929
--===============1624727152317273375==--

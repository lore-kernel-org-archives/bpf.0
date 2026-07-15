Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B13AE6F7;
	Wed, 15 Jul 2026 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131889; cv=none; b=IEnd/CpFc7uaFzmbssMCBZNB7UDI+4uQtmJQ1qYpFaoW+LxpSN+WjxIrIh85q2/s9ks1DZ/j+sw1la9n3zDYhXqDFixekxx/qUIG3mV7eD7ImsuJKFL6gksX/lFDO6gZrtUCWl2CFStoRAdNFLDH5Z+Df9YcbJFanbXwrtJSd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131889; c=relaxed/simple;
	bh=xPWZlkaZmHTfwXAZBHNZ/26q/6xUwHL70MWiPjcrvuE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kc9gqjQGJ/CHT6lYVGzLBOzrCn2BPhtOyLMTGtV9Fxrr3l84i3bxC6tyhd5cDv8yaAP6VgGHpsbh7Mt8mOlo5CRbZFkEHdEnEiRo03yamgFYZSsciRAbnUThUyQv6pZevDWopJXQCIVy045cgz8QlyOtL6W2VrES9E2TpIHwncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ao6nUTM+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ao6nUTM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822481F000E9;
	Wed, 15 Jul 2026 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784131887;
	bh=Tf3cGA7IwdKD9g3buDsiPFR1lPrxDw72fmpnNSuoTHo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ao6nUTM++1OFBUS9Knq0jbVw9+96vziwZYqpohUdK5eYXsP0sNN1oohKfoY7JyWFS
	 PZ9hyasmN19rUwKo/CqOsd7hych3ErvuD2uPQDMDBIz3a8b2mLdNn81FfaZYnEe/WA
	 LrGyLh8pb/t6eitYSiLgiixYyvk1Z9TH/2Fw61yQlwQMHgYqjRAMl+M25ZXJCi+4cM
	 RwmVMiaOYrAgI/98XAoZRzIk35fKfVeAf2DzRf7TcPA2nCCqcoMrIKA6QYyWiuLZsz
	 yDzJw8/mZYkts9CEuga4Gk/pJ35TeZ1Snbl5vMNfMaC8sJpFVJYrNdtLaOLIjHIDFG
	 fCgD+U5/RWt4Q==
Content-Type: multipart/mixed; boundary="===============8374667622444933851=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <13cb81aa58ced1b75131c293972db0b78833c2e2ed4cf2427ac94afb39ee0112@mail.kernel.org>
In-Reply-To: <20260715153254.92010-7-leon.hwang@linux.dev>
References: <20260715153254.92010-7-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v10 6/9] selftests/bpf: Add tests to verify global percpu data
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 15 Jul 2026 16:11:27 +0000 (UTC)

--===============8374667622444933851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests to verify global percpu data
>
> If the arch, like s390x, does not support percpu insn, these cases won't
> test global percpu data by checking FEAT_PERCPU_DATA support.
>
> The following APIs have been tested for global percpu data:
>
> 1. bpf_map__set_initial_value()
> 2. bpf_map__initial_value()
> 3. generated percpu struct pointer pointing to internal map's mmaped data
> 4. bpf_map__lookup_elem() for global percpu data map
>
> At the same time, the case is also tested with 'bpftool gen skeleton -L'.
>
> Add a test to verify that the live vars of subskel won't include the vars
> for global percpu data.
>
> Assisted-by: Codex:gpt-5.5-xhigh
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

This isn't a bug, but item 4 lists bpf_map__lookup_elem(), while the added
test reads the map through the fd-based bpf_map_lookup_elem_flags():

    err = bpf_map_lookup_elem_flags(map_fd, &key, &data, flags);

Should the changelog name the API that is actually exercised?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29428917849
--===============8374667622444933851==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEEE47012F
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576498; cv=none; b=hgXc/bBkdJUuGzW2/x7UAXRrvvMFPHFoWserAnQqpdcoZQv/FNsEfBF4bhgYesuyNAhyuLEzM4Cs94Tk53Qj9Ehmx6chUywy1rQZCjeSouhg1VKLOstZ1dov+/5xLxCoGNcDr0YLaSe9pEQac7E/85d3FHSYvL4Qk3L8Osjny/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576498; c=relaxed/simple;
	bh=YD05KFKM4S11nG8Wm7speIG2YqG1+CKX0MwJTF3wXfE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NgKpyWj9UO+K8DkgAL0/8v/nuLB5mu0mD2SCFihRR2aejyhhFYn0bNLNaBUj2IK6H9ZkvJokLyuSQepFAt4qI6evol6DYWzJ94KdQUjJsEZB71qdjAhOwRTkDtwFO5YiaKiqLhnpMGTzh9U2vDbVeFBr3AZu4Y4pGjvOKlBwZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN7NAe4j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN7NAe4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29791F000E9;
	Wed, 12 Aug 2026 23:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786576496;
	bh=LQcLp1vHf9BuK95PLju9QCM/aOka62LQ74AceMuu1y4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mN7NAe4jzqBY/zONUKWwmF7kgEmXcD2VGJ9eAs8GwmyGzlsd1SD8X6NXzTnxoVFXG
	 4dELYUmiY7yweXPUOoPzsOPreFZqPO+6CH7Q3nMMPU1ljwsye4oUPZJ/sbRDaCweis
	 vjUvf2MXH5QkA/ehBHiBIusOXI4oaBWw7clmItoEODQ3CxHpV16VcqDH1CT876XRAY
	 bvBy78On9NZoJRctxpmHXqehdAjfLOflodK9PN7ZhikWqT+MJUMiax+ujM/w+WFVlF
	 2dHt4D7xSCjFuqRK02oJNyFUt19kRU6jYssSC+9LGnstfZMookSr0aqGw/mgVUzyvM
	 9d4c0DbuyETiQ==
Content-Type: multipart/mixed; boundary="===============4465619353943570755=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f8a769bf3f0e8ea2781f3a14ea2b80dc817ebb6b95664167028c9b147abd4ba5@mail.kernel.org>
In-Reply-To: <20260812221925.3358041-6-memxor@gmail.com>
References: <20260812221925.3358041-6-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v8 5/6] selftests/bpf: Test stack depth stats without BTF subprog names
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 23:14:55 +0000 (UTC)

--===============4465619353943570755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Test the per-program insns_self, insns_total, and stack depth statistics
> emitted when BTF function info does not provide subprogram names. Check that
> the subprog 0 main record and static-subprogram records use <unknown>.
>
> Make VERBOSE_ACCEPT request verifier statistics so the raw-insn test can
> validate the output without a test-specific log level.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This isn't a bug, but since the expected log splits around the
insns_self/insns_total values, would it read more accurately to say this
checks the record format (names, kind, stack depths) rather than the
instruction statistics themselves?

Looking at the test's expected string:

    .errstr = "stack depth max 352\t"
              "subprog 0 (<unknown>) main insns_self \t"
              " insns_total \t"
              " stack 32\t"

The cmp_str_seq() matching only verifies the label text exists, not the actual
counts. What gets pinned is the record layout, the subprog ordering, the
'<unknown>' names, the main/static classification and the stack depths (32,
256, 64, max 352), but not the instruction counts themselves.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31647029137
--===============4465619353943570755==--

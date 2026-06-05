Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F62D5A01
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662167; cv=none; b=eNPjlTU0ZINPSoEBYnvscm5tAFkjbxBOCtZV6OoTdv5zwOp9+ZEeOszycGkm6ACtotjm8JZBf9rfP5rtIOdSVUh0YlKFap/zNzdmpvmsCUt380JEvUZwDtQUfExJSVHMq30hKi0ViHUX7UIum2WqNc6RvCG/BarDTCj8Q3WN22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662167; c=relaxed/simple;
	bh=a7SecOqdduHbqsP/KeGFjY8WtpqwYTFh/W8nCnoWV7k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=I1ArzWLKC4v+y+HZgPRkxKOrvFRw39NitzOfjYpfGgVOKET7XjqM/TNAE0OSqOlBpl6O4ik9xabbAkCrm7xIUcL3MQpcU4Xj8Y0+9rru1QAYKvbLV9TJ1x1Ehrr7N6Wi92SKn+1/qWpgk+9gbQKwGVu5hP+lfbhihKMxPD9BQ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlLaFa7V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlLaFa7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978A01F00893;
	Fri,  5 Jun 2026 12:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780662165;
	bh=mDA2lP8VWe1Not8GBTacppwgi6mIVSVPk/rDlaoHMpc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZlLaFa7VUu5glbKP4UICLKx6eOFisXprcp0BjMGuV7ADaIVjraamcHrW2ZkkczWsQ
	 4CTSVLc3E0Sa1Q2jdxp7+gPrNt9XBjUEJRdWcYaqL+zNqHs+vm2ROMiLi3Q3Et7UOB
	 z5L2AUbOtIm1nS2Buh9W0qGWAbvRDz9qve4B5B4GkgvYH5nb7bZp1AAOx1KDSn9mx1
	 IcwPikVoVh67N/KLGCeO0nZ1S/CFEoruYV7XRQXTMeP8xoT2Af71HWpmNqGUJ5oOx9
	 pLhQ0r0HwE7oauOZptD+N1v0cjU6mkY4yIrbosh8diOcOVfYl5w8DjddyKv/SBNbA9
	 L2qSUxUcT/5Ng==
Content-Type: multipart/mixed; boundary="===============5061178354112411199=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6b923e9e93c63fe9d52cec371f06d2848ed9386333d46c2bb6c2f96dc07443d4@mail.kernel.org>
In-Reply-To: <20260605115713.3224051-1-linuxoid@gmail.com>
References: <20260605115713.3224051-1-linuxoid@gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: add arena split and fork tests
From: bot+bpf-ci@kernel.org
To: linuxoid@gmail.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,memxor@gmail.com
Cc: song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 12:22:45 +0000 (UTC)

--===============5061178354112411199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fork.c b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
> new file mode 100644
> index 000000000000..bb134e9adb60
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
> @@ -0,0 +1,53 @@

[ ... ]

> +	pid = fork();
> +	if (pid == 0) {
> +		unsigned char vec;
> +		int rc;
> +
> +		/* If the mapping was not inherited the range is unmapped in
> +		 * the child, so mincore() fails with ENOMEM. A success means
> +		 * the child wrongly inherited the mapping.
> +		 */

This isn't a bug, but does this multi-line comment match the preferred
BPF subsystem comment style? The guidelines ask for the opening /* to be
on its own line, for example:

		/*
		 * If the mapping was not inherited the range is unmapped in
		 * the child, so mincore() fails with ENOMEM. A success means
		 * the child wrongly inherited the mapping.
		 */

This was raised on v2 and does not appear to be addressed yet.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27013893868
--===============5061178354112411199==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFC5946C
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776719221; cv=none; b=bQnN7ePCGtOjog8jppAaOHINB7o8sYkkCPdzTtm0s7pCxH09uZyGe74j1XurrY4jpUzCCNXfkzbbHn6QKNKmpaxXD2OSMN055RcztMDzZSnHLGUI40EVAA98kr471jIfQAZ8o/tRUcRAuLke+CgiMBzQn918vmryEwzKk1dCPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776719221; c=relaxed/simple;
	bh=3cHSBmpcX2nJUlq6LI6ZlG++JUm8OwWAydtl2xnsHXA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SGmfDeIgtw5Yo9IjLKo6HaCMs+0hWNUrr33dPdLVyO6IzHjYNFs+CIjoHMDDy5E009UalVc89YhmuG8lEJ3vtbroUxFA/zUXsmVOTi2lMtTUchaC92j0PRxKSK6VsQS2BUJBAonlWRKxV1BwWbfxVI4aT3m7OSw/EzfxxRTYkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4wHmTxz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4wHmTxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEBFC19425;
	Mon, 20 Apr 2026 21:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776719221;
	bh=3cHSBmpcX2nJUlq6LI6ZlG++JUm8OwWAydtl2xnsHXA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=r4wHmTxzr5yX81l7dOirPPYfEBStSR+DwH7IxMT0HJT5unDQCuVyuO0M+PGsNSLZD
	 GUieA3z2aXa4NIRxPv1FTYxCok5P0ZGRFWtOfIqkFBRpKV8e9r3EIgb4bh5q5I+xEL
	 bhmdVDWgccXfcGdUqSlwr/gia2Uf1QdUCwK8i/LxL6l9HbAZv/J/XB1jBCyHo75NDo
	 U/H5Vygas3WzyJ5ZrwkPngbSFOuTEHbakH5E2tc2AsHqKp7BkwpphcM0dw+7VRysjc
	 IeDsJwgRySK5xJvYPR840Es+kvjCTX3ToufFfzxhbngtAW74r7inrHSi6mOPgCiBAY
	 r7Xvf3NpZO/Tg==
Content-Type: multipart/mixed; boundary="===============8674614109493422119=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <925d5bae9468149379825bf0c7ce4a7c3ce2373f3ff53c06482de72229558b0e@mail.kernel.org>
In-Reply-To: <20260420203306.3107246-3-utilityemal77@gmail.com>
References: <20260420203306.3107246-3-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for map-stored struct file kptrs
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bpf@vger.kernel.org,mic@digikod.net,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 20 Apr 2026 21:07:01 +0000 (UTC)

--===============8674614109493422119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add test for map-stored struct file kptrs
>
> Add tests for map-stored struct file referenced kptrs.
>
> Add a test storing a referenced kptr in a map. The referenced pointer is
> acquired by get_task_exe_file in this case.
>
> Add a test that verifies that the struct file reference remains valid
> when the original file descriptor is closed, by checking the extented
> attributes on it after completion. Trigger this validation manually by
                                                               ^^^^^^^^^

There's a typo here: 'extented' should be 'extended'.

> hooking file_open and opening dev null.
>
> Validation is done with xattrs.
>
> Add a test verifying that attempting to insert unreferenced struct file
> pointers into the map is rejected by the verifier.
>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

> diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c

[ ... ]

> @@ -0,0 +1,246 @@

[ ... ]

> +	while (1) {
> +		ssize_t bytes_read;
> +
> +		bytes_read = read(src_fd, buf, sizeof(buf));
> +		if (bytes_read < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			err = -errno;
> +			goto out;
> +		}
> +
> +		if (!bytes_read)
> +			break;
> +
> +		err = write_full(dst_fd, buf, bytes_read);
> +		if (err) {
> +			/* Remove partially written destination file so it
> +			 * doesn't linger on disk.
> +			 */

Can this comment follow the BPF multi-line comment style? The opening /*
should be on its own line:

/*
 * Remove partially written destination file so it
 * doesn't linger on disk.
 */

> +			unlink(dst_path);
> +			goto out;
> +		}
> +	}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_file.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_file.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_file.c

[ ... ]

> @@ -0,0 +1,152 @@

[ ... ]

> +	task = bpf_get_current_task_btf();
> +	file = bpf_get_task_exe_file(task);
> +	if (!file) {
> +		file_kptr_err = 2;
> +		return 0;
> +	}
> +
> +	/* Exec can open multiple files while the new image is being installed.
> +	 * Only stash the child's final executable, which we identify by the test
> +	 * xattr.
> +	 */

Can this comment follow the BPF multi-line comment style? The opening /*
should be on its own line:

/*
 * Exec can open multiple files while the new image is being installed.
 * Only stash the child's final executable, which we identify by the test
 * xattr.
 */

> +	ret = bpf_dynptr_from_mem(file_kptr_probe_value,
> +				  sizeof(file_kptr_probe_value), 0,
> +				  &value_ptr);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24689427455
--===============8674614109493422119==--

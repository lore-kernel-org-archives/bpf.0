Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6223EAA0
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953514; cv=none; b=WpyMGgT3v5594WLnveqkpSVoPwBqvjAG5r53CGOTxZjQB9YdetdJ56rNE2B86CjkD+2563c6jFqgiBsCm4WivRIy7HHfK3UZPqzFjRcbKkQEsYlF3UVcSxLVYIFWIBeJoWLwAEzuXR36cwgyuuKRsBex3yFDX+tBGJoljBlkKDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953514; c=relaxed/simple;
	bh=Fh7In0OQdYeMXtei9EkBQU0nIUp3d67ZTUTHSLWTagQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OnhM2bBdHrk0BeRnxocg7YUN6ZPFcDFRldvuln+yfmCWeWs7IamYeLwFBBhp7LZf9KV6KEmo5iDyQkMj3IiUgqa1Ip9Btv2bObdZzh8FchgJbutGxLnkN299vQVAzn7++LjdGvagfw7SmLxX+sPr0wIC1N5ukiow/DC/RWLfMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0KE3w6l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0KE3w6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A170C116D0;
	Tue, 24 Feb 2026 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771953514;
	bh=Fh7In0OQdYeMXtei9EkBQU0nIUp3d67ZTUTHSLWTagQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=T0KE3w6lwDRXGYZ1oPjZ5CXHUYpiXLQT7FwwoyhdQY34EvcsyG2M/fyY0arXeEmo9
	 Q0rWgAElUbKTHu7bGtYlCRmLbuRTQqwXRXp6LGGz0wBRXuRpsln2DiHnoyNlHtMapJ
	 JPVYNlvg50dB8L1pscGWgfXOOu2jbEi64pZG7hbdf3BGiUASDBgmqkti0mwWgNkM8H
	 URYKebHG+1f6zZGdCDoVxvU8h/DfSeIezPOmlwKgPvZE1Ythozsxkxoht54loucfbB
	 g8RlzdIebs7eD6X+PNipeSDHJ5/aY1TThP1mfKxj1mIVIg+szckIKZNcMXEGctvg+7
	 Z0Ho7n3f+dgvA==
Content-Type: multipart/mixed; boundary="===============4147559795412978623=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b3fd82fe09eb200599e8ac8e24ca4f9b8b995f0902f2d4343585a6b8291e6229@mail.kernel.org>
In-Reply-To: <ebce5bbcffe226e4ca1894c4970d094fadd711f7.1771950922.git.josef@toxicpanda.com>
References: <ebce5bbcffe226e4ca1894c4970d094fadd711f7.1771950922.git.josef@toxicpanda.com>
Subject: Re: [PATCH v5 2/3] bpftool: support merging multiple module BTFs in btf dump
From: bot+bpf-ci@kernel.org
To: josef@toxicpanda.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Feb 2026 17:18:33 +0000 (UTC)

--===============4147559795412978623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Auto-detection of vmlinux as the base BTF from sysfs paths works as
> before. If vmlinux itself appears in the file list it is skipped with
> a warning since its types are already provided by the base.

The commit message says vmlinux is "skipped with a warning" but the
code filters vmlinux entries silently.  In do_dump(), the first file
is filtered with:

    if (strcmp(*argv, sysfs_vmlinux) != 0)
        files[nr_files++] = *argv;

and subsequent files with:

    if (strcmp(*argv, sysfs_vmlinux) == 0) {
        NEXT_ARG();
        continue;
    }

Neither path emits a p_info() or any other diagnostic.  The v4 version
of this patch had a p_info("skipping %s (already loaded as base)")
call which was dropped during restructuring for v5.  Should the warning
be restored, or should the commit message be updated to match the
actual behavior?

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c

[ ... ]

> +		while (argc && strcmp(*argv, "file") == 0) {
> +			NEXT_ARG();
> +			if (!REQ_ARGS(1)) {
> +				err = -EINVAL;
> +				goto done;
> +			}

Quentin Monnet asked in v4 review why strcmp() is used here instead of
is_prefix(), which is the standard pattern throughout bpftool for
keyword matching:

https://lore.kernel.org/bpf/4ccb0ad0-3e50-4548-b8d6-e2d7e93b3dad@qmon.net/

The initial "file" keyword is matched via is_prefix(src, "file") at
the top of do_dump(), so abbreviated forms work for the first file
argument but not for subsequent ones.  Was this intentional?

> +			/* Filter out any sysfs vmlinux entries. */
> +			if (strcmp(*argv, sysfs_vmlinux) == 0) {
> +				NEXT_ARG();
> +				continue;
> +			}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22361062191

AI-authorship-score: high
AI-authorship-explanation: The commit explicitly declares AI assistance via the Assisted-by: Claude:claude-opus-4-6 tag.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Commit message inaccuracy about a missing warning and an unaddressed maintainer review comment about keyword matching convention; neither causes functional problems.

--===============4147559795412978623==--

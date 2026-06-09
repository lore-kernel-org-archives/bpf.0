Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C3E3ACA43
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003833; cv=none; b=oIsOVb9Ut4vF8xWZ5pWX1JEfSr4MfcsqYiSsFNP7cnsdwoJCI3oClg1iliSlAMwSEmPiUbO7dXxf0ioILoLIhrnSRboHuoPjW8rUcnQE/M6cTxraBSaN2pjR9ned/2r7oCmZ4OsIlUQzcha/qfvLINOmPfKM+wOQSxg5n6L4iWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003833; c=relaxed/simple;
	bh=O4bpGdjHVpJLORv4XUOQjaSEKQusMa0bbGjjOxgojZA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EhPsAV7zuytnG09n7XVdVT7FIZqdPFCCr9ci3MDehjV1HVyXncAbskmTj4L/pmsP4drBAPDMGVccQ3NKsFYH+65i/XRQmSswhvNcNK6MUcD9wZYfG+lUM3qbV5GPpuPfOPJ+ocimOdnNt6Lhp/XUz0+9cpaYmhTHAQfDyo11ONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/HNuwgn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/HNuwgn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B741F00893;
	Tue,  9 Jun 2026 11:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781003832;
	bh=7nEfXy69vYiNCahwS6ZlKUXrdtMWfxX+YM9y2tAflI8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=C/HNuwgnFwH9d1gGYWbT7raCN8/G9yT7i4ya7YaM5PRun2q7EuXDNRkT4uw05U8Dz
	 8RyRkrIAKOEQrL6aEqsAT64rNEcLWijYyHn3vUCggcEAjpuqcOZTTr3Jb2BGDmmNEs
	 xnlQbjGqox7G5USBNPVBzCgYmOIvDaeCJLAQ/T/FS+tLDbgrzt2Ja/oTlkDjZoykD7
	 nXsfkOA9PO59mFeJa106B/9XF55l+lpb4zC+9E47/6chnOU20URPYC+V6uBRcJmjgq
	 RwoL4sk1rSYciUE3IPWX5idsLDp+SF+yDAW4HvUz7/Q2u9RiJxjuDvn7Y8EHwB9p+T
	 AUA5p90pye66g==
Content-Type: multipart/mixed; boundary="===============9167227088313926545=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e651c603d7b7501bbf77c4b516098c3135a8b45d445ed8e3994f6dd76d01f6a8@mail.kernel.org>
In-Reply-To: <20260609104244.588321-3-jolsa@kernel.org>
References: <20260609104244.588321-3-jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add support to specify uprobe_multi target via file descriptor
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,oleg@redhat.com,mhiramat@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  9 Jun 2026 11:17:11 +0000 (UTC)

--===============9167227088313926545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Allow uprobe_multi link to identify the target binary by an already
> opened file descriptor.
>
> Adding new BPF_F_UPROBE_MULTI_PATH_FD flag and the path_fd field for
> the attr.link_create.uprobe_multi struct.
>
> When the flag is set, we resolve the target from path_fd, without the
> flag, we keep the existing string path behavior.
>
> I don't see a use case for supporting O_PATH file descriptors, because
> we need need to read the binary first to get probes offsets, so I'm
> using the CLASS(fd, f), which fails for O_PATH fds.
>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

This change also fixes a latent bug in bpf_link_show_fdinfo(), changing
the exact-equality test to a bitwise test:

	else if (link->type == BPF_LINK_TYPE_UPROBE_MULTI)
		seq_printf(m, "link_type:\t%s\n", link->flags & BPF_F_UPROBE_MULTI_RETURN ?
			   "uretprobe_multi" : "uprobe_multi");

The original "link->flags == BPF_F_UPROBE_MULTI_RETURN" was harmless
while BPF_F_UPROBE_MULTI_RETURN was the only defined uprobe_multi flag.
This commit adds a second flag (BPF_F_UPROBE_MULTI_PATH_FD), so the
exact "==" comparison would misreport a uretprobe_multi link as
"uprobe_multi" whenever both flags are set.

Should this carry a Fixes: tag pointing at the commit that introduced
the fragile comparison?

  Fixes: 803f0700a3bb ("bpf: Show precise link_type for {uprobe,kprobe}_multi fdinfo")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27201419867
--===============9167227088313926545==--

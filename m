Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75439020C
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119747; cv=none; b=Ohvd0O43zhvNtDDZUR5F2osk+wyhHF9YPoBrLbFM5mw7rXBwIc5fOq6Sb2gKv6I/TcudymaHjcL8wqOvnEeuqj2plOLgmeuqMZ9kKVYAM51aDy0qewngt2VRbeEB1CqBTQSlSws+aqiNEqDdGgYpUMARd4iYEelBUta7xSMYl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119747; c=relaxed/simple;
	bh=32BIU5tubp/u/8SUJud2DG6VlB03/4UD7FmWcuMVuj0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UG3j1xDnLH9sbKd70toEr3rlg3saBjDvW7Dv5gYcMYRFACPEtaziumvtZvBE8MYzR7jLRZFIdhOyYEkDRkY9llBn6txhuv+YmVa50NYfqUUzvQjV8U6x7bAAbJQuHl8rRfBPYQAqOueZ+xg84p6Qli0HMJbqtwMgaCJerhIJDFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0g8Dx8H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0g8Dx8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6341C2BCAF;
	Mon, 13 Apr 2026 22:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776119746;
	bh=32BIU5tubp/u/8SUJud2DG6VlB03/4UD7FmWcuMVuj0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=M0g8Dx8HFvCKjxRmsQi+jGazX4J0KMfyX5dGO+mzekwQ3SnKKgukQ/P7VccvUb/BV
	 mBtIGg1GrjUKMlepMFyNnYJgKeQj01Y+A9IIVUn2TKkNpN4dsbkSRp5p8n6XD7wFqS
	 XPasanKtgf6NlSaI+hNIjyQ++9BBUEF/0qhtloK9k/0g7GjdkXvnZ+92AxUzbQjGvW
	 daSiUQraUqy526BhFwt7Q7wnqHGqB21urMznB68HkEtx1jnVuG26/3zR1DtFIC86FC
	 bp6NhhSH0fU8tm76xe9Y94XxRMWUZv0OWR393O14om2FIr8HhevbT6VvCxCoXxZM6F
	 O7hGiDG+jfs2Q==
Content-Type: multipart/mixed; boundary="===============2079917072474390360=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e5aaee29c55b7c801c713abe8977d42618df38ee605a25a4f8631d926f88b830@mail.kernel.org>
In-Reply-To: <20260413-stacklive-fixes-v2-1-ff91c4f8d273@gmail.com>
References: <20260413-stacklive-fixes-v2-1-ff91c4f8d273@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: fix arg tracking for imprecise/multi-offset BPF_ST/STX
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 13 Apr 2026 22:35:46 +0000 (UTC)

--===============2079917072474390360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 944d3bf7ec135889f575f3b8ae4612684896737f
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: fix arg tracking for imprecise/multi-offset BPF_ST/STX

This commit fixes the arg tracking dataflow analysis to use weak
updates (join) instead of strong updates (overwrite) when storing
through imprecise or multi-offset pointers, and extends dst_is_local_fp
to recognize ARG_IMPRECISE destinations for BPF_STX and BPF_ST.

This appears to fix bugs introduced in bf0c571f7feb ("bpf: introduce
forward arg-tracking dataflow analysis"). Should this commit include a
Fixes: tag?

Fixes: bf0c571f7feb ("bpf: introduce forward arg-tracking dataflow analysis")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24369343210
--===============2079917072474390360==--

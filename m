Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148543375CF;
	Fri, 20 Feb 2026 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585081; cv=none; b=gUAfcLFKAOz3GTw9RsHHEULJfg3fpQ734++9InfpEnyeRXEYIDUdTgXYbc1bdGQosSVZB+7kt8tw9AYSIxF3soOrGkJNVqXQH+SyLlx9hiKfgSsZiq3gDR00MGmuvhgdUkWFzRy2OdXiHUi0xiqXjoJ9Hegg9tJu07/zarl0Y4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585081; c=relaxed/simple;
	bh=ujeVhXmM4ay0nAJL6w/gTVdOkTZScBJ+lCtOa3kcvvU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QjXyNtQb0NEhtv4gK8aXr5QZddNqR3XwFsKpxmE4wxF0QsAVxF8bfSuG7p6tKZy+T96BL5S35QurDCkY1Q96cfVi1xJ4jfT+R8bwSGjQvSkgPmOkbOWBoFeF8+1y4FvGTohYmYQKumCZUdyZFc9USp/9+dVj4o6nfScXiG5TKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTHAuLzT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTHAuLzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F70CC116C6;
	Fri, 20 Feb 2026 10:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771585080;
	bh=ujeVhXmM4ay0nAJL6w/gTVdOkTZScBJ+lCtOa3kcvvU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=HTHAuLzTLDKOK5pcHs3UMIwOG2csXYH5nDtJPGM+E1ncCv2lS6utcILpxnvbclZxT
	 mOXfpqf3MYqz359pw8nIn0QsfHFuRUuUfKM5JZqI6gMhl8ESSieg3OA/Z2gJopolD4
	 3F4gZ5ZpNAQs0KRyIxFUeweFAtwIO4MZJAYR0coGMPj3BG6Jc/FCTQcO733Kc/lRYA
	 7tTaCKiPyYZx8YWpKJqscsypdBpQrxuLk0DU3KUe5biJiO9GOUqx1gz9HXczrdGAXC
	 LkjIkR48b/RMxvGpKYE5pmBSuiPb6x3w+RUwVcT/QbQrOUoTjz1JjJYMV/+J1SrahI
	 9CBrrEQdA4xZQ==
Content-Type: multipart/mixed; boundary="===============8832366613410037155=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eceabbf86e0765a807e9edad56c44f0abbc218c79fa6bfb97ba480f64ef2a53b@mail.kernel.org>
In-Reply-To: <20260220100649.628307-5-jolsa@kernel.org>
References: <20260220100649.628307-5-jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 04/17] bpf: Add struct bpf_tramp_node object
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 20 Feb 2026 10:58:00 +0000 (UTC)

--===============8832366613410037155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> +struct bpf_tramp_node {
> +	struct bpf_link *link;
> +	struct hlist_node tramp_hlist;
> +	u64 cookie;
> +};

During the RFC review, Andrii Nakryiko suggested that instead of
co-locating a prog/link pointer in bpf_tramp_node, the JIT functions
like invoke_bpf_prog() could accept the prog pointer as a separate
argument, keeping bpf_tramp_node to just {tramp_hlist, cookie}:

https://lore.kernel.org/bpf/CAEf4BzY=vqpnjrDNtLVvC3_nU5=Z7iROU_He=xbkEJDuGCoqug@mail.gmail.com/

The RFC had `struct bpf_prog *prog` in bpf_tramp_node and this v1
changed it to `struct bpf_link *link`, which still co-locates the
path to the program inside the node.  Was the refactoring to pass
prog separately to invoke_bpf_prog() considered and ruled out, or
is that planned for a follow-up?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22220470181

AI-authorship-score: low
AI-authorship-explanation: Mechanical refactoring with lore history dating back to 2021, consistent with the author's known kernel development style and iterative review process.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Unaddressed RFC review comment from maintainer about struct design; not a code bug but a design concern about co-locating link pointer in bpf_tramp_node.

--===============8832366613410037155==--

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695954;
	b=i5goVvlp82TcCNPoEVBq/u9IjcfDgL+f5bhfd/qfYsGIKd/j2iK+lzHEWurI8mKCM4OQ
	 rTy4imnDHQ8ZNa1LnmX8BHUXOUBokV3TEsPNZtqD2rXhggz7SHT4qlzZFnL0H5ewQ9GIx
	 v4GgchL002PZ74FqQOm6mfIb0O8CgwGMa8ykMJekJiGCMDw38s/CORXlfSU6Q5IqIIWP+
	 cYVqOgAVqgyaKKqRcdZF1Z1yrAOUUmRJ4b8eoQX5CSsHH/uww8r5AxZuMArZkuz5+LB7S
	 1E2Jr4TWs+alDauASma72WiAOuaaZYuEvgHwEPULspHKJwtqc27GqYMSA4Hbk6GXijw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695954;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=kOsQgTVGIr/Tgep+NhW4hFbLq1/HBMqauRz/MX5hys0=;
	b=XnG2/qXFaTHMfT3On5d1j2PL9TIwRK+35/dX32CyI3xZ/vf92qFQKAOlBGG/jENGLIGI
	 qtWVZwwpxaCJAxU7bjfxWih5rCHc250YHwOiVwrd5wgiuay+gqNrlM+XtPX7nWDmxEBAq
	 PsAjFwVHxLdKhY4qvJQSaUdyG5vhmhw2z62TChRzOIZTH8SyFNMyNl+pRBjDHzU3Tg5LN
	 0OEOGzYUlu8eBLDTtePcwMS490wgSiWgRrWyrPAkjmgeXptIzEAPNjie3feLZ7qkrOevL
	 w0aMHmPggtpPQEztLcWVsFQjEE+eNv6VWYofiKsNfx1w2mIwAZuS8jtIUW40ekxF9xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=huWd5l+4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B6D606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=huWd5l+4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD3C1F000C1;
	Tue,  3 Nov 2026 08:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695954;
	bh=kOsQgTVGIr/Tgep+NhW4hFbLq1/HBMqauRz/MX5hys0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=huWd5l+4F1p+J0e/58VInghO7CNSTaaGVdbo5FineQFBFdmf24vmWLFN79iG31zWp
	 CIoe1TPdP5xOq9rQEM4AwCOCC27U7hVXBuwqvb/uJG7PXNuUIjb7Qvv1+odSMnI0VE
	 gcTCo+nv9IAI8fIdYrYqGxh89ujO1h6ZLZMsg4BTF86q2d3LfApttRJ1Av4gf7AV10
	 GbzaX1t7dTzXLTvaS9Bd/seH4No5BR1nUhUWOa/TLtZiIO/bXqDLzit7aG88HgiQUO
	 VKNL27/sUq/WjFFAbm2gK4o6+tvorDsU8BTMQzBukjtY3KitCvGSV8WDUYnd56gy8Y
	 1fMW+OJVd52dA==
Content-Type: multipart/mixed; boundary="===============4326115560903711698=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <777e38238bae7c9eed41283cbb64940b49db57f67f10be75346de2051fac6dce@mail.kernel.org>
In-Reply-To: <20261103075916.100050-3-jolsa@kernel.org>
References: <20261103075916.100050-3-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 2/8] bpf: Add user memory kfuncs
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ljs@kernel.org,john.fastabend@gmail.com,nierro92@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 08:52:33 +0000 (UTC)

--===============4326115560903711698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add user memory kfuncs

TL;DR: Commit message only: it lists what the diff does; could it describe the
use case and why FOLL_FORCE writes and PROT_EXEC anonymous mappings are
needed? No code bug reported.

>     bpf: Add user memory kfuncs
>
>     Add sleepable kfuncs to copy data into a task's address space and to map
>     or unmap private anonymous memory in the current process.
>
>     Require a usable user mm for mmap and munmap. Register the kfuncs for
>     KPROBE programs and gate them on CAP_SYS_ADMIN BPF token capability and
>     the BPF_WRITE_USER lockdown check.
>
>     Use FOLL_FORCE | FOLL_WRITE for task memory copies and return -EFAULT
>     when a copy is incomplete.
>
>     Rename the syscall info-copy helper to bpf_copy_to_user_buf to avoid
>     the name collision.
>
>     Assisted-by: Codex:GPT-6
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>

this isn't a bug, but could the changelog describe the use case for these
kfuncs, and why FOLL_FORCE writes and PROT_EXEC anonymous mappings are
needed, instead of listing what the diff does?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41602296728
--===============4326115560903711698==--

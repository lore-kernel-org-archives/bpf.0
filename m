Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888DB38A70E
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273200; cv=none; b=jhRMItpuTf23QZDwLoBFsjNOx7nZ9YnUKSY5psArVbnFz5nObUzBp/1LDtOwGytJebfalxIRenDUxXF/aFtp3KqBtNLeA3Akqyj0DfrGQRIYT4P0QNws/Q2KKqSK6sQoltZrgYOrLrrKkMw9pJ45p+DoTWM48xGwggaJqSrUA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273200; c=relaxed/simple;
	bh=SOzKbazOCLpKflfqgysH9Tt/kpVuMvBQ7e7txhsHWh0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DjSEX3O2f9JMgQfNv3bV+mVyqQA2gy0/LeoWdMp1B3cuGbuQ1Lx/PPrvd2JV4jWaSXTKOT8bZWEbB+x6LOyvpn1xxKsd9eS1y+5LMjp7la8E4fghzqPZ64UG7y005Ow124SX5oT5Dg3JH0v4K5nnE9dXVO3JbBk2vZFp7XzgzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGQnW7Ho; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGQnW7Ho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5602C4CEF7;
	Wed, 11 Mar 2026 23:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773273200;
	bh=SOzKbazOCLpKflfqgysH9Tt/kpVuMvBQ7e7txhsHWh0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=sGQnW7HofhabkfPzLFMisizp4N+OybDD2Es9zLphhRt9y2NoCzU4hyJcn4t3Btz7V
	 oPRahI0QPdY8Z0JshJBdQZw4n4yU37l3HsxRK4Xzx5rTIqsnQodkyeNMdfJe2F5K9S
	 Ndq0MY1EojHwYG2ZDsZh76nlXqpm3GT7N8NQX4JnG3nJOrYASdySxKD5BivQ1RI88I
	 HLsuE0ygkh7ZgToRYl2V3+RD252YmsLT50R2JDVpirzcHA5ytNPDI6uev7jooKHXOA
	 M96Vd8cXEYEOzpIB0QXYxfHiJ9ok2NXRsUZ9TRvbKG8nun/yzo3Mn6asOX4iaSwI59
	 U4ApEJv8PkDLA==
Content-Type: multipart/mixed; boundary="===============3431656453584545981=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b92523761351a0b0c9413962d141951c90b422e560449a73b9fd2f03d84c580c@mail.kernel.org>
In-Reply-To: <20260311225726.808332-4-puranjay@kernel.org>
References: <20260311225726.808332-4-puranjay@kernel.org>
Subject: Re: [PATCH bpf v3 3/3] bpf: return VMA snapshot from task_vma iterator
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 11 Mar 2026 23:53:19 +0000 (UTC)

--===============3431656453584545981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 50dbeaeafd86..83e3c3983341 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c

[ ... ]

> @@ -928,23 +928,37 @@ bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
>  __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
>  {
>  	struct bpf_iter_task_vma_kern *kit = (void *)it;
> -	struct vm_area_struct *vma;
> +	struct vm_area_struct *snap, *vma;
>
>  	if (!kit->data) /* bpf_iter_task_vma_new failed */
>  		return NULL;
>
> -	if (kit->data->locked_vma) {
> -		vma_end_read(kit->data->locked_vma);
> -		kit->data->locked_vma = NULL;
> +	snap = &kit->data->snapshot;
> +
> +	if (snap->vm_file) {
> +		fput(snap->vm_file);
> +		snap->vm_file = NULL;
>  	}

Andrii Nakryiko noted in his v2 review that this fput + NULL
cleanup pattern is duplicated in bpf_iter_task_vma_destroy(),
and suggested adding a common helper to keep them in sync as
more trusted fields may be added in the future:

https://lore.kernel.org/bpf/CAEf4Bzb9aPiAxOfo+_L6iaZPGrk3mPQ+6yuA6msTUHOV=xbGfg@mail.gmail.com/

Would it make sense to factor this into a small
bpf_iter_task_vma_snapshot_cleanup() or similar, as he
suggested?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22978681697
--===============3431656453584545981==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6731714AA
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074017; cv=none; b=UQmRSPx8RobzgyVM1HL7xwJyXspYzppTFdtQVq9L6wpeSA/P8EEhGUtvKuRKrfJyF/Q6xcIuk7hBzfLz1VU5FGyfQt+SLW7UBsRTNWzkLw0LN/86Nr4NuGVRLRQbZSIBYD7quNpkapECggK02V8GdWbu2Euzv6fCnOzvDcA9lno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074017; c=relaxed/simple;
	bh=SaLEcj5dQz01ZP70/avYwjzuKAyMs/kWshBG00l3Csk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NQBUSaiAt9vB6D9C+4hnEpaZCn3DE4zg8APYBUs8SaX2HbmLnJ6nX3dsYUUJOl7vkMY/d+OGpzmytBEyv4+YJkRO8wXOU5Iee1Co2AxkWyPJVHApBXsyMbTpThUrlyjkTOJe69VBoOSGio/T2xw69N0RHY0wQKMKoz7bwf+gkbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQQVsIWb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQQVsIWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEA9C4CEF7;
	Mon,  9 Mar 2026 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773074016;
	bh=SaLEcj5dQz01ZP70/avYwjzuKAyMs/kWshBG00l3Csk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kQQVsIWbxsO9zEfiaVDdbSJ8t0HFtDztSZiTUdojK3pfnc07oMRvcfeazase+Al81
	 wILz/1HEhYC28N0qeXg+cZjBNKTIcpIHGYVerss7yaKDviIxelRHzYO1Mvh9JAVdqM
	 wQZDhhfauOBsSyEbdB2UcGBHHrvKNLv2glb7VXnpiWaF54IbN9IWZK44S9EjvO1nVT
	 IJhDzVv6x+MjYgLQ4kudO9PcqobSqt4DHJCXs/LhOpUlbCpjCsvRZCCVXCF+Ub51g9
	 NoH+xxIds5WlAMQ6TOWRswsfET+R0amzLHSxG2u2Xc6BhM1ugZnAQ29JMFRNalf5z/
	 dJ59SWmsJ2RaA==
Content-Type: multipart/mixed; boundary="===============4840168270955531071=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <77b1bd109312c2b2dd53fe217a3504ff0454b36beab0f308c215e60b5633c4cc@mail.kernel.org>
In-Reply-To: <20260309155506.23490-4-puranjay@kernel.org>
References: <20260309155506.23490-4-puranjay@kernel.org>
Subject: Re: [PATCH bpf v2 3/4] bpf: switch task_vma iterator from mmap_lock to per-VMA locks
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,kernel-team@meta.com,yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  9 Mar 2026 16:33:36 +0000 (UTC)

--===============4840168270955531071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c

[ ... ]

> +static struct vm_area_struct *
> +bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
> +{
> +	struct vm_area_struct *vma;
> +	struct vma_iterator vmi;
> +	unsigned long next_addr, next_end;
> +
> +retry:
> +	rcu_read_lock();
> +	vma_iter_init(&vmi, data->mm, data->last_addr);
> +	vma = vma_next(&vmi);
> +	if (!vma) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
> +	next_addr = vma->vm_start;
> +	next_end = vma->vm_end;
> +	rcu_read_unlock();
> +
> +	vma = lock_vma_under_rcu(data->mm, next_addr);
> +	if (!vma) {
> +		if (next_end > data->last_addr)
> +			data->last_addr = next_end;
> +		else
> +			data->last_addr += PAGE_SIZE;
> +		goto retry;
> +	}
> +
> +	if (unlikely(data->last_addr >= vma->vm_end)) {
> +		data->last_addr = vma->vm_end;
> +		vma_end_read(vma);
> +		goto retry;
> +	}

When lock_vma_under_rcu() fails above, the code correctly ensures
forward progress: it uses next_end when that advances past
last_addr, otherwise falls back to PAGE_SIZE.

However in this second branch, when lock_vma_under_rcu() succeeds
but last_addr >= vma->vm_end, setting last_addr = vma->vm_end can
move the iterator backward. Since the condition guarantees
vma->vm_end <= last_addr, the assignment either keeps last_addr
the same or reduces it.

This can happen when a VMA is concurrently shrunk between the RCU
walk and the lock_vma_under_rcu() call:

  last_addr = 0x5000  (from prior iteration)
  RCU walk finds VMA [0x3000, 0x8000), next_addr = 0x3000
  VMA concurrently shrunk to [0x3000, 0x4000)
  lock_vma_under_rcu(mm, 0x3000) locks [0x3000, 0x4000)
  last_addr (0x5000) >= vm_end (0x4000)
  last_addr = 0x4000  -- moved backward

The backward movement causes the iterator to re-visit VMAs that
were already returned to the BPF program.

Could this use the same PAGE_SIZE advancement that the
lock_vma_under_rcu() failure path uses? For example:

  if (unlikely(data->last_addr >= vma->vm_end)) {
      data->last_addr += PAGE_SIZE;
      vma_end_read(vma);
      goto retry;
  }

This would maintain the forward progress guarantee described in
the commit message.

> +
> +	return vma;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22862450537
--===============4840168270955531071==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB363FAE14
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060375; cv=none; b=YV04qqDPiz73bXYUFb/tYJGwIZnrq/At2BFbeDxJTzpI4nZKARzt/iIOVex5APuC0F+Ur9DcaIFqh8xN7RBEh9eHkDXfwJneyASWn+VDDdPoaphkdXNBIWfnMozMZ6o11hiVeFGf5JZE6rWsqdMbHEqu/i9CcfTQ/Gxi7O5abxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060375; c=relaxed/simple;
	bh=bjH3G4oq0uDLCVqYA9UWdjUdpaYTE15P7PEWxWAnX2I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UkXVQK/r5/b6l4jL70sxS0YVwC2m+nbiYB1Vz2GjGCxqeLN8fk7YT49HXChe18yM6D0RiFstrguI1jiusTBAVORCQgH7fiz2shM/mgg+chaDhQ1mehCga4qIc+MjnNtgFjVmMFkcLqztRBjtZRuyi5cJQTiuYXT7JFw3ww3oH6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZiViD3x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZiViD3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53370C19425;
	Fri, 24 Apr 2026 19:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777060374;
	bh=bjH3G4oq0uDLCVqYA9UWdjUdpaYTE15P7PEWxWAnX2I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=OZiViD3xiTopEFmjDerq2pMjWiUnmDyHzkLFlIxwqOEeQY/FJBuDUFR5iljD781HG
	 OW9Sp3fSWwb2i+zuW0Cg7M+YzIBkH7ghIJ2nydXyeXT7KQTbILoSx3zbRqX4aHG+Dq
	 L8o6Zgo8cWgOJDV7i8CvPFZHTFYsJTv5qY2pQ+QLzRHnCAmXIrQs8tUStcqTO3KH3A
	 X53n23JZvSXqSCdIcKPyJWELCX2SYNMercH1Ft6kVSLo/sHAGgT5umzJdybMhmcTd5
	 GitTf6gy3FnUY5QVoyrfw7fIeZOL17wCQlTuCKWMBsoOS/+oWriwD+AZc+O+tF4J5R
	 cEtOMmcyE1Dqw==
Content-Type: multipart/mixed; boundary="===============7825488805449871253=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8f4147f1d88eb89492a6822f94e14daf6004ef78681b387c8c6ecc7a8bad1a8c@mail.kernel.org>
In-Reply-To: <20260424192252.695240-2-utilityemal77@gmail.com>
References: <20260424192252.695240-2-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Implement dtor for struct file BTF ID
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bpf@vger.kernel.org,mic@digikod.net,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 19:52:54 +0000 (UTC)

--===============7825488805449871253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index baa12b24bb64..4739e2bf0f31 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -20,6 +20,7 @@
>  #include <linux/proc_ns.h>
>  #include <linux/sched/task.h>
>  #include <linux/security.h>
> +#include <linux/fs.h>
>  #include <linux/btf_ids.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/kasan.h>
> @@ -2752,6 +2753,13 @@ __bpf_kfunc void bpf_task_release_dtor(void *p)
>  }
>  CFI_NOSEAL(bpf_task_release_dtor);
>
> +__bpf_kfunc void bpf_file_release_dtor(void *file)
> +{
> +	fput((struct file *)file);
> +}
> +
> +CFI_NOSEAL(bpf_file_release_dtor);

Is it safe to call fput() here? BPF programs can update or delete map
elements from NMI context (for example, in BPF_PROG_TYPE_PERF_EVENT
programs), which will synchronously invoke this destructor.

When fput() is called in an interrupt context and the refcount reaches 0,
it adds the file to the delayed_fput_list and calls schedule_delayed_work().
However, schedule_delayed_work() is not NMI-safe, as it attempts to acquire
spinlocks such as the workqueue pool lock and timer_base->lock.

If the NMI interrupted a context that already held one of these locks, won't
this result in a hard deadlock?

Multiple reviewers raised this concern in v1 and v2 of this patch series.
In response to v1, you acknowledged this as a "real bug / reproducible
deadlock" but stated it would be addressed separately as an "orthogonal
issue." However, v3 still uses the same unsafe fput() call without any
NMI-safe deferral mechanism (e.g., irq_work).

Reference: https://lore.kernel.org/bpf/20260421010536.17FB1C19425@smtp.kernel.org/

> +
>  #ifdef CONFIG_CGROUPS
>  /**
>   * bpf_cgroup_acquire - Acquire a reference to a cgroup. A cgroup acquired by

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24908056518
--===============7825488805449871253==--

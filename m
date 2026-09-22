Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FEB43DA5E;
	Tue, 22 Sep 2026 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084186; cv=none; b=CA+RqMYlwP27lD1jrnsoWR/o0MLS0fxcRIKjSaY9wyfg7cqX7FQ4/je2SzN5ueRPsx73bFTF2WiR9bHYYNCoaM6f1OuihmpppCinJLkJVHRVMkto/8ELBi7p19gAjofNR9s1Pm4mATB62LUs5KUTLX/7eSz/1h1oSAq2kyozoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084186; c=relaxed/simple;
	bh=43UXDfn7sNeHDV0sICdY354Wj6rQBtd1ihIgC87V9Pc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZcUFs2qKMb3IkTYq/3UeFTY5o02IKLFnmMzrDyfGeqOJlbjpXP9fpdlhO7UOA+PCDWd/BjGp4QT0DhptLVBdFSuYL8MjuxbtwWcLl6IFmbUi/Cr68Ni3f7SuiAmV2rO2eZx6Bh0SrzhZPfJPgkDoMfVZzm50kaXpIbk7xnWFFK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElCG8u7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElCG8u7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8DD1F000FF;
	Tue, 22 Sep 2026 13:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084185;
	bh=83iYiHkzkMkZMnSJ/zg/iyBsJXlsjdLVxUiYdFZ6Qdg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ElCG8u7nFecpheqE7toouV+plJ9108sDuJpjQrdfcILmtI8SM0tJWDNUGy4DSoqpN
	 MHLOL+y04K6ywuyeHMVMg/Uv0wN/NesmgrZjqTCMWbGPiIG1QNkJB7QDKhIaeIRiZf
	 hdzq8F7ZIbysbs5+z/1fIZGjH84TVVCNCXznGs3AeKsB5CI+D0fnSU4E59vOtV+BfW
	 rcg3LzN3X+I6EWGMVmJLBBa2S2jcn7jEGlyI6cEM5w83sMnxtujLSeB6xPMaLgWYkl
	 tRz/6szLvtrlU492bwaTDIA1F4VvyPmOmQICCVmWFjBCi0baBFkmvkHfIFF1GcBzhO
	 Ukj9fjMsm032g==
Content-Type: multipart/mixed; boundary="===============7247518973345400370=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f6e17da46b7895d19df3b379a6e879cd0ff237c50dc387127c87c6f48a48a7d1@mail.kernel.org>
In-Reply-To: <20260922121022.256777-1-jiayuan.chen@linux.dev>
References: <20260922121022.256777-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v2] bpf: cpumap: fix use-after-free of dev_rx on netdev unregister
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 13:36:22 +0000 (UTC)

--===============7247518973345400370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 5e59ab896f058..0c9647f28034d 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c

[ ... ]

> @@ -832,3 +879,39 @@ void __cpu_map_flush(struct list_head *flush_list)
>  		wake_up_process(bq->obj->kthread);
>  	}
>  }
> +
> +/* Frames in the ring and skbs in GRO hold a raw pointer to the ingress
> + * device, make every kthread consume them before the device is freed.
> + */
                                   ^^^

The BPF subsystem requires multi-line comments to have the opening /*
on its own line, with text starting on the next line. This is a newly
added comment. Should it be reformatted like this?

/*
 * Frames in the ring and skbs in GRO hold a raw pointer to the ingress
 * device, make every kthread consume them before the device is freed.
 */

> +static int cpu_map_netdev_event(struct notifier_block *nb,
> +				unsigned long event, void *ptr)
> +{
> +	struct bpf_cpu_map_entry *rcpu;
> +
> +	if (event != NETDEV_UNREGISTER)
> +		return NOTIFY_OK;
> +
> +	mutex_lock(&cpu_map_mutex);
> +	list_for_each_entry(rcpu, &cpu_map_list, list) {
> +		/* the whole ring, plus a batch already pulled out */
> +		WRITE_ONCE(rcpu->drain_left, rcpu->queue->size + CPUMAP_BATCH);
> +		wake_up_process(rcpu->kthread);
> +	}
> +	list_for_each_entry(rcpu, &cpu_map_list, list)
> +		wait_event(rcpu->drain_wq, !READ_ONCE(rcpu->drain_left));
> +	mutex_unlock(&cpu_map_mutex);
> +
> +	return NOTIFY_OK;
> +}

NETDEV_UNREGISTER notifiers run with RTNL held:
call_netdevice_notifiers_info() contains ASSERT_RTNL(), and the call
site in unregister_netdevice_many_notify() also does ASSERT_RTNL() at
entry.

The wait_event() holds RTNL until every cpumap kthread in the system
has consumed rcpu->queue->size + CPUMAP_BATCH frames. The ring size is
bounded only by the 16384 sanity limit in cpu_map_update_elem(), and
the countdown is decremented by frames actually consumed, so a ring
that is continuously fed by a different, still-registered device forces
the full 16392-frame count to be pushed through before returning.

unregister_netdevice_many_notify() calls the notifier once per device
in the batch, so a batched teardown such as netns exit with many veths
multiplies this: N devices x 16392 frames of RTNL-held work,
serialized.

The commit message addresses the bound ("The work is bounded by the
ring size, and the frames had to be consumed anyway") but not the fact
that RTNL is held for the whole drain. Also, the "frames had to be
consumed anyway" statement is only true for frames already queued - the
size+BATCH countdown can force consumption of many newly produced
frames belonging to unrelated devices.

This is not a deadlock (the drain is bounded and the kthread cannot
block indefinitely since its work runs under local_bh_disable()), but
could this cause latency or stall issues on systems with many devices
or large ring sizes?

[ ... ]

> -    Fixes: 9c270af37bb6 ("bpf: XDP_REDIRECT enable use of cpumap")
> +    Fixes: 70280ed91cb8 ("bpf: cpumap convert to use generic xdp_frame")
>      Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

The Fixes tag points to commit 9c270af37bb6 ("bpf: XDP_REDIRECT enable
use of cpumap"), but is this the right commit?

That commit (October 2017) introduced the cpu_map_enqueue() function
signature but did not store dev_rx anywhere - it used data_hard_start
as a void pointer with a comment saying "Followup patch will generalize
this".

The actual storage of the device pointer without a reference
(xdpf->dev_rx = dev_rx;) was added 6 months later in commit
70280ed91cb8 ("bpf: cpumap convert to use generic xdp_frame", April
2018) when the code was converted to use the generic xdp_frame
structure. This is where the use-after-free bug was introduced.

Should the Fixes tag be:

  Fixes: 70280ed91cb8 ("bpf: cpumap convert to use generic xdp_frame")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35727192473
--===============7247518973345400370==--

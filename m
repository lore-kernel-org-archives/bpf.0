Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89651E260C
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999525; cv=none; b=bXDFKdFVQeXAYZH8jfSF5zXXUokydX1QnNlklZkOvCQZTJRG7AEcd5OrI4buB3PPmoDot8fyAiNmSAFB3fTQ+VCw1M1c0za94Y1guj1g5cyfHVyGwc1dBDtRhILbHCh/EkrjS98gWbasWMazH6CH27JxgSDp74WnNfBMayJ2akg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999525; c=relaxed/simple;
	bh=jaNioM4Duopm7wQPClnumqpTmanSpEh1XvdORXG/kWM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oUUceA0t7C/pNgFRn/b2/WptDK9CxYlKCQCifdeNiT8Glb1pv5sxVH5jjRAyWfcFWVQLhOEfb6IGI6pWFWVjWlvPn8izeJBP2qXJmiBOtcgimHz4/woE0ABbzfMzri7yqHmZ9+yWHE6j4bjQZ4uQEcTtvjZOBELySLSGfJZ+Mdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyrMsbGD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyrMsbGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ACE1F00893;
	Tue,  9 Jun 2026 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780999524;
	bh=x6X9YhyCGygenY9RGMxpNMYs3nuEa8uBLoHWhXtlx6c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SyrMsbGDRFXM1XMgwOSJiPqx6mypJnJ4DThUHwJVbqcYqh1B17Y7uUE1MqlV2BB9U
	 3qrS/Z/uI/ANh6OeuaP5DkUIJp+IqctCNAZcrsXoHvrpu1mAcFuGNdl+wWOtEUAdqQ
	 1fiVhdzH5X5cvwjbrp9vR/Lkjav4mTx8S/v5BA8Q4KcCLKS/3ARljQc8YK9B2GKMpB
	 y5JkdWZgM/eN05mPeMvnkFXuNErVeXQxl1goD0OAMFcPYkqoWVnt+GzCa4HjY1FNG7
	 0P0EAgPd1izLenufnisPJ2HVkxwPOPvuTx09xwRQpRCLGb8ymzyvBFlJ9Yy1PTTpan
	 TtLGOlGNCC0LQ==
Content-Type: multipart/mixed; boundary="===============2522026566685583619=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <57de2c7627d38482f75a18b79b3556d45225da3eb307343d04ce47cfbe154e33@mail.kernel.org>
In-Reply-To: <20260609093719.2858096-2-memxor@gmail.com>
References: <20260609093719.2858096-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Reject bpf_obj_drop() from tracing progs
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  9 Jun 2026 10:05:23 +0000 (UTC)

--===============2522026566685583619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 62bba7a4876f..0654d2ffadc1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -492,6 +492,35 @@ static inline bool btf_record_has_field(const struct btf_record *rec, enum btf_f
>  	return rec->field_mask & type;
>  }
>
> +static inline bool btf_field_is_nmi_safe(enum btf_field_type type)
> +{
> +	switch (type) {
> +	case BPF_SPIN_LOCK:
> +	case BPF_RES_SPIN_LOCK:
> +	case BPF_TIMER:
> +	case BPF_WORKQUEUE:

Can the BPF_TIMER and BPF_WORKQUEUE cases really be treated as NMI safe
here?

Dropping an object with one of these fields runs through
bpf_timer_cancel_and_free() or bpf_wq_cancel_and_free(), which calls
bpf_prog_put() synchronously via bpf_async_update_prog_callback().

If that drops the last reference to the program in NMI context,
__bpf_prog_put() falls back to schedule_work() because irqs are disabled:

    schedule_work()
      -> queue_work_on()
        -> raw spin lock on the workqueue pool

Can this hard deadlock if the NMI interrupted a thread that was already
holding that workqueue pool lock?

BPF_TASK_WORK defers its destruction via irq_work_queue() when
irqs_disabled(), but BPF_TIMER and BPF_WORKQUEUE do not appear to take
that path, so they do not look NMI safe in the same way.

This was raised as a high-severity concern on v1 of this series by the
Sashiko AI review:

  https://lore.kernel.org/bpf/20260608154008.27E011F00893@smtp.kernel.org

The v2 respin left btf_field_is_nmi_safe() unchanged, still listing
BPF_TIMER and BPF_WORKQUEUE, so this may still be unaddressed.

> +	case BPF_TASK_WORK:
> +	case BPF_KPTR_UNREF:
> +	case BPF_REFCOUNT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27197841616
--===============2522026566685583619==--

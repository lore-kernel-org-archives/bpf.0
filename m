Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97968372B24
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781038703; cv=none; b=WSzdN9Glc7jEfNWkM62YzrWCWSnKdoxiU6m11dD3gFlbydF24QDWy4zUqGv221QB/l6h2ttitlwfJLH3ZabS5Yweu5gjeqmPUYFppiSEiCnBhIiCvJSfx8acdnYIbHxAte7QphWtfOuR32DAx81Zt3OTuRMii9vbp8UykD69WDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781038703; c=relaxed/simple;
	bh=hyOFsXdUVhUcL87be7MzZtwg+ol62jQs0ssG8nMwEZ4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iDLrz8JswHga3LaHgCN2k/jcaxtaV7ZR4qUdwAODQzDNJYKtFIXyA0+tugI5o8RyRX6/r2lGEnGZ1aoJwaKaCu5wjp//3/XvTJg1ZCcMMbiJ6fBnrYERo0QLh6UyO5LVxFmDvpg5YI1UdkWUW8GPd1RSk+1IuOWWQMOhgYNByu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iR3GVy+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iR3GVy+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11001F00893;
	Tue,  9 Jun 2026 20:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781038702;
	bh=iXmPJhyp3x1BdK0j3PvYgLgVmyHL1/MXW+PSEpzQXkY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iR3GVy+FqxKnngOFrMVrNeCcfDN33rA24geESIEp1K4yw/Sj+TdWOiluGpPPa9jHp
	 WX6ZqeWPHEQk9RP63CjFqf0lXK1G8qYEdKdUsApkpWFzMtuBVQDVK0aGWzmSy7tCV+
	 4cFwavMI6KmtvyMcioxpXilhl+3LtYBEyKKrpp97jN+MBb6BlfYdP1avGHHvu3QsBW
	 EbwFxl2uIVyl+hD63ctLyYfFhCIgMoWiTBpa65tI6SgoSt2JqKvG2eb0JOxyrBvSpU
	 LOYV7Ifgimq54g4AcwMla/fzB7lwZwzS15vptG/AoH+SUK92c18u52ebXxXmB8xWyL
	 Gb3siET0RztZw==
Content-Type: multipart/mixed; boundary="===============3685913275376362949=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7a1365f68163df1f81f1f1e367013e6ac89132b2b687d072a8a7a54c6c1026c0@mail.kernel.org>
In-Reply-To: <20260609202548.3571690-2-memxor@gmail.com>
References: <20260609202548.3571690-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Reject bpf_obj_drop() from tracing progs
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  9 Jun 2026 20:58:21 +0000 (UTC)

--===============3685913275376362949==
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
> +	case BPF_TASK_WORK:
> +	case BPF_KPTR_UNREF:
> +	case BPF_REFCOUNT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

Is it safe to include BPF_TIMER and BPF_WORKQUEUE in this NMI-safe
whitelist? Looking at the cleanup paths, dropping an object with these
fields calls bpf_timer_cancel_and_free() or bpf_wq_cancel_and_free(),
which synchronously invoke bpf_prog_put() via
bpf_async_update_prog_callback():

kernel/bpf/helpers.c:bpf_async_update_prog_callback()
    bpf_prog_put()
        __bpf_prog_put()
            schedule_work()

If this drops the last reference to the BPF program while in NMI context,
__bpf_prog_put() falls back to schedule_work() since irqs are disabled.
Since schedule_work() takes a raw spin lock on the workqueue pool, couldn't
this hard deadlock if the NMI interrupted another thread that was already
holding the workqueue pool lock?

BPF_TASK_WORK safely defers via irq_work_queue(), but these fields do not
appear to have the same protection.

This concern was raised by sashiko-bot in v1:
https://lore.kernel.org/bpf/20260608154008.27E011F00893@smtp.kernel.org/

Would it be safer to exclude BPF_TIMER and BPF_WORKQUEUE from the
NMI-safe whitelist?

> +
> +static inline bool btf_record_has_nmi_unsafe_fields(const struct btf_record *rec)
> +{
> +	int i;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return false;
> +	for (i = 0; i < rec->cnt; i++) {
> +		if (!btf_field_is_nmi_safe(rec->fields[i].type))
> +			return true;
> +	}
> +	return false;
> +}

This isn't a bug, but these helper functions were suggested to be moved
from the header file into verifier.c since they are only used there:
https://lore.kernel.org/bpf/6461e40c-d5a9-41a5-aaba-bf063de67d3f@gmail.com/

Is there a reason to keep them in the header?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27234422852
--===============3685913275376362949==--

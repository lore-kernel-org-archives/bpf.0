Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513D31B824
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933209; cv=none; b=AuBUwEHdmIfLvBpUBRdTgr5d9YDnyrF51ZoAyW2azAqYRV5rH6P+2YGxrew/lN8S6yHYeU1f7JlsmF/U2kCAa0+7Xsi5/ypzWxfgWgcAHjUgL5Wd1tHqpIxRjqejhlAqjuWlmAnEDLnqV1IafzXUWYfcrsy1peTWh41uHP5bbR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933209; c=relaxed/simple;
	bh=FkvF3mbkjfiW7CKANbeF6JmBwxGZ/+51vBSjHFyxdHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HUzaH10feuZ7Uwkt89wcEEKs7w8IO0lf8cFUVFGGJ2MFBZ8dIjR3S/doMIr574VDKrugsRY6wydOL4i2pCDHV9LOBwSddxFWom0/O8mlWBeqvi1t7t+xb8nXfdPpOOOpoO3D/NXgRW5PrceMBnt+dJqKhhE7j6MNhVrwyUl7PeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMah+VO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMah+VO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E011F00893;
	Mon,  8 Jun 2026 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780933208;
	bh=bV2Wn13qXSoUF4LeGxQpijy13gpVXBh6Q2peXdZmlno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMah+VO2HSs038d0hpyGG0fJodVGzuakap9zPpgooTGNGdvMrG5K7o32SZsXbbxhE
	 i/CowjQvsPD8icZTYlQipu3xnw19kF2Ec0vVmJ9L5yUYJDFkGPMqU/LBOvZDe6w0MT
	 UGmNMdFhlSQspSxtQa9H94e9tb1yxEYcwRkzZCTnTabfAkkdTozCOGxzHMfU26dqX/
	 WGjYYZacrJoeCbnBUTXKyUCk2PtI8X9BuZZCRxs2AvSJE1wj/H/jwgPEDvE0SnneEB
	 J920gXV/9QqoH4JswynLExHg78QAlvX2KV+vlVzaCNKhhr0zF+Am1A0XfPu2sGcSsG
	 X8jcoh+XyqZ5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/5] bpf: Reject bpf_obj_drop() from tracing
 progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608144841.1732406-3-memxor@gmail.com>
References: <20260608144841.1732406-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:40:07 +0000
Message-Id: <20260608154008.27E011F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] BPF_TIMER and BPF_WORKQUEUE fields are incorrectly whitelisted as =
NMI-safe, causing a deadlock when bpf_obj_drop() is called from NMI context.
--

commit 3287c13e44b513ce0d9b41e4aa24cd264b519b04
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Reject bpf_obj_drop() from tracing progs

This commit restricts bpf_obj_drop() and bpf_percpu_obj_drop() in tracing
programs to only allow objects whose fields are explicitly whitelisted as
NMI-safe. It replaces the previous blacklist approach with a whitelist to
better handle future field types.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -492,6 +492,35 @@ static inline bool btf_record_has_field(const struct=
 btf_record *rec, enum btf_f
>  	return rec->field_mask & type;
>  }
> =20
> +static inline bool btf_field_is_nmi_safe(enum btf_field_type type)
> +{
> +	switch (type) {
> +	case BPF_SPIN_LOCK:
> +	case BPF_RES_SPIN_LOCK:
> +	case BPF_TIMER:
> +	case BPF_WORKQUEUE:

[Severity: High]
This is a pre-existing issue, but is it safe to include BPF_TIMER and
BPF_WORKQUEUE in this NMI-safe whitelist?

Dropping an object with these fields calls bpf_timer_cancel_and_free() or
bpf_wq_cancel_and_free(), which synchronously invokes bpf_prog_put() via
bpf_async_update_prog_callback():

kernel/bpf/helpers.c:bpf_async_cancel_and_free() {
    ...
    bpf_async_update_prog_callback(cb, NULL, NULL);
    ...
}

If this drops the last reference to the BPF program while in NMI context,
__bpf_prog_put() falls back to schedule_work() since irqs are disabled:

kernel/bpf/syscall.c:__bpf_prog_put() {
    if (in_hardirq() || irqs_disabled()) {
        INIT_WORK(&aux->work, bpf_prog_put_deferred);
        schedule_work(&aux->work);
    } else {
        ...
}

Since schedule_work() takes a raw spin lock on the workqueue pool, couldn't
this hard deadlock if the NMI interrupted another thread that was already
holding the workqueue pool lock?

Unlike BPF_TASK_WORK, which safely defers destruction via irq_work_queue
when irqs_disabled(), these fields do not appear to be NMI-safe.

> +	case BPF_TASK_WORK:
> +	case BPF_KPTR_UNREF:
> +	case BPF_REFCOUNT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144841.1732=
406-1-memxor@gmail.com?part=3D2

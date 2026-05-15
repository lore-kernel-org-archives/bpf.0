Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345873EEAF9
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869510; cv=none; b=MLLfO+OKYOP2Rny+jy3TFEsCIouXSMthcxP4f6/hfUeQQF+nxA2mgAKrd2iwpUu/T+AkRIXuyP2Q/CyiZJmRS4aLtj7JgruS6/3LUXdHooOmHDMzxlnrUHZGQG0oIOu6Dn4tmbFLSYTK1GHDUAIdLDb0pkZ/ggLpdAfpnFTM0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869510; c=relaxed/simple;
	bh=nz3xozvp2rBHN1PjKGlnasO+PycQX7BliV+pJHppGzs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=siNrqEeZvbPaHcAVjYhYO9OLBpIA9jvXP2naJDp4gBBc/pRrUNKhNPFEc5RBUJKGpOR28ji009+vZj54/lITqo7QpMB9V07VqlCckULSHlmCxIL1YFDbOzIzZVYUSDElBLLW5DxDQGD5BzU28sxCYJCODh4aitnqYXs0zAwfz4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyeEjQ5Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyeEjQ5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08E7C2BCC7;
	Fri, 15 May 2026 18:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778869509;
	bh=nz3xozvp2rBHN1PjKGlnasO+PycQX7BliV+pJHppGzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qyeEjQ5Z2SN9iMoiIbMWTnuOq3cSCpIMRjv48njIILIaZUIuWQypT0RdPdJzyMUqu
	 NTOJae1tdhcx3B3D3SZ5SwTcASWNKEoaV2JVaFiV4mXqsquamehQvYqpAWV/uaOeOF
	 EToZGdhCOW0SL5Wbl5z3AAEvMvTP0QSfxbap2334uTV7+ARR6wzx36yBL2IWdBqtWO
	 ixz8jPr25p8zCsZ+0PNHoP8R7/IzrjYF4XKUVlRRuCGQ2AT9BIbXhpqLGLMOmvvRui
	 Gb3bjBEYoOt81pa9TEbDMdCJYclvV1xYk2lpxPLGnxODsrWt3x/Hz2B+7WsIdQf1fD
	 Cxk5kRUT3c9mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/3] tracing: Expose tracepoint BTF ids via
 tracefs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515-generic_tracepoint-v1-2-aa619fa94132@meta.com>
References: <20260515-generic_tracepoint-v1-2-aa619fa94132@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 18:25:09 +0000
Message-Id: <20260515182509.A08E7C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The global `event_mutex` is held across a `copy_to_user()` operati=
on, creating a denial-of-service vulnerability and latency spikes.
--

commit 5bcf593e0ef00b79b0e87af32e5fdb4e5481d768
Author: Mykyta Yatsenko <yatsenko@meta.com>

tracing: Expose tracepoint BTF ids via tracefs

This commit introduces a new tracefs file btf_ids for each event. It exposes
the BTF object ID and tracepoint/raw BTF IDs populated by resolve_btfids at
link time to allow raw_tp and tp_btf BPF programs to properly attach.

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index c46e623e7e0de..d463fb44c790a 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c

[ ... ]

> @@ -2200,6 +2201,62 @@ event_id_read(struct file *filp, char __user *ubuf=
, size_t cnt, loff_t *ppos)
>  }
>  #endif
> =20
> +#ifdef CONFIG_BPF_EVENTS
> +static ssize_t
> +event_btf_ids_read(struct file *filp, char __user *ubuf, size_t cnt, lof=
f_t *ppos)
> +{
> +	struct trace_event_file *file;
> +	struct trace_event_call *call;
> +	const struct btf_type *t;
> +	struct module *mod =3D NULL;
> +	u32 raw_id, tp_id;
> +	const u32 *ids;
> +	struct btf *btf;
> +	char buf[128];
> +	int len;
> +
> +	/* Module unload could free call->class and ids[] mid-read. */
> +	guard(mutex)(&event_mutex);
> +
> +	file =3D event_file_file(filp);
> +	if (!file)
> +		return -ENODEV;

[ ... ]

> +	len =3D scnprintf(buf, sizeof(buf),
> +			"btf_obj_id: %u\nraw_btf_id: %u\ntp_btf_id: %u\n",
> +			btf_obj_id(btf), raw_id, tp_id);
> +	btf_put(btf);
> +
> +	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);

Does this hold the global event_mutex during copy_to_user()?

Because guard(mutex)(&event_mutex) holds the lock until the function return=
s,
the mutex remains locked during simple_read_from_buffer(), which internally
calls copy_to_user().

Could this allow a user to intentionally stall the global tracing subsystem?

If the user-space buffer is backed by userfaultfd or a slow FUSE mount, the
page fault could block indefinitely while holding event_mutex, which protec=
ts
system-wide tracing operations (including module loading and unloading).

Looking at event_filter_read() nearby, it explicitly releases event_mutex
before calling simple_read_from_buffer(). Would it be safer to use a similar
pattern here by dropping the lock once the buffer string is populated?

> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515-generic_tr=
acepoint-v1-0-aa619fa94132@meta.com?part=3D2

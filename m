Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958973A9DB1
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915173; cv=none; b=CfMYSiOT8YAlEs7av4WXiyzOHuWw6xHQ4MsbUVm3IKR4mwheG/KNSyOaGH01MwKijum3FjjncpcdIEohIfl8EM739+EO4bkZyhD640siVUe0UgKfEq8A1ivUF00FmsCvsFhZKHOxXIzeT2JrT5X0DpbtyPtqxT0wEF7z0gG7JHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915173; c=relaxed/simple;
	bh=Zi34qjoASjdNDJ33Wp/QHhz36chYSKpA38fL8Z00Itg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CHV+uCJC4v89R29m8NGwqMSHID7DHXl9foAA6nRG8Vvg5+/X22oUDcs7wN7WLaTI6HyqK9k7dfctKnFQVq1xne8vTk1kgPVDMBGlOg0jwv6faZB7K7A/7FhEuQI6CHNDVyhvf4uW+3joXIXj8NG8HPeNsCM4V9oCQRB0pucuRqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKuRphb3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKuRphb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D861F0089A;
	Sun, 20 Sep 2026 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789915169;
	bh=8UU/nUqPaeVmcAiEYDbOzAtRlxyi97b+M6+OFxMp7Po=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SKuRphb3g0GmgLu8VPhDGKLBWfSrM4CDtf/KpNMUtDJxJb4a6UCrBo5sodsyw09UF
	 oaQS+wMvqTGIITFMBc3+tMuiUEotH6K4ATpIsuOCl//hEO9ITU5SS37HWQo/qoG/8D
	 E2gze4w75ROqV++8yOf3kRKGZK/iByJ5+dilypug+xjGJyPiLC2W9QPBpfWxcII2wu
	 PVLvCguAxmKLKxSfWEOLMu03xOqNCEYtHj0ywDr8JvxZO72I9nMojN4v+LgWY7itPB
	 lCuZqTzy6K/jQ4mRh5GTT5E5GKIXDrQgF88sPML3Di/4p540bGgUk05GuNUZlcyuEe
	 J0iedzrGK03tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next 2/9] bpf: add bpf_ktime_get_real_ns() kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260919143732.11772-3-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
 <20260919143732.11772-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 14:39:29 +0000
Message-Id: <20260920143929.72D861F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: bpf_ktime_get_real_ns() causes hard lockup in NMI context
--

commit 5767d1a435f8b04a603eb9c7fef3df289f64be7b
Author: Jason Xing <kerneljasonxing@gmail.com>

bpf: add bpf_ktime_get_real_ns() kfunc

Introduce a new BPF kfunc bpf_ktime_get_real_ns() that returns the
current CLOCK_REALTIME time.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b3cc5c8fc8756..7a0db620a2730 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2335,6 +2335,11 @@ void bpf_rb_root_free(const struct btf_field *fiel=
d, void *rb_root,
> =20
>  __bpf_kfunc_start_defs();
> =20
> +__bpf_kfunc u64 bpf_ktime_get_real_ns(void)
> +{
> +	return ktime_to_ns(ktime_get_real());

[Severity: High]
Can this cause a hard lockup if called from NMI context?

The ktime_get_real() function uses read_seqcount_begin(&tk_core.seq)
internally to read the time. If a BPF program running in NMI context (such =
as
a perf event or kprobe) calls bpf_ktime_get_real_ns() while the CPU happened
to interrupt a timekeeper update like do_settimeofday64, the seqcount will =
be
odd. The reader will execute a busy-wait loop indefinitely because the
preempted writer can never complete.

Could this be made NMI-safe by using the latch-based fast timekeeper API
ktime_get_real_fast_ns(), analogous to how bpf_ktime_get_ns() uses
ktime_get_mono_fast_ns()?

> +}
> +
>  /**
>   * bpf_obj_new() - allocate an object described by program BTF
>   * @local_type_id__k: type ID in program BTF

[ ... ]

> @@ -4972,6 +4977,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, K=
F_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_file)
>  BTF_ID_FLAGS(func, bpf_dynptr_file_discard, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_timer_cancel_async)
> +BTF_ID_FLAGS(func, bpf_ktime_get_real_ns)

[Severity: High]
Does registering this kfunc in the common_btf_ids set (BPF_PROG_TYPE_UNSPEC)
expose it to NMI-context BPF programs, leading to the potential lockup
described above?

>  BTF_KFUNCS_END(common_btf_ids)
> =20
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919143732.1177=
2-1-kerneljasonxing@gmail.com?part=3D2

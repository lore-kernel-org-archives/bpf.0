Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2710539F165;
	Tue,  1 Sep 2026 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232962; cv=none; b=dfv+XMwTigtmwXdei/gTsx/M41lq8eY78pBwQ9fAxJ00zs76nZSrZibaOnu3SqstqaJLEFSniMtVUJO+l8r8STgFNIu7MXXHcJck/jzopIh96vgFRmn1FF41B+9Cjg6RKZ2zyFPMLUOJCOvX6Bz72hOITCCBSRcxwL2TawW7Qgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232962; c=relaxed/simple;
	bh=uUuLFTrbgfJ406U75DTXYKVrNpwzrXtWeKIHPTrVbg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FUyQTp4JKEret8jKYmHvaUYnqwe6n6b4z7ivzyslXvhfebS3q1G+cZNvee/V5PWq2yGpWHTk9JPgxG13Adk7Sn4IhDxxvBuMzVgjuIZshVqA7hTj9kDeSiTwFZHpowqjSKHodSeCme++MlZFXn+L/Raee51YTJqLXkLSh9yRM/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKdWwnzP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKdWwnzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929AA1F000E9;
	Tue,  1 Sep 2026 03:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788232960;
	bh=posf1Vg6Q8J/1J624lxdJx/BvbrX4NmQPgwuVl+2Ts4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bKdWwnzPzgNZ4smE4jn9fuEy7G19/o18BF1521yBQTArbAFfAg9HqbN1PJ24ErHoW
	 b2AauLY4L2WeLClaVBfKYKKMpiiHx3iLR0ktxwBvtCk7sZ+F07Hyvpe42kFCsdp7pf
	 N4lL8gY9RIGiYfoTJcr4LELzOnFZdRQnYvVbuW8EUNcvObCjgziO4Q2I0Rrx/fBr8m
	 eE8zLQlytQQ+a7ai2ies0XbVq+mkX1GAkKcmRPozcHcmnZRvAXSxNpccqbtI3n2VhO
	 +r67Pp01yInRiA6cHFChoRF8ssASRkyw3wu0Q6IM6ZEBljEsME6D+uzAz2eU7Nz2+e
	 SBS2oGx5bAeMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: don't deliver duplicate
 ops.cgroup_set_idle() for same value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260901031101.731943-1-cui.tao@linux.dev>
References: <20260901031101.731943-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 03:22:40 +0000
Message-Id: <20260901032240.929AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch references a non-existent struct member `tg->scx.sched_id=
le`, which causes a build failure.
--

commit b3dc4baced455427fac828517318398556404ffa
Author: Tao Cui <cuitao@kylinos.cn>

sched_ext: don't deliver duplicate ops.cgroup_set_idle() for same value

This commit modifies scx_group_set_idle() to prevent delivering duplicate
cgroup transition callbacks to the BPF scheduler. It checks if the new idle
value differs from the existing value before invoking the callback.

Link: https://lore.kernel.org/r/b53c61a1-4d7d-4232-941f-d48b0563d4ed

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index c539d15cda637..c72d9780830b8 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4930,7 +4930,8 @@ void scx_group_set_idle(struct task_group *tg, bool=
 idle)
>  	percpu_down_read(&scx_cgroup_ops_rwsem);
>  	sch =3D scx_tg_knob_sched(tg);
> =20
> -	if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_idle))
> +	if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_idle) &&
> +	    tg->scx.sched_idle !=3D idle)

[Severity: Low]
Does this code build successfully when CONFIG_EXT_GROUP_SCHED is enabled?
It appears tg->scx.sched_idle is referencing a non-existent member in
struct scx_task_group.

Looking at include/linux/sched/ext.h, the scx_task_group struct defines
the field simply as idle:

struct scx_task_group {
    ...
    bool idle;
    ...
};

Should this condition check tg->scx.idle !=3D idle instead?

>  		SCX_CALL_OP(sch, cgroup_set_idle, NULL, tg_cgrp(tg), idle);
> =20
>  	/* Update the task group's idle state */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901031101.7319=
43-1-cui.tao@linux.dev?part=3D1

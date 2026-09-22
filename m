Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A328337A493;
	Tue, 22 Sep 2026 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043331; cv=none; b=n9Jp9yrW9n9l8uEQfSpe04jcMI5jM5fjgu0kaoWtajPCqVajk/RLA1BgkHFWeNN90iG7t2DFyr3SEzz5HYw/phPaMhwuuE36ub3p84QodlfGmqi6Cxw32i3V8F24qozDFqoGDnU3TNGUsd8UqPFrW/ulgQzZlNI4Z7bKRlwXpYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043331; c=relaxed/simple;
	bh=upAmf7O340LggVwD9B/khjrfXTIQE89XLpGNVVnBCE0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=I0SPz7/RTd5qDbYuAdqc/NlsgyTFFcD9q4IjllBrPRBXkoRf3ciUBcbSk9/erIB8+naIzI5zteLQvggETPd08NnzkPKxbYyxOtlYcA9O4bQTboC04xyXDaN1hZvIPcIMNTB1J7a/TQIefv9Mr/XmoPfWdavTc1dULoPPOs7BDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0ogEMs2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0ogEMs2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91CC1F000FF;
	Tue, 22 Sep 2026 02:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790043330;
	bh=JZJuwIbYXbTVm20ZJPRd0Ya8OsuYiYtiR7JJkaR0h50=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=f0ogEMs2n0Er94M4gC1pq94XxsBFWtTNBGlioqXZE1SA/XmhHdW7xBmEW780M45xv
	 cBrSlFvEHIt0RkoT6JmX4s0AuWlTB0V9r+/bmELfA/VxLEnu++CNCoJrjbW5mH58yb
	 vUA700350sQOMruXYpjhaYkXqBy+8PBnOmZgzWBy9XbTM/5XD5UjN8fs6sNwx3hEVo
	 uDKMF+eTrQUA1K2OATCjGm86Axd2EllawzyDfyjwfnbHWO6Mzxb3/aU8T3gOHumKut
	 RcOhmrLuKlTeIU0mpIYHUOgwmwyIev2HoluVGF+pMBS5Gn3fGr3uu4xB19ECkFRqf8
	 gXoiwPDgaXZjw==
Content-Type: multipart/mixed; boundary="===============1972334872518367697=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <03d6f574722589dc54b917ece6a488e1f3c2ee836e1b1aaeca523e58506d8d8e@mail.kernel.org>
In-Reply-To: <20260921185943.4031480-3-usama.arif@linux.dev>
References: <20260921185943.4031480-3-usama.arif@linux.dev>
Subject: Re: [PATCH 2/2] sched_ext: Specialize the scheduler hashtable compare
From: bot+bpf-ci@kernel.org
To: usama.arif@linux.dev,arighi@nvidia.com,bpf@vger.kernel.org,bsegall@google.com,changwoo@igalia.com,dietmar.eggemann@arm.com,etsal@meta.com,juri.lelli@redhat.com,kprateek.nayak@amd.com,linux-kernel@vger.kernel.org,mgorman@suse.de,mingo@redhat.com,peterz@infradead.org,rostedt@goodmis.org,sched-ext@lists.linux.dev,tj@kernel.org,vincent.guittot@linaro.org,void@manifault.com,vschneid@redhat.com,yphbchou0911@gmail.com
Cc: usama.arif@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 02:15:27 +0000 (UTC)

--===============1972334872518367697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 124bf827791ed..705a937268505 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -41,10 +41,21 @@ struct scx_sched __rcu *scx_root;
>  LIST_HEAD(scx_sched_all);
>
>  #ifdef CONFIG_EXT_SUB_SCHED
> +static __always_inline int scx_sched_cmpfn(struct rhashtable_compare_arg *arg,
> +					   const void *ptr)
> +{
> +	const struct scx_sched *sch = ptr;
> +
> +	BUILD_BUG_ON(sizeof_field(struct scx_sched, ops.sub_cgroup_id) != sizeof(u64));
> +
> +	return sch->ops.sub_cgroup_id != *(const u64 *)arg->key;
> +}
> +

This isn't a bug, but scx_sched_cmpfn() and scx_tid_cmpfn() (added in
the preceding patch, twenty lines below in this file) differ only in the
container type and field -- would a small generator macro be worth it
here, or is spelling both out clearer at two instances?

>  const struct rhashtable_params scx_sched_hash_params = {
>  	.key_len		= sizeof_field(struct scx_sched, ops.sub_cgroup_id),
>  	.key_offset		= offsetof(struct scx_sched, ops.sub_cgroup_id),
>  	.head_offset		= offsetof(struct scx_sched, hash_node),
> +	.obj_cmpfn		= scx_sched_cmpfn,
>  	.insecure_elasticity	= true,	/* inserted under scx_sched_lock */
>  };


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35676595280
--===============1972334872518367697==--

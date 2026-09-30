Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E85738C2A0
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755885; cv=none; b=BL6BlN/IhaIaBEzyIbUzimUuDrWM7m8SYQpjiKwDHKrh2/FK5IRJs5PQKmRBsyuk4WvBALZdz/GAdARtpZVr1IrzE+5n+TVH5ECAuShcjmELfrr/msvmmz3tPIYYcbJls5fCSC3RDk9J917zQd4zEG8OgWOWHUd6y5ncbfouwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755885; c=relaxed/simple;
	bh=MYRxGFC2RhdduN6KAuZ/Y5v0rsZSkDQCpDjyOiUmjEA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lxUDvklSQOporIyOmM77ysGloxqtYIcn9fFLvyMqhkRD45F3/Bn/Fed5PfjigYyF6anFw50b93lcQ59jDTyGLB0OCwGFWYwFi3Xj7y84z8STrL5hFEyIhf2ea3B3hdKnIDEuAxWoPpVdAAiJEommE0Xi0pUrEtLRMSyak7Xtadc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzlgE9RP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzlgE9RP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDA91F00893;
	Wed, 30 Sep 2026 08:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790755883;
	bh=VUBgNVlJdDCksmlXhjpOvPDSpCQAomdG3W9CExQ816A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JzlgE9RPSbqez10YlSvfOZkcAFpKulHSJtU/sfJ7doiK7eKfWYAXGnxUOsr47Jbgj
	 As/SYqBk9aXWcMWvYcr/QJoa8A7nQmL8c7NjK9CDph4gClqCOizrib/3Dmk5FZergi
	 RcN2fy7g924NqDLt+XIMB7VhrzdEE+7BMWJieGNhmTpBeLD2SsMnpv/DY5uI5L2zjD
	 PrY+MXH5/44WX7P02dkiUgnB7b/rkE20b0xtbiWwoqdZMXnPomtPZTSU/HWTQSZosF
	 4Whh5qnz1keFNjr5oMt+nBZeyMOxdBThHHQiGTx3xI3e7kyET4NErYmALMJyIfQBmI
	 3WbV79vbffajg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v8 1/4] blk-iocost: add BPF struct_ops cost model
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: mkoutny@suse.com, tj@kernel.org, bpf@vger.kernel.org, hannes@cmpxchg.org
In-Reply-To: <20260930075154.189958-2-cui.tao@linux.dev>
References: <20260930075154.189958-1-cui.tao@linux.dev>
 <20260930075154.189958-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 08:11:23 +0000
Message-Id: <20260930081123.8CDA91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] block: Use-After-Free in q_to_ioc() list traversal due to dropped =
rq_qos_mutex
--

commit 18772c6b40ac8eb626b52af0f79d379ddd873095
Author: Tao Cui <cui.tao@linux.dev>

blk-iocost: add BPF struct_ops cost model support

This commit adds BPF struct_ops support to blk-iocost, allowing a BPF
program to fully replace the builtin linear cost model for a device.
It registers the iocost_model_ops struct_ops type and binds the custom
cost model to the target device's block cgroup paths.

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3584,6 +3584,204 @@ static int ioc_cost_model_show(struct seq_file *s=
f, void *v)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF

[ ... ]

> +int ioc_bpf_attach(struct iocost_model_ops *ops)
> +{
> +	struct block_device *bdev;
> +	struct request_queue *q;
> +	struct gendisk *disk;
> +	struct ioc *ioc;
> +	unsigned int memflags;
> +	int ret;

[ ... ]

> +	mutex_lock(&q->rq_qos_mutex);
> +	if (!disk_live(disk) || !blk_get_queue(q)) {
> +		mutex_unlock(&q->rq_qos_mutex);
> +		ret =3D -ENODEV;
> +		goto put;
> +	}
> +	ioc =3D q_to_ioc(q);
> +	if (!ioc) {
> +		ret =3D blk_iocost_init(disk);
> +		mutex_unlock(&q->rq_qos_mutex);
> +		if (ret)
> +			goto put_q;
> +		ioc =3D q_to_ioc(q);

[Severity: High]
Is it safe to call q_to_ioc() here after dropping rq_qos_mutex?

q_to_ioc() internally calls rq_qos_id(), which traverses the non-RCU
q->rq_qos linked list locklessly. Because the protecting rq_qos_mutex
is unlocked just prior to this call, could a concurrent thread (such as
one disabling another QoS policy via sysfs, or a device removal triggering
rq_qos_exit()) modify the list and cause a use-after-free during this
unprotected traversal?

> +	} else {
> +		mutex_unlock(&q->rq_qos_mutex);
> +	}
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930075154.1899=
58-1-cui.tao@linux.dev?part=3D1

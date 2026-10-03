Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3435676A
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050169; cv=none; b=f+XTqEVplL4EY1SSm8lzcaYwMu9G0hZYjN0eAwye/OUYNHZQjgGFfwvZCo2rI4NdxwzA36ProXrbnpAOID57TaCNuoNYhT4ketxbPaSVAcSv+H2Hc5BdIYHniZxnTi8RVlmk/w+HBxrmz9RfyV6m0EoXijrV7g2HuC9g9oYSwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050169; c=relaxed/simple;
	bh=OxpMVn5Nlxju/LinzrFO/EJtt7fpGQ3sOMm9NSFeg/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PGsMV0Zsmib3vz++9irIAKlAgCLuR8jgF5VTTwp/giBgLdGFPqegsgYD8/T3gs/aZEC4MwoZOjlOa5QlzE/OUuNXeGTa4lwey4zEkAz4sYGfL2la4xfMa9ln0QqjDykiAGxoXNgnUMib8YvqNAuEhmMJq/5aG3NybdMXePL+4RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIjiDMKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIjiDMKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D3A1F0089B;
	Sat,  3 Oct 2026 17:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050167;
	bh=cseVix12C5qVYqzRegC4MEurSOWdWY0COo8sOKqSoss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iIjiDMKqpchUf/JqkwfZ0qQhK5NtXwlDq/D2TV4caGdG/sE+xjVWkr2ZlQSGonuFY
	 MvgnaEgPjk2XG7qlmqh5bzhf+rT6rLC7W2A4/tE6BdhFhCl6DX8/SOEIb9M5RSO7rR
	 E4NeBFz4ziDlBJOujHZZIDF77RNqD9tPHui8OxkYzYgm5d3LrP7R08jCidVbAEmzkp
	 x9P3Ne42VRdgQ/lmxCCcCROPVNo/f3mOLeWwXpd97Y09eb2XeultDwc0U4JhNevEBU
	 ewNEqKUTq7zMxISm6A06JjHwt51fpoQuoUHWlrivs/5n2XyM+DJtlK0/RQ7JbpZtcD
	 UchXKRs7lLEfg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v10 1/4] blk-iocost: add BPF struct_ops cost model
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, tj@kernel.org
In-Reply-To: <20261003124045.1289305-2-cui.tao@linux.dev>
References: <20261003124045.1289305-1-cui.tao@linux.dev>
 <20261003124045.1289305-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:06 +0000
Message-Id: <20261003175607.37D3A1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] blk: lock inversion between rq_qos_mutex and queue freeze
- [Low] bpf: multi-line comment style violation in BPF-related files
--

commit 54129eafa6fdb7e951520269403d0945a53f2d20
Author: Tao Cui <cui.tao@linux.dev>

blk-iocost: add BPF struct_ops cost model support

This commit introduces BPF struct_ops support for the block iocost
controller, allowing a BPF program to replace the builtin linear cost
model. It adds attach and detach paths for the BPF model and modifies
the cost model sysfs write path to allow switching between the linear
and BPF models.

> diff --git a/block/blk-iocost-bpf.c b/block/blk-iocost-bpf.c
> new file mode 100644
> --- /dev/null
> +++ b/block/blk-iocost-bpf.c
[ ... ]
> @@ -108,13 +108,13 @@ static void bpf_iocost_unreg(void *kdata, struct bp=
f_link *link)
>  	struct iocost_model_ops *ops =3D kdata;
>  	struct request_queue *q;
> =20
>  	/*
>  	 * ops->q may already have been cleared by the removal ejection;
>  	 * take a queue reference under RCU before entering the queue,
>  	 * as the queue may be dying and its memory is only guaranteed
>  	 * under rcu_read_lock()
>  	 */
>  	rcu_read_lock();
>  	/* pairs with the smp_store_release() in the attach: a non-NULL
>  	 * q guarantees the owning link store is visible */

[Severity: Low]
This isn't a bug, but does this multi-line comment violate the BPF subsystem
comment style? The opening /* is expected to be on its own line for
multi-line comments in BPF-related files.

>  	q =3D smp_load_acquire(&ops->q);
[ ... ]
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
[ ... ]
> @@ -3621,7 +3621,265 @@ static int ioc_cost_model_show(struct seq_file *s=
f, void *v)
[ ... ]
> +int ioc_bpf_attach(struct iocost_model_ops *ops, struct bpf_link *link)
> +{
[ ... ]
> +	if (!queue_is_mq(q)) {
> +		ret =3D -EOPNOTSUPP;
> +		goto put;
> +	}
> +
> +	/*
> +	 * the freeze is taken before rq_qos_mutex; taking the mutex
> +	 * around the freeze instead cycles against the io.cost.qos
> +	 * write path, which freezes with the mutex held.  Holding
> +	 * rq_qos_mutex from the disk_live() check through the model
> +	 * switch keeps the ioc from being freed under us.
> +	 */
> +	memflags =3D blk_mq_freeze_queue(q);
> +
> +	mutex_lock(&q->rq_qos_mutex);

[Severity: High]
Could this locking sequence cause an ABBA deadlock? Here we freeze the
queue and then acquire rq_qos_mutex. However, in ioc_cost_model_write()
introduced further below, the order appears to be reversed.

> +
> +	/*
> +	 * one map binds one device at a time: the ops carries a single
[ ... ]
> +void ioc_bpf_detach(struct iocost_model_ops *ops, struct bpf_link *link,
> +		   struct request_queue *q)
> +{
[ ... ]
> +	/*
> +	 * the freeze is taken before rq_qos_mutex like in the attach;
> +	 * the attachment and the link are re-checked under the mutex
> +	 * below, as the ejection or a newer attachment through another
> +	 * link may have won the race meanwhile
> +	 */
> +	memflags =3D blk_mq_freeze_queue(q);
> +	blk_mq_quiesce_queue(q);
> +
> +	mutex_lock(&q->rq_qos_mutex);

[Severity: High]
Similar to ioc_bpf_attach(), this establishes the queue freeze ->
rq_qos_mutex lock order.

> +
> +	ioc =3D q_to_ioc(q);
[ ... ]
> @@ -3484,6 +3907,8 @@ static ssize_t ioc_cost_model_write(struct kernfs_o=
pen_file *of, char *input,
>  	bool user;
>  	char *body, *p;
>  	int ret;
> +	const struct iocost_model_ops *new_model =3D NULL;
> +	bool model_write =3D false;
> =20
>  	blkg_conf_init(&ctx, input);
> =20

[Severity: High]
Does this code establish a reverse locking order compared to the attach and
detach paths?

Further down in ioc_cost_model_write(), the call to blkg_conf_open_bdev()
acquires rq_qos_mutex, and then blk_mq_freeze_queue() is called. This
rq_qos_mutex -> queue freeze order looks like it will trigger a circular
locking dependency warning in lockdep if someone loads a BPF struct_ops
and writes to io.cost.model.

> @@ -3536,9 +3961,25 @@ static ssize_t ioc_cost_model_write(struct kernfs_=
open_file *of, char *input,
>  			continue;
>  		case COST_MODEL:
>  			match_strlcpy(buf, &args[0], sizeof(buf));
> -			if (strcmp(buf, "linear"))
> -				goto unlock;
> -			continue;
> +			if (!strcmp(buf, "linear")) {
> +				/* staged and committed below, so a parse
> +				 * error later in the same write leaves
> +				 * the model selection untouched
> +				 */

[Severity: Low]
This isn't a bug, but this multi-line comment also appears to miss having
the opening /* on its own line, which goes against the BPF subsystem
formatting guidelines.

> +				new_model =3D NULL;
> +				model_write =3D true;
> +				continue;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003124045.1289=
305-1-cui.tao@linux.dev?part=3D1

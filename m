Received: from mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770FB4EA371
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554743; cv=none; b=C218wbIK/MJjMpCyWg9vHFMs8wCM1I8vJISM8wuKKWVSInO6BNKQbvnEQ+aXqjp3Zkp+k1X7kstb0DeLnhJLZRVSZmHth3o+2nPGRZXHlR0V9KqCEpVC0fVR7hD8VezTQB2uK6J2I5MHD71n7IVJFtmWiRSorhgtRH3ly5RJ/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554743; c=relaxed/simple;
	bh=XEElrARnGZXo06nVsE55UlAH/qIqFqbot95vz0Dia1k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rMFefZo2ASeLDeBuj982A34XebgHkKqPwLRRafNp+reQTlPXFRPtZKb3xWhXsPtRyhLhszup8V8rd456Sh4X8FgHkZpLkSg6oqRmzQ8DWEkHZEY2EqYozGnQ9kCTOdaioG3OzDrntcfqlIaypXOZL3knzmmO83/phnCSMxXNlnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qPlH3sK/; arc=none smtp.client-ip=91.218.175.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qPlH3sK/"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XEElrARnGZXo06nVsE55UlAH/qIqFqbot95vz0Dia1k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789554721; v=1; x=1790159521;
 b=qPlH3sK/T/fSA1FKI9kwsVwPTCwG53A8jfUMjBIPWqI7GNtNiomHw0GwS8a0vf4y02+JAjH+
 hYBFnwdXUULX/vom8QGUTMrRK3QId2IGoBT29dnvqR3MXRTaEklg/6TQSCHxT752s4eK9rSrJ2L
 WSNEZpMpGqLj40xPQK9wuKyw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d8fc3f7943fd14ab;
	Wed, 16 Sep 2026 10:32:01 +0000
X-Mizu-Trace-ID: d8fc3f7943fd14ab
X-Migadu-Flow: FLOW_OUT
Message-ID: <2d6e4798-a3eb-4a63-8575-c3f9cbd7fe62@linux.dev>
Date: Wed, 16 Sep 2026 18:31:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/5] blk-iocost: add BPF struct_ops cost model
 support
To: sashiko-reviews@lists.linux.dev
References: <20260916072302.1068871-1-cui.tao@linux.dev>
 <20260916072302.1068871-2-cui.tao@linux.dev>
 <20260916073408.D92471F000FF@smtp.kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260916073408.D92471F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/16 15:34, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] bpf: resource leak and broken blkcg notifications on BPF model unbind
> - [High] bpf: coefficient-only writes fail if bound model is unregistered
> - [Low] bpf: multi-line comments do not follow modern kernel style

Thanks for the reviews.  All five findings across the two patches are
confirmed and will be fixed in the next revision:

- the lookup in iocost_bpf_model_get() only searched the registry, so
  a coefficient-only write on a device using an unregistered model
  failed with ENOENT; the lookup will fall back to the notify list,
  keeping such a model selectable by name until the last device
  unbinds

- the notify-list detach condition in iocost_bpf_model_put() was
  wrong for a registered model bound to several devices: the first
  unbind removed the node from the lifecycle list early and the last
  unbind then failed to find it, leaking the BPF map reference; the
  node will leave the notify list only with the last binding

- the 2x example model did not advance its cursor for merged bios,
  unlike the builtin backmerge behaviour, so a long merged stream
  could drift past the 16MB seek threshold and misprice the
  following IO as random

- the multi-line comments use the opening marker on its own line

While testing those fixes we also found and fixed a problem of our
own: two racing io.cost.model writes resolving the same model each
took a reference on it, but the write whose commit found the model
already bound did not drop one, leaking a map reference.  The commit
path now drops the redundant reference.

The next revision will follow shortly.

> --
> 
> commit 4e914860298423131f3423ab63f79ed4a655051f
> Author: Tao Cui <cuitao@kylinos.cn>
> 
> blk-iocost: add BPF struct_ops cost model support
> 
> This commit introduces a BPF struct_ops based cost model for blk-iocost,
> replacing the builtin linear model on a device. It implements a
> registration framework where sysfs bindings map a registered model to a
> device.
> 
>> diff --git a/block/blk-iocost-bpf.c b/block/blk-iocost-bpf.c
>> new file mode 100644
>> index 0000000000000..7f1f9a2e51cb2
>> --- /dev/null
>> +++ b/block/blk-iocost-bpf.c
> 
> [ ... ]
> 
>> +const struct iocost_model_ops *iocost_bpf_model_get(const char *name)
>> +{
>> +	struct iocost_bpf_model *m;
>> +	const struct iocost_model_ops *ops = ERR_PTR(-ENOENT);
>> +
>> +	mutex_lock(&iocost_bpf_reg_lock);
>> +	list_for_each_entry(m, &iocost_bpf_models, list) {
> 
> [Severity: High]
> Will this lookup fail to find models that are unregistered but still
> actively bound to devices? If a user issues a coefficient-only write on
> a device using an unregistered model, ioc_cost_model_write() passes the
> name here, but since this only searches the registry (iocost_bpf_models),
> it returns -ENOENT and rejects the write.
> 
>> +		if (!strcmp(m->ops->name, name)) {
> 
> [ ... ]
> 
>> +static void bpf_iocost_unreg(void *kdata, struct bpf_link *link)
>> +{
>> +	struct iocost_model_ops *ops = kdata;
>> +	struct iocost_bpf_model *m;
>> +
>> +	mutex_lock(&iocost_bpf_reg_lock);
>> +	m = iocost_bpf_model_lookup(ops);
>> +	if (m) {
>> +		/* keep the linkage queryable so model_put() can tell a
>> +		 * still-registered node (one ref held by the registry)
>> +		 * from one kept alive only by device bindings
>> +		 */
> 
> [Severity: Low]
> Does this comment style follow the BPF subsystem requirements? The
> standard specifies that multi-line comments should have the opening /*
> on its own line.
> 
>> +		list_del_init(&m->list);
> 
> [ ... ]
> 
>> +void iocost_bpf_model_put(const struct iocost_model_ops *ops)
>> +{
>> +	struct iocost_bpf_model *m;
>> +
>> +	mutex_lock(&iocost_bpf_reg_lock);
>> +	list_for_each_entry(m, &iocost_bpf_lifecycle, lifecycle) {
>> +		if (m->ops == ops)
>> +			break;
>> +	}
>> +	if (&m->lifecycle != &iocost_bpf_lifecycle) {
>> +		bool freed = refcount_dec_and_test(&m->refs);
>> +
>> +		/* leave the notify list with the last binding: the
>> +		 * remaining ref is either the registry's (node still on
>> +		 * iocost_bpf_models) or zero and the node is freed
>> +		 */
> 
> [Severity: Low]
> Similarly here, this multi-line comment is missing the opening /* on its
> own line.
> 
>> +		if (freed || !list_empty(&m->list))
>> +			list_del(&m->lifecycle);
>> +		mutex_unlock(&iocost_bpf_reg_lock);
>> +		bpf_struct_ops_put(ops);
>> +		if (freed)
>> +			kfree(m);
>> +		return;
>> +	}
> 
> [Severity: High]
> Can this sequence prematurely detach registered models from the lifecycle
> list and leak BPF map references?
> 
> When the first device is unbound from a registered model,
> !list_empty(&m->list) will evaluate to true. This removes the model from
> the lifecycle list early, breaking blkcg notifications.
> 
> When subsequent devices are unbound, list_for_each_entry() at the start of
> iocost_bpf_model_put() will fail to find the model, causing execution to
> jump over this block completely. The bpf_struct_ops_put() call will be
> skipped, leading to a map reference leak.
> 
>> +	mutex_unlock(&iocost_bpf_reg_lock);
>> +}
> 
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index 2745bffcd5eef..22b2ece52fa58 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
> 
> [ ... ]
> 
>> @@ -3591,6 +3628,24 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>>  	spin_lock_irq(&ioc->lock);
>>  	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
>>  	user = ioc->user_cost_model;
>> +#ifdef CONFIG_BLK_CGROUP_IOCOST_BPF
>> +	{
>> +		const struct iocost_model_ops *model =
>> +			rcu_dereference_protected(ioc->model,
>> +					lockdep_is_held(&ioc->lock));
>> +
>> +		/* seed from the bound model so a coefficient-only write
>> +		 * keeps it bound; ctrl=auto/user and model=linear are
>> +		 * the explicit ways back to the builtin model
>> +		 */
> 
> [Severity: Low]
> This comment also places text on the same line as the opening /*, which
> diverges from the preferred BPF multi-line comment style.
> 
>> +		if (model)
>> +			strscpy(bpf_model, model->name, sizeof(bpf_model));
> 


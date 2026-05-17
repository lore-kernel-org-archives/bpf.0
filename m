Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E3D3BB105
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027464; cv=none; b=o4WeQodrRa2uopKqj2oWBPlgwJ2IWl+U6SZrzUnfe/Z5oQVMZT6eAgLR2Syw6gj1vUjj3DLPYCNm9qHeXtA6c6ygFZXY6JMFvF4uBLMBHL5zBCHkz7H8r3RMytbK+DeCIjhdAlZKfyIUSaJoMPxb8xgpzqEnCj9P5+eRGkK0q7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027464; c=relaxed/simple;
	bh=E3Vg2Oq2ir+JjV1MKpVqofNBfbCynlS3UP/dp5f/jdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T0yz+hrK2KXLNF4BVCD0mdl7gWDZD9SQNxQdt50fjDTZlP3ptB2+nn2ohZ6vbCpm6GRDOz5OFWdYbiQnOJObENoE5iHQB13TVWBGrVty5yUJcaPMbJ9PYYRuwBBq+baBOsijjftDJ0h6XM8tVtawrfG6QN4YXvAfsGqZDrwhhDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a42HipzP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a42HipzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0856DC2BCB8;
	Sun, 17 May 2026 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779027462;
	bh=E3Vg2Oq2ir+JjV1MKpVqofNBfbCynlS3UP/dp5f/jdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=a42HipzPYDBPqVZ9Pso2pNiiMUfP1tVki1e6bhdSaWNkRy9v8KEnTvzNQXQ1FZ7w7
	 tA50VE2BRUeCh79Q+CnpbVaD3SNNbGZSXl+V6ib41jJ4PJ7Fcj27ARnAX39NJq/C7Z
	 9q8O4ch9ftktER3GyNIfJUjQHMIp/r3Poek3rH2DdSgiKeFhVw4FQmVd7NojjptQzB
	 giBFHGtzCeRGL4ijyUVbjcAKuFJALorL9YGnrcfdYYO53DXy1e3z0fuLuqkHrA232h
	 /W4Y30rqZXhp/EvFl/NMo23I3i/zmFTnzvE5W+6rW3/JF0fgdAto9HvZf8zYhkiv7Q
	 ashNmApNK9RVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] killswitch: add per-function short-circuit
 mitigation primitive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260517134858.146569-1-sashal@kernel.org>
References: <20260517134858.146569-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 14:17:41 +0000
Message-Id: <20260517141742.0856DC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Calling __module_address() without rcu_read_lock() or module_mutex=
 in ks_module_notify() triggers lockdep splats and risks a Use-After-Free.
- [Medium] The command parser in ks_control_write() rigidly fails with -EIN=
VAL if there are multiple spaces or tabs between arguments.
--

commit 41367b8b3bd9a102ede7118d0216e23f583793b2
Author: Sasha Levin <sashal@kernel.org>

killswitch: add per-function short-circuit mitigation primitive

This commit introduces a killswitch mitigation primitive, which allows
an administrator to force a given function to return a specified value
without executing its body. This is intended to mitigate security issues
until a patch can be deployed. It is operated via a securityfs interface.

> diff --git a/kernel/killswitch.c b/kernel/killswitch.c
> new file mode 100644
> index 0000000000000..7f509c62ea748
> --- /dev/null
> +++ b/kernel/killswitch.c

[ ... ]

> +static int ks_module_notify(struct notifier_block *nb, unsigned long act=
ion,
> +			    void *data)
> +{
> +	struct module *mod =3D data;
> +	struct ks_attr *attr, *n;
> +
> +	if (action !=3D MODULE_STATE_GOING)
> +		return NOTIFY_DONE;
> +
> +	mutex_lock(&ks_lock);
> +	list_for_each_entry_safe(attr, n, &ks_engaged_list, list) {
> +		if (!attr->kp.addr ||
> +		    __module_address((unsigned long)attr->kp.addr) !=3D mod)

Does this need to be wrapped in an rcu_read_lock() and rcu_read_unlock()?

The __module_address() function traverses the RCU-protected module latch tr=
ee
and requires the caller to hold module_mutex or be within an RCU read-side
critical section.

The module subsystem drops the module_mutex before invoking the blocking
notifier chain, so this code executes without it.

Can this trigger a lockdep warning or risk a use-after-free if concurrent
operations modify the tree during traversal?

> +			continue;
> +
> +		pr_warn("killswitch: %s mitigation lost: module %s unloading; re-engag=
e after reload if still needed\n",
> +			attr->kp.symbol_name, mod->name);

[ ... ]

> +static ssize_t ks_control_write(struct file *file, const char __user *ub=
uf,
> +				size_t count, loff_t *ppos)
> +{
> +	char *buf, *cur, *verb, *sym, *retstr;
> +	long retval =3D 0;
> +	int ret;

[ ... ]

> +	cur =3D strim(buf);
> +	verb =3D strsep(&cur, " \t\n");
> +	if (!verb || !*verb) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!strcmp(verb, "disengage_all")) {
> +		mutex_lock(&ks_lock);
> +		ks_disengage_all_locked();
> +		mutex_unlock(&ks_lock);
> +		ret =3D count;
> +		goto out;
> +	}
> +
> +	sym =3D strsep(&cur, " \t\n");
> +	if (!sym || !*sym) {

Is it possible for valid input to be rejected here if there are consecutive
spaces between tokens?

If a user or script writes "engage  my_func  0" with multiple spaces,
strsep() replaces the first space with a null terminator and returns an emp=
ty
string for the subsequent space.

The check !*sym would then interpret this empty token as invalid input and
abort with -EINVAL.

Would it be better to use skip_spaces() or a loop to handle natural variati=
ons
in whitespace?

> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!strcmp(verb, "disengage")) {
> +		ret =3D __ks_disengage(sym);
> +		ret =3D ret ? ret : count;
> +		goto out;
> +	}
> +
> +	if (strcmp(verb, "engage")) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	retstr =3D strsep(&cur, " \t\n");
> +	if (!retstr || !*retstr) {

Could this also fail similarly if there are consecutive spaces before the
return value token?

> +		ret =3D -EINVAL;
> +		goto out;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517134858.1465=
69-1-sashal@kernel.org?part=3D1

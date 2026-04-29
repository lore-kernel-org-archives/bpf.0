Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187AE1E25F9
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427390; cv=none; b=sOx7RGkSbo7zFNS9oMALFmTjLYZtBioNrJHg8m2cs16DlAOqqNyKJIE+JL6o7jst1TiNs6i6qlEg+MAxpM+8jBW2Ne0tNX8gn5lQxoxSQB+9yJa7lNVxAhjWzByJazSTx8O3nPpDt+lCEfk7q+RUUJb8/0M0qkJpOdsnTN3cSvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427390; c=relaxed/simple;
	bh=2aX/+VoHidjDizQdg6x8FZK9YZgi0J3yPJaYctwKZA8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tTmaVilfhC1gGNrhVuyHiM+7XgBV7zNO5TLElo8QSjcO9lbhXZSP3eQmYm6mJ25qJoR0UkT18Itu/FYtQ+qvRweoGi8ilyFopxuat0XMTAKUxFmo5mZXAh/ucSjeysRmpn0u4ENBQi/JAyiXiStsFuaidlN9LSF/Q3GBuWCY984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eU6AzgoV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eU6AzgoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1A0C2BCB7;
	Wed, 29 Apr 2026 01:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777427389;
	bh=2aX/+VoHidjDizQdg6x8FZK9YZgi0J3yPJaYctwKZA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eU6AzgoV8em4FQGnou7wGiyxR32VrK4fDryyO+h5XX+rAGYWahwqr1CYM6AOOWlHA
	 gl3HMIXyDQjJr/L/OWyUf/3RbRWoo/z6AnwcuhvEAJbUF3cwZAGFHczAsX+URORBqu
	 O+fmdCnT5HAMxVdz9cssMCstJEiSXBks9g7ATV/sJHjYLYfsN+gnGKYaWXrEW/KOBI
	 2mzlcvsDCvSwf3GejcC+4iRsxy1wo9qzzyKRyqddGQU5BMgyPdyhAb7yb99rKSE5IT
	 NefryF+S5OWlx22wUTaLxUa8EfDMDSBvOUux8gTGa8TrIYxzEUAzRj4Qa8+2jz2Glq
	 PfSCxSyAAluww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/4] bpf: Use rcu_work in BTF teardown
Reply-To: sashiko@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428201422.1518903-3-utilityemal77@gmail.com>
References: <20260428201422.1518903-3-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 01:49:48 +0000
Message-Id: <20260429014949.7C1A0C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free in `btf_module_notify()` when flushing RCU work aft=
er `btf_put()`.
--

commit dc547d68e9d5193df746bf0203a1b6ef30ad4a58
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Use rcu_work in BTF teardown

This commit queues the final BTF teardown from an RCU callback onto
an rcu_work. This ensures all RCU grace periods cease before proceeding
with the free work, allowing synchronous teardown for subsequent patches.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 77af44d8a3ad..2b0511663319 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -8446,6 +8451,7 @@ static int btf_module_notify(struct notifier_block =
*nb, unsigned long op,
>  				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
>  			purge_cand_cache(btf_mod->btf);
>  			btf_put(btf_mod->btf);
> +			flush_rcu_work(&btf_mod->btf->free_work);

Can this result in a use-after-free regression of the btf object?

When btf_put() drops the module's reference to the BTF object, the current
thread no longer owns a reference. If this was the last reference,
queue_rcu_work() is invoked to asynchronously free the btf object after
an RCU grace period.

Because the thread is no longer inside an RCU read-side critical section,
it can be preempted before flush_rcu_work() runs. During this preemption
window, the RCU grace period could expire, allowing the background workqueue
to execute btf_free_work() and free the btf object via kfree().

When the thread resumes, flush_rcu_work() evaluates &btf_mod->btf->free_work
and checks its internal state. Does this directly dereference the
potentially freed btf memory?

>  			kfree(btf_mod->sysfs_attr);
>  			kfree(btf_mod);
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428201422.1518=
903-1-utilityemal77@gmail.com?part=3D2

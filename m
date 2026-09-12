Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C06722D7A9
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 03:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789184302; cv=none; b=f+14RCXVRaSL3QJG7IottsnETlvW5ln/kJwO6gNruPDix6xjC8E4WrV9UwJEcOtQsXsprUacBd1Uixw+Lyns+2Et1hFHW743yh89jDYIiTObuGWjSFmCElybEn1KQYHgSc3ag/eX77lX7pb2GqvmPAlPlc/tvLvqqls9e8AViZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789184302; c=relaxed/simple;
	bh=KC+UqVfL9UqJKpxIQMOygXmXYZtPFOQIR+oOnjMHYG0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=iVLxzpr+svJ58l3aSuOd2GFupHphfKEZV0pOUryjqRpf2vmtrK5/sgTcqWHJfHoZl82xABkFnebHW5RmcenaXbFKGhUJOzQ4JjAAV1fJQ5T9rK8MQ3shx+06fskhDvOL5Wn0MZtZNUkcNzvY//X9RKtVRYnZm960kYq2QXpmREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGh1YbDY; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGh1YbDY"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46accbdfc20so624791fac.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 20:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789184300; x=1789789100; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=byHgOSMC0udxAsSgGbQwrR3Tvn2bMZ/JmBBvuMT0KGo=;
        b=mGh1YbDYBjvfUVBoqmm/fySt1SxgWxr3UN+Ry6ud/7EMhuJTRtowTAVH+5GzctqT0K
         u1Ie8Beqk9hNW0w6rMx8+E4inaw4bxYQXnT1qrt8eWBUK728iioNPYf1lzTupFSHlxDK
         5mO/e43ddaIJtF6+LOxcSYmSCZaSd/7LVfSXO1zPLvrA3T/HXjQywj135ucQvYs5vVsO
         Ft39w1UKd7VaqYmPX5o2N6DVJ2K8JtcdJnwcTccVzth4hQIp6164NIkV6HOEoLhxYrc8
         iyVqUTQRALMl6L9j6oI1cCLznD/KodSvEDTkbuzO6WfC3e9QO9vvWfcCHQuJ8kvMY3Lu
         /oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789184300; x=1789789100;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=byHgOSMC0udxAsSgGbQwrR3Tvn2bMZ/JmBBvuMT0KGo=;
        b=gkS1gSThzWyzRvdGajRm5bQhvFPgXskQtYR5mUN+PTmBQR4rvH6zGUAkg+30HXIeA7
         qtDZjnul1NG2NIr+HkJbDACfU0qiDu5ktKWqTCShm6UHQMYLsDPpNWryaJyDLR3Ke4AV
         vJGWz2KDsDOwBgeiK1nWbq8DQi6Ini7YkwaYCBKnHduxAz9cK4YXgI8QCQfDQnyHb15d
         TduKLFXEvjBeqV5pdbyCCmFFCUejXm29hKzIMLxyJZMEb6vhraPjMACjkBquh5r4zyJi
         QQMuAiOfKQ71ZztDeHE272b7LtwUTxUDjQPMcErp1GPjwTcku9zCLkMDOyBJzGvHB3+R
         NeSw==
X-Forwarded-Encrypted: i=1; AKwUvBzDwXZfGKHO5B4an9dUdok9atFyg4uJyYZ7RIEYMB/HEupJgtQjDBBwnFKCxhO9huPpLLE=@vger.kernel.org
X-Gm-Message-State: AFuF++mlZ3gS5sF+RqP3eJGEKlJ0wEgOdx1d4MQITmFs0UJbdClDlCSQ
	HPeAl0vHht5rdaEz1Z48b9zlHfsPEgAOYfS0Kctk7pETqZ0hGDNevYgv
X-Gm-Gg: AYBFou1brc5XlFy8OlPdtQmODzt2CSGrdykEysuthNNyRY8+d0CR9npZKWc/ODxVWgm
	JCPR5l55i59Y8j6LULj3jpaqDPNk1QbSldgE56n4gkSU2QaNgahWQmuoH3gMScDUb4Je9ItzsiS
	enOSjo/oPprltV2WbfnMvRN9xIfAVNt6PR6mit6wvX8SETVblOIsdm135H38VE0ZQc1cWj31wz4
	bZQp1qB4MXrRNiyR1DG7zeiywTJCXTrnyGocwHqF6+uU/T/SwuRpUw3XPww4+DizVWO68/CPxlT
	c5gpofY9WMhMOBoHBqQYKO7qbDuQJn65S3DI396WzV4xDmVXqErndq+2jpNTgkj2S5uKge4AUok
	Gy8LhmDVGLLgg9yD1wEAOUNh0ei1tIx/YIu3vD6tAEm5tjcxPaKy099KkVuSVX7OaqFbRT25ouV
	coXaFizPJRPJ3rCm/1lC+UVaG//DOcFhzK7h0MIkG3oovKOGd/w1leso5c/rOIDM8upbtxvpn/r
	L0hYvmbsPjzeYqeUc7H6nkNXybuwapRZJ0aFgq4gZHmXuzwUq3tYYOG219T+zulmw==
X-Received: by 2002:a05:6871:113:b0:448:71f4:a28 with SMTP id 586e51a60fabf-47de7720e6amr10502335fac.2.1789184299775;
        Fri, 11 Sep 2026 20:38:19 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:12::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df8699647sm3683938fac.5.2026.09.11.20.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 20:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 20:38:16 -0700
Message-Id: <DLD0WER9K97K.2V2NOAJ840CR7@gmail.com>
Subject: Re: [PATCH bpf-next v3 07/15] lsm: Add the
 bpf_lsm_policy_apply_bprm kfunc
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <kpsingh@kernel.org>,
 <matt@bobrowski.net>, <paul@paul-moore.com>, <mic@digikod.net>,
 <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <kees@kernel.org>
Cc: <casey@schaufler-ca.com>, <gnoack@google.com>, <jack@suse.cz>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <jolsa@kernel.org>,
 <m@maowtm.org>, <bpf@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-8-utilityemal77@gmail.com>
In-Reply-To: <20260909193719.518517-8-utilityemal77@gmail.com>

On Wed Sep 9, 2026 at 12:37 PM PDT, Justin Suess wrote:
> Add the kfunc applying a policy object to an execution:
>
>   bpf_lsm_policy_apply_bprm(object, bprm, flags)        KF_SLEEPABLE
>
> It asks the LSM owning @object, through the bprm_apply_policy_object
> hook, to restrict the credentials prepared in @bprm, so that the
> executed task starts confined by the policy.  The meaning of @flags
> and the composition with restrictions the credentials already carry
> are the owning LSM's; an LSM without execution policy support makes
> the call fail with -EOPNOTSUPP.
>
> The kfunc runs the hook in a root memcg charging scope: the policy
> restricts the execution on behalf of the BPF program, not of the
> mediated task, so what the owning LSM allocates to compute it, e.g.
> Landlock's merged domain, is not charged to the task the program
> supervises.
>
> The filter makes the kfunc exclusive to the sleepable LSM programs
> attached to the bprm_creds_for_exec() or bprm_creds_from_file()
> hooks, the only contexts where the bprm's credentials are prepared
> but not yet committed.  The verifier's argument typing does not draw
> this boundary on its own: a trusted struct linux_binprm pointer is
> also available at the other bprm hooks -- bprm_check_security(),
> which runs per binfmt while an interpreter may still rewrite the
> execution, and bprm_committing_creds()/bprm_committed_creds(), which
> run at or past the point of no return, where the prepared
> credentials are frozen or installed -- and to tp_btf programs via
> the sched_prepare_exec and sched_process_exec tracepoints, which
> resolve kfuncs from the same registration bucket as LSM programs.
> The attach-point filter, not the argument type, is the authorization
> boundary.
>
> No filter case is needed for BPF_LSM_CGROUP programs: since
> commit 5b038319be44 ("bpf: Reject sleepable BPF_LSM_CGROUP programs
> at load time") they cannot be sleepable, so KF_SLEEPABLE already
> excludes them.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>
> Notes:
>     v2->v3:
>         - Drop the BPF_LSM_CGROUP case from the kfunc filter: since
>           commit 5b038319be44 ("bpf: Reject sleepable BPF_LSM_CGROUP
>           programs at load time") such programs cannot be sleepable, so
>           KF_SLEEPABLE already excludes them from the apply kfunc.
>         - Document, in the commit message and the filter comment, why the
>           attach-point filter rather than the verifier's argument typing
>           is the authorization boundary.
>
>  security/bpf_lsm_kfuncs.c | 68 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/security/bpf_lsm_kfuncs.c b/security/bpf_lsm_kfuncs.c
> index 43a4bf57fd31..857e9a316d1c 100644
> --- a/security/bpf_lsm_kfuncs.c
> +++ b/security/bpf_lsm_kfuncs.c
> @@ -2,16 +2,25 @@
> =20
>  /* BPF kfuncs exposing LSM policy objects. */
> =20
> +#include <linux/binfmts.h>
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
>  #include <linux/btf_ids.h>
>  #include <linux/cfi.h>
>  #include <linux/init.h>
>  #include <linux/lsm_hooks.h>
> +#include <linux/memcontrol.h>
> +#include <linux/sched/mm.h>
>  #include <linux/security.h>
> =20
>  #include "lsm.h"
> =20
> +/* The sleepable LSM hooks bpf_lsm_policy_apply_bprm() may be called fro=
m. */
> +BTF_SET_START(bpf_lsm_policy_bprm_hooks)
> +BTF_ID(func, bpf_lsm_bprm_creds_for_exec)
> +BTF_ID(func, bpf_lsm_bprm_creds_from_file)
> +BTF_SET_END(bpf_lsm_policy_bprm_hooks)
> +
>  __bpf_kfunc_start_defs();
> =20
>  /**
> @@ -44,6 +53,49 @@ bpf_lsm_policy_acquire(struct lsm_policy_object *objec=
t)
>  	return NULL;
>  }
> =20
> +/**
> + * bpf_lsm_policy_apply_bprm - Apply a policy object to exec credentials
> + * @object: policy object to apply
> + * @bprm: execution context providing the prepared credentials to
> + *        restrict
> + * @flags: flags defined by the LSM owning @object
> + *
> + * Ask the LSM owning @object to restrict the credentials prepared in
> + * @bprm with it, so that the executed task starts confined by the
> + * policy.  How the policy composes with restrictions the credentials
> + * already carry, and the meaning of @flags, are defined by the owning
> + * LSM.  @object is only borrowed: the caller keeps its reference.
> + * The hook runs in a root memcg charging scope: policy the LSM
> + * computes on behalf of the program is not charged to the mediated
> + * task.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the LSM owning @object does
> + * not support applying policy to an execution, -EINVAL on unsupported
> + * @flags, other negative values on LSM-specific failures.
> + */
> +__bpf_kfunc int bpf_lsm_policy_apply_bprm(struct lsm_policy_object *obje=
ct,
> +					  struct linux_binprm *bprm, u32 flags)
> +{
> +	struct lsm_static_call *scall;
> +	struct mem_cgroup *old_memcg;
> +	int err;
> +
> +	lsm_for_each_hook(scall, bprm_apply_policy_object) {
> +		if (scall->hl->lsmid->id !=3D object->lsmid)
> +			continue;
> +		/*
> +		 * The hook runs on behalf of the BPF program, not of the
> +		 * mediated task: charge its allocations to the root memcg.
> +		 */
> +		old_memcg =3D set_active_memcg(root_mem_cgroup);
> +		err =3D scall->hl->hook.bprm_apply_policy_object(bprm, object,
> +							       flags);
> +		set_active_memcg(old_memcg);
> +		return err;
> +	}
> +	return -EOPNOTSUPP;

Nack.

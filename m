Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785862D3EF2
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776891933; cv=none; b=rk7eizTwwZ8fIpVPQjBDciwikIy1tAmZ6k9kgS77WuN8VPnC7Kv6Ak3Xwtl7otJffJs1/HhAa/7X94DmHYcxCrVHTz5+TV1tciEjD+bWwlxyLjrk16fOksuIYrZKJZpzARLqZr/oUYS0oDgrVPnK+s5Y5y0DAHfSA7o/+v6jO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776891933; c=relaxed/simple;
	bh=DODawgWOJGNx/xfdNaM+WfUXZt1N+0Qdlh3wRvy8OYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gkuHscG6/qWgvtS1bI5aUiM76LIne3GKX5qIUGRFEmnw3/87cvD9e6evhfCvhS6hVTT5JD+PYh+qqWOAPDnZfEMnKIH4gfd8sqRBJoc4Sv11WRBgohQAopkSMFetNXcRkr7GXrg9+SqZvjuzTA7N4gF5hsB2Ql2SZDEplYsO0mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfzPwhel; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfzPwhel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1245DC19425;
	Wed, 22 Apr 2026 21:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776891933;
	bh=DODawgWOJGNx/xfdNaM+WfUXZt1N+0Qdlh3wRvy8OYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NfzPwhelCOi/KzGQlCiXr9UzXli0nw9AbRz/qU2UYP/DY06MYHu7kdGltgeHerToo
	 3OeFHUJ7NehDAtZuPbal7jVhKqdc0v9/umToswWLbTa2vbHvK10uzrjVcKsZvqMy84
	 lTchdCRC0KjwKlurmL1m+chrQH4/00VOle7qnsVR6MCfgihVUVPSq5aUqwLkrhB8nd
	 RULuqj6JcMk57Tqr1x9vO1YCv8uUnir179+2tKCrlDY2OeR3/tkgv4TpkXHecmcfrR
	 jHdlEGsvEirP3QF/O9zn5Ev51+iYxQs49I5Svcn88sra1qs9v2EOHeZErxRZvy0uFg
	 wIaWEIzy2Cgpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] io_uring: fix missing submitter_task ownership check in
 bpf_io_reg()
Reply-To: sashiko@lists.linux.dev
To: "Ali Raza" <elirazamumtaz@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260422-master-v1-1-e82f47558345@gmail.com>
References: <20260422-master-v1-1-e82f47558345@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 21:05:32 +0000
Message-Id: <20260422210533.1245DC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Incomplete fix for privilege escalation via deferred `submitte=
r_task` in `io_install_bpf()`
- [Medium] Denial of Service via user-triggerable WARN_ON_ONCE for missing =
`ops->loop_step`
--

commit 0ef4622575dbd984db4b264672ee9cc5b456a439
Author: Ali Raza <elirazamumtaz@gmail.com>

io_uring: fix missing submitter_task ownership check in bpf_io_reg()

This commit attempts to fix a cross-privilege execution vulnerability in
bpf_io_reg() where an attacker could install a malicious BPF loop_step
on a deferred ring before a privileged process adopts it.

> diff --git a/io_uring/bpf-ops.c b/io_uring/bpf-ops.c
> index 937e48bef40bc..cac11c9292971 100644
> --- a/io_uring/bpf-ops.c
> +++ b/io_uring/bpf-ops.c
> @@ -162,6 +162,8 @@ static int io_install_bpf(struct io_ring_ctx *ctx, st=
ruct io_uring_bpf_ops *ops)
>  		return -EOPNOTSUPP;
>  	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
>  		return -EOPNOTSUPP;
> +	if (ctx->submitter_task && ctx->submitter_task !=3D current)
> +		return -EPERM;

The commit message states that the vulnerability involves exploiting
IORING_SETUP_R_DISABLED, which defers submitter_task assignment. If the
ring is disabled, wouldn't ctx->submitter_task initially be NULL?

Because the check uses ctx->submitter_task && ..., the short-circuit
evaluation will evaluate to false and bypass the permission check entirely
when the submitter task is NULL. Does this allow the attacker to still
successfully install the BPF operations during the deferred assignment
window?

Should this explicitly reject registration if the submitter task is not
yet established, for example by checking:
if (!ctx->submitter_task || ctx->submitter_task !=3D current)?

> =20
>  	if (ctx->bpf_ops)
>  		return -EBUSY;

Looking a few lines further down in io_install_bpf():

	if (WARN_ON_ONCE(!ops->loop_step))
		return -EINVAL;

Since ops->loop_step comes from a user-provided BPF struct_ops map, can a
local user intentionally omit it to trigger this warning?

On systems configured with panic_on_warn=3D1, could this be used to trigger
a denial of service? Would it be safer to use a standard conditional
return without the warning macro?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422-master-v1-=
1-e82f47558345@gmail.com?part=3D1

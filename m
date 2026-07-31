Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F233AD8B
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 02:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465897; cv=none; b=B3SqdEOUiSGS4Dj1/yr+oFj9AsDlZ1egqm27bFLcQQ+JBAX15UbfygTRHtrG7FfePkm52L+PvClQvByrKLG0spzqK9L5bErwibOo2pN0r8oT8GA03nzBWS0EkON9OewEDoOJPGm8r8wRGG75JjzRUro33mDEMakz25DIV1/oTLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465897; c=relaxed/simple;
	bh=cvEO5GU+CO1JtjKAJZBI00JMvmd3xrJMdZGp4TeWK6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BYXHVXXDgqepvKMHbucBMCJRVJjg0m2CjT/LpoPcsr+E5t4G3qtT16HjkUMuWJUbuvPgdoZzNB3OqoHd0fYj2iJgCd7IhZr769nZRH6jMUGifoqCA+ZRbNXhSQS45stKJmzBR7Ow6kFP0dHWmER7dl/vcd0STi48osktU0exVa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrmtZECL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrmtZECL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71801F000E9;
	Fri, 31 Jul 2026 02:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465895;
	bh=aqMzh0bszPXgQZGEvz/43Kbolsa+8n3Y3wMAupbBbaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lrmtZECLhFc0s1NfFWbYORqqLwA+sppdKxbi5JqSRZGHLRY0I5iWt9TIoCoCHHTGX
	 wZppKThKhuG8mYye+pv8eQSqxyi5+ABv4W5gnn4A8mhn6llXfab6R6AbbHLyP7MZPH
	 NPfMiWy90AhYNKBma7o5sF4GCyMoVmLkSS9XD6PuiZqhMBlHFW7HIyr0kFwcTFxgya
	 oNBy5198xuqGt4z8GV6qrKBjvUrR4RuNONDVF0yprveQ16Wwyn9YbqAYdlFSMrgE1n
	 x4kJGX3SCJTI3XSuYb42BI2kkCXUD//8czwOBb8z21nfhSb8IXrxy2MIuUveo9wwK5
	 X6cc87+cYhygQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 02/13] lsm: Add LSM hook
 security_policy_kptr_put
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731022047.189137-3-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <20260731022047.189137-3-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 02:44:54 +0000
Message-Id: <20260731024454.C71801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The WARN_ON_ONCE for a dispatch miss is bypassed if the caller e=
rroneously passes LSM_ID_BPF, resulting in a silent leak.
--

--- Patch [2]: [PATCH bpf-next 02/13] lsm: Add LSM hook security_policy_kpt=
r_put ---
commit 6653ce935258422e0de519b7ec4e4610455b2e51
Author: Justin Suess <utilityemal77@gmail.com>

lsm: Add LSM hook security_policy_kptr_put

This commit adds a generic LSM hook for releasing a reference obtained
through security_policy_kptr_from_fd(). The hook uses targeted dispatch
by lsmid and includes a warning on a dispatch miss to prevent silent leaks.

> diff --git a/security/security.c b/security/security.c
> index 14fd8b878cd07..fd535bd00c244 100644
> --- a/security/security.c
> +++ b/security/security.c
[ ... ]
> @@ -5479,6 +5479,33 @@ int security_policy_kptr_from_fd(u64 lsmid, int fd,
>  	return LSM_RET_DEFAULT(policy_kptr_from_fd);
>  }
> =20
> +/**
> + * security_policy_kptr_put() - Put a reference on an LSM policy object
> + * @lsmid: LSM_ID_* value of the LSM owning @policy
> + * @policy: the policy object, in the member of the LSM identified by
> + *          @lsmid
> + *
> + * Release a reference previously obtained with
> + * security_policy_kptr_from_fd().  Only the hook implementation
> + * of the LSM identified by @lsmid is called, and @policy must have
> + * been obtained from that same LSM.  An implementation must support
> + * being called from a context that cannot sleep: the release of BPF
> + * managed references may be driven from object destructors.
> + */
> +void security_policy_kptr_put(u64 lsmid, union lsm_policy_kptr *policy)
> +{
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, policy_kptr_put) {
> +		if (scall->hl->lsmid->id !=3D lsmid)
> +			continue;
> +		scall->hl->hook.policy_kptr_put(policy);
> +		return;
> +	}
> +	/* A held reference implies the matching LSM implements the hook. */
> +	WARN_ON_ONCE(1);
> +}

[Severity: Medium]
Will this warning be bypassed if a caller mistakenly passes LSM_ID_BPF?

The commit message states that a dispatch miss means a caller passed the
wrong lsmid, and that the shim warns instead of silently leaking the
reference.

However, since the BPF LSM automatically registers a void-returning stub for
all LSM hooks (bpf_lsm_policy_kptr_put), it appears the dispatch loop will
match LSM_ID_BPF, call the empty stub, and return early.

Could this result in a silent leak without triggering the WARN_ON_ONCE(1)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731022047.1891=
37-1-utilityemal77@gmail.com?part=3D2

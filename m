Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49913FC5A6
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002644; cv=none; b=I78SS8IHbZXFUW4LpTA7PPZf7vWgZB7awHhqzrwSv7duwdaj0o3A78V1rpjkxQRG+1Pg2Z/9jh+x1EQ3B1pclUz1rwmA/q/RT3le1fZiGUck//hfB/g9G2fevfLhLhU7E5JaTZB5HvXineD4X8ZQ0UPKcx98Xurzyt2XBkeU2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002644; c=relaxed/simple;
	bh=7hsqIM5JNCdXhV+pA0KhrU4KlDgjcbD2V1QHTYCCPGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UeuUfCFGTIHM+vqPghOKoT9awvviEq24rTWfzrhJ0YbhtRLdPqlSpVeV+9j8XMeYHoqOFRKnad9/3nCdAFZVaDAF4x8PqNzitkK5mdqLHEOHTKvL2zYPuO0YdHSsaW7vo1WxxU0V4EtAZo6lWwKLd10GYJkXgjfF/twot4Pqiu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0FxaW6A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0FxaW6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311541F00898;
	Tue,  9 Jun 2026 10:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781002643;
	bh=U5eTPRqrYsXEcXWVv9aajnChI+cSu9fpTKbnLSDZmtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n0FxaW6AMqwiSIwghB6PKwodQfAFDOkEFvI76C+ZLJz52MtGGppx8y2uvhiR1eLdq
	 Ev4f5HxyOplnQq3Od+SbOgsa8Vk8di2JnfHbFyGx+1BiA+je3MhOYnfE+KZK3eS4Ab
	 yXJ5kxb/izg7YUPFidGgPCHbyrb5z+fX5fgMO8NxYMOkCEheR0304gHtx7kP6ZozZE
	 EXmnsE/7895wiO4Ed11/Fu11ToHxtcjmzDiVyEnJs4Ms8teKdw2Nbjw7SgHtWIjGtJ
	 +GC4qoEe6nhYxoByIA9yGdzBly+VCsk7JQY7zoXhA9DZRVK/PTFwgg1lk7VVYU/oRE
	 s6UPMRwRCtsdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add support to specify uprobe_multi
 target via file descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609104244.588321-3-jolsa@kernel.org>
References: <20260609104244.588321-3-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:57:22 +0000
Message-Id: <20260609105723.311541F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing strict zero-validation for the unused `path_fd` field wh=
en the `BPF_F_UPROBE_MULTI_PATH_FD` flag is not set.
- [Low] Mixing scope-based cleanup (`CLASS()`) with `goto`-based error hand=
ling in `bpf_uprobe_multi_link_attach`.
--

commit f7958ff1ce57c1ab456d3f134881a0081a58b8ed
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Add support to specify uprobe_multi target via file descriptor

This commit adds the BPF_F_UPROBE_MULTI_PATH_FD flag to allow uprobe_multi
links to specify the target binary using an already opened file descriptor
instead of a path string.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 970ce7bbf99e1..4965006d58ee6 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
[ ... ]
> @@ -3240,29 +3241,51 @@ int bpf_uprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
[ ... ]
>  	uref_ctr_offsets =3D u64_to_user_ptr(attr->link_create.uprobe_multi.ref=
_ctr_offsets);
>  	ucookies =3D u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
> +	upath =3D u64_to_user_ptr(attr->link_create.uprobe_multi.path);
> =20
> -	err =3D user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, &path);
> -	if (err)
> -		return err;
> +	if (flags & BPF_F_UPROBE_MULTI_PATH_FD) {
> +		/*
> +		 * When BPF_F_UPROBE_MULTI_PATH_FD is set, the executable is identified
> +		 * by path_fd, and upath must be NULL.
> +		 */
> +		if (upath)
> +			return -EINVAL;
> +
> +		CLASS(fd, f)(attr->link_create.uprobe_multi.path_fd);

[Severity: Low]
Does this code violate the cleanup subsystem guidelines by mixing scope-bas=
ed
cleanup with goto-based error handling?

The bpf_uprobe_multi_link_attach() function relies heavily on goto labels
for error paths (e.g., error_path_put, error_free, error_unregister). The
kernel guidelines state that goto-based cleanup and scope-based cleanup
helpers (like CLASS) should never be mixed in the same function.

Should this function be fully converted to scope-based cleanup, or should it
use explicit fdget()/fdput() without CLASS() instead?

> +		if (fd_empty(f))
> +			return -EBADF;
> +		path =3D fd_file(f)->f_path;
> +		path_get(&path);
> +	} else {
> +		/*
> +		 * When BPF_F_UPROBE_MULTI_PATH_FD is not set, the path is resolved
> +		 * relative to the cwd (AT_FDCWD) or absolute  using the upath string.
> +		 */
> +		if (!upath)
> +			return -EINVAL;

[Severity: Medium]
Should there be strict zero-validation for the unused path_fd field here?

When the BPF_F_UPROBE_MULTI_PATH_FD flag is not set, this branch is taken
and attr->link_create.uprobe_multi.path_fd is ignored without being
validated as zero.

If userspace passes uninitialized garbage in this field, it won't be
rejected. Could this break forward compatibility if path_fd needs to be
assigned a new meaning in the future?

> +
> +		err =3D user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, &path);
> +		if (err)
> +			return err;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609104244.5883=
21-1-jolsa@kernel.org?part=3D2

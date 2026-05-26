Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951873FDBF1
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804210; cv=none; b=Brp/a81rgbisRjFDwcQeT0/OzdtpTwT3jVw0kGrNyK/pP1v9MY1av0ovnVIkQE28vZLG5+O0ovHO/Qn56rktVYItnu3D6j95g04ryPaPCrQWqD1BTh9iIyzqqjn5i6vh+ROAuRIBSsGLISAr0vrJFLWGZxQdJEFxd03ZmbcobUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804210; c=relaxed/simple;
	bh=DI9CHT+SbGvvZQksRJiYkvPuG8VgUqjMwDCcl8Jjf14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uiQu19lTuQQTZ6qQEW9LyXvSP7wUi55oLUw2PDqzJlBZ8L7gmExAyh15/DtBOeVNFt0oCQFCtLAdbb92IaUF58iZHIGQujNujrTUMW9t6CJROVNdbfCY/9ETsr1N6i6q/xvc99dzmx6nT1cmAegNh3xT0dWlpa1kREO5/rEjx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8ISg70Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8ISg70Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187C01F000E9;
	Tue, 26 May 2026 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779804209;
	bh=xQyYO6AnsZg6O1viyXAc6GC8G68LA1RBliDlhPzTIBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C8ISg70QPvBcL3PgvhAZItghP7vpoNtT8nklUqoHx1GE2gPiwk7SRdu0Uqnf37mcO
	 yoorz8E4qxI9KVOXXlj5g/9kbUeXUWWm9SGOqjPyfGiy+Gty+FrfCaugX49DhNamCA
	 kDrYPHM5vVLSsCbfXqd5VyjvhuiE/oNK8sAlR7BJSXvMZ4ikDRM2nlU8SOjdvQT2dj
	 AKA4rvOKBL/vgVygsSVisjddNS1/zIwZvbnCqaOBsxf7cKzkYyUUwdwWLvIMw8/ruQ
	 MsyVwU6PWBHClf0fSptQ78gRKsO/YhTVBiXbdlmPZ0vOYgrOUkwakINJjKfJugygvg
	 LyQDx7/I1wi6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] bpf: cgroup: fix sysctl new value replacement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dawei Feng" <dawei.feng@seu.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526131035.1312864-2-dawei.feng@seu.edu.cn>
References: <20260526131035.1312864-2-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 14:03:28 +0000
Message-Id: <20260526140329.187C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Calling kfree() on the sysctl buffer can cause a kernel panic =
because the buffer is originally allocated with kvzalloc() and may be backe=
d by vmalloc().
- [High] The BPF-provided sysctl replacement buffer is not explicitly NUL-t=
erminated, which violates the VFS sysctl contract and risks out-of-bounds r=
eads in downstream proc handlers.
--

commit 87d6f30bc7d66708176be678dd7992a7d205d7b2
Author: Dawei Feng <dawei.feng@seu.edu.cn>

bpf: cgroup: fix sysctl new value replacement

This commit changes the success check from ret =3D=3D 1 to !ret in
__cgroup_bpf_run_filter_sysctl(). This allows cgroup/sysctl BPF programs to
correctly replace the pending sysctl buffer after bpf_prog_run_array_cg()
returns 0 on success.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 876f6a81a9b61..8715a014c21d9 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1935,7 +1935,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table=
_header *head,
> =20
>  	kfree(ctx.cur_val);
> =20
> -	if (ret =3D=3D 1 && ctx.new_updated) {
> +	if (!ret && ctx.new_updated) {
>  		kfree(*buf);

[Severity: Critical]
This is a pre-existing issue, but by activating this code path, could this
kfree() trigger a kernel panic?

Looking at proc_sys_call_handler(), the original sysctl write buffer is
allocated using kvzalloc(), which means it might be backed by vmalloc()
for larger allocations. If kfree() is called on a vmalloc address, it would
cause an invalid virtual-to-physical translation.

I noticed this is fixed in a later commit (bpf: cgroup: Use kvfree instead
of kfree in __cgroup_bpf_run_filter_sysctl), but should this patch be
self-contained to avoid exposing this bug?

>  		*buf =3D ctx.new_val;

[Severity: High]
This isn't a bug introduced by this patch, but now that this buffer
replacement path is reachable, does this violate the VFS sysctl contract
for null-termination?

The VFS sysctl contract guarantees that the write buffer passed to proc
handlers is a null-terminated string. Since ctx.new_val is allocated with
kmalloc_track_caller() which does not zero-initialize memory, and the
helper copies the buffer without explicitly appending a null byte, the
memory past the new length could contain uninitialized garbage.

Could this lead to out-of-bounds reads when downstream handlers pass this
buffer to string-parsing functions like kstrtoint()?

>  		*pcount =3D ctx.new_len;
>  	} else {
>  		kfree(ctx.new_val);
>  	}
> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526131035.1312=
864-1-dawei.feng@seu.edu.cn?part=3D1

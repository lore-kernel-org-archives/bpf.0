Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEBF3D301B
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778013583; cv=none; b=R8oumMJXGB8uhDynOSE7t9SzeXDZ7+lGKQtCc1QtfuH9wCByUi/PKMfXSh09SEH7Jy+cDY2FbYK+LV/a8Q8LrdZpZ7mxj1VfJ8qE/Q5zHkaNnuDBP+Y47ADxDnFsD6aV7kqP9aXv4XqNyefM75qQZRChGcBq2fcA1AjRwsfOwW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778013583; c=relaxed/simple;
	bh=5mmZoznD09C2W2EW3n4WEX9q9Yyz6goSHy8ef9v2XH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oq3DzGH2tVBMukQ67p29AV44eyrabSeD+xYdHkZHgxgKPTQdynwPc0mWZq59bGFI5fv7h8RT6F8Vd7ctRzkFWt/QPAg0w3IqKA/hLBm2JOKTEajWjh3SMLmQNrZImJfGC0fB+mGG+jH+RIeDqxEn3F3MwRz1RuKeFT5ikeqA0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEYvbGqR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEYvbGqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A3DC2BCB4;
	Tue,  5 May 2026 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778013582;
	bh=5mmZoznD09C2W2EW3n4WEX9q9Yyz6goSHy8ef9v2XH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XEYvbGqRnf84y1rWGWlCZ7IAMTUPRtAV5vBxK2PN365HXMHBe0dm46cKMhxx83H7h
	 p4T0GV0q6/ULkpDNKIGWpVjVdynZG/dJvYhjeIcksPuWg99vZxkkWKbmSCFdeeS9m5
	 WCuowop93KDLrwa8jGauEhwbjHUEskUwLNFEpBJ3feVYgU50sJ/jP7+EuOddmSbut6
	 mIMbFCkhlC0QtD6rjgJWankdkSKi2EJ4et056zYtqng6brmP2upUEYLOct2r6AV1lp
	 8/GSPf5XOVQ2yBg6CSyUiU6MaV7k8AnrF+jPeiOnwDf2w5QVU+HPS0sn4LTWJ4Ai+t
	 1rQc8xmcvBMsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 10/19] unwind_user/sframe: Remove .sframe section on
 detected corruption
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-11-jremus@linux.ibm.com>
References: <20260505121718.3572346-11-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 20:39:42 +0000
Message-Id: <20260505203942.98A3DC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent stack unwinding on a corrupted `.sframe` section trigge=
rs a user-controllable `WARN_ON_ONCE()`, leading to a potential Denial of S=
ervice (DoS).
--

commit a00e313eeb121415a3ca3fe4ed3b15126f46c76a
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Remove .sframe section on detected corruption

This commit removes the .sframe section on demand when corruption is
detected during unwinding, to avoid continued attempted use of a bad
section.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 9c755965ab837..8eed6a7d96256 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
> @@ -358,6 +358,10 @@ int sframe_find(unsigned long ip, struct unwind_user=
_frame *frame)
>  	ret =3D __find_fre(sec, &fde, ip, frame);
>  end:
>  	user_read_access_end();
> +
> +	if (ret =3D=3D -EFAULT)
> +		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
> +
>  	return ret;
>  }

Can this WARN_ON_ONCE() be triggered concurrently by userspace?

If two threads within the same process are being unwound simultaneously,
they could both encounter the same bad .sframe section and hit the
-EFAULT path.

Because sframe_find() is only protected by the sframe_srcu read lock,
both threads might call sframe_remove_section() at the same time. The first
thread will successfully remove the section and return 0.

The second thread will fail to find the section in mm->sframe_mt:

kernel/unwind/sframe.c:sframe_remove_section() {
    ...
	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
		if (sec->sframe_start =3D=3D sframe_start) {
			found =3D true;
			ret |=3D __sframe_remove_section(mm, sec);
		}
	}

	if (!found || ret)
		return -EINVAL;
    ...
}

Since found is false, this returns -EINVAL. Because -EINVAL is non-zero,
WARN_ON_ONCE(-EINVAL) evaluates to true.

Could this allow an unprivileged user to intentionally trigger kernel
warnings (and panic the system if panic_on_warn is set) by unmapping a
registered .sframe section and triggering concurrent unwinds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D10

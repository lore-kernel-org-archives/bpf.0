Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998954071DE
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374591; cv=none; b=gg44mOAsozK0P708pJmMaYZp03W8YSp36cPQJ5qYfLulR0/eOnuor5c6FbvrTnRiGKdhgexSAuy1nVdzLXE3+ZOtv/jXFQM2J5fUe1EpVgHxmZ34vMpaYlqdqZorTEgBgB3Ysstep6i95V7jp/H07U5OPaYjg+27ElfHeSV/EYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374591; c=relaxed/simple;
	bh=HGKXOUFT1UdbWhs+59+isEU9tMC61ALjm++nViA61+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ELKU6o0fpDn1JCalC8tZQh9iMnEUSc6v96n3aIj+YZB3gksIjjOAhJtNmRBWOKASFrihp16ouLNlvLO7Ppfq3rN34g3C3Kn2KvFD1dat4Z7rVP9z8fwlhq65G1aaEu0CX/lBIzXQSh+IsAF9BTIoXChTzRwtA5UhqjkQFpWWuOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU856j0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU856j0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCD61F000E9;
	Mon, 10 Aug 2026 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786374590;
	bh=gykY4aVeFF1poNy6Iv6QGPq+XPnaVGRyT0Pa0JE7er4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iU856j0bxKu7K6kQ/Aubl6m9MjFO9f3FcdFsAb1XUgl4xjMLnfyK5tsR6M6ojK2Wf
	 4YhsZu6HnYYEjQrW7mwTrFg0mnd2JFpJ9oB8TyIMAPqXfvtV75hw3XR0EGGbbZZR9s
	 /I+wHw8flk/mdu1EoBTipnqqVpV2H9T/v+zzWGRdd9Qalp4n+fJz6NsVjuANs/V9p+
	 fwEzcJ0ivfLwDqKFQBC7q0PuES7Y3MLyZTqAXtIFTxShGnaMoUliP8KNJ3IEhXMr4T
	 shfGncFUCP49IFSMSrhm1ExJQUEJrdQGdUOMLL5pDn2uFHOoawVJ9JzN5kRaazAms3
	 eqwc3rGkPbdrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 14/26] cachefiles,netfs: sunset ondemand mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, bpf@vger.kernel.org, "Anna Schumaker" <anna@kernel.org>, "Chuck
 Lever" <cel@kernel.org>
In-Reply-To: <20260810144746.574036-15-dhowells@redhat.com>
References: <20260810144746.574036-1-dhowells@redhat.com>
 <20260810144746.574036-15-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 15:09:49 +0000
Message-Id: <20260810150949.9FCD61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function declaration `cachefiles_flush_reqs` was left in `fs/ca=
chefiles/internal.h` despite its definition being completely removed.
--

--- Patch [14]: [PATCH v9 14/26] cachefiles,netfs: sunset ondemand mode ---
commit 3258008555b130612d694792049c301874f06845
Author: Gao Xiang <xiang@kernel.org>
cachefiles,netfs: sunset ondemand mode

This commit removes the on-demand read mode from cachefiles and netfslib. S=
ince
EROFS no longer acts as a network filesystem and doesn't use this mode, the
associated code and documentation are cleaned up.

Link: https://lore.kernel.org/r/CAOQ4uxi4dzxArY24YO=3D+kBCK2gGoq3Ptb8WkzCqS=
ogPgU_R3dQ@mail.gmail.com

> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index b62cd3e9a18e4..409492744bde6 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h

[ ... ]

> @@ -191,8 +146,6 @@ extern int cachefiles_has_space(struct cachefiles_cac=
he *cache,
>   */
>  extern const struct file_operations cachefiles_daemon_fops;
>  extern void cachefiles_flush_reqs(struct cachefiles_cache *cache);

[Severity: Low]
This isn't a bug, but it looks like the prototype for cachefiles_flush_reqs=
()=20
was left behind in the header even though its implementation was removed fr=
om=20
fs/cachefiles/daemon.c. Should this declaration be removed as well?

> -extern void cachefiles_get_unbind_pincount(struct cachefiles_cache *cach=
e);
> -extern void cachefiles_put_unbind_pincount(struct cachefiles_cache *cach=
e);
> =20
>  /*
>   * error_inject.c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810144746.5740=
36-1-dhowells@redhat.com?part=3D14

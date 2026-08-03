Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616A635A3A4
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759525; cv=none; b=aa+Q7gNEAuUtR9eZDkcom6BUGF3jjDhqhm4lah2FOyu+gdl4HRf8nKi0YX67+vuqvwsSXOO+0uQ9F+Xy36cprz4HHPBX56g901p43fB3ie974j7/bWHZEk/156/ydJKSe32zHHd7xRfH2tPR1Al88wAlcYjW3pSVJV1G4G2G5M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759525; c=relaxed/simple;
	bh=R1u2Rtv5wRPUPUXwshZXzWAnsq899oLmslH8Bxo0F5k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fa7ExibEPFRqyIKGJbocf/zzlnQxyTCPkc6jbTYzj6Cdn0lk67kwM4ucD06DNc/38SSbbJEaekyJ+VHhY6p+HR51NpwJ85vhyJxOFcChIim3o34UNYB5pVXZXjvRw4Yyb8k5+P2aKCOntPkQafpsqpAiiJi3GyMrEFJmLe31wac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4eVDUj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4eVDUj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBABD1F000E9;
	Mon,  3 Aug 2026 12:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785759524;
	bh=LLj6HNhy4hYxhugt23w0P0o4gxRWQQeUoN3kOYtDvWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D4eVDUj9/9DGFu0AbstAKp/S6mxt7W3p9BQPjIgcf1Ao+qKw4O7fzg8htDh9CEEco
	 7RlVObnIkPlOA/tXuR3s3jmRJ/jkcHY2lSr6VlhL4rENWKwhtm3d60ae6XEws7KkbW
	 kHv5YRTFgJSElBif9FQEPDoV6pUwilGd0yyFpTaTAfGXwD5wGcW7mxgyRYdaaUPhYa
	 5hfoCDCLaWdeLv5r4DrXrSqQ+DgjYaDIRE0ylPxbiRi8DHHCFtIowvczj15kI6Derl
	 +QCsncZ53y4cfWqrZi7BtCXanP8xyNRtSoJWhKbbFuhOAXFTbGgTAh11JLdq9k2S3O
	 FhZXiFGP+UxcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] binfmt_misc: document the pre-opened interpreter
 limit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803-work-binfmt_misc-interplimit-v1-3-4a2435500bd9@kernel.org>
References: <20260803-work-binfmt_misc-interplimit-v1-0-4a2435500bd9@kernel.org>
 <20260803-work-binfmt_misc-interplimit-v1-3-4a2435500bd9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 12:18:42 +0000
Message-Id: <20260803121843.BBABD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch inadvertently removes useful documentation about binding =
files with no path of their own (e.g., memfd, unlinked files) using `/proc/=
self/fd/N`.
--

--- Patch [3]: [PATCH 3/3] binfmt_misc: document the pre-opened interpreter=
 limit ---
commit 7e931b9fad1ca1a8aeab3afa756448374ff5e74d
Author: Christian Brauner <brauner@kernel.org>

binfmt_misc: document the pre-opened interpreter limit

This commit documents how pre-opened interpreters are accounted for and lim=
ited
by the new /proc/sys/user/max_binfmt_misc_interpreters sysctl. It details h=
ow
nested namespaces affect the limit and explains the -ENOSPC error behavior.

> diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/ad=
min-guide/binfmt-misc.rst
> index 622b5d8c89957..d26b63a27c259 100644
> --- a/Documentation/admin-guide/binfmt-misc.rst
> +++ b/Documentation/admin-guide/binfmt-misc.rst
[ ... ]
> @@ -215,10 +220,9 @@ with the credentials the entry file was opened with,=
 exactly the way ``F``
>  pre-opens a static entry's interpreter; the paths must be absolute. The
>  path is everything past the first space, so there is nothing it cannot
>  express, and no interpreter has to fit in a register string. An entry
> -binds at most 100 interpreters; a write past that is refused with
> -``-ENOSPC``. To bind a file that has no path of its own - already
> -unlinked, a ``memfd``, or reachable only in another mount namespace -
> -open it and write ``/proc/self/fd/N``.
> +binds at most 100 interpreters, and each one is charged against
> +``max_binfmt_misc_interpreters`` like any other binding. A write past ei=
ther
> +limit is refused with ``-ENOSPC``.

[Severity: Low]
This isn't a bug, but does this unintentionally remove the instructions for
binding files that have no path of their own? The previous text provided
useful details on how to use /proc/self/fd/N for unlinked files or memfds,
which seems to have been dropped during the rewording of the limit behavior.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-work-binfm=
t_misc-interplimit-v1-0-4a2435500bd9@kernel.org?part=3D3

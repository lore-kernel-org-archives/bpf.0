Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B835C6A1
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583707; cv=none; b=FRnCEzxHO3y6HvV9XzClVD02jcdU0N/Z3CHsw+SQg9N6qcRPZhuDLSxzb2VOs/XjNVZ5cYDs0wIdg6/m3DNoEheG8aoZJahkQzAz3oFkylm7ZTGAF52Dr8lub9RvScKiCcnW+wj04rBGubd1OFgrym+kASF4h42FTpZCuLhXOBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583707; c=relaxed/simple;
	bh=m/N6+HqnDANi1F1g27+mPl/pjVayTfK26PYd27xT5zI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TfSmEbxcA/RQx20r8lZHwePeZiYUA1KyCzVzDOnwLXN1mZOfe8htqAmrFCuVbf7diMk1dAMzlyjOj16UufCeryqftYoW52ZV6py5vmmWWXFlsrYs1yCNO0miKPrLgb3nt+NgDNNBJChiUr0AMjmeJobgP2EbXuBRXfl8l6uITtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lri7B4e5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lri7B4e5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433861F000E9;
	Mon, 24 Aug 2026 15:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583705;
	bh=m/N6+HqnDANi1F1g27+mPl/pjVayTfK26PYd27xT5zI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lri7B4e5jsQO67ovK1KRmAJd4xS9j72Gmsj7ZncD5dFuU2fgPd0KzAdtAgPMfS6uQ
	 Fkk2PssqRxTmwvpLf+bi9DDddxq2pV9fMVZU588KIaFfr8M100MzyOme3ISPm7uEt5
	 39FlgmIhASYOjv2x6hHAH5FHb9x8QFCGdDHPqp7aagGZaTdS8W9r5CjuT2F+M8hIFs
	 VXJGe0PAslnXr3pIIMzntphHsPe+o1y5V41Q//b4exKziMeJPVa+lEX5/ir70nY6sn
	 WDQick9PsDxg121tUB/YzPS7oWU2D7lm/7Ir/D+U40qxXJ+5cCso6pcwLpi2d8+n8I
	 /MAv9hZBe+hJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/35] cachefiles,netfs: sunset ondemand mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <cel@kernel.org>, bpf@vger.kernel.org, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20260824144130.759997-4-dhowells@redhat.com>
References: <20260824144130.759997-1-dhowells@redhat.com>
 <20260824144130.759997-4-dhowells@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 15:01:44 +0000
Message-Id: <20260824150145.433861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Removal of the exported UAPI header `include/uapi/linux/cachef=
iles.h` breaks userspace compilation.
--

--- Patch [3]: [PATCH v10 03/35] cachefiles,netfs: sunset ondemand mode ---
commit eb4335001c5a2237f8379d09b27bb7484e9e516a
Author: Gao Xiang <xiang@kernel.org>

cachefiles,netfs: sunset ondemand mode

This commit removes the on-demand read mode from cachefiles, as EROFS
over fscache is no longer an in-tree user and fscache is now focused
on netfslib. It also cleans up the related netfs, fscache, and cachefiles
code paths.

Link: https://lore.kernel.org/r/CAOQ4uxi4dzxArY24YO=3D+kBCK2gGoq3Ptb8WkzCqS=
ogPgU_R3dQ@mail.gmail.com
Link: https://sashiko.dev/#/patchset/20260716103030.3065561-1-dhowells%40re=
dhat.com
Link: https://sashiko.dev/#/patchset/20260722130218.78958-1-dhowells%40redh=
at.com

[ ... ]

> diff --git a/include/uapi/linux/cachefiles.h b/include/uapi/linux/cachefi=
les.h
> deleted file mode 100644
> index 78caa73e53434..0000000000000
> --- a/include/uapi/linux/cachefiles.h
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef _LINUX_CACHEFILES_H
> -#define _LINUX_CACHEFILES_H
> -
> -#include <linux/types.h>
> -#include <linux/ioctl.h>

[Severity: Critical]
Does removing this exported header break source-level compatibility for
userspace applications? Any program or container runtime that includes
<linux/cachefiles.h> will now encounter a file not found compilation
error when built against these updated kernel headers.

Should the UAPI header and its definitions be kept intact so userspace
builds continue to succeed, while instead just returning errors like
-EOPNOTSUPP from the kernel for these legacy ioctls and operations?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824144130.7599=
97-1-dhowells@redhat.com?part=3D3

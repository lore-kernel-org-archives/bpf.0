Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A7046F497
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547255; cv=none; b=kbAbbtgvr1Wc6tD6XR/lGUOrGex20qG7Ns1mTCrK1IeCTt5206ytlnb1y/97YUGLCfcigJk7NRqNYx0rYyt7g7BGc94UF4N5pcjjlPMCgvBDOckUNfdjOiGU8hkt4tWghG0EmGqMrc+6nMSdVXeq42V9cHQfvTT3RVTi3JSYcYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547255; c=relaxed/simple;
	bh=lHBw2dVHFKDxoFnsfw6babzkcso+Gc9LfF2lSLQJEB4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nP/lVj4DVfqbSf55lE4kLXbU4Fi8UYQhSITw7IXd3GeoLJTapPSu/UcWkNpLg2KVSZyzUCgMtNK4OSy4chK11EImSCnXcsE4BjU+rjj6sacMRpSWF3rM1O5ADffHvsXeDhecstHJiyxA5AJnp0A1z/Vyg7wuMv+S4SOxe+40BJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nffF9/81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nffF9/81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832781F000E9;
	Wed, 12 Aug 2026 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786547247;
	bh=lHBw2dVHFKDxoFnsfw6babzkcso+Gc9LfF2lSLQJEB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nffF9/81n/wGKj+wfttHQRNe+5djhqIk6o7cFPFgeT36bR555EZbdUa4+ccTwqLcx
	 mnNoxKato8/+GR6haHoiooUg0uWW8s6tIkhLAH9/YPJnRWCE9qfO/I7wlX0oq2Vs28
	 P0deJMSNprZsdUphpz8CEouKDNId/lLtPG/Pw4jxEgpZsjjMieGuvkVde9z13ZAViA
	 DyQUJCPJzSikpG3rXroGdg4DlMQPKZgae6fSbm2uxIMXeaF86VtzEgv+j+heeEvlXy
	 JTBEUivf5WTiyPcH7zIgg5kf5E7gL6MuWUOlPJq4qP/RA706Y2qqkJmLHiPCQD0jub
	 m1gIfRXhkz9Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cachefiles,netfs: sunset ondemand mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Howells" <dhowells@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <1046393.1786544127@warthog.procyon.org.uk>
References: <1046393.1786544127@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:07:27 +0000
Message-Id: <20260812150727.832781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Complete removal of the UAPI header include/uapi/linux/cachefiles.=
h breaks userspace compilation.
--

--- Patch [1]: [PATCH] cachefiles,netfs: sunset ondemand mode ---
commit e5845e932fdde67ddaf43301939e4efa8d4c2a07
Author: Gao Xiang <xiang@kernel.org>

cachefiles,netfs: sunset ondemand mode

This commit removes the ondemand read mode from cachefiles. Since EROFS over
fscache is now removed and netfs has evolved, the ondemand mode is no longer
needed and is being cleaned up.

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

[Severity: High]
Does this complete removal of the UAPI header break userspace compilation?

Even when a kernel feature is sunset and its runtime support is removed,
standard Linux kernel policy is to retain the UAPI headers (or leave them
as stubs) to avoid breaking userspace source compilation. Any existing
userspace applications (such as ondemand cachefiles daemons) that include
linux/cachefiles.h will fail to build against the updated kernel headers.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1046393.1786544127@=
warthog.procyon.org.uk?part=3D1

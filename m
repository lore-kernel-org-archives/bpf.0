Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8A4F4059
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776677; cv=none; b=NUtaELD6pvzlwbvRyt//RXumxyr8OjSfOGgBOFoSaYJHnPRmLhAfyXZBqADVLG8X9pvG2a4xkynsEAJC7VZq8y0y7vQYthvvhKux/EXdmvtbIh61lZXBNtWAs3qcBUfEy4ZzEfiGaW/lPt8mzLwlKyAJZVlNsGUK4uCi6d9+zKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776677; c=relaxed/simple;
	bh=Nry3nFCuqVWCFegzzAFM54lalWlidIpNtwv60/kgASY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QlORt+gVDu0q4Eo2pNV+E8YuJrXb3ZWA6VfiK/+7AQtRSTlI993x5CNoOTHi/6zQoIkBDgg9aNPVHvul0oVWwVilddyia258W8gGrMng+aM51r4ycvV0HebnTGlXy++uecDO6OKtMu+hagUGUTiGDk7irHzmY3lPZ5LUEqFx348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+tzeQBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+tzeQBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2CB1F0089A;
	Wed, 30 Sep 2026 13:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790776662;
	bh=U2vch9xD0f4302EDVC3E40ad28K/JNd/bcQaVZtvgPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C+tzeQBg0tejkmYpHdzZsp2Ko5AZVHBAoy96B4zyuv4nYNaQiAgRSjXbe+xiPIeyP
	 QR4X5FteP7N4QukgjWl9uKYD6Oe0IeBbCYfqSXX0vVYUK44LPluMFlKHR7uH0+dQGo
	 /d6aJZhLJEpn04bFrfOcB3262L+Pk0DMMZQYqOonGbgAeWpuEnwCbYYv0Rri86miH0
	 qyjchp1jxPba7OGEfSVMkTR6axIfhu+svdYctFMSyLknZVImx1XBm9wn33kaYf4fPi
	 I6KgMmgcF1AVFqHG3u46U56d9d3V6fwpoL9YhP0Kx+klTY3ArSUn6aVSTEKZz3n7VX
	 L6eKJT2Jsplug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/17] fsnotify: detach the connector before destroying
 its marks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930-work-mount-fixes-3-v1-14-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
 <20260930-work-mount-fixes-3-v1-14-be34c83956ae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:57:42 +0000
Message-Id: <20260930135742.9A2CB1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] fsnotify: NULL pointer dereference in lockless fdinfo readers
--

commit e6a7d29740f3498c210e8d2cef8ba5c5a72ce862
Author: Christian Brauner <brauner@kernel.org>

fsnotify: detach the connector before destroying its marks

This commit moves the detachment of the fsnotify connector from the object
to the beginning of the mark destruction process. This prevents new marks
from being added to the connector during the destruction walk.

> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index b2640d836a712..f6891d39e42fe 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -1112,6 +1112,16 @@ void fsnotify_destroy_marks(fsnotify_connp_t *conn=
p)
>  	conn =3D fsnotify_grab_connector(connp);
>  	if (!conn)
>  		return;
> +	/*
> +	 * Detach the connector from the object first. Once conn->lock is
> +	 * dropped a mark could be added in front of the one we're at and the
> +	 * walk would miss it. fsnotify_grab_connector() refuses a detached
> +	 * connector so any mark added from now on gets a connector of its
> +	 * own. This also stops pinning the inode until all mark references
> +	 * get dropped. It would lead to strange results such as delaying
> +	 * inode deletion or blocking unmount.
> +	 */
> +	objp =3D fsnotify_detach_connector_from_object(conn, &type);

[Severity: Critical]
Will this early detachment expose a NULL pointer to concurrent lockless
readers?

By moving fsnotify_detach_connector_from_object() to the beginning of
fsnotify_destroy_marks(), the connector's object pointer (conn->obj) is set
to NULL before the marks are removed from the group's list.

Concurrent lockless readers iterating the group list might observe the mark,
check the connector type, and attempt to read conn->obj. Because there is
no lock synchronization or memory barrier enforcing the visibility of the
detached state before conn->obj is cleared, a reader could see a valid
type but a NULL object.

This regression might be triggered if file unlinks race with reads of
/proc/<pid>/fdinfo/<inotify_fd>. For example, could this cause a NULL
dereference in inotify_fdinfo() via igrab()?

fs/notify/fdinfo.c:inotify_fdinfo() {
    ...
    inode =3D igrab(fsnotify_conn_inode(mark->connector));
    ...
}

Similar lockless access patterns appear to exist in fanotify_fdinfo() and
when fanotify_remove_mark() locklessly evaluates the connector mask. Can we
safely detach the connector this early without breaking these readers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-work-mount=
-fixes-3-v1-0-be34c83956ae@kernel.org?part=3D14

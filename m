Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90236156661
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929893; cv=none; b=mAec1VX5PoXxLUYnc0WwwLdrzHSFUmLhPohcpilUbjlUEBRQunla2GJMsPtbC2s24GzA+7bCAXpUo1xQxkdE9OdP2VNYbVolzY7uK74b2Jzk/oMn2f1/9rANlq+cRbfCYKi9/mSjpZdBLJNXa+pXTw0JrRT47vcHtgLemjrOxRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929893; c=relaxed/simple;
	bh=bmgHfa1oX0pSLAvDhj1lJRn9aW7lq5cDlA3X62XUJyY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lL44DrputbJ4io9rypWUbGUVdBcrckgkoGPQ7kAh8XbCIm4Ei1xbpV/Ryxkxqusl2Q7ggMMAxBjK/Dgel3b+HdkyqK9gpcBDhAjn1rTxwAq5uBHEUIoKeDqbu5AsdMoPVx+ZEps/B/7AMIfzgCYhNOZH6v6qZejuwhbrWTnBczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWqSHBTM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWqSHBTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F29C2BCAF;
	Thu, 23 Apr 2026 07:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776929893;
	bh=bmgHfa1oX0pSLAvDhj1lJRn9aW7lq5cDlA3X62XUJyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AWqSHBTMS4ioMg+CRWZl/+qYwhH0HkY6Y7oQDmGiuYsmqxQ4s0iUdiUL2UjL6tenC
	 YO7I+sllHIQVXc+K4hekoSio7fT7eBUQigddRr2ZutGSEPK8nITo2IxDhUvd1k+CdQ
	 UTyFI2clXaehcE/Pt03ZWsfVay3bOWPll8w4RDe5jFfBaDBCMChlFUAXENjjr8jD53
	 VIp4f05OJ3Pn/5ArjH9j4pkI7TkMSsgPokx0AtVNvwPshO4w3xebuVmDr9VqRa+44P
	 bSSCR+YeW4oG0YcM4VlbWfTAcZzhRBqyHQIGqIS4BVaI4LiW5WLwL5CrEDPg4o+mI0
	 U1kagJMClHZ8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3] bpf: Fix NULL pointer dereference in
 bpf_sk_storage_clone and diag paths
Reply-To: sashiko@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260422065411.1007737-2-bestswngs@gmail.com>
References: <20260422065411.1007737-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 07:38:12 +0000
Message-Id: <20260423073813.13F29C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] diag_get() leaks uninitialized kernel memory to user space when du=
mping BPF map values containing special fields (e.g., bpf_spin_lock, bpf_ti=
mer).
--

Note: The format of this review has been altered to provide a free-form
summary without quoting the original patch code directly due to recitation
restrictions.

commit 32307cca407ebdd5cf1feae057cd9956ec19daa4
Author: Weiming Shi <bestswngs@gmail.com>
Subject: bpf: Fix NULL pointer dereference in bpf_sk_storage_clone and diag=
 paths

This patch addresses a race condition where a concurrent RCU reader in
bpf_sk_storage_clone() could observe a selem with a NULL smap, leading to a
NULL pointer dereference. It adds NULL checks in clone and diag paths and
updates diag_get() to take the validated smap directly.

While reviewing the changes to the diag_get() function, I noticed a
potential pre-existing issue regarding how map values are copied to the
netlink attribute.

Does this function leak uninitialized kernel memory to user space when
dumping BPF map values that contain special fields like bpf_spin_lock or
bpf_timer?

The function allocates space for the value using nla_reserve_64bit(), which
reserves space in the skb but does not initialize it. It then copies the
map value into this space using copy_map_value_locked() or copy_map_value().
However, those copy functions intentionally skip copying special fields,
leaving holes in the destination buffer.

In the standard bpf_map_lookup_elem() syscall path,
check_and_init_map_value() is called to explicitly zero out these holes
after copying. Since diag_get() does not appear to initialize these holes
before sending the netlink message, could uninitialized skb memory be
exposed to user space?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422065411.1007=
737-2-bestswngs@gmail.com?part=3D1

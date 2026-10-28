Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200071;
	b=YKh2csjVrBVrJJdrz8nLeeYG/2i+qkVb4wdruOi0DAuw37XVZSlV8EAvsIURravUiVoi
	 6xxVWIAJYtb/SiBKo5dh4pWfDGGODntWBhK096glIm8ZHMIBflmCr1kGn4kmxsGq+6d0Q
	 TjeEWqBQ6B+2ZGpSrLG0DvVXNjPPzsDN6y9ROHCkw4cl/rwu+aiO+DHAqt7a7KeMCagoq
	 wl6VXtsE+DfLYibEGnzWTBgXtcLuKb/+fUIKNRjhoVTJs9IA/52Qnma14Drhy15oZBXMF
	 l5U6IJMaDSv1mmPJPqrpqlJFcmwatc0caHSOZFknqo3tO6UVo6x1+TKGtkdsTue6RIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200071;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+uMcQMbhx0su6lr+nNnHJAEr4mhA/4anPG/zP5Txduo=;
	b=qcJ1j5D82Wo5SIYgthchbyZclup1c/x4IM2Klz4Dv4HAj4KyX8NSWq9gtcZ63iq4xVS0
	 H96HKZkBo3tS/fTCnUujKDFh05qMWDqS32itycbYjSME+fkae1HVMjAXmuwx06yXig9DM
	 M8eKgl57Y7bKIkYo+vFjZMKp8kryhf8eaS1fUTwoVAU8ETzfXV3ByDa/Up5w8k1sNX9m7
	 fcm7ryxzfn51v/UWPo29KrkIqVTLKySwpl08oYh8i55esuVlZ+ufDh+P0O0f1nTKio4Jb
	 bPfXs2F5xcrrox/9NcA9ndqWz6rBdC7VjkFk18NBYrd32ocaV3W+UeUJyBLfYWjn2/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGJzy4J0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B957606A333
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGJzy4J0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88751F031E1;
	Wed, 28 Oct 2026 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793200071;
	bh=+uMcQMbhx0su6lr+nNnHJAEr4mhA/4anPG/zP5Txduo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SGJzy4J0Z4qM9JlPbNyD26EnEbwCmXtqmaBZdCtSN0qhs0wTaDOQjt4wgxK6jRKR/
	 5f4p7RAgLCxAn4YFfbisHulcQ34Kzsml/W2BumDov9HDkm+UOuWm7fHhF1Hnx/hwdP
	 8muw76K08KcYemTLrM+mquMMr3K8ZIPZKyMeaJl3aBhFVnX6/GMHdCM9E2kHKGzdbx
	 9y1hjFoocxsLFhKMEjdWb2WWCRfIQ0NOKlMo9byzrlzJO74Fa7S8i4RCwT0cr5akET
	 n+S3FMzXPtq4ykl022ZTkCnyaZWSBGmk1MITk0/puhmJaiXdUfCnA0OjYbXDyViBTy
	 pxirrf7HoJvIw==
Message-ID: <sashiko-outbox-188036@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] blk-iocost: add BPF struct_ops cost model support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261028143534.135968-3-cui.tao@linux.dev>
References: <20261028143534.135968-1-cui.tao@linux.dev>
 <20261028143534.135968-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:07:50 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] blk-iocost: duplicate comment opener in block/blk-iocost-bpf.c
--

commit 8a9cd6a3cb263ab4dbba729b48cb1180333ad71b
Author: Tao Cui <cuitao@kylinos.cn>

blk-iocost: add BPF struct_ops cost model support

This commit adds BPF struct_ops support (iocost_model_ops) to blk-iocost so=
 a
BPF program can take over IO cost pricing for a block device and track onli=
ne
cgroups via iocg_init() and iocg_free() callbacks.

> diff --git a/block/blk-iocost-bpf.c b/block/blk-iocost-bpf.c
> new file mode 100644
> index 0000000000000..8ff51c26fb253
> --- /dev/null
> +++ b/block/blk-iocost-bpf.c
> @@ -0,0 +1,464 @@
[ ... ]
> +#include <linux/blk-mq.h>
> +#include <linux/mutex.h>
> +#include "blk.h"
> +
> +/*
> +/*
> + * Deliver iocg_init()/iocg_free() to the cgroups already online on the
> + * queue: init walks q->blkg_list in reverse so parents receive it first,
> + * like blkcg_activate_policy(); free walks it forward like the blkcg
> + * policy teardown. The queue is frozen and quiesced; queue_lock
> + * serializes against blkg creation and blkcg_mutex against the delayed
> + * list removal in blkg destruction; the callbacks are called with
> + * ioc->lock held, the same lock the attachment updates take.
> + */
> +static void ioc_bpf_deliver_iocg_callbacks(struct ioc *ioc,
> +					   const struct iocost_model_ops *ops,
> +					   bool init)

[Severity: Low]
Does the duplicated comment opener above ioc_bpf_deliver_iocg_callbacks() in
block/blk-iocost-bpf.c trigger a -Wcomment compiler warning (or break the
build under CONFIG_WERROR=3Dy) when CONFIG_BLK_CGROUP_IOCOST_BPF is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028143534.1359=
68-1-cui.tao@linux.dev?part=3D2

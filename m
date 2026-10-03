Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16466381EA9
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991229; cv=none; b=GMKFB2jrvK70jTmvYcV2/wDO8Q1L6a+04menVLLa9na6zdMpKqfmsM7nJV/Rz0KxpL340uAcmv0mFquIYLmvzWB8PGm/V7n6nXhk0e5C+EA3ak8biIZQMrJr7EneEw+uQB91jSat7/xjY35CcPgkU/qdKg31WDkX8RHR+UZNvLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991229; c=relaxed/simple;
	bh=wCoXTILTFs5Heb3GmLcVNYCPljv/deoBgLdgoVnJ+jE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BVtaIJxipuDRBQPVslE+7lK3DTnbJGlNXcaAZ5fqR96uABup2/jRnMc1WmGGLKwmokkGAiYZnBhfvS3b8aGXZU/vxy8VhnGg97sUbKpLTXe4mCVTSzhqO7S7Am2KMVL8ALZeH+1MRHx3CbSFl4yi+1L9vj0KOoLH0xRbMdDB+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIhZIJcu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIhZIJcu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10671F000FF;
	Sat,  3 Oct 2026 01:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991228;
	bh=wCoXTILTFs5Heb3GmLcVNYCPljv/deoBgLdgoVnJ+jE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SIhZIJcuGDttENbTq3lmVLtaqrBaoo4k9W6AotVw89INMVPT/JdYvOklFtWUGzbKu
	 Ah54unyGyi3WMenYM5CHDqGuX8h6mSXGbPthDQ1bs8rnz3sYnZOZ77v0IAp7NwQ3NT
	 F9zMq9eTzCpUp+Z7VEWMJYzOYB9JVGvO1NcKA2MGt8DwV8j0xbSjWpRtHRiNQRSu+n
	 DnXSl+BL2GUkwzbKL8ljXaa/ut1d8hFQ8H/IuNRKZti4XQTHs5pdJ1JBa5W0EEr4QA
	 bEi5l07InBhq2uYMMXKVI1mq75kIvtHu9FHtljcQ8GcRJ1zd1dx96GbTZLSiuWmdid
	 sQ33PS6dM09qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y 2/2] bpf: Defer work in bpf_timer_cancel_and_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Dinaburg" <artem@trailofbits.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261002193020.19392-3-artem@trailofbits.com>
References: <20261002193020.19392-1-artem@trailofbits.com>
 <20261002193020.19392-3-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:47 +0000
Message-Id: <20261003013347.C10671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: Use-After-Free in bpf_timer_cb() due to deferred cancellation
--

commit 12eef63fe47026afa8702d0bccb135f5bc2594fe
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Defer work in bpf_timer_cancel_and_free

This commit addresses a deadlock and potential use-after-free situation in
the BPF timer subsystem by deferring timer cancellation to a workqueue when
invoked from within a timer callback context.

Link: https://lore.kernel.org/r/20240709185440.1104957-3-memxor@gmail.com

[Severity: High]
Does this deferred cancellation introduce a use-after-free when map elements
are freed synchronously?

Looking at kernel/bpf/helpers.c in bpf_timer_cancel_and_free() (around line
1476), the code defers the cancellation by calling queue_work() if
this_cpu_read(hrtimer_running) is true.

However, if a BPF program executing in a timer callback deletes a map
element containing another timer, the deletion path in kernel/bpf/hashtab.c
(in free_htab_elem) calls bpf_timer_cancel_and_free(). Because the
cancellation is now deferred, free_htab_elem() continues and synchronously
frees the map element, for example by pushing it to the PCPU freelist for
preallocated maps.

If the deferred timer is currently running on another CPU or fires before
the workqueue executes, bpf_timer_cb() in kernel/bpf/helpers.c (around line
1162) will execute. It extracts the value pointer from the timer and passes
it to the BPF program callback:

callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);

Since the map element containing this value was already freed by
free_htab_elem(), could this allow the BPF program to read or write freed
memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002193020.1939=
2-1-artem@trailofbits.com?part=3D2

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF1D47F2EA
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522438; cv=none; b=arqg9/CmZi2DnGA/EZyuaBctBzFEl2WWp4FMrH5tu6QbbhpJQBMEdxxX8srNiVlPJvSZ/YceMGHqkrFafTc9qe1Dib8wzJbMvvI2/c/dpfDWh4q3rwta97JOWRcJnhKZiN0fIldeedfi1vs+BotUbrmywv7z5on6XasT+kllOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522438; c=relaxed/simple;
	bh=NN9WzawSVkpijGCZ0HvEA3ACWXhwptdzqhn6Ll9QcjQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qFforp92dxRAGSwUV54sqxwUyGZ6eVoUATAR9hy1E/7598TVLFY8WozdT6jIReTokefzndsBaLp/bViK2G5yIHBjVRIE+5vBJsOCbFO/sr1SiTQQ/yfHXUxOZkdWWoixrp1aL/3DK66auLd4soPW+aQeOjGaAJTPIaGDfIjj6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLphe5Fw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLphe5Fw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEE81F00A3D;
	Fri,  4 Sep 2026 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522437;
	bh=DaBZSdIFTUOPY89Oz9mADOmnAvqX9o9LccNFCBlIQbQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mLphe5FwxfD1X3Tiss0rmH/rDW3oDNohN3+lw5pKP9XNoZxmCTrYFtXCwHs3tuzmK
	 nqHqAqmP/tESh4O9474Zy17afT99K4kL3cQMASg/xcAVc5FcN6q6SxH8qqOYTBE1ue
	 uSduvUxOI3rd8YozsHkrZm/vPVlo2gAnafkXr9AtABfgyHVDRGaWxF7dF/jQzqC9A7
	 Ttf8c+WlKjhvNSBGYxEJpkTE6t9cE7eJOszcr47x/V3VWIY5vJfm//goBESyQ1aZ6k
	 9mUAj+vHqnOyYmwXGX6fmY4O8lp9FZUxdRjuBQuDkVsR1ryDcWidBTFLQBtmGV3y1c
	 L9Q9baioW2gCQ==
Content-Type: multipart/mixed; boundary="===============4909590059671924964=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a9617a32fb52d4f95694a95b920cde3e797c0291d0fde9b95cf8b6beadaef33d@mail.kernel.org>
In-Reply-To: <20260904104203.345917-8-memxor@gmail.com>
References: <20260904104203.345917-8-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 7/8] bpf: Preserve inner map identity in callback frames
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 11:47:16 +0000 (UTC)

--===============4909590059671924964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Preserve inner map identity in callback frames
>
>     Callback frame constructors initialize map-typed argument registers with
>     __mark_reg_known_zero() and then restore map_ptr. This clears map_uid,
>     which is the only field distinguishing inner maps that share an
>     inner_map_meta template.
>
>     When a timer callback invokes bpf_for_each_map_elem() on a second inner
>     map, both the saved first map and the second map value can reach the nested
>     callback as the same template with map_uid zero. bpf_timer_init() then
>     accepts pairing the timer from the second map with the first map.
>
>     The runtime records the first map in the timer without taking a reference.
>     Freeing that map does not find the timer stored in the second map, so a
>     later timer callback dereferences the freed map.
>
>     Copy map_uid from the same caller register as map_ptr when constructing
>     for-each, timer/workqueue, and task-work callback arguments. The existing
>     identity check can then reject mismatched inner maps while allowing a
>     callback value to be paired with its actual map.
>
>     Fixes: 3e8ce29850f1 ("bpf: Prevent pointer mismatch in bpf_timer_init.")
>     Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
>     Fixes: 5c8fd7e2b5b0 ("bpf: bpf task work plumbing")

The Fixes: 69c087ba6225 tag references a commit that cannot contain this
bug. The bug being fixed is that callback frames lose reg->map_uid, but
map_uid did not exist anywhere in the tree at 69c087ba6225 (Feb 2021).

Running 'git grep map_uid 69c087ba6225' returns nothing. BPF timers, which
were the first users of the map/field pairing check, only arrived with
b00628b1c7d5 ("bpf: Introduce bpf timers.", Jul 2021).

The inner-map identity confusion was introduced by 3e8ce29850f1
("bpf: Prevent pointer mismatch in bpf_timer_init.", Jul 2021), which
added map_uid and the (map_ptr, map_uid) identity check now living in
process_map_ptr_arg(). That commit did not update
map_set_for_each_callback_args() to propagate map_uid into the callback
frame.

Should the 69c087ba6225 tag be dropped? The tag only misdirects backporting
(stable AUTOSEL and distro tooling will try to apply the hunk to trees that
predate map_uid, where it does not compile) and misattributes the
regression. The existing 3e8ce29850f1 tag already covers the timer and
for_each hunks, and 5c8fd7e2b5b0 covers the task_work hunk.

---

The Fixes: 3e8ce29850f1 tag is referenced in the commit message, but the
bug in set_timer_callback_state() was actually introduced by an earlier
commit. Commit b00628b1c7d5 ("bpf: Introduce bpf timers.") introduced
set_timer_callback_state() with the pattern of calling
__mark_reg_known_zero() without restoring map_uid.

Commit 3e8ce29850f1 introduced the map_uid field and validation logic, but
set_timer_callback_state() already existed with this buggy pattern at that
point.

Should the Fixes: tag for set_timer_callback_state() point to
b00628b1c7d5 instead of 3e8ce29850f1?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33865340224
--===============4909590059671924964==--

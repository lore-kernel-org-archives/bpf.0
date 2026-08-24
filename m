Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084B3C1419
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573851; cv=none; b=k1fBAdNdasdNwOqQZSdxcOPjVaQMEfYIai+rQArKNlvs6GQUZEmy9/6C0/DzNom2fNzIkgaZ6QTMJ8/+H7ZCaLncZQ+JQs+HONS+rUdy3Evsyd+21SdMgjp95UcrF+WtMJt32KNc7UxCZhLWw57/UghCfO7F1ahG5PFQ6HqOaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573851; c=relaxed/simple;
	bh=eBRYWWR8nfbWr4mOjGeytAgn05HIL4uZdSxjG+BbOBY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=j9PEkS+DGkpTe6n7mvAj547kuZRC0dqCv7l1QEJK5jDY2CnN6gMV2x2BSCcWexxzTSExKgYEEN3vkXcYEy6HBCLnTCIFCtTKdsdRsPrWXOHWJQJXABK4x6aFtCKxygELtnlzn/HDUwaKLgEX1qiwj9vrB5EEF4WtCJF/EXn0wLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJRx3xQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJRx3xQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE151F000E9;
	Mon, 24 Aug 2026 12:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787573850;
	bh=ATuVilTHTL5dbwXLqnW5LKKYozfJXag+sxOoWSGt6ak=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NJRx3xQaiMcQo+sUEHcIe8TEN1fFKtgVJazLb1iQaPnabuqHnPCMZfWaTEEEVrz1+
	 ob5r9B2Z/+O37za44WOCXUK/Z78YGPTHsQFSpjg5/3jGgq54u2VDKEjEmHWS/7Kdhe
	 512gbl3jIjQBNvjIVwbBPk/aujW8sGfNO3X7u9y9yY/gGU5iVyMY4jkDpXeaR5S/gF
	 OZpELT13fTY9q34Guo/LAhii+JKvPbOzzR1vSB2/usYvhD42/QGoqW/3UUcMunhnsX
	 7q+dUhdsCGG+rvHJpT3MohgrDZVPKvl4RhE/9H7O455BhZEcYR+Fex6HQiIg03giS7
	 1E2UlQ4nefjtQ==
Content-Type: multipart/mixed; boundary="===============2527444145715287312=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8ccf80b6fd9c4203cb1a8a065a5fdde73565964037a89e68c624c0d7135f3711@mail.kernel.org>
In-Reply-To: <20260824113123.270057-1-maghasi@disroot.org>
References: <20260824113123.270057-1-maghasi@disroot.org>
Subject: Re: [PATCH] bpf: Fix u32 overflow issue in map batch operations
From: bot+bpf-ci@kernel.org
To: maghasi@disroot.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,brianvv@google.com,maghasi@disroot.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 12:17:29 +0000 (UTC)

--===============2527444145715287312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")

The single Fixes: tag covers only one of the three commits whose code this
patch corrects.

cb4d03ab499d introduced generic_map_lookup_batch() - that tag is correct
for the changes in kernel/bpf/syscall.c at generic_map_lookup_batch().

The other hunks fix different commits:

generic_map_delete_batch() and generic_map_update_batch() were added by
aa2e93b8e58e ("bpf: Add generic support for update and delete batch ops"),
which introduced the buggy expressions:

    +       key = __bpf_copy_key(keys + cp * map->key_size, map->key_size);
    +       if (copy_from_user(value, values + cp * value_size, value_size))

__htab_map_lookup_and_delete_batch() was added by 057996380a42 ("bpf: Add
batch ops to all htab bpf map"), which introduced:

    +   if (bucket_cnt && (copy_to_user(ukeys + total * key_size, keys,
    +       key_size * bucket_cnt) ||
    +       copy_to_user(uvalues + total * value_size, values,

Without these tags the stable backport scope is wrong: a tree that has
aa2e93b8e58e or 057996380a42 but predates cb4d03ab499d (or vice versa)
will not be matched.

Would it make sense to add:

  Fixes: aa2e93b8e58e ("bpf: Add generic support for update and delete batch ops")
  Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")

> This patch resolves the mentioned issues by converting the cp's type
> to size_t in the effected places.

The changelog misdescribes what the patch does, in two ways.

First, no type is converted. The diff only adds (size_t) casts at the use
sites; every declaration is untouched. generic_map_lookup_batch() still
declares "u32 value_size, cp, max_count;" at kernel/bpf/syscall.c,
generic_map_update_batch() still declares "u32 value_size, cp, max_count;",
and generic_map_delete_batch() still declares "u32 cp, max_count;".

This matters beyond wording, because actually converting cp to size_t would
have been a bug: all three functions report progress with

    copy_to_user(&uattr->batch.count, &cp, sizeof(cp))

and uattr->batch.count is __u32 in the uapi, so a size_t cp would write
8 bytes into a 4-byte field on 64-bit. Casting at the use site, as the
patch actually does, is the correct approach - the changelog should
describe it that way so a reviewer does not "simplify" it later.

Second, there is no cp in the hashtab.c hunk. __htab_map_lookup_and_delete_batch()
uses total (declared "u32 bucket_cnt, total, key_size, value_size;" at
kernel/bpf/hashtab.c), so "the cp's type" does not describe that change.

(Also "effected places" should read "affected places".)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32723998558
--===============2527444145715287312==--

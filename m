Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F820233134
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 00:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619922; cv=none; b=OwkyVOALpIwuWTnsh/wi6st7/6klbl7YMQkcaMp3/urJm+CvUUUaa5utDSE4CuHxTB3d1LuWLGwoTILKtudUEQoFCbf3LxQYUPxFji4TBhnAHE45OyjtshQjOauApDTxTWm7zBZupUk6YJOdcUFc/Um0wQU6nknuiZDKvOZTa0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619922; c=relaxed/simple;
	bh=EAn9vzqrKK45Dx3TR1RsHfF5v/e3DG0JI1wF7jIWfPI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qn1DfcaKEl/RmuLvyKE3JSwSno1YNtu9cYyNDz02vXbyV+kPWvz6hf81/gy7r8gPcx9yc0kR2dCP6a1+tX2FU7aNmjVjwLeLEy52O5PCTvF7finwPCVPYt5z9Em9cu5/p/fs6AN/Gp2rAOdt5sRSOWVK1Z2St9xh8YtZN2IQzq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g41BUuSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g41BUuSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8281F00893;
	Fri,  5 Jun 2026 00:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619921;
	bh=M/cjk3+uN93/YeKlk+NwlSzigUvLHuyV7zmOJZno3BM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=g41BUuSK+A+qxuzKbTfBOCdK3ZeMGpWGws43VNQDQjxWN5H9Kn9OS2gq5kMxCqKVG
	 fs8L0sSUKsKp6bMnhu99m53OtDZs/JTYlWIw7J48vNw4ELSRvwgtXzXSetEWx7BM1i
	 v3vhkJ6vcUnl7g+4EgTFBtspihAWXclE8URK3RNlUzOv9BpQA0Q8rCnAaXpYig76e3
	 QFqOi06bYyOBJg76U9stj6weioCG3d6woDaIzcDEiQ2MIrKweS67Q54HXIJAlAagF+
	 rPt+mT1t+8xhsPHxBfwJBXJshCFFBlYM+Pawkerl3Dvv/+IoFSUrbY5Aam8B/W+nuw
	 reEemW67RKH7g==
Content-Type: multipart/mixed; boundary="===============8993415648243942955=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0a64b83a809357ae1367cd92c06ba52a92fe472d00571fdee4b7313ffb309160@mail.kernel.org>
In-Reply-To: <20260604235016.20856-2-emil@etsalapatis.com>
References: <20260604235016.20856-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 1/3] selftests/bpf: libarena: Add rbtree data structure
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 00:38:41 +0000 (UTC)

--===============8993415648243942955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> new file mode 100644
> index 000000000000..000000000000
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c

[ ... ]

> +__weak
> +int rb_destroy(struct rbtree __arena *rbtree)
> +{
> +	int ret = 0;
> +
> +	arena_subprog_init();
> +
> +	if (rbtree->alloc == RB_NOALLOC) {

Should this check rbtree for NULL before reading rbtree->alloc?  The
other exported entry points open with:

	if (unlikely(!rbtree))
		return -EINVAL;

so the missing guard here looks unintentional.  The same question
applies to rb_least() below.

[ ... ]

> +	while (rbtree->root && can_loop) {
> +		ret = rb_remove(rbtree, rbtree->root->key);
> +		if (ret)
> +			break;
> +	}
> +
> +out:
> +	arena_free(rbtree);
> +	return ret;
> +}

When rb_remove() returns an error the loop breaks and falls through to
'out:', where arena_free(rbtree) runs unconditionally and the non-zero
ret is returned to the caller.

Can this leave the caller holding a freed rbtree?  The caller sees an
error suggesting the destroy did not finish, but the handle is already
freed, so any follow-up access (for example a retry of rb_destroy())
would be a use-after-free.  The nodes still in the tree are also leaked
on this path.

Would freeing the handle only on the success path, or returning 0 once
the handle is freed, make the contract consistent?

[ ... ]

> +__weak int rb_least(struct rbtree __arena *rbtree, u64 *key, u64 *value)
> +{
> +	struct rbnode __arena *least;
> +	if (!rbtree->root)
> +		return -ENOENT;

Same NULL question as rb_destroy(): this reads rbtree->root without
first checking rbtree, unlike the other APIs.  Should rb_least() also
do:

	if (unlikely(!rbtree))
		return -EINVAL;

[ ... ]

> +		if (rbtree->root) {
> +			arena_stderr("WARNING: Trying to destroy RB_NOALLOC tree "
> +					"without removing all nodes");
> +			return -EBUSY;
> +		}

This isn't a bug, but in review of an earlier version it was suggested
not to split string literals across lines since it makes them harder to
grep for, and that going over 80 or 100 columns is fine.  Could this
warning string be kept on a single line?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26987200618
--===============8993415648243942955==--

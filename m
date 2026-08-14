Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6194908DF;
	Fri, 14 Aug 2026 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733816; cv=none; b=a0zX57KmbipKI8X+nz/YXlij6CGqbvEk1CcNcdNcKJgrOw10nUdSpuzTmMrsyq8v3yPwnUR0ypVdd5QTnXuWT9Z8Zr0QfAJxnSl5F8UO2DSkxZWfQoteZcsgv7hCeCz9Qb/Hylp3hG+hNs+pO7+QLFNiH32/zYjsne3a5xs13pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733816; c=relaxed/simple;
	bh=fvUQh6hrewjOc9QpHR1VpYoAFACpSE3cpDOUJAH20Gw=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=onnPbdZrYOLAgufh36OkxyVZxfJJ+tUQYd+yqfArK6oOtRfZbLrB+K/W7pkA7egtl2Qc/7stYPvqnzCvCgQDPevaKLeZuGqFCz08G+of5AUkpeBjQIWrOG1bbStSC/F14WCgo4VrKDtQFsSa6EY9ElNXv0J3E91OVixjjZlQd/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McOs4ced; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McOs4ced"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB301F000E9;
	Fri, 14 Aug 2026 18:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786733815;
	bh=923cbn/O6HD2ZGZtx03vJT6xtNmvD/hM0ayug7/qj/k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=McOs4ced7owH/FsTaGSrwbEu+63FGMRb+fZTsmRyOKlwHwcHrCcwNicdDYzLj8HP4
	 jWWX2uU/oQKdn8tfo7xf63cjDaeW2bRhT5hErbkIz7OPVTs5u8PpxA3utY9G9GEeNj
	 RYuhb5BMnpJeYHDTsbLUd0lAhKhoyQ0R0kxVykv+18HFycWrvv33jS3sm4ydh1hglJ
	 WW/luNVFLYWtU59ToKDPXglRpHDaP9q0XiZhofaG4Ih9ddcxLg2fIDhO5KvtQb24i9
	 7uUjQB5QJS73FK+/YVV4pmkDGq7hlBy6FoRmnRgxakW5yoCzCSFyakt1GD9lAbuG57
	 1pcj34jllYXzg==
Date: Fri, 14 Aug 2026 08:56:54 -1000
Message-ID: <f3a7965cc9d6527de793fdda816b6b63@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: Tao Cui <cuitao@kylinos.cn>,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
In-Reply-To: <20260811075913.344033-1-cui.tao@linux.dev>
References: <20260811075913.344033-1-cui.tao@linux.dev>
Subject: Re: [PATCH] sched_ext: don't BUG_ON a destroyed DSQ in
 process_deferred_reenq_users
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

On Tue, Aug 11, 2026 at 03:59:12PM +0800, Tao Cui wrote:
> -		BUG_ON(dsq->id & SCX_DSQ_FLAG_BUILTIN);
> +		/* destroy_dsq() may race and invalidate @dsq; skip */
> +		if (unlikely(dsq->id & SCX_DSQ_FLAG_BUILTIN))
> +			continue;

Nice catch, but this also swallows states which can never occur
legitimately. The only builtin-flagged value that can show up here is
SCX_DSQ_INVALID from destroy_dsq(). Let's keep the BUG_ON for everything
else:

	/* destroy_dsq() may have raced and invalidated @dsq, nothing to reenq */
	if (unlikely(dsq->id == SCX_DSQ_INVALID))
		continue;

	BUG_ON(dsq->id & SCX_DSQ_FLAG_BUILTIN);

Can you please spin v2? Also, please capitalize the subject after the
prefix ("Don't ...") and remove the blank line between the tags.

Thanks.

--
tejun

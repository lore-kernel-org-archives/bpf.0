Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5862F7EE1
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788086154; cv=none; b=H0GUPbnayoDF4xv/oZvWioQzfATFyalFzBOsDkhFfV2NDLT+f3ahwA3GeTy7SQYn+4ZpsrjA5zl19HzJ/TrLpQEnt0JqNhF2VvTr6oWZ3jRdweFUpjLgvugC3QZT7scnBIcdQ/FEkQ6+0OrPEIyG0Qe7lh5wVvB1Zx64oDBbfiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788086154; c=relaxed/simple;
	bh=rapiJ+S4qZqKtzRt04q9BFJt9ZavrmoUUHa9IIysK1U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AlNseYN3+cgGPoYib2V4XmdPM9aKuWh+i4fpIFz3lUbMZx7MWAZO7vJb1wSR149LyD2OtqFt7anteSzLguHN/EiTMjPksdxMSJ0sE2Ju5fPlKQhsvOnqUp3qPHlkwr+UZPRz6HHEuWjzw8XSTboFfSXiMK12mymt9z+LtpWDvng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9iZiurf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9iZiurf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4141F000E9;
	Sun, 30 Aug 2026 10:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788086153;
	bh=MfPXkoOvG+su7/zLzxw5zLutia14L2BU5OdCqQ+8xRk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=d9iZiurfZoFVjKDL+eMFXdG4TmaicQIWZ9VmncrGUBOuuP3OfCS5dpVxPx6tdRHJ9
	 MIXhuQ7gkfJjQW5EehZAC/XVPgpkSGghvjt/FPBgJjdMMr8gjBrfrkPJVjN1eciSSV
	 qfuAqOorz/qo3/K2u/d3GlZ2oWWn30lO4RN4EeEEhmIJv8a5tWSpX39DCV4d3DFtIm
	 6WaUAdy6hJmnFZpOBWDtaPUc+RlJEL3eQEPmaUFmDsMoJHeR2EFfAv1uF09fjsSEp0
	 hpj4HqpZ25Q5KyrVfPNVICJneZnc52Uu4t+2hGJfccJPuNU54vBtzEgarOn0guz5rm
	 57kqlVe1oDzyw==
Content-Type: multipart/mixed; boundary="===============7031426601232568890=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <74c34c5ee8f98a3a3c9bdab7422140ecc3a192673885e086495e30cec986dcec@mail.kernel.org>
In-Reply-To: <20260830093514.4105972-4-memxor@gmail.com>
References: <20260830093514.4105972-4-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/6] bpf: Separate stream readiness from capacity accounting
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 30 Aug 2026 10:35:52 +0000 (UTC)

--===============7031426601232568890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 7ff803d1d406e5f7340f74f25183895b96ce7628
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Date:   Sun Aug 30 11:35:08 2026 +0200
>
>     bpf: Separate stream readiness from capacity accounting
>
>     Stream capacity is charged before allocation and before an element is
>     published to the stream log. Using that reservation counter as the read and
>     poll readiness condition can therefore report readable data while no
>     element exists. A blocking reader can then repeatedly retry instead of
>     sleeping, while a non-blocking reader can observe POLLIN followed by
>     EAGAIN.
>
>     Add a separate readable byte counter. Publish bytes with release ordering
>     after adding elements to the lockless log, and use acquire loads before
>     consuming them or reporting readiness. Limit each read to its readable
>     snapshot and subtract only bytes actually copied; this keeps the aggregate
>     count correct even when concurrent publishers update it out of publication
>     order.
>
>     Keep the existing capacity counter solely for enforcing the stream size
>     limit.
>
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This looks like a bug fix for stream readiness tracking. Should this
include:

  Fixes: 05755d4f1f98 ("bpf: Add file descriptor interface for program streams")

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0af3c79f5d03a..2ed1e82391b93 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1713,7 +1713,8 @@ enum {
>
>  struct bpf_stream {
>  	refcount_t refcnt;
> -	atomic_t capacity;
> +	atomic_t capacity;	/* bytes reserved against the stream limit */
> +	atomic_t readable;	/* published bytes available to readers */
>  	struct llist_head log;	/* list of in-flight stream elements in LIFO order */
>
>  	struct mutex lock;  /* lock protecting backlog_{head,tail} */

[ ... ]

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 99a89533eaef6..b1e6767d8754d 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c

[ ... ]

> @@ -234,7 +252,7 @@ int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, vo
>
>  static bool bpf_stream_has_data(struct bpf_stream *stream)
>  {
> -	return atomic_read(&stream->capacity) > 0;
> +	return bpf_stream_readable_bytes(stream) > 0;
>  }

A subsystem pattern flags this as potentially concerning: the readiness
check here happens outside the exclusion point that guards the consuming
action. bpf_stream_has_data() does an unlocked atomic_read_acquire() and
is called from bpf_stream_poll() and from the wait_event_interruptible()
condition in bpf_stream_file_read(), while bpf_stream_read() only takes
stream->lock afterwards and re-samples readable inside the lock.

Can this interleaving occur with two readers on the same stream?

  CPU0 (poller)                          CPU1 (reader)
  -------------                          -------------
  poll(): bpf_stream_has_data()
    readable == 50 -> EPOLLIN
                                         mutex_lock(&stream->lock)
                                         read_len = min(len, 50)
                                         ... copies 50 bytes ...
                                         atomic_sub(50) -> readable == 0
                                         mutex_unlock()
  read(): bpf_stream_read()
    read_len = min(len, 0) == 0 -> 0
  bpf_stream_file_read(): O_NONBLOCK -> -EAGAIN

The commit message states that "a non-blocking reader can observe POLLIN
followed by EAGAIN" as the defect being eliminated. Does the new counter
fully prevent this, or does it narrow the window without moving the check
inside the exclusion point?

Note this is about the structural placement of the check relative to the
lock, which was introduced two commits earlier in this series in commit
05755d4f1f98. poll(2) readiness is advisory, and the single-reader case is
fully addressed by this patch. The question is whether the changelog claim
about POLLIN/EAGAIN being fixed needs qualification for the concurrent
reader case.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33304989971
--===============7031426601232568890==--

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001266;
	b=sHEVL8Cp4l0SRjaL6hYXAPsNlqau2uER7lhHkRMCinCXvvSGuk8BDNMaWWnz9jJ574TW
	 S5bcR3P4sbSe1rCjO5r2ixtq8xkNV9MTnf7xOOv1n12cWPFz+kBfT9fKsKQneaK7k3/WN
	 4yAcFfKZ1P5xDu1WJgXOv8hUPuFiVd4n0fSmT765ACQgKscZw4P0RSo3c+Ku4Hj4wHTtl
	 FG2KPKKetYU24+/k0wTvBt7e5UaZDCED1ILsCl4R3wQ4DmjFYNIud0Io5pn2EsCq1iXxc
	 ZHC1FDInYmIbEKwz2r7Es3P3uFLK9tjQTOwlcmAJaDeQddrV8wyjH3V9ig9TM2ypziw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001266;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ml8UQRnupsBXChpdLQ8z+bnOgucCiDf6uIjptkI/ug8=;
	b=1ynpWaNhs08irGj1ndF/1OnlzSnOyXMXkx9zwkRVuAT+VN1Ez6fEKM+SMmEjRPXuO1GL
	 9Yt3Cp0IBx28XXKqRuoiJ0C+FjiRkuYgdWL2wJwE7lyYwPwzG0qpbb+GVhMkVH+vNORix
	 W4ixyOcq7jUG63MusNpjMf3/+eQnmSscYul5JyqcK+0fc14N94aFCf/bxxbJ2sbcPYvDw
	 M/mldb7vfMkqOwVGPCW4t9JbBD5EOzSCPHDMWNsaLVOyFE/6mv6HdogbNADPnBXEwoZVj
	 lOjdwkO/XDBU2PeAuDC5i1T5GM3cbI5e43Y7R7er3SLlrwAfUTTdpP06hrTln6s5Hrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9MGFOzP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF5606A31C;
	Wed, 18 Nov 2026 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9MGFOzP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423C91F000C5;
	Wed, 18 Nov 2026 11:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795001266;
	bh=ml8UQRnupsBXChpdLQ8z+bnOgucCiDf6uIjptkI/ug8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=e9MGFOzP2HUIQZi9v7TkvhV0pgEeVupUV47yOGoPmj4yP6vd3UtT07u0RmITJ4yHD
	 ma3VgSTHBAu5RLfRmbvEcehFeY3x8jLE+9GcIxrX3Olb4iTSYTpdX+ljyipO/8Edgc
	 FBuuUJUzr40pcpJz7pYpVWJvmK3ELKK6pcStmRMRyrFEtFUaeEVCh5b/pczf4/oAo3
	 7fAW8lbxnXfeOSeIszAvPRMbJ2AgOJnZBalKSHtyyeMM4o2ioX8viEA0iKBh8z4lSW
	 jwsprIGOpnP5HamafE7Oe3M3gi0NyDbgk3MI9TCLbrXkpgRxA2fzB9XmOKLgPpNyZC
	 HLCjYtT4vQxKQ==
Content-Type: multipart/mixed; boundary="===============0628549358835958140=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5c75ee187165e77ac4a71e59084adaa793051388b57dd217f63430c2c8ebdbca@mail.kernel.org>
In-Reply-To: <20261118104758.98620-1-jain.sm@gmail.com>
References: <20261118104758.98620-1-jain.sm@gmail.com>
Subject: Re: [PATCH bpf-next v2] rqspinlock: Keep claiming the lock while the queue head is still the tail
From: bot+bpf-ci@kernel.org
To: jain.sm@gmail.com,memxor@gmail.com,ast@kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 18 Nov 2026 11:27:44 +0000 (UTC)

--===============0628549358835958140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> rqspinlock: Keep claiming the lock while the queue head is still the tail

TL;DR: Nits only: two comments in rqspinlock.c (queue-head claim and pending
undo path) still describe the old behaviour and could be updated to match the
new retry loop.

> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c

[ ... ]

> @@ -624,20 +624,23 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
>  	 * Otherwise, we only need to grab the lock.
>  	 */
>  
> -	/*
> -	 * Note: at this point: (val & _Q_PENDING_MASK) == 0, because of the
> -	 *       above wait condition, therefore any concurrent setting of
> -	 *       PENDING will make the uncontended transition fail.
> -	 */
>  	if ((val & _Q_TAIL_MASK) == tail) {
> -		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
> -			goto release; /* No contention */
> +		u32 new = _Q_LOCKED_VAL;
> +
> +		for (;;) {
> +			if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new))
> +				goto release; /* No queued successor */
> +			if ((val & _Q_TAIL_MASK) != tail)
> +				break;
> +			/* A pending claimant can abandon before publishing a tail. */
> +			new = _Q_LOCKED_VAL | (val & _Q_PENDING_MASK);
> +		}
>  	}

This isn't a bug, but the comment block just above this hunk still
describes the old behaviour:

  * If the queue head is the only one in the queue (lock value == tail)
  * and nobody is pending, clear the tail code and grab the lock.

The new loop also clears the tail when pending is set, keeping the
pending bit (the n,1,0 -> 0,1,1 transition).  Could that comment be
updated?

Similarly, the comment on the pending claimant's undo path still says:

  * Undo and queue; our setting of PENDING might have made the
  * n,0,0 -> 0,0,0 transition fail and it will now be waiting
  * on @next to become !NULL.

With this change the head no longer waits on @next in that case while the
tail is still its own.  Could that comment be adjusted in this patch as
well?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44290867653
--===============0628549358835958140==--

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820291;
	b=tJatMjGBHte+QYMPDJgFGjSM93/w7svjxT/VoOBNRjk0FeSufeUhzh1+rJwWdPDE0b3u
	 EDUhWuWuHNSUOrXTOluhtrvBFmmiAdFiNPYw8KmWvVM+L3WyzTETMWiQTz8FfPn3UQ1V5
	 OKzDuNPHajVYPYIfeUtdivVMkdAwf5mP8B36q7SBl2luVgeP04H+q3LlfZQdzOzmcNyHL
	 LOFJ1wAp6HdekHdhpQSJe8Ro5lUMqNJSUsAGvN8rxgPdlHoocmQEKsZZU9K9Xa0KY9Lgq
	 nB3MHJaGuMbXgN+nE6f7hGFLc8WKt2d2HBgrFLjygn5268rVthmbabOLxnMVk/elPkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820291;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=2cl+IPVJlClBxWQlKHZKipsDZ6QUPUvr34kW14M+CmU=;
	b=mYvdsDYLCkeeOCHc9GJfYivqbUbCUpCnJYzSLpl3fE74RqtQG/v7Opx8T/jq8DAo1qFR
	 tF3NzEtcmGRj3eN1lKaUG2l7MaQnXuYCG9Xeb3bpNNl2Mj4bcB54sv/uMDdsdhi6aohU1
	 2QshW2F9c+N8tFEGHMGBC2/C514+ejm1kP2r4ma7FMVkL+bRbregtDDs0Hi/R9GFI0z4/
	 Skb8wjDrNqp4eMKLtr62AseJuTbQjCO18E3xp8cJUbQVL73UEZ8qHkNJIQMo6517JduN+
	 um/3hwVWtt+9Duur2+kI21aSJCQOXnHRj256KDEFpTETyteItqzyMeUzNQB9s6mMatA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtrEJpci;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0276070E66;
	Wed,  4 Nov 2026 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtrEJpci
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099821F000C1;
	Wed,  4 Nov 2026 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820290;
	bh=2cl+IPVJlClBxWQlKHZKipsDZ6QUPUvr34kW14M+CmU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LtrEJpciasdBqwJR7UCMuE83mRgAsfJd95YrCqYDxstR7kmS5ie32cqCleSTDaaCj
	 pexMT53rH6JeiIckRf0FsyXlrrE+LmvbXYfuGgwrJ9QPN53f8MGC3wC9jB8Opil/hz
	 +Dak9Jl6Z3ddnrQdc+DPJsB4sxbMYun4d684ySUDTkELbuu3V+izKiSvG7iv/3D+x1
	 DmlScfuNYdb11YV+fQcAO/1jy0IkS7fwbrVy1W0sZxmkjQ5thaQ6uyZ0oIAeIdSH8p
	 kKCjSgeRdYQ7pYEcfxnH2g2P61xxHmHUbAOzIVTBmQO6BMl9lsjtXDCwt6OF/NfOcL
	 X2cGv/8LrLzVQ==
Content-Type: multipart/mixed; boundary="===============2959817077743352993=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8397ab89d713edcda68bf7dfa564b3a6f2c7d4c420a9a1a9a49fa2dfc8833233@mail.kernel.org>
In-Reply-To: <4b2b24fdabd4cdef1364a8664d7d9615e960c72c.1793818387.git.hi@tychen.cc>
References: <4b2b24fdabd4cdef1364a8664d7d9615e960c72c.1793818387.git.hi@tychen.cc>
Subject: Re: [PATCH bpf-next v8 2/2] selftests/bpf: Check bpftool batch map dumps
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: hi@tychen.cc,qmo@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,shuah@kernel.org,daniel@iogearbox.net,ast@kernel.org,alexei.starovoitov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 19:24:50 +0000 (UTC)

--===============2959817077743352993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Check bpftool batch map dumps

TL;DR: Commit message and comment say the selftest's injected -EBUSY mimics a
hash bucket lock failure, but rqspinlock apparently returns -EDEADLK or
-ETIMEDOUT; test still works, so only wording (or the errno) needs fixing.

>     Batched dumps must print the same output as individual lookups. Use an
>     fmod_ret program on security_bpf() to count the map lookups made by
>     bpftool children of the test, and to fail batch lookups with -EBUSY as
>     a hash bucket lock failure would.
>
>     For each map type with batched lookups, compare plain and JSON dumps
>     with a dump whose batch lookups all fail, and check that no individual
>     lookups were needed. Cover BTF and per-CPU output, an empty map, 1-byte
>     keys and unaligned values. With 4 KiB values, check dumps that need
>     several batches, and that failing the first or second batch lookup
>     continues with individual lookups without restarting the dump.
>
>     Assisted-by: LLM
>     Signed-off-by: Tianyi Chen <hi@tychen.cc>

> diff --git a/tools/testing/selftests/bpf/progs/bpftool_map_batch.c b/tools/testing/selftests/bpf/progs/bpftool_map_batch.c
> new file mode 100644

[ ... ]

> +	} else if (cmd == BPF_MAP_LOOKUP_BATCH) {
> +		batch_calls++;
> +		/* Same error as a hash bucket lock failure. */
> +		if (fail_batch < 0 || fail_batch == batch_calls)
> +			return -EBUSY;
> +	}

The commit message says batch lookups fail "with -EBUSY as a hash bucket
lock failure would", and this comment says the same.  Is that accurate?

Since commit 4fa8d68aa53e ("bpf: Convert hashtab.c to rqspinlock"),
htab_lock_bucket() returns whatever raw_res_spin_lock_irqsave() returns:

    ret = raw_res_spin_lock_irqsave(&b->raw_lock, flags);
    if (ret)
        return ret;

and rqspinlock only fails with -EDEADLK or -ETIMEDOUT.
__htab_map_lookup_and_delete_batch() passes that value back to user space
via "goto after_loop", so no BPF_MAP_LOOKUP_BATCH path returns -EBUSY for a
lock failure.

The test still works, because dump_map_batch() in bpftool treats any error
other than -ENOENT the same way.  Could the comment and the changelog say
"an error other than -ENOENT" instead, or could this return -EDEADLK?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41893799307
--===============2959817077743352993==--

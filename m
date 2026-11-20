Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210493;
	b=2ylaesM1lOtNYZt7QrQxNukL3fjCTObWixs3JJnBZb+T3jyMXzEIOOz0PASf2KjUNjUB
	 EUmB9tk6KupFgC0GlAltdIrheR76OOJg9ba9AJYqhJduIepo3ZtavLlQtqffMLAryCNEq
	 uJor0vZ6PhYYxjz03PU7Yd1eaZ5ils3Wkff9PWXXd679ZCXt/fZcAijtTP6KXRew2gPyX
	 kkAsmJMm/T87ixwxT3VmgMxsxey3IzrA+1iH9nKjfOaCcLBMF+yoz83wufWyKQyFDk7/1
	 7/hk4IPEEwPjgNAzK/ywF9ZVWdrXd9bIpyyRbJcJUHy2SLZojQ54x+VKAj7C3/du3tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210493;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=6lQLw7vr49c/xRNsbp83rNdT7a6dbGynY59B+DhD1/Y=;
	b=jnux8Nrk12uCPZvMdHdooYYPoRmfZsa1ApwvIsq2WHvwPcb8BGoy9HbuF0SMRiveKHgb
	 fi/KiyhKiIflqCdF6XNoPjVf92FybdRlahOoA/1hAsekI2xK+SQgIV/fmmhoPYUZ0hJeI
	 UNcLDVBtSUNRv9F0+HQhTdZ978JG/8EfSgNRV2nG5bkfYv/8kcggbPtLF8/tTJ/3adciV
	 1bb5MNU975u/21Sgmq4Oaa3el1NWOwa5hrWWZLJjcxpi02uQ1WT9tiQFpxBJWl6cTXuoa
	 IxnG1KzhBUchjrTVI9k1YX2QFLHz4SNV0cMxIad3Y2os+Wy6brUbmlM/8lkNWckLBZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtyFeQF8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C560A2625;
	Fri, 20 Nov 2026 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtyFeQF8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3411F00AE3;
	Fri, 20 Nov 2026 21:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210493;
	bh=6lQLw7vr49c/xRNsbp83rNdT7a6dbGynY59B+DhD1/Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GtyFeQF81iU9dXepEp+Ub4FExU8GSM+Ts+DJ0OiIEKqSZ0Dl65ccDXO/7hsLRDBgu
	 GSVaY4DA77ZmoW3HpQTIuOTkdC0B2q97BUtx9u8EbW13LlfZ53ezYmx8LiqVIkfD6Q
	 Cqq9h+X2IQFE7HJh3O3y8Q4iRIrdktToavDPRM4uycI1/GIp/17Y9PERD+nM0K2bGB
	 KbmUhwrIdbVxic2ha7+8QMQsdwxXFK7PbkBivQAbr8RPml4NgtnOIlI9ue4mqh0DFv
	 rQrxlWk6vOnnZN1h3nSgx9XEhw4i8jDt/k1L/ZSxxYbQme8cDx8UJ1xGxnJ8yYo4Gb
	 VbB7exrlV5kzQ==
Content-Type: multipart/mixed; boundary="===============3484032340514818205=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7d0a57117d3a4bac7aab7808335393ef3328333d04b7f67d1aa2f492959e3ff0@mail.kernel.org>
In-Reply-To: <20261120-bpf-ringbuf-fixes-v3-6-ff7ca15d6c37@kernel.org>
References: <20261120-bpf-ringbuf-fixes-v3-6-ff7ca15d6c37@kernel.org>
Subject: Re: [PATCH bpf-next v3 6/8] selftests/bpf: Refactor lifetimes and test wakeups
From: bot+bpf-ci@kernel.org
To: tamird@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,arighi@nvidia.com,xukuohai@huawei.com,andrea.righi@canonical.com,billy@starlabs.sg,void@manifault.com,ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,awerner32@gmail.com,zeffron@riotgames.com,andriin@fb.com,tamird@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:34:50 +0000 (UTC)

--===============3484032340514818205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Refactor lifetimes and test wakeups

TL;DR:
- Commit message says what changed but not what was wrong with the old
  lifetimes; maybe split the refactor from the new wakeup subtest
- Test nit: repeated tryjoin plus joined=true pairs could go in one helper

> selftests/bpf: Refactor lifetimes and test wakeups
>
> Use cleanup attributes for skeletons, managers, and file descriptors in
> the ring buffer tests. Pass skeletons and managers explicitly, and stop
> or cancel worker threads before joining them. Preserve the existing
> zero-bound, NULL-callback, and overwrite-map regression cases.
>
> Add edge-triggered readiness coverage that consumes one record per call
> to exercise the wakeup handshake across bounded returns.
>
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>

This isn't a bug, but the changelog lists what was changed without saying
what was wrong with the old code.

Could it say what problem the lifetime rework addresses, for example the
poll thread outliving the ring buffer when ringbuf_subtest() returns early?

Also, could the lifetime refactor and the new ringbuf_wakeup subtest go in
separate patches?

[ ... ]

> @@ -323,12 +401,14 @@ static void ringbuf_subtest(void)
[ ... ]
>  	/* background poll should still be blocked */
>  	err = pthread_tryjoin_np(thread, (void **)&bg_ret);
> +	if (!err)
> +		thread_guard.joined = true;
>  	if (CHECK(err != EBUSY, "try_join", "err %d\n", err))
> -		goto cleanup;
> +		return;

This isn't a bug, but the same two lines, "if (!err) thread_guard.joined =
true;", follow each of the three pthread_tryjoin_np() calls in
ringbuf_subtest().

cleanup_thread() is only correct if every join site updates joined by hand,
and a later tryjoin without it would make the cleanup call pthread_join()
on an already joined thread.

Could the pthread_tryjoin_np() plus joined = true pairs go through one small
helper that takes the thread_guard, so the state is updated in one place?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44815895103
--===============3484032340514818205==--

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311174;
	b=P1wfoOF252FKRPPn5FQU21+4RwJIuaFxWW9anKpS89rYU3q3kogT6k83Aseoc/HEP4ir
	 CVUQlM0UlOzxaWKmOs0GDbtCqE2JbjI0JsBGG1ux5GvozqIpaVHOOoyAY6wOUKGFkUkFi
	 BFeI7bNxX2fNFimO/+XIrqd06vOqKvz/Df/9IBxEbpeJ8kLWavwt1YHnyeJ/a+eN8A20l
	 o/HJZwJ4t1xoiqL0smb2Uep0HXvVaYNqL13gZL9KP8ulAd6b+miVCih2ViDx4TRJJqhab
	 Wq9Ch/K8m647SeNVIS26arRCSZTJJV6qZtWAFLo03mQfB8879PZVK1kgOWrWcJti2sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311174;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=M+YkVfh/m9QNMVkwEafBbwPCRvwdpFTGjYDGrmLRT6g=;
	b=K6uxQhqXU+YJLHOmMQNKLPqSHm3T5S3K+ffHjIzdCgEj5/XqZ/KdiXVOHc0kO/T7sGT4
	 r8lu0Iipnfm4oFPh/YHtK/sH45G2oETg6rQiaGcAuUAPgKYd262Eu8fBbknKS9a6LIuOk
	 rvydTgEyf99oXey+l5AhFKIbQoBeJLpcgMi1VxKVluyCGs8gSX3mI10keHzbtG/T/1Y9Q
	 CAdK9YTlLgzHLizj3b0kTSl6l/Qoa4A9PTaOd58tz65vPoKpjYDbEcDCrLYSEkQWkEnR8
	 PBQvQJZNI5ME/fh3s5dZqH/Y1IyXq5C2d40Y/n/tqtYsAmE+RbfUgAqQSuuBgXQtnWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kijhsrvd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142F0606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kijhsrvd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632561F01816;
	Thu, 29 Oct 2026 21:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793311173;
	bh=M+YkVfh/m9QNMVkwEafBbwPCRvwdpFTGjYDGrmLRT6g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KijhsrvdCMs7njoxZIgNpvRfUz8AWbcZLX/EFCBaqexoqJ5laFtbXpTwuWKaWQCeE
	 CfYMoIGpALaRSk+S8S6zLHE3+RS0mKXTToXZJs7QVffBu9u7xjMS/aIR69kO8hbA7b
	 cHnIdO8kHFlJij+tU7GeVZrPjRt/ZLvNRqxUdibZ7cFR6vQbj5szmwfhjgS/YPrqGd
	 Ggok7RAsI9q2+QKK9ejSMNBExWQgZZlY67FTAiKmx4rwsadju7KyelHVk2oBuj4lZS
	 Sy5dMB78xEDPktHiU15wF7wusyG5HExR9+7s6mJvc7DAUJ5+I4giqkHKAtm+eVpwOt
	 Hkb+uaU227oCQ==
Content-Type: multipart/mixed; boundary="===============3154708283504647599=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d023b011d67ae13695a93c94ae0197e96fb5d42bbc3a4a63b42fcd0c1852a605@mail.kernel.org>
In-Reply-To: <20261029212551.56964-9-jolsa@kernel.org>
References: <20261029212551.56964-9-jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 8/8] selftests/bpf: Test user memory kfunc errors
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ljs@kernel.org,john.fastabend@gmail.com,nierro92@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 29 Oct 2026 21:59:33 +0000 (UTC)

--===============3154708283504647599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test user memory kfunc errors

TL;DR: Commit message only: it claims tests for partial copy faults and
read-only mappings that were added by the previous patch, and omits the new
RUN_TESTS(user_mem) verifier-failure tests.

> selftests/bpf: Test user memory kfunc errors
>
> Test invalid copy arguments, zero-length mapping operations, partial copy
> faults, and copying to read-only mappings. Verify that a failed unmap
> leaves the mapping intact, and that non-sleepable programs and programs
> without CAP_SYS_ADMIN cannot call bpf_user_mmap.
>
> Assisted-by: Codex:GPT-6
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

The changelog says this commit tests "partial copy faults, and copying to
read-only mappings".  Is that accurate for this patch?

test_partial_copy_fault() and test_copy_to_readonly_mapping() were added by
the previous commit 8f0bac0f80cd ("selftests/bpf: Test bpf_copy_to_user
kfunc"), whose changelog already describes them, and this diff does not touch
them.

What this diff adds is test_zero_length_mapping(), test_failed_unmap(),
test_invalid_copy(), the three verifier-failure programs
(user_mem_nonsleepable, user_mem_kprobe and user_mem_no_sysadmin), and the
RUN_TESTS(user_mem) call that runs them.

The changelog also does not mention RUN_TESTS(user_mem), which turns the
existing user_mem_test program into a privileged load-only subtest.

Could the changelog be reworded to describe what this patch adds?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40959191771
--===============3154708283504647599==--

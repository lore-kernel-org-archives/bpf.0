Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849ED4E77F3
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799739; cv=none; b=i/YLcUKGbF0elROtqsjdFM8WsT9BLuHgoI5iDU3TmRuxW4sxbMEzPy/fbV+M0nQbuwCBCTW614jP4PuXt4POiZJosHTR9DLXlVPhYk47j9Qfyd0jVFymZ43qUhdBPqItjXHnTRjjalAfD6AgkoIU8cT8zgFpQzsDvLoWL31rrQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799739; c=relaxed/simple;
	bh=emJoTCFE7PhUBk3gNZcGqHVFcGckcoBevLgBzaendF4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=H6f6XbWN6SifhxYEwMSYdKvbVBIyXROmDNwNbfpQbDeHpki/+qkcPOSRUEVaBL0Y8ilcPK1cAzF+i5yobXlIWfttKPNn4LqPERkwpW8FtvYGl5M7zLsTZePv5VERrcjODyuvF79K//209bJx+Ivw9TbapSLdjAJhU7rzZGfrGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp/00/GX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp/00/GX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2621F00898;
	Wed, 30 Sep 2026 20:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790799738;
	bh=zZmABR92HkXvDEXmQ22UUV1coxmwWDZ5hE8k5qP/mfY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Qp/00/GXFqr7T5eB8IB+d0ePCThSAJtjXndytpmfWA/6UpHWnoIP/VJxsV25Vfwl5
	 U7d0bpOlUj20+tFhQA+op7C8eUDZX5eUkexGAEZot5CU3olQtYdCnxVYIoZebmZ7ES
	 rxtqUaL93/+Fv/kSyNaP9THxjRDU2pTKa0GhwMP8LIk3ShLYmr4RSDN+1by89bBd+M
	 syisRMriit9el9fc3APnaDzmdp/pyW8+DZHiBAUqYbGG/2EZna+iHX0tPvltg+Um7i
	 u0wz8RUMPtQSVG/FNCNSTWryJLNLygjWOzbh/yn2oZb/SgkbrHO84EFeBKIC9BfvEk
	 sYwqRl13lI5lw==
Content-Type: multipart/mixed; boundary="===============3507585133500301614=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dbe33efbee822cd51da4dc2ccfb23376037637f385c4ebeb5eff0e7e55709c7c@mail.kernel.org>
In-Reply-To: <20260930193127.2181684-14-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-14-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 13/14] selftests/bpf: Add test for global data in arena
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 30 Sep 2026 20:22:17 +0000 (UTC)

--===============3507585133500301614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add test for global data in arena

TL;DR: Nit only, in the new selftest: on architectures other than x86_64 and
arm64 it skips silently, without printing a reason. Suggests adding a printf()
before test__skip(), as stream.c does.

> diff --git a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
> new file mode 100644
> index 000000000000..bccfb0110b94
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c

[ ... ]

> +void test_data_in_arena(void)
> +{
> +#if !defined(__x86_64__) && !defined(__aarch64__)
> +	/* other JITs don't take BPF_F_ARENA_SCALAR */
> +	test__skip();
> +	return;
> +#endif

This isn't a bug, but on architectures other than x86_64 and arm64 this
skips all four subtests without printing anything.  test__skip() takes no
message, so test_progs only reports the test as skipped and the reason is
visible only in the source comment.

prog_tests/stream.c uses the same arch guard and prints the reason first:

	printf("%s:SKIP: arena fault reporting not supported\n", __func__);
	test__skip();
	return;

Could a similar printf() be added here, for example
"%s:SKIP: JIT does not support BPF_F_ARENA_SCALAR"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36768148430
--===============3507585133500301614==--

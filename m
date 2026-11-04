Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784242;
	b=W2zD0lZDp3k9GMV3YFPkU4q4CE6WL8AovBibu6D5Gd5pY/747/vHgNcwSIl+Ro2JYMMe
	 iadPU7U1g+mw0T4GYS8cS6lYsobRzzBhPtOL2OmkRP1dWpayDHMeb21XhCTIuDL/CbWnU
	 thME5U6KxKf58lbX3UstLIbiQ+ZcoR6vTGEgOw/h8QIpxKUVK4rd1Ktrhi1BwMABnB6xp
	 bPmfIbe/ylucI01Rp6K6R/v2voW8ayaeZoSEfYiRp8KFTCyi+l75uHMSKbVcE7yjlK0CN
	 zsdKzNAxcR2jMDKUruhsRXH3OJUi/EhfRK3ksTONkfy89zF81RpuwwY0MwTnRX0cafw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784242;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=L+88iVde34Oo/REFSbiXXB2pfC0goIHj3cRCJ8dtLrU=;
	b=McfK//GT65r6C5vzrNxKdQFPI5gdX1XV6fUvFLUw74C3QUjF+sTXTvZ++rzpgM8qIxON
	 iacBszPbt0NRxyQba8XTXmXhbePeWjXe7A4m+3w25N29/R/7LRAiMor7RQxlFdqifUpjP
	 wKNBXa9kaBiZljAW5ws09/zm7LXc1X0VbRv4APc6NDiCzkIrjFaQO+1nsZ35nlFdDaWKe
	 hCMDZzVxvc5DrE7bVZZr2S2gxA/8OTNUYg7w9izoqCe89v84RHLY2Zd/p5OQv0h38PFxE
	 qWTkGtB2Yvn55sNJ2g9xS52byiaflIH4cfXfadu0H3gcTt1utgL6b1mCc+6Mx2Arznw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=chhb0SxH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45047606D815;
	Wed,  4 Nov 2026 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=chhb0SxH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5324B1F00A15;
	Wed,  4 Nov 2026 09:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784241;
	bh=L+88iVde34Oo/REFSbiXXB2pfC0goIHj3cRCJ8dtLrU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=chhb0SxH0sRbIv41mbOf1XZzsDh5nHsJ50zTY4PkoO1yQtIvHjVbtn+pLJfpCBHCs
	 +9MhlAB5wHCgD6qrbUILMO0w2u6B/W+81//0tVoc1PLbWmbsE0FyZL2CG9BPK3Xmk1
	 g2tQOYQMxGxVcqqHbKNRsju9m4F0gjZk2ADBNFqcvq5i3MdM134yb8TaAkel6/fvR9
	 uw2a9tPF+FJQgcvWxIxCcrUOzOsMTe/Sw/QGKnq0pbGoSpbMP6EQhsQfyZrI/qWazg
	 uw4aD+U6g3WkUhgqGc+RXNE0Jz5ETnmRawSdh8RVrM+8KEQqxUGIzFPD29TJMjOqxJ
	 qRYThYIYTKVwA==
Content-Type: multipart/mixed; boundary="===============0075720949142317520=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <1653a9b2f3190fc956341a7cce09701b03b7fcafa3aa02d1fba34c29136053d0@mail.kernel.org>
In-Reply-To: <20261104083833.971911-2-yangfeng59949@163.com>
References: <20261104083833.971911-2-yangfeng59949@163.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Test faulting build IDs from a sleepable raw tracepoint
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,song@kernel.org,jolsa@kernel.org,ihor.solodrai@linux.dev,kpsingh@kernel.org,matt@bobrowski.net,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,emil@etsalapatis.com,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 09:24:01 +0000 (UTC)

--===============0075720949142317520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test faulting build IDs from a sleepable raw tracepoint

TL;DR:
- Test issue: raise() may call getpid again, so the BPF programs may overwrite
  the stack the test inspects; results may depend on libc
- Nit: usage message omits the new uprobe-paged-out-stop mode

> diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
> --- a/tools/testing/selftests/bpf/uprobe_multi.c
> +++ b/tools/testing/selftests/bpf/uprobe_multi.c

[ ... ]

> +int __attribute__((weak)) trigger_stop(void)
> +{
> +	int err = prep_build_id_page(false /* page-out build ID */);
> +
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Make one syscall that the BPF program under test filters on, then
> +	 * stop this process so that the recorded stack cannot be overwritten
> +	 * by another syscall while the caller inspects it.
> +	 */
> +	(void)syscall(SYS_getpid);
> +	raise(SIGSTOP);

With glibc, raise() goes through pthread_kill() which calls __getpid() to
get the tgid for tgkill().  So rawtp_nofault and rawtp_sleepable can match
a second time on id == SYS_getpid, from inside raise(), before SIGSTOP
takes effect.

That second match overwrites stack_rawtp_* and res_rawtp_*, so the stack
that subtest_raw_tp() inspects comes from the getpid stub called by
__pthread_kill_implementation(), not from the explicit syscall(SYS_getpid).
In the sleepable case, that stack is also captured after the first match
has already faulted the build ID page back in.

Whether a uprobe_multi frame shows up then depends on how libc compiles
raise()/pthread_kill().

Could the BPF programs keep only the first match, for example by returning
early once res_rawtp_* is non-zero?  Or could the comment and commit
message mention that raise() issues a matching getpid() as well?

[ ... ]

> +	if (!strcmp("uprobe-paged-out-stop", argv[1]))
> +		return trigger_stop();
>  
>  error:
>  	fprintf(stderr,

This isn't a bug, but main() now accepts "uprobe-paged-out-stop" while the
usage message that follows still lists only
<bench|usdt|uprobe-paged-out|uprobe-paged-in>.  Should the new mode be
added there?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41802507259
--===============0075720949142317520==--

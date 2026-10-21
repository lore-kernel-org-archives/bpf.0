Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614621;
	b=vkbFitr7MUPVnnKPNB9y9EpOHMP3Ws7ttzUZZvKC7EoChlNK+/XcLprYORc95JH5ED9J
	 PeQ2/WtbPCwJusVCdr8K54CQdMLGJiiQUrmkH4nPi21oAd0pl7chC+62HoKt/pqrKf8Dg
	 FayTSZlkPq18+GxW69tRIJj76p5evQHAcFxKmXFJfub9/P2lBp/77lQQYDn3ErYVRCBzX
	 nPurhDzETVdOOyxPm7j9DYER6ajNbo4L1Y4J9CCgbPD31r4EEWZtk1aGWU+jzf3rNQwpd
	 FK4fx8dbIz8paU/y6pc4KgQlpnfCkOqQMTPqadyK25JOg8f3iKVQ58IkMc8IGV3WlSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614621;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=dC5pXc4nN0qf0upwnfjFKJD9G2HlA8g2yqaCeFHQhQQ=;
	b=eCJyShcsFygz5Gp+uQ0kMwlmsFYctg2cM8Hz8dtE+QBz8+1oFFRV6oGej5CYPQ/3pkyn
	 sJ70I6uKVQqnLWN/4wxwQYuJwlqOMMB3IJ2jXI86ZGQvTs47RPXlqPnpIwhiEjblmQFRW
	 7i2jqe795Yng+valrNSMEem88PH+iIXYkO99EKtVV5iqLbseKZ7WRHcim/AGvGXfNjE3x
	 Csv/ZJ35tSzFTAjrGgBJRJO1sSnqxf0xNaNcvgamBTJdtmsnJNN65qs1uMIE8MsgZkorV
	 Uj6vct6IeTqoDRdo78vP1YpFC/7Rz9NjGHWL2KPI6+IVZtcC/6Z0XBymdm053Iz0DeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N/VdZDYY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F72606A324;
	Wed, 21 Oct 2026 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N/VdZDYY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A47C1F000C2;
	Wed, 21 Oct 2026 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792614620;
	bh=dC5pXc4nN0qf0upwnfjFKJD9G2HlA8g2yqaCeFHQhQQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=N/VdZDYYRjr+K7gPY+DRPpbDh54v1Jugz91wj373VKafhu5CnBpph665lbj73ijd6
	 0zG42WBW8RZ/GrXqQKCOM9BWFDLgs8gEccQO0oacheUteDflqkucODHDVauwr1AGiw
	 3GvoQnX2+Ca4VmfoEui8dsXIbH8QgJNynaYYZFMFeF8Byd7nS+fOiGJTbfUNl2Mdnz
	 mUO4oZ50SElfFKrEjVRbKKwdg5x/iYEScJGYHLVOSW9/iY9CMvtDdTMM0XOX9DaCTC
	 XOLenf/H9eX+cZk+p29ipW++EAsQwQWESGMz842uceiR2R2AEf4UxNg9YyeYDAMJlw
	 au/3qGehx3jcw==
Content-Type: multipart/mixed; boundary="===============4819838643990905154=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <038645137772f125ac45a4ea75ca052ffcd035160522f1bc4c2011fd372e88bf@mail.kernel.org>
In-Reply-To: <20261021195759.119421-10-jolsa@kernel.org>
References: <20261021195759.119421-10-jolsa@kernel.org>
Subject: Re: [RFC bpf-next 9/9] selftests/bpf: Add user page failures test
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: bpf@vger.kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,linux-mm@kvack.org,akpm@linux-foundation.org,liam@infradead.org,ljs@kernel.org,linux-kselftest@vger.kernel.org,shuah@kernel.org,john.fastabend@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 21 Oct 2026 20:30:20 +0000 (UTC)

--===============4819838643990905154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add user page failures test

TL;DR: Commit message claims the test covers replacing sealed mappings, but
test_reject_replacement() replaces a still-writable page before any exec call;
either reorder the test or reword the changelog.

>     selftests/bpf: Add user page failures test
>
>     Cover expected failures for invalid allocation sizes, misaligned or
>     unrelated exec requests, replacement of sealed mappings, repeated
>     execution, bad writes and attempts to restore write permission.
>
>     Assisted-by: Codex:GPT-6
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>

The commit message lists "replacement of sealed mappings" as a covered
failure, but does test_reject_replacement() ever seal the mapping before
replacing it?

In this series "seal" refers to the bpf_user_page_exec() transition, which
the kernel-doc describes as "The page cannot be made writable again after
this call".  The test goes straight from alloc_user_pages() to the
replacement:

    if (!alloc_user_pages(skel, 1, &addr))
        return;

    ret = mmap((void *)addr, page_size, PROT_WRITE,
               MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
    if (!ASSERT_EQ(ret, (void *)addr, "replace_mmap"))
        goto out;

    skel->bss->exec_addr = addr;
    skel->bss->action = USER_PAGE_EXEC_ONLY;
    user_page_trigger();
    ASSERT_EQ(skel->bss->exec_ret, -EINVAL, "replacement_not_bpf");

At the time of the MAP_FIXED mmap() the page is still a plain writable VMA,
and USER_PAGE_EXEC_ONLY is only triggered afterwards, on the replacement.
The replacement itself is also not a failure, since the test asserts that
it succeeds.  Only the later bpf_user_page_exec() on the new VMA is
expected to fail with -EINVAL.

So the scenario the changelog describes (replacing an already exec-only,
non-writable page with a writable mapping and checking that exec refuses
it) is never run.  A reader could also take the changelog and the test name
to mean that the kernel refuses to replace sealed mappings, which it does
not do.

Should bpf_user_page_exec() be called before the MAP_FIXED mmap() so the
test matches the description, or should the changelog be reworded (for
example "exec of a replaced BPF-allocated mapping")?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39668036298
--===============4819838643990905154==--

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000931;
	b=0SVAYHIuSeeoitFcHf9SjxxYdtdgM9Q+rbRuzJ0IZTVUlHWV7vhlECmUqbjR0Gy2nCKr
	 k27r2YIxxVmcBpge/TtkQKRkHmPSlxLyh14Gj2uXFOMUWOSWZm1C+apM6H+xlUgKTf28W
	 OndSLAn7evg4cV5rKs0ADJ7X2cMQK3urriSCxz83PCl0cS3Gr0MWQMxnDBZ4v+E1N7O/C
	 khc1dswoaDVnVi+BpppvD1F3d0VFEpcYgXrzsqvg4c5sZ0LZPAqdqSkTny3I+21nlOt4F
	 Ke9vGHbi4fGmg73jXXNubNg9MDUHWQ817+KQ+DrbuFg4HfrYI/i2Scc8Pp67gQINfxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000931;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=qDLkoWqq+lnN8FRxhDSjiq97CllCMlGCEUvlKkMFITU=;
	b=RZmY7PCJ/0NGcjdoxB45/+/rUFpZuxUXD7uJqzY98Z3Xf4bDr13hqMZDtclpL+jvvj89
	 bYcxmzvCMnHsGKnw25YaCWCd4AHfiP/JYeaU+sODSouPzzUBy83G6FoWyoX+IFOsSMFk8
	 klHCptUsgxulccyREXNV4CMBhGf13WqRIJapa/8W0KGAoFArr9OkeHVXidUjYD14C+jvd
	 8ezJRyJ/Q4e0iwFew1Y9j+ZC4T/0gGsWn8gowDSYjWsAmKz8EMNl8D/+d/vyRCSIpxsxN
	 XDfXvwGRXIVOhJVlEa+em2DLKAYcuh0Dgcq3eXYWVx5N8LsQ9XfFgxOThNPHIVgSl1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWM7+BZW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F071E606A326;
	Fri,  6 Nov 2026 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWM7+BZW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE901F008A1;
	Fri,  6 Nov 2026 21:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794000930;
	bh=qDLkoWqq+lnN8FRxhDSjiq97CllCMlGCEUvlKkMFITU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LWM7+BZWo6iB6FYAPzh0c/+NneA4GRu00bxhDJbxx+KsyGVaZCU3IVa8cp4XiE+pm
	 LGAiwqoxt8y8T9N2ttrNTgzhRWhihRAFHIE0Yg5CMHMzwS6p+jMaR9lNGv1d1hzB26
	 7PDkiEPOMz7U76jloU3dflVbupZLSSU5Hs75fKrEF602NzW90+T+xY7rEkv64CwW//
	 XkpwN75Td98j9LFc9zZ0RUf6rqpbFrbyALdw2GBmYppgYjktuqX8r8+79U/U97uDu5
	 0kv7/i7SJhZVEJaFpHGegILnDJaITpjqBHfbFGHu0tIsuAhh7COAqu2zhKtWTl6mEZ
	 XorYv27XlxjRQ==
Content-Type: multipart/mixed; boundary="===============1772708986620951677=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <23cbf06b46fa6d1cdfa3a9bbcd247deec22de8efbe5d1b2fff4cb89177171d56@mail.kernel.org>
In-Reply-To: <20261106210314.1767267-17-a.s.protopopov@gmail.com>
References: <20261106210314.1767267-17-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v1 bpf-next 17/18] selftests/bpf: Enable bpf_scan_ir in the config
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,brauner@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sashal@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 21:35:30 +0000 (UTC)

--===============1772708986620951677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Enable bpf_scan_ir in the config

TL;DR: Commit message only: the list of cases where Kconfig ignores the plugin
options looks incomplete (other arches, missing matching llvm-config), so "CI
builds and tests it" may not hold and fmodret_retval may silently skip.

>     selftests/bpf: Enable bpf_scan_ir in the config
>
>     The bpf_scan_ir plugin is off by default. Without it bpf_testmod has no
>     fixtures for the plugin and fmodret_retval skips. Enable the plugin in
>     the selftests config, so CI builds and tests it. Kconfig ignores the
>     options with GCC and with clang older than 19.
>     Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>

Is the list of conditions in the last sentence complete?  The commit message
says Kconfig ignores the options "with GCC and with clang older than 19", and
that CI "builds and tests it".

scripts/llvm-plugins/Kconfig has more conditions.  LLVM_PLUGINS needs
CC_IS_CLANG, a working $(LLVM_CONFIG), an llvm-config with the same major
version as $(CC), and a $(HOSTCXX) that accepts the LLVM headers.
CLANG_PLUGIN_BPF_SCAN_IR needs X86_64 || ARM64, DEBUG_INFO_BTF, !LTO_CLANG and
CLANG_VERSION >= 190000.

So config.s390x, config.ppc64el and config.riscv64 never get the plugin, and a
clang >= 19 host without a matching llvm-dev drops both options silently.  In
those cases the build succeeds, bpf_testmod is built without the
bpf_testmod_retval*.o objects, and fmodret_retval reports SKIP.

Could the message list the full set of conditions, or say that "CI builds and
tests it" only holds when a matching llvm-config is available?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42294987431
--===============1772708986620951677==--

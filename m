Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179822C0F8E;
	Fri, 20 Feb 2026 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771628266; cv=none; b=FHtPnCtrOGgflIUCng+zhRs+fnPB8yYqlI230YfSmjwg6Uq1UytRtqrEy2vJQ5bM31N6MSd3oIEe/LpoOtpacKSk6yi8n4zipYmublKKapYZViX14Gcqv5qlAp0Bh72QMV7TuCOoYEedcAE+P7Y6NY5aCEJTUm+pfzkvQHhTp3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771628266; c=relaxed/simple;
	bh=f2K4mz3xzX7XZVnhJJqm5caKRbajCUFOqlM+Tv2JjFc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kQCX5GYB6c5Czvc9CAXId9KEpYi50PWfmg8Gn47qbXEU57mPbQYRKMmHG2yGCph6KK0ycyNusoiNf4hXUM3IFzMFR4EO2Gez2/tTAn+gzNGzbsgP5xC5MAN1BjDtt1EDTXebZRJ2TjsrtUMUZjRR+ZDrvi5gPnxyPKjKD/ExzWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+dcR+q9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+dcR+q9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E00C116C6;
	Fri, 20 Feb 2026 22:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771628265;
	bh=f2K4mz3xzX7XZVnhJJqm5caKRbajCUFOqlM+Tv2JjFc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=k+dcR+q91hHTBO3O734NOK1oHio8aQMXhmxFe4UwKL1BgEDrETbE1tttx7XvI3a1Q
	 xdg/xEIg1RUkcGrIM+8VhZtbhngXAjGaRkzyB9vpaqxj12hGtCarH2GVOFK7G2jMg+
	 xLeg/Qi8bA+NZzIsskKuqJvuN6UsWSyoFvHfdGe3VEw2TrZTotrfqpmoxiebFKaaI4
	 dLivQYGqKs2Je4N10XGdQ5JjfNUdHGJxKYMuL4RSXkGMf2WAoKGagO4eRztmGXVDdA
	 wJNU4wlUXBNXEXvjNGZIQDhT5MgFPLb+7V7RdlihI1y9jygcXOkFJmqRRZPF150aED
	 RRc6XzI4ekbdw==
Content-Type: multipart/mixed; boundary="===============8902314731415162730=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <edac02ca77865be9cc18b013f5209a8fb0d8a4c443ce16dce8ad368a9ecefe05@mail.kernel.org>
In-Reply-To: <20260220222604.1155148-2-ihor.solodrai@linux.dev>
References: <20260220222604.1155148-2-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v3 01/15] selftests/bpf: Pass through build flags to bpftool and resolve_btfids
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,olsajiri@gmail.com,yatsenko@meta.com,alexis.lothore@bootlin.com
Cc: ameryhung@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 20 Feb 2026 22:57:45 +0000 (UTC)

--===============8902314731415162730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index 1733a6e93a07..ef083602b73a 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -65,6 +65,9 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>
> +ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
> +ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)

The "|| echo -lzstd" fallback makes zstd an unconditional link
dependency. On systems where libzstd-dev is not installed, pkg-config
fails and the fallback provides -lzstd, but the linker cannot find the
library and the build fails.

bpftool handles the same transitive dependency conditionally via a
feature test:

tools/bpf/bpftool/Makefile:
    ifeq ($(feature-libelf-zstd),1)
    LIBS += -lzstd
    LIBS_BOOTSTRAP += -lzstd
    endif

Would it be safer to drop the fallback here so ZSTD_LIBS is empty
when zstd is not available?

    ZSTD_LIBS := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null)

This would still link zstd when present (needed for the static linking
case where libelf.a pulls in ZSTD symbols from elf_compress.o), but
avoid breaking dynamic builds on systems without libzstd-dev.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22243753316

AI-authorship-score: low
AI-authorship-explanation: Human-characteristic typo in commit message, natural lore discussion with incremental debugging, and standard Makefile pattern reuse all indicate human authorship.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Unconditional zstd link fallback in resolve_btfids Makefile can break builds on systems without libzstd-dev, but the affected scenario is narrow and limited to the selftests build system.

--===============8902314731415162730==--

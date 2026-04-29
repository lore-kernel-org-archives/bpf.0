Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA2927AC48;
	Wed, 29 Apr 2026 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475608; cv=none; b=s/edYn+aGGztLrpng0hwauMsVHnz8g0dkVRpNttJLqL3UsWwoKqegBVrL2xg1dR2QTC906uTd/6gj9nq/7yJfgVmQTBf+N3UyUeTLs2peSl2alp5wcSWXhFHghJUO8gIyLXu/03GHTBlhVKQC5faxktmN3+CYVroyvqYkdZQ8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475608; c=relaxed/simple;
	bh=RWkVbu5/pi88Qi6bCf3N0GSV30pOVetYecwjLoyAac0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aQQ7TtmIqeaUNq2caBVua0wzyj3gMpBNcAp/N2GnYR86zbg3d0OyEGSw5lDKzP3ZVepZae9YIVO0Z78lp0L2fHl43lE02irbWbK00yTeoCtPpb2EULJ2yiREQm+HGUzBeSdoLzLTGa3cSJpuxQU2P4Ux48meN08aqEql30HvsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMdo7Vxb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMdo7Vxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EB8C19425;
	Wed, 29 Apr 2026 15:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475608;
	bh=RWkVbu5/pi88Qi6bCf3N0GSV30pOVetYecwjLoyAac0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=JMdo7VxbL4RqXbfmiXbcVoz3ULUxbm3umUwQVAdP2B3AnI/uUyf4FB9v9iAZ+nOfv
	 RpT4NIO6o4eANHMrf4tWJ0tyGMSnq5HjtbXwJVRvEuHyBM6lEqWItV2nXrv+/D009F
	 AXLvn5xbIFu3GuCUDYbKeLKZbDr9PdZh7l/LYrK6rLsjYglHP2CKqI1TFCzKtY21iX
	 /ZR6LItERbmZX4r2Z8+Ctrrik2R89CUZik3HENPIcEA1gJU4TP7QY6PPRHN/pvN6Af
	 hJxD+YL4IH56DH8+Pmy3lyP4MQkYRgkChA722UE6H2UfWxZVpze3l3eBCOnMsIzdzl
	 2V/mUWOTpD+oQ==
Content-Type: multipart/mixed; boundary="===============6422401205942298843=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e020f5f82d86e5da292d0ba7b1d707d5ce47f741fd77019d209853b8b7582816@mail.kernel.org>
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-1-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-1-c311f06b4791@suse.com>
Subject: Re: [PATCH bpf-next v9 01/11] selftests/bpf: Add BPF_STRICT_BUILD toggle
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Apr 2026 15:13:27 +0000 (UTC)

--===============6422401205942298843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 97ee61f2ade5..6094fe99b5f6 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -44,6 +44,12 @@ SKIP_LLVM	?=
>  SKIP_LIBBFD	?=
>  SKIP_CRYPTO	?=
>
> +# When BPF_STRICT_BUILD is 1, any BPF object, skeleton, test object, or
> +# benchmark compilation failure is fatal. Set to 0 to tolerate failures
> +# and continue building the remaining tests.
> +BPF_STRICT_BUILD ?= 1
> +PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
> +
>  ifeq ($(srctree),)
>  srctree := $(patsubst %/,%,$(dir $(CURDIR)))
>  srctree := $(patsubst %/,%,$(dir $(srctree)))

Multiple reviewers (Sashiko AI and bot+bpf-ci@kernel.org) raised a concern
in v5 that when permissive mode skips building .ko files, the
$(TRUNNER_BINARY)-extras rsync target will fail fatally during out-of-tree
builds (when O= is set) because TEST_KMOD_TARGETS are included in
TRUNNER_EXTRA_FILES but the .ko files were never created.

The rsync command lacks --ignore-missing-args flag to handle missing files:

tools/testing/selftests/bpf/Makefile:$(TRUNNER_BINARY)-extras {
    $(call msg,EXT-COPY,$(TRUNNER_BINARY),$(TRUNNER_EXTRA_FILES))
    $(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
}

According to the v6 changelog, this was addressed by adding
--ignore-missing-args to the -extras rsync, but this fix does not appear
in the current commit. Does the rsync command need --ignore-missing-args
to prevent 'No such file or directory' errors when .ko files are missing
in permissive mode during out-of-tree builds?

Reference:
https://lore.kernel.org/bpf/20260415211828.BFAFFC19424@smtp.kernel.org/
Reviewer: Sashiko AI
Date: Wed, 15 Apr 2026 21:18:28 +0000


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25115689001
--===============6422401205942298843==--

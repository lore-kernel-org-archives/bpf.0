Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8EC38D686
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 20:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369935; cv=none; b=n6iq06gICi5nJ/LYJd0Hm2vRkjQKYeSgM12OhcG/OfSqPVXtRe3W0knd37pooXwVDgkpyeiTiTIwAmG7LmB8umO2vQmBw9ugsAUWa9vyB7CTDNoG9erGRo76PXcM7MiauW2LegbG7I82NiQEAbqYdQehs7rsOt1hm7+AS0ccVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369935; c=relaxed/simple;
	bh=0ny18tY1O1oec6eFQW2WbzQ6a0GCwZVMhTdTJezNa2s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zn+E647SP/FkB2DD9D+5U9R4U8bFeo4KWUa6x7nsFsL8wFyMX3J7uTzhkvMAVugXAMM2Mpa+RYlfDD55J8QTspw6esvAAgtk8kEuZfHv4TS1DOmKg/pDqIUtVhLhX+zpSQcPFAVXAYHYXSGEjVWizvjLMvdyH2AqkHupuIGGN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTdJudoM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTdJudoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CE5C2BCB4;
	Thu, 16 Apr 2026 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776369933;
	bh=0ny18tY1O1oec6eFQW2WbzQ6a0GCwZVMhTdTJezNa2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bTdJudoMQE2rqTfzs8Uug/JOCnfBbEsEgiqhNyP/vsMkKXHWgE4rH9STsqdVQdrOK
	 eXwwdnMFSx8oLCJ70RHln1SnJAVETSC/m+riI74k5bF78JoO1053QAbu9QCIwfk5mq
	 NHk8bSaJHBsgSkeXLchZafDPCsNd9kXj2JebDENabXRrykNfu/lOcI7tWMmC+lebPa
	 T7TrkCAkjpJDgZL0M7NglpqoHNzaaS/5Dwox5stwqYd7DYmHADucklrgxTZfbYCOhu
	 My5Rk8PL5dnZNADldaCp79UHxj5Am7wzV8CP4AeOYly9pE3ZETdIA4ZF3tlsKJBfBQ
	 4hYgSvVYovWVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 08/11] selftests/bpf: Allow test_progs to
 link with a partial object set
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416-selftests-bpf_misconfig-v7-8-a078e18012e4@suse.com>
References: <20260416-selftests-bpf_misconfig-v7-8-a078e18012e4@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 20:05:33 +0000
Message-Id: <20260416200533.90CE5C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Moving TRUNNER_TEST_OBJS to order-only prerequisites in permissi=
ve mode breaks incremental builds for test binaries.
--

commit bb28ef3f04df5f17cc120a9836e147154e3974e2
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Allow test_progs to link with a partial object set

This commit modifies the Makefile to allow linking of the test runner binary
even when some test object files are missing due to compilation failures. It
moves the test objects to an order-only prerequisite list and uses a wildca=
rd
filter when permissive mode is active.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 5ad50d3ff2f8c..a5597e8431a0b 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -758,14 +758,15 @@ endif
>  # some X.test.o files have runtime dependencies on Y.bpf.o files
>  $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
> =20
> -$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
> +$(OUTPUT)/$(TRUNNER_BINARY): $(if $(PERMISSIVE),,$(TRUNNER_TEST_OBJS))	\
>  			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
>  			     $(TRUNNER_LIB_OBJS)			\
>  			     $(TRUNNER_BPFTOOL)				\
>  			     $(OUTPUT)/veristat				\
> -			     | $(TRUNNER_BINARY)-extras
> +			     | $(TRUNNER_BINARY)-extras			\
> +			     $(if $(PERMISSIVE),$(TRUNNER_TEST_OBJS))

Does moving TRUNNER_TEST_OBJS to the order-only prerequisites break
incremental builds when in permissive mode?

According to GNU Make semantics, order-only prerequisites enforce build
execution order but do not trigger a target rebuild if they are newer than
the target.

If a developer edits a test file, it looks like Make will recompile the
object file, but might consider the test runner binary up-to-date and not
relink it because the object is no longer a normal prerequisite.

Could this lead to developers silently running outdated test binaries after
modifying code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416-selftests-=
bpf_misconfig-v7-0-a078e18012e4@suse.com?part=3D8

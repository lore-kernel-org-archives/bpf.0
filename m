Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4840530CD95;
	Thu, 30 Apr 2026 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555844; cv=none; b=ZHQKEzvFpS9HiMGPPfnDgXuLFUHCkXPLmSKDKZDbVAVyvc0ccM5MeigC9YNFYEgBsRN6Bq2YTohWHerfr35ryOijKCAd5mjx3MOxm7DEKy6W5zeKw6pQ8oRrnl6GxoR+nkY7bWn/DQUN/qlSUGnCw++D12n1B0NrMF4KEgWY56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555844; c=relaxed/simple;
	bh=99fXgXxUkzhOkBU7eJUf1hb+gT5gO46DzyHAbfFJ5QA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=l/cHt1Ln+kEA+VS7e6fR5tpjZ+6FkFrOeJKqUyGnAZCyqjimsSxtxbGIy7Z+aCW2GWl+MGoX4KwOek+3zlRlf5mrlo5wQ+xbQIzfC1zLfk9D+zZTrOAeCL9wsioiZMptBM+BhcrnSM3mSHZyT9/TVT/SlmKXfX0SA31Msuotk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGw2x4Id; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGw2x4Id"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F329C2BCB8;
	Thu, 30 Apr 2026 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777555843;
	bh=99fXgXxUkzhOkBU7eJUf1hb+gT5gO46DzyHAbfFJ5QA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NGw2x4IdwxygxnePm/+WJkjN7Y6m79Jacj01lZdcxm2EorVacE9jYIs62hBdxPamU
	 D/D4O3ZEEBBGbBiR31WwPiGEV4pAsHEpEZo7TFjEtGC/ZKDSoPQQd8KpkDtrlnv5hF
	 gfJa+3kdZGPthumlyrlHvXwUtBHfoJ4u4GorGSFArm9WE52IweJCintmziFIMc2oip
	 wDeT7tgj8NzvOZN07ipiEySiPpDhkCO1DvI/sVFrMazidOq0EDN6b5/AzBEE0RXBRn
	 Flkga3AixW/xMVf/Ss7TTDkZSIQtLKS/r6g/6eL5PqyNTJ2u/LLgo6i+T3Kemh2ftk
	 Dbb8O6TNQgwvg==
Content-Type: multipart/mixed; boundary="===============7899902004849665635=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3a9c0b3b4546f4041ab4d20c1f231e704c2d93209ace88294ae84aacbbdfabe4@mail.kernel.org>
In-Reply-To: <20260430-selftests-bpf_misconfig-v10-6-cd302a31af16@suse.com>
References: <20260430-selftests-bpf_misconfig-v10-6-cd302a31af16@suse.com>
Subject: Re: [PATCH bpf-next v10 06/11] selftests/bpf: Tolerate test file compilation failures
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 30 Apr 2026 13:30:40 +0000 (UTC)

--===============7899902004849665635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 608e6dff0392..9becc077eb23 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -717,11 +723,14 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
>  		      $(TRUNNER_TESTS_DIR)/%.c				\
>  		      | $(TRUNNER_OUTPUT)/%.test.d
>  	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
> -	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)
> +	$(Q)(cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)) $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),|| \
> +		($(RM) $$@; printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2)))
>  	$$(if $$(TEST_NEEDS_BTFIDS),						\
> -		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
> +		$(Q)if [ -f $$@ ]; then						\
> +		$(if $(V),true,printf '  %-8s%s %s\n' "BTFIDS" " [$(TRUNNER_BINARY)]" "$$(notdir $$@)"); \
>  		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
> -		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@)
> +		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@;		\
> +		fi)

Does this condition correctly handle V=0 or V=2?

In GNU Make, the $(if) function evaluates to true if the condition expands
to any non-empty string. If a user sets make V=0, $(V) expands to the
string "0", which Make considers true.

Consequently, $(if $(V),true,printf ...) will execute true;, silencing the
BTFIDS output entirely. The standard msg macro used for other compilation
steps explicitly checks ifeq ($(V),1).

This results in inconsistent behavior where V=0 correctly prints brief
messages like TEST-OBJ but silently skips BTFIDS.

Could this explicitly check for "1", such as using
$(if $(filter 1,$(V)),true,printf ...) to accurately match the behavior of
the msg macro?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25167006036
--===============7899902004849665635==--

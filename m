Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7431A7E2
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 04:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777437527; cv=none; b=VZgNfTxfPlkLMkkREQAt7Lvb6HQ9y/zRKH94199+frstIj6hfPhhWxENeGSILpmo04m5r9p+f463MS+PjVQRaFkuRA1PnHKgz1HODcvrjZhgv4kKUE/UFBMBqjnwNDExMYZrrn/8DPsKs922y1nrKjjiIW0Ie66yHgw2pJv+3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777437527; c=relaxed/simple;
	bh=qpV3QUFmgYEqNitU/ldekwclnyjVyKwRL5qaO1Czzmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=muT7+BjyMMgm8dAOoUUF+K0/iOhA6tYyPrHwkkoeVl80ONo7PkMZ2SgiVW4Dolh7B32Ju8XzM2TWiv3Ld+2oy8A8nTxOTuT/n3xRDpDbHUS1IkPF7fwurh0pUlttM9HybLU5B9uknlcGP1RkgwLfgSNPWuUaa2QM1CTmAOuRIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rR9xYdxB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rR9xYdxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9012C19425;
	Wed, 29 Apr 2026 04:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777437526;
	bh=qpV3QUFmgYEqNitU/ldekwclnyjVyKwRL5qaO1Czzmg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rR9xYdxBcuiLFCf86+Et493SfI8LNGnIklhRve/B30USCHBOXi5tlL5FfGGfFB6yX
	 XseriQAImwyUvOWgGzMUnspgIjMuEfFp7fcMf63r2T8CXro56av0R7csshCAEaBFPw
	 XW9tkzoQd69nf4pVT+KQYW1G9I7GdhvXXFVkhE2tEYBsaIZL13tO3fZzoh055yRY7a
	 fgGeP9KJ7ixstCiu8b3dg32yFo/MH5ORn9vtKSk86/1KK70V9mxMlHFH8oCXfoMeR/
	 IMWejKoRydhJm6gYVgdQiY1Cd7VnGU9CYoVvt/wcAC5fj2FZVUjF9ruF6aLzc6OzUr
	 UWhh/RhLuVdhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 06/11] selftests/bpf: Tolerate test file
 compilation failures
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-selftests-bpf_misconfig-v8-6-bf02cf97dbcb@suse.com>
References: <20260428-selftests-bpf_misconfig-v8-6-bf02cf97dbcb@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 04:38:46 +0000
Message-Id: <20260429043846.B9012C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The error-handling branch (`||`) executes in an unpredictable di=
rectory context depending on which command failed, potentially leaving stal=
e object files or deleting unintended files.
- [Low] The patch breaks the verbose output mode (`V=3D1`) by unconditional=
ly executing the pretty-printed 'BTFIDS' message.
--

commit 2bc133e2e13cac20b234b4431b2122c75b488855
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>
selftests/bpf: Tolerate test file compilation failures

This commit modifies the BPF selftest build to make per-test compilation
non-fatal in permissive mode. It removes the output object on failure and
skips the BTFIDS post-processing step if the object file is missing. The
msg macro is also replaced with a plain printf inside the BTFIDS shell bloc=
k.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 608e6dff0392..f0545ee6b32a 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -717,11 +717,14 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:		=
	\
>  		      $(TRUNNER_TESTS_DIR)/%.c				\
>  		      | $(TRUNNER_OUTPUT)/%.test.d
>  	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
> -	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$=
(LDLIBS) -o $$(@F)
> +	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$=
(LDLIBS) -o $$(@F) $(if $(PERMISSIVE),|| \
> +		($(RM) $$(@F); printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2=
))

If cd $$(@D) fails, the && short-circuits and the || branch executes in the
original directory. Will this cause $(RM) $$(@F) to delete the wrong file
and leave a stale object file in $$(@D)?

If a stale object file is left behind, the subsequent [ -f $$@ ] check
would pass, and RESOLVE_BTFIDS might incorrectly operate on the stale
object.

Could the directory change be isolated? For example:
(cd $$(@D) && $$(CC) ... -o $$(@F)) || ($(RM) $$@; ...)

>  	$$(if $$(TEST_NEEDS_BTFIDS),						\
> -		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
> +		$(Q)if [ -f $$@ ]; then						\
> +		printf '  %-8s%s %s\n' "BTFIDS" " [$(TRUNNER_BINARY)]" "$$(notdir $$@)=
"; \

This isn't a bug, but does this break the verbose output mode (V=3D1)?

The msg macro used previously evaluated to an empty string when V=3D1, which
suppressed the pretty-printed message so only the raw shell commands were
shown.

Because this replaces the msg macro with an unconditional printf inside the
shell script block, it appears Make will echo the raw shell script block
and the shell will execute the printf, resulting in redundant and
misaligned output.

>  		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
> -		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@)
> +		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@;		\
> +		fi)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-selftests-=
bpf_misconfig-v8-0-bf02cf97dbcb@suse.com?part=3D6

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C540627C
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554652; cv=none; b=VxPBMHf/PBoz9v7ys5hem/+3NyFEAe+O+uvebVuAsO13eGGvAQe3j5nXXPNpS3P8PlBtcL81DcQfGqlsBG5L9QGxNPVbAbe/xMANONGhdP7qzq6WEyXhm80/2vCB61UtNLNe/ZxELnu/PCKU0tGyW2hn1aSpRMX6NEI1ctHcvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554652; c=relaxed/simple;
	bh=j34NnwlSOO6mG9ViEss7YPQSrKvIQRDKbbWk+z8xRgY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bQzBQWFjHpIA/mhmNeriYLUB+xtdqX4KPICFGgtRuIQr7tM2DUDfqsDcWVwbLNLtPoH3T7ePUzO645zrdOQAPv1cbyPifq9mHWklZd9ool97nJ5dwkb9O8oqxeeLvvyKZCFfA0gDwrR+WxMjPq5rXtkMic6HBVDopunRp4ejyoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuWOdrPq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuWOdrPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E683C2BCB3;
	Thu, 30 Apr 2026 13:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777554652;
	bh=j34NnwlSOO6mG9ViEss7YPQSrKvIQRDKbbWk+z8xRgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tuWOdrPqo+3FlrP1piWIFdjP+GHw4ra5TZdtd9INJPEd5Age051yjE4y6NJLPEHws
	 1E9RaxOWNI0kIybw1Xx0Dw/0X4F8zSA4zUiM7kD7rrddop6gT24Ylkd1eaIH1Irwcc
	 u/sCS8lAf8Vcehy4Yc5IfscHu9Zt5fCJHu81p8moIAhKtzHPJyaGLCaXrorNWOzO/B
	 XF88eoCuTL7mA4zJy45uuV0wswOaxppop5PzFPP83NysjDTa6ZkXxg3E/VbpG08WqW
	 DQXceYSv9fJehIVKHT4PaPJ3soq2uh/q6QJ3iGRm3fDu3N2zfJZIt3eWpU/0H7l+Ox
	 GSOJQN+MIKgzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 06/11] selftests/bpf: Tolerate test file
 compilation failures
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430-selftests-bpf_misconfig-v10-6-cd302a31af16@suse.com>
References: <20260430-selftests-bpf_misconfig-v10-6-cd302a31af16@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 13:10:51 +0000
Message-Id: <20260430131052.3E683C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The inline condition `$(if $(V))` incorrectly suppresses the `BTFID=
S` pretty output when `V=3D0` or `V=3D2`.
--

commit 0d69d461adbd02ed2bb765aad81f923aeaf2a8da
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Tolerate test file compilation failures

This commit makes per-test compilation non-fatal for test_progs, skipping
missing objects during linking. It adjusts the BTFIDS step to use standard
printf instead of the msg macro within the shell conditionals.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 608e6dff03926..9becc077eb231 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -717,11 +723,14 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:		=
	\
>  		      $(TRUNNER_TESTS_DIR)/%.c				\
>  		      | $(TRUNNER_OUTPUT)/%.test.d
>  	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
> -	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$=
(LDLIBS) -o $$(@F)
> +	$(Q)(cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $=
$(LDLIBS) -o $$(@F)) $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),|| \
> +		($(RM) $$@; printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2)))
>  	$$(if $$(TEST_NEEDS_BTFIDS),						\
> -		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
> +		$(Q)if [ -f $$@ ]; then						\
> +		$(if $(V),true,printf '  %-8s%s %s\n' "BTFIDS" " [$(TRUNNER_BINARY)]" =
"$$(notdir $$@)"); \

Does this condition correctly handle V=3D0 or V=3D2?

In GNU Make, the $(if) function evaluates to true if the condition expands =
to
any non-empty string. If a user sets make V=3D0, $(V) expands to the string=
 "0",
which Make considers true.

Consequently, `$(if $(V),true,printf ...)` will execute `true;`, silencing =
the
BTFIDS output entirely. The standard msg macro used for other compilation s=
teps
explicitly checks `ifeq ($(V),1)`.

This results in inconsistent behavior where V=3D0 correctly prints brief me=
ssages
like TEST-OBJ but silently skips BTFIDS.

Could this explicitly check for "1", such as using
`$(if $(filter 1,$(V)),true,printf ...)` to accurately match the behavior of
the msg macro?

>  		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
> -		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@)
> +		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@;		\
> +		fi)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430-selftests-=
bpf_misconfig-v10-0-cd302a31af16@suse.com?part=3D6

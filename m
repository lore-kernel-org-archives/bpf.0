Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A839D6ED
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777495071; cv=none; b=hYlnLhekvILC8rXMFtE6MS9VZ6sGXHUJfJV3hZtVd7/FN2tuujW1w6fV24W90dfa8M204Afveua3j1LrQae6sIkxfauNcwXZQUGRhMn+z5D31CWKR+8y0etF82uc4E710eDhTcOi95PxN1u5PNtpkufWAGexgTwkhQE34+FeE/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777495071; c=relaxed/simple;
	bh=UdrbwBEl55RHt9WyNCS6PLeyg1QM6yUZgGlZdi7zUU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nvq6yv1SD12s2LHNn5994Dlps8nTgZh5fkfkbk0gyvACSPJEYs8LlCYgcRZiZS6rELS+jYbLL3He2FWjlu0b5tKUX0KJpOEiUHhnqiu3hAkniDBYPP3lhXRTA3W3fwOkEM5KKa0G6z18x2TBPqhryey1rI2YTzPd/pM3kgFDRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCy8h7uN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCy8h7uN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4824C19425;
	Wed, 29 Apr 2026 20:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777495071;
	bh=UdrbwBEl55RHt9WyNCS6PLeyg1QM6yUZgGlZdi7zUU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lCy8h7uNisYH+CEG0BwrwSLzpRGv7X87/45lJIaRFl88Didb8ITQqgZdryGGUuK+o
	 JpofOROqip8507EM1bwIdHM5mQfW+C8NW0iFRxo+hAmoDpgHR8EEpw323P2LkNX1dt
	 1TaudMoWRnk/QVEt7n03DDKfB/aTWc+5OpOR4Iz+df4cwXiMY+Y6Kw0lzhtmoF3kwd
	 PAUvbBEd0cNukpF3L/5m2gTCdTgwXeonN39dZGQWVbh4cIMomecSH5Cy5+KohmKwpu
	 zIbJqN5YeiLm/fxY6aZgdWwR04fwSH5xmOSb5f6GmNTkJf4aWAaMV96ak07/Xlxomb
	 5R/mg2BKf2PxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 06/11] selftests/bpf: Tolerate test file
 compilation failures
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-6-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-6-c311f06b4791@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 20:37:49 +0000
Message-Id: <20260429203750.E4824C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The custom `printf` replacement for the `BTFIDS` `msg` macro incorr=
ectly suppresses output on `make V=3D0` and introduces inconsistent log for=
matting.
--

commit e98acd9f7c5260c9afc1f002b79650f156ef776d
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Tolerate test file compilation failures

This commit makes per-test compilation non-fatal in the BPF selftests Makef=
ile
by removing the object file on failure and printing a SKIP-TEST marker. It
guards the BTFIDS post-processing step to skip missing object files and use=
s a
custom printf to replace the msg macro inside the shell if-statement.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
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

This isn't a bug, but does this $(if $(V),...) check handle make V=3D0
correctly?

In GNU Make, $(if $(V),...) checks if V is a non-empty string. If a user ru=
ns
make V=3D0, V evaluates to the string 0 which is non-empty, causing the che=
ck
to evaluate to true and completely suppress the BTFIDS output.

The standard msg macro uses ifeq ($(V),1) to avoid this.

Additionally, does this custom printf formatting align with the standard msg
macro output?

The format string produces a slightly different log format and drops the fu=
ll
target path compared to the standard msg macro. This might lead to visual
inconsistency with the preceding TEST-OBJ output line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429-selftests-=
bpf_misconfig-v9-0-c311f06b4791@suse.com?part=3D6

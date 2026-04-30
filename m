Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619DB32470A
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567133; cv=none; b=pT/DNa1tDLW7bSxWLBaO+rm1gmen3TyQCewpJTKIu8Wd3Ho3kG87HcEBuiQjWW3u50RBt2bTGbhSgWhKvtXk5Mv5j2Ly/P0respkuNqrofpsFaZN0Hdf3OSMpoP9irhPotAeqTaa3zZNkR0dBqI5i5BJAoT8UTIB/DOL+jzy3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567133; c=relaxed/simple;
	bh=/gcpzjNln8juH7f+Rg3JrU6e+orhzABB3FgSCvFRxDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YP5raZ6XIIjfB0opw/3SVbbh4OgAXSnJf4IDOgco05BXtYrt6sKSTf914a0vtmWE/elJCFcAsx/6P4J87bpDr7ANSRKbPO4kL+aapMdMO7czs55jjhP7oJYArzu+wCOcKTa53CPX6XQthD0o/LpRmbpCTABc+p+U6rdmt0Oq8+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYEwc//x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYEwc//x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33CCC2BCB3;
	Thu, 30 Apr 2026 16:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777567133;
	bh=/gcpzjNln8juH7f+Rg3JrU6e+orhzABB3FgSCvFRxDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fYEwc//xaNIjMZG0ADWGtFNWep28aowfon7UD6SgX9755P/JkzJc7GhsRyjlj6A0R
	 JQJRdIkw0RTUozYWT5tU7i9uKcaKcsYk+AiVt3Y8dhv9aLwAvMS6m1v58hRoTJZj8x
	 m0yG9lNWbqwSfjOKt1OoPBznc3r56oWvecGASPFTnWpPATw83cvwpf/7iDETz5lt1/
	 3K27UWAE3xtF/X6I4vPvsYjboLI4IrYrmLXVQgbjCF5dtDK8JTtIVaZuJKefsciVM6
	 XYu+Diou7aXDOHhUaKg9X25SZV3XhtbZVtJBYKxO16TD5mj+WYjGhp0bbo46+QbEh2
	 3ajBnZlCay9wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v11 09/11] selftests/bpf: Tolerate benchmark
 build failures
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430-selftests-bpf_misconfig-v11-9-e11f7a8c4fdc@suse.com>
References: <20260430-selftests-bpf_misconfig-v11-9-e11f7a8c4fdc@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 16:38:52 +0000
Message-Id: <20260430163852.E33CCC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Skipping the 'bench' binary compilation will cause 'make install=
' to abort.
--

commit 17b45ab67f584992f6ac2a400e83d514968d8c98
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Tolerate benchmark build failures

This commit allows benchmark object compilation and final bench linking to
be non-fatal when PERMISSIVE is set. It emits a skip message and removes
the failed outputs so stale binaries are not reused by incremental builds.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 04634e6e0661e..a460f2ad3cffa 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -988,7 +989,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>  		 $(OUTPUT)/usdt_2.o \
>  		 #
>  	$(call msg,BINARY,,$@)
> -	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
> +	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@ $(i=
f $(PERMISSIVE),|| \
> +		($(RM) $@; printf '  %-12s %s\n' 'SKIP-LINK' '$(notdir $@) (some bench=
marks may have been skipped)' 1>&2))

Will removing the target via $(RM) $@ here cause make install to abort?

The bench binary is registered in the TEST_GEN_PROGS_EXTENDED variable in t=
he
BPF Makefile. The selftests framework (via tools/testing/selftests/lib.mk)
unconditionally attempts to install all files in this list using rsync.

Because lib.mk does not use the --ignore-missing-args flag for this target,
rsync will fail to find the bench binary if it was skipped (and thus
removed) during a permissive build. This non-zero exit status from rsync
would break the make install step.

I note this is addressed later in the series by commit 99f5f021f0516
(selftests/bpf: Tolerate missing files during install).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430-selftests-=
bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com?part=3D9

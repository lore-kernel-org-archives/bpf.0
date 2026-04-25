Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC01F16B
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079585; cv=none; b=n7tvrDkv80812WM5/fmkqb+bTzcfK1BmuVBuNJBf9BvHjqp6EROXQCfY6XEiC25tD8RPQ/7dQOuD/p50c5ococ86dJ5rlxXAcOugIIZMQb0k2SVQxrELexdeb0+eXRFb/sqyvuXXm/zjCnKv1o/p1I3Bdz03hcz9iiLHyO4XVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079585; c=relaxed/simple;
	bh=6pMloRHSu/Pvwmw3f8UI6PNV+DeZ9Av5jwL3xWSlhEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o5sO+LFRLAt0CEBD+4lXBnM7XCZEJ304wR+GnyfkcynoYCaIBUHP+VIHf2eoFsQC8DRG1H2515ZmX6z0YGAhteaTUwOQuXnOSPT+qcqpCCCmLzD0dSoLjB6YJyfZyIBgjICseP9ZAlNA1/oPGZAAzp/sNNRSLXfxA0JQZFav++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X688Hxxq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X688Hxxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E38C2BCB2;
	Sat, 25 Apr 2026 01:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777079585;
	bh=6pMloRHSu/Pvwmw3f8UI6PNV+DeZ9Av5jwL3xWSlhEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=X688Hxxq+ShG9i+QiDKfwcTgrKX+h4pDNz3jzhDVVKRWIE9z3fqm2YqoIOCKa+l2h
	 JvvFH+PYBXj5TW+nTZUYaWStqJZBe9kjU03tLnCwFFCoQgXSan5Y7eKNzknmFgSArM
	 uj9b1OBefjUAmUzUBMEzbwJBuu8XvhlJ0NDgoadC0JA5zJ7Noeu6+sp17nPHaCJuNI
	 uSWtOy7CgORe1wDrwHET78TUl5xgyT00XMXsipROcrzTxflNoM14oqANXVkr1lN+l1
	 8TpXw1rkppXmM3R1gMZ7adBngY6QlDauxDoH3x+YykO6uYHsOp2LOu9C8JxpZ4PiJ3
	 u26ngVimgAAZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 05/11] selftests/bpf: Make skeleton headers
 order-only prerequisites of .test.d
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416-selftests-bpf_misconfig-v6-5-7efeab504af1@suse.com>
References: <20260416-selftests-bpf_misconfig-v6-5-7efeab504af1@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 01:13:04 +0000
Message-Id: <20260425011304.D5E38C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The patch breaks incremental builds when a new BPF skeleton is a=
dded and included via a modified local header.
--

commit b493f7e4dc9746c484e30e391d53240eeb2b0fd3
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Make skeleton headers order-only prerequisites of .test.d

This commit makes BPF skeleton headers order-only prerequisites of .test.d
files. This is intended to prevent unnecessary recompilations and avoid bui=
ld
errors when a skeleton is skipped.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 7d1e5d6c30ec..b3eaa4a93707 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -717,11 +717,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:		=
	\
>  $(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.d:			\
>  			    $(TRUNNER_TESTS_DIR)/%.c			\
>  			    $(TRUNNER_EXTRA_HDRS)			\
> +			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)		\
>  			    $(TRUNNER_BPF_SKELS)			\
>  			    $(TRUNNER_BPF_LSKELS)			\
>  			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
> -			    $(TRUNNER_BPF_SKELS_LINKED)			\
> -			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
> +			    $(TRUNNER_BPF_SKELS_LINKED)

Does this break incremental builds when a new skeleton is added and included
via an existing local header instead of modifying the .c file directly?

Because order-only prerequisites are only evaluated if the target itself ne=
eds
to be updated, and the .test.d file only depends on the .c file and
$(TRUNNER_EXTRA_HDRS), the .test.d file might be considered up-to-date.

If the .test.d is up-to-date, make ignores its order-only prerequisites, and
the new skeleton would never be generated.

When make proceeds to compile .test.o (which is marked out-of-date due to t=
he
modified header), could it result in a "No such file or directory" error for
the new skeleton header?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416-selftests-=
bpf_misconfig-v6-0-7efeab504af1@suse.com?part=3D5

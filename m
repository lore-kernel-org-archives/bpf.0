Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D42DF13A
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 04:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436671; cv=none; b=aKi87X4DU0DTB8rBFAK2vdojjnW3vSdNslH7JZQaotVK8qlY8dcECyOEhJ9uxWSt9Gj+dRjfng0zCxtGnBtGtSiR3fNsaEcjVNuT4czNF6UJPsN+IAQYIVepzobDj3PvPdbx2YkZ+rlJ5rO7BqioCAL65PCtyZvwCPhwbzk3rYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436671; c=relaxed/simple;
	bh=XUdhmhT0js4z5YaL1Kr8gtQffKlcN3iVEqkaYjvDkCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aK9Sor6aO50JhkGJKL2xjtOVPb03pDlF1V0mipNhZs6KTmF57GO8XPX19n4beu3SR5cGrjTsN6Bs0n3OYdIYFdfYE3ql41TmAbPb91bJbDosod0u2mxDmzENRclVU3ZWIALqU0zojM9MTSQiqvCdwueVQMHEZWGMwXYvWijhVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5wH+2LX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5wH+2LX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53339C19425;
	Wed, 29 Apr 2026 04:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777436671;
	bh=XUdhmhT0js4z5YaL1Kr8gtQffKlcN3iVEqkaYjvDkCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=k5wH+2LXS//Xol/t+S63Z4FBcqdBuhxcOXLutyOVaoGJKqDD0/rhmdYw+jq72QFTm
	 ZuilaYjUmSINj27mWqhQ49Xa1ThywkJfngJJQdeWAqL/2EzcuYFTGS37/YAOgA+rJF
	 QYzrbjpEKFKXsTcOiAZEvm0f53yBD41GLY/cEWRmt0GITzvbNg+44W5eevnypJ+W/S
	 LqaHysLlZF2nn5SzvRD+Edx6AWZxt2SiPVSZK/rYE3pucvkmo4ITvXt/507ogp87ae
	 9uR7AcStYbSZu+pO/xQNJIXXJcTH6BvnhxeIhXlH6XpjWDSC1gQu43jBVg48VGbkq+
	 p9+379TOV8upA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 05/11] selftests/bpf: Make skeleton headers
 order-only prerequisites of .test.d
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-selftests-bpf_misconfig-v8-5-bf02cf97dbcb@suse.com>
References: <20260428-selftests-bpf_misconfig-v8-5-bf02cf97dbcb@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 04:24:30 +0000
Message-Id: <20260429042431.53339C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch claims to make BPFOBJ an order-only prerequisite, but =
incorrectly leaves it as a normal prerequisite.
--

commit 1c23b38fb90b7e8ceffcd630b01bd346c227417e
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Make skeleton headers order-only prerequisites of .test.d

This commit attempts to change the .test.d dependencies so that missing
or skipped skeletons do not prevent generation, and rebuilding libbpf.a does
not force recreation. It updates the Makefile rules for .test.d generation
to use order-only prerequisites.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 9a4d8bea0c18..608e6dff0392 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -726,11 +726,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:		=
	\
>  $(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.d:			\
>  			    $(TRUNNER_TESTS_DIR)/%.c			\
>  			    $(TRUNNER_EXTRA_HDRS)			\
> +			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)		\

Does this keep BPFOBJ as a normal prerequisite rather than an order-only
prerequisite?

In GNU Make syntax, the pipe character (|) separates normal prerequisites
(before the pipe) from order-only prerequisites (after the pipe). Since
$$(BPFOBJ) is placed before the pipe, it appears to remain a normal
prerequisite.

The commit message mentions that "rebuilding libbpf.a does not force .test.d
to be recreated", but since BPFOBJ (which points to libbpf.a) is a normal
prerequisite, wouldn't rebuilding libbpf.a still force .test.d to be
recreated?

>  			    $(TRUNNER_BPF_SKELS)			\
>  			    $(TRUNNER_BPF_LSKELS)			\
>  			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
> -			    $(TRUNNER_BPF_SKELS_LINKED)			\
> -			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
> +			    $(TRUNNER_BPF_SKELS_LINKED)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-selftests-=
bpf_misconfig-v8-0-bf02cf97dbcb@suse.com?part=3D5

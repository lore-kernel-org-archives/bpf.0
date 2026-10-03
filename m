Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B8388873
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991235; cv=none; b=NLVD/D7EeInfge4kfwLmRHuJ6d2/r24+8bTiFwxYVwefjSvHwpvQ1EtBl40ouKxZOiR6sHIRxcV3PMvVxBmglewS8QQr68AXQWxGzhyJUNm5TQswIsbNJea3nCNRy1LRd9djT7Xx9dq0EBMfR+3iLt/6YD61Gng4tSwTfi/yLi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991235; c=relaxed/simple;
	bh=4Y02AMlc4b229k0+UKX83S3IEtYJAhu/IdUlKraAbJk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kDv98r4/YKQmtlhbM9hyEC07UAM4e9oFDGK6lqosQZeLLvGjcHqfK/AQgVnwaBn4Pn3W1PXpkvr8IvKLzYyagVNw3BuldghN20saCHFaPmqEO86BCMjx3CDUidFMIIAyBhbfpRMxGkZvm7fKvDDcOR5cs01zo3xcaAkoyA//rPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6uK2oVD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6uK2oVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8771F00898;
	Sat,  3 Oct 2026 01:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991234;
	bh=Y9zuW+0NMYVhdhWFsf2Q/OGGptss4HBLnJx8lRS8cV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q6uK2oVDtfmYDrXAYvO5PqhXPQgoSio4I24W9C2bIAcI7Vq5ak7nkkGd6kXAUQQWK
	 19E1OoEetPVGQT/EKQlcZwZIFJJyScR69goS8Mu0HfTucpTLmZ04p3yon+F3sGwK6Z
	 3W8faTpRMrOOhERwHX2BdPWcPJiVHGvECtYP30vDdq3avZnkngoTlRALWhNnxz01gI
	 yzcO1O10eXjALbwl5YAt2phIMG4fkbwfAHnr5TQHQ3LFkaAYQ1Swg2bJrQc1fh9NiT
	 8hWD+FmaaWwp2Sb/zO01Ybo8wJeT9wE8Ufwzr+OD+O2Qsja4qKFUMtuanXCQX+kEbo
	 pKbwpL9/z8XyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 04/13] selftests: net: add a generic rule for
 BPF skeletons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261001202124.692591-5-maciej.fijalkowski@intel.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
 <20261001202124.692591-5-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:53 +0000
Message-Id: <20261003013354.1F8771F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Makefile shell redirection leaves empty file on failure
--

commit 819b3d37545dcc960fb225a24a62ad26c2989d48
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

selftests: net: add a generic rule for BPF skeletons

This commit adds a pattern rule in the networking selftests Makefile to
generate skeleton headers from BPF object files using bpftool.

> diff --git a/tools/testing/selftests/net/bpf.mk b/tools/testing/selftests=
/net/bpf.mk
> --- a/tools/testing/selftests/net/bpf.mk
> +++ b/tools/testing/selftests/net/bpf.mk
> @@ -42,6 +43,10 @@ $(BPF_PROG_OBJS): $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MA=
KE_DIRS)
[ ... ]
> +$(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o
> +	$(call msg,GEN-SKEL,,$@)
> +	$(Q)$(BPFTOOL) gen skeleton $< name $(notdir $*) > $@

[Severity: Low]
Does this shell redirection leave an empty or corrupted file on failure?

Because the shell truncates or creates the target file before the command
executes, a failure in the bpftool command might leave a corrupted file
in place.

Since .DELETE_ON_ERROR: is not defined in net/Makefile or net/bpf.mk,
GNU Make will consider the file up-to-date on subsequent runs. This
could cause the next make invocation to fail and require a manual cleanup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001202124.6925=
91-1-maciej.fijalkowski@intel.com?part=3D4

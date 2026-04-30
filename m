Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9C2C21E6
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566561; cv=none; b=Iwxnf+iEoJJrOoQRuKB+FdXQVmmmHegXoDpegCtsIF86RX2jr+3iX7mhpDjNxctfKM5ZyJNnX4SW/WTwcIGF1CZ9vzL4pXvlRKEuuqqVMSY5WKgMBXIuEJ5RX3dSK5pb1hohSSEfFSrb/aeJvUETLXu12peUIIPmYitzh6WA8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566561; c=relaxed/simple;
	bh=xKBZZfMijtUQm+jwmeLQXnhJzwT0f8Fek7Saoejezpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VhvRoNFZkSGNNrPj+04bfyp2naZJEhoDA8uVQsxwE0SpJTndckqHd+he1jIPq+HREOlFDXWHs5tmWFnNB1YJQQIZkqRzUHKa2N9tRmkSdHOqVRYZ9gpeV+4U6AmZ/tWa5u8K0P/UWGpcf/w2U5KnIXYpLzZhcqdLsfaWmQxPtfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpguOcoe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpguOcoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0829BC2BCB3;
	Thu, 30 Apr 2026 16:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777566561;
	bh=xKBZZfMijtUQm+jwmeLQXnhJzwT0f8Fek7Saoejezpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NpguOcoe8OBiR9seQuzi2HGebFIynpEJFheT6AFHi19fUeBGqeeKaCSLrypIfL/wZ
	 thAIv0JJ3ZBALwQRFJ5B65l5rkIqqV+q6wQpWbIvifejrNyBjPBJ66uGK6nzjAnSW0
	 D7QW8cg5bAFV+RNpdT28saIFcXM9m64agHeKjS8EWk+DAJEDTPE3zkcCTyXgsXmUlL
	 xujLVzXmUx4Ga+a/v7ggQ7TYN7jizhUek0fVdQX/VGkHfoIeZ4oQmVJ5jazHyQlxyV
	 WPh9utCQLQee1s9jQ7Ps2ck0lVvJMY+/Lia2y1zdmfwcCdC/kpTapmUquHWgaLXuvs
	 7sQV39VZVqYxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v11 05/11] selftests/bpf: Make skeleton headers
 order-only prerequisites of .test.d
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430-selftests-bpf_misconfig-v11-5-e11f7a8c4fdc@suse.com>
References: <20260430-selftests-bpf_misconfig-v11-5-e11f7a8c4fdc@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 16:29:20 +0000
Message-Id: <20260430162921.0829BC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Making BPF skeletons order-only prerequisites of `.test.d` preve=
nts the generation of newly added skeletons when they are included via exis=
ting local headers, breaking the build.
--

commit c609958fbea63ac5aab9bea46f3e2a6881af6a94
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Make skeleton headers order-only prerequisites of .test.d

This commit changes the Makefile to make BPF skeleton headers order-only
prerequisites for .test.d files to prevent unnecessary recompilation. The
BPF object file is kept as a normal prerequisite.

> Note that adding a new BPF skeleton via a modified existing local header
> still works correctly: GNU make builds order-only prerequisites that do
> not exist (the order-only qualifier only suppresses timestamp-driven
> rebuilds, not existence-driven builds), so a brand-new .skel.h listed in
> TRUNNER_BPF_SKELS is generated even when .test.d is otherwise up to date.

Is this assumption about GNU Make accurate? According to the GNU Make manua=
l,
order-only prerequisites are never checked when determining if the target is
out of date.

If a new BPF skeleton is added and included via an existing local header,
the normal prerequisites of .test.d remain unchanged. Make will consider
.test.d up to date, skipping the order-only prerequisites entirely.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 9a4d8bea0c184..608e6dff03926 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -726,11 +726,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:		=
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

Could this break incremental builds? The old .d file would still track the
dependency on the modified local header, causing .test.o to be correctly
identified as out of date.

When Make runs the compiler for .test.o, will it fail immediately with a
missing file error because the new skeleton was never generated?

Furthermore, if a subsequent patch tolerates test file compilation failures,
would this result in tests being silently skipped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430-selftests-=
bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com?part=3D5

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625993E7BA3;
	Tue,  2 Jun 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407452; cv=none; b=g7f5LFgNnCLYZKcPBmjV/24gyo7I+FBB0QJeEAUmCa3xs2AwT6+zLwaIF9WYXs7to5am+qhV4inEKArmclBIowTAMfqK/crgQYsuYNC1ljcDsRO03UHFOsB1bqmX1VOAXOwgtzTGUhNW/TPBt1zPWlBDb/mo8QAgHmvLU57c3bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407452; c=relaxed/simple;
	bh=BiIuX3GEfgEGigGjIPCmgTUh2I4sZLbNCb4fapIoYwI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bM95nrqcpzVWl8mnzAXpl7jWNPw+6SP74a1XMtCZ6oEPGEk6z+GWjFI62ZIJsVHh0lADbb3MrCiOxd+GKdnKDW0wHlc5d+yNjvRo1diegPr359gAUW8AvwwL9CxjBVi74SZ1AAnYUCmHKbF8YEYUsbQ4vNrDMCLJ3oo6pp+Bb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i02IHPEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i02IHPEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10BD1F00893;
	Tue,  2 Jun 2026 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780407451;
	bh=lSQqW/a82YaYohCGwQDojjq6a6IPnK86k/3oYt6lU0I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=i02IHPEIyFDo1SPBnC5IssoPs9Vxkcslopr4JZqQ9gzoii0882OhmRUG/wAUMDmHx
	 bKisDbK11Ag5DZTEURqOFxer6nTi3cvNgnrt3/DSlB/9PymDu0+EbsPSymvCvEEiys
	 NcCzQXcGRdkys2mr6FCWoa9kwvENIlDLsLpKcdaVSF6ZUjmkth/hrtSaxrrOMsiJSi
	 jz6ZfkVl3uva0TVOnLONXJU48ie2YOXyfjV2EEYKTyfN1yA9mXwYdGbe46S2H1ZGAL
	 1kHLUiYqSWSnyLrLUbsXWNAGd6xUxczuFgb6MRQNndCceQLWyCL57VqdpfcLLSNYpm
	 MiGg1td8xg/FA==
Content-Type: multipart/mixed; boundary="===============4050644796597654082=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d835c3a0f12681c96bb72764ba18db8ca1e0c511bf0c420f3918eab1559c83ae@mail.kernel.org>
In-Reply-To: <20260602-selftests-bpf_misconfig-v12-5-27f898b3ba26@suse.com>
References: <20260602-selftests-bpf_misconfig-v12-5-27f898b3ba26@suse.com>
Subject: Re: [PATCH bpf-next RESEND v12 05/11] selftests/bpf: Make skeleton headers order-only prerequisites of .test.d
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 13:37:30 +0000 (UTC)

--===============4050644796597654082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -726,11 +726,11 @@
>  $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
>  			    $(TRUNNER_TESTS_DIR)/%.c			\
>  			    $(TRUNNER_EXTRA_HDRS)			\
> +			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)		\
>  			    $(TRUNNER_BPF_SKELS)			\
>  			    $(TRUNNER_BPF_LSKELS)			\
>  			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
> -			    $(TRUNNER_BPF_SKELS_LINKED)			\
> -			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
> +			    $(TRUNNER_BPF_SKELS_LINKED)

bot+bpf-ci@kernel.org suggested in v11 that this patch should include a
Fixes: tag pointing to commit 81b7e7ba095f ("selftests/bpf: Tolerate BPF
and skeleton generation failures"). This appears to be a legitimate
request since this patch addresses issues introduced by that earlier
commit. Should this include:

  Fixes: 81b7e7ba095f ("selftests/bpf: Tolerate BPF and skeleton generation failures")

Reference: https://lore.kernel.org/bpf/8bfb94f32bee29ef1204a13edb057cba1f61251eed39c5fa5fb86bf9e0cdb567@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26821824931
--===============4050644796597654082==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648C472764;
	Thu, 30 Apr 2026 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567319; cv=none; b=oGcnN4MVNAgnEQPPgQC8Sqbkpf1FwdJQWsQMElPZYuJsrJbhEEs4zhUtG0d4RlHJ6AUIvndUnwzi0eSyeLEl4OAxEpDZJzw1oaYLlnQQlefPHg+DTzno1t6oey/VPYzLeTzTbwXGJC6KECd5B4Ae3fY0xcm5/RvkcQjaPN4bYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567319; c=relaxed/simple;
	bh=GbvnM7bJWLwLfTBcmTmFgvP9zp0FkZYr6bLM2eEO3Zw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cTHGO0dJYL5ouiSZhqSdMexBARQZOni7jv4M4JYjTwmqvi6RmefEs9J9oenFLjd+VXdOBZorvw2mT7A8jheX6zl/soSwtYXCBAo/mirOcKkRTvH241hO7aXHLk5JMEoxcx42w6nhmAsVr20O0QO93AnJwVP4An/c7zfjHdCa/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8XlONB7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8XlONB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB88C2BCB3;
	Thu, 30 Apr 2026 16:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777567318;
	bh=GbvnM7bJWLwLfTBcmTmFgvP9zp0FkZYr6bLM2eEO3Zw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=K8XlONB7SGh7aMjHKsrOFxbBVnYRNguJ2Mq2xaTJ5VIcvhBac3yROG2D6T+Dz9Prn
	 BUylO5fk6fM8t8m3Cbzv9nsUo2KotpwORiWAFTkTc96HP0axue68XMoai3ja/OjptD
	 iIrAkbu28MjeLgrbyIbSAkE9VdtNxGWWYmEoPUWYy0VC3Y+9e39FHVlMQf1kTsLw6p
	 8kc65XuR5kzlhow5JZbbzKCybAc/dbooGaVbtxM9U2k+c6I2VzxY0p7dKo7jjRJjvg
	 Ie/YLhrF/9R8fWIREG8CImM3Sji1ynmyVazUMmHPXzW3D9IBsQKk4HoKuXiTbfOFJx
	 jzqd8qt5lNkGA==
Content-Type: multipart/mixed; boundary="===============0748131300935954994=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8bfb94f32bee29ef1204a13edb057cba1f61251eed39c5fa5fb86bf9e0cdb567@mail.kernel.org>
In-Reply-To: <20260430-selftests-bpf_misconfig-v11-5-e11f7a8c4fdc@suse.com>
References: <20260430-selftests-bpf_misconfig-v11-5-e11f7a8c4fdc@suse.com>
Subject: Re: [PATCH bpf-next v11 05/11] selftests/bpf: Make skeleton headers order-only prerequisites of .test.d
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 30 Apr 2026 16:41:55 +0000 (UTC)

--===============0748131300935954994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 9a4d8bea0c18..608e6dff0392 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -726,11 +726,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
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

This commit fixes a bug but lacks a Fixes: tag. Based on the commit
history, this appears to address issues introduced in commit 81b7e7ba095f
("selftests/bpf: Tolerate BPF and skeleton generation failures"). Should
this include the following tag?

Fixes: 81b7e7ba095f ("selftests/bpf: Tolerate BPF and skeleton generation failures")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25176431268
--===============0748131300935954994==--

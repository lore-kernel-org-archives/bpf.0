Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D937F73B
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772651780; cv=none; b=LmaZeFMQ+Hor/lu4BPinlRwo6zJ0ND0mP8LIJHcQrPg6HfyiQjEzgsSQkbSVBXGE4vI890LL+OqtLJNRjO2zw70E2KNmtWV1h51yByh2zWQIjQMJo3L8pk8qx4pJPKMIIGdNpI94dHJQOslfFHSVK0hDwiP+u8qcEnu3rsjhH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772651780; c=relaxed/simple;
	bh=sP0CN953w49TpHcfLG0HyppJFXVpbaRhi9iybC+d8/Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XmdhOvXrfgHXHlm/+qMtmO14FUNS4i6cgikoym60uRlOjCGpivTvdULptn8uBK4TO8mouaqiPHJ/yO1AMbhoN9d2Lss3cRnKy/6fG2a1nn7MLzL6G1eWPmInHp6Msw59b+Pi/HwjwkpeSNkooMgJEhphsRGerRNBWQD+h24NlcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5mvpKsB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5mvpKsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB0FC4CEF7;
	Wed,  4 Mar 2026 19:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772651779;
	bh=sP0CN953w49TpHcfLG0HyppJFXVpbaRhi9iybC+d8/Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=r5mvpKsBV43MxNSZqY6qsgzPv+Mz2dBKolzkKvqEIaSPfATBrR5eN2dxqLFVT64pU
	 2DjcV+8tkgwkgU5z3HAP2ifaLSprlyByCHIogIpDOtwVHteQ6jjCYBkHgsxwtkd6GO
	 AlCeB9rZK/GIPagO2SreVOyXamjCsB4l2uS9kdRPaIvKew/SrzppmyPtffaQ+B54YO
	 VkQDvYQUfWbi2Ln0T47GTeuC1PT40q0X2bD0G7Z8J+rvdSMJnqkXoOKAdNEmVb1WZn
	 DLyVxFOvqCbZsM0rQdUGN1/n042PPQYkKclV7Uf8T8bP5hj+qKoFmy812Ni9o4ypYx
	 sp1r75yJ2f+SA==
Content-Type: multipart/mixed; boundary="===============0343443932592754989=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4825b62fa63a8e19552161ad8b3310629fe80c956c47fc6165e29bdd132c7df6@mail.kernel.org>
In-Reply-To: <20260304184058.180310-2-cupertino.miranda@oracle.com>
References: <20260304184058.180310-2-cupertino.miranda@oracle.com>
Subject: Re: [PATCH v3 1/2] bpf: detect non null pointer with register operand in JEQ/JNE.
From: bot+bpf-ci@kernel.org
To: cupertino.miranda@oracle.com,bpf@vger.kernel.org
Cc: cupertino.miranda@oracle.com,david.faust@oracle.com,jose.marchesi@oracle.com,elena.zannoni@oracle.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 19:16:19 +0000 (UTC)

--===============0343443932592754989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/log b/tools/testing/selftests/bpf/log
> new file mode 100644
> index 000000000000..c846f86c5642
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/log
> @@ -0,0 +1,28 @@
> +
> +Auto-detecting system features:
> +...                                    llvm: [ OFF ]
> +
> +/home/tino/oracle/playground/bpf/debootstrap_image/pristine_to_test_in_chroot/tools/testing/selftests/bpf/tools/sbin/bpftool btf dump file ...

Were tools/testing/selftests/bpf/log and
tools/testing/selftests/bpf/verifier_jeq_infer_not_null.bc
accidentally included?  The log file appears to be local build output
containing developer filesystem paths, and the .bc file is a compiled
binary.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22684155285
--===============0343443932592754989==--

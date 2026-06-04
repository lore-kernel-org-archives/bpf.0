Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FF02989B5;
	Thu,  4 Jun 2026 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537818; cv=none; b=kqFwtfDVlBQZPp/X0CO65I4qKFzdNccND1Jbjp70beRNYKHzQjVm6VL6xHkn5rP+dOJRy+a1htDGF5SQmBig5iXmgLYail+XnCx52d13ky8aDXVVSkW8MrvbC5axlqxZQNpCFdm3jkoEk5eMVaTrRTw2eww2/pBQghExY9JSg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537818; c=relaxed/simple;
	bh=mQvo2PpSlc3yJtcSWSz3uvnASBkIOLRsjClD0Ql+Evw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YL8ynyWyVmNreAzBGN8WCK6xY0+y7XI9Y+7oeR0VvFTUFm+z6rEQKoOmR0K+txujG58mmaDsxxv3BpWhG+XXfbf3OsZucQ1qUbZJCkdiMHy9HUaVEoUBrzk9mXK/U7mcz7l4Y/93k/yuPtMa/+9dvFx7GWkCHEvxV0jToH4yv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+zSS0Am; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+zSS0Am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF311F00893;
	Thu,  4 Jun 2026 01:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780537817;
	bh=pfKyCNVco24/zBt8XvJvqAKyR5qloFcCh/cvmTpP81o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=H+zSS0AmnsDMy6Tz8fxAGU8NveVPXnF7cHyG9NnNRvJADXfleTHcT8+8dx1JVqcjz
	 l3o9qlR/rOK8K4yD5BtL/o29WuagCWbc2VJvl3v+U5+EokDWXSFBXI6a0pi+u2cRFj
	 djasM/AeGJPW1Kmpt9OeeER5mKFtPuQjIljf3gW0NVuVZ96zl1gDKDCm8dwXrmfBud
	 kbS85ISaaLivKpu9CeIxv15AJOm+h5INSAdsw1tsr5CtwrNdf8ff2v4OJCFNxfBK7w
	 t4BE7UE/BwXzyPCmsywZcbzbiD5u6PnvNsh4MYIEOE+A+G/cGbqfUvkrUpi+cmrEEj
	 ddiJIJV1lyz4g==
Content-Type: multipart/mixed; boundary="===============2769173019627471115=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <74147fc81dc525aa48190b5390b1fd7a1b64ff882402ca93eb4f1dadce6a3528@mail.kernel.org>
In-Reply-To: <20260604005729.1992632-2-malin89@huawei.com>
References: <20260604005729.1992632-2-malin89@huawei.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: Cover tail-call cgroup storage prog-array checks
From: bot+bpf-ci@kernel.org
To: malin89@huawei.com,ast@kernel.org,daniel@iogearbox.net,bpf@vger.kernel.org
Cc: andrii@kernel.org,john.fastabend@gmail.com,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,zhuyifei@google.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ameryhung@gmail.com,malin89@huawei.com,cuirongzhen@huawei.com,tanjingguo@huawei.com,cenxianlong@huawei.com,chenzhe@huawei.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 01:50:17 +0000 (UTC)

--===============2769173019627471115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index 7d534fde0af9..f8c4b569da95 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c

[ ... ]

> @@ -1777,6 +1928,14 @@ void test_tailcalls(void)
>  		test_tailcall_freplace();
>  	if (test__start_subtest("tailcall_bpf2bpf_freplace"))
>  		test_tailcall_bpf2bpf_freplace();
> +	if (test__start_subtest("tailcall_cgrp_storage"))
> +		test_tailcall_cgrp_storage();
> +	if (test__start_subtest("tailcall_cgrp_storage_diff_storage"))
> +		test_tailcall_cgrp_storage_diff_storage();
> +	if (test__start_subtest("tailcall_cgrp_storage_no_storage"))
> +		test_tailcall_cgrp_storage_no_storage();
> +	if (test__start_subtest("tailcall_cgrp_storage_no_storage_bridge"))
> +		test_tailcall_cgrp_storage_no_storage_bridge();
>  	if (test__start_subtest("tailcall_failure"))
>  		test_tailcall_failure();
>  	if (test__start_subtest("tailcall_sleepable"))
>  		test_tailcall_sleepable();

In the v2 review Leon Hwang asked that these new subtests be placed at the
tail of test_tailcalls():

  https://lore.kernel.org/bpf/20260603150213.68746-1-leon.hwang@linux.dev/

  "These new ones should stay at the tail of test_tailcalls()."

Here they are still registered ahead of tailcall_failure and
tailcall_sleepable rather than at the end.  Was the intent to move them
after the existing subtests?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26923843925
--===============2769173019627471115==--

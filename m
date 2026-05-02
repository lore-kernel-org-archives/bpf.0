Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8711E633C
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777740054; cv=none; b=iYzZGtI+UYoBomH1VKdvCEte2as9H0sHuFsMM6C5yZPyV1iympYm3SYATeorZTZlb90ZYHvb7u4JzzFXTIVrGzyAvc+QCro6U+dd/OYyaYgtjlQxc8C5u1huct6o4mCf//4EK0SOIceHCEiOVZ5DSiYKDXrnabvunvrHZ93HSuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777740054; c=relaxed/simple;
	bh=/JRzLxqIe1CqH1qMtEYKKu2dm+ZOD/jd1cb0jRh1HY8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jDDpAsSWUABQomObpUPGOeobYOy9pP6whzbvv0Q10ozbDJOcEveJtC89VdgujevZmQKr6KGprakMG7Yus3ZA0wgpPbvKefsGQffv4/fhehReRaGd/GEnuo8epXozIwnj/J/tlq2pWuP8co13xwwaWDcsPC/NYRxaJSar2n+zkpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cS7uqzCt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS7uqzCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD111C19425;
	Sat,  2 May 2026 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777740053;
	bh=/JRzLxqIe1CqH1qMtEYKKu2dm+ZOD/jd1cb0jRh1HY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cS7uqzCtQwUMSHJOgpaD0XcNnk0rv1M32vH8ZDlyrwfqZ71WtCLRmrCb5NCmlo30Y
	 JGXmvOfYlyYAeWRuZeUhTGTXtsVqDS2oJ76637QEo62wUYV4ZDzwkw3wgsZKM7zqER
	 VgJxi3NF1RW5ZYTbFEonHLWEzAwB/o4krwrrN06nWXpaDYgdiDL0Hl5puetMKX9fFT
	 nV5184Nxvf07jN4siSlbftstU3YJjr/FP6FnUzP77VyPZgw/OijB87Nd0L7ATsab6Y
	 q5EMOIQ1VPrMY0FMT/B1DJgED9rnADOxoRNWlzIpMmKF0JvlWUF21rlSmwmp3Cm+cG
	 HamFyEYv87QWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC9D380CEFE;
	Sat,  2 May 2026 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] tools/headers: Regenerate stddef.h to fix BPF
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177774000581.3879891.10038495861005323120.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 16:40:05 +0000
References: 
 <8da8ef16055aa452d940668ed5359ce54adc6b0b.1777715500.git.paul.chaignon@gmail.com>
In-Reply-To: 
 <8da8ef16055aa452d940668ed5359ce54adc6b0b.1777715500.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 2 May 2026 12:12:40 +0200 you wrote:
> With commit dacbfc167808 ("crypto: af_alg - Annotate struct af_alg_iv
> with __counted_by"), two selftests, test_tag and crypto_sanity, now
> indirectly rely on the __counted_by macro. On systems with commit
> dacbfc167808 in the installed UAPI headers, the selftests build fails
> with:
> 
>   In file included from tools/testing/selftests/bpf/prog_tests/crypto_sanity.c:7:
>   /usr/include/linux/if_alg.h:45:22: error: expected ‘:’, ‘,’, ‘;’, ‘}’ or ‘__attribute__’ before ‘__counted_by’
>      45 |         __u8    iv[] __counted_by(ivlen);
>         |                      ^~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [bpf] tools/headers: Regenerate stddef.h to fix BPF selftests
    https://git.kernel.org/bpf/bpf/c/0c7ae130698e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



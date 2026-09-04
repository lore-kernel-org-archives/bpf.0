Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA9050EC15;
	Fri,  4 Sep 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541266; cv=none; b=H3aP1yo0XNGSjpRRZy6QK+YYc36lFfrd6zPcL/qevErxtbRYybE23A6fqonJcvqR88dZN0fIibVbmFOXp+Qae1dn7/9Lwsf6f7ItHIe8T7jV0CTeXPgdtFMYAeP34rrnV7Jqa9hFEXEefUbP3wFxmlKX4ML1YgiDzrUzh0OmMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541266; c=relaxed/simple;
	bh=44zkCpR+Q6trSzxeaV93VhjJiybQ3LcyKsvSiRb1yT4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YoWyTjR8+f3KXM4UCzVkJxS6tJClfUqdSLap+deKlC+kjnA0bKI7DiQiuJn+/SWMbXWUEChJeFKPfIj19/M3Pmfa8u4776hQi6em2t9vsaqMhTb0GmqBIzAnvFbxviNUc9qsKKVmZQ8I8qdSLgMUF3p9/zu0J/sZxXvduFzBYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgjJmslu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgjJmslu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC2D1F00A3D;
	Fri,  4 Sep 2026 17:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541265;
	bh=lmyTQrEk9iItBhgUN5arNq8q8hxBJ/DcJrguueYMcac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cgjJmslukMCIalj3tVGBD9djY1BI/q4QeNgWVPemeUXS0enNoWHTCfA2amWThW9md
	 593pdkllprOZnByQ1xPdYH6XYe9Bsd4M5zLgLeOnPAdUn9sfJbQxHj9w1bNSWOPnFw
	 0yF6pXwvEwTSlGiwrR1MTD7ff+YeGM+RJT/x+B3cnmeU4tP3MYi58uHrxPu/d0QgnB
	 AzfrCif9xxn18ORYgKBOVQ74LeB5+LnGdta7FbLXEENkGkF8R6IbsSAijRJ+u680Jb
	 SMehwz2MnV1gCJj9xrZlXO3XWRjE1jeWuiL+wgH7Cz3gdmyM4iR6GQBSU0okWHpsW/
	 XfvbV3eBzr5kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5695E3924A53;
	Fri,  4 Sep 2026 17:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix flaky bpf_nf test when
 random
 NAT port is 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178854120589.442795.9129340051112718540.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 17:00:05 +0000
References: <20260904073745.363314-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260904073745.363314-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 ihor.solodrai@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, chenyy23@mails.tsinghua.edu.cn, puranjay@kernel.org,
 lorenzo@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  4 Sep 2026 15:37:39 +0800 you wrote:
> The bpf_nf test allocs a ct, sets snat and dnat with random addr and
> port via bpf_ct_set_nat_info(), then looks the ct up and checks the
> reply tuple against what was set.
> 
> The port comes from bpf_get_prandom_u32() and can be 0. For
> bpf_ct_set_nat_info(), port 0 means "port not specified", so only the
> addr is mapped and the kernel keeps the original port. The check then
> compares that port with 0 and fails, which shows up as a flaky
> "Test for source natting" failure in CI [1][2].
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: Fix flaky bpf_nf test when random NAT port is 0
    https://git.kernel.org/bpf/bpf/c/5e8c349bc8d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



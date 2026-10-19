Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B6E331ED5;
	Mon, 19 Oct 2026 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375809; cv=none; b=kJEKJONMyo9TWXtzuOclHoFBpxdfJ/rW45UegCp6Vv02vuMGleX8XXnU2ZdxySmT1jTeWekhhDUCokwjuWSFTaRsDTsoKptzV2Wpf5+C6vMEeu1Fd9f16EYPRrcwrWC4nKNb4PIF3spUXknUNyGmhh+Pes1DfapgJqrydbA+ow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375809; c=relaxed/simple;
	bh=KvUMQEWYfdey80/BQJ7+FGg4rV7O8edOwbRu8YMuZcc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MT/gjV2D0CWU2+kNoM5DZ0FL04fIvYNm8cUtD6j9hawtvu8Zt9z3fQpx1g1KbrOGOkNBz/bWuT1PDtIiJZt0qPq0sSN4XMfyYK1BNfSRrYvwiTBbK0f+NensnOAzQ7Umb4pIcmpzvWCGgxRqwsKZ25KEfC8fzV0xGtIDKRXUduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hwv+lZMY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwv+lZMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8661F000C4;
	Mon, 19 Oct 2026 02:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792375807;
	bh=teJIFDDNWP3ITzh4CqU/xscsH17U40oqYbCU+p4WP3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hwv+lZMYVIlNNWm/M5f21J784hFq3u5Andza8s7WiLop/DCID+OgLYV0lJrzC0pfE
	 IAieKVni6JQLYepdsAT5U+Ddhxgr1bf/B7zlaSjpTSdjTIA+GmQugANhptP5RJQ+Vb
	 Ux1YY63ukVv2aVW+nPUcazsqwAueXktWZWho6lSVkGpaATDUU+1hgslAgVOHF5mJV4
	 Cp1EKD5uogqgWtbjGSmn0arKaJhqA/ZpswDuZl02u4jt1n2Vz5LhTn+rkG4G4xWMfz
	 sGVz8ZJMhHwM2bqaUsZqahqcOuzoP/XQ2W0jYFtjAbvhoDGZFVNaM0Z3wn3QJISRo/
	 5naAq91XbON6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B445D38119C2;
	Mon, 19 Oct 2026 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf: Enforce trusted BTF ID argument
 provenance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179237580653.2359447.8270002565749496312.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 02:10:06 +0000
References: 
 <20261007-a3-arg-trusted-v4-v4-0-253ef3a1a69a@mails.tsinghua.edu.cn>
In-Reply-To: 
 <20261007-a3-arg-trusted-v4-v4-0-253ef3a1a69a@mails.tsinghua.edu.cn>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ameryhung@gmail.com, listout@listout.xyz

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 07 Oct 2026 16:25:28 +0000 you wrote:
> A global subprogram parameter tagged __arg_trusted is verified with
> PTR_TRUSTED, but its call-site type check also accepts bare PTR_TO_BTF_ID and
> MEM_RCU registers. This lets a callee use a pointer with weaker provenance
> under the trusted-pointer contract, including passing it to a non-KF_RCU
> kfunc.
> 
> Encode the trusted-pointer requirement in generated kfunc prototypes and
> drive the shared provenance check from the argument contract. A KF_RCU
> kfunc additionally permits MEM_RCU, while a global __arg_trusted argument
> requires a referenced or trusted pointer. Normalize nullability when the
> argument contract permits it.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Enforce trusted BTF ID argument provenance
    https://git.kernel.org/bpf/bpf-next/c/c3a0bfddaee4
  - [bpf-next,v4,2/2] selftests/bpf: Cover trusted BTF ID argument provenance
    https://git.kernel.org/bpf/bpf-next/c/71b6a960c73f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



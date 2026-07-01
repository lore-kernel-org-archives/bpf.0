Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD229D27A
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935430; cv=none; b=Y2l+PyL0UHOfVCkNuk34QERlVM3XISRmgt/icES+ADvhTsToV3+2OtOjbSTG5mYqmHeTw/XtBVgd1I97MCYpMwCqDF2JlfLeNpJdIMyZsBJETYZHaQY7t05JlHKC0kI9YYZqTjfT+osvUoKiL5asmTVH+EtKXvWXhYBD5vjOibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935430; c=relaxed/simple;
	bh=HWmMZFmb2pbH6JZVZxSJi9RmyE8g50/2/jBfXaHBEaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LUsTonizHazyHpxQWHxkLg3mngUhiFsYb9XfWMtYLeO1ErfkFrKYoSRY5DsiXAcX8N0ZiOEy5igSWU36K599cvCpeRASZOgh1rkndrZBIxuanh9pzCja1DScSlgzFptPIRVgGUuBH/QJ/nz0mQ/phA+nGxZ9ZFTtEwDqN0yigEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jtf9jbS4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jtf9jbS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840DC1F000E9;
	Wed,  1 Jul 2026 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935429;
	bh=Aj3H6yE49GEFnv8UGauDjnTY5pgF6dhT4NTwXe7gPmY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Jtf9jbS4ruim3DD5NEoajCY3s8HdmJoiTneC5KQfs7QugcxzB21K3eUAPZY87g50c
	 sLTguvJTQH3Mea6cA2mlaFDt53gh3RhwcyA0R/lom+rZCbYO3yhozaUVFl7rp1t9mN
	 xFIGKv6cqrrV90gKJ4zd6tMQ1Ql99CUKK9ccYCVJIJm3cy8IhiryWf/zGZOB8u6KhP
	 P6QpzelaFRJQfD3ygS7C4cvKoQLNyPLkswFC4Fc1iYYhig6UcYZuQMTuyAgNLr/6pj
	 BzMHL1MdgJONdvqm0kLwdoX8NBBCJythOerPZXgPIf+bWYcP4oxOIIBQrrNyFvwLVp
	 yZGlRBwXISQ2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19892383BA04;
	Wed,  1 Jul 2026 19:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 bpf-next 0/3] bpf: tracing_multi link info support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178293541264.1269008.13935548760043177318.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 19:50:12 +0000
References: <20260629212208.895962-1-jolsa@kernel.org>
In-Reply-To: <20260629212208.895962-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 songliubraving@fb.com, yhs@fb.com, qmo@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 29 Jun 2026 23:22:05 +0200 you wrote:
> hi,
> adding link info support for tracing_multi link.
> 
> Adding the kernel support with related selftests and bpftool support
> to display the tracing_multi link info, the output looks like:
> 
>   # bpftool link
>   ...
>   61: tracing_multi  prog 167
>           attach_type trace_fentry_multi  btf_obj_id 1  count 3
>           btf_id           addr             cookie           func [module]
>           92598            ffffffff825017c4 10               bpf_fentry_test1
>           92600            ffffffff82503814 30               bpf_fentry_test2
>           92601            ffffffff82503824 20               bpf_fentry_test3
>           pids test_progs(1540)
> 
> [...]

Here is the summary with links:
  - [PATCHv4,bpf-next,1/3] bpf: Add tracing_multi link info support
    https://git.kernel.org/bpf/bpf-next/c/859055e07697
  - [PATCHv4,bpf-next,2/3] selftests/bpf: Add tracing_multi link info tests
    https://git.kernel.org/bpf/bpf-next/c/d36e4dd547bb
  - [PATCHv4,bpf-next,3/3] bpftool: Add tracing_multi link info output
    https://git.kernel.org/bpf/bpf-next/c/37c1e353c9fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



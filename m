Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8C51815A
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678425; cv=none; b=Nt1acbJYmpTxXeimEaCIFSKUy1M4WJuCkz/hI4s03DMaMQ3ms19jIiwiyxo7GmuWGP3feOL/Ci36xfQYWcW3Ke7UzkGqTbtywk/hDRVoyIuKONf+RmlofxoB8AYVrqpTEAc87iQp1ClHeyyvDIQrt2ggXwN1LvkSk5GMrXMnZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678425; c=relaxed/simple;
	bh=aNpzJbzOo/GhTPnWkaBvxEhjGt7AsFw3PczUOB1+vGE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SAmbbQI0hXV2U1W+SxNaq/FcYVSmpP/IxBELiouzlse8ZmgtnIbl59lQFNq/Ewk6iNLXXgTpvrosQf2oCK3TtCTjA+VWq3Xgu0Meq11DAlhRNpm08p/uAMMs2rksyicV/3LwmkTk0dnSKahstLj4Hvyp0sIIT5gMlXK//0WhPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGpi/Qml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGpi/Qml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1531F00893;
	Tue, 29 Sep 2026 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790678415;
	bh=6zTGE2AlofmZ4ugXrwoWZ3aZcqnsG66RMimSO66aEa8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mGpi/Qmlm4G5/Ks4MRmNqLEiikPOLPHaTdjYZ5M3mshpPNckdjMeOOYnFRFFP2nVX
	 n9ROOjuWHrq5Ek3/8LqhcTjUx09u7N37J1VjlXILsd8l8UPkxxEvHIcONgA5C1Ud1Y
	 93UrFgiK9nuoIRcCTPI+n1MNxCY4/GyG8Rc9Nygd5uhOlv4qaFl7iw15bSbKjWTDDx
	 8VxTWl3okBiLs9ns17y70XvMdgSuJJtt05IgOkxOkwidkixZi2LRd8VHzuNXB9JTRR
	 VfTvUZNDfztVzGcMeFtxEHtXXI7we26z68lSHW/nVYW6mNmq4TZIN8MxsF1pebWfRS
	 ImYadZ/YkZFng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B442939263B1;
	Tue, 29 Sep 2026 10:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/11] Unify subprog argument checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179067841453.421460.3752055362291528812.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 10:40:14 +0000
References: <20260928185334.1004200-1-ameryhung@gmail.com>
In-Reply-To: <20260928185334.1004200-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 28 Sep 2026 11:53:23 -0700 you wrote:
> Hi,
> 
> Helper and kfunc calls now validate arguments through check_func_args(),
> while subprog calls still duplicate much of the same validation in
> btf_check_func_arg_match(). This makes common argument rules and
> diagnostics easy to change for one call kind without updating the other.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/11] bpf: Fix kfunc BTF parameter lookups after wide arguments
    https://git.kernel.org/bpf/bpf-next/c/d82229330a32
  - [bpf-next,v3,02/11] bpf: Identify subprog calls in argument metadata
    https://git.kernel.org/bpf/bpf-next/c/f7be720383d3
  - [bpf-next,v3,03/11] bpf: Build argument prototypes for subprog calls
    https://git.kernel.org/bpf/bpf-next/c/668a51c4ed4b
  - [bpf-next,v3,04/11] bpf: Check subprog scalar arguments in the common path
    https://git.kernel.org/bpf/bpf-next/c/c40f746cc7de
  - [bpf-next,v3,05/11] bpf: Check global subprog untrusted arguments in the common path
    https://git.kernel.org/bpf/bpf-next/c/3886a9fc38de
  - [bpf-next,v3,06/11] bpf: Check subprog context arguments in the common path
    https://git.kernel.org/bpf/bpf-next/c/03f312c2cbd5
  - [bpf-next,v3,07/11] bpf: Check subprog arena arguments in the common path
    https://git.kernel.org/bpf/bpf-next/c/44cfe492d06f
  - [bpf-next,v3,08/11] bpf: Check subprog dynptr arguments in the common path
    https://git.kernel.org/bpf/bpf-next/c/a1456ec685a6
  - [bpf-next,v3,09/11] bpf: Check global subprog BTF-ID arguments in the common path
    https://git.kernel.org/bpf/bpf-next/c/77d9384a69cd
  - [bpf-next,v3,10/11] bpf: Check global subprog memory arguments in the common path
    https://git.kernel.org/bpf/bpf-next/c/46e074462108
  - [bpf-next,v3,11/11] bpf: Check all subprog arguments in the common path
    https://git.kernel.org/bpf/bpf-next/c/bf82eb018328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



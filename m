Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD97367F37;
	Thu,  5 Mar 2026 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753409; cv=none; b=cXm0RvnYpxVnzyB+PFqtV+F2B5UYW0CQq5TVFWZHKmLBGxc7AT6hc28CsA7WEPh774a7v8z7yjtiAkhRSQt15B/Jk2V7mmx+ZWfl3IlvPGnRQCZsiZcT5fEPb7oN+iDBTsIddgGJr3Hcf6T/PrDVGkvF9vSqGSZpbJIwY/OVrJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753409; c=relaxed/simple;
	bh=5Kc270dFzQjR8Vm6+7T2HWXccxHdjgILIUdO6WaZwYU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A5I5bpSnXATqg9QUWB3f9znCBp4DcJchpJC/Rgq4pnP9lLYeETT/XGCALSLDTe6B5bLAv6UwlDyklhFoJbwWYVLwUE9aLcxMVziYjM0ov9FLYtyA0LuOjokOxOPId3j0/NwVruOC4rYHZWKx9FBv/hDdJj3+38V+J5EwtqEF2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNGzaTX0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNGzaTX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8E7C116C6;
	Thu,  5 Mar 2026 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753408;
	bh=5Kc270dFzQjR8Vm6+7T2HWXccxHdjgILIUdO6WaZwYU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dNGzaTX0v5iOpOlwKPkM+8oECnSbesuoaA89DWsjNOZ6udpDHCLAP3uXm2hclyW8/
	 3HdbhGDjJOrQe4sglWNPJWSvInrQmzZUxBZDFdD4Kg3M5l5WDq7FfP5IlqGXc0P/RN
	 fqmF0l7AqPhVa60PFVq97lmz3h9J/WtQRMm5ejsiMsRSLrxbhsP7HB/vHeE25ZHMI8
	 sFXS2z4H8AQ4G+buseoRZl7l25/CB4XmeIH1/h9LA5Ux9B9vnVaOz6SLX6hCXeqJCp
	 A/0K5OcoP5X0TXif7zlLKNiQ4W8Ga31Cp6AVF7f4grdF2FZk0L/Hz+EzjroI5ks2I6
	 gM+WdS7oXLIow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0093808200;
	Thu,  5 Mar 2026 23:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] Optimize kprobe.session attachment for
 exact
 function names
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177275340855.3325345.9824882028753278157.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 23:30:08 +0000
References: <20260302200837.317907-1-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260302200837.317907-1-andrey.grodzovsky@crowdstrike.com>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org,
 rostedt@goodmis.org, linux-open-source@crowdstrike.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 2 Mar 2026 15:08:34 -0500 you wrote:
> When libbpf attaches kprobe.session programs with exact function names
> (the common case: SEC("kprobe.session/vfs_read")), the current code path
> has two independent performance bottlenecks:
> 
> 1. Userspace (libbpf): attach_kprobe_session() always parses
> /proc/kallsyms to resolve function names, even when the name is exact
> (no wildcards).  This takes ~150ms per function.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] libbpf: Optimize kprobe.session attachment for exact function names
    https://git.kernel.org/bpf/bpf-next/c/6afc431db1b4
  - [bpf-next,v4,2/3] ftrace: Use kallsyms binary search for single-symbol lookup
    (no matching commit)
  - [bpf-next,v4,3/3] selftests/bpf: add tests for kprobe.session optimization
    https://git.kernel.org/bpf/bpf-next/c/a28441dd2961

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



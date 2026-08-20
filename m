Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7A387363;
	Thu, 20 Aug 2026 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251861; cv=none; b=M7PS/Wl7AqYyrzH9vMDHc6hmPS5cOL303ZkGOvJ0h6txPqTC2A3yVMZqWfTQhZdH+VTyYboCUqF2aFKlnIxPUx/+yeZAUq5RGdqRcxw40EaOXTc2GfR/Cdx8nXIaaxkpcG9jTVqTpbVrOO19hSQ8kri9Jomx6WIOnpYwFC6ol+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251861; c=relaxed/simple;
	bh=bVrzwnEvUgGGVO7ADm7jjcgKzKwMCmvtplGBL6MR14o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tN6W6j7G2qICpJIJbH03LV87GAaNw2VeXUbYl9lQboUhPBTt7BVttWoFswH1/rU04Ft6pgeYdQV0Ils2EWRshHExa9ifEEA5RF1dX8Ux+ntYynHJUEPLSViDsT6oOiCct0zfwWrKJVHMj+5DGRrT+g8Co5esx68uAwhryiR8y74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdJCVpdV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdJCVpdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D08F1F000E9;
	Thu, 20 Aug 2026 18:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787251857;
	bh=DXRVjrx/ulv1em1SI8SvcPY5rNy+msFfXTDuwrN3ZZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YdJCVpdVY/wWSTrqrMZEmJiHJQYOohnJbwkKJz2iaHZmxpMCvCqCOPQj1OGS9N8Zg
	 odkluF+6+r2YEjbjc9QxwwyisT4A7BDSrAFOp0QYv0u+j6foiOMZRRsLL69mk1kUP9
	 /T9k7KUsni54ux/9vQ4OSbzt4Z4Yvg32qkDZi+yx/I/rRYmyWsC9yz5ZGlznsyPOk+
	 kLdMCV2wF+MxTMdne62PP3Sb2dtggOThEWrtDWPjYAGZN7D9lhMPRstZ+QodEaQRkj
	 DY9IXDFwDYyIW7kuDOE8bhFMqb79glRejmzwqibhjRuDqcC9JOZhTaqOaIrDVHvZFx
	 haLe45YLeKsIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09823822D60;
	Thu, 20 Aug 2026 18:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: fix REG INVARIANTS VIOLATION on speculative
 pointer arithmetic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725180773.429815.9253874260271382081.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 18:50:07 +0000
References: <20260819125840.286434-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260819125840.286434-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, clhiker365@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, paul.chaignon@gmail.com,
 ameryhung@gmail.com, shung-hsi.yu@suse.com, kafai.wan@linux.dev,
 danjwade95@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 19 Aug 2026 20:58:29 +0800 you wrote:
> Take the following unprivileged program as an example:
> 
> 	r0 = bpf_map_lookup_elem(...)	/* PTR_TO_MAP_VALUE, offset 0 */
> 	...
> 	14: r0 += r1			/* r1 is a bounded scalar */
> 	15: r9 = r0
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: fix REG INVARIANTS VIOLATION on speculative pointer arithmetic
    (no matching commit)
  - [bpf,2/2] selftests/bpf: Add reg-invariants test for speculative pointer arithmetic
    https://git.kernel.org/bpf/bpf/c/7ee2f20bf20e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998501862
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169223; cv=none; b=lWrlaB8EJZJiIIr/wNfCKCLM7UD+tv/xlwaNLeaQYEJ1bjY9dKTK5d7IdQI50x3aMv/8SaEdxzdkE++WBZDU4HiPWjXvqNw4NCCHzAL5Q2zBcbKHwWE9K2E7vYXiHfd9icxrtIzK67j8axLnFZ2/YWOutlWmr7tBEy7CtfnAD8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169223; c=relaxed/simple;
	bh=KziuRRWwZ/ksvqZfdCyYPdWCbDu3VwR4Wutf26sRwUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=azt8u/4Fqo3u/zpANW8CwFMkery4VCjkNvPAXShYoF7gU47eZMfwOAESsu54GureE96w9HY5Fr4cRUwRu+4AiTUPCXNOdGsUPg134bBKJ33n6X5T3ccFA1PZEZGTph+h0OZrk739BADu+a7+WnnbYiBcVKVowFT9BXcmaZs6dz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+psodxT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+psodxT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1B1C19423;
	Tue, 10 Mar 2026 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773169223;
	bh=KziuRRWwZ/ksvqZfdCyYPdWCbDu3VwR4Wutf26sRwUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W+psodxTJStH19OKkZYAVEZAPtDgw3CvLCjz4yRZmGKBWWk6DlodXEimrgJM+4GF1
	 7g13qT//2jp4rXE6WpgRNYDth+5Cg6/GSchaL9DojotZ4tVaqaHkhgbaE3CfYj6a9A
	 y6389QAAJcy/q/tMNobyKoxdyntZaeXzJcBNreZukOVlmOtBZOw8crakSqJSVvbGcq
	 TYCgHrdyyMQbnvAN7UjaNhq3xqgdAfz6sItoeCemhaHZ5SR6WP5Lph0zz5fkBolemk
	 1xrTyiyhcSgAraSWwTMunHFgBgiILX49GTu1WSwvlz322Zrr4crr39oq0PdpcOmfjk
	 nJNi5H5FGKvhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E613808200;
	Tue, 10 Mar 2026 19:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] bpf: support for non_null ptr detection with
 JEQ/JNE
 with register operand
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177316921979.2465788.14303668038451646510.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 19:00:19 +0000
References: <20260304195018.181396-1-cupertino.miranda@oracle.com>
In-Reply-To: <20260304195018.181396-1-cupertino.miranda@oracle.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  4 Mar 2026 19:50:15 +0000 you wrote:
> Hi everyone,
> 
> Apologies for last version.
> I have no idea how I added the spurious log file. :(
> 
> Cheers,
> Cupertino
> 
> [...]

Here is the summary with links:
  - [v4,1/2] bpf: detect non null pointer with register operand in JEQ/JNE.
    https://git.kernel.org/bpf/bpf-next/c/2f4cb53eed44
  - [v4,2/2] selftests/bpf: tests to non_null ptr detection using register operand in JEQ/JNE
    https://git.kernel.org/bpf/bpf-next/c/6a1c9a442f63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21078379EFC
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786079459; cv=none; b=gPg7FDLF/7Y/zZS3nQndpYtkteZmxC9GewrSEd6jA9pv8WLkyA2tpZJV4Q/EdxJl6ShG1yELH1KmlVEbcNC20AkSfdWJx1mUezMkt0Xez7HulpkTlihfHkShqHa/bB7HT1O2W8uB1IFFxR+xBZVM5+VtckdIVKT4VYnKTSUwtic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786079459; c=relaxed/simple;
	bh=ZypqmWmwdQt2sgt3w+PIVe8f6tIQE+K5wHOD0Na1b+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KxayQ8pS4GtoCrdnpoixO6539GRmbDyjuxsc6uX2pHAU6f6qYdVWTG2pzsjexRK1MnZGkarxOlPucluVxXqt+86TIC+ZSHEwFZeeCfCn4yc992TLVgbbJYZmo6SYmCzpYF7lgnFaID8JORjZw8DIZXB8nhAucR7/0k+J16+JAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1x1tQO8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1x1tQO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93DE1F000E9;
	Fri,  7 Aug 2026 05:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786079456;
	bh=c+faH2jz658Qrn1aFNB1MuhqDHIvLqtthuClRo2VG8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n1x1tQO82srkKkiSjMZBvJS/T8fKb3RdUna1zrkzBA898/ZIB9fBDmq9sf3yjC6ZV
	 DWbOjwY8x18VsOvw704XvtXf0bp5KgWkNsB8g8dRDDbof5GDK51DR0FethGG6rpOop
	 VVuQl+3BQNKquTMxewAWbFJVuWTXT9TA1UXi8c8MV80jFQFEI8zZsHJgOXK9EEfTsj
	 4D1RKBV8xBhuMzdxCQCtSj3AYsN9dfCHM06tTRtjeAMAHL1a6pAkjRv8cePbDjYLIm
	 DT2egaaECirIr+Y7VVqAMRE4DYMkp95yT0QAwDbJooVMI3hIBs6khRJWepPDgSwgt4
	 SXlS/4aYywzjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19994380A95E;
	Fri,  7 Aug 2026 05:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/6] resolve_btfids: Implement BTF tags
 emission
 for kfuncs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178607941464.1610510.8127033300425733213.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 05:10:14 +0000
References: <20260807032029.78092-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260807032029.78092-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, alan.maguire@oracle.com,
 jolsa@kernel.org, emil@etsalapatis.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Thu,  6 Aug 2026 20:20:23 -0700 you wrote:
> BTF data for the kernel is generated through the following pipeline:
>   * DWARF is emitted by the compiler
>   * pahole reads in DWARF and produces BTF
>   * resolve_btfids makes kernel-specific btf2btf transformation and
>     patches .BTF_ids section
> 
> This is orchestrated by link-vmlinux.sh, gen-btf.sh and Makefile.btf
> in ./scripts directory.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/6] resolve_btfids: Deduplicate BTF after btf2btf transformations
    https://git.kernel.org/bpf/bpf-next/c/3d72aca40b83
  - [bpf-next,v3,2/6] resolve_btfids: Process KF_ARENA_* flags in resolve_btfids
    https://git.kernel.org/bpf/bpf-next/c/27a78c2e7eee
  - [bpf-next,v3,3/6] selftests/bpf: Verify arena type tags in resolve_btfids test
    https://git.kernel.org/bpf/bpf-next/c/ef77140f4b3a
  - [bpf-next,v3,4/6] resolve_btfids: Emit bpf_kfunc and bpf_fastcall decl tags
    https://git.kernel.org/bpf/bpf-next/c/692393104909
  - [bpf-next,v3,5/6] selftests/bpf: Verify decl tags emission in resolve_btfids test
    https://git.kernel.org/bpf/bpf-next/c/9f3881ecad88
  - [bpf-next,v3,6/6] docs, resolve_btfids: Document kfunc BTF annotation emission
    https://git.kernel.org/bpf/bpf-next/c/fd5425b67355

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



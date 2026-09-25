Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA6C2931DE
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357485; cv=none; b=Nd9T1vULUcazvFuiKGfKBByR10EwPV2Vm0Ji6EmSgN3+EAdW1liLzOaVQj6af4u86MtL9s3em/O8JLs2fJ2IgHA2/vvJqyazm+SE8MfZVDU3jUqkYUK03E1I07RpTNLgM85pxkMpeQySH9eiK9XpDm65xGlXTPSchlXwhKnVBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357485; c=relaxed/simple;
	bh=8DbPAcN3S9cYOxO+OCdaxlzqKFHNMbSCYdnUAz7UqE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PTwscg+HCAegb3SySaZ91kplD+KCo4Z184COqKGYdfLd6SUckzs1FO4jSnRE/CGe+ReEPtR4Q7VEhTV8+utVlYQfwUXO599I9FBs7u6O1JCcIuNUxLhZy+jc3kbg376dCIYgf41HxEjHjBGT6tvqelZzThOx/egu2nDczM+l9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEV/lM5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEV/lM5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F3B1F000FF;
	Fri, 25 Sep 2026 17:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790357484;
	bh=qKwwc4G4EWJcE8NmGzf1Jc6rqgv7T017pQlYqkMd//4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XEV/lM5u5Vv45o0oRqOdZJI9ZnzynrNFuPJYkfbZwK64WT27kCHKgkXYuI+H05+iv
	 XyAcSRI2kFaiW/fj/FYO0Lz0g9V98poA0hyh/AtZXC4s3OsWDlzvipBblkv1ztopfT
	 WvdFjCbyBehc79Yt/w7nxz6EkPGGOJeVDd0Ccjpwzt08hYkyxTVxVMlEvzZ3LwrNfJ
	 TBpbM9D6rTYswaNq+nB3XYwqy1wCVN//U1fo8/xsDUHDRobZJGrKt5phP9lgTeTaES
	 OjGXBMtORbtqFvi5lSGJMzijUDAlcbxns5LtLEUomUL9FoxVEpm8L3cS5APpHmMCqW
	 1Z/dfIDWPfmHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568C1380820D;
	Fri, 25 Sep 2026 17:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Hold map BTF for the memory allocator destructor
 record
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179035741215.3062647.1669325075936587788.git-patchwork-notify@kernel.org>
Date: Fri, 25 Sep 2026 17:30:12 +0000
References: <20260925064652.2261885-1-memxor@gmail.com>
In-Reply-To: <20260925064652.2261885-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, chenyuan@kylinos.cn, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 emil@etsalapatis.com, kkd@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 25 Sep 2026 08:46:51 +0200 you wrote:
> bpf_ma_set_dtor() duplicates map->record so that the bpf_mem_alloc
> destructor can release the special fields of hash and rhash map elements
> once the allocator frees them for good. btf_record_dup() only acquires
> references on kernel and module BTF. Fields whose types live in the map
> BTF keep pointing into it: a kptr to a local type refers to map->btf,
> and a list_head or rb_root field carries a value_rec owned by the struct
> meta table of map->btf.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Hold map BTF for the memory allocator destructor record
    https://git.kernel.org/bpf/bpf/c/ab39974240a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



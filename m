Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEC31E858
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791037215; cv=none; b=j6SRHcJDsOg0zrhUPIhfHOfkkjxeCfguYVfLjSVUfDyPHvuntTrTOLmsPY+z6IKg9v3mHOJ2CJERMO3nc5akS5UoZHY1FaqYdm1ZK7QlVcUYVY0Sqd3AnDUmFlwT1PPG8P4PwWqo+DOu3z9qAp8Zrbg+gmS6Vlpo8YKIUMGlO3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791037215; c=relaxed/simple;
	bh=nTbhO5VU+QJmKS06zEbRKYgODjhCpFWR+jBP47UM7Ak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gDmP4wu39vqJqiIyCL37MZ2/KWiKxsTeYaWk7fMDskIl+OTvkMjItZGIdFo3FvjLMzYIPHCUK03JTlCS7zw41FVyVeby7ePKaau5o214XRw5ItUHp9zHakJuKaHYyjM0h3UwXO0E/spsAtn0EFf+YQt0ro0YBfQJEilbe1vwMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1bJFRNu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1bJFRNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424061F0089B;
	Sat,  3 Oct 2026 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791037210;
	bh=oaVszFqYxTIk13EaN6X03ygJiND+VrdkvcE+65hTTy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G1bJFRNu6oq3g8eaGWg77ayCTRtnXki65z7W8LpR/umFaK6J+V8lB7X9UOO1OctOr
	 3k98qrA7JVsIn6Gu2SCWceqfVPRna+bRPy/bZYmeSkvlHFaCBHe52xi/JAZixIkVhR
	 Mrvt2KxIvZgjlAKbN0Lo8raP+Goroqxj59rKclAJ0sBf7ss/UXtT+Ek0Oprrq2Fkgb
	 /UyNj+hWZNw4txoLNR3UCa4KYBJn2rsSVGdrqXQDRaIMyxVOIqE3m46Qqnxbr33n57
	 lW5DjbXaXmK7SQilIdVw637iJ02ZzlOrkW3xiWR6ybzcOEd48wwK/ugRXbNhFLX6Cf
	 FsXTEO25bsgJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A282392446B;
	Sat,  3 Oct 2026 14:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/15] bpf: Support programs compiled by
 rust-bpf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179103720903.94766.5280727089659165315.git-patchwork-notify@kernel.org>
Date: Sat, 03 Oct 2026 14:20:09 +0000
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Fri,  2 Oct 2026 12:46:59 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Rust programs compiled by rust-bpf keep all memory in arena and access
> it through plain numbers, since there are no address spaces in Rust.
> core tags pointers in the low bit. BTF of such program has names like
> 'Option<alloc::collections::btree::map::BTreeMap<u32, u32>>'.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/15] bpf: Allow bitwise ops, shifts and mul/div on pointers with CAP_PERFMON
    https://git.kernel.org/bpf/bpf-next/c/72c0681c0e75
  - [bpf-next,v2,02/15] selftests/bpf: Add tests for ALU on pointers with CAP_PERFMON
    https://git.kernel.org/bpf/bpf-next/c/7ba7c5b3989e
  - [bpf-next,v2,03/15] bpf: Treat load and store through a number as arena access
    https://git.kernel.org/bpf/bpf-next/c/4c651a91bdfc
  - [bpf-next,v2,04/15] selftests/bpf: Add tests for arena access through numbers
    https://git.kernel.org/bpf/bpf-next/c/b233f937b98f
  - [bpf-next,v2,05/15] bpf: Allow names of Rust types and functions in BTF
    https://git.kernel.org/bpf/bpf-next/c/bed1986a1932
  - [bpf-next,v2,06/15] selftests/bpf: Add tests for names of Rust types and functions in BTF
    https://git.kernel.org/bpf/bpf-next/c/711d8a75c507
  - [bpf-next,v2,07/15] bpf: Allow arguments without names in static functions in BTF
    https://git.kernel.org/bpf/bpf-next/c/8e1b3e0945a6
  - [bpf-next,v2,08/15] selftests/bpf: Add test for arguments without names in static functions
    https://git.kernel.org/bpf/bpf-next/c/3dc3a91ec9c7
  - [bpf-next,v2,09/15] bpf: Allow a variable in DATASEC that is smaller than its type
    https://git.kernel.org/bpf/bpf-next/c/9094a158e842
  - [bpf-next,v2,10/15] bpftool: Skip pieces of variables in DATASEC
    https://git.kernel.org/bpf/bpf-next/c/124a5a2bc0e2
  - [bpf-next,v2,11/15] selftests/bpf: Add tests for a variable that is smaller than its type
    https://git.kernel.org/bpf/bpf-next/c/87be058a3b6d
  - [bpf-next,v2,12/15] libbpf: Keep global data in arena when the object has .arena.data
    https://git.kernel.org/bpf/bpf-next/c/8ab58ed42b08
  - [bpf-next,v2,13/15] libbpf: Keep format strings of bpf_printk() in .rodata.str
    https://git.kernel.org/bpf/bpf-next/c/373e1223ff00
  - [bpf-next,v2,14/15] selftests/bpf: Add test for global data in arena
    https://git.kernel.org/bpf/bpf-next/c/27e24617a83b
  - [bpf-next,v2,15/15] selftests/bpf: Add test for global data of a program in Rust
    https://git.kernel.org/bpf/bpf-next/c/e86cb7315451

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



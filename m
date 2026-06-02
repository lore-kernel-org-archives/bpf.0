Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0EA3803F2
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419010; cv=none; b=vGKqEIMKtzKU5VduXocvYPBgfiNfK95m/9u0aZ8wAZ/xZdvNFI1Goz0rcOoB9SzMBvc3iE1yNyMfcPrl7jSDLhF881f6SzEGHQAJ7dOZJQsM94MwwRIZExoAHkE8+3x+hx7TjZCTueW5z47lieH4ioFTEBQ5skUlur375Jn1sms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419010; c=relaxed/simple;
	bh=9TXQOlVLXRkAsVEMALAiTWicQb+TP6+OFi2lqMp/EEg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C7zX1Q8afpzw4iVrleYqs6ZM7EqwhLaOI2ABISv/05xR65CvgBJ/uVTQzAo5fbm2ki2QJ7SdbawFeML01Y2rTsLFCgkxHdfwdlndHcRZM/LRJUzfQr1R/71x0PvWWgA2mK/q7GcHEv3OKNcaDelNc0m3H2vr3QsTu5aEydq4RNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxwcnt+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxwcnt+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1221F00893;
	Tue,  2 Jun 2026 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780419009;
	bh=+4bWChj5PCBcqfW6IgzhmZYeDH6P5TZcnZK5YLmiIR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dxwcnt+m6KK/qPBEIBd092lvOKQrxBbp5qC/LuJSQ6b7d1HHnzpVmnQvqfMrcKJ8Q
	 l5yoXRlkioNF34/1wTd8yKshKhdEw51iu1QxTpay1itkSjQ5FBf36y6Qndu3NZX+S1
	 tmBt7WrrDvYw6J4dQaU8oU9+Z6/ruqDPvNwHuuE9THPgbzoDmzSBAU/qge0x4ZoK/p
	 9urhRs1YvIxRm+5KDmcaNxpfzsQeuVtx3BUeGh9fDrlEjuLFHdXukr3rrEBU8vPG3h
	 NOieLgxk6f10F5NpPHgSlvzIKZatiQXaeFk4MMV7H/ac7JpHJJQSVNixEPqknxIdc7
	 Uun0lpTDDE5/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A83811A61;
	Tue,  2 Jun 2026 16:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/4] More gen_loader fixes #2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178041901139.525612.7415193249618658369.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 16:50:11 +0000
References: <20260602133052.423725-1-daniel@iogearbox.net>
In-Reply-To: <20260602133052.423725-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org, kpsingh@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  2 Jun 2026 15:30:48 +0200 you wrote:
> Another small follow-up from the sashiko findings about signed loaders.
> In particular, closing the gap to reject exclusive maps in iterators.
> 
> Daniel Borkmann (4):
>   bpf: Reject exclusive maps for bpf_map_elem iterators
>   libbpf: Guard add_data() against size overflow
>   selftests/bpf: Keep verifier_map_ptr exercising ops pointer access
>   selftests/bpf: Test that exclusive maps are rejected as iter targets
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] bpf: Reject exclusive maps for bpf_map_elem iterators
    https://git.kernel.org/bpf/bpf-next/c/3c56ee343f94
  - [bpf-next,2/4] libbpf: Guard add_data() against size overflow
    https://git.kernel.org/bpf/bpf-next/c/7fef1796ec4d
  - [bpf-next,3/4] selftests/bpf: Keep verifier_map_ptr exercising ops pointer access
    https://git.kernel.org/bpf/bpf-next/c/082c41209771
  - [bpf-next,4/4] selftests/bpf: Test that exclusive maps are rejected as iter targets
    https://git.kernel.org/bpf/bpf-next/c/8dedd34122d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



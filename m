Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00B282F13
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762048; cv=none; b=KN4E5xMkW4aRPtRJkYw9kmiHro3sDN+jf7BkI9Wkj+Z42hg+zm68IoQY+X1Q1VMcLM17B22BMkjuoNd5lImENCiS4JLmoLGOYJCvO/SBtIAsCJjJQn9XXJMX7ekx/9k/hzvLs3cehrSnwXWlghkq0NBjbUmfqD+DlDrY3NQ0n90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762048; c=relaxed/simple;
	bh=AikK8zs+cAp6iMMq6+e2LDXco5L+sxftX4Yakoiycms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kqTp7F0/qa2X/1XnAejfWtRx3PmqjcqYSh00EnaTD/SeAaOdLmub1YM7AJZiX25L6vg+H6ZtBUMUId2HRtethNkBOFdFvMIzIAWBtR9komAuDN7xXTkPUOjomuv0ytEii3yx9DU2Lcveyk6Bj7dJXFzJWO63XnyKgts4gxdT0hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAkqLux/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAkqLux/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ACD1F000E9;
	Mon,  3 Aug 2026 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785762043;
	bh=N6zav2rtr1skpPWNtD6p7w06ioconZTb9KNlcba14YY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XAkqLux/CJjdZGUibpxdFObhZvFo6l9cWaiMrTQu9uahra3olTFVaN5Q3gviF9C4M
	 eSMeKvj149JV6TUimrEZ2o29Dmd7c/HuSm+By4l1mOb4GjwndtPEtcUt+ru5lKjlfm
	 EddDkYCCqWJvZy40usKrS2fvncVidNYzXyRG5Svk+F3VOgeP6+ud/9mwOIY9nck3Fx
	 3amq/oTsz+MhF9iW+gyzYi5PVwGJvlauPsPU5MtOsWS2h5XBGXn0oSfnofA4ZBkBrn
	 h7TPx9fhipTojQcZ+qpKV8Ne7V4aa3FRiOknISIcgDxo8o26JY7GvIClL5nrUl0TCa
	 tZkBfLK+mQnnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5697F380A959;
	Mon,  3 Aug 2026 13:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove unused BTF_FMODEL_STRUCT_ARG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178576200488.2195894.4705000603722370421.git-patchwork-notify@kernel.org>
Date: Mon, 03 Aug 2026 13:00:04 +0000
References: <20260803052726.2821447-1-yonghong.song@linux.dev>
In-Reply-To: <20260803052726.2821447-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun,  2 Aug 2026 22:27:26 -0700 you wrote:
> Commit 814cba835ef6 ("bpf, x86: Fix trampoline stack size for 128-bit
> arguments") changed the x86 trampoline to compute the number of
> registers from arg_size for every argument, which removed the last user
> of BTF_FMODEL_STRUCT_ARG. No other architecture or verifier code looks
> at the flag, so remove the macro and the code in __get_type_fmodel_flags()
> which sets it.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Remove unused BTF_FMODEL_STRUCT_ARG
    https://git.kernel.org/bpf/bpf-next/c/457d4ecb47aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309E81AA8
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201807; cv=none; b=f2XhvuuZxrP/KzvCmTxJIWViajejsHC1cpGJjY6M6aSnTfSD/iBsdSI+nNcBAmx6Kl3KhVgkig5msv5UhriF6KrsoeEV5XIDsK2SC4j1h9+bfXy1Upv+V4MdEjJ6GGUU6DKkVaikmPp7TGfGrtNboJVgy4lMsG7YpRXbHOxOJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201807; c=relaxed/simple;
	bh=FUGmW731kH9LrO4teRcIliUpUMybLQ2y3px6zNZcph0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UnM4n2o6/x0dkW70oMtmhu75cy8EePEzcewO9QXx3yHIpV35lCr65UzjCnb3TySg2DIYU0V+RqnPP46D1kMx+1Zkmpm37LGPeXgpTSu19UqqWkkLlZIg1Y98sMAO7+ETqiAHUkkLc8YiYwIWztDSyiPZZ4Ayg90GWT/XPr++a4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoUb+9JH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoUb+9JH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBB81F000C4;
	Sat, 17 Oct 2026 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201805;
	bh=Sv21T4myvYFtjWKJVEx4SAhTxTZeNcGI3bcSBXMUsU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZoUb+9JHfwaYDlAdrkAZTYUbVeTsEsnOc4DlvBySDcSkR0BUPD/biL+LQx6rImRVp
	 ucpfggoSQEqIWpA7eB0fPf7jGYmJk2dDf0LAH7h4mElzPMiApQPf8cjrXaoKmS2iFg
	 pfgreTcUBpPUjY/eFFTKbqPqSQJF1phqTu8FqpL0f6e5Mv+TAImUl+Bzjx5SaN6BUH
	 BnOpKGrcUSe2DBnmhW8D+XEsD06b3nzniPo3iFFPUnBpj0uoiqpB+rTYtDagrweT0Y
	 mnecG/y1Ql8znps4gS+mgCPKHoRSdPLQI5v3zJA9Cs3K32rY2/45MNGbBiwlShKEOR
	 E1GKDuufOz5wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B442B380CEDA;
	Sat, 17 Oct 2026 01:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Don't echo user-supplied map info fields
 back to userspace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179220180452.1055958.11274248760332929964.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 01:50:04 +0000
References: <20261016191635.662690-1-daniel@iogearbox.net>
In-Reply-To: <20261016191635.662690-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org, qmo@kernel.org,
 hi@tychen.cc, kpsingh@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 16 Oct 2026 21:16:35 +0200 you wrote:
> Commit ea2e6467ac36 ("bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD")
> started copying struct bpf_map_info in from userspace in order to read
> the new hash and hash_size input fields. Before that, the kernel ignored
> the contents of the user buffer and returned a zeroed structure with only
> the output fields filled in.
> 
> Some output fields are only set for certain maps: btf_id, btf_key_type_id
> and btf_value_type_id when the map has BTF (and btf_vmlinux_id for
> struct_ops maps, ifindex, netns_dev and netns_ino when the map is
> offloaded). For all other maps, these fields now return whatever
> userspace passed in before.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Don't echo user-supplied map info fields back to userspace
    https://git.kernel.org/bpf/bpf-next/c/458575e1f2dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158E3E2ABC;
	Fri, 26 Jun 2026 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476885; cv=none; b=mlIEu+RBbIU6EMFVgR6Y17giHvxwrl/wgp9Uw6Z8GPcbbnYLDIpmKWNShV1UqJShQZ7j8X7o4YmT6SEx+2tcc0GA+djVPzVTGuKULZiRl4r8b3KwwcIpPdXTofj7skM14ePN/I7JnS0xKwBtEAlLOszyQ2Kbk2d4+hsoqK1WHfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476885; c=relaxed/simple;
	bh=qeJ0JmGdObWqopU6FbkQamavF5fNAVFJ+YgvA0XXLM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H1RUyTYYagdykS8Oc6psuS8ihfKLv6PX5bY50VJkDJkYiPqYMo7BY8QRhxIZT31shAGzt/aGYZFZmIW/LWKHWg3J7XtnjiI7BeK5g1c5K1maL+ovye+satA9FGiI+ogOTVALTrzgLY3JPPHF51qJvxoGZqaG6vQbkH7TJtlTLqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMdyn5Hs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMdyn5Hs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3FE1F000E9;
	Fri, 26 Jun 2026 12:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782476884;
	bh=dybHT29f8eGTZHQp51+uMkthLGSPPlcmD3PS4dmDqmY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nMdyn5HsaP8epbzNIEiOOwUq7afku+iUyQOg4HpXwoLfMANMTidjr6E8g22hQan9B
	 BLTdhyK9f6kzQwUi8PxCTTm3RJ4pxb+8xO6b/cWQX5yud21qiNhrSJWkmlWDz6y2xs
	 5uwjhR7jazvNlIGfGV//QyG/2DapdxoLUuwmD9YlYwsIhQTAggx8R0noYiqHGmOsLH
	 zCbwyp0IsYoaGV92fY9RsyvaRvqpQCBgBMqpLrpCOnSAG/PExuJEi6Ei8qtfYMDKY2
	 vFq8ZjxsQqryJayv6iu8TwEy7OQVYlV6cMjdKZD6zFxaNkfsFPRt2CW1wId+qQjXUS
	 e4cpdqpRpXr0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BED39389F8;
	Fri, 26 Jun 2026 12:27:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Mask pseudo pointer values in
 verifier logs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178247687102.457674.3393626775693705323.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 12:27:51 +0000
References: 
 <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-0-a190ebb8f3e2@mails.tsinghua.edu.cn>
In-Reply-To: 
 <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-0-a190ebb8f3e2@mails.tsinghua.edu.cn>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 haoluo@google.com, shuah@kernel.org, andriin@fb.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Jun 2026 18:43:37 +0800 you wrote:
> Verifier log printing already hides ldimm64 immediates for map FD and
> map value pseudo sources when pointer leaks are not allowed. The same
> print path also sees rewritten immediates for BPF_PSEUDO_MAP_IDX,
> BPF_PSEUDO_MAP_IDX_VALUE, and BPF_PSEUDO_BTF_ID, but those sources were
> not included in the pointer classification.
> 
> Extend the existing masking so all pointer-producing ldimm64 pseudo
> sources print as 0x0 when allow_ptr_leaks is false.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Mask pseudo pointer values in verifier logs
    https://git.kernel.org/bpf/bpf/c/72a85e9464a5
  - [bpf-next,v2,2/2] selftests/bpf: Cover pseudo-BTF ksym log masking
    https://git.kernel.org/bpf/bpf/c/8a870967ca61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



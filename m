Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6BF4EE86E;
	Thu,  3 Sep 2026 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453674; cv=none; b=jfjXQahrMh4/CvkaRytYsy3Y07xG5+CfaU+GxXVFxf5SCighquLXI09uP1+kA2XDK1ax/GcgoV0ORiI0c4whdZaqg981YgK2BdxieuDWzRqiKX/p5TaqXjsfyjq4MtXf1AGsOFmmx53MHIujbzIOOhyZ7Vhq230BYZSA19u27zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453674; c=relaxed/simple;
	bh=0TrWRDrm6JwpPlWIG5sRWS2knMRYk455Zy02Hjx2ORw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iJwPSuSnj49S3Bg5epn7eCqFEAgu7+48/YeGG3eoEbF8F1mn31VNDEeIeHy5d2lABzdy5BSkIn2tUOAwuSfJieWH3rk369pzxpGQNaYilNECYA46dr3KqHq6Qm2R4bTUgFM/dUazivJhdhRVw6fEzQm2WoxOH5er1952cxEkM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ6qxku5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ6qxku5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9AA1F000E9;
	Thu,  3 Sep 2026 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788453673;
	bh=bYMereBBVRYbKmRkp6818ddKUJlhuQ9kkdUx1VhdiU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QJ6qxku5tNLi45KttZSC4CEBdUUPoohRamL/XAzQ+907nxIhKw9EAKwgV9x21oLbq
	 8ZUdf6Q/SQPZewiraAVunOLUeuf6gBuhKFaoHaL6nEWmFGqZCj57Xh8aGxGIBnHGn7
	 PFjwSeCo/3P1p316/VG17yJ1UrQTijSci4ouMpMgG6UHbchfcSs31fukqPuauaPDhn
	 hyyAclQovMcOImvcA/nzvQG1gUoVn+lt6dKL3A8IYEZ5mDycYVqFIcu/5ewxCxDAPO
	 lIBTTeUQYUQ3Lzp4nUWhZucjadWSx535szs8ZryhUDh2uRZIxfamqWrzCQ6l3ZYlhZ
	 dZLtqF2X4m/Cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A9638119D1;
	Thu,  3 Sep 2026 16:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/5] bpf: Fix NULL-ptr-derefs when showing a void
 BTF
 type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178845361464.3438810.12687597306930362552.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 16:40:14 +0000
References: <20260901104924.346187-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260901104924.346187-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 yatsenko@meta.com, alan.maguire@oracle.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  1 Sep 2026 18:47:34 +0800 you wrote:
> This series fixes three NULL-ptr-derefs in BTF handling.
> 
> Patch 1 handles the syzbot report. A key-less BTF (btf_key_type_id == 0) used
> to be rejected for hash maps, until htab and rhtab gained a ->map_check_btf
> (to register a dtor) that does not look at the key, so a key-less hash map is
> now accepted. Dumping it through bpffs feeds the key type_id 0 into
> btf_type_seq_show() and NULL-derefs in btf_type_show(). Reject it again.
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/5] bpf: Reject key-less BTF for hash maps
    https://git.kernel.org/bpf/bpf/c/0895a0c07347
  - [bpf,v4,2/5] bpf: Fix NULL-ptr-deref when showing a void BTF type
    https://git.kernel.org/bpf/bpf/c/4ea508b9ebd7
  - [bpf,v4,3/5] bpf: Fix NULL-ptr-deref in btf_var_show()
    https://git.kernel.org/bpf/bpf/c/5403a383f52f
  - [bpf,v4,4/5] selftests/bpf: Add test for key-less BTF hash map
    https://git.kernel.org/bpf/bpf/c/6265b44f2c3b
  - [bpf,v4,5/5] selftests/bpf: Add test for showing a void BTF type
    https://git.kernel.org/bpf/bpf/c/1ae6aa61958a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



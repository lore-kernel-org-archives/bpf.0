Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709065B1EB
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892846; cv=none; b=FJGYr38X7eAGG9hLjEbBb+8xi8u1nLMMdTcGg2ULIUEvUxoGdW6Sp0v8d56GOJIM1K/mKiT1BU5WguFv5P7eMZvZRSDvLXECZXqUmDkjvzcHzSnoBK1gDPmPZ3dWYPLUiyZn74cSvmCgsI7ciDlVDUQ1CgWtukUcgsiM9AxvIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892846; c=relaxed/simple;
	bh=GxAjXSWxM2xH9D7SwiAhXNpB1d50blgNwbeLRqvtKwI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HVd/4jdLtaW0H5KeL/gg4OpZWwFUg897BHHr6ERtcDQTNW4qICAIvSldM4R6mEELSxUvzrS7D6vAyF5Mjpyib6c7dDhD6uORpOEd6VWoTzDQX318bfyt4s/OUQU5HBb7i19vMZ25Vvd2pbzadTbfCeRIOHa9FVCjogxWL3sbovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0w4b4ip; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0w4b4ip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139B8C2BCB3;
	Wed, 22 Apr 2026 21:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776892846;
	bh=GxAjXSWxM2xH9D7SwiAhXNpB1d50blgNwbeLRqvtKwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P0w4b4ipiWPKS8IY1mkJkABG2ygcxQmel9g6p70ZWV0NIgCnAj46ZhOyh7RPknYg0
	 0w9kmX59OmQlgX9OvP12KbJ2NvQeNYSB6devbuZfqyF8Celct4nyW1H+tSCLHtjot+
	 fgyypppBxEtMSSFPcsKtn3D3bHr+NvpdPkhb3FU3PaAvwmzrAOgARx9i1hgThcoxW+
	 WQ5ENhzR3kb5gvyNWcvOveIkJmGy9+Q1he6Zh8Sv4kRMTc2ZgyVN9UUZnBMArMDpAk
	 bGo6CYnWgTrcDZhBX01V4jsZG+FMn2Yi+hXAmwBXflCjLaoaTGA5NHYeLY8ox9Miin
	 DHRw5MJ2uVl8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CC6C3809A85;
	Wed, 22 Apr 2026 21:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/2] libbpf: fix deduplication of typedef with base
 definitions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177689280832.4040916.15269160320880604899.git-patchwork-notify@kernel.org>
Date: Wed, 22 Apr 2026 21:20:08 +0000
References: <20260417083319.32716-1-atenart@kernel.org>
In-Reply-To: <20260417083319.32716-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org,
 paulhoussel2@gmail.com, alan.maguire@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 17 Apr 2026 10:33:17 +0200 you wrote:
> When deduplicating definitions for a module, typedef defined in the base
> are not removed. This is because the hash used for base types differs
> from the one used in the deduplication logic in btf_dedup_struct_type.
> 
> This was introduced by the referenced commit when moving the typedef
> deduplication logic handling from btf_dedup_ref_type to
> btf_dedup_struct_type, as this also changed the hash logic
> (btf_hash_common to btf_hash_typedef).
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] libbpf: fix deduplication of typedef with base definitions
    https://git.kernel.org/bpf/bpf-next/c/0831b110eb45
  - [bpf,v2,2/2] selftests/bpf: ensure typedef are deduplicated in split BTF
    https://git.kernel.org/bpf/bpf-next/c/1980023d759d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



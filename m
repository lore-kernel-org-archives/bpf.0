Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B26D4AA57C
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273484; cv=none; b=RaXjvOgNysME034vl71VLTNPVoAEGVKkZ8Yo2u9YYVxjnf4sUBO8BH0O0msyO33G8U1vJ0AuEbdUx68KqSfCZaMoPoGEGCuP5/iXZNPOtnGGoWGPrH/q8vZgNUQ9BZ/X/D0yJ+9KubzH/YXd+Mopcc2m66y1q1L0qa2HQyIaQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273484; c=relaxed/simple;
	bh=2UqZlfTNdlcicZ7dzpiHjHHb/5BEYKtuQq/dlIBsXYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DrQiQ7By1vWEWS1tuQ8Lrz2icZ9stt75frnQLOS35rIPtoQL31+0/maPzvKuVWMFK460zDGpurBVBwYsyJ/8+eYpp2qmVYVtY+t54RsMNacVJ63ZvmWV3pz/n/asO74KvlpzX8XQu8Smr9Djb5SmCpxL6jTyiSqH3iYtbJWxL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezhQ4idz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezhQ4idz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDB11F000FF;
	Thu, 24 Sep 2026 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790273482;
	bh=YiiVPQBEvCATubzTYyt43qfDxWzT5lDK1cYabKTnv+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ezhQ4idzBZGH0ZpMB1KCNuMudqJP8VwvCILLByuHQtOMJxkBhj0eD+gmDIrAnw+k1
	 ZMLCe1WNLu8HGaDLnHBHvYRWYPdHiPzFNlPyp01OdsDXBs/V3Fjc0buQYOOFyVoqzg
	 8vkhD+Z0/HKNMAOrfSn7AEZxBlvqMjvN1NcBPQrs8AzbKcfy6tmFe8DeojdtX43CTM
	 lPcCvacgDdnkOYuI53e0fQQnuWonnelxG5/70daaWNBqQgRJ9CgAGHmtPuh1+hTVWt
	 P/6J+r5B92DDthcc23bLU/dF7g/gNAJvA8JYy7AfKvDxfMm8bRczjUICpL7kcZ0jd9
	 Aylxf93ojueeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E83A566DD;
	Thu, 24 Sep 2026 18:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/18] Raise BPF program stack size to 2KiB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179027341165.1690644.15234244935000712349.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 18:10:11 +0000
References: <20260924165740.2146806-1-memxor@gmail.com>
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, tj@kernel.org,
 kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Sep 2026 18:57:01 +0200 you wrote:
> BPF programs get 512 bytes of stack. This series raises that to 2 KiB
> on x86-64 and arm64. The budget covers a whole call chain, or each frame
> on a private stack, and a single function may use all of it. The
> interpreter, offloaded programs and the other JITs keep 512 bytes.
> 
> The x86-64 and arm64 JITs do not depend on 512-byte frames: both encode
> frame sizes in wide enough immediates, and on both a tail call pops the
> caller's frame and lands in the target's prologue before the target sets
> up its own.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/18] bpf: Add accessors for verifier stack slots
    https://git.kernel.org/bpf/bpf-next/c/3b8da394c289
  - [bpf-next,v4,02/18] bpf: Widen the stack slot index in the jump history
    https://git.kernel.org/bpf/bpf-next/c/a9082d8a54c6
  - [bpf-next,v4,03/18] bpf: Store linked registers in the jump history as an array
    https://git.kernel.org/bpf/bpf-next/c/9eda94d7e898
  - [bpf-next,v4,04/18] bpf: Track backtracking stack slots with bitmaps
    https://git.kernel.org/bpf/bpf-next/c/765e7328d64d
  - [bpf-next,v4,05/18] bpf: Track scratched stack slots with a bitmap
    https://git.kernel.org/bpf/bpf-next/c/ec373f1f0788
  - [bpf-next,v4,06/18] bpf: Treat unknown-size stack reads as reaching the frame top
    https://git.kernel.org/bpf/bpf-next/c/1e054ab4aad6
  - [bpf-next,v4,07/18] bpf: Size liveness stack masks by the stack each frame uses
    https://git.kernel.org/bpf/bpf-next/c/481ceda77aeb
  - [bpf-next,v4,08/18] bpf: Grow the verifier id scratch on demand
    https://git.kernel.org/bpf/bpf-next/c/9f3d900a69be
  - [bpf-next,v4,09/18] selftests/bpf: Cover the tail call caller stack depth limit
    https://git.kernel.org/bpf/bpf-next/c/7fc140ba3dd9
  - [bpf-next,v4,10/18] selftests/bpf: Check that narrow stack stores define no slot
    https://git.kernel.org/bpf/bpf-next/c/76ab55b45244
  - [bpf-next,v4,11/18] selftests/bpf: Check liveness merge of masks with different widths
    https://git.kernel.org/bpf/bpf-next/c/10e9fa2b0b20
  - [bpf-next,v4,12/18] bpf: Size the per-frame verifier structures for a 2 KiB stack
    https://git.kernel.org/bpf/bpf-next/c/ecc441fc774e
  - [bpf-next,v4,13/18] bpf: Bound program stack use by a per-program limit
    https://git.kernel.org/bpf/bpf-next/c/9cfc28c9a8e6
  - [bpf-next,v4,14/18] selftests/bpf: Add load conditions on the program stack limit
    https://git.kernel.org/bpf/bpf-next/c/4fc52c1b549b
  - [bpf-next,v4,15/18] selftests/bpf: Give the 512-byte stack boundary tests a 2 KiB twin
    https://git.kernel.org/bpf/bpf-next/c/41fc2320aafe
  - [bpf-next,v4,16/18] bpf, x86: Allow programs 2 KiB of stack
    https://git.kernel.org/bpf/bpf-next/c/9f3bcf081ded
  - [bpf-next,v4,17/18] bpf, arm64: Allow programs 2 KiB of stack
    https://git.kernel.org/bpf/bpf-next/c/1d5306c11da2
  - [bpf-next,v4,18/18] selftests/bpf: Test the 2 KiB stack budget
    https://git.kernel.org/bpf/bpf-next/c/17d6fa978c00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



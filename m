Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118611;
	b=uSKH4y2Z+AWSPuOfta8yWc5vZ29fDX7YjyEVVhr0l/8dzCgrcy2+IbPs1Vd7d/qHu11g
	 m/zbuaG24vClWGU+a8mEd4zeON1wOEtkzokMeqdV6+90NN57A6XeXp8ykutl/SEk7KNIj
	 YVa8fPJuvevTrtU2/0CT196Sfcna1HI/8zPzg/4r3Ki+0FBOXaAX6TV++chdynf4FpURi
	 mvgr1Ko6Ys+BUp5ad2YCbiGShRNhyRr4fESiB4aB8y8j3tKLYUHcBNfxWeIIhiiHg/SdZ
	 8x95m46homLQe1BQAlfVEP4IAdIhSVg8XWKYG2HayaH+SIzFx+/vaxPm6xCQTuqywXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118611;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=GB0gRLlV4wVO1bv8u274vyCCN8paUU5WSSz4Hrk9iuA=;
	b=F4C/2gtggBzV4FpiDBIsYBcOtP06OVfYXpFADN4Pf/pjFcUoNPOSxeTsZsIdVMzKiuRi
	 RFKkkg9nEOzse+Ejf0YXXgJofAKQS76IGRhkHqQAnnJqCXN+Nc0dspkQ2FHWepUy3gcML
	 JNirrF1tQ8NVEGLXg7kdob8zhUTg3kAQUmAzyIB0DfidA+5+zKipOK4kdUGIyCrrmDlTQ
	 1jVX7FyB3on/wON6ZxKLBBT/8uqub0LtTs5I1KKgve+v7grjpxzgHVbj3Uf+eB/4LDQNx
	 wWKEajMGIJ+87rsDJnUcFqcB3g25PN07GgRdW1g/cgRRC6JBRqUSKdcv3ncp53+eH1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7U0HaXe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCE1606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7U0HaXe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5368F1F01825;
	Tue, 27 Oct 2026 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118610;
	bh=GB0gRLlV4wVO1bv8u274vyCCN8paUU5WSSz4Hrk9iuA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L7U0HaXeO7RjxF6u7VSlVyacQeVEOIwHniR8PC5NY+n9orw6dhQCfEG4KOgO4n+Cm
	 BchPTfR1Aglqfm4088nrAp2sNkx+zkTJJ59r1BOcdmRu6SanJ60hzu/04jGpEI9bH7
	 FphX0wrevALtj0CkooPiCUDpy/ipu+QLjUQyWxegd3iQgXhBlSvc90A5i+4hJSDizL
	 kuPMpO24yUridXMQerBecPrC9X3mMfcFFJQFacE7HdSJ3p7pxKh4udvOs53OXf4TOb
	 h+uGzkQPAkmlQzep1PRpKvfbHulitArMKMe+6Nm9AGoyn/5hcUvweTFxPmxPpDG6Fi
	 vlKaTsH5X90Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4450D3AA9A95;
	Tue, 27 Oct 2026 16:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 00/11] bpf: fixes and follow-ups for 32-/64-bit
 scalar
 evolution
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179311860907.198437.13084328897071120006.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 16:30:09 +0000
References: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
In-Reply-To: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, yonghong.song@linux.dev,
 memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 26 Oct 2026 16:38:20 -0700 you wrote:
> Fixes:
> - bpf: avoid false infinite loop reports after changes in SCEV clamping
> - bpf: do not intersect with current register range on clamp
> - bpf: reject pointer operands for 32-bit recurrences/latches
> 
> Follow-ups:
> - bpf: (zext32 (zext32 X)) -> (zext32 X) SCEV simplification rule
> - bpf: check the iteration count before the predicted exit value
> 
> [...]

Here is the summary with links:
  - [bpf,v2,01/11] bpf: reject pointer operands for 32-bit recurrences/latches
    https://git.kernel.org/bpf/bpf/c/c463b378eae7
  - [bpf,v2,02/11] bpf: do not intersect with current register range on clamp
    https://git.kernel.org/bpf/bpf/c/0c33d612bdd5
  - [bpf,v2,03/11] bpf: avoid false infinite loop reports after changes in SCEV clamping
    https://git.kernel.org/bpf/bpf/c/5dd32c8c1082
  - [bpf,v2,04/11] bpf: check the iteration count before the predicted exit value
    https://git.kernel.org/bpf/bpf/c/86d654957d40
  - [bpf,v2,05/11] bpf: (zext32 (zext32 X)) -> (zext32 X) SCEV simplification rule
    https://git.kernel.org/bpf/bpf/c/abc9a76a888f
  - [bpf,v2,06/11] bpf: print 32-bit SCEV bounds as 32-bit numbers
    https://git.kernel.org/bpf/bpf/c/899cbaae6e4c
  - [bpf,v2,07/11] selftests/bpf: pointer operands for 32-bit recurrences/latches
    https://git.kernel.org/bpf/bpf/c/88b1da858326
  - [bpf,v2,08/11] selftests/bpf: cases with empty range error under old clamping logic
    https://git.kernel.org/bpf/bpf/c/39cd4e0915c4
  - [bpf,v2,09/11] selftests/bpf: cases for SCEV interaction with infinite loop detection
    https://git.kernel.org/bpf/bpf/c/344c14e8b3d4
  - [bpf,v2,10/11] selftests/bpf: 32-bit copy of the counter compared at the latch
    https://git.kernel.org/bpf/bpf/c/a0137c789774
  - [bpf,v2,11/11] selftests/bpf: Restore stack pointer subrange pruning coverage
    https://git.kernel.org/bpf/bpf/c/8fd732e5a64b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



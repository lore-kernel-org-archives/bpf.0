Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29035F19D;
	Wed, 26 Aug 2026 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787738604; cv=none; b=cZ48MinSKVDSXmfCIsTO9Z/4hxKRb7tETOZQ36oPIccB59ycHd0tCGJxCn9dwOrDkdQCf9OAiVBKgAQtGOb/U3v47W+xx0f9NwvdZIu6D+iUTFMLIFrJOUui1d/bshrkCX2vwFV6ZNjcHAewSjlPvut5QfOi5ahmek8BKFbKDqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787738604; c=relaxed/simple;
	bh=jiqHUks1m0JXbpeFcnNwxpziXVJoP1qjEoguu8lM/WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z89lVykZfln89tjqQIe8UzaLBJbaTaApYP2a2xXJOUfhIgJyNB0Zz5gStcH+alQURfqfF1jGN9FctGqnIxMRo0Hg4IafyewrvoRo1LCChnXEmokAe7kbX4Aq5gm0VJsnEAbrlg4a8Ir7PuN6GHFs8+83/jhqBr7pg99iSSMyVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=egVz/zbA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="egVz/zbA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WZakOKFiw1qwrXHhV0NoUSm3EeQmFpLc6hHbXxKxp4w=; b=egVz/zbAaKyEoDL6mec9PlJmKR
	S0HI06OfojIuS8q55yHaRp10zVsWuRnv4NJ47AgFAr3Jgc5e5I3lUd40o2I2x5+/3vKWCk5vfjnRC
	W8i/C9kFrAf2hYc6LGqfGt9Q/+Ewe0drS5bnywL83w2+OCBBxNz4ZSnJXiF92vt4xpcoTAcDbCW3F
	5vd09+38/5qaBqM4HI10/7+GHQWx63vnOKSj7cZncpze94BPHo04cPQUhcthyFOtCR9q4tUlkoWEX
	9j7Ox0ORjD0W04UDwlWrL//J4a7uSkhDAUEpFHOSQ74mtl2viIOkRlUMZ/4h2SMyY3MTrNxdM6x7o
	LPnA17Fw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wzATY-00F8SY-28;
	Wed, 26 Aug 2026 10:03:20 +0000
Date: Wed, 26 Aug 2026 03:03:17 -0700
From: Breno Leitao <leitao@debian.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] bpf: arena: reschedule while freeing the arena pages
Message-ID: <ao61BrPZiCx7erAR@gmail.com>
References: <20260824-b4-bpf-arena-free-resched-v1-1-5c447477a64b@debian.org>
 <20260824170831.33E051F000E9@smtp.kernel.org>
 <ao2gP7Y6UJ2o2tUc@gmail.com>
 <CAADnVQKP8R=1aZiDcnfkqD3mA=32R2Yrw642u3w7de4JSfMWKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKP8R=1aZiDcnfkqD3mA=32R2Yrw642u3w7de4JSfMWKg@mail.gmail.com>
X-Debian-User: leitao

Hello Alexei,

On Tue, Aug 25, 2026 at 09:35:03AM -0700, Alexei Starovoitov wrote:
> Just to be clear.. Is this needed to backport to some older kernel?
> New kernel with CONFIG_PREEMPT_LAZY=y shouldn't need
> this old practice of sprinkling cond_resched().

Yes, this is happening on our Meta kernel, and it is crashing a lot on old
kernel in production.

It does crash a lot for us: 56780 crashes over 1538 hosts in the last 30
days, 41% of all our kernel crashes in that window.  But it stops dead
at 6.13:

    6.11.1     26060 crashes /  160 hosts
    6.13.2     26014 crashes / 1119 hosts

Looking further, it seems that commit 517e8a7835e8c ("bpf: Fix softlockup in
arena_map_free on 64k page kernel") is what is what makes the
difference, which landed in v6.14.  Meta's arm64 kernels use 64k pages,
so before that commit GUARD_SZ / 2 is 32768 and
bpf_arena_get_kern_vm_start() is not page aligned

So there is nothing to fix upstream, and nothing to fix in the teardown
loop.  We just need 517e8a7835e8c in our 6.11 and 6.13 branches.

Sorry for the noise
Thanks,

--
pw-bot: rejected

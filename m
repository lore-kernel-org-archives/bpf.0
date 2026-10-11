Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7831F38F92D;
	Sun, 11 Oct 2026 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791763116; cv=none; b=AgLv66zZMGw1I+zLel70R5RsK0nwvnccj5JF3n3xC5yGRsl3FKwF/ej1x9NDeXLK/lo/GoGepN503Lvvyt8ic1pybh7u/4A7Nsovv9DfJ2/MXZkWEJ/EZOn4+CRknpVqN12pzQMazeqb59fBtjDkxD2ZRTkGBjzjP+o3kJv+IRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791763116; c=relaxed/simple;
	bh=hLEsQpBs7QL7OqRDPzIQ39cz72I8Y4conVmCTtv9nLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw0QlgN91ErcvaBIzBahNyJL0gTGVsFOBmhwxFLiCOT/YHjNExemO8+2GzztZ0P80GeR5ZbOynBKRXHS8VseO/3FWclvNKuMIcdKe4c6HtQs+/nul8SoLBw+FcS3Tz3NN5Sm4h8cU0cfxj3vOoqSFmL7DzeDQqU8DofsfxGorps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNT/oclY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNT/oclY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1791F0089B;
	Sun, 11 Oct 2026 23:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791763115;
	bh=QCCntHCgy7VbEHLAJo6UOCr0OwmulBO/v13/0zhFZrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dNT/oclYnh1ac4Q10wCAhu0/giJaa1Caw8cpQTp537/LfnmOQlvBLu93n+HV/allW
	 E10dJc8Umu4uy72/Hvw0mswCoG9Ac/V4pc9bUlNEANSoCb5ZVDFgYDF8s01tBqxdyU
	 xHaTA1pC6UnyXPeIHBY509eusGo3LV/tGs/L9nxKY2q2iFy9637KWOPTopIr2us8oJ
	 ETQEATNKmONslO5PnNAtajIKQVPTSOGljipBj8MipM8WUByc/+oY1OsC5NsSoPWyx0
	 NMsjM43/TnkeiMTCKC1gYpt0dbTHFMM/9C/xcLpYdBieQWn8E5zNj6YvxLGyIlAc7m
	 5/X1TnAP0PwOg==
Date: Sun, 11 Oct 2026 19:58:33 -0400
From: Sasha Levin <sashal@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH] tools/dma: fix building from the top level with O=
Message-ID: <aswiqUfbA9840hgo@laps>
References: <20261011223358.2327625-4-sashal@kernel.org>
 <sashiko-outbox-167498@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-167498@kernel.org>

On Sun, Oct 11, 2026 at 10:43:33PM +0000, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>- [Low] tools/dma: incomplete fix for out-of-tree (O=) builds
>--
>
>commit f9ebfb989b6d469df7135b7ea719817656f0b606
>Author: Sasha Levin <sashal@kernel.org>
>
>tools/dma: fix building from the top level with O=
>
>This commit attempts to fix the out-of-tree build for tools/dma when using
>O=<dir> by correctly setting the srctree variable. It ensures that srctree
>is worked out even when it is empty or when building_out_of_srctree is set.
>
>> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
>> index e4abf37bf020c..b5fe6e2625eef 100644
>> --- a/tools/dma/Makefile
>> +++ b/tools/dma/Makefile
>> @@ -7,7 +7,13 @@ bindir ?= /usr/bin
>>  # isn't set and when invoked from selftests build, where srctree
>>  # is set to ".". building_out_of_srctree is undefined for in srctree
>>  # builds
>> +ifeq ($(srctree),)
>> +update_srctree := 1
>> +endif
>>  ifndef building_out_of_srctree
>> +update_srctree := 1
>> +endif
>> +ifeq ($(update_srctree),1)
>>  srctree := $(patsubst %/,%,$(dir $(CURDIR)))
>>  srctree := $(patsubst %/,%,$(dir $(srctree)))
>>  endif
>
>[Severity: Low]
>Does this commit completely fix the out-of-tree (O=) builds?
>
>While this resolves the srctree issue to successfully locate Makefile.include,
>an out-of-tree build via O=<dir> will still fail immediately afterwards.

This was fixed in a different patch here: https://lore.kernel.org/r/20261011223358.2327625-3-sashal@kernel.org

-- 
Thanks,
Sasha

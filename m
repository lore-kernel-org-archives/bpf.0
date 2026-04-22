Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C6191F94
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776817767; cv=none; b=Dcd5KSs5ndTFac9mXD911DzL9ZZy3E1Kxu1act4YIe+c6nHgJMN6E6HyT6VCa1piv8WUBTskppiF2GKBLRix1q1C/XVCQ3pxjOZnlqmgj5mGXQO6suR5JppGQat6cq7p3tX8bLaTyx9iCZc+43AdewzmxePb4wRM0qMWcCkQyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776817767; c=relaxed/simple;
	bh=zH0U4ineaEs07T53qcgS0oQ74H5dGaHaSXFnTIvWlms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oI1292QSzd7yG3d06lePnubRmaUo44QOMa0QHf3lTcd53E+PvMiS5TaLzfcqfX7yAC+bdIYCZSe2pQ1JXbvZy0a8+nipO2sBnz1POPLJlJ25odhhuX8vOAlsMuU26jt0aAKfp6nj3kcLCUxFY9ecOZPtJrd22/cu2mj35huT8wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nAuOLEct; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nAuOLEct"
Message-ID: <5323628d-65d6-4fbf-a302-2f5d3e2d46e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776817762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWj/5q9t4uwb3E+DgLdW4JaDawhpaJfxsxaAHuuwY1c=;
	b=nAuOLEctBlMxX9my98ebK/MEvDVwUVvfnVu//rjqXn5CXVIU6cBA0arRrRp1F2dx9lwUJG
	+RFXs3wNTZGAW2/3a9r/HsFx1ede8+OaO14y5UTCqwAklvF0LVpl5bCGT0EE6ouwb6ANnq
	U5YDgRIU16EeUNnNpVkLc4dtjt9Khvo=
Date: Tue, 21 Apr 2026 17:29:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/9] bpf: Fix tail_call_reachable leak
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260421171937.3508679-1-yonghong.song@linux.dev>
 <154d4ed659716997501257309218648961b1f25de606e411a8f84cf16b95cc5a@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <154d4ed659716997501257309218648961b1f25de606e411a8f84cf16b95cc5a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/21/26 11:06 AM, bot+bpf-ci@kernel.org wrote:
> commit 697f215251be114235dcf2ec469f425797a26a51
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Fix tail_call_reachable leak
>
> This commit fixes a leak of the local tail_call_reachable flag across
> sibling subprogs during the DFS traversal in
> check_max_stack_depth_subprog(), which caused the JIT to emit
> unnecessary tail call counter preservation code for subprogs that
> could not be reached via a tail call path.
>
> Should this commit carry a Fixes: tag? The buggy pattern (set
> tail_call_reachable to true on push, never reset on pop, then mark all
> currently-on-stack frames) appears to have been introduced by commit
> ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in
> JIT") which originally added tail_call_reachable tracking to the
> stack-depth DFS.
>
> Something like:
>
>      Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")

The above fix tag is in 2020 so it has been 5+ years. BTW, this is not
really a bug although in certain cases it may cause more stack space than needed.

I would skip Fixes tag for this patch.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24736686700


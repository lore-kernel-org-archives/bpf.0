Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8D2405EB
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178501; cv=none; b=WnXywIPX8QFNyO31eql5HkWv19ITid13rvpBTuYYeEw6KOPuGkO3AcVONmU8b3n4Z35jK9dM42ZbZYVaPSCk4Px2eSxdHi36U4gC/pOqd5FwuNILK691L6j+kuMu8gq8U928Gzr0DR5LGT7dHjdrovgUy1zTtHDYwmJAC7Kw6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178501; c=relaxed/simple;
	bh=UhJJsm2tNfLB9xUO9NtvEulNO08uGmsVIKokm5sX4zI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l2ooF3x8Rg836F4rjALt963dJQskxBs40IFnZB/arnkgAgxOhNXFmuhJsYzAeqm8Kne5JVk4gYQDC9cHZuO+P46hfTKFHy5VCSdbb0g1bVfik5gQlR4YjzNpSUTwoyg9XAxPCwQrz7mdnkQqT88jHpYTuSCblBQ/p9KWGsuOsGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btjyQV/+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btjyQV/+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a8fba3f769so5930285ad.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 18:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775178500; x=1775783300; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JG1pkqTO4Y4H2FCB3jB3l1JPvRx/2avmmc4C5srLFCE=;
        b=btjyQV/+/mC+aaJsho2wWMgweLAs8kMdX5E2YMFf8LzlxPRZxyfUo8bxb+mW/gDtPy
         hY0jHA2sNvvR+DFDwzVzN9Kz6yttNEnmhkdNt0AgOzvH1HoW1WcdYiNwwBb3pnYoRmSJ
         U22Eyh1pnk6bUzsia4SLZIHV29jjN4rUdftzJlMwv2FCOraM8iDU6vLBvZdqsizNsarh
         j/Wvvj3z7vv9jvEVtZV0YuX2Z/MtOq2KfqTJHDJd6MzusVeJb/opDDCzVrw1RMUQ+yfW
         eakAckVjVkOi4MZYJEkVqMGDdlvPsbIdIywHKv+7XEDGBL2oAXD9WsJM4P0YgcyjIRsf
         oYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775178500; x=1775783300;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JG1pkqTO4Y4H2FCB3jB3l1JPvRx/2avmmc4C5srLFCE=;
        b=Z46DZqI7XG1f+2gp0V0Kw/XdH1RyxoIhwgz3PXf2qYN+S82pDrc+rgxj8lKSg/elCF
         8kbTSoYE3rMU86+fnPbMzDUbjz2Nnj+c49ScpaU+rCi3ma3KUTg1/BDrrgFTnlidaz/4
         TsGX6Lgg+bE+8xyBkRxAoFSSX0O1000g4qO4oDZh6qj1j9PxfZmdswvE/9UY2TFkOJMZ
         DDnt/gdooIU+q0YY2Ut4SWnOS22N0CmHHbSeYBBbuuSQdD8QHwny4ka7Iq1uO2zUNxA2
         tB1Xzl32A3DH6SxKc7X1lquBrhopq2EByQhbRczfy3GpSXx7kJfarXxEoUtxeKKgQxOs
         XrXw==
X-Forwarded-Encrypted: i=1; AJvYcCXItDlVEh5CTEh4DFnH8X+t9RXKOzRxDAFehyZnXrSksz9cQx7qTE/++2oYo5TxELFDZaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvrmXJHsSGqTXMdZ36nakJKrVpEiaLZ/cq2MD5+1aUqcTKL9Be
	a433z1Zny7gAFCb2jwsTlPuNv6Xf8/GbEEITf1udlVoplgCz1v2MLaq9
X-Gm-Gg: AeBDievLKWUnrXXTsU5CEF7GbL1+pjeoeAXSnRbASMJ6G0Q0ZewFSG4Hdp75/B5GbI+
	CCFQFOL2PgoZffvQbI7gaLPFLbgvrMlszy66Yv9XCFZziaJA9himh1gn7wNHgxbZqKhHz1JZ0VY
	wvQfvh6aHBDQ6T6GnTGVCuUrXKUmyq9pc12QBQ/BsyoFWWV/CrlGkTSzarqXiGxdDYsY8AkuQSH
	9o1fMcLVG0ATTvjgng3c53rRIYqu+B1TDWjglgm28dfhR5oz02KXLziaKC2AAekl5HXrJhnfQLC
	+PRAfjU6ER0sTLp3FeZeJgocZsJJLVehVGLNIdM7wNcVVbJnwOkcWn50PCb/xlpYjCXg4dAWcq3
	7/CiKyDck0WUtIhGIl4ULvk3dNblAa3ZNnxPDcnUg1oa/s+gQfueRQOWx7Qh4BqyFgwDeFrpmfm
	E+ORMN4XeBIs37/PglSoSL/lWhV56FzPshpYrrh0BMwNpnhIwXWyGcrkBdKUt3i5w=
X-Received: by 2002:a17:903:2a88:b0:2b0:6df2:8cd2 with SMTP id d9443c01a7336-2b2817a1cdemr15915065ad.19.1775178499814;
        Thu, 02 Apr 2026 18:08:19 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478bc96sm42248925ad.33.2026.04.02.18.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 18:08:19 -0700 (PDT)
Message-ID: <1c90f21c027534a1f59770c198af380056229bfe.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Fix invariant violations and improve
 branch detection
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Thu, 02 Apr 2026 18:08:16 -0700
In-Reply-To: <cover.1775142354.git.paul.chaignon@gmail.com>
References: <cover.1775142354.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-02 at 17:07 +0200, Paul Chaignon wrote:
> This patchset fixes invariant violations on register bounds. These
> invariant violations cause a warning and happen when reg_bounds_sync is
> trying to refine register bounds while walking an impossible branch.
>=20
> This patchset takes this situation as an opportunity to improve
> verification performance. That is, the verifier will use the invariant
> violations as a signal that a branch cannot be taken and process it as
> dead code.
>=20
> This patchset implements this approach and covers it in selftests with
> a new invariant violation case. Some of the logic in reg_bounds_sync
> likely acts as a duplicate with logic from is_scalar_branch_taken. This
> patchset does not attempt to remove superfluous logic from
> is_scalar_branch_taken and leaves it to a future patchset (ex. once
> syzbot has confirmed that all invariant violations are fixed).
>=20
> In the future, there is also a potential opportunity to simplify
> existing logic by merging reg_bounds_sync and range_bounds_violation
> (have reg_bounds_sync error out on invariant violation). That is
> however not needed to fix invariant violation, which we focus on in
> this patchset.
>=20
> Changes in v3:
>   - Rename and refactor the helper functions checking for tnum-related
>     invariant violations (Mykyta).
>   - Small changes to comment style in verifier changes and new selftest
>     (Mykyta).
>   - Rebased.
> Changes in v2:
>   - Moved tmp registers to env in preparatory commit (Eduard).
>   - Updated reg_bounds_sync to bail out in case of ill-formed
>     registers, thus avoiding one set of invariant violation checks in
>     simulate_both_branches_taken (Eduard).
>   - Drop the Fixes tag to avoid misleading backporters (Shung-Hsi).
>   - Improve wording of commit descriptions (Shung-Hsi, Hari).
>   - Fix error in code comments (AI bot).
>   - Rebased.

Thank you for addressing this issue, let's land this.
Please proceed with the followup covering tnum checks,
so that we can be finally sure that there are no
more invariant violations possible.

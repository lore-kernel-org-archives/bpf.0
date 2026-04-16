Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D433B6BF3
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344985; cv=none; b=ommcK4wjWT26T2xV1Ydj406MCiO7qYCjZQ2+H3IN55qg9+vCCq2Mc7J5VldGp6lq0AqN2pkx/MrdTeZtmhKCNUPt8bcuTX0yXiDapEEUsTyo9hPQTbbUWfXmBI4xojcbpMc518A/KSfCoNFmAujktI1SHvASqNae926VAKxfGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344985; c=relaxed/simple;
	bh=IuFHfKvw4AaXS+sJZ4aZsdVitVcIiWPTo0nWX3Sf7sY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UJyjtN6dnsuT4AeM5Y3RVzvhug7aahP0wDSiDw4RmaPQx6rpGTfy0wkyt5JzTbWkK65DUAXCuDHLYVNHpEetKaArVGePpZPMztIZ8hhKuK3JhQ1A3VVB8FIxndxt0iju74GouOwurerChlODc1p2uj3ypIdELZGidvBENfv/OOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URf+M1Bx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URf+M1Bx"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ba840146so79003595e9.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776344982; x=1776949782; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qx166AIK/GrOhpDdws2xwWLGxCo+ft6N2icOFNiQp4=;
        b=URf+M1BxvCh/6ghYeHM9zK1Y+i8OvFfh2NZ7fq3BWfLMv1dDh3u2UwGd0E7qxzWllt
         F2Rg/pInZDk6pMm2QQRUykcLi/ZHgEOWu0aP5qdvreUq7INHfdKnKqJVhNSPNTIfGXEs
         ihWq2k8mtAay9J5/JZTaRrLCkiBZBZ5Nvk/kq+raURmf7E1qnGgAMZc/JEc5WTjAmlh9
         GXRQ2odoM9+NwdEQA0VUGPXn/BHzZgZkL6MaQqkFoAMzek23DSYcZTActfyXw/rG2YPf
         /hJwXGRWBE9YyhRjdAUKbeU0snYGYK8eYCzqo85VnxpfX7tfBM/JohSZSd+SvT5HowvJ
         YwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776344982; x=1776949782;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qx166AIK/GrOhpDdws2xwWLGxCo+ft6N2icOFNiQp4=;
        b=OJcNIvhwDN0Q0QHgAIhK3v/aRd9ht8omL5DeQyVXzYEaF6ZzEeSud+0AAvnBP9L2rn
         fGNpyCqCqf0mdfFTAaEXt07i6dD2ZW032jmZiLOa5wjbnFQ7E7AisyrmKwyjs7SxkrrJ
         ypV8NoO/vJOkI+QVRMHcpKpWg19GnLZ3y0F/EV6fbKPYbOO5AZL2wVrQBfrFmRxt2zOG
         h0dt9gvfZYNlFp9GUjsr++/+blsMXL3OC+M748LiaXcCfrq7qe26Udw/HeqM1nJ+RIZP
         37MhJZVXiTz7248lbYNezIApHn2Lg7MmdB3wcg7v6+dqvUWvs0/pWYkU2ZBHJEuQ8rlX
         R7OQ==
X-Gm-Message-State: AOJu0Yyniblf9nWnxskUC+R/KhShoF1J0AbOcwapCkcfMd8djSuWXhjN
	GtBMPldQABYUrEPI09CjmmHcFsMeq8TnKLk4kDKU04pr1kt7z6xxpxzAWPgKNBhT
X-Gm-Gg: AeBDietRXqzVklaNNiLdLxfbHgeHPTlezyRz5bHKMxO9CZ9ThDuSLjtYkvte/3HehSh
	eaiL0yltbOWIJ4XeqWPU4F2Sh7n0oV91bljqL+r63aTzvX9IfjbboqyrscqvcF+BSyBK9VgOwmm
	BJGBDL4c03v/tTs0IcoYO0HaUAOCCvz0BnUc2rFKpCM4yxu6nDEz11FHZRRtwFNfl/jhtoIqumh
	rOvyFfVIM8j0oL0jVMw4bS23/T6isSOkh5nxHtJ2TE8rUiSS34wDfQPGg2cB2uj5D4Ck/G5TuCz
	7i216yPJofObxwZLnSojMeaJPEwdfI1jyH5gh0dJRO0DNKyDcHPxfBIKTjpMtep15rdurdVv1A3
	y4IhZRZcnsFTuJVyU9GhWgfnx+xLqs5x4EWnmmSS3YK/rRM6N1QlsgjMS/ioRUIqp/dcV718ZFO
	uVqFfHlhnUOqHKYPLfdhhve2xNf8OUL1Evz/bQh7cEa4m2rkaCZGYz4m6Kne18QOXBuzbLq6e2E
	sLY12noViIedsG8ySmfrZ+ewwHmz5wUX3RbkkfXUCjSbuS10xL9qktjspdMvlia2KmStDk3r1mv
	WNoTPdrYglsB6Uokqzhsa/l8XkZSnRiMM9QXLAbOYV+/p+pGcu7X
X-Received: by 2002:a05:600c:350c:b0:488:9661:2570 with SMTP id 5b1f17b1804b1-488d67ce8c2mr354763405e9.8.1776344981680;
        Thu, 16 Apr 2026 06:09:41 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b55a04a9836ebec0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b55a:4a9:836e:bec0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f08b4f7esm71745505e9.0.2026.04.16.06.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:09:41 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:09:39 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Helen Koike <koike@igalia.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH RFC bpf-next 0/7] bpf: Fix reg_bounds' slow mode and improve
 verifier refinement
Message-ID: <cover.1776344897.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset fixes several failing test cases in the slow-mode
reg_bounds selftests. It also includes an improvement to the verifier
u32->*64 refinement logic, to help better align it with reg_bounds'
refinement logic.

I'm sending as an RFC because it needs [1] to be merged first. The two
patches from [1] are included here, before my fixes.

Patch "bpf: Improve 64bits bounds refinement from u32 bounds" also
happens to address the refinement shortcomings discussed at [2]. To
demonstrate that, I included the new selftests from [2] at the end of
this series.

1: https://lore.kernel.org/all/20260415160728.657270-1-harishankar.vishwanathan@gmail.com/
2: https://lore.kernel.org/all/20260410124035.297632-1-koike@igalia.com/

Harishankar Vishwanathan (1):
  bpf/verifier: Use intersection checks when simulating to detect dead
    branches

Paul Chaignon (5):
  selftests/bpf: Test for empty intersection of tnum and u64
  selftests/bpf: Fix reg_bounds to prune on range violations
  bpf: Improve 64bits bounds refinement from u32 bounds
  bpf: Remove dead code from u32->*64 refinement logic
  selftests/bpf: Hardcode insteresting 32->64 refinement cases

Eduard Zingerman (1):
  selftests/bpf: new cases handled by 32->64 range refinements

 kernel/bpf/verifier.c                         | 299 +++++++++++++++---
 .../selftests/bpf/prog_tests/reg_bounds.c     |  38 ++-
 .../selftests/bpf/progs/verifier_bounds.c     | 202 ++++++++++++
 3 files changed, 482 insertions(+), 57 deletions(-)

-- 
2.43.0


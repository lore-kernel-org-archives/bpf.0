Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E3357D1D;
	Tue,  2 Jun 2026 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388111; cv=none; b=DzBhp9SF6PKLHqfCmV91VtVMvjhWJJVmF/gPihyfmg4KY3ueU3uOVYYqKcelELvvf7oA3Bg1Dg0m6/yOclY5kEUr2mJFnMmwSSfKytmBQPhsPDzKNVNkCBOTsGUbmkl4cig0Cn6Tzj+jFDg3ZexIa4JAd7GtkefYm2d49aZLxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388111; c=relaxed/simple;
	bh=2mk+dwNu0i/Zqex9CjcafI2LzhKLjrgLIHtYxQ7CFdo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=G657UYX7oeRi1yD1NVOeV0iHQnJtu0/MVn4jULjIM66pKrwtTNkAV1m3KqxW1vJRK19fEjXSG0vTGjWTPKaamEmPBiKV0DpDE8M6f3XJEqCSTASDnu0CMo+19R9sq/hLRlmESyPlh6G8e6D938vReWizplqM/J5W9tthFnSVlYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8THNxEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8THNxEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1456E1F00893;
	Tue,  2 Jun 2026 08:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780388110;
	bh=2mk+dwNu0i/Zqex9CjcafI2LzhKLjrgLIHtYxQ7CFdo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Q8THNxEI757acW4Fyf1vBoG9NNHtEyMJnGrX4OM6nWWN1r6BMZir8cOSmsnvc4289
	 GIJvIr46tJGzFRfqr3VrPrDtOhySvWrIipEvVekGpUU4sN+tJmSbddYK1k4+wk7zkW
	 Mlrh4MSBcVhHYpNNbdp3MtJffvyJk1uDYigj94GhN22OqZ52FDBr2/jBCeoE+uaNGU
	 tVoXGLX0IIxBJ+9fBmW0VeHPE8DFEuWQidZtWYKLejM5aenPV7s1W6C5HS6ZF0WLOD
	 zqI5GU4HI0ZDfxTIuHzXg8OjKNTaZ6QDKwFEUcleSity8ry7Lv5rrij2ARIXvtRvIF
	 o9rhMuT9MlS5g==
Content-Type: multipart/mixed; boundary="===============8398948007622053609=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f56821dd0ced1df92a25da2428dd8fd3be81841df8ed3b8061ace2c496f0004d@mail.kernel.org>
In-Reply-To: <20260602073539.1567846-2-malin89@huawei.com>
References: <20260602073539.1567846-2-malin89@huawei.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: Cover tail-call cgroup storage prog-array checks
From: bot+bpf-ci@kernel.org
To: malin89@huawei.com,ast@kernel.org,daniel@iogearbox.net,bpf@vger.kernel.org
Cc: andrii@kernel.org,john.fastabend@gmail.com,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,zhuyifei@google.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ameryhung@gmail.com,malin89@huawei.com,cuirongzhen@huawei.com,tanjingguo@huawei.com,cenxianlong@huawei.com,chenzhe@huawei.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 08:15:10 +0000 (UTC)

--===============8398948007622053609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add tail-call selftests for prog-array ownership when cgroup storage is
> in use. Verify that loading succeeds when callers and callees reuse the
> owner's cgroup storage map, and that loading fails for a different
> storage map or for a storage-less bridge program.
>
> Signed-off-by: Lin Ma <malin89@huawei.com>
> Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
> Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>

bot+bpf-ci@kernel.org raised a concern about the Fixes tag in v1. The
bot pointed out that the commit message references commit abad3d0bad72
as the incomplete fix that this patch builds upon, and the current patch
removes the '|| !cookie' logic that was introduced in abad3d0bad72, not
the original shared storage feature from 7d9c3427894f.

The bot suggested the Fixes tag should point to abad3d0bad72 rather than
7d9c3427894f. The author responded explaining both patches target
7d9c3427894f and this is a complement rather than a fix of abad3d0bad72,
but did not change the Fixes tag in v2. This remains unaddressed.

Reference: https://lore.kernel.org/bpf/d061816d1a9bfa304d8b8a986df4729e3b30028a350d79e7eb981a41d7b5a53c@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26806034423
--===============8398948007622053609==--

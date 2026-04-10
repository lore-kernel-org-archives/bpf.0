Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399C02D3A7C
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775786542; cv=none; b=PeMUqjeFhcJHTdgf+OELl/5Hrp+I2vUAW8y+1b0DEm5zgET+sUz0X4VXYaVr5o3mB5VHmAQtVHG5Kzm2gKdYyGbOBl3bCuPm0tjOeURB4N2RNzs1QG0B7ExP3AIowCQG27KuAWb1Uv3p13vEGS0vYMLn92u5neuDql6UTfdZW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775786542; c=relaxed/simple;
	bh=kr1S691Crjgu9dlZKHySfEnnMETrJpS6Re9fCC273zk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=d6U0TcwLhj4k9C1plqIFteJ/DXf00Q1DrkhWg+LpDXmwgnk2LddBWn2HMvFcAlTrvh1HZb1IsM/q3OUxD3hASr8SrVWFj72WuNunev1BxLpyIkc/gVSy2crOxde60vGB95Cr23UdsVnXVxULNIpPcsOeBgmA10i0fNRlXImxQkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy3aifYl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy3aifYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AC6C4CEF7;
	Fri, 10 Apr 2026 02:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775786541;
	bh=kr1S691Crjgu9dlZKHySfEnnMETrJpS6Re9fCC273zk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Xy3aifYlNHa4q9LTMMqJpliAaDtF6X/yZ0m8EbRq4SdeGdYdU4BuOw4cW+cTMS7O4
	 Txm4QR6oqCEstR37RB5tQMsYBLnE2I3Or0DnVlD5W+o1H6MB4dKyHb5Oc/rPyI6cgN
	 zYPAi/B9CVgld2ABdRISLYQOzm9VtQiwmoGbhKON/UAq6mI671+BXTUJE4x47SFcCs
	 WugzVJu4fslWGoNMZkqO78qQcYJ8RTkdVXCo64JldZQHbcwGODwGj47i4xtEbw1E+y
	 cLxmb2GoZZ8TMQ7yuuZV/yIlZjDx+9ohsAUizZERbyjSbl9EvrfI+RxpL2IHaZXNIA
	 vBCQL5UIwVQxQ==
Content-Type: multipart/mixed; boundary="===============6965203328950192564=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a7f9aad746ac5b2755c76590d7a0812152a6403585f08ab62a6499c19abacd69@mail.kernel.org>
In-Reply-To: <20260409-patch-set-v2-8-651804512349@gmail.com>
References: <20260409-patch-set-v2-8-651804512349@gmail.com>
Subject: Re: [PATCH bpf-next v2 08/13] bpf: simplify liveness to use (callsite, depth) keyed func_instances
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,alexei.starovoitov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 02:02:21 +0000 (UTC)

--===============6965203328950192564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> func_instance stores just callsite, depth, and a callsites[] array
> for outer frame lookups.

The struct func_instance does not have a callsites[] array. The
callsites[] array lives in struct live_stack_query, not func_instance.
Should this say "live_stack_query stores a callsites[] array for outer
frame lookups" instead?

> Remove spis_single_slot(), spis_msb_half_slot(), spis_lsb_half_slot()
> helpers from bpf_verifier.h as they are no longer used.

The diff removes spis_one_bit() and spis_single_slot(). There are no
spis_msb_half_slot() or spis_lsb_half_slot() functions in the tree
(checked back through the entire series). Should this say
"spis_one_bit() and spis_single_slot()"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24221779050
--===============6965203328950192564==--

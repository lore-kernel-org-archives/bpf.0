Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894E2C08C4
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844956; cv=none; b=XOKW01SHS2CHXJ3PoJbuVcQnpib7wvGj5aWUQVVxfye2tNt+6wZMOKo6y8Cdr/xKmkpy31zVtb8RyP6u9slZ/gCtrKiHVbxQH7M1+ZFzUYgLF9l1NTNrlvDqFz/6v9qbEiQvHBNm1B0mGhc1XfaaeF5XkggMQZp+6d6dbDWF1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844956; c=relaxed/simple;
	bh=6Pq7toGRBGn+Ec8UEuPgc0SD+mUE0wGY6th44T13dBc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=epvXpcfS6Gz9ydJPCsxC04CZTvocxG37tYz+bhqNYOML7yty2qvLojFCA00EkSm0hcQQhxX1rwsOTj/fbZ5uz/X2Le59ogVJ7isefLwCPiHHvK/5X1WiUv5QIFYQTyDo4THOZ4yyOyBx9VgZ1ZQxKKeUI2xACguQgEC3c57+wko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzH2nr8o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzH2nr8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B093C4CEF7;
	Sat,  7 Mar 2026 00:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772844955;
	bh=6Pq7toGRBGn+Ec8UEuPgc0SD+mUE0wGY6th44T13dBc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rzH2nr8o6KX4gbu1xx5JyD5HK4SHXLxxvaXH14zlcfrPpdsFx1STnqyG9uyim0V6G
	 JRt9y7ZbYdfZiUJtF6CXJEEFGGzp+2uwwggWeSHVuFGQaDwFMa41x9ufDM3iGtmO32
	 IskfgGhQSprA3LpbOZIysn97RkZbG9o3zM918C/OBeDzITDVSt/cqqyNR9Fc68QDOX
	 v4Cgknr95iDlNTVrNsx06463skdTJQHfplbPZIZN3XoSppO4xhc8Tv1sU4y1TOl4PV
	 iP1xXqi3sZMNgmh9YpkWS4hKMDvVGSrPzPrZBUXOUUTIOSNZuaKQm2Krqd2AQzLNy+
	 ZzoVMKAXePD9w==
Content-Type: multipart/mixed; boundary="===============7527132546623287183=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <28ff0a701e78a62c807b7564e4332bb1412ee44fe28c133c173c668fb07dbd52@mail.kernel.org>
In-Reply-To: <20260306-linked-regs-and-propagate-precision-v1-1-18e859be570d@gmail.com>
References: <20260306-linked-regs-and-propagate-precision-v1-1-18e859be570d@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: collect only live registers in linked regs
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  7 Mar 2026 00:55:55 +0000 (UTC)

--===============7527132546623287183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

This commit fixes a bug introduced by commit 0fb3cf6110a5 ("bpf: use
register liveness information for func_states_equal"), which made
func_states_equal() filter register comparisons by live_regs_before
but did not update collect_linked_regs() to match. Should a Fixes:
tag be added?

Fixes: 0fb3cf6110a5 ("bpf: use register liveness information for func_states_equal")

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22787654290
--===============7527132546623287183==--

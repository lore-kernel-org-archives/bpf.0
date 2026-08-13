Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7799F3B8BD9
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657479; cv=none; b=uQYdVatZDsqFOEz+7LYLQnL58krLSaAMstiRfLmmxmtzIU3OrCqdJmtJnwf7jiVAAMdcu1eUdY+f5jjeaoqATLnuSjpUVVTB2Wnf+7bmjZUGqgRUa4OoTQdQqeqVKAnkliIZn/sDIpzgSWHR+3sfvh4mMz5JhVLr074QBqDwDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657479; c=relaxed/simple;
	bh=xSZtBk9DwUT7evC8nBXZA1uBDhcmghurB7Adoek8x3E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=USheSS/1y1Id7JOTSKGhNc4xhlkgr/4qnLSrS4MV5RlUdOQBdUvsBE5OzCdAGMhoe35MZXczUmK/BvseZqRGsJNeJLh8Ty9g49WHW6XgXWa24KbnR6AR/eJ/zWWBFbevfAe01PtmgR6Bx6nCqQ3Vqxio/VypgiTzKP3QjceUtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTlzlYU7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTlzlYU7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1131F000E9;
	Thu, 13 Aug 2026 21:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786657478;
	bh=Br0TOz7Ns8WQ2j9ZUlYGJKI40gYaKAYW9XoxOnBYsNc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NTlzlYU7bgyOSQk0Wo1WSVjcdBIjJotILUBFVgrhj1iySyRWbEjuAyuq2apvOGUyE
	 Nc2626NwfFchgVHIOxlslasj+ZuuM5C6ilz3R7Z7ytUoxYVQ6fI/zPhyNVgNgCqo1a
	 8bG5gqMedEP4uAjc8OCiLio+18BAUjIyKaBXw7ewRd8r3nHlaQrcxr0sEgH5jK1JHp
	 PXHqSnOfbE+RNscTw/Rh6bQ6nOPo2iP3G52p3jdVlLrJ8uvrJeb4N/eIH3ZrALrkpZ
	 BocmjMIAEKzM2bRTtmJa/jxCdXnEWVb4ja3/JO+S/0udWcH2b8H0rGDSQpserbVp7I
	 1SSO8UriUUnuQ==
Content-Type: multipart/mixed; boundary="===============8842438279431695634=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bee693df6e3b4ecbe8c7c1000f23ae44df9f79fbd08b99bfc3ca39d50f4ba48b@mail.kernel.org>
In-Reply-To: <20260813204032.644949-1-daniel@iogearbox.net>
References: <20260813204032.644949-1-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/4] bpf: Keep fault protection when merging pointer types
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,eddyz87@gmail.com
Cc: memxor@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 21:44:37 +0000 (UTC)

--===============8842438279431695634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit e49db69f3fc735b4b80a6b4b8a50b41285d42c00
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Keep fault protection when merging pointer types

When the same BPF_LDX instruction is reached through paths that yield
different pointer types, save_aux_ptr_type() merges them into a single
type which is later used by bpf_convert_ctx_accesses() to decide whether
the load has to be rewritten into a BPF_PROBE_MEM one.

Before commit f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
the merge only accepted two PTR_TO_BTF_ID pointers and unconditionally
fell back to PTR_TO_BTF_ID | PTR_UNTRUSTED, so the merged type was always
one that gets the BPF_PROBE_MEM rewrite. However, the mentioned commit
widened the merge to also cover a PTR_TO_MEM base and replaced the
fallback by a union of the PTR_UNTRUSTED and MEM_RDONLY flags.

The union can produce types which bpf_convert_ctx_accesses() does not
rewrite, and the load then stays a plain one without an exception table
entry, e.g.:

  - PTR_TO_MEM merged with PTR_TO_BTF_ID | PTR_UNTRUSTED
   => PTR_TO_MEM | PTR_UNTRUSTED but only the MEM_RDONLY variant is valid
  - PTR_TO_MEM merged with a plain PTR_TO_BTF_ID
   => PTR_TO_MEM dropping the rewrite the latter type would have gotten
  - PTR_TO_MEM | MEM_RDONLY merged with a plain PTR_TO_BTF_ID
   => PTR_TO_MEM | MEM_RDONLY which is not rewritten either since only
    its PTR_UNTRUSTED variant is

In all three cases a program can take the unsafe path at runtime with a
NULL or otherwise bad pointer and panic the kernel on the faulting load.
Fix it by normalizing the merged type: if either side needs the rewrite,
pick the one rewritten form the merged base type has.

Reuse the may_fault_on_deref() helper in is_load_acq_unsafe() as well to
avoid open coding, and trim the overly verbose comment which is more of
implementation detail of bpf_convert_ctx_accesses() anyway.

This isn't a bug, but there are a few readability issues in the changelog.
The sentence "pick the one rewritten form the merged base type has" is
hard to parse - could it be reworded to something like "pick the rewritten
form that exists for the merged base type"? Also, "which is more of
implementation detail of" is missing an article. Finally, the continuation
lines in the ASCII list use 3-space indentation under 2-space bullets, so
the '=>' lines don't align with the bullet text above them.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31743446421
--===============8842438279431695634==--

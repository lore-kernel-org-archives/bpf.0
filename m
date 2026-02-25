Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987A38F933;
	Wed, 25 Feb 2026 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014149; cv=none; b=CJQ4ze9lL5GrTaRW3Ah9GzUR0QF/AJ2V5LrkfxgO1ncCdmn+3w+8Am1rvva15Plax2rc+s71akkauLBOOidS/DPdMd/l3Br78iOIkzauciQC/v56CkN5qUrDtQvJtjWg5wHdDW4bJaUGwHN3SjLeBTkxuAxNun9RTu6iKYAWyo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014149; c=relaxed/simple;
	bh=CfYCszxAxhMS8qQHcBKjQOsNb8jic3AdWDNoOXYU7Ww=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AOpsVeJZCeuG/4e8wRcH0Vnk8Fg/OUjUcz6Jbs5uPmkk9yWZ3wwKwZE8UL8P0tp7v4DWCACtsMOCNBVLI0K//4TEx0eP4+cqeHGhWX0CthGeTSRwKPCEODRR3ZuKQwBfur08M/kM+tushcTbA1PQTNQTR/hmDdShVMiZ9OijAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMpXhKB4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMpXhKB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D9FC116D0;
	Wed, 25 Feb 2026 10:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772014148;
	bh=CfYCszxAxhMS8qQHcBKjQOsNb8jic3AdWDNoOXYU7Ww=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=DMpXhKB4qGxzb+D1CcsGhEUsVyKm5zQyt2oTv+K0n+xiuskqK70WNorSXPBNyDzIn
	 LE+fvyBih4PWZdGkWMsxtaJWOCXLQeUpHfqGDLwQpp5197J/k2s9YzyvbOcdfOuZ8V
	 eQ41qPMAokQU4EhIfjPyXv2uIxr7UbJpEg2HKkzQicnKWmqUuyPjCVhVebxoOuk+/s
	 BjfOBzLdpOmrmo9thx3aYW/ByQEwfXQ6P58p742bNdiFfyCYoRwf8zz+fMJIyv9SDH
	 84P0k9SV1Uid00hdmNrfrh2CUhqmLI2p12+orYjOMLu8tXH2zahnM00UjG1SYmHGaH
	 X9dlZoMEm3Vwg==
Content-Type: multipart/mixed; boundary="===============8254512922807785031=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <44a51c003ed5184e14c114c1b8327c16fba34aff50c2323bdadcd72de45f9920@mail.kernel.org>
In-Reply-To: <20260225091359.3299924-1-tabba@google.com>
References: <20260225091359.3299924-1-tabba@google.com>
Subject: Re: [PATCH v2] arm64: bpf: Fix UBSAN misaligned access in BPF JIT
From: bot+bpf-ci@kernel.org
To: tabba@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,puranjay@kernel.org,catalin.marinas@arm.com,will@kernel.org,bpf@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,xukuohai@huaweicloud.com,jakub@cloudflare.com,jpb@kernel.org,tabba@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 10:09:06 +0000 (UTC)

--===============8254512922807785031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: b2ad54e1533e9 ("bpf, arm64: Build branch-target-identification-enabled BPF trampolines")

The subject in this Fixes tag does not match the referenced commit.
Commit b2ad54e1533e has subject:

    "bpf, arm64: Implement bpf_arch_text_poke() for arm64"

The v1 of this patch had the correct subject, but it appears the
subject was inadvertently changed when respinning to v2.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22390726005

AI-authorship-score: low
AI-authorship-explanation: Natural patch evolution through mailing list review with v1 rejected and v2 adopting reviewer suggestion; minor human error in Fixes tag subject change is typical of manual respins.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Wrong commit subject in Fixes tag; the SHA is correct so tooling is unaffected, but the human-readable reference is inaccurate.

--===============8254512922807785031==--

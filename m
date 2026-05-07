Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39D344DB5
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 22:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191880; cv=none; b=Oog0dCc+7OFL9vtyc+ZkRl+XD3EcUgKDJdxw+A0J/e5nKysyGOiyyC584bjfqiCpOmije5JArJ5NhRtQ6KehRHlS0Za3j/0JYdxDmiISDKyYsWjUFyeaYXKbeqzGN5vBhpipiCVum73QYcDv14YHELWbyGS21v//RQ/X7ziGY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191880; c=relaxed/simple;
	bh=5AHYiQ556keOG2nYcRB1dEZjnXWwZr6k2F/l4iwPWcQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=vEik8r5sb4GhKG52PF/G2xh6FjpOEH9xNdhqUl9JsIlJlvotde3ZayUoRLjMZIhFKkbWg3NLp5QrzYqTYjGuWaWBDosnd/wDmzcro4mCfTXcYwxF9K/rE3GDD7IXq1jWqoq6iTRTLBD5/e6tkpkq6Ex8+N3kPSVC0oACBowxgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjcLKZqD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjcLKZqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2F6C2BCB2;
	Thu,  7 May 2026 22:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778191880;
	bh=5AHYiQ556keOG2nYcRB1dEZjnXWwZr6k2F/l4iwPWcQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kjcLKZqDTI3JXxtq6YCAUppnVISab82Wdsz20FqCjWz6VGuxLP7nF7U6IcOG4avgs
	 0zDe1zVRbfliMsi5yeGB+lAB5AlrNV/FszZrEDnOMO0LArqc432ePlxC/8LMxxOffi
	 BseyS8IgWq9jS3eHjMCGhDkrOFJgLU1ucq7mklUzzjDSXR1KcmDZScmo4WF+evfvJR
	 Y061zGbMj6jOm/GAOxoGSOdlPuINdAq0MaisVVRVreJur7W8rveHXWfCgdtUgPWlCn
	 2Eepq4sj33l2808YXQwLZ0EepiUBwhNIPykEAfWSGEtPqa2/KCXQfsx1+PIcGnOKn8
	 OXmdx1Uj2fODA==
Content-Type: multipart/mixed; boundary="===============4268321734759214111=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <08f7cab25b4acf6b4e71984b18fbfcf0754aec96742559fa689a6819302eb551@mail.kernel.org>
In-Reply-To: <20260507213018.1128602-1-yonghong.song@linux.dev>
References: <20260507213018.1128602-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 07/23] bpf: Add precision marking and backtracking for stack argument slots
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  7 May 2026 22:11:20 +0000 (UTC)

--===============4268321734759214111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 4c0111fe676cd1905f81c3bd7d7f87d41cc028f0
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Add precision marking and backtracking for stack argument slots

Extend the precision marking and backtracking infrastructure to
support stack argument slots (r11-based accesses). Without this,
precision demands for scalar values passed through stack arguments
are silently dropped, which could allow the verifier to incorrectly
prune states with different constant values in stack arg slots.

This commit fixes a bug but lacks a Fixes: tag. Looking at the commit
message, it addresses a verifier state pruning issue introduced when
stack arguments were first supported in commit c364b7a0f7ae ("bpf:
Support stack arguments for bpf functions").

Should this include: Fixes: c364b7a0f7ae ("bpf: Support stack arguments
for bpf functions")?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25523765323
--===============4268321734759214111==--

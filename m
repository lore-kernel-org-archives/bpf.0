Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D441345757
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191879; cv=none; b=YA5xoN/CPGegFIr/ZDOvnARKWcZg10u7UGlsfZZ/7qDzKHqeFq6TFe1Dn+a6Ak6Okw56KjSvchu0bRioZTnN+aIrJAJ97OiUSuRsrFpY3513HjksQk8v1jSd0KIYSpt40vQHNOd62DWFSgyvZYfwlwYVmeZ1wDuc9DBUQc6NtWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191879; c=relaxed/simple;
	bh=sfLDWw4sy9NVC3x2imEjX5t4HDah8J+xLnInU0/uH2A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gOHxYpC2vY2E6uDovH27WKdPoPi554zwu7+gLLr5P0rE1Q0jLHjvt0OQ00CTagN1f237Ss4LoDjtqVKfoQ3CKSwQuBS4L9yf9GB3y1k4ZRjblFakLgiqV7rOIqPQsoeHPAV0f0eYZhNlDngi1s8n1hcM8VKJC45ugtOK56SrWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nmra2m9F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nmra2m9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73FFC2BCB2;
	Thu,  7 May 2026 22:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778191878;
	bh=sfLDWw4sy9NVC3x2imEjX5t4HDah8J+xLnInU0/uH2A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Nmra2m9FdvGsq5Q0EVSRkJmx0zU4ezghRUU2HTmpUw0gWwqbjVClfjdkX6XESLQDY
	 f6PI40d6jyPAHNueZtWeh/NrKhTQxizTdMWI5q8KB/I6jTzF/SJhb/autUh0M+X9iE
	 VudKMzKGCWXoc5I0zQWVjzwBIepybqN37TH9kbPwqK8MA5WKKBCKCTti8omM8mD+hB
	 CnQvuoCCg5NXB4AncVcwSBzt6KtvjIZ//md8+cTzz6DaVdOVUVtCuwf4jPPo18KOlt
	 ZceY8kg51HpjgE5juUU7HcYKACMt8hj2GHSvjY6H/99WMd1A84BpLxTfhj5WUrBH75
	 bb3eVOW3QtjMg==
Content-Type: multipart/mixed; boundary="===============8568738931088906392=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <40b4fbd223c043b2a8d74fc2e5e57a59dda472f13279e8062792c84723cd5af8@mail.kernel.org>
In-Reply-To: <20260507213029.1130085-1-yonghong.song@linux.dev>
References: <20260507213029.1130085-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 09/23] bpf: Extend liveness analysis to track stack argument slots
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  7 May 2026 22:11:18 +0000 (UTC)

--===============8568738931088906392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 66a19f95afbdbdfe3c3c887c8656037ebcca1be1
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Extend liveness analysis to track stack argument slots

BPF_REG_PARAMS (R11) is at index MAX_BPF_REG, which is beyond the
register tracking arrays in const_fold.c and liveness.c. Handle it
explicitly to avoid out-of-bounds accesses.

Extend the arg tracking dataflow to cover stack arg slots. Otherwise,
pointers passed through stack args are invisible to liveness, causing
the pointed-to stack slots to be incorrectly poisoned.

This commit fixes a bug introduced in c364b7a0f7ae ("bpf: Support stack
arguments for bpf functions"). That earlier commit added support for
stack arguments but did not extend the liveness analysis to track them,
resulting in incorrect poisoning of stack slots when pointers are passed
through stack arguments.

Should this commit include a Fixes tag referencing c364b7a0f7ae? The
commit message describes fixing out-of-bounds accesses and incorrect
poisoning that were introduced by the stack argument support.

Suggested: Fixes: c364b7a0f7ae ("bpf: Support stack arguments for bpf functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25523765323
--===============8568738931088906392==--

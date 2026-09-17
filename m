Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D00466B1F
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641250; cv=none; b=ASboAon/zFGOlugEC2U433R+sNfI/OoCTDjN7ILuwpEe/FtnSQuEXe/5eWpLf3tuQxjM3wMDd6uVdI51RdD3l+zDLc/sh8NaOcY5c3XQCf/uFSvzrMHNan7R+DUhSlDzpkNAhDL8Te8Hrf5VmSfzFa1Q8e9PkdjHoSI/CgH2JH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641250; c=relaxed/simple;
	bh=y+r60gV1iyhWh+lrWwtNY7gXxNGcvj3Rtz9w0o1D3lE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=S01zS3BnmZYHIPyFAOl2lGc8PBUGgggKz1WlEIkifpCQ7llHkWm40jinTrSemNujFu1JIqrbXsE3R4BiHoTI9RJTULnm9yxy5EmGM7t7GOiQJ+HiSmxcKYfAo/RIAta9+W0gR6KAntOLnjXXwu8Sz/XNoSXSzobJiUeODZltFGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2cit9Fc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2cit9Fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5666B1F00893;
	Thu, 17 Sep 2026 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789641240;
	bh=JP2EdqEK6476rk6wVEbvB9xmoZf88rSiKDcKplOO724=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=f2cit9FcWBfxh/4loDykjyXjmcfprhNmrdLdrJI4PUQvdgebxbxruBNu2+YS0vh9R
	 txqgORgP5+QWdctAJdcKtFuOnwzTqCFEhgqSferGy7+oHLe+CETO70bVAOe5EQc2ys
	 Z5wR5JGhxwLesWsIYdWp5vaiL9BO6E6+IMnw/l1QOBd/XJXOg3xvAMS3gQVvIZ8lpP
	 rql+f4NkB809jjNp+vbs0oKM2d5uKUPKOG5ILqbi3IQd6SDbQdzJW7kdM98VPL8pRf
	 075Yuq9SUPUkwsieIzEbBKo7LYmWnL0YWz+B8hFFlDyKSNFhneZ0fdeZPJlhD2MbO/
	 Zey5LN+XTh7Ug==
Content-Type: multipart/mixed; boundary="===============7840322365097672416=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c3837291bd0336beb0ba3ccf00e69f2c408fba8f72d52294caf5e743cb539601@mail.kernel.org>
In-Reply-To: <20260917093928.48495-1-running910@gmail.com>
References: <20260917093928.48495-1-running910@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Guard link cleanup in fexit_bpf2bpf
From: bot+bpf-ci@kernel.org
To: running910@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,running910@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 10:34:00 +0000 (UTC)

--===============7840322365097672416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> test_fexit_bpf2bpf_common() can jump to the common cleanup path before
> the link array is allocated, for example if bpf_prog_get_info_by_fd()
> fails. The cleanup loop still indexes link[i] unconditionally, which can
> dereference a NULL pointer and hide the original failure.
>
> Guard the loop so the test reports the original failure instead.
>
> Signed-off-by: Zhixing Chen <running910@gmail.com>

This patch fixes a real NULL pointer dereference in existing test code.
The old cleanup loop unconditionally reads link[0] off a NULL base when
link == NULL, and every one of the 7 callers passes prog_cnt >= 1.

Should this include a Fixes: tag?  The buggy cleanup loop (accessing
link[i] without checking if link is NULL) was introduced in cd241b77f5b7.
This is checked mechanically by CI on the bpf list, so the tag should point
at the commit that actually introduced the bug:

  Fixes: cd241b77f5b7 ("adding ci files")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35207993886
--===============7840322365097672416==--

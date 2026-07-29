Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8813E024B;
	Wed, 29 Jul 2026 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367328; cv=none; b=LAwOUTN1mCQhGk4DfL9fu6PJnYUgpL+SEqtEW/dLp9QbDW8DpwNqVEKivTccCByrSgFiou753ByhIlVeUeJ03yTYXlBkXtIcxg5qdkPQ/nn2Glk3c2q0MWtQz1NaT5gr4+F5qH+bYb2mxe29gBjwkrA4la9TkIQiDCiJVICnP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367328; c=relaxed/simple;
	bh=Xy45rUtew1tuvisF77eUYR63ZJSLTXWJGkFjO5MAu2Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EfMh3ViRBEF1Uz3eMRglywr6nzA2qmT3FagtXYh3k0uXeKOUN5PoCd++aChf3xz1GaDgmb32HYcwDkQ0IiE+7caoFcefQON7YmD6fncb2/zSrz0TCSPWRXKEVoC4hYoD4MJAkJ/Db86lhq1z4coOLUvQBysV3kw6CjMm4fPdgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esP5wMLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esP5wMLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8592C1F000E9;
	Wed, 29 Jul 2026 23:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785367327;
	bh=CN254wpYvZtbq8sUbWx5jFepkYm3YYA/esEWQiGkpJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=esP5wMLNRu1/uEroQaaGDYLsrKNjS8eYx+klEMnzc3Y3h3OtN+I+XmXhJSPIu/Hdq
	 Kdo7GnVk71S8stnsYcf3GLy82QJgXyROYMOxjaCyeazYcFkXdjkfV1+3wHWYRQyYjW
	 +L9C6YCFx418S66YeJOwIRXWUqlFSKVHmCvhn0sPIXX2wFQpyxq5DiAFViBToaEztS
	 dBo3WlFz7l3eR9kioduVwQhkmUlrg7QttyHUBL/7JEnjeFD4jfE7NwqGvy0SlOTPM/
	 k0DR7qL5gTCLiZLSYkA+XOVVoZbEXtXpCYMSeIdadle1pzW7KGFjfpViRoKksJhvnF
	 ViSVfBDPrsr0w==
From: Nathan Chancellor <nathan@kernel.org>
To: nsc@kernel.org, Yafang Shao <laoar.shao@gmail.com>
Cc: linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260728024950.44946-1-laoar.shao@gmail.com>
References: <20260728024950.44946-1-laoar.shao@gmail.com>
Subject: Re: [PATCH v4] kbuild: rpm-pkg: Preserve BTF sections in kernel
 modules during debuginfo stripping
Message-Id: <178536731492.3649112.13944152410837051411.b4-ty@b4>
Date: Wed, 29 Jul 2026 16:21:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=791; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Xy45rUtew1tuvisF77eUYR63ZJSLTXWJGkFjO5MAu2Q=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFlZ3XJFwkfeMocfuLxij9aSDUyvn22s/LLdwe2G2NuFX
 q8fKp/+31HKwiDGxSArpshS/Vj1uKHhnLOMN05NgpnDygQyhIGLUwAmskCUkaHFW+nTE4mPzCU7
 HTczXxe1yNE+GmJz/bbvtXubL8nFmd5n+GdkxnXh/sWEsO1/OMVOcv27v6z3aPPi7a6V4UzFc/Z
 77WEEAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

On Tue, 28 Jul 2026 10:49:50 +0800, Yafang Shao wrote:
> kbuild: rpm-pkg: Preserve BTF sections in kernel modules during debuginfo stripping

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git kbuild-fixes-unstable

Thanks!

[1/1] kbuild: rpm-pkg: Preserve BTF sections in kernel modules during debuginfo stripping
      https://git.kernel.org/kbuild/c/e5a259d98823a

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted. Patches applied to an "unstable" branch are accepted pending
wider testing in -next and any post-commit review; they will generally
be moved to the main branch in a week if no issues are found.

Best regards,
-- 
Cheers,
Nathan



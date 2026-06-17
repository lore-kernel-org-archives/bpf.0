Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE259481A85;
	Wed, 17 Jun 2026 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712144; cv=none; b=Q4vxbBFYkaeB7DyNZgnPgXUk6tnDGeszZjJoQmdX9MN6OWsRlahc18wTshDUD7uk9Cw1XQNVB/80tmPf3nJHNz7/a7Zd9hFNcomPidiA0i0X1Un3Uy0F+BowmTyPiI+qlcV3Y2+aE/6Q5k7cCOgzQU18dEaDV+xWs8uPGsQR8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712144; c=relaxed/simple;
	bh=LOOK3Ax2+U5s+COFznkSh0iIRKsckBDMd7vWn2OhtqE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CBA4COTWwfNgm3P/B1Sl5e7yWh5n8KsXtXZDRadINBNMuSIn+rVslNr1zWsPXdsZh2fHRFeI01IaimHt/MgzyJWAkL6OqrFokcPwPT+OCvGg7RhqMrLzt5t0sa/mvy747UyJwJpYYL0cIS993LuNW3fdWnOk/Vafu4QeLx7L1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4/SJJ+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4/SJJ+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29AA1F000E9;
	Wed, 17 Jun 2026 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781712133;
	bh=5JH3aBmd+dEJ/OlpyLd6p/5ZSwevGj8hkc5VtZxzLx0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=j4/SJJ+CALrB1zdiJyg+ntxZ1g4ibWZa79lgXtoj4YP/UoROWxeyKNdclaeXkuWkW
	 ZJA79BbP9gRLR5TucTvhfwQ6KQR3T73I1G77T2tZL0zrofec/GIJ2Jw0vqvC7JAiUB
	 7KY+ghxLftZFVMDnskXtgKGZWS4Y/bB69wdmNT1KNY0hPKh8kh7IrDehbnGANz1ewj
	 eJqIEfwU96NEBebb4W3A5ewN36HL6RdLKzqq+ceEAYBO7dOJ8ajrOJUyirutcY/KRg
	 UAxvY1I3mFO4MjOr5XtheUP2Z38/mzqONZohu0+RqWs6/ArIx25VBn5rjDOfugVn7r
	 whBtQTKhEZlMA==
Content-Type: multipart/mixed; boundary="===============4488830804621448735=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e69f8ee202519923dfd2fae4e49d8fa31072503af7bb0895a13e4f1e981bea28@mail.kernel.org>
In-Reply-To: <20260617-f01-06-half-slot-pointer-spill-v2-2-42b9cdc3cf64@mails.tsinghua.edu.cn>
References: <20260617-f01-06-half-slot-pointer-spill-v2-2-42b9cdc3cf64@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Cover half-slot cleanup of pointer spills
From: bot+bpf-ci@kernel.org
To: gnq25@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,gnq25@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 17 Jun 2026 16:02:12 +0000 (UTC)

--===============4488830804621448735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: Cover half-slot cleanup of pointer spills
>
>     Add a verifier regression test for a pointer spill whose high half is
>     cleaned dead while the low half remains live. Force checkpoint creation
>     with BPF_F_TEST_STATE_FREQ and assert the verifier log reaches the
>     checkpoint and the subsequent 32-bit fill before rejecting the partial fill
>     from a non-scalar spill.
>
>     Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>     Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

This is a regression test for a verifier bug where a partial 32-bit fill
from a pointer spill whose high half was cleaned dead could read a
non-scalar stack slot past the register-fill check.

The half-slot cleanup that destroys the spilled_ptr metadata when the hi
half is dead was introduced in __clean_func_state() by:

  be23266b4a08 ("bpf: 4-byte precise clean_verifier_state")

Should this test carry a Fixes: tag pointing at that commit, matching the
accompanying fix?

  Fixes: be23266b4a08 ("bpf: 4-byte precise clean_verifier_state")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27700639579
--===============4488830804621448735==--

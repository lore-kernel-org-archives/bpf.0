Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5735B63B
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640977; cv=none; b=FdDaQTUS14zbAl1g0YE6Hd196Eus034A0G7NGWZga5s0cpbQ6jvR/3S8kmzzMN7yD+p41HwdRn7x24ajENZc8N4+XP5KV1XaIuywdwCkCt4z66TuYMMQ4tU4UxwgjWWQg0hgIUMJCwCpZUTM+MThgSSFKWnvgsb7J6p7YpxtqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640977; c=relaxed/simple;
	bh=kzTWGDncsQgI7vVv9OfP1LY8x87/ePi73VuH2QKocMs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IfUfEdf8IEJgNJDl4c5zuXoZPY2FYD06DT7GRtAdvjau1N9W9F889JcydYOAFrmoGlSqXp1mPFQb8sfmx1VUyDQQWfD82X5bDcPTSg0jFXJSVGkrBy5jN1Qr5DpBK5P7gkwd1iXI9qtsrKNztj1CwfAXoBz/0oQ3tKv3O4YA9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUc4Zahh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUc4Zahh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E50C4CEF7;
	Wed,  4 Mar 2026 16:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772640977;
	bh=kzTWGDncsQgI7vVv9OfP1LY8x87/ePi73VuH2QKocMs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=AUc4ZahhdOpu3CgAmHdgSJtJODMkDVVJFsZm4/aC0hjFcOIxHp1QBHYjkaRsb70He
	 OXsAhBMsGzqNnwloCf73/L2Qz7EcKzII2tGqNH26g0klaHl9qV2xDTGWEqOaAxJr29
	 Ii7npvpToFhhIsxx88c4oneYqwcyB4PhMDUst+TdXOR0iZsbUtwoX3eHOBwWKhOAEf
	 kh3cLg4TaRdFR+U3WBNp0WDAORIRoXGwQFxtphMGruq41ckmjhA+BfdN05rF0krUNg
	 MccF97lVzPHU+VxaDdoWSmBxDDCBvXq5PhwIloSJ1AHqB+0JKxFPVMm6Wztr9qNP5o
	 vhjsuxauJNkJg==
Content-Type: multipart/mixed; boundary="===============1947542225045088666=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <556525dfd6030cb7f9f2f0c4d8a8533ab1a3590e7e933efee602258b980ec66d@mail.kernel.org>
In-Reply-To: <20260304151932.177995-3-cupertino.miranda@oracle.com>
References: <20260304151932.177995-3-cupertino.miranda@oracle.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: tests to non_null ptr detection using register operand in JEQ/JNE
From: bot+bpf-ci@kernel.org
To: cupertino.miranda@oracle.com,bpf@vger.kernel.org
Cc: cupertino.miranda@oracle.com,david.faust@oracle.com,jose.marchesi@oracle.com,elena.zannoni@oracle.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 16:16:17 +0000 (UTC)

--===============1947542225045088666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The 5 added tests are copies of the already existing tests in the same
> file, but changed to use R3 instead of an immediate 0.

The commit message appears to be leftover from v1 of this patch.
The actual commit adds 2 tests (jeq_reg_reg_null_check and
jne_reg_reg_null_check), not 5, and uses R1 rather than R3.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22676623004
--===============1947542225045088666==--

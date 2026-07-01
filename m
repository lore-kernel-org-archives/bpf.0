Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF2A153BE9
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948944; cv=none; b=XMiNv+MXaWd+W43IxKFVPLb1Ny9ToP+6sE9UQRM3h1ZqEbfPJ+aXtMMM6Br9Q6/8969WlOMh8nZ5GpIZWiCCpHMXHvh7jZV+rUgcLWxCuIiRuQGOkv0NisAbtJYCOi8iEpi9Z2rOqa4UXMjkuvhyx0vJyDKaR5qt3GnZK+lp/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948944; c=relaxed/simple;
	bh=107HkT8yPSYE/wmfU/BfLEjqO6/6JX9NWJXR6+UF5OE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AFgyMluKrGpWOv7h5kglqUm9tXvciSV5yTXrkZ3sMQulRkE0VShTJ2IH+QImT95IBROqNgCsG01mWxXnpyNV9fNcAQBVYwmRbjoMcWnP9YITZESTZlr86e28KuWAbUB+4z7x9UN3CyvDehj0zLi3CuIa7RyklbBmxtZGqSXNHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bjpkts6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bjpkts6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B1A1F000E9;
	Wed,  1 Jul 2026 23:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782948943;
	bh=107HkT8yPSYE/wmfU/BfLEjqO6/6JX9NWJXR6+UF5OE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Bjpkts6MsK7NAvbWVzm3oS9WkznktwC7As578rniLuJNlJzCU4YGuVjwZ+dWrQHEf
	 6MvvBsSSuUcAvx3Bs61+12qC9eWQrDaK25SIae0/pC4ShBzWLZEoDaJITy78wXsCC7
	 7r5lrpOwADlF9eosQFLVXKBQcaQ8FDzvQzUUt/UnEBTSym8Y75q0qmV4bRLzsSpUnB
	 qi97kabIqCG/5XZfVMKAts0w8hx4VZGrCB7I2axFGPrzFLyulfUdlvf3uYDlGL3slj
	 h2LNI/PIX6TtgFgeLRWHCCp4QdCzf9hw+ix0vLEjo4wPcJn4ii5f4tJY5GHTuZ4w1t
	 lbpwEnNT9+QvA==
Content-Type: multipart/mixed; boundary="===============3746883498331062950=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c3449eb3bdb823fff558548a30773000a4bbe929f34501233466a91cd40269f1@mail.kernel.org>
In-Reply-To: <20260701225034.12628-4-emil@etsalapatis.com>
References: <20260701225034.12628-4-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 3/5] selftests/bpf: Add arena-based bitmap data structure
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,mattbobrowski@google.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 23:35:42 +0000 (UTC)

--===============3746883498331062950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add an arena-based word-aligned bitmap data struture. The
> structure is useful as a building block, e.g., sched-ext
> uses it to represent cpumask structures.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

this isn't a bug, but should "data struture" read "data structure"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28553504082
--===============3746883498331062950==--

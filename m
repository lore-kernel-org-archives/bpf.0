Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59235336885
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 02:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786848339; cv=none; b=Uu9ezcyrqLejeFDjciYdAv9oUNMfESPNnNutUNnwnMtt3TtP3yhIivhFw49iWYqYpOXe0tW3hUMWzK8MbxG8eyHQmqmYq1d5ImAAHDevJp7EYmkhOuDnlbwTPkcYQOBevhRazpZzDOLbWNb60XIaTXq9V2okB6ZIpQDRQkgwoRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786848339; c=relaxed/simple;
	bh=/NWK/rL+Ziaf/I81bvbBbZnBhKBmPQpvsaYjGKoKZ9c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Rst/Jh4Joqn2WUfH5sRoshuEg0uIWxF+Gp94cHx1X4Zk0vwDzN5AS2F2Dg+lI/28dzWRtjJbQrAHueHVfi+CJxec0OqoVBlHk+CAx7W9yFHuGPvZwXwvmGuaJyUgdBKMC8I5Y6UFQUg6uozupIMYHvSJL853K9OLGoQqPzqmqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3GzAZjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3GzAZjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E351F00A3A;
	Sun, 16 Aug 2026 02:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786848338;
	bh=/NWK/rL+Ziaf/I81bvbBbZnBhKBmPQpvsaYjGKoKZ9c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=S3GzAZjNOs3qxGFe3gPIgdkQJJf/KJpCHlsVqVU1LGF7MxXYrCo8QhxOyO+RvNBtt
	 U04TgA3DaZz+Kvhnc7U/l8L915Nz28iiVwaNk2pBJ88Wk0XdWIWlFnCvUPnOxjFSr9
	 nWbcgRv8tLfsVGLDUwkgngMKSo7+U6M1KwH7MsbSAn+FKLiU2SMUkZg0FghVNsojW0
	 kMQ/J2s+Ir2BAEdacqwaHN5hQDXhF3+FxHkPm6PdaNgHFyN0KBB/RBE22+gUuvYTVg
	 tXNsf68Ep/gJUdXk81LKm1xUjDpchXoEvBICjDH9ukyU2hGzj8t4b5MXCr7pMLE4o6
	 ggU1k6y+2t4Fg==
Content-Type: multipart/mixed; boundary="===============6029463034311986706=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d7d6ffd97c2a82ff6fd69c784d944a8458586008c5f01469bdb81091b08fb01f@mail.kernel.org>
In-Reply-To: <20260816015746.2632990-3-memxor@gmail.com>
References: <20260816015746.2632990-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 02/14] selftests/bpf: Test verifier stack-read diagnostic attribution
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 16 Aug 2026 02:45:37 +0000 (UTC)

--===============6029463034311986706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test verifier stack-read diagnostic attribution
>
> Verifier diagnostics distinguish uninitialized stack bytes from opaque
> dynptr, iterator, and IRQ-flag state, and identify variable-offset atomic
> stack accesses without changing the existing verbose messages.
>
> Add output assertions to the existing dynptr and iterator rejection
> cases. Add a direct IRQ-flag read and a variable-offset atomic stack
> access to cover the other classifications. Retain an assertion for the
> legacy helper-worded verbose message in the atomic test.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This isn't a bug, but would it be worth adding one assertion on the
retained uninitialized-stack-read report as well? The commit adds test
coverage for STACK_DYNPTR, STACK_ITER, STACK_IRQ_FLAG and the
variable-offset atomic path, but leaves the STACK_INVALID arm unpinned.
If a later refactor changes the uninitialized-read wording to reuse the
new verifier-managed state classification, the change would go unnoticed
in the test suite.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31921026518
--===============6029463034311986706==--

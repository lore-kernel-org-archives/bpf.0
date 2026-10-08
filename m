Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5073BD638
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448767; cv=none; b=Rvv7c1nPmYb7HTmlx5q0tiWsE53SWdFJfz+ILn1ivgzhCKNZAs/cOAyPsMyBTpXGgd64tv9pP7GnclsvkP+5Pi7J9Gw5HxQw3GKcgbx9Yg+gXYdAChSuGNAEOMdxGbZdZtFe8D5BncbylKpIXwmY5axNo65bRimKlZs4d2AyfJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448767; c=relaxed/simple;
	bh=SxYxhnQ/TPUstHjmkkcJGDuMGmgYJ3cmL7kwrcohX6k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tkpP+FR1c0d8yR0CikgCth7wyx4maE5qFZ/AhPmhW7RUOQzmSgq76EkIRCNNFk01784/GELZ2ttDpUGq3Ve+8LotcPEoNsYqPzXW7RJ9r2FrbIIGoF6SKCa4xDPI+Pqhivph41yKWvgUXVMtT10DQl+bIwOpKjVFKy4mytGdFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9hc+S2F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9hc+S2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101BD1F000FF;
	Thu,  8 Oct 2026 08:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791448766;
	bh=L/trNmiGC915w62Z96US2AdmCenGDeGFcUzX38JYj68=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=A9hc+S2FmDhN6yKxXCduGb5A9mCepWk5yPu89tx8FnrZucyL8V9rYo1S5t7GhAfTs
	 HaQ4yG4dPpTH+2eYrmeEAov8CuDmPcBBTIWfD3s7D185tKE+Eg99lSIc5JOkb+OKhK
	 eWNw8dObQ+Epq0QYNieBlq43N0ihxPtdKoA39KYWLxv5ehAB5Sp7YS0vnBBd4iIrhu
	 oP9Lk8q+P6mZEX3uBTcv5YagipVlG20YA1iuCVUjhBMyC7zK3fY3TgpLyrTGu/QvwP
	 TjvOX5htYhxL5+0PciAEm7M/ZYKLyDRRPafp8wBGp6vY2SN53XfGU93xsDW3PthH3j
	 IcVWMd5VJUcmQ==
Content-Type: multipart/mixed; boundary="===============5174336129054866377=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e886b1d0457c718b5b198c480ed1c5040db1a43391b3c56028b659be85a82031@mail.kernel.org>
In-Reply-To: <20261008075111.3003497-1-yonghong.song@linux.dev>
References: <20261008075111.3003497-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v9 14/23] bpf, arm64: Dispatch exception cleanup pads at run time
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  8 Oct 2026 08:39:24 +0000 (UTC)

--===============5174336129054866377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, arm64: Dispatch exception cleanup pads at run time

TL;DR: Commit message only, no code issues: the changelog should open with a
sentence saying what this does for arm64, and one bullet ("aux->epilogue_ip
and the native cleanup table") lacks a verb.

> bpf, arm64: Dispatch exception cleanup pads at run time
>
> - arch_bpf_stack_walk_ra(): walks the frame records with the kernel
>    unwinder, handing each return address to the consumer and storing a
>    new one back into the record it was read from. The first frame, whose
>    return into bpf_unwind() comes from the walk's own record, is
>    skipped.
>  - With CONFIG_ARM64_PTR_AUTH_KERNEL and a CPU that supports address
>    authentication, the new address is signed as the BPF prologue signs
>    the link register, with PACIASP and the record + 16 as modifier.
>  - aux->epilogue_ip and the native cleanup table.
>  - bpf_jit_supports_cleanup_pads() says yes, also with a shadow call
>    stack: only JITed frames' records are written, and JITed code keeps
>    no x18 copy of its return address.
>
> A pad needs no BTI: it is only reached as a return address.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

this isn't a bug, but could the changelog open with a sentence on what this
does for arm64, instead of starting directly with a bullet list?

Also, the bullet "aux->epilogue_ip and the native cleanup table." has no
verb.  Could it say what is done with them, for example that the JIT records
each function's epilogue address in aux->epilogue_ip and fills in the native
cleanup ranges once the image is final?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37747693645
--===============5174336129054866377==--

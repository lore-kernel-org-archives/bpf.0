Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792802490;
	b=pYaKKOXtkgKxot4sp1CxzjDP+QWmb9FIHkR0EJPngyTDD6xDW5NBjTWs7Bi/qzolrldS
	 Rx22U0gx+D7wSAYMTiIUKzBBFeoWmdhQ4s0+lusyPL7Zle6fOpzMN2rcKgCDfh3ujy3D6
	 9BPF787PToaj1aKE2mQqAf+SNaAPvPrF39p//3JXOOAEeaZIn88XNSZs61mcIbvxhDVij
	 5Yt4N5z/2K2BFbGgyCSxWCjIqv+TqkSOt/cA710mui2OMtS6MriF6XVQn1jbwp9FmhMJY
	 Udds8uuCYpKxDijM8K4NwccTKZNXoriyisThnmC1KD9U+0gnCYoSHtBgxIYvoFdD8MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792802490;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=QVpR9EMxkNGuvZQ0iCkHcLkfQGS1tYVWjUx2aAjyuL4=;
	b=A3ix/3n0Lf9+19BCxbhNFDHmeWHTE7hcTPH+NbRNP+k40yB4sJiI/f6xoP15awcX5c54
	 A5+AqdxeZV1sFiKy4GKjM6uF98YvD7uiP7FMq543nx5kBGPl0Urag6mhu/F+GvLtecgMk
	 Ol0wNlOFRb0brflJXFaylHsDoHr0GoyIWdHU8fpAje2PfOV1q3ErVfqySdaRjlL57zswq
	 O1hCNGc+Z0v+a1ogm7Yz0MAJ3pbu9AoCizGBfBcC8NUPcBRLJKgCejwxULUI31z3S4Oa/
	 sSf8gOhlIrckLyNo3uewrV/KJPIidwtZabn6CO16dZzydVLnB3Bl47YkZ4W6v8H9LJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Gd/at2Ya";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF004606A31B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gd/at2Ya
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014D31F01825;
	Sat, 24 Oct 2026 00:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792802489;
	bh=QVpR9EMxkNGuvZQ0iCkHcLkfQGS1tYVWjUx2aAjyuL4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Gd/at2YamVXspNZXYUwgftVs38uyW8Dq4nOgddtC6Xtt36qUfn/r4xhkZOFQRIs/+
	 fxWOZde2xpYWeADHbNrpVRlr4tUd2mQPrlv9/7NzD01Pu55JGv3cYEewCEl4WyUKhI
	 qwSLOpLTApIVYOFwqLvVKUbQeqNqHr7p248cnNC/EnaaHdMZ/TGgQDRWYYpEaXbWiY
	 esu2s5enPMnV5+5I6hwicLFewHmr5hpHDKYq4Huuic3O5d42T0x2jzhuFT41EfdRz1
	 6Tf4LM0eDEiRx57Hy6xX/KpbfB8Oa2VLSZbfpritS2VZibimMiNMrz6rhS1F7IyP44
	 qqkDXazGc0EVA==
Content-Type: multipart/mixed; boundary="===============7622743072109499011=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <dd3410a9758b6a7fc45924f9063c3a456a7e13c9bcb34211cf01540239993ef4@mail.kernel.org>
In-Reply-To: <20261023-scev-simpler-clamp-v1-6-d43a07eda7af@gmail.com>
References: <20261023-scev-simpler-clamp-v1-6-d43a07eda7af@gmail.com>
Subject: Re: [PATCH bpf-next 06/11] bpf: print 32-bit SCEV bounds as 32-bit numbers
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 24 Oct 2026 00:41:28 +0000 (UTC)

--===============7622743072109499011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: print 32-bit SCEV bounds as 32-bit numbers

TL;DR: Commit message only: a stray second subject line, "bpf: Simplify
printing of SCEV bounds", at the top of the body looks unintended and could
probably be dropped. Not a bug.

>     bpf: print 32-bit SCEV bounds as 32-bit numbers
>
>     bpf: Simplify printing of SCEV bounds
>
>     - Print large 32-bit bounds without sign extension.
>     - Omit 32-bit bounds when they coincide with 64-bit bounds.
>
>     Before:
>       loop header at ..., widening r0 to 0x80000000..0xffffffff (s32 0xffffffff80000000..-1) step 1
>       loop header at ..., widening r0 to 0..3 (s32 0..3) step 1
>
>     After:
>       loop header at ..., widening r0 to 0x80000000..0xffffffff (s32 0x80000000..-1) step 1
>       loop header at ..., widening r0 to 0..3 step 1
>
>     Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

This isn't a bug, but is the line "bpf: Simplify printing of SCEV bounds" at
the top of the commit message body meant to be there?  It reads like a second
subject line that differs from the real subject, and could probably be
dropped.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40044354980
--===============7622743072109499011==--

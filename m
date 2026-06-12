Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7028C2A1;
	Fri, 12 Jun 2026 05:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781240627; cv=none; b=qN3iDt8KE8luQqZ4jKQ4kngR/db9VoaTU6wos8SWwxJ7CeHmSsMNVRhWUpvBiMRH+zTidZ/tpmz9CreDUdqVVoyiKIdgMzChHYpEbRhIZKnTABi5hM7QaC4RzMuJbK+rMIZwOF1xJ1OnK32VXMq0ZkYUSWi21SqOTCznFeCoJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781240627; c=relaxed/simple;
	bh=TLlDgusTqFVwHmzy3B4RA1hNhQ5jRT0SrmoMOmabaJc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FOp2MBBXWQuFabTxcKg83DwDi8p6QXoAT5eEQNEnjyesEl40FiBSZ3eKRQcaMpOI+7jBOcIh8116V3Al5CDWtq/ipJ+eIEXElqpG75QykdPeuWISKkeDF0x0ixHL0/6TznnZtuo89B//ScLex0iRGt+UgBxonNFTk4QMHE1euwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noA2WqGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noA2WqGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3731F00ACA;
	Fri, 12 Jun 2026 05:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781240625;
	bh=UNJ5PYKkSQSj8+UOF/vUH1O6W4GxrUeFtwzQS+J4U6k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=noA2WqGdqEcIAlcukkHkx35J3XcZyRG5Gc75rdZTWWj977xFnl+9a3ITtf41gE9Xa
	 CMQ5kIWiBl3bbKtXCoiNlckD+7fjflXaokUnenh2ue8FJJ5Zc+969fL0KWA3APUVEB
	 RUwqxHZLdyQ9rdVbXAXbkH0Dy95/78U0S4W3R9CHZ6tBHKNWs7M7DFbYES1GqzWdrX
	 +TwHU9NAj+7Z0nadJ+oQ4efgOMhyXnEhdn5DLTZBhvi27tjk7ehAVPWJhgOLhCZgSs
	 UwdFHldhFFjFA8x89snyxfrd/J5SitOsnCgBgrjIJ9RaujRsfUjXTtiZiVqtivTuoF
	 XjgF0RvpWZiYQ==
Content-Type: multipart/mixed; boundary="===============3457443008343983732=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <09d6933ac4873b9888f07593530c7fba6b3e525a643b90c16b113c09617fe2e3@mail.kernel.org>
In-Reply-To: <20260611-bpf-ringbuf-callback-v1-1-c32b6cb6ce40@kernel.org>
References: <20260611-bpf-ringbuf-callback-v1-1-c32b6cb6ce40@kernel.org>
Subject: Re: [PATCH] libbpf: Allow callbacks at consumption time
From: bot+bpf-ci@kernel.org
To: tamird@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,tamird@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 12 Jun 2026 05:03:45 +0000 (UTC)

--===============3457443008343983732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     libbpf: Allow callbacks at consumption time
>
>     Ring buffer callbacks and contexts are fixed when each ring is added to
>     a manager. Callers that drain records into per-operation state, such as
>     a bounded destination buffer, must therefore keep mutable dispatch state
>     alive for the lifetime of the manager or rebuild it for each operation.
>
>     Add bounded manager and per-ring consumption APIs that take a callback
>     and context for one operation. The supplied callback overrides the
>     configured callback without changing it. This also allows managers used
>     only through the new APIs to be created without a setup-time callback.
>
>     Make zero-record requests return without invoking callbacks so all
>     bounded consumption APIs preserve their bound.
>
>     Signed-off-by: Tamir Duberstein <tamird@kernel.org>

Part of this change looks like a bug fix.  The early return added to
ringbuf_process_ring():

	if (n == 0)
		return 0;

makes a request for zero records return without consuming or dispatching
anything.  Before this, the cnt >= n limit was only checked after the
sample callback ran, so an n == 0 request still consumed and dispatched
one record and violated the requested bound.

That bound-violation behavior came in with the bounded consumption APIs
ring_buffer__consume_n() / ring__consume_n() and the n parameter on
ringbuf_process_ring().  Should this carry:

  Fixes: 4d22ea94ea33 ("libbpf: Add ring__consume_n / ring_buffer__consume_n")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27394962126
--===============3457443008343983732==--

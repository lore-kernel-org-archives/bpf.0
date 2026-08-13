Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1148CD47;
	Thu, 13 Aug 2026 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638379; cv=none; b=FRQ+2/EHo+eselomqoAsnylQfIyWyHVcCuoLUSaX9dzSzlbTt1LuU/mv478GXL1L3d7rL8epbg4R99vO/py74oJSGGIrz5u6xOaKM16sWX603gYZkQPJvuvZKtP1B874ATF8fa5F+vrUHETaaLqRO+DjUXQz4cmCOmBKMj/hleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638379; c=relaxed/simple;
	bh=uB5s1jQ3hiFuQFX0vrBKBDHwWCQSVzTK5nq5aXRLYbg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TgY4IT33wtLYVzB8vBD06XjV7r+Y0NA9HmrWYvE2hFwcvtKqoNTN4KBcAn1kvANshC6s9eBBCwxtE0I4lbO2KR8nShbWlI17cuCV/nbDFzp7w0IitrV1W/lmlWMCoddkokQqE47zzOTZWB1M+4Bx3yOlcwJx7bKj3mFEObbYIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkLSpAzM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkLSpAzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57ED1F000E9;
	Thu, 13 Aug 2026 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638375;
	bh=uB5s1jQ3hiFuQFX0vrBKBDHwWCQSVzTK5nq5aXRLYbg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MkLSpAzMxc3JlGi9OjgaJ0EZKy2i4Vztl1FVOurafU5Yxc9JxMfJORX0Ieo8KQ3Aa
	 BY6KKY9GPQjDBmsw+5qZOsO1vjNjw5FM3Yoi28h5E0vWHnnRDOYRiUWzAQ+Q9MHqfk
	 5uC1Paim3k41NudwjT9QWQHhXuWyj7t2YsotwmQrMzimWOWAPn4f+o5DIw6v3B9yPw
	 cgvgcG85hGOhGlOuz0L8vqqBV/AZNIDdIYeS0a2z3Y9mjU9q12oSw6Mq6Ar2UTZyto
	 t6sfNhdagm7SuFGbwTnA2r74MXaioZn78k34MvuQqKnRqcr6ch6gbNufZtWij8R9yp
	 I2h8BqRs3umsg==
Content-Type: multipart/mixed; boundary="===============5959896170807582759=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c235a89df142e86e70f38a91acc5c3ec9e64cba2ae7539df9696150bf8ea3d66@mail.kernel.org>
In-Reply-To: <20260813152324.97937-3-leon.hwang@linux.dev>
References: <20260813152324.97937-3-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v12 02/10] bpf: Factor out check_map_mem_read helper in verifier
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 16:26:14 +0000 (UTC)

--===============5959896170807582759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> In the next commit, percpu_array map will add map_direct_value_addr
> support.
> IOW, it will add a map_type check in the iff condition of the
> bpf_map_direct_read() code block, which will reduce the code block
> readability.
> Hence, factor out check_map_mem_read helper to improve the readability,
> and the maintainability for the percpu_array map case.

This isn't a bug, but did 'the iff condition' mean 'the if condition'
guarding the bpf_map_direct_read() call? And since this looks like a pure
code motion, would it be worth adding a 'No functional change intended.'
line so reviewers know what to expect?

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31716447858
--===============5959896170807582759==--

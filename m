Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB5E399031
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786664318; cv=none; b=e1yx1u0D1yhpZAR65OWveXK1QHg3yikwiaZgw/il/YEDXoEgA1+G093bO8AAjyD9gQdrHCS63XWquzwrqM6tpZS7Y15K2Y4wl1Alws0gkAhbGKNxf34zQY4j9uOlk8c59eyDJqCO5kX43/KAIlXHMI+KI3hQDGxUfBEEok62f3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786664318; c=relaxed/simple;
	bh=o8lZlQrm+jkwJpWJr6gVxavM26GcLNsZbeRqfwXLjeI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IKc39I9dOFqGuBdx4mRH8TuDWew/zbyZY0rV+hTvtnX+EkeJHfuBnHC8iVKcP3U8vC3YqN840gArydqViVz5a94xtgSt2Mibhag/C0R7BRYZDEwo8J/bHAN1AHjaeiQ8xrged2nLD1SED7rJLgwCnsxiVoZvpcsI8nmGpf9jCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0zZeJBD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0zZeJBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157FA1F000E9;
	Thu, 13 Aug 2026 23:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786664316;
	bh=o8lZlQrm+jkwJpWJr6gVxavM26GcLNsZbeRqfwXLjeI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=c0zZeJBD4QI6waeiEtudVFZCUJFKUcp4s8uVWn4Ahm8qUmzz3rs7gjah4OlsNz7Cj
	 Q79UJhG32GHv0rrdFxD+RdnC82tsKR5J4678iiibe91HAM9/4TNoTdybbe0PiDSbB5
	 kmQ3tqrVGZGpJXN4jlM5aDuwd/WX9widjnHzCTPsvRJU/UNIUROKPq6M89tgsy7TTw
	 NUapc+uwGrzg1Uzi3pX+4BNrdKrpGxSTRCnDmzpuHAeVYpE3YsvB9w4Y6GWrl4zH+f
	 6YDMBwEJrKhgvRuDIQCLIAoW0VDQ+UIrT4uM8wKNmYJNo7Z3eovo2O5j35UUddFuqV
	 lWGMmbL4aJMpg==
Content-Type: multipart/mixed; boundary="===============7014200611460179976=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6142836b7397cc1eac282de8416547c479dc8b2efc514f2b3873db36ff00f5bf@mail.kernel.org>
In-Reply-To: <20260811-veristat-filter-fix-v2-3-6c234c4cd6ef@gmail.com>
References: <20260811-veristat-filter-fix-v2-3-6c234c4cd6ef@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: guarantee zero termination for veristat test buffers
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 23:38:36 +0000 (UTC)

--===============7014200611460179976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: guarantee zero termination for veristat test buffers
>
> In veristat tests replace direct read() calls with calls to
> read_output() utility function, which:
> - guarantees that the input buffer is zero terminated;
> - asserts that read operation succeeded.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

This looks like a bug fix rather than just a cleanup. The pre-existing
code called read() on a buffer that was never zero terminated, then passed
it to __CHECK_STR() which expands to strstr(). Because init_fixture() and
teardown_fixture() reuse the same malloc()'d buffer across subtests,
strstr() could match text from a previous run and report a false PASS, or
read past the buffer end.

Should this include a Fixes tag pointing to the commit that added the
veristat subtests with the unterminated read() calls?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31753097393
--===============7014200611460179976==--

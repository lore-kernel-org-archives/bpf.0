Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6C18D636;
	Thu, 23 Jul 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800117; cv=none; b=rHqhT1BOXlq3BscQHPZU/gT2Fh9ySw7XQ6KQhQaH5fPNFVPxZUDqOFMHSBDI1CvyTjjAcREvYh/WKsG5GalgNGDLgoDKqWNPzhrmS3+2skm3aMXMLq2U/i2uzYiCLL4uBJ2ddKMi7+ueEMEQwfJ0zssecz0btvHzpZodI4gZT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800117; c=relaxed/simple;
	bh=H/+4S+fv6QO2xnc1ySQL8eb3xrPv51YPvcIph5XLI48=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=myz7E5BwfrkIc8V92cLcVpOfWYvB4qLK5jqrqvau9FOIohuLktvdWPo6I5fCxIi83GlL3VQfkilh5oRfozbuF/7Fbvwlzf6l+hm/nik4gyhOp/4OaVgysQe7EkKQUVBcZrJ6kNgZt72PtfJXX/lnpnsqdxX9TzW2FJO9w5rNIKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHSmSnn+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHSmSnn+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5484A1F000E9;
	Thu, 23 Jul 2026 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784800115;
	bh=+dWL2WyLdza5agh1ICZ7Nx+Hq+qtUv/yXiwZFwWI/ys=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HHSmSnn+/HNACtFMA+wD03tEujNgmNnlQpM3Yduz/XbJy2ltfHbcnGqeYRY0xE7ik
	 9thWpb0RzHaYhYtRa5hVizMGFDj9kIH24LstX3OQgwKr8dOKImV7+k6JB4VtIZFl7/
	 1U1xvjGZ8Y9O6PddLMH/JyAa3z+EteUzHvIVGqrP3m1bxZ0wvivYJuVSFR52+h7cvg
	 YBC2Yx/3zSzpYpf29nGj80PA0ivBbnxBY6oiikOR3zHMzDCDfTsjTNRBjViZFThaxY
	 VMsIy1bZfz9BYNBEKzBb4Z7hlsRkMpRc6Z6Kxshsr0DgW6K9jI/NJPqfbEb8MR6PDG
	 TBj1FBNw8cvpA==
Content-Type: multipart/mixed; boundary="===============4855712811431053212=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f95518d44faf4ae8e76c203ce75b47318a411790f7a06601d6c1ff9b0e88b562@mail.kernel.org>
In-Reply-To: <20260723085100.482147-5-yangfeng59949@163.com>
References: <20260723085100.482147-5-yangfeng59949@163.com>
Subject: Re: [PATCH v3 bpf-next 4/5] selftests/bpf: Use calloc to allocate subtest_states
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 23 Jul 2026 09:48:34 +0000 (UTC)

--===============4855712811431053212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: Use calloc to allocate subtest_states
>
>     An early return triggered by read_prog_test_msg leaves uninitialized elements,
>     which leads to memory corruption during free_test_states cleanup.
>
>     Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

This looks like a fix for a memory corruption bug in
dispatch_thread_send_subtests().  The uninitialized elements that
free_test_states() later frees were introduced when the malloc() plus
per-element memset() allocation was added.  Should this include:

  Fixes: 0925225956bb ("bpf/selftests: Add granular subtest output for prog_test")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29993688332
--===============4855712811431053212==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E687390C8C
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782186862; cv=none; b=ZSjTKscK2cCbqT7XdZQhyKiKUOFkK6FmYOz3b4SwMPr6forlo1KkJL+lCPJLZleooZuJnWakQSLablLemprEAQwOnFTXAyMXj+ebythMQffrm5ysIwM+CTkbIaURtoOzDGLLHIjO1PDIf+h4s78G9CESo1RZ5lVBxB85Ub6xV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782186862; c=relaxed/simple;
	bh=bqc7hbd84zHw2xgQzJtB6diKTyDorPiQE9EbvGT71U8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b3hR+hyx8CuqLtNNtcCbdTG+VLnGVS6LTtY+kwY+NlDIRLf5qvPLKv6M+Tw2crypFokXo9rDeEdrq258adGe7MQIt/n3Aalog+0cSBKap9OD72uK3lg2MAo5rjq1CmXQ/cEFwKtXtY5iZN3hErObX/kyuE77GhJtJ4S+bwcUHeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD4CTS3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD4CTS3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA3B1F000E9;
	Tue, 23 Jun 2026 03:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782186851;
	bh=d2nvMDFpk98qS9RDDG854lnFXkfTp5tuXAwh1i9+bhg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aD4CTS3GGl8HOeoovn8/vfX2uXshLwLgC8ZNUFYirxQCIM5A2w9vbrjhauUM1RzOg
	 +J1tV/7si5iRJO7gDvk1sMFCXxk/Qa1/+/Ecj3yggckD7zqy6acjxz8ZQ7aaKngHld
	 Z6e+7bCGu+D7znHUS0XjnYMVRWVvCWUb8LgrSPjtbOtWCK2TrV62EwWDDrh2Gjku+p
	 5e5FvA9Jm+ZYjZ2v1zqoJHZWrjhNoOUJl3oj9WZPYkjsPX7/Cr19LbO0bt0okwoZDe
	 sTKbn2y9WZqtl4Yo6z14LxuWBU0ECeBuoLR/qUh4iR+xFYPRQ6clzXITdM1WqY+tix
	 lIz36pQ0kXm/Q==
Content-Type: multipart/mixed; boundary="===============1453111805496538725=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <56f7441bfbf02a45e40a978ce64992b2c29fc68f72f4a74f9b7daf2bfc893a70@mail.kernel.org>
In-Reply-To: <20260623030803.44798-2-lange_tang@163.com>
References: <20260623030803.44798-2-lange_tang@163.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: add bpf_memcmp kfunc
From: bot+bpf-ci@kernel.org
To: lange_tang@163.com,ast@kernel.org,andrii@kernel.org
Cc: yonghong.song@linux.dev,jolsa@kernel.org,bpf@vger.kernel.org,tanglongjun@kylinos.cn,lange_tang@163.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 03:54:11 +0000 (UTC)

--===============1453111805496538725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit ed9698292695c1294690b0b42df1c4b26e8df6a7
> Author: Longjun Tang <tanglongjun@kylinos.cn>
> Date:   Tue Jun 23 11:07:58 2026 +0800
>
>     bpf: add bpf_memcmp kfunc
>
>     Add bpf_memcmp() for binary memory comparison. Unlike bpf_strcmp,
>     null bytes do not terminate the comparison. Returns 0, -1, or 1.
>     Registered in common_btf_ids.
>
>     Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>

The commit message explains what bpf_memcmp() does but doesn't explain
why it's needed. What use case or BPF program requires binary memory
comparison that can't be achieved with existing helpers?

Reference: https://lore.kernel.org/bpf/CAADnVQJTXdNUsLxEHZPg9V356XfuqrSTwSE3W9EaOuMjMznMEA@mail.gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28000096945
--===============1453111805496538725==--

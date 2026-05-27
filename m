Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB43E3D83;
	Wed, 27 May 2026 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885479; cv=none; b=LWnTDzexPKYYTWaHBefXYraLKaj3yXDuGB3vics/7HTR4/puV8t1RB74uHMb99OqSFkimMjB/xIrxwOcsWmT/0s3Ep6Fn+9HNwpL+7X5+henw40UrGVaseUbl/hrxHXxVfGPXvWk33XMj6uP975QypLUZQgjIEZRQtu2PODiY48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885479; c=relaxed/simple;
	bh=eidRWk/WUKUSMHMKd3qKkLtQcvZtOuBd44sloKptWAE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JxMJ8U9I2ivSFugb/SQA1iWlYsJQpOWQFzZ5aCNabeLqYRNbnJYvDh6sIj4ErK27bPZHg2hKslgi0pX17NbubPJ9dRotj3tSHHfvu7sXnQXem3cCg7g7DoAGTeW3TZ+r73wDTqhFO2pNZcKZVZU1Evhyz/IxLb9jpeMX/UZ4LTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeqJMXRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeqJMXRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9471F000E9;
	Wed, 27 May 2026 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779885478;
	bh=5NZA+PAzS8eu7zlaYNoF3xrJWofY7sLAXE9fErm9cxk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jeqJMXRuuGFwFMbI8R9ePtZZLy2g7lqqee2ddHydOcdp6910htXK+eGNj0oNqFDUN
	 fAtBRkiqNU2266RzKTpHYyFSua53t1U1NTTvuHaYuR3K177lE2/G13e6yXb37ZrPLP
	 HbDXUJ4O4VaxPSy22HyhiOSeUaxmCGRWQZdM0WbHDGa0li2nyQgBTMEF8RhlwF+A9f
	 kmNSRU800AbegM9G7tvjwT8FzT4PWifo6Zb8g6onay+iV1fns5ILfc/W7s/NYCDICJ
	 /9ySUGbXV7PLEFmI6f4lWZa0AXt9gskyqW4yn2xUmNvyBrUSjXiItlahLKdIlqym3y
	 wsnsF4anXFW0A==
Content-Type: multipart/mixed; boundary="===============5919305565738034012=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5eed7ff1e8224073bea93c1feb0962a799047fa795fafb657115c866e5fc0df1@mail.kernel.org>
In-Reply-To: <20260527113951.46265-2-jolsa@kernel.org>
References: <20260527113951.46265-2-jolsa@kernel.org>
Subject: Re: [PATCHv6 bpf-next 01/29] ftrace: Add ftrace_hash_count function
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 27 May 2026 12:37:58 +0000 (UTC)

--===============5919305565738034012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 28b30c6f1031..282da661f131 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -551,6 +551,8 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
>
>  void ftrace_stub_direct_tramp(void);
>
> +unsigned long ftrace_hash_count(struct ftrace_hash *hash);
> +
>  #else
>  struct ftrace_ops;
>  static inline unsigned long ftrace_find_rec_direct(unsigned long ip)

Is a fallback stub needed here? The function is declared under
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS but other direct call functions in
this header provide static inline fallbacks in the #else block. If an external
caller uses this function on a kernel configured without direct calls, would
this cause a build failure due to an implicit declaration?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26509800686
--===============5919305565738034012==--

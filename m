Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961091;
	b=C595MGubDAb/uq1fVGHZQt663tk8jedKfzKklg+KfYwe3MxXg4jQHbTGd/CjGOPiY/O4
	 bu8B4RhrEWEYQ0nG7JVUQSLAa3TMPx1SFJBrgh1mLG4Ok3lefROJKWS+iuF3YNuEiClNE
	 +CzuCTVrZ1ZxaHpfbQ8SAenC8ZYB9M17FB+HUSlOFQA7BdX6RJiNpSSDhr+jE5No/I/iJ
	 1YkMsXfiagR5Iw7BCHXyIsGiJr2bpyMThmRQN+gUdlO+PW7dpA8rPXrglxDvgPtQtzP+o
	 gVXAGnfu1U6M1muIFaz+T5JolgCyPyqxSKSapRCzfn4vMyGxuuCJaH9HhwMvswXQs0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961091;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=j3r1sGel62TclXy0kAZrwC00YPbtdZixA5zZLRWcoo4=;
	b=lKJgHsvbaYW7I7jd/66iCkpb+AOk12yWSp1xF9ljizKKiX6gFOIGAU/1R8OnUz6ybME9
	 K+6N/GNh7x0z+bmxeaUbqWj2AQKLbuhkoypuoUdUxF378wfdrI3YJxKbiCZyxLxlHZR8p
	 RQQUsJ3hqQya3jAtrJminDnRVZuVd0ixrhoR6TePapYAqoHhB5HrYjvaqMWV7Cwx60KBE
	 3rU1v8lAXxndYy0XgRHX22BLVEg3MD9nmzdNp7YlocyNo/b78xn7LlCzGzy7CpGecDB91
	 eN6K6AASgZRoHmz2qTe4HgU4+OLNX1LmJupLIjsyb1Tzf0X2sY3VMeOqlwzqZgmPFEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAZzv5Qr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898B606A32F
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAZzv5Qr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0161F0089F;
	Fri,  6 Nov 2026 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793961090;
	bh=j3r1sGel62TclXy0kAZrwC00YPbtdZixA5zZLRWcoo4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lAZzv5Qr3etzu/N7gQZj73zjEktYBbxNF46fsfUi9spQrCuc1WEKb8YKKhyD9aRwW
	 /cRGRa29CKO1lKd9ZWHQ6AYnmUifRuaOtuaFhI8iuekzdHFD1oxSnGvcv5bUEnEvJ8
	 dI3ZUEwLzJo/Stlk3FEW7cuGzTNW8oy0CrhW/ft8Kv2c/hALmrDnPJ9bGRYAvhEp01
	 7CsF8bTwDLdIUgRph7wVTg7Sr+P++wFn9GgYfp1GYSTItBJ7Q5V8GYwocSdO6jPD2N
	 2TJ0FNNABVuM9AQcs0t7foSiJN+sTyBYiyhvaFL4FfoOR03OeY48YZYgwu3mc6pdbu
	 GjLur+s+QQzNQ==
Content-Type: multipart/mixed; boundary="===============8248426033563057875=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <992fb2ab1d81eb0b16dde3266110ef6c1ff1664cae8377e04be55feef980bce3@mail.kernel.org>
In-Reply-To: <20261106095747.471718-7-luyun_611@163.com>
References: <20261106095747.471718-7-luyun_611@163.com>
Subject: Re: [PATCH bpf-next v2 6/8] selftests/bpf: Check bpf_wq value membership
From: bot+bpf-ci@kernel.org
To: luyun_611@163.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 10:31:30 +0000 (UTC)

--===============8248426033563057875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Check bpf_wq value membership

TL;DR: Nit only, in the bpf_wq membership selftest: DEFINE_WQ_MAP() is
instantiated just once, so plain functions with a single callback counter
would be simpler and give clearer verifier logs.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_wq_membership.c b/tools/testing/selftests/bpf/progs/bpf_wq_membership.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_wq_membership.c

[ ... ]

> +#define DEFINE_WQ_MAP(map_sym, value_type)				\
> +static int map_sym##_cb(void *map, int *key, void *value)		\
> +{									\
> +	value_type *v = value;						\
> +									\
> +	__sync_fetch_and_add(&cb_count[v->cookie & (CB_SLOTS - 1)], 1);	\
> +	return 0;							\
> +}									\
> +									\
> +SEC("syscall")								\
> [ ... ]

> +DEFINE_WQ_MAP(values, struct wq_value)

This isn't a bug, but DEFINE_WQ_MAP() is expanded only once, as
DEFINE_WQ_MAP(values, struct wq_value), and every run_cmd() call in
prog_tests/bpf_wq_membership.c passes cookie 1.

Since the macro is only ever instantiated for the one values map, could
values_run() and values_cb() be written as ordinary functions with a single
callback counter, the way progs/task_work_membership.c does?

That would also make verifier logs point at the failing statement instead of
at the DEFINE_WQ_MAP(values, struct wq_value) line.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42200504781
--===============8248426033563057875==--

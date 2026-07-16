Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C8F3BCD2B;
	Thu, 16 Jul 2026 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188730; cv=none; b=CTMQLrFgL6l5DGKqXzSG5TpSpWrTlRwfj/H/Nlpg9UKmHnEELS/HzT9jz7S7UHlBzdc6LoY8ANXOdFBTAm6miWwNOtyXaJKzioNwypzPNaul+NgiWeXCb8oareoTL2UC2G3KMh3CbxNHmaMK8p/ERQOupykjzHi0MbXW3/hywpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188730; c=relaxed/simple;
	bh=XFGB9EYTJwH+N4BI/qhn6r7GPkURnLDExNdsrN16I9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lh9fXjHd4qdqritx549R3O7heA6kaf86CEGvQ2xzj+7pOOa5zqcuLUxirh1SPlyfhYUjdw0YJNwR/Zb64oaj95LlK00qgu84sHcxpTLGJqET41dRYVcwkxfNQTR2fPp6XOYiHTLg209XVxubvaubzZtjqcplWRAHdlygkPWs6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWKRQEdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWKRQEdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7F01F000E9;
	Thu, 16 Jul 2026 07:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188729;
	bh=XFGB9EYTJwH+N4BI/qhn6r7GPkURnLDExNdsrN16I9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=QWKRQEdDiRTpwlxFhKtRwDV6MX9vBuTKRz3k1VfevFlBG+b6rXCBDO5CZjsL8QqL7
	 d0dN1XFfBltaKe56b6y/0CbtnFP/SVnL67XU/txpIidjorkHlqvlPlcT4Qfs2B4DG7
	 x83SrrwBpmXQBQFS3NOYjXxW8J/BdjYCC5EP0mckkD0maDzYCNuWSRPZjd+MNefeYx
	 ukrVcR4hwYZr37KxVQ7ksFbjeyrwht3BgI8zYwuSsjkUJShdaEcDWXYkyHjU8aAbzP
	 QnmTSfrxyrdp2g3Vy1UpCgAzPU8uB7D5Q/RXzgTUJ0FhetG7DLi1fVBjaCFJM6bSyx
	 XJ2XEJ/5LGx8A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Luke Nelson
 <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Pu Lehui
 <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan
 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Feng Jiang
 <jiangfeng@kylinos.cn>
Subject: Re: [PATCH v3 2/2] selftests/bpf: enable timed may_goto tests for
 riscv64
In-Reply-To: <20260715-riscv-bpf-timed-may-goto-v3-2-cf2a9c3d843f@kylinos.cn>
References: <20260715-riscv-bpf-timed-may-goto-v3-0-cf2a9c3d843f@kylinos.cn>
 <20260715-riscv-bpf-timed-may-goto-v3-2-cf2a9c3d843f@kylinos.cn>
Date: Thu, 16 Jul 2026 09:58:45 +0200
Message-ID: <877bmvwekq.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Feng Jiang <jiangfeng@kylinos.cn> writes:

> Enable verifier_may_goto_1 (raw instruction tests), stream_cond_break
> (250ms timeout path), and the may_goto_interaction_arm64 fastcall test
> on riscv64 now that the JIT supports timed may_goto.

Really a nit, but now that may_goto_interaction_arm64() handles more
than just aarch64, maybe rename that function?


Bj=C3=B6rn

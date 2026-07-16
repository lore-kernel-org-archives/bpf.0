Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B7388E60;
	Thu, 16 Jul 2026 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784181326; cv=none; b=L0CMBVuIyJ7GVhY3/7C0GF49/DfDRMQG9qgbYJrw99qtVWANWKwe9FidwWpIqRQ0I4G5F/zycliyZENP0PYpn47BxBWWmFreoAt0NL+uCPrKrqdhaQ+B643o2sXvERDVYLc6EIj7Ql34bzJ8pGrVs/65bYYTCO/eAZwLEjfQ7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784181326; c=relaxed/simple;
	bh=Nq2SGI4HeV0P+ZkfiRFxeDxrukdSAoWjo2FvWLwqwF0=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=HMxikBHVdBq2WJcBNAMP1XS/3gT6kNMFdQO8IJLd8nOqpXPwr3iqq9epKFTU1a36OlfTSiL4uQDK7ZygNPjUdTi4Ht8VZtKYjMYlrYDQDR4v0CU0pjarJm6h/cVjYV9jqSS3z4zjmRjoNYdvoDgvkGVLjV9IInXLIOEU36UgxmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h12MG02zLz5BNRf;
	Thu, 16 Jul 2026 13:55:22 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 66G5tDGL038830;
	Thu, 16 Jul 2026 13:55:13 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 16 Jul 2026 13:55:15 +0800 (CST)
X-Zmail-TransId: 2afb6a5872435a3-710a0
X-Mailer: Zmail v1.0
Message-ID: <20260716135515586meEuKQ_R48nXmdnpldURM@zte.com.cn>
In-Reply-To: <20a444b2-aeed-4af8-ba76-e994e2c14087@linux.dev>
References: 20260716113419588y6Ycmo7pzva8buwne9yWZ@zte.com.cn,20a444b2-aeed-4af8-ba76-e994e2c14087@linux.dev
Date: Thu, 16 Jul 2026 13:55:15 +0800 (CST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <leon.hwang@linux.dev>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
        <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.xin@linux.dev>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBicGYtbmV4dF0gYnBmOnN5c2NhbGw6IExvZyBlcnJvciBjb2RlIG9uIHRyYW1wb2xpbmUgdW5saW5rIGZhaWx1cmU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 66G5tDGL038830
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 16 Jul 2026 13:55:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A587249.000/4h12MG02zLz5BNRf

> In subject, 'bpf:' is enough, 'syscall:' can be dropped.

Ok, thanks.

> 
> On 16/7/26 11:34, xu.xin16@zte.com.cn wrote:
> > From: xu xin <xu.xin16@zte.com.cn>
> > 
> > Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
> > code from bpf_trampoline_unlink_prog(). This aids debugging of race
> > conditions during link teardown, while keeping the warning rate limited
> > to avoid log flooding.
> 
> 
> Have you tried to trace bpf_trampoline_unlink_prog() with fexit?
> 
> bpftrace -lv 'fexit:bpf_trampoline_unlink_prog'
> kretfunc:vmlinux:bpf_trampoline_unlink_prog
>     struct bpf_tramp_node * node
>     struct bpf_trampoline * tr
>     struct bpf_prog * tgt_prog
>     int retval
> 
> Since bpf_trampoline_unlink_prog() can be traced with fexit, it seems
> unnecessary for this change?

Well, the crash may happen when the kernel is booting, or too hard to reproduce,
in which case, bpftrace does not work.

So this change will be more helpful, I believe.

Thanks,
xu xin

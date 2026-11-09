Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235665;
	b=AJYB0SXoK0fH393bQSq1OjYiXMq9wWKQfT8cTiD/UBe96Mu+jDgVgsTG1asRQAINQfxu
	 QVNXEfQXaSGswDNcFLkQMRB8DaOejKZKXkTnejk+42Yc+vOQHq+YE4JT4Hl+NfKbakhUe
	 TYiWzzzFrlNzRSKWQXFtRMdEYgFQO9NFn+DmVxrPrLAwQbqokVb9Alb9M9ijxKNKuvjAv
	 yTwh5cjwuVq6NQPzJFCyRCj1gWGQfGV44ym89xeXALMgMOVStr/rVrCLyD62v8/D0vw1l
	 xZ0TebXwFfYHdht2dt5sHYYWPi4Eww2UDjjYoN+FK8Gc2OEFKwsMCT9qrxMZ1c3r58w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235665;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Bwn4oMi4wD4Hm2RlK2+vnAdq4AFCLTg3OHrUehp6rKQ=;
	b=zCG3yLN8mSgr5bRHbp/BJhu3H4mtXl9jYwFEVrb3KQ5DwUanRbSOBm7hXQslavX+a/90
	 GuEkD9kpIXsbFLaGB2ZNVqErSR6fU5HsxUm5Q01ScGG5da5iHSApl7X56C8g1Gg3WmrTF
	 T1KwjYtV3Qgra2/N2ng2hQwa/ui0m2t+OqVOh1SBxVC+CbAKUEuoZhFXy8HhkJf53sc3D
	 NXAXbXqHHvCbLawF+6D2XAaIfTgkOM3JspMp4k0RV5Us4N/JRWkAx8ihoJPZymlAQ6uI6
	 zdypE2WmebgQX1MpAZ6BYRWyanPKDz4AmXprkOglfpe+mEsnn1i474kZA6uaLc9PvKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1u1vckD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A57606D807;
	Mon,  9 Nov 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1u1vckD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3521F008A6;
	Mon,  9 Nov 2026 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235664;
	bh=Bwn4oMi4wD4Hm2RlK2+vnAdq4AFCLTg3OHrUehp6rKQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Y1u1vckDjH8hJB76C9UNV0Jie/UmxwTJ5xCoKFaBVFS4pYMvG3XP6ao8osYS5luGt
	 7IVgAGiHiC++Y2xxERgx+6vLb53UrAUWJmxrXRdcEN4FT+hwDfqJnhGunyxwQY+1wg
	 dySHKzmjZyPtmc2K0aXZCxNNP4iIhz5MpRZa7P8WvVU6zcSqPNJW6LFDSUBee47nYs
	 FqF7Rk++hN2aYFPUo5ia4Wt4gc34hbT5NtZzXQM6cr9f0To21UNWQy7+Nr7aGy1//8
	 jr959VB8xHKzHPTajKdbEL9KY3nOpthHwGV4xxp5+Nku32c1LqMm5PIz7ghcqbd3LA
	 XFDDcIbadTZzQ==
Content-Type: multipart/mixed; boundary="===============0156833231429614843=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8b9e5217cbe9c192e678ce5c8d59f573c80a659d72211f5b91c905ed00ebb799@mail.kernel.org>
In-Reply-To: <20261109140816.5196-6-leon.hwang@linux.dev>
References: <20261109140816.5196-6-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 5/9] libbpf: Add log_opts support for BPF_TRACE_ITER
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,kpsingh@kernel.org,matt@bobrowski.net,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 14:47:44 +0000 (UTC)

--===============0156833231429614843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Add log_opts support for BPF_TRACE_ITER

TL;DR:
- libbpf BPF_TRACE_ITER case may not reject stray bytes after iter.len
  (missing OPTS_ZEROED check), so unknown fields could be silently ignored
- Nit: iter.len test in the legacy branch looks like dead code

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c

[ ... ]

> @@ -821,6 +816,16 @@ int bpf_link_create(int prog_fd, int target_fd,
>  			return libbpf_err(-EINVAL);
>  	}
>  
> +	if (iter_info_len) {
> +		if (OPTS_GET(opts, iter.len, 0))
> +			return libbpf_err(-EINVAL);
> +		iter_info = OPTS_GET(opts, iter_info, (void *)0);
> +	} else {
> +		log_opts = OPTS_GET(opts, log_opts, (void *)0);
> +		iter_info = OPTS_GET(opts, iter.info, (void *)0);
> +		iter_info_len = OPTS_GET(opts, iter.len, 0);
> +	}
> +

When the legacy iter_info_len is non-zero, the check above already requires
OPTS_ZEROED(opts, target_btf_id), which covers every byte from that offset
up to sz, including iter.info and iter.len.  Can this OPTS_GET(opts,
iter.len, 0) test ever be true?  It looks like dead code.

[ ... ]

>  	switch (attach_type) {
>  	case BPF_TRACE_ITER:
>  		attr.link_create.iter_info = ptr_to_u64(iter_info);
>  		attr.link_create.iter_info_len = iter_info_len;
>  		break;

Every other union member's case ends with a check such as:

    if (!OPTS_ZEROED(opts, tracing_multi))
            return libbpf_err(-EINVAL);

Should the BPF_TRACE_ITER case do the same with OPTS_ZEROED(opts, iter)?

On the new iter.info/iter.len path, nothing checks the bytes after iter.len.
A caller that sets opts.iter.info, opts.iter.len and opts.tracing_multi.cnt
gets the stray field silently ignored instead of -EINVAL.  Likewise, a
later field added to the iter struct after len, built against newer
headers, would be silently dropped by this libbpf because sz still equals
sizeof() and OPTS_VALID() cannot see it.

Legacy callers would be unaffected, since their union is already zero, and
the iter.len test in the legacy branch could then be dropped.  The later
commits in this series only touch selftests and do not address this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42633880300
--===============0156833231429614843==--

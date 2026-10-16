Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A0413796
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194724; cv=none; b=BOmFQsDb6RlIWO1fvgQllGNZQLxOBX2cHRqqpoeAXWveZCLdPGgNn6J2orcDKdH/syRzBrrOzckgEXknPE7Hik6+sTL16yxyBxHEzVbBVQNjWbhn2xqLYl2pHbdZQ1VZ9oh+6kCn3Ox4npq7KG9hyBYOMFGqf4VYzNy7SIS8pD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194724; c=relaxed/simple;
	bh=encltDdbwP86iA3t/RWo0uh5+73YF5lHb4R7QxtVGSc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=MKDxOfMRLQK5vGE3/oTeNFyIb0vTIdMl9UJ4lKOSDzllZmwZ9oD/rd9MElcgzKjZy6kHtwHOHit6Ptobgv7Q4FuVgNlPjUYy2fZQaziD8bk9oSdwwr1+OPvph16uXAGLlJVkeYKOKrFb78OGLt4ZTctzcXbH0HgjI81jf6dTQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5/ESChz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5/ESChz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e95bd1c14cso2962765ad.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 16:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792194723; x=1792799523; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LEuEMUsoi9gqHznlDv6aFR0STWW3QPHsNbZxVfkH0AU=;
        b=i5/ESChzehoZqOnDmo5QAe0grXmsnQAgamVuu3FZMvSX7rkfz233i3eXVjUafU0CUg
         5R2J5BXI3uZVWVhZjAyiK/Y47KmBv86SieFhGQROGXAP1/PZRPkBQ0hRYmZiR3DAVgdH
         SX5yslwd4sIN4Teo+rON6BhgNnGWVDTfMEAP8z5a4OC769lzWBFaEj4iu+DwUwmzouWf
         N5Cn+AdjCYlNdjltdOzblD1LBONRTNvbrJ4e+bBplr7haKc8YJsCVPS6Y6VE8qvZ47Ss
         ifHHFHhFZXuWxfieLzAMV6u8PdlqiR1PcuWM77jX4TJyUBY1glqZJA6RWU+TUsJMYclZ
         73Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792194723; x=1792799523;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LEuEMUsoi9gqHznlDv6aFR0STWW3QPHsNbZxVfkH0AU=;
        b=D/o/9vFU00vVhOrqWE/+uZbdK2Bn78KCEJW12T6Y6P7GV066IlZ8acnfYGaYEddrPP
         v3MR6oGgPufmoh4HdGSZINEMB2N38s4WxpwXXDKT1aDJmgCMS70tNaZLWdy0kmi+cz9u
         WKI3sYpphE9/IhqsGm+SZt7TfWTK3CpZwVbRJ5QaULxzgujRf0ggqymYC1HgMhzXLEQz
         dagf7pQmwIn9SEu/qSSF6wbbbsr0LjmOhzaukcPXBK2STYgcYAGAZAPWZHBxfpZmUtqe
         W+4G021BGlb9cOzqAfh/UEGsQYC23LCxbLMfGYU/QMTXGszQfC0Zp+1IG9xNp9yN2C0Y
         GALQ==
X-Gm-Message-State: AFq9FYJT/9HFy6t/bCW0wSAcrp3MTuSga1l1JRMvLcYlN397e248gAtG
	2uF9DpaygbolLGo219yLWAr5/Dly8s/fX4m7ikdERBhe39OjYBzdDpco
X-Gm-Gg: AYBFou05IoVM6MrY7Ya4G5QY03HTwsfJiiJWEvqrh5FS5IMzVHl0kSQjAzz/+nD1yr7
	TE1Fp08DY5vg/Qw2MoH9X19NIzKmS6Gf9lNXQIDWbu64ywpzwohQn7F7A8ON303OjwV2ARZSfpQ
	WfslVPrXED6JKVfh69jzK4pVYtfLGbOaeMvMYweohDw2dZbf8NygEm0G1VeUjRor+pUblur4qMz
	dmYlukcp4QjfP8O7Q9E3mVEJv2zX9+Fb7HV0AV6os2+hdyuihVZCYw5cXU7MOCpQZk+WXRFjUX1
	tc2JN7L6bIxKF37wjnozzs9hxadtfzu/DXAWkxJSEawazc6u3SJzhQqpg7zj+RAWQNIj+rvK5X7
	PEdN5ofZr06O/95pdtZjDfBKQAe5cenUWIoulm7wR4ehlHB2ZtCTBRF4onR57UfsQv9+aCPgfJX
	H5l+oeuxR4R4VvgH2IafWjdZp0XQF7hNLBTizyjTBL1BQZqy8PZuRQUTwHb6cE5VaXkrjrvTkmh
	Ld5G5i0R5oc/27GN25ILQCS5jp6JGVQrFAsurNifxHA9s6GcUEDQf8FeQwRm75v27aajwKHDDX+
	4scKihZvIp4I1A==
X-Received: by 2002:a17:903:370b:b0:2e9:55fc:ded2 with SMTP id d9443c01a7336-2e9a6d1f605mr14152635ad.52.1792194722571;
        Fri, 16 Oct 2026 16:52:02 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e833ffdsm16714415ad.32.2026.10.16.16.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 16:52:02 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 23:52:01 +0000
Message-Id: <DM6O08VBRY20.1PFUYACCZ38JL@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>, "Jakub
 Sitnicki" <jakub@cloudflare.com>
Subject: Re: [PATCH bpf-next 2/3] bpf, sockmap: Restrict iter-context
 sockmap updates to iter/sockmap
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Michal Luczaj" <mhal@rbox.co>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Lorenz Bauer" <lmb@cloudflare.com>
In-Reply-To: <20261016-sockmap-update-limit-iter-v1-2-23fa946db59e@rbox.co>
References: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co> <20261016-sockmap-update-limit-iter-v1-2-23fa946db59e@rbox.co>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 11:09 PM Michal Luczaj <mhal@rbox.co> wrote:
> [2]: commit 64c2f93fc325 ("bpf, sockmap: Take state lock for af_unix iter")

unix_state_lock() in bpf_iter_unix_seq_show() was added only for
unix_stream_bpf_update_proto() called from the iter prog.
iter/unix cannot get there anymore.
can we drop it ? can be a follow up...

> +		if (eatype == BPF_TRACE_ITER &&
> +		    env->prog->type == BPF_PROG_TYPE_TRACING &&
> +		    !strcmp(afname + strlen(BPF_ITER_FUNC_PREFIX), "sockmap"))
>  			return true;

iter/sockmap prog is not limited to ctx->sk it seems.
bpf_skc_to_unix_sock(ctx->sk)->peer is a plain PTR_TO_BTF_ID and
the value arg of bpf_map_update_elem() accepts it.
The peer doesn't have to be in any map, so it has no psock,
and sock_map_seq_show() holds nothing but rcu.
sock_map_update_elem() takes bh_lock_sock(), then sock_map_link() does
sk_psock_init() and unix_stream_bpf_update_proto() on a socket
that unix_release_sock() can be tearing down.
That's the same unlocked socket as in iter/task_file.

Should we restrict it to ctx->sk somehow?

pw-bot: cr

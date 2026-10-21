Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541014;
	b=PMWdC1E60F9r++zwmVKl/Ll9zlF0Ms0XRBoQht7h9NPu4ZD3Jekq9lKu2aX+bz9gDM1x
	 9ltQytMnLB2WTi4nfILMDKEwHIcMBMc7oKASDG+hIOQkQkRdL5jst9e2+rkCZuXKKqIQ3
	 TZBEzR+NJLqAbVu+71HE+YjOyDjgYi2cNxDK9KFBRGlDTB680YN5F4CxpFyCy5uvOqfaE
	 +hhIdHd2EgihmbRk0NrZFFgL9wSeU7GNDRdpCoZ6BKogKQFTUVMjg2GmR6hRe43828jE5
	 kjltBlkX+Z9wzyAWwE1QYIPsHtOUVQH75OtviXFhabe2qet3f8KnrnXQoQUebvEkhVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Subject:From:To:Cc:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=o7cBhNpg0ui+vvenTrI+Qs2agwPMwE+Ym/zTHxHB83I=;
	b=nJcLMFth11XLrezg+Y6tOQBqilcVbd2VpNJp1xweI9CDx1WJZXRdG2M27drYTSscUluB
	 sJpXTgGqjXvnKPb6v3N+YvguG9s6uHtavqdc5L5vG+NFFTHdBvJWbNqMrjDMIRao1LrRr
	 s79yiNc5dQkEKwIBpqbMba1Q9WigRvsRA6gaFYVQHe8LD7LBms8rIxcVM9/LoTzAvtyRz
	 +HTA1RrN8K8QOwkW1Vh9wVKn869E0MVqqicftJZjRRSaW8EVpAfbVPSHEn0BhhhvCNNCU
	 32JO58tHUvsGq6mXtkLGoNkV4wI07soCN+njTrpsc11+fE+f81YPA2AVh6IRyyRZ/MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="ZMEt/2it";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74647606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74647606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZMEt/2it
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a07078200fso51079b3a.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792541014; x=1793145814; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7cBhNpg0ui+vvenTrI+Qs2agwPMwE+Ym/zTHxHB83I=;
        b=ZMEt/2it0rDxDHMN5+p0lAcKOC93Y08ECZcMWhaG3jaszhSDde1PHD/V62CPimWNa8
         u6LCqvl9cxTgr89VJ78O4MkdrFayQRO6Rsat7NW1yW548f15+aJOVqBID5rSSGsj8Hwx
         OW0nw708LIH0SJAb2Uq44DqS29Tu5JK8gmuUM9yWDSqFWqepzcy2OQ1LToPZhZrx76uD
         KXHBo1bZ6o1IU7lhmaJSXSSK6s9VPpbzQo69QUYKGzSiGmckzn+fK4jbxUU1SQEPKoQu
         BxJ/QBXELQpORXGFjfUivFIV8UOU98nOUrUIXaVf7pjJ+xuTGkBU9+fHb1ImSnpDEKF9
         XtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541014; x=1793145814;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7cBhNpg0ui+vvenTrI+Qs2agwPMwE+Ym/zTHxHB83I=;
        b=bjdr2JtKIAD/IV5wMeb5rxvxBKV9PROF+EUkBgJYpgbqTO12TRHbBmfaIMiBJTqAgV
         XjRhifdcAMf4YmCsDGHOlbvwdK+7HUuTgArKLbKmT6rSHarm330YAsHfzymFPYcC0THE
         ReaGJ2HSjmoVah/q+7jAR85pI7m7VQxeYLv+j5S9rermNEj7PcQJS183vOtwfHOtN96/
         4Dh5mOE5lZh9oQDMIrKYKsXXZwZ0gpCYDC84L0faXtF9PpND1dKStTXk0jBeHO6SC6zx
         XgQqq1T2QG6NaSYEQe39SWqva8FbpvjptvqGK5wYYysFVuuhMuNd8Pi2wDRKvVZuW9rG
         ZvQA==
X-Gm-Message-State: AFq9FYLhJvqhXAwAGmsWcy2itJgegmpjH3mYRaRMQWq1FvXdUH41rCpZ
	aNDIwU1jjDkGZ3+L/F/nRyhKjlBtZniRcX7MzeY0B44emc+9nNeVI+k6
X-Gm-Gg: AYBFou1709a6gtN+B12b1foZyHgD1OiPZLsLJOCSZPFWWAku14qAzpijG4OXKeFiiVk
	zP9RRe9MmjxnuOWL3hLsKJSVpsaebrndTKPgVe6QqkrXgeuU3/h9zHRGBKX5NXEhaY0ki60Tbp2
	UjFmWIpVV+/fdyWOManrc3F+bS2nJMfLM52F7/wRZpO3NSa0fZIriBBtEL44VUtq8yT3PT2qhy6
	aUcl5hqUXT3CMarj+Dh0kTXpluiwJqC7ai2Ql2Wl+YUCtAJgTjP0PP075RuMLuY2ULz4mePiUC5
	1v09lVIVhr+ekUjV/tiXBbScskh7lrvnqziqLh1GjmtuxHGWqLdtWxFrfGaPaJzHxa9uMrlHVcW
	SykspA8JwiF6c5A5myynb42oQZMjseL4H1AO4CyLtla4rvPwgPqg8ov0002nGBfI2Jr8sR3TLYm
	FEfJIa1MZc/RNE4lYQ37FvgU+ZTUBPuAb+eLtGS19kOlTG2vmosrwYMfv5iGaycfrSKLbvhmZxm
	AXhNx4OX6WOCSM/VDdC9Nl3ak4LtbLre340OH/WQQ3QXxm8RFrm3yC9sPk0JMQHYDA57dh8Jjtr
	y2E=
X-Received: by 2002:a05:6a00:2da9:b0:883:904e:da56 with SMTP id d2e1a72fcca58-8a089d21b81mr372682b3a.36.1792541013696;
        Tue, 20 Oct 2026 17:03:33 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895c0affsm153415b3a.29.2026.10.20.17.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 17:03:32 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:03:31 +0000
Message-Id: <DMA2R8KIUPO2.SR26IDI6VG35@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Validate stack arg reads against caller
 state
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, "Xiang Mei" <xmei5@asu.edu>,
 <co+eada64ce90ecebce@bugs.sh>
In-Reply-To: <20261007174203.37071-1-bestswngs@gmail.com>
References: <20261007174203.37071-1-bestswngs@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 07, 2026 at 10:42 AM Weiming Shi <bestswngs@gmail.com> wrote:
> then read a slot that the caller never allocated or initialized. Async
> callback verification also starts at curframe zero, so subtracting one
> to find a caller can underflow the frame array.

Sync callbacks are broken too and this patch doesn't help:
  *(u64 *)(r11 - 8) = r6;
  r1 = 1;
  r2 = cb ll;
  ...
  call bpf_loop;
where cb() has 6 args in BTF and does r1 = *(u64 *)(r11 + 8).
The slot is written, so check_outgoing_stack_args() called from
push_callback_call() passes. push_stack() copies stack_arg_regs[]
of the caller and the load in cb() gets the state of r6.
set_loop_callback_state() marks R3-R5 as not init, but stack args
stay readable.
At run-time bpf_loop(), when not inlined, calls cb(i, ctx, 0, 0, 0).
x86 JIT reads arg6 from r9 and arg7 from the stack frame of bpf_loop().
The verifier thinks it's a map value, but it's garbage.

No helper or kfunc passes more than 5 args to a callback.
Reject callbacks with bpf_in_stack_arg_cnt() in push_callback_call().

> +	if (!vstate->curframe) {
> +		verbose(env, "invalid read from stack arg off %d without caller\n", off);
> +		return -EACCES;
> +	}
> +

Only async callback can get here with curframe == 0.
With the above it's rejected earlier. Drop this check.

Add sync and async callback tests to patch 2.

Also mention in the log that
commit 4286f5deee14 ("bpf: Validate outgoing stack args when btf_prepare_func_args fails")
closed this hole for the first call only.

pw-bot: cr

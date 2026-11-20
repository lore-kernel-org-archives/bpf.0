Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795217034;
	b=CPJhcpJPct3IRNIRoh2xZHB1XWYzSsY7Gv2EvGPTAkn5uKwy/6INaYzk7Dd2IJzcZtPF
	 jprn8apQriPcAekjCisbdFo07QbdWtZaDQSWr+ri+hh69KioyBsqU9fy6mrq8hY1K3s0I
	 dw9ODgAvF3Cjy9WCzOwzcxsf5qsDoUE0zkGjoo1D6QHYru2tS7ymhMX/hhTqW5VInfg8W
	 Wv5tHsOLw4FKqkK4GS6UjloXC1SZf3Ac1+HDFlVyfVJtfwD7F+kteeCkY3ql2sqLx6R4U
	 IfdHfIRKhgvkhUj3n2jGhUoAbnlvTjJIdo68zFu0foo20MB984mrHScXQXpEFe0itUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795217034;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QsMsrSVzccV/M4rLUJzb8bjMzW9z/0kzllqgzjAO/iM=;
	b=Kf+MJtFJqIMFzGS84blTesTL3G6OwpIPaELJ1vF9FuLQoSI51rio8ROMkGbHAVqLBXij
	 5/G46PQvl205fT52bW5ngOVdXU4Z4q3cJY+cGoacUFo84Q2/1qVE1BZ5dpYLSq7eqc4yv
	 rP7OGvBmzqQVEjznlb+WhdjksmwD0dozd55ineh6/v2Y+dQ8emJqVVDDcjwPCQ0QoeKr+
	 xifFyRn0LD5e8OyH+5Ay4kRt9ZabBYNOm+HERVELGgsu5W8Cf4ayqO3wYiZXqJQrQCsdk
	 xhwGEmqlsjmlRRsgIpnsFNQXKgAryu7ik6E19rC+NIL0dvEslBX1egEs77p5ebs6suQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41438606A690
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 23:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41438606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91f0274f88cso20607236d6.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 15:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795217033; x=1795821833;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QsMsrSVzccV/M4rLUJzb8bjMzW9z/0kzllqgzjAO/iM=;
        b=OIT3bX9aDXP6Gbe+lpRtEjvpy+UFqRGtvpnHmUNlO0f356XNomHtVWboRY5bwYRklh
         DozUHSDi0+2qaXKPUr0RhAXLxxbYQkxLwW1NZAENNvhmVLk4DNqsjtfNzocUlovhm5eI
         xjjHiXBcYciNhU8EboAKPQrFZ+b7JkYG+daUBZ+PdrxcaHv66tHTW40eAe1lDPFACav6
         038Jxk/6NMm/vl5rb0ONXNqOpXaiH9RAkltRKWB0r8jaOgE+7yw4e9QmVn9AE5mOZLZ/
         CCWZI8+E8zAURpIIj8aIx/IS5IJKUWM9ZLJOe7+mdWpuJygxqyTwv/Z3eqo/+BbSRyW1
         S58Q==
X-Forwarded-Encrypted: i=1; AL+hErH8OtK1KT9Odm0tzOiFSj36CydwTYzijPBUnMC6zF+G/MC5q31s5kK44rVjzmTYk93NzpA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PZNlb8LT4qANqzxFG7uUziGIKyXeRWCISVVgN3VqxK82SLgBq
	rMTupY+XnHhQyFdr4L4Iy5q1z4N11Ukes5d/mDknm1olOqcoq7zIJtWC
X-Gm-Gg: AZFdTZd24tEvWsHlY4L1TcV18+1GxvRrGWAGet3Yzi7RagGYgBO+QA+cdE4hSIq3FX2
	iqAV3xlTeUspN/98/T+Qlb7sA8g6WxHe5TnuQJKJeDM0/oI4InpEKYptxb2YJCvqNiO6IRegPPH
	QZVkg5uLPocdZAnv1QpAogLwfAMq95q+5AB17nD71pZ9Gy8uGBfQFNvUDFedUfx+6dKu0/r5aG/
	X0HyMJwMR8YYHq4xOEd7LliRrDfV+SiLGPJyRLZrJvQyAfqhRq33V8BO6d/jspL5yJLMMuBlTAY
	Boc6T9z6xkeb7S5IEbO5PRptLpUzqUSbReDKBCn8jbnmLm9t7soP1IsxaYPC0/AzDGOntF3n0RX
	2rWzwH1BPJ/F6A5qoB7ivnmEUygu+3Votc/v6ryQtaOcMoJRFipsf3GkwerQbXNDyDqLcFj5acp
	EdwMpWB8A10jUMgDzSyQf6lk8TWRJbw513o7axRFOzcowR4N5mLLCPBQ0aasvJVsZHsmQD2Dx0u
	D2EJ1XXXirNKO83fKnMflR5xqH5UY4Th5sYFPBxxFbEk7ddGJQCmHi/iSO4NQsFV54XHyc5mYKM
	NeJ9k6z868RdLrJoUfUnwJbEgISfSRrJppPG4+ormCIGdHS268bcQ+cUrYuNcpFjsslZxlQHobA
	XQXvEFSvp87ILd/ECF68oFTbg4gny693jWm5Lt4N+LXEir/TsQ3F7YR8JEebx6scbiczonCJYMC
	A=
X-Received: by 2002:a05:6214:498c:b0:921:3f58:a52a with SMTP id 6a1803df08f44-9213f58a5e2mr40412176d6.10.1795217033088;
        Fri, 20 Nov 2026 15:23:53 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a2806dsm37455776d6.45.2026.11.20.15.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 15:23:52 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org, arighi@nvidia.com, xukuohai@huawei.com, billy@starlabs.sg, void@manifault.com, ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, awerner32@gmail.com, andriin@fb.com, martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH bpf-next v3 6/8] selftests/bpf: Refactor lifetimes and test wakeups
Date: Fri, 20 Nov 2026 17:38:22 -0500
Message-ID: <179521430209.33161.791368362708058227@kernel.org>
In-Reply-To: <7d0a57117d3a4bac7aab7808335393ef3328333d04b7f67d1aa2f492959e3ff0@mail.kernel.org>
References: <20261120-bpf-ringbuf-fixes-v3-6-ff7ca15d6c37@kernel.org> <7d0a57117d3a4bac7aab7808335393ef3328333d04b7f67d1aa2f492959e3ff0@mail.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

> Could it say what problem the lifetime rework addresses,

Split in v4. The lifetime fix explains how an early return
could free the ring buffer while its polling thread was still running.

> [...]

> so the state is updated in one place?

Added try_join_thread() to update ownership after a successful try-join.

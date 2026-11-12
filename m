Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445473;
	b=upIaDYkEpQpqsBN3p86KmU/tboYi0jIevYZVd6u6KiuBUEtnOhXezbSrPLdtE9z9rY09
	 BtT+qrffu+8H8DTHqCobXTeUk83zprWiO0M8ElOyravVKaTVEgRV5OSx0fDlcotOOxdbP
	 urryJ4zjoGYav52xz2TmH8bXCPziu52yzI17+5n12kVN5fMIMTVRULvHb3/pwHW3IzLmh
	 aV5kmdEkHaqcugsWyyDfZbezHWpBM4b0CS/twD5UJrcabiut3soDT8yj78e2NfosHWq0L
	 4LtdLSM7aqBmlvrC7pyXOAy3HsKXVtd/oXc1nCshyjPDN/TPmSRUFFViI9fzliJGhCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=ImXBWGlfZVszV/Tkddt3FR7QWzPa65TkJvi8WUZhBmU=;
	b=5KmgNXDUn1Tak3lPWhOYftcYxFMuDZB6z7vrQaXEANcx2HoSt1iPqvZZBPg/PrccAv1P
	 eNqz3VfYrqpHeV6M4HxNNZFyHvLjQEqTpArL8aOE981KzAhspIJX8EmmuuhsKgdtQjWnl
	 A6YGmwLWU+u74dDdfSBNvbQ98KpmvRoMky2d1qd5g+tsdlSQ5/g7rXfybyL8Zp3dls5Eo
	 PaD0tCXm4xweRLzgjWHxv43xB6vqLa+Roz59N4wfnReCWqlS1s0PV0Bpa5Mpt2wHEUXhJ
	 aPZTD+aTZJpXJWscnmvolYnO/gBWEhjciKT1fnww8/cICQwHcV/U/zCo9p33QCwGzGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AISAJ9bb;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094F606A33B
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 01:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3094F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AISAJ9bb
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so1575538a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 17:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794445472; x=1795050272; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ImXBWGlfZVszV/Tkddt3FR7QWzPa65TkJvi8WUZhBmU=;
        b=AISAJ9bbeU8GfdfXc0hLt7sMbDWH+hMBgyUtmeidknJQeLdeCBSqQ++3Ab4McAJkWR
         cyjHGHKPWZzGDjet/7z2iDyQHRyGnIe0HOdif98bx4pz+lYySI0+lCGOf7CeW2pHWIzv
         tpEDH/VJX+VnjRJHCVZeNsYXOyzUXqAldn6kkUhTXMYZ+sWD0fa4Fc+tKpTZu0IWHlFt
         irjynHqGN/7GuyKtbmfM4Qje2w8qHPEyAIAcozxd1LS8veIrrThANyqqXGD3oVTjmZiB
         HOIJg46NX89zi+SYaRrcx29ZvLGnCEStm56k8tduYDPHOn//AwYmnhWpqU28Qgdby59I
         wSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794445472; x=1795050272;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ImXBWGlfZVszV/Tkddt3FR7QWzPa65TkJvi8WUZhBmU=;
        b=jqkKVxc6CcSvwMDx/Xkt3Vrbbp2LVjA4OLCX8ss3mll/Aqw1Ex7q8q0W6Wj1ODbXtL
         jiOKKG2gTZ2xUcyoHxVBdNTZXAdqymcSA4NjK3McieoRK6fmRQZDkUD7eeKa12eWoK51
         mw5d/ZqiZVzRl1aXQooodQKiRXp6sqmilTDT5qHjXfvyW/rK6H50JeCujlz2l/jAPHIW
         atqUAFquin5YsMMkqaz8avyQJ0aq7urc/3U3LhftBGs+k7d4EOa4P7SCRO70oost+yl4
         p1Qt2YxMf9pHiZr9qJAiN6MxDnx6SLNNk5ELVlQkk2u4BQPUsQJeqSZ9EfukPgyB7nU8
         cQRg==
X-Forwarded-Encrypted: i=1; AL+hErGArtxwOAAthkNRIwh7XBLBh96qWK7SCFmxriTJInOI4RtFcLLK+kuBApM6l0ZLD/DGBqQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8J+4fAtyL/zsQ7Oph1Ckn8jWUVNA9J0UsUIDfJErnzJsoGsbew
	wkTLrL1FVWVxmeUm9YuTSQ/Gi0NW42/XCMPCHsl2uncDWH/B3Sy1PXk1
X-Gm-Gg: AYBFou1dY/vJLybJN8tDCvCaxaLp0oYI+9oao1a2tS+AtzuepGJRXNsN1BWuh5DWuj5
	3xzvQGPfIH5l05AstR+eUHlCKmtk1foHVRSy1gGZh4FSCgzI/Q2isPTWlxoq7SLN1U0mJAgjJjb
	lYMsXKbHIkIKqAKwMHHDyKSlKH5fwt9WRDtlVc28zQO6JVxdQlOhVj6yT+wliHnHRHwTzZ5tMLw
	hBeO8ho3tuxzKQd7Wl5GJeWT/yQjXlROyMmpMATvnykSO7yvSy7d7wLDPyAihC2lapVOYvDi2dr
	dF7GxcOIzf0TKUqnmb7WqF0VzM1SDFCsNM1potZWzrdqeoHE8yZG0NuJHhvNdsUvqq8t8LNptzW
	iZKzCKCiUgeoPJW4TnK+sdKCG5B0yUq7DP8b3Yor0wbu0gEmAQEBVh4vxB4V4vMDLNZk0w/1HBq
	u+h1OVHyN0k+dyrH2nr4v6SOPHOq1m3pVZom9Vx5PA0eeXCZCu44z6v1Gt7f/xHXsNOgLs5t2ed
	CwSRXJFfM1G3WbTknqV4nZabeKTzbfrTdWRvbjGg4d6CiMqm1CH+hMvCWQqV4sWIx/s+2/UG6zV
	zFA6I98tY1DskNhBLBdSghW68WpKCX7Zs4kmzNBfpDtlv9P6531xxfjYYaAWG7HoKJ/CzAf4ANw
	3mUY7g3vdSGN0HKiaEn9k5b9933V5Luh71Q==
X-Received: by 2002:a17:90b:590c:b0:3a8:699f:959d with SMTP id 98e67ed59e1d1-3b182f28bd7mr3487343a91.31.1794445472226;
        Wed, 11 Nov 2026 17:04:32 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d7a26e5sm2247647a12.18.2026.11.11.17.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 17:04:31 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 01:04:30 +0000
Message-Id: <DMSTTWR4MAET.1VEV3R66S7ZFY@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "JP Kobryn" <jp.kobryn@linux.dev>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Check program recursion per task
 via bpf_ctx
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <mikeba@sentinelone.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
In-Reply-To: <20261111-bpf-preempt-v2-r2-v2-2-9d8f6b952ad2@sentinelone.com>
References: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com> <20261111-bpf-preempt-v2-r2-v2-2-9d8f6b952ad2@sentinelone.com>
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

On Wed, Nov 11, 2026 at 11:39 AM Mike Bazov via B4 Relay <devnull+mikeba.sentinelone.com@kernel.org> wrote:
> As a result, the same program can now run in two tasks at once on one
> CPU. Programs that use a per-CPU map as scratch space across helper
> calls may see another run's data, where the run was dropped before.

The kernel has such scratch space too: bpf_raw_tp_regs.
bpf_get_stack(), bpf_get_stackid() and bpf_perf_event_output() of fentry,
raw_tp and tp_btf progs take a slot of it with get_bpf_raw_tp_regs().
It doesn't disable preemption. Three tasks on one cpu:

  task A              task B              task C
  level 1, regs[0]
  <preempted>
                      level 2, regs[1]
                      <preempted>
  put: level 1
                                          level 2, regs[1]
                      uses the regs of C

B sends a sample or a stack trace with the regs of C.
This is an existing bug. Today it takes two or more progs.
With this patch A, B and C can be in one prog.
Doesn't hold the series, but I had to mention.

> Fixes: ca06f55b9002 ("bpf: Add per-program recursion prevention mechanism")
> Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
> Fixes: 439ebd5b5708 ("bpf: Add sleepable support for raw tracepoint programs")

I don't think we will be sending them to stable soon.
This is a big behavior change.
Backports only after next merge window.

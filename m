Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D852BDC05
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780094676; cv=none; b=cwDx9NsR1j8TrTGOXTctyKPPzr3gslAIm5TJG1XREH8+rzLDqxBWxLmJv99KUrWdDKvB35oUBQ1T7MGN1Vccn0VZNSQfLj8E99TITeCLdrcl7lOCK49FzEgqxKGG1lVnkOHhGF1/3/8PdfjscxnZ4Wbz/KsiuUcCmrH/2YpMvIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780094676; c=relaxed/simple;
	bh=Il2/pK6FRRwWyjbfAqVJcaRqdFcws2iLssIgd3rlNaA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=afCgG+yqwdwjBkep+fF0hWqxWiIr5R+ac/44xPaw9ETnPe7CXGz+O7CN85QagNMUYpNQQlQCKvTjdY55bHr5eaDCpDImdQNHoN4io8O4bz4aYI/pbwUaZ26DGpuTx8ZXW/+HCKz1YgYU5TYqFh7TCEPs2FxEnrKamjmYiydCDsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owsh96CG; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owsh96CG"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304ddfcf72cso2284737eec.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 15:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780094675; x=1780699475; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OUIaCGwXRmuxCVmeuVVGcVKMjpVrKy95vt+M/Iwvbak=;
        b=owsh96CGGHL1JVEwAJT7WoSiI6a99M3OgimAlb+F1D17/wCyqXts0VeFxKk36NkN3H
         ggct8Ak8/8RwMStn2LAzR6OraaU9b7ibQ9ri6knlJ6wnSJ4/zvgZpcnuv7sGG06Kxd5h
         zVODJ67Iifq1N1A6zTZD7zxmDBr6pr+5hCf3beRvbxPcG47v1uxVSDBZP6dYB3H02eE6
         NoS1DuN306S1uc4aFM1CtTw+GnzfiB9Yz0GdtxN/DzQIEM+Kvl96VryuS+KanD8ruLeO
         AuGo8zoXW9LNRfxl2Sxzlmz6DRIpTt+gr0NaZqf42KiJTBua/aYmthu7Xh1IL7KHufXn
         ID5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780094675; x=1780699475;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUIaCGwXRmuxCVmeuVVGcVKMjpVrKy95vt+M/Iwvbak=;
        b=B2SsSCNOfUCGZMLGokDsgXPyHFFSaBcBRUy/VH3ofqoYttgCkRQ47efpxKGMxetJ0e
         fqpzffNdaSztmu7XMdRJLXQfVACYHcH0l5FPjTnfWDKCXsYHnLrg/LIFj9mpkRHYI3b2
         hJA+NgdqNEifVkpdhDyNoD7sG95cjM1KJPRcnmUBIXZoJNC7IqkyBL35LMXrxBMDTrl6
         +TEdHsl/9TPsrqBaqe9PAoygPCJ2cTbwCOOIJpzH0ga1/FUim/fYsf8f8yu8yHrRbzCB
         WyqUsx6GmlyBqp0HOc+TrnbFOaeMsSiJqmDQnDpbGwxpXGcpwuhlXBtyxLhE+BrPXjeG
         5Rpg==
X-Gm-Message-State: AOJu0YzV+YrI2uH/bgYh9bQPM0vkbZneV6UaQ4gsa/+U+Bke96lRDIxg
	C9zpKRvp9BbtR5OaW9P7VkwTznz2G3Yxk3UsPYrqYoQHpIwny9ZDTduZLjiTIZ79
X-Gm-Gg: Acq92OFcY7FsKsPm4Iac33qI/nZW564tVzi0zE5cdi6qoqATn+Vw/4+bsHg2sDwVLZm
	Pd4BxkPUYhMj5ipMn6V4CVgBLOV1K7yuW9L86Qofy866thk0fieoBMPeCVAq84ZrReTndadC3gx
	5D4XK/Ba6llpHABdp+Hm1+4NfQ5piXxLRr3oNj1fQrd6+ZR3+hOmZAepaVzh8+ReXS9Oyg99JOO
	M6ryOKyN1oYRg5zPSr4+M+2jtZBuCAdEbkXrXdAnH7rZPQ4s4PRzy999e03I+CBDJEUQYApSfJs
	+lOm5IcSTu5MLeulAaI1LkYDw2oAh+srcfZB6Cu59YEoTJFymebLjfQR1Nk5MK1j+eBW2AXCXHc
	Qlf9p1IbN6uak8atI5Jn23pB7aa4tqUwpV5dKur53kPWe/9ehuGSSSi+ZmIOEkWgrHY6pG4THuj
	wK0y1vHmOIcXgzQ7oxew3rICpPAG29hf6SvXZ2elKgTazSLTdKH3XcwJuiiYW3ITIuVm0SkkNhp
	Ev4CmZww4c5Ac+A
X-Received: by 2002:a05:7300:5714:b0:304:e7c9:b528 with SMTP id 5a478bee46e88-304fa693516mr901422eec.30.1780094674656;
        Fri, 29 May 2026 15:44:34 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:290a:537d:fffd:9353? ([2620:10d:c090:500::5f51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5f6426sm2441193eec.31.2026.05.29.15.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 15:44:34 -0700 (PDT)
Message-ID: <14c9e9e95a07b6de94a142394c69b81d6587998b.camel@gmail.com>
Subject: Re: [PATCH bpf 0/2] bpf: fork state when comparing sign crossing
 ranges with zero
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, zhuyifei@google.com
Date: Fri, 29 May 2026 15:44:32 -0700
In-Reply-To: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
References: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 01:13 -0700, Eduard Zingerman wrote:
> YiFei Zhu reported [1] the verifier regression after switch to cnum
> based scalars representation. When the following sequence of
> instructions is processed:
>=20
>     1: ... rX setup with [negative, positive] bounds ...
>     2: if rX =3D=3D 0 goto ...
>     3: if rX > C  goto ...
>     4: ... code relying on rX being in range [1, C] ...
>=20
> The cnum-based implementation only infers that rX range is [0, C]
> at instruction (4). The pre-cnum signed/unsigned ranges based
> representation could always deduct from 'rX !=3D 0' that
> umin bound is 1.
>=20
> This patch introduces a workaround forking the verifier state when a
> register with sign-crossing range is compared to zero.
>=20
> [1] https://lore.kernel.org/bpf/96c4a1aa4333d10b882a9b5093d2d982f9f106e3.=
camel@gmail.com/T/
>=20
> ---
> Eduard Zingerman (2):
>       bpf: fork state when comparing sign crossing ranges with zero
>       selftests/bpf: test fork on zero comparison with wrapping ranges
>=20
>  kernel/bpf/verifier.c                              | 71 ++++++++++++++++=
++++++
>  .../testing/selftests/bpf/progs/verifier_bounds.c  | 68 ++++++++++++++++=
+++++
>  2 files changed, 139 insertions(+)
> ---
> base-commit: e42e53ae23b7d41df22ccd7788192bf578f24da2
> change-id: 20260529-cnum-split-at-zero-3c03db9234d3

I don't know why CI misses it:

https://github.com/kernel-patches/bpf/pull/12235

But I see two libarena tests failures with this series locally:

File                 Program                    Verdict  Duration (us)   In=
sns  States  Program size  Jited size
-------------------  -------------------------  -------  -------------  ---=
---  ------  ------------  ----------
...
libarena_asan.bpf.o  asan_test_buddy_oob        failure         879905  209=
739    4158          3931           0
...
libarena_asan.bpf.o  test_buddy_alloc_multiple  failure         269851  110=
341    2774          3897           0
...
-------------------  -------------------------  -------  -------------  ---=
---  ------  ------------  ----------

Investigating.

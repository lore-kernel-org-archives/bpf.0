Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E723033EC
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118774; cv=none; b=D9dhavPo2Rs5ZOBBrXBdDkOoVUgtNC5lXNCECyUMItJ5bCSzoyw97b2ODpvoAVTCpnNY7XqgvCoCpqySrJXZEgxlxS+2CzUXymH8tYvoBDuNYhswlcNenfd2r973M6K/Qek1AEccpHPSHE9x+T5t7f2RUG4WYYgJcA7hi1Udxj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118774; c=relaxed/simple;
	bh=KhuFbLLpkHPxpewHcHu0w8TJF4wgBLlrYuy2xLW5JrI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=cqblWxc9AMpqpwlTZUUwGJYLWQRsggxe/VM9XVVKx/T8vbjFrsjZNNYtzxzTBfBrXJbJpiQLcB/Qa0gWEWnoiTbNj42PeSkqbFMSmajgsNICUbblfe/HBNYWbbtXkRqwj5aXJOiojqIeq1xsxbsJWlvw0ualjrfpn5QxZLrRa2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0n2IDSf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0n2IDSf"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e940d5d2beso10294005ad.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792118766; x=1792723566; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rtABOQBVY3EjE3qc90f/RNYh22l21HguATv0M3MM1t4=;
        b=O0n2IDSfQ4Om7FpmL+TfwmFkO+8cITcJuAo04ndndFFtTV29bWlNtp18UPuAuzyyzH
         AMLjuC++Zn0btIY3RcYr6EaxoJK8eKZEpmpSETQ8RhQtsFpYMQ3XcRO6XOtbkiFIdzwR
         xy+BPsTkIuHG11qiCqEhYUL7AeLt2rqWYVaetdPnn087bKGWmGgiv08189N6BQdlWclr
         3ZRaGzrWS5b67O3rov94GmWjh355OYYRyKgSxtR8qoKuysa8gPHXOib9B36rrQI1n3c8
         ryTOTM8HbRC2crPKY71nZHBLT+YivqHSOa0D8KkCkPsNRFCk1FSefdBoOglrA92AUUzN
         jv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792118766; x=1792723566;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtABOQBVY3EjE3qc90f/RNYh22l21HguATv0M3MM1t4=;
        b=Xpf5+ILulTW/m/zGrelZuH+qj9Q1uBASeYTZXRsihhGV7L2wC3s3H5ik8nMku72Ffu
         lVIWw7lW1HfaQk9LXiZlsgB9BGAFX0FPgyEOEXn+tzHvz30PMQQ8mjwuret2zuliZWBz
         hnk3cO06O7dQekv/+qRnW1hY674K8zPRm626Q8DH1K+/FrSfmvgK10M0cqVTA1TRhNti
         /zURden96zcoPMemyEd5J8431tRFLhK1tlWwGmmXTUsZus/IiFAjDPs9V7yHvNSuDXfa
         iOV0XzNSxox+XUX0stcvPOUPrxJl1Hu5AkkQPDAkOY9sCpYyVlL1I7K2NKYbldz/5JJB
         ccBw==
X-Forwarded-Encrypted: i=1; AKwUvBxkn3YhbpJb/7cdlcNi9+e1q0+3Uu+uZtqEk4pWb2Sc2OUqHAySV1DzqF7f2KRQPoHdBkE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnE1/jWXDfJplYUT6QR5MMUYi5WMoIeoLENn8pjD0YEN8gBNyY
	3qkuI5HMHSpf6LwXZpebXX/FbBts/Zfp3HbCZPaXnkLRL2mvWLqiSOlM
X-Gm-Gg: AYBFou0qh4WujckgBIP9dBoYVq8OpCmaBEyHNxlQ9NNUB55p2qCgH4amjoVAJVZvGJG
	vSQEuqfjpPGrsXShGGUI+jC6Efh+zkK5ImPZtVXe97eHo6e/PLDELC1rfUex3RfLw3/INk//NMO
	wW9ywm3nwA2NBdOCbCAOcG/D80YJ1cN4cMaF0T5vb49eTyuC0mC2ENx8eUysuPh/1u1Y/IjluXI
	OIfBuhPQjrDsQUPocVOj82LhSqwPfrDqhx5SqrkPip608NiBzl2KMTtPgjlJ+GHtW5RZi9/Fw5O
	Xpizn06cF8+wrAbhvP7X6kU5y2X8zhIlgvnEtcHfolGnQWSMhv7GUQE2grWC9niYnM4gYjREfff
	yVj29Ng+p0y8DPg6mlkXR0aFKy2lfaj4I1HOY5O0B63YAAKQe5+Tevt8SWiwE1GnBuMPx9Zwwbb
	mWlStaxdBvyUQAkRPI+xLwFlWgOjKroqn7lUAVy0K0Kjy8T5H8S7GKfqAwsGZXiig+gLRhUYq0/
	hb88df/euM6vLsCVZUQ/Lr+kl0tJ9bCC6tPcd/bQ6/ScQIGcrILrBd1eb+HyG0BwjcgpP7peKLP
	nZem
X-Received: by 2002:a17:903:124c:b0:2e8:e17d:c8b8 with SMTP id d9443c01a7336-2e8e17dedffmr119328715ad.63.1792118766078;
        Thu, 15 Oct 2026 19:46:06 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804ef4sm3090825ad.18.2026.10.15.19.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 19:46:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 02:46:05 +0000
Message-Id: <DM5X2Z5473A5.DNWH4JDJTYJF@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v3 10/11] bpf, x86: Give a kfunc's stack
 argument the 16-byte alignment it needs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261013171035.2137865-1-yonghong.song@linux.dev>
References: <20261013170910.2126673-1-yonghong.song@linux.dev> <20261013171035.2137865-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Oct 13, 2026 at 10:10 AM Yonghong Song <yonghong.song@linux.dev> wrote:
> The JIT places a kfunc's stack arguments at the offsets from RSP that
> the convention gives them, holes included, but RSP itself is only 8-byte
> aligned in a BPF program, so a kfunc can get such an argument at an
> address that is not 16-byte aligned.

There are no kfuncs that take __int128 on the stack.
The kernel is built with -mno-sse, so nothing but cmpxchg16b on &g
cares about this alignment.
Can we drop this patch?
because...

> +	for (i = 0; i < n; i++)
> +		EMIT4(0xFF, 0x74, 0x24, disp);	/* push qword ptr [rsp + disp] */
> +	skip[-1] = prog - skip;

  u64 kfunc(u64 a, u64 b, u64 c, u64 d, u64 e,
            __int128 x, __int128 y, __int128 z, u64 w)
takes 133 bytes total. BPF_MAX_INSN_SIZE is 128.
do_jit() prints "bpf_jit: fatal insn size error" and the prog
fails to load. It was 92 bytes before this patch.

pw-bot: cr

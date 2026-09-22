Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5E2E2663
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042109; cv=none; b=gBI/tNcvAoOW80gYZwYM1jX0n+JD0OuGBySGiOUG5PJ9LIbCsguLsFWltjdYFhUvBgkoG9GQc2Lmq2m1b1NU4aVtB0p5pDKLB+AFcKjjqYQMvqgxBjM01KmJwjphOX3XOAKzVSNHhBbHR/dfnE9b8KJ8QHoszBx5BhhVYMypjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042109; c=relaxed/simple;
	bh=kmwinMqyVyK6F6efS9rTUE8kNEppKMqQ9v6+PhIJL9E=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=P71q/w7ezL4XUulSG52z5rA1JVg75eOJnjGZMIsGFyWIeZQLcxI8t5KTghtxDCyQnNxH0qzicm7Rd9wa5lubgP1DZcAzxSET/UvEKsOtWrEImpAGLDPzLrE1KmkVSHC/P9AI+/1APaiQArQEQgMfHyu8t1Romco/O/dhs+l7VWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj3GvVhg; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj3GvVhg"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd4b43b20bso25919825ad.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790042107; x=1790646907; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g4jCTOSbAnex1HQAgqcYLzBLa9FVcPlYvAMPVHtej0s=;
        b=hj3GvVhg/r5zNBEVjeKBfncOFFaxtRWc/vBhSqZPzpcp1+NmUS6mC6XDOuS1beSbDK
         vUIvg7IflcCoaDv2jZuB5abd2c5lKNWvW+d4kxdvlsjyocjSkgLFiVRoWQ9sPWdN0sAr
         O+awGKH8ciRwq/kkBvLwX5So/5XKW0BB0klxsj2av0lXbIfRrAzTZ35TnX/ElzpkofXh
         ZWJ/wv9pGOp8ZR/z9oGVMTBjbApTGm+lqJYG7Hd+nR+1YyUK1Q+Xe00No6MzTWBczRhw
         YCScICpqiJciEsk4vwDv5Zap/t44AwNwBmRB11pdaG+fDLEBjYsrz0FR1JORtXB0/R76
         IxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790042107; x=1790646907;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g4jCTOSbAnex1HQAgqcYLzBLa9FVcPlYvAMPVHtej0s=;
        b=l9fZB3Xc/0kI49uGqws8FJHf+WqDMGat3Y6wjUOvR9IDjD+Kzzr4hIwLSYx5BQ2PLJ
         vblIcdOvOIQ0puN5AeKShgaWaEfdqIKA2+nnD5zIhN8UOOTpT2rgHuzghZ/vINWjrqvn
         GDqiBSi2Wd0dUZ+fSKsHrGvVfsLnYMl22DbqOMoNLVob+hZu8KHUp9TW5Or9UDCAXKei
         x31ouhUm/D6Ie+Q0KypTNmN3XIgPy6utmlDz5fFGtAmzKBEFuZYKPF0a9PL+MsxkZ1NV
         i2hBjuC5RbI0IfVgTFfhw38uXDjP/gSYgdKsMB/rL9YBvh13Sx5VgpVJlpV9Y++N5gQU
         HDuA==
X-Forwarded-Encrypted: i=1; AKwUvByldvr1gcXIB9RDVFECnVwRuoFdKh8Em0v/rMROI8F/RugSzghPtWwQjGTXf80U8U1JphM=@vger.kernel.org
X-Gm-Message-State: AFuF++l3ht8Owf8smoMaCaizLErMq11Et5SVn6fv4TJw8Qvy/QmAsAGq
	yyktd+oHQ87IBmET+dbhxIdVrcUqNiQE8a5ATxeBelfqerIku2/1QG5R
X-Gm-Gg: AYBFou2t8gzKm7J+OmiyKUQUA8E2kTdn8rxhRAoLLOtxif29xSZkf/gIognSX/22epp
	1+NPtFRHAEeqRbc4bt3MipoF5GLnvy9q+YDEtcbxm3N97zZcQSqG0vmnGInYx22ZlivhvKDQo3n
	KnQjLdRafvxw2XV0GoX78G6/qO425nOl3MZyLBimyNHZzbZbI4+3GWhQ1YEespPW4Jtm7bmKD5E
	VSwMqf5r8X9ELeFg9XMT2UMymwmfLE44Sti5v0OLwbSY+quYrmArufwRJjOJGxaAzatuET8SdyF
	8wfMI8mUgPHYLT5iki2UpFgmUjjStFpiDrKgaPqCzcSywP6GT5mpEkwxWhMt1B8YbHNDAms3DvV
	Fy0slbWQvw8J0zD6HzRFrBdqPzI9o1p3nKwDXxjOncUORnQh/eF+qeUszXf8StmoKDsb+n8THC3
	568IPKjdvpc2OM8nYOko7nVh/OUfp+yLASvh3fgNNTzFNN/zNEW5ZWc/3RLeneSDWgG9XS8HZ8o
	iiQCHL4iMAv1yM8tzKeIR/jZqF7MlXIjOdwodRTX/TGBqjw/ZQgSyb8+oz3QoQFbu3Gh241fNHd
	Eqa5KJUwic2wRQ==
X-Received: by 2002:a17:902:c94d:b0:2dd:c100:424a with SMTP id d9443c01a7336-2ddc100453amr120434615ad.46.1790042107183;
        Mon, 21 Sep 2026 18:55:07 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d066d3asm1193085ad.78.2026.09.21.18.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 18:55:06 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 01:55:06 +0000
Message-Id: <DLLGYV7DI406.JRNDNAZ4S29I@gmail.com>
Cc: "Amery Hung" <ameryhung@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Nicholas Carlini" <npc@anthropic.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 0/6] bpf: Scope callback arguments to their
 frame
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
References: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 06:03 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:

> Neither has a local fix: both arguments point into a helper's own
> frame, with nothing longer-lived to anchor them to.

It's the same problem as a pointer to callee's stack.
check_stack_write_fixed_off() deals with it like this:
  if (state != cur && reg->type == PTR_TO_STACK) {
          verbose(env, "cannot spill pointers to stack into stack frame of the caller\n");
          return -EINVAL;
  }
CONST_PTR_TO_DYNPTR wasn't spillable before 7.3, so nothing depends
on parking it in the caller's frame. Reject it there too ?
and then no need for REF_TYPE_FRAME complexity?


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633551;
	b=pfPl6jmpsMdh2pG66t1x2oR0M7U01mx12a0yd5x8/6NM8daoIN2LptPujS1IobqZgNwf
	 mt5MyU1oCmdcqvVBjeg6gI7d/g6ajDDMqo47GA8Qhv4EqukqijWehnFtpmvtdc8CvrU2r
	 cFwp3HkcUPKqoeEeMfnpLgPaOsL3vk/I59NEIfqe+/KcUk5A/WWbrOfebXVUwtzxJW/J5
	 wKay0uqp6j0VQNFPRsSCyqvo2IGvJfjYEDElClHASZlLmswU6t7gj/zD4qAQ7Md2sFIXN
	 sT9FPJm7ca0kMDKfJs+biMRFEFtWgqI7xqjzaEbhe7WneL8Z0Vbn9YFHMW1rdYh9pKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EY6w23YOysdkoo837RmZUgYn48ZFmiggooztRv6/io8=;
	b=MAeD0mnFP+YxwsvIBXv19imRKICRxv/ylENgAmO2WGDOkzXcaCq9bledQBkyNipw9G6j
	 v4R+f8OPb/X1F/nMIGdMPfWx1+WNOja/+H7QgYGRnYAfIRUrQrTJ68MC/YOXUfB7eXgWR
	 kf6XL9Agfe5JSfZHJ+Qmy06RrzUu82ERKEYlOBebhJMb/lXetS4aI9Tv4kMBFK9NJHskM
	 xoiiB+4PNWUvmgOAvqPn8amyFERwlxR6YjolorC873iDB/fpmxyrelmy7Ozdd8CNpx3aA
	 7X6rhjf05G+SL339qWus+dRak9Zoxqqccpas0QFR1JK5pQhH2WoIhoBmMlsQwGsrFLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yuQlNUe1;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F5606A323
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 05:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 427F5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yuQlNUe1
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e987a2ba0cso9143225ad.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633550; x=1795238350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EY6w23YOysdkoo837RmZUgYn48ZFmiggooztRv6/io8=;
        b=yuQlNUe1ejavQXnsl7eQEw7MHFH7Vy+LZ3PU2DadN4IB1CZ5vcwSF3E5MJgc5LGkN8
         Yknc/xttWLUOhS018Z1jffJLYvioKmoUVNsAdbCcJeMTvWy8EtoP/eO4JDbojztP9m9Q
         tsDrg2T9diopKT7Qa4WKlDdcOmNzKX651dDbxhwgFxNVMtdLgbeRusWsg4ZrcotNKCnR
         bT/RIGOUN4Wlt1MotFw82dulN1vPa8NNYtt2Xs/oOKj3Ft9p0M+iOSbdfrTqrw8lNZhc
         vAwS+2ekJ/8JkKhMmQhKt8UmF0qhHuf/B0zzMZhDK2M6s742p5/BvqghSAvcM7mRU4Id
         8tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633550; x=1795238350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EY6w23YOysdkoo837RmZUgYn48ZFmiggooztRv6/io8=;
        b=Jgd7KAsD3EtA8ui3ZyBoUiTpXei2N0YhOYZLLoKhk3JiHZ/ajzpUPn9eVtSF/rdOXb
         zDszKmZmviqZWIxGtWafzE/BRSt0Xhz1eMeF456SmAMafWV89qEk6jZEeYsf4+nTuhBC
         BwAGhIT9X8bhChP8mZNfDNeGrZO3g2brwgfSb4IehJgK4yVzoYvBZuLOucCsq3vtnQdR
         XIJSw0WfAKa9EcBLIzgH4mVfWHo58QZrloZe/OrkewcXmn7Em6RKOOAg6sCR7xA4kdtU
         j44ekbszWeCBg6OL7Ql0MrtjUVM+JJA9q0lJale2+RJTaEX5NrDQOz69KX8iUlxNkI3V
         +9Fg==
X-Gm-Message-State: APuU4Z+V3vr5i0VXFkYPUVHgo9ixGy42cuPggIglZKE6IOY84u5w6f2z
	klRs8eL3c7mft1xRH56P/AuNwKZBqKbpxoM2pNztFEggO4OLg06iKDBvJKxkgA==
X-Gm-Gg: AYBFou0mITNu239Xjp/TnmiqZZIiSE+DunCZNZ16irrI6B7W59VUdzZ2TU5oQ6Plyzm
	4KxLquDeoNoF2nFs3beyIUAYTQ58FlhQ3JKDHwa8IhNTrb8OKz8fURDqOTMBZH/+SY4xYPWkaFG
	NvxM9W16za1O0q0lTzGJieuwYkm9hcoeLOI/avDsd6n/c2qV6/JbBIjvnOqiYHfvzd3USARQ/hS
	ifNSfhiRErWoAOwaJel+mLlwOLC2kSUcoPHwvNn8rZIV++WWTE59Tt+/CfafyzaT3B3qWH1xRZv
	S8J7Eh6dJsWPtBojDRno6juXc6phFJ/DFN6u5XcapJjgyhMbbKqOy0Byw24ZBnhNnIJ0dkipVka
	5vAVspXtv2FfnX7UaqCH/KDkVZluE+/nI9T/EXXiXP+qeOi5mYW1rXeW3WmyJDyl5DExIYzz45j
	0rEXSOMIvWN18OdZYz8ShATSKB2dVCBqkyrfGP4kkd2DfsvvULk7mSBWON9N71MSyNcAV49MIv/
	GOn3qn5ddFXnRls8eEY6U4aS/j3wKsh4c0xbycoLDglTy1C7DisR7YQaHdkGVNDNz5gbr6PDDbE
	fVSX8u06mplWvC7Moqb7YlnKRjj93mL8366v5H6JWVBA7Tb6UhPouUPO6izowCRg9QIH7PhKDdA
	1v12LoHtpNmeetPzl0IDHL1audWR3BbEDyVsNzJPfo9M7R3dxIF+Pqv1pRsbaltTwP5y0Q9DOhc
	7vnThSATVRdhad0ybX0mg=
X-Received: by 2002:a17:902:cf0f:b0:2ed:5548:298d with SMTP id d9443c01a7336-2ee0dca7c25mr42517075ad.54.1794633550357;
        Fri, 13 Nov 2026 21:19:10 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75c875sm17788695ad.15.2026.11.13.21.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:19:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v3 bpf-next 10/11] bpf: Require the JIT for fmod_ret programs on tagged 64-bit targets
Date: Sat, 14 Nov 2026 05:18:04 +0000
Message-ID: <20261114051805.683966-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
References: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anton Protopopov <a.s.protopopov@gmail.com>

The interpreter returns unsigned int, while the trampoline passes all 64
bits of the return value register to the caller of the function. The ABI
and the compiler decide what the high 32 bits hold. If they are 0 and an
fmod_ret program on a tagged function which returns long is interpreted,
then a valid return value like -14 reaches the caller as 4294967282. This
value is not 0, so the function is skipped, and it is not an error either.

Require the JIT for such programs, as for other features which the
interpreter does not support. The caller of a function which returns int
reads only the low 32 bits, so nothing changes for it.

No kernel that has tags runs such a program in the interpreter today.
CONFIG_BPF_FMODRET_SCAN is for x86-64 and arm64. There CONFIG_BPF_JIT=y
forces CONFIG_BPF_JIT_ALWAYS_ON=y, so each program requires the JIT, and
CONFIG_BPF_JIT=n leaves no trampoline to attach to. The rule is for the
next arch that gets the option and keeps the interpreter. There
net.core.bpf_jit_enable=0, or a JIT that gives up, hands the program to
the interpreter.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Co-developed-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb41713641a..a22037ac9068 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24533,6 +24533,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	env->fmodret_retvals = tgt_info.fmodret_retvals;
+	/* The interpreter returns only 32 bits */
+	if (env->fmodret_retvals && tgt_info.fmodel.ret_size == 8)
+		prog->jit_required = 1;
 
 	/*
 	 * We don't get trampoline for tracing_multi programs at this point,
-- 
2.55.0


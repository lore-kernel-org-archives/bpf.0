Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA957400DFC
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355342; cv=none; b=RiiqF2anmCjHYcd1SrwHlS2GH03CzwSXemrZ8tbaJEk7VIFsezE2pSAa22D1DHi/eveMuGqT+OGAtmCmmW6O+GgV33bsODYuJK3lHGP05k2tgJ8CldWsLGXIIebxAVlpRaLlgXDLnaMrB22dfLGTxWnX9XzsH3rKjZ9da04aXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355342; c=relaxed/simple;
	bh=RZYh0Vkz33ernshYGQNEPEh6sacgZ5u1cmeiqxF/9Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQzPXRtiVVEGTnpa0+II6wcg/WcHPe8rcKOkKrctCrtsTMu8SVKXDeEjQOkZZTWLLxZRAIrPHHRihRiIBVwi/JjMZh1vXO2kp/ud/N5u8qxkvmBqxBL6u0gaOyS2pTtx4Ds4XWMI+eyQarSKjAnZkCLvNZNUfH+LVLLGdcsEhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9Kgw/ka; arc=none smtp.client-ip=74.125.228.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9Kgw/ka"
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c219353e5bbso98216166b.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355339; x=1787960139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HdTQQowwwx5mxwkOjci4FtVllWvq/i/d6hbZbuLMrug=;
        b=E9Kgw/kaaXO+VqkXMUER/MA+Dg8p0IASFWBtria5M/gdYkbpLh7PGJFWZwNxTNiEuS
         hikJjg0a4or+9dhb7aK5HTPTAq0zpSaAvlv54a+SmE3cTSQa4mAGckV8JjA/8NbWacnE
         qyT9KxiZ37SNOn2326rBm6+A61PGQrgv1ntGCAwyrrRwHaBdmhgVJawiaw1ekDKSJQfu
         8T8m7cvjtRcIpj9nUA36RzTbwLpbqAWj36vucjPW+Y6CFVjm6L5lit764C/nudtZTsLl
         41+xCOr9pM2cd/Fbqj/f2R6KmfCsB4sdkPMRx0BnbeAMh2hnQ8LYp0BwJEoS7JtkSivF
         m6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355339; x=1787960139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HdTQQowwwx5mxwkOjci4FtVllWvq/i/d6hbZbuLMrug=;
        b=KbFffQfG/K02+3pdzqP97KX5EVL8S4ZNM6hPKGjVhWIS14QY9k4lWH5z82o7LQbQ6d
         3tXf+tNlP2X+rUwDVIKwFW9TNgznZTLTm1q6rmcWJRHEyob7+BaS3pT/0qlaIygccSEx
         3eQ07Gg6XS8+LYqVkEuXP4YgRTiU7gdLz2Hzm88nixu96tvGSgvX6fqKk8vK6LBzufDk
         QR5mF+Gvj7/1oKI45cnZNTvPWk6XdIHmyV1JwuwU93ir2AQYCSGUZ7oOe0J3t2oMlvtw
         YnkoEI1fUK7wXKnaDYi5oGxG1uY2fi37imqo0gfgB3bntzx5NAIRueLpvGbqdt0T2kkX
         4r8w==
X-Gm-Message-State: AFuF++n8b+panBtCzWFTcF1BJDMG3/TUhii2eTZ/Uqnmi978HPzSD0dA
	a2KsVDMAAh0zcIvFLqkvm5I+yU8poS79HzP1hw5H6riOvU14LhuixRAeMuFQtCdr
X-Gm-Gg: AR+sD12l2NjY4H/U6ElMA3jrW9qGLpjcbpJicA4Qvm/Grd9YOhpmMRwnO9on9VCpufz
	uDiqhFonnWXaQMOGITUEzfXdYAcmpeT/IWOkmdXTA0znUGCXBh/16fi4ak8YgDBcx1YZd1G8anh
	TtOyoYYZddQ5Nbx8xjjqSircTelxTurx4Hpvm2M1WqTX20FuWTsUbGARCDla+g3L7tz9XNxMwRc
	vOyr85N1/4hYpsKbrTJJiruZzHwzV8rXDqYcoho/bZUeIEvOXcYwNLA4BoQvdQ/fUqsVkBTZ72T
	GBlKHWMd/z6YuF/YY9LXsrPc8jMF/pIEfTHj8YTZPzSSmLTzbtADhSZ3aVuwvghmZsIcxPx+xDg
	ewhnlAq7ml9Qc/qDvPLIl8bLYfMPP1hLqwlvJdNiub2MjAFs1D3QbiviXnDxbgyRdwi064fvkzF
	l2ZYmhCzOIkpnS4WjCPUbFNNAhIzCrVhcpLZaFIxOPp6EviOsnHDvFzoA098weJ0rvRPnqay/FT
	ql+UbHfat3hDxVuRjbwv8ixivFFMr/C9SJVMvECIEdHUSXQ7r5PpqEOkD7b6b3Mf3jy6HgcHgJ2
	Yn8bnESsBbOT+jyyYahY7v3/2lZ05PCWlA3aMA==
X-Received: by 2002:a17:907:1ca0:b0:c16:14d1:b529 with SMTP id a640c23a62f3a-c249262043bmr188960566b.18.1787355339193;
        Fri, 21 Aug 2026 16:35:39 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24968ba7b6sm38862666b.62.2026.08.21.16.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:38 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 14/14] docs/bpf: Document split arena argument JIT capabilities
Date: Sat, 22 Aug 2026 01:35:08 +0200
Message-ID: <20260821233516.3426127-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821233516.3426127-1-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2337; i=memxor@gmail.com; h=from:subject; bh=RZYh0Vkz33ernshYGQNEPEh6sacgZ5u1cmeiqxF/9Fo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjwYS3uQpK93mmHmx76hraJS+28PblZC7xLr81v2aJL 9K633e3o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABO53sfI8HMnd8tZy0yHg8tL 4uaciVpekJU5z5XLWvjl7+1ddrdDpjL8T9+2RPhWgX3XmWk/t+0yzbPWFQrj3jnR7VWPXYHKoht uHAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Arena kfunc calls and struct_ops callbacks perform opposite conversions
at different JIT boundaries and are now advertised independently.

Document the architectures supporting each capability so users can tell
where arena allocation kfuncs and arena struct_ops arguments can load.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 89dea6b0b024..65e56491cae1 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -301,9 +301,10 @@ An example is given below::
         }
 
 Calling such a kfunc requires the program to use an arena map and a JIT with
-arena argument support (currently x86-64 and arm64); verification fails
-otherwise. The program can pass any value without compromising the kernel. A
-value that does not point into the arena is a program bug.
+arena kfunc argument support (currently x86-64, arm64, RISC-V, s390,
+LoongArch, and PowerPC64); verification fails otherwise. The program can pass
+any value without compromising the kernel. A value that does not point into
+the arena is a program bug.
 
 The suffixes have the same meaning on the arguments of struct_ops stub
 functions, with the conversion running in the opposite direction. The
@@ -311,9 +312,11 @@ kernel caller passes the kernel arena address and the trampoline converts
 it while saving the arguments, so the callback receives an arena pointer
 it can dereference directly. With ``__arena`` the kernel caller must not
 pass NULL. With ``__arena__nullable`` a NULL kernel pointer arrives as NULL.
-However, there is no obligation to prove to the verifier that such a pointer is
-non-NULL before use, in-line with existing semantics of arena pointers used in
-a program (or obtained from any other source).
+Struct_ops arena argument conversion is a separate JIT capability, currently
+provided by x86-64, arm64, RISC-V, s390, and LoongArch. However, there is no
+obligation to prove to the verifier that such a pointer is non-NULL before use,
+in-line with existing semantics of arena pointers used in a program (or
+obtained from any other source).
 
 .. _BPF_kfunc_nodef:
 
-- 
2.53.0


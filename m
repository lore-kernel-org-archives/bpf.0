Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B42FFF8B
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778613; cv=none; b=niSkl4TlenyjW+YjA7e52BtoZX4yRyAAGHuYWl9VdClaC8x0T/Lg41ap3lnkcCvArIdM65/PoRgn96eem4FXuASZLA1+C7bZ7ETrqrDGD8lFMMw4hM2Cw8dmY4vejwDfw9hDvr3+j6QbRtFrjbKDA4gXBVRKfW2fm4vFDH7zGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778613; c=relaxed/simple;
	bh=s5af3FSSdggh8ZfIqiW0Q2gXNka6XVx0J/FgSFArHSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DIcawQvLTwzzHLxZltdhfLHuPOtMbO07l5PzjS6V7RR/0ouoD2eJNlHFkP1DpO0WK3/FI3NLz3MXQHe1h9jfSLC7M88eT4En1mXWccIE8f2b4urYGXoSSf3rQNsvBRCBm8fEk5ySYfuKWL51JKRTpom9baAujWKtc1HtcdKsyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6eCxyeE; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6eCxyeE"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-482e067ec96so323481f8f.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 17:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789778609; x=1790383409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Di6RKXy3XE+cdrUcF2GWR5aS87EGejPGZXsGdDElrH4=;
        b=J6eCxyeE/Wa4nR9rMnK8eIn71TnJP3kJ2NY7WdepopHKvTTy36ASneCS7gIpF60AtO
         eQXZlBqDFhellEekGfpbKHJzhDtxPC8mF+3saUAKQquLU1gREmzLmAOB2ZRWJIddqvys
         rYFfpZZOHlHfbaKwSpvsPlUyU6pJJqxNLNaK6El99Y4kUvnN841VRSgcZPLgRmSNjC86
         t2Sru4KFdD8GAzeBmJNeXMYd9vwPqaiu73Db98CsAKqLjuYJjn2PYoiort7nCUCbQi5Z
         HeFRuS9pp7dsT/yLiA1of9lje6YiII/ZsOwX/buiIozz0mTIkk9veIFjgTt7dlNAK4Gl
         yUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789778609; x=1790383409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Di6RKXy3XE+cdrUcF2GWR5aS87EGejPGZXsGdDElrH4=;
        b=ohOjFRpDIloApBFU4TWqOP9Vy37osK2MjTk7/5k9QluNzyU34tx38iLb4xTFLRh+yC
         jcifo5+ZlHBarqfwJAPv/yCz9B3fE79wLKf6rJwdHbCcpS86phcsSE1rzZZlUeJAfCR8
         H7iX21NKHzZ3INPGKDUiHa/KkOsjEQpdR1V8qKXaXCuzewKEpLblDBz8zkSll9OmOJWA
         rTqDT/VL10SwXBnpGG9KxkHpyUTZ7xOkZfgHFJVbWZ+YObQZSrRaObDyVF9YbF5WOvdE
         zheFYm0lG95tq4zE0C/Dxv2XlTn9yTbgxNToCf3nkPK2i52e0Y3jo7zpCQMJW5e9Igam
         mWiQ==
X-Gm-Message-State: AFuF++lCuaZVdkBZCUZ0ySuZX6/tKR4UZ7uExkkJJ3BGwmbiWOTF36/P
	Olg+GYCtgYCd92EyfMf6ADXokhiMB2dJl9sGWkeWEffn8HO5iwyw1IPZ2x0QsJmL
X-Gm-Gg: AYBFou1zzLZ+r7ohtb3GxBXIw7Pxmt64pdzjbabF5WQqS24nrX88GvAlBVv4J/HGly3
	TOZxhQ+A+W/0/yVAjzLFo3rGcDuOBQqded55QtAjPandjXE5Ok2z/au0bZyAq6f4PGz3dLWQXmE
	EbT1BdTce1+FkN3CC+N2iqUDJAIcFCovKLYH9+hUH4/MPRY11ieejezRYHYbY+eCWOKBAQUIXHk
	G/3S9ZD+7I827Wo+UvQbBl+2vvI5LPp/BJeYLy8YVZHM09N0yHsnZnE3u3xGOUBJbHfgWPDgSs/
	s9STL1a1G3q2F+PfmjXz7s148M4+i3kxaaniEDoiPTMolVPhdiFrZhuF4Uz+BA6YvUXjzpAtpCb
	iNVxvfjL+H2MqbN4zUGLSSpuIk5oDbODeQ/II525v5exc3GAcXA5aUgU7t/DzJu7dTzQiU6xqyT
	zJxn/NQzjSrGbMQfwlTmFRmQDFqdUSj8quBtmJwvTSh8mBhpv+TY8BJHGAkbQzRPPWGzcc8+Cnu
	mFuaj56ll1pB9449IYXRWUw5Hu5rm3s+NfdGJVwQff0fY8RTd7UUIW7BEUWxOEJydxuVjak8jl+
	m0OY4q7rDa3+G4wj8CIOTmo93cWiPkZYXFDiKA==
X-Received: by 2002:a05:600c:4e50:b0:49d:17d8:abec with SMTP id 5b1f17b1804b1-49fc5728fa5mr55878215e9.21.1789778608728;
        Fri, 18 Sep 2026 17:43:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd068059sm30998435e9.5.2026.09.18.17.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 17:43:28 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 0/2] Compare stack frames in exact register states
Date: Sat, 19 Sep 2026 02:43:23 +0200
Message-ID: <20260919004327.1403382-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027; i=memxor@gmail.com; h=from:subject; bh=s5af3FSSdggh8ZfIqiW0Q2gXNka6XVx0J/FgSFArHSc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvtzfeODjMLA4oUN2dUxCxe9jhj3+3s6Mdz+df4af75L vK35tqajlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzkGRcjw9yS039X+px99aW+ MexwzcJVPV4TJOVa0/Yde82gsO6Gax8jw+v1nWdD5bIMCxt03inoyi2Yo3f36w2jOYZbqr3Fhd4 t4QEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

regs_exact() compares register values and their ID relationships, but it
does not compare frameno. regsafe() checks frameno for ordinary
PTR_TO_STACK comparisons, while its EXACT path returns through regs_exact()
before reaching that check. Infinite-loop detection can therefore mistake
pointers to the same offset in different stack frames for the same pointer
and reject a finite loop.

Move frameno into bpf_reg_state's type-specific metadata union so the
existing regs_exact() prefix comparison covers it. This avoids a separate
PTR_TO_STACK case and keeps the structure at 80 bytes. Adjust the
states_maybe_looping() comparison boundary for the new layout.

The selftest keeps a stack pointer live in a register across a loop
whose only change at the header is the pointer's frame number. On the
unfixed tree, the program is rejected with "infinite loop detected". With
the fix, it loads and returns the expected value.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20260918011313.3053497-1-memxor@gmail.com

 * Rebase on bpf/master.
 * Drop the redundant spilled-pointer test, since existing tests already
   cover the stacksafe() -> regsafe() path. (Eduard)
 * Place asm labels on their own line in the selftest. (Eduard)
 * Collect Acked-by and Tested-by tags.

v1 -> v2
v1: https://lore.kernel.org/bpf/20260914161340.3419141-1-memxor@gmail.com

 * Rebase on bpf/master.
 * Move frameno into the type-specific metadata union so regs_exact()'s
   existing prefix comparison covers it without growing bpf_reg_state.

Kumar Kartikeya Dwivedi (2):
  bpf: Compare stack frames in regs_exact()
  selftests/bpf: Cover frame changes in bounded loops

 include/linux/bpf_verifier.h                  | 16 ++++-----
 kernel/bpf/states.c                           |  7 ++--
 .../selftests/bpf/progs/verifier_loops1.c     | 36 +++++++++++++++++++
 3 files changed, 46 insertions(+), 13 deletions(-)


base-commit: b4e875d397da451fb4e9c573ff4b86db53caba05
-- 
2.53.0


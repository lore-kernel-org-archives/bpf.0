Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793321360;
	b=xhy1B9U1fdd/4YqAduz9wssy5bBV4uWCh9G0djda4NXwX3raK9h9WadMJiZEEOg68q6k
	 tLcR6U+rrYYCQS42nTJrdGCb1Avv1K9UF2kYcAOzgLDoL+OAbPTRLD6Zx5lxqZ/r+BKLo
	 M+SjNMFDY6PKYZ7NutZY6JjXyTAw2tSVrgcm8N1yfUzDsf+qhhhh72C+TidIVa3IOc6GK
	 RFteVy1U98lGyAGFH1xIdfj6ybkn6OTEs3cHkUI3j9Vxti0rjN8MojJxREH/6i6KYOX1q
	 DstRyJRgUYxGcKJigTW5pvLK63SLBZ42WCZDN1q6pSRelfzxsJGkHgYGp46TnmtvI3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=EeM3D31E2eSYjdhcWDyWLCwhjM8hc/qZ+87RM9c/GcE=;
	b=Xh9g/+z0ntcsG48A/uLt/TquyZc2i5rppW0PeqrkOa3eBCVeQa+RVRSUl+BCtKVGcjp8
	 mke/VQeKKixJUlKzz40Pgcqh+XOVIhGFW0FI6aQgNusePZmSviGutdGCuYlvQPzjU73Y5
	 yK6NH0SmkcetWaSMFx0bxgvCBH+OXaRrn4i8M4nvqQLRObk+jJMw4hswkPQlcJdPrObx1
	 HSjdRZ4ztFEvZdWNgVJmAgdCsflIh5Va9k+Ky3h59bOcgevTmFdPPqF5QNs2Dp8OfXKtj
	 urtzIirSacKpNAT7wS409UhMDMA+0ghtUZXcDAqF7zO54jhLV+5zBebXL1daaFbwWZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jnm7yDRZ;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25775606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 00:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25775606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jnm7yDRZ
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso1722607b3.2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 17:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793321359; x=1793926159; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EeM3D31E2eSYjdhcWDyWLCwhjM8hc/qZ+87RM9c/GcE=;
        b=Jnm7yDRZzgh3wEIbH41vNkuSPYTMFlu0SwbTT33zx/ogtId/M0jppaJFYSP9gUSViz
         d+NFbTKj0B7dYK5euKIAGwHSMrYpidzKQRx6uZFRdaZu2yAArtsAnog413kdyudBCnve
         k812UWQYl7V5CmJVtTV2j1kVlO1CDALWRWcjMg1D6nXEoJ56gmnt3UQVgnYoqWl8tHmb
         R1yatjqM1wsPfsveArvF4WYYViKClMtbLC6t1G9UBlqMplJz3a7vAL1oQ2ptWn7a5+E2
         H4JZKPx36YiL9WifQaTSa+J2eLUbALE1UnnqSjVXMytu2VU4WjhjJQVy6KcANSBkpaxs
         HMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793321359; x=1793926159;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EeM3D31E2eSYjdhcWDyWLCwhjM8hc/qZ+87RM9c/GcE=;
        b=A9EUA8sd6vGZEv2vwd8MmqqY8riz+6JlMbDIQakmkV83tJlG8EfUrz3LLVJ8VOusMp
         KubIA9zXxYw5ajKT1qbCl/GiQVmwNUbgtD8QuelruueOVllMzCJrbWfHqjjU2oDy/8lX
         kk2XZF3FbmeOvn4jaB5vNBe7+HWEDY7XqERC+huww5I8sX3d4ZjDLlMbGCxBlZwg7IBi
         0mlvTp0GLnp5B6BBh3JGEvbIdbMRsOqVb7Te8GTq5tY2pXPHBO4gCYG5DN2DvQ7yfTGG
         +3KNhHL5N0z2EeylUhdNTubHP4NihqpGXYAQnY7K/hxMLhcHg9jJKBGm3ZoJGRyS4EvU
         dUxg==
X-Gm-Message-State: AFq9FYLK0RoMfuQMMvIBZSio/G3P+wdSEd7Vq8ar+z6rEJEI1Y0vMOFy
	iftqzuhcKSWoGCrq7rwqoT597o3WMZ2TCH0JZb/aZKx+eJ92iZ8LsQLc
X-Gm-Gg: AYBFou2/EbaVF9y/V6rmlplfA7BaVQqi/ImJc2lUyDw8he1RRI/26kNEHlggojiyJhr
	Od3wVqTpJXv8csVpSHntDHceTqOOS1nLU/xHzueiAwHsPrKVHLIsHkLD7THkpcX1byH91CHpL9Q
	NzjUB1rlvFAOlLe91BZmrQslniqczD2Mg8gCAI+AgalAf1AOSYe2FrSMb7O1n5WewzJwnp48l2m
	Z89yVKCVxbMsj1/h8mAY/0WQ6lR0wv/ki+ONnnvJZX2RpUeBhcnUIAUxuU5X8IJv88i9RKfAHqk
	VLppEFzj2pFxSRIaST6+eu7g80PajWJXOctVwhh00PDtjy7QoLbnhV9OmZ0MSB5jYuGFHXFHQZg
	JI6ot+7QJ59qDdxc4S2YIr544EoWVs+pkP83yHNs0RNazOMCEiIUVss3MvbybMf5F2Cky/swity
	ZiKMAVLoKBBFXDC9QaJtbG3ehQqP1dK9TJB1PCkR3eIzSOZDJXg67dn6MC4PmvdrR67w1cAW9nO
	10vbOZshLcsdJe8uhjy6GGP68/7NjQPagj7h8GDc65XN0aekVx/vvVo4n225MUaBNziD9j0ZP/7
	l0NdIjfyOLnBfrzhyJx9
X-Received: by 2002:a05:690c:dc8:b0:8a8:7fda:15ee with SMTP id 00721157ae682-8b2b676a6e5mr4519907b3.50.1793321358869;
        Thu, 29 Oct 2026 17:49:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b714bd4csm1889657b3.24.2026.10.29.17.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:49:18 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next 0/3] selftests/bpf: Make strobemeta and pyperf
 robust to branch reordering
Date: Thu, 29 Oct 2026 17:49:09 -0700
Message-Id: <20261029-bpf-selftests-branch-order-v1-0-425cc1ef8581@meta.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIbp42oC/x3MQQrDIBAF0KvIX2dApQT0KqULNWMjFBNmpARC7
 l6aA7x3QlkaK6I5Ifxt2raOaNxkUNbU30xtQTTw1s/O+kB5r6T8qYN1KGVJvay0ycJCzj5CKCn
 nUC0mg124tuPOn/i7zsfA67p+wJHI53YAAAA=
X-Change-ID: 20261029-bpf-selftests-branch-order-10499cabb9f0
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 vineet.gupta@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793321356; l=2638;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=xvsRBYRP4Lx86ab5lUhEb31AKZ9RLjV94vLxATFGLww=;
 b=LfG1HoE0U9vkvCmlw20WVWYqIofr9QE25utl7EUUaOnx8hcSkr4fwik9pTOaqJ7sszIGufVkG
 54bAcQe4wMYBb8ir8Ezf7Jtq98TuNLEJEexaAqGgjA8ABtW4oEfbrS2
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

An LLVM BPF backend change ("[BPF] Analyze conditional branches" [1])
lets generic passes such as branch folding and block placement invert
and reorder conditional branches on -mcpu=v3 and v4. Some verifier scale
tests are sensitive to which side of a branch the verifier explores
first, because that decides which states get cached for pruning. With
that compiler these programs hit the 1M instruction limit (insns with
the current compiler in parentheses):

  v4: pyperf600_nounroll   (460,049)
      strobemeta           (157,733)
      strobemeta_nounroll1  (50,745)
      strobemeta_nounroll2 (108,121)
  v3: pyperf600_nounroll   (466,200)
      strobemeta_nounroll1  (55,975)
      strobemeta_nounroll2 (115,445)

In strobemeta the branches that flip are the early "variable missing"
exits after calc_location(): when one of them is the fall-through, the
verifier first explores every later variable with an unchanged payload
offset, and the paths that do read variables arrive with wider offset
ranges that can't be pruned. Patch 1 checks the result of reading the
variable instead of its location, so all of calc_location()'s outcomes
merge before that exit and the read succeeding stays the fall-through.
The payload format and the scale of the tests are unchanged. Patch 2
fixes the payload offset being reset to 0 when a string can't be read;
it depends on patch 1 to keep strobemeta_nounroll{1,2} within the
512-byte stack. Patch 3 makes pyperf leave its frame loop once frame_ptr
is NULL instead of running the remaining iterations.

With the series, all strobemeta and pyperf programs verify with both
the current and the patched LLVM, at about the same cost as today:

  strobemeta             167K-171K insns
  strobemeta_nounroll1    47K-51K
  strobemeta_nounroll2   110K-121K
  pyperf600_nounroll     ~423K (current LLVM), ~340K (patched)

[1] https://github.com/llvm/llvm-project/pull/236189

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Mykyta Yatsenko (3):
      selftests/bpf: Check the strobemeta variable read instead of its location
      selftests/bpf: Keep payload offset for missing strobemeta strings
      selftests/bpf: Exit the pyperf frame loop once frame_ptr is NULL

 tools/testing/selftests/bpf/progs/pyperf.h     | 32 +++++++++++++++-----------
 tools/testing/selftests/bpf/progs/strobemeta.h | 12 ++++------
 2 files changed, 23 insertions(+), 21 deletions(-)
---
base-commit: 33cbc5c2cadfe3b43f024e89880dd8fe2efb3a2e
change-id: 20261029-bpf-selftests-branch-order-10499cabb9f0

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>


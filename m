Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670702;
	b=Lj7W9TIIb8vl1r+w+Yc8vhrXAFlMwxz6BBuhP0FjFO5HAJ6I6ykfnO9SHB9v0wYpXeVp
	 B6gjeAcRrNMlN8Q1f8kDg2AULfH+G5+tnpYpgz0kPg5J5cq/UN7i8Au8PnqZNrZ//gi/6
	 prujtaM5hVO6YVa8dZm/JdpHuVVfzyFcibbtTy4ZRk8wOxsjpGrbhmKfi3NGnXf/u05HJ
	 QBseqsnI9810zGXSp3Q9eP0xFNp7B4SuyqDNaKic/F+6Iw+Kn36UOftNTbcmJEVpUPsVj
	 AD3wxeOU3r53M29ffTGvpC9Vf1lcsTUTtfCshipSwsTrN3+7vjr3/yxg8v+LQq33dsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=2+PL0BdhymuszaAqzLGLWPySod9WjSM2hocAOAcpS5g=;
	b=M0oPZCnP6nGpcWo69Z20NtoBlyhybJCbCDcPqSpC5jpLOsUvUGRGEhVYMKIF4cTNVppi
	 QIwzI81YL77YQhhzl8SFp5/ykhkh3qSwbO45siX8d7EXyKX2aOQi1wfG4BvgTeRnRo9pC
	 YJkMtPthFG7YWt2ZR3SFdyVSO19ko+QcoeNqY/PjKPdKsuUOJ1BixCQlmiecTVi9mplep
	 PkXwKdxiQfhEfDkS30+9ZYkqQuDM7yl+t8njtuXlZH6JlKBJsgCOqJPspewz0Wx6usGmF
	 qvsz+AuEk7EyB5xuvc/E2oovMhKboy890hkO5Y1h5wswBrW/+UCUoogeQw03teK/5lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E2EpafJP;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7509606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 12:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7509606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E2EpafJP
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b0dba37a7fso14399937b3.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 05:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792670701; x=1793275501; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2+PL0BdhymuszaAqzLGLWPySod9WjSM2hocAOAcpS5g=;
        b=E2EpafJP5cJo5QW4SJbq4FouSv2GzHYYp28vuODIlfawbzLrkrIS8rWD55l8z8p3q9
         L9APJBeBNXpCXohGiyDU88iuZsPbCQZjCCETwBNKkA6z1VzLrpXYBPe0Uc7WpbOQG2Kc
         ZnE0NWc/YJJ1ZT86RyqzOKE8k0hu6HgcFq0ZcvcBPBOucSa3Ryi3fduIBi3KMRm7Pxgd
         zCNSrds1sbc1fQd71FSKX9kGB29CgmVRrRSxDfgydER4Al/PaKhWN2S+9pcdcNVzaK+D
         utULW60/7H0rn4NyubI84GiM3Mf8fvU2sDsxxxnFKdIFzK2/Myl24K0p2QEMXg9ZmiNx
         LDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670701; x=1793275501;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2+PL0BdhymuszaAqzLGLWPySod9WjSM2hocAOAcpS5g=;
        b=cdJnC271Hy4XhSgBo6h5cF8BIqIvXZ8l3MLn+mP7wZ/BBPTes9jBAAFImDOUWTRtNF
         JfuPN+EE0cGCZR1xUvwxGbIwLBdaiYJxFOOz7l6YWF5jjLsecqz/SJkrv4UZpdIpO+eF
         Cdn8V4O++cdYIBhOl/jXcIhzVvzDZyEbZl6TCm6E0QRkGWT1YnRrMsi/a+VvhwnERIOs
         PZE7xzJeo3itinDCvXsvb9NPRsAuPCM6s2XhErwnjAImRcX7w48yPW/y535ew5ZtL12X
         3bBxAU4LhCSwAz+POtQ7hjE8Kqe26L8O3lJI7elfk0tT3Oxzaop7FGVitzil/1wrDrvj
         AUAA==
X-Gm-Message-State: AFq9FYLMoaCWYaBAjhIhoLZdSk9dxWoJ07oGp6HKJvDzQHT7Wp4sBmGj
	mtTBbl0eHzbSEFpOD4bvpdRnRyvJH73CNfmd9ihg+jcDnfjHJbA1Uax5
X-Gm-Gg: AYBFou0DejDXOT15ibJhnH0TiNcgAY3x6UtBtHnWrfwr+iW2zoGJ5k3yX9b5IB5yKu9
	eB/oNetN5lI6yDk86R65QUK6s3eYNIa093f38X5zmhcfSVe2DjSDle4qR3o+n1WP36guaWn6oO7
	c0un1GyYsxOR131fdY+NNxHHimHwu4QsnLzwLMGcGNg+Qilm7lTQT3L7FsmvPaK1mQw/7r1+lAv
	SvOhS+H2owVnIZZEGUb28mkd7whvEzoh+gmvBaYvyAgZLrG+wwvfuXj49gXmo/dtJ5FLVuS7D7h
	rce2lW8DvGOSKTlXdyhzU+OQGkt1jtCOwMH0rwnJylHZwSdqEfmLdjndyfnY2JEYire5jELmdog
	RNTRjukoEJheBid4sLcztvauxmVyoe6zZlir0k7iAW2Df20YSpRqyP+6qJY5y0kS1YZrZ4evgEs
	cE0bkWK2JJW0iX3apYbxmaY86CkcZ+ZD7pEu3dQYMj2lsnAnwIikzMQsocTgQYL+RRjkrJvY7nJ
	5ZtdVcr3ff04rYLoyn/PZ8qMwD9jfJ8UKMRw7J1O+HKVg==
X-Received: by 2002:a05:690c:962:b0:8b0:acc6:8e89 with SMTP id 00721157ae682-8b133fa1bc8mr25174197b3.11.1792670700647;
        Thu, 22 Oct 2026 05:05:00 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b130073596sm25519317b3.11.2026.10.22.05.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:05:00 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v2 0/2] bpf: Fix x86 JIT stopping before jumps
 converge
Date: Thu, 22 Oct 2026 05:04:54 -0700
Message-Id: <20261022-jit_size_fix-v2-0-4bee6921b218@meta.com>
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
X-B4-Tracking: v=1; b=H4sIAOb72WoC/23NSwqDMBRG4a2Ef2yKiUXUUfdRRGJyU2/BB0mQt
 OLeC447PvCdA5ECU0QnDgTaOfK6oBO6ELCTWV4k2aET0KWuVamVfHMaIn9p8JylM5Wqx8bdW21
 RCGyBPOeLe2LcvFwoJ/SFwMQxreFzfXZ19f/krmQpx6b1rtLWeFc/ZkrmZtcZ/XmeP8NWywKxA
 AAA
X-Change-ID: 20261021-jit_size_fix-da316b8d492c
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792670698; l=1643;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=heTurfQcR1GwW8nEI64/AfElAhckC7B7x6r1aELGaAQ=;
 b=0ijA3L0UgekmaLQiaquPBnEOcRfpXOpkaNdEkMpVV/nyb0TirulPC0MRDCHG5TfL7yi8vffeV
 8GemmhOQZRQCnKpdbdi0AlLK00uMNd0VMGSMWO4Y5q1C0FaowlFlkQp
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

The x86 JIT stops its sizing passes once two passes give the same image
length. A backward jump can grow while other jumps shrink, so the length
may repeat with jump sizes still changing. The final pass then emits code
of a different size than was sized, hits "bpf_jit: fatal error" and the
program fails to load with -ENOTSUPP.

Patch 1 sizes backward jumps by the insns they jump over, so no insn
grows between passes and a repeated length means nothing moved.
Patch 2 adds a selftest which fails to load without the fix.

This was hit in CI by cgroup_tcp_skb with the unpublished branch
inversion series, whose layout change happened to trigger it.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v2:
- Size backward jumps by the insns they jump over instead of checking
  for moved insns, drop the ja -1 special case and the imm8 limit of 123
  (Alexei)
- Start every insn at BPF_MAX_INSN_SIZE, so none grows in the first pass
- Check that the selftest program is JITed
- Link to v1: https://patch.msgid.link/20261021-jit_size_fix-v1-0-b89fd32cafd6@meta.com

---
Mykyta Yatsenko (2):
      bpf: Size backward jumps by the insns they jump over
      selftests/bpf: Test JIT jumps which change at a repeated image length

 arch/x86/net/bpf_jit_comp.c                        | 109 ++++++---------------
 tools/testing/selftests/bpf/prog_tests/jit_insns.c |  59 +++++++++++
 2 files changed, 90 insertions(+), 78 deletions(-)
---
base-commit: 65953903cd7bce4c4392ad6ab629cba78f24644e
change-id: 20261021-jit_size_fix-da316b8d492c

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>


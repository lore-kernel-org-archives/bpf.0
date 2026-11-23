Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409857;
	b=WBzkrSLAHfSnx64/0bhQu3XLRWSyadkF8ZNVj4U3SswZBnn2mt3uSmB6avNiL2O7W39G
	 z3Hj/RJuEvoOmmLpU7Xb0hINpte8QpqKxSfU1oWlTsc+cBbY3pjqZ7EwPxPp/ivcTvXRX
	 dVB3rbtQqK4ooeIJjKJxXeXQ1adRRRxdMW9cQW0aJU28hWNaPlbqXraonwLI5OdWJNbSf
	 rmWsDp2CQDtZWkJPEas+ioFUMJ+WmrC9Y1crR/fCxBYa111SHwjSkuepIdZatGpl1U3QZ
	 VMySHncHCMMMF9U6se3CgiVVhULkh137CSB56gjHmxEh0Kmn8CoFN5zrbFYWX15QWAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=0mdcGcj64GzmYrPJu0IJ0WiOiRlU4XegUX2JgumUSPU=;
	b=WQi5m4quDhJfRVCYCkfBP9G4LK3O8odQOWz+l/VG+sfuFRNqvFy/kQmsyda8s+3h3OBf
	 oLYZN5dL0pctinoUelFZ7oZ8XE5/0ZUUKU5J3VKYYC7xd/G/1zh5GfrEeTTrk0OLP39wb
	 gDi0sBO8eXSu+1M/CV+x0kOIFOsOMpcAGjPajxLrphzMsQHNsalsumEMakjTxKTzuEn3d
	 F1zUeAr0cQKhvmuEySfD9bhY8q9mwp/j56ju1YS/oxMMhJkKqmqXS30WQlht9m2QW1CRC
	 Cku5/BnE5LNIbpC+FPTnR+wFdDzpvyUojKF+WSri0P31CEQvr4HHyIBds/UZFFRWohg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tweek.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F9nAdFTU;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524FF606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 524FF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F9nAdFTU
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cde9044a96aso350911a12.3
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 20:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409857; x=1796014657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0mdcGcj64GzmYrPJu0IJ0WiOiRlU4XegUX2JgumUSPU=;
        b=F9nAdFTUx3IwRVE5j8Herp4NHkJcsEtBnnDYRWoArcU56RCTej6HNKSzvYcwYse1oZ
         KuG+DAq257bVijuE+P0flKXEHymfpyaP8BUL33sO1gHgGXgBiG4FfAKtwk/8OVQaOKGa
         MMThRedOZx5zjKfLmx26hHaOoRpPig5IHsaRQHSuFFkghsihAyv7+2y3oiVTNVvoQGzo
         SkenIBYeKyxzeU+zmDUDhTVkIRcwzHwEsqKyJdgvyfW/741nIDDOuQ/frrUuwpGdQgZH
         qcDK2Ks3i3HDfj54HMi7bq65DmTd+CtuCCO4/i3nAvXB3W3+mFIvWBR1ZcerNPzkngS6
         lX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409857; x=1796014657;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0mdcGcj64GzmYrPJu0IJ0WiOiRlU4XegUX2JgumUSPU=;
        b=u/Zim9mVH2gjPf4KCirfnVBq/Z+FCwAFzAMwnJXeMH1yqiN/KluVkL3MA+k5qmCRuB
         s5Y9SO4T3QnxtdyjsqiKsa9Q/TSI5W5mymO9cT9dZR5mWJY2w4bksbFjxs+RWsspV+dG
         b3ZUQsxMCOO9W6LPhjVZIwixL6Y/0YEmYo8JWL2jHblGCDfqpHNHP2RhJg3mB0S9sNnz
         1bO1p8zg8ehVpEgasfMYU5v8PBPwMyHucrqUPIXkl2JkBEeN+egzrSUhAvhn3josBJMo
         d6z0vIPUGTuWpDCriDDSetP0d7QX0X1Do3cTbXxjlxWFNfCttGPXsl57JVVY93hxpouG
         9X8g==
X-Forwarded-Encrypted: i=1; AL+hErHvzhtkAaNC0uAtGrarrfiBDRyL+om8y7fccpQp3PRsPAkBdnYYjqsL1Yjj90R/EfGTSvE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZbAaHtyfyEsLtmFWYMkKCGzEm2inTPk561hxFKyBJP/YFNYsB
	4hogSsh3hve8d05h3B8yvQVt8LBNllnnV9LGS5K4zkKVTVVK7n2/ClAfdzLW5dja43LkpYdJ56B
	F8A==
X-Received: from pfwy15.prod.google.com ([2002:a05:6a00:1c8f:b0:89d:e040:c63e])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7489:b0:3e0:e60f:2e5b
 with SMTP id adf61e73a8af0-4014c948925mr9728669637.30.1795409856438; Sun, 22
 Nov 2026 20:57:36 -0800 (PST)
Date: Mon, 23 Nov 2026 15:57:28 +1100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123045730.1960346-1-tweek@google.com>
Subject: [PATCH bpf 0/2] libbpf: Skip BPF token preparation for gen_loader
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Sid Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When generating a loader program offline (obj->gen_loader), libbpf emits
loader instructions rather than issuing BPF syscalls on the host. While
other host-interaction steps in bpf_object_prepare() already skip
execution under obj->gen_loader, bpf_object_prepare_token() does not.

This causes offline loader generation (such as bpftool gen skeleton -L)
to probe /sys/fs/bpf and honor LIBBPF_BPF_TOKEN_PATH. If the build host
has a token-delegated bpffs mounted, libbpf acquires a token FD and ORs
BPF_F_TOKEN_FD into map_flags and prog_flags without gen_loader
serializing any token_fd, producing a broken loader blob.

Patch 1 skips bpf_object_prepare_token() when obj->gen_loader is set.
Patch 2 adds a token/obj_gen_loader_no_token selftest covering implicit
/sys/fs/bpf delegation, explicit bpf_token_path, and an invalid
LIBBPF_BPF_TOKEN_PATH.

Thi=C3=A9baud Weksteen (2):
  libbpf: Skip BPF token preparation when generating loader
  selftests/bpf: Verify gen_loader skips BPF token preparation

 tools/lib/bpf/libbpf.c                        |  3 +
 .../testing/selftests/bpf/prog_tests/token.c  | 82 +++++++++++++++++++
 2 files changed, 85 insertions(+)


base-commit: 84afebd853437e44cb71f718be11d90e4c1a59dd
--=20
2.56.1.750.gf70dc682cf-goog


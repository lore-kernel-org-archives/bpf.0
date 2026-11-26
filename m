Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702665;
	b=WGcWARnicv05C5XtoVWUpo01rtd79Q7HQU7ln/9Mu7v5UOmBQoEejo1WZcHuq2iXZktn
	 gwiyAf5Pbg1q09E1UOrB/Q2ehbjS1xo6KBxSoBN4VZ/uNfzHGlqa7myEaneBJa/mAP3K/
	 /bUP/TEmf9cTl76vfOV7RLYu/DGCMtApRz9zD01n2AQejHmhrppgksMSZPTr+jz6akEBQ
	 f+sTEogSjOaizJkLzz9egJ9nvQkBPxk3ea2UJxYxH33HV8QMJjL02ujXcE9ERebyWRHir
	 7taq/xYx3Q7wG2U9QIemBEbXBt2slewcEJGkx3C4zPJah/SNjS5y2iOi4ftR5sUwj4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4qDkrFutVKINGUjMQD2PJbHOhg40qEJa82hi0xdZEFM=;
	b=xmw5R/6a8ZHg58EE23YFvdQQIoaAydBq5FNK83sIW7LKw6lcZJZ8PlCFXVIZEkho2Vk2
	 ItwC7psuD6DvJiAg/2UIe3cIhRmS6hQTha/YKc1w+ymsWlgb9/f9SbWdFSF6bIiMQL9I7
	 bxJqYTwzsFioQ4cmMpbV1kYTkUd/2mbA+VhoEMhQcnsPZkxV25KxgZiERqBqUddF1yn24
	 4rrxd34zqRWPd1eCS5ntSFKAhS2tjrLLhGwrTBZJUPfer2kwdzUpSbqjFShlJ11PgHJY8
	 K/zgzA8P8AkX2ucTTas5jX2AcvqG8wQLci1dRa75zp8EKcqRFHLXa8OzkqY/Nr51qsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p2otFJav;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE12606A32A
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AE12606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p2otFJav
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so33912275e9.3
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795702663; x=1796307463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4qDkrFutVKINGUjMQD2PJbHOhg40qEJa82hi0xdZEFM=;
        b=p2otFJavuW59QOcFO2nM89N93aCC/BJXQ+wjMHD0epjLYRpYRd4N04iMSRaRii+RUh
         tUlK6wwYmzQ9XriZ3IIuW5kc2O/A84ALbSYhqOgCDo0oby6cOib7T1cslSUvvJcVulf7
         LVYsGSZxf2pKDn8lUuSCIW7HS/zW7uXtUWv7mXSr41iDHtAK1rjoe1IVc1wMilPr80zP
         PeUdrD1eII92+M5OMCxZLog1M+6man7/8Dm8n5eJ5y52VGfX4jPLm+jt+6F1WD0csdZ6
         QxKY7Mq/0Jmctr0swfjkrVPpPnETUBhoy1W/CFS3dx0OqpgNO0USBD+R5b2yPpORX75h
         vknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702663; x=1796307463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4qDkrFutVKINGUjMQD2PJbHOhg40qEJa82hi0xdZEFM=;
        b=Fov9cXkcr5UlWkWHFk38K169KZzuMuV8AjhxcEbdf9nW63gM2tzAyMa2E7jZt1CefN
         tAy11LfI7ehXNoO8PcJM9CjlrRM8SNmr3sLKNPIx4hQU35RtoXsbL7XFa0sIV0unLFF8
         7jUZvG/ZjUDAWK4Y9SKdOSv4PyUi8JNWzFA04LFKevVkv9xVBTz14ZwTWSTUBfixPSAo
         S5pJCj/IEr1PLGJ133aHX0yFFZMkpr9jw9HYKoZ7QSd1VoMgfVWoCDa66pq+oJbEAiR4
         ktsbNQk8IpIrOFgk8ZmBmz5tDYPM106fMT8XRSeuZwu2p5ObQCaChe39TbitPR2V05LT
         BEgA==
X-Forwarded-Encrypted: i=1; AL+hErE5pEeNJIymRBbSKx2EgL4EQ6DaUN8NTXbNfwR+lUVYEaujKrlnTYfbkmrdn2Lf1w7rQxo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UJjPV0OHZsDxYS/hL0gSmA3O+eA8UuochUQlvyZ8ZCcBHNS7Q
	pBIpVIZzKvQFUzWRj7WGIZxA0j8iN7Bv1R9Q93vcL1pbNa3Z+e6iP+4V
X-Gm-Gg: AZFdTZcBaUuq7C4dhHYLtIkm+pe8zeC6doEfN9ecpn8MtblmpW/mpcDo0UGlb6H5OQp
	2u/aVcNr81yPiQJueqFxBgS368SRy9FEnu3leivl1V6GK+sF9KDaLy9nPh+1a4GQS/HNpmym4VY
	RnOM+jrsygtY8pusYmWoCEvLrv6NGXpfuV0FzYnUKfEg2ghXcNfsX2lseGCYk7Sra+DhF+Mcb8N
	Yabwa383cqOxsXn4Eyq461FFb/8veax5c5K/6cPPVRI4VAgrJYS5E6c6yksLOdAkfnC0FMBJ6ii
	gsWIjBNe3uAiEDEJbimHG8Gd3sXSXyVdh+SPEndm962+V3HFs/EMvxrOqansXyN2bP7H6UHUA/1
	Rg9QtkzkZ+FcAYH/+RrfLVefA57W/i1MdwuO1Reg0KzWMMhL4MXmTv5lnuP3YXJpxC9aQOyOjC/
	nEep9N5T9qGGLoGuX78LVv4s6jHzvSGqzuA8yK/sh3XwsGVhufj9Kgzsgc9uluGWNDYGY12Cw9z
	Ssk7/os/VBbZ4GHA/av7PeqxN+pUrKQPlKJCIap7lZD01hiMVVg9dzm2VPL2S+gtbggi7M/ddIX
	r3Fe0wNl+zc96sfmUHeThS8ESf3x16hiUHpuxNQSjQOKAj4=
X-Received: by 2002:a05:600c:1911:b0:4ba:38a9:85e3 with SMTP id 5b1f17b1804b1-4bb8880eecbmr465852385e9.12.1795702663234;
        Thu, 26 Nov 2026 06:17:43 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm596496575e9.5.2026.11.26.06.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:17:42 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 0/7] Do not tag selected functions as fmodret targets
Date: Thu, 26 Nov 2026 14:29:06 +0000
Message-ID: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
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

With CONFIG_BPF_FMODRET_SCAN=y the build tags the functions that
return errors, so that an fmod_ret program can attach to them. Among
them are functions which BPF itself relies on: the verifier, the
trampolines, kfuncs and helpers. As was suggested by Alexei in [1],
we shouldn't tag such functions.

Changes split into a few logcal pieces:

  * Patch 1 fixes a selftest which will be otherwise broken by this series.
  * Patch 2 excludes the functions which use BPF types.
  * Patch 3 excludes kfuncs and helpers.
  * Patch 4 adds a static list of functions to exclude,
    which contains 6 functions for now.
  * Patch 5 excludes bpf_*() and __bpf_*() of vmlinux.
  * Patch 6 excludes the code of kernel/bpf/* and of JITs (x86 and arm64).
  * Patch 7 adds a corresponding selftest.

In my arm64 vmlinux build this removes 795 tags, 13629 are left.
Precisely,

  * Patch 2, BPF types:        removes 575 targets
  * Patch 3, kfuncs, helpers:  removes another 130 targets
  * Patch 4, by name:          removes another 1 target
  * Patch 5, by prefix:        removes another 65 targets
  * Patch 6, kernel/bpf, JITs: removes another 24 targets

One implementation note: in patch 6 gen-btf.sh lists the symbols with
${NM}, which reads what ${CC} writes, LTO bitcode included, and gives
them to resolve_btfids with --fmodret_deny.

v1 -> v2:
  * New patch 1 to fix the selftest which have used the bpf_dummy_reg()
    function, which patch 2 untags; use do_epoll_create() and also check that
    the one of vmlinux has a tag (ci-bot)
  * Add copy_to_kernel_nofault() and tracepoint_probe_unregister() (Alexei)
  * Add aarch64_insn_read() and aarch64_insn_write() (bot)
  * Drop the *_locked kfuncs, new patch covers them
  * Exclude bpf_*() and __bpf_*() of vmlinux (Alexei)
  * List the symbols in gen-btf.sh with ${NM} instead of
    the llvm-nm of llvm-config, which can be older than
    the compiler (Alexei, bot)
  * Test functions which only one rule untags

v1: https://lore.kernel.org/bpf/20261125212849.868523-1-a.s.protopopov@gmail.com/

Links:

  [1] https://lore.kernel.org/bpf/DN3P7509U44I.MLLYA1W3M3X9@gmail.com/

Anton Protopopov (7):
  selftests/bpf: Test the tag of vmlinux with do_epoll_create()
  resolve_btfids: Do not tag functions which work on BPF objects
  resolve_btfids: Do not tag kfuncs and helpers
  resolve_btfids: Exclude a set of functions by name
  resolve_btfids: Exclude bpf_*() and __bpf_*() of vmlinux
  resolve_btfids: Exclude the code of kernel/bpf and of the JIT
  selftests/bpf: Test functions which must have no fmod_ret tag

 scripts/gen-btf.sh                            |  10 ++
 tools/bpf/resolve_btfids/fmodret.c            | 138 +++++++++++++++++-
 tools/bpf/resolve_btfids/fmodret.h            |   4 +-
 tools/bpf/resolve_btfids/main.c               |   5 +-
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/fmodret_untagged.c         |  58 ++++++++
 .../selftests/bpf/progs/fmodret_retval.c      |  17 ++-
 .../bpf/test_kmods/bpf_testmod_retval.c       |   6 +
 8 files changed, 230 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c

-- 
2.43.0


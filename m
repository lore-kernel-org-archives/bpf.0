Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520345;
	b=3C034R2RbPfB+MZ4Fc+2ZwRRc5I9qA6/dxbIdKByBq2+r/UekcN/Yz+GXKwJkpeEs2EN
	 PoSY8ecSSFjsB6WCaD6pGuFJXKIRZC2K1D7vlR8iSxTWEhbEDpbxYQbtP9qq2zhLrwL8a
	 SkzVVXwRMVskKvmaV04br9Eky9NPCqdQPLRhKjczqWfDDSoicqdZd5SdgsY3MHKms8e4r
	 ZwAysIPbFcaEVJAp5zbV08rF8NnQ5riAnGYat+7aDRB2KNDjOOhGvNGD8m1w4aQgskUtZ
	 ndvipqsBREXiv9rf4KZOsV+lNhku3WposYmwF4+p04z4Ya4fUt+DS0cvNe+ZxyhdK0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gjzsNImBjOSloDWNBkdxRytNUxtIvmh55DaoaVnTsbg=;
	b=CFhYtRb29gYXeblzHUFBl471spWEuKWwVFZileVqSg9rVnI/4NMKR6PqNAAL3bG9gwjT
	 Hem0gjCSAefV/q+u7tMzOCMEIS7SN4RI4MVLJG0D6Cr8Ml/JPMMedv6sHEf/ViLa07SLB
	 8YBTkhZyk7X+RKouzDEmqT+DKA+PXJb3i+JSuxHm4Oy50N5lmz0U63AEe6BvQ3QgUMJGh
	 /6BXg5KwrH6/gqQJbEY9OsQQlpRbOsq0ouKDm/fJx0B6ayvDkJztr3N58qPHDLa9/5qjO
	 fEYTdhqVYaciffIRT2fWzmDUeQH6c1SHR8ipwKJJlJXdh7htLieGcWxjykoFzjVeQoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="y3THO/Gs";
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE03606A329
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FE03606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=y3THO/Gs
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so55219a12.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792520344; x=1793125144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gjzsNImBjOSloDWNBkdxRytNUxtIvmh55DaoaVnTsbg=;
        b=y3THO/Gst1utU4it3ctAmroBFVq4q2G5j6SynabD/hszBhdKP/G/orqAdt7UAJXbEM
         S91JhRASMFFhmVrrUJUF2jR4w8ponUbgY9ZJRzQctzzGXg9e3P2P5q4yBygU0kzUZ1oY
         Hw8qVMSD0aN/Wm840yNUzrxV0i8cFUIBr/j/omRDs55kgiusm2IX/1vNvhLS9b7gUBAS
         woyx6n4dEboHIL9C10B9JeAL+M7GYqbyHM6nkJ0vl1dnrRl0zk21K9dy++1kpLSh5YSn
         yMpLOxj7LSkLXzvrsmfs8aKp8U4wNWnebG9PODscA7VLi1SKc+oBrI27eFmtHJNIjeeW
         LAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520344; x=1793125144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gjzsNImBjOSloDWNBkdxRytNUxtIvmh55DaoaVnTsbg=;
        b=xPeigngnIrhUTdRdY3s1Ogn4dbW4D7t1A8DoZEfS8dqPldtbw7p4yG7IVwa8dYZk/O
         HST7M/KQn3ttUpMDTAfdGBEZdbk34S6PGC5P6fTaqGxgMKUQv5FxFDrYo0jATbuUMiXZ
         MrjBA+gKWR6PX/N7sswAy0lJnJN4reRul5k85Y6AYNfp1k6IwZbfLcpaVt84698CamFR
         nATUmJkTdYcwMANkv5x/cMzR3z6tPkeyg+28b7arf/slzLKa9ML50XoWuNyIxdM7uyf0
         +VytAWf7dTiJ1krvxxgqseeHaXBpfjFLA6mZ3MO+2VzL44iPGtLuH2JpjaE/E3JwDS6f
         FPJg==
X-Gm-Message-State: AFq9FYIPIdE4UWFU6MnjtZwhoJsTLzurGJm4pWrejYXW/Wr7Cxetwrlv
	gyH22rpyNTcRCZsnpXgpzs7M2GsugOrAiry0V7WVpTxnMXyx0oeAbcRlypjPNYceDkE5t9LFTdf
	9GWOhYvM=
X-Gm-Gg: AYBFou1svbIUYIL+CWpF+xlbuombJMuRb3cH0q5PIlMS89ix+Q2qCXtK7p2qaWp0xt6
	IagGeqQNfRP4IfLNYGyqCtnnSH/W/SC9nlKsQLK5AaSanPIOqvTuZREYJeAgVFu6IHsa/xX655U
	bLGle5iB+qDRfoy0yW1cIhuQ8vpLU8ZClDjnkyIhNMqeuC5fjnSif4OmMMQqGZnkeEBHdY5pSJ7
	U0O/Wmf+HgISfsBU6RLK0mFyg9GaBnNtPh/VWZ7qOlTfoj947esVjBCq6S0Fg/bZVrTeIn9hqmp
	GIQznENoRNw/oeQ9f0keuuqXjoGlhyBNHQaOWXvixUgtdXzf2BqHSnX/5dskFSCB2sDm/UgVFfo
	2ANb9r9b+jAAA9WsbCSNVRX8RE3CgZUt5UD9ddKbOFaE3dv1wS1o4D6vpMWFQZ4bigx4hvaavgh
	uLLhpQw41GzDzDkHjcuDqFIW5fCytCBwcXGPthMDjmEGtqKzYo+FtNmTLlw7OJtlRJ1un3hzxDJ
	hliyrxeBfrq5BUXA+tiW3FFVFzh/iuHhcDe
X-Received: by 2002:a17:90b:390f:b0:3ac:8897:7ba5 with SMTP id 98e67ed59e1d1-3acef5f5bd8mr10487481a91.59.1792520343841;
        Tue, 20 Oct 2026 11:19:03 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad7ffb84a8sm710661a91.2.2026.10.20.11.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:19:03 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Harry Yoo <harry@kernel.org>
Subject: [PATCH bpf-next v1 0/7] bpf libarena allocator improvements
Date: Tue, 20 Oct 2026 18:18:53 +0000
Message-ID: <20261020181900.6755-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
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

The libarena buddy allocator's design has up until now prioritized
ease of verification. With new verifier features like unlimited
global stack frames and a large stack size we can now improve
the allocator's performance and robustness.

This patch introduces per-CPU caches for the allocator. The overall
caching design is inspired by tcmalloc. Each CPU has its own static
object LIFOs, one for each allocator order. This speeds up allocation
and freeing for BPF programs that have some degree of locality. The
CPU caches are lockless. The caches are replenished from and spilled
into "transfer caches", per-order caches shared between the CPUs that
amortize the cost of spilling/refilling. Data from the transfer caches
is in turn moved from and to the allocator.

The patchset additionally includes code for allocator reentrancy and
bulk allocations. The reentrancy code lets us safely allocate from an
NMI context in general, and from a BPF syscall program context
locklessly. The bulk allocation API is useful for replenishing the
allocator caches and also on its own right for speeding up allocations
during initialization.

Cc: Harry Yoo <harry@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (7):
  selftests/bpf: libarena: Add bulk buddy allocation helpers
  selftests/bpf: Add a parallel buddy allocator benchmark
  selftests/bpf: libarena: Add buddy per-CPU caches
  selftests/bpf: libarena: Handle NMI reentrancy
  selftests/bpf: libarena: Refill local caches in batches
  selftests/bpf: libarena: Add a transfer cache
  selftests/bpf: libarena: Cover buddy cache fast paths

 tools/testing/selftests/bpf/bench.c           |   2 +
 .../selftests/bpf/benchs/bench_libarena.c     | 100 ++-
 .../bpf/benchs/run_bench_libarena.sh          |   8 +
 .../bpf/libarena/benchs/bench_malloc.bpf.c    |  43 ++
 .../bpf/libarena/include/libarena/buddy.h     |  10 +
 .../libarena/include/libarena/buddy_cache.h   |  61 ++
 .../bpf/libarena/selftests/test_buddy.bpf.c   | 277 ++++++++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 646 +++++++++++++++++-
 8 files changed, 1103 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/buddy_cache.h

-- 
2.52.0


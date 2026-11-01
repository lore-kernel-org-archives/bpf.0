Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793494023;
	b=v7BWSfEjqipoehFIj0UEEDxtHqT7cf3o8MWTHBKozzbFKN870ZtE5KSZmJFi22QfO6as
	 RtzRun1EB0XjnSiWwOfQjQK0hRTf6EDtRfPFTFhEMTPmB7e0f20iqjnW7BShDtwe0K1Bo
	 MuAzmprhdF/4+ishY+tvC4kHsXGlvsL9Vx7d6+oLRX+4Mi3J+xzN2Olz2yHuWMeHXq52O
	 2bNuchRqW0dJVC7eSF6Qa0eqp8790g8fr9mjMk6a7bdHxicvX/HH4c4Z8ggmeG3DkqmA/
	 +GuYWef23Td/db9ohQHFW3a2+eZzT1Pq+pG8RRmR1lcrY1Y5KF0aNWlXnxgdx6hKcOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7Jh1LgZwW+Vx0gDOEtYupin9T6xKTlgGX0kPd4+7DDM=;
	b=1/cuUH3bTsPBVnZ4oS/3maSndeaEIldXPqiDkXiz0KbSNXovTVmzLLNokrNrmdNPkh+C
	 PwqSQKpS/qUaTOzI/KesoSq/HjedY3UYfPnmqxldhMI6BEZBrpeN4SwmNxPRHADikOlHi
	 O8rmgGbWktCjXOmDAZYliRlNbrqJSZ4bEFpPxqZwCh4s7hSg4TtACMxd5VBBmjCgy5AW4
	 ZYci/rIO2eYy6at6/Z4BV6kLOHy3O3AutgADcyI8Zqw5qd2Pky1CLqwzkyqL5ZKCxg6pc
	 3qP0Vg9TcFOQdDRvsdyNDXCiE7nPFLJrTTq/rd847dfSkR+40hB8YFZDyuYRCIrYIMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZwT2kjpd;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C3606A31A
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 00:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944C3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZwT2kjpd
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e987b4a710so15553575ad.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 17:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793494022; x=1794098822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Jh1LgZwW+Vx0gDOEtYupin9T6xKTlgGX0kPd4+7DDM=;
        b=ZwT2kjpdqhbEWarm+xTOQ3LCHHhLN9Rft+xfyRbNfVSDuGN5YQhYvi/jAa52xXDwLa
         WzOT8zs20v4Y8ppfiBhiRpiS6Awx7+RyrQMNU4cVcsdR5GOoG5PM5225tDWNXBMw52s/
         JcENA26671vKATM5KEtNXi3pwFWnptcBQT+zJzxji6b9Z73vylyP4lUgu5q82eGqzq5T
         ytwW6of+LMbE2XmpnvY3kVGRS5ryMAnC2vV7ZvPrFMLbKnCpt+LS3Eak9rqvxRkjxeHf
         MeClYFuxhZROgRqBWR78YBnmTXZ4/+rG7sfM0znVv9WMTzINGH9HDx/MRDpViTRiKcCo
         UUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793494022; x=1794098822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Jh1LgZwW+Vx0gDOEtYupin9T6xKTlgGX0kPd4+7DDM=;
        b=K5M9V0JVCksnSwtqhFuhRGCSNnW04gVvTzxZh4igmqL9HbBtHhSBszghaLXDZqz7jF
         FvUTl/Jicl0MYdjPHsA7qBC1at6uYIDSK3UNhhx7ycAlZKaOR+I6vq7TounRhU86EFx1
         aQglXp9BBU27NrwNw9bo2IZDB3AJ0v6DGACi8f94gh1J65hy8pqmz4BkzwokSaHQUSKF
         itS8YqmXvd/g1G/F9va7YPIWKVdmJndXEte7jSa9OCVP/YmeN2/QwUolihrZvBJgogUG
         XOc9TQDhKmR+Qdnyjd+hCTW1n6DAID7NmMzJHzTk4kA7YWs0JhlQPXUI+M36LjWoUd02
         FDww==
X-Gm-Message-State: APuU4Z+rm6fdmM26NmcDo9NFbNBj2EtMrloLQ8Fut+GxO8BFQpT6WfVx
	KIW0tV2vHTnmycTgl11mmhgwV09aXXRQn+NyPUSINo9rvgmWnns838zuZSA3wQ==
X-Gm-Gg: AYBFou23yA+vyJtIY3RKJxli9dF+kdPfI+otlMR3FNGQ6UKYWSAibA6Jrbo47qs87N8
	CBoesl6XnqfXmhLu5oJuDJcVMsQ9Qccf/baYjKpJRqMKCeQYlpHEk64385i2Eh4msc7p88OFNSm
	ls1MLEKUOlIut09OOM4gIvaOav4q9jjeRK6gdlLh9ZpIgX8OYpScVnYItFnllGBCjeUwkxU6IPc
	X1hVPmzycwz49pzCa4xY5BRWly+sF3vYKVqNalyQv9hPZTa7pzgXY/Fk7gfDHIlh43V0tPnhdBg
	G1myy1+L7d+f5iv1z8EiEEAdOxA/Z4TiYq+MFkHJttQrwLOrUtCJjhblIoHG/sLhhpeIizyzqKI
	//Gsi+XFWpmtyz9XojviH2aiWlcgya8Uw32iSHMqIJderEa/u82DIHfy/GDL+5dZhzNpaBNPmq6
	rxM5kKdABZxttAVcfRKBEuSj4lizJ4GHwfgVAX0I+okvFxnDEmG2qcxi5GUaoDcrzzyLRb3iapQ
	rb+0WzfluahmwcrWhyk7De7MxOiUtC80Ck98r4PAaeB0+ENfxsk/xlGijlk3MSb0CBgPwf6u4qu
	CYfV0g8zUChCvviC+4xb33ZxKwwvIIIRkA4+pH8Rls7TnopEAlEJOc5gjNItP7oPu5yUvS6ckWx
	nPfy3wh8P/ao/RoCubRAtCIZ1vUnZGYMr1mgV7P9Gu1q7feGFmCvAl6kU4FdwRV4kndajwze+IR
	A3idZjTNcbr0P33eH4FFQ=
X-Received: by 2002:a17:90b:1b0d:b0:3ac:36c7:c144 with SMTP id 98e67ed59e1d1-3ae89776936mr3571493a91.28.1793494021715;
        Sat, 31 Oct 2026 17:47:01 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87f99899sm4639185a91.2.2026.10.31.17.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 17:47:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/2] bpf: Don't trust pointers spilled in slots that a callee can write
Date: Sun,  1 Nov 2026 00:46:54 +0000
Message-ID: <20261101004657.3406576-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

The analysis that follows pointers to the stack before the main pass
assumes that a call does not change the pointers that are spilled in the
frame of the caller. A static subprog or a callback can replace such
a pointer with a pointer to a map value. Then a store to the map value
counts as a certain write to a stack slot, scalar evolution misses a real
write to the counter of a loop, and a prog that accesses a map value out of
bounds loads. Valid progs are rejected too.

Patch 1 is the fix. Patch 2 has the tests.

The series needs "bpf: Fix the join of fp+0 in the analysis of stack
arguments", which is posted separately.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (2):
  bpf: Don't trust pointers spilled in slots that a callee can write
  selftests/bpf: Test a callee that overwrites a spilled pointer of its
    caller

 kernel/bpf/liveness.c                         |  50 +++-
 .../selftests/bpf/progs/verifier_callx.c      |  46 ++++
 .../selftests/bpf/progs/verifier_live_stack.c | 230 +++++++++++++++++-
 3 files changed, 309 insertions(+), 17 deletions(-)


base-commit: eaae576c34d7e001767b6845a5950b0b8db3e68a
prerequisite-patch-id: d1ee323f716bd2f2339c814bf670f801432f5b15
prerequisite-patch-id: 0cc5798286d30e27e5fbd131af57beaaa5d701ba
-- 
2.55.0


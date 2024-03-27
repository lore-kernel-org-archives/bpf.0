Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D78CA7D
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540788; cv=none; b=in7Faz/jFxXVSSMl0/vXjNGrA7ctZbOIjPCT6jQfekQzqpmTV39N7iYf1lqiPEacAXgJ3iS+v70rK5GQwK1CzGK6u0+y3IPstYG1nS6SwB4NE8ELlYcZMwqgshgIrID4tjjnf60fO4pV3hp7vjqbcEE8NHSfh3CD87iTP61TbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540788; c=relaxed/simple;
	bh=mz0/ECDjayG4HZZMvxlhFd4aDsDW0hhlaR9hl1Pj+Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jBtPhXWtK9JBJggX3vInrS2PArf5x29prjpqnNTPBBVwERVZOETdJdQg243iCb29Fl6maYqC0bfHI6uxFKQ9vz5mvE6xTosTYEjvFhAqTK4TlVbYsg6dAPmjvDCp8Wk6OnhI4z2LxxtQeq7F1X0j8ybHIqX+Y29B3HH0F7EOn+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evO72i0h; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evO72i0h"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e704078860so4914157b3a.0
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 04:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711540784; x=1712145584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4GUrf4opcyvT6/2OkbZEvnYHsXgYTajSZhYRVbvPtoU=;
        b=evO72i0hnQRqgq+JYzjiisYn+vPVYqMBxvyyvY2SZZS8Izae50fi7rwgoy2hBwJLfS
         OBWDxIeYVKve5V0QWD6MDZjW84xmK2gwC0P68GeNYCc85Wf1fURfjuijoajeyLh+n8Ie
         Xnw1tU0/8nJwKxoMOKx9b6qyHuHV7R3i7ujiOkIjX4UyOBDLHv+rKSQV4Vje/wg2RiVo
         VBcWsk23PCBJ56FulTZ+kSSFGvod6xXnyUySZx6vy4PFDDAZuiB+Oja9voSRMbGSiTwG
         Vc/0jMlaKuefKauRcX1RDTNczJy4eDyYZRof5Pj6aV3Zxv0jsl6Swayu67ed9L+xGPIC
         Fl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711540784; x=1712145584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GUrf4opcyvT6/2OkbZEvnYHsXgYTajSZhYRVbvPtoU=;
        b=FXcVj1qFlmGx+pLZV8ZAmYBuleVA6af/nvCz6Szvw13U5RMDPTx5VKggpxByTT7vLr
         G5SBzPT2hhJ3PTkdc/ufWbmn96XTcxBR0JOqfNjLlQjL21UZYVOK/gmaBJzAU1l8zDJD
         HSuq/gOqyQHxkubu98CNA4DKhdg0rAwYpI69IJbh9lxqIHh02++19AeVXZaHVpoQG4tB
         MPWdj6KqM0+u89euxpa9hZpWiwmWJJPGCZQ7Le09rmjB6n9RerXIX9sIQu1zc1wu5sMx
         07bHs39kI6ChiMz8vEJTvdBxyM3Ldem3gCvY/yiwDAa7tx0pvwZhck22kpgYe/VG5333
         Hvmg==
X-Gm-Message-State: AOJu0YzxiCrQUinXKOPnt4eZugF7pqto4nvAkyJQe893h3wXMGy4aXq6
	C3xAYP7Ue+s/krZ66Aku2qUj6GArNjQoHdvHZDB3RSBrE3398rR3
X-Google-Smtp-Source: AGHT+IGLyJprqUfb9r5R8/JGokJHaEHsuJ2K0YGV+C8LG0zYn60FWHdKggvgv+fPAVtJaVvzotBiuQ==
X-Received: by 2002:a05:6a00:890:b0:6ea:7db6:6271 with SMTP id q16-20020a056a00089000b006ea7db66271mr4027108pfj.19.1711540784420;
        Wed, 27 Mar 2024 04:59:44 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.203])
        by smtp.gmail.com with ESMTPSA id fa26-20020a056a002d1a00b006ea7b343877sm7675695pfb.9.2024.03.27.04.59.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2024 04:59:43 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 0/2] bpf: Add a generic bits iterator
Date: Wed, 27 Mar 2024 19:58:46 +0800
Message-Id: <20240327115848.84695-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
added for the new bpf_iter_bits functionality. These kfuncs enable the
iteration of the bits from a given address and a given number of bits.

- bpf_iter_bits_new
  Initialize a new bits iterator for a given memory area. Due to the
  limitation of bpf memalloc, the max number of bits to be iterated
  over is (4096 * 8).
- bpf_iter_bits_next
  Get the next bit in a bpf_iter_bits
- bpf_iter_bits_destroy
  Destroy a bpf_iter_bits

The bits iterator can be used in any context and on any address.

In our specific use case, we leverage the cgroup iterator to traverse
percpu data, subsequently exposing it to userspace through a seq file.
Refer to example in patch #2 for the usage.

Changes:
- v3->v4:
  - Fix endianness error on s390x (Andrii)
  - zero-initialize kit->bits_copy and zero out nr_bits (Andrii)
- v2->v3:
  - Optimization for u64/u32 mask (Andrii)
- v1->v2:
  - Simplify the CPU number verification code to avoid the failure on s390x
    (Eduard)
- bpf: Add bpf_iter_cpumask
  https://lwn.net/Articles/961104/
- bpf: Add new bpf helper bpf_for_each_cpu
  https://lwn.net/Articles/939939/

Yafang Shao (2):
  bpf: Add bits iterator
  selftests/bpf: Add selftest for bits iter

 kernel/bpf/helpers.c                          | 120 ++++++++++++++
 .../selftests/bpf/prog_tests/bits_iter.c      | 139 +++++++++++++++++
 .../bpf/progs/test_bits_iter_failure.c        |  54 +++++++
 .../bpf/progs/test_bits_iter_success.c        | 146 ++++++++++++++++++
 4 files changed, 459 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bits_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_success.c

-- 
2.39.1


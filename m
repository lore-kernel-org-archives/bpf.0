Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC5421EFE
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971290; cv=none; b=qHTd8Pk3kaSzVw9chRZ846p1negkMcYIJOGg+jDP/o37zZGsqTptNO7MuyT2TUxzUQWOyDS7Lz0+vYYdJNgWrK73UspOdwaE/6j8CoAUkT+Y2vK1UkDy2zlJZSAVb2LxlQA00KpoArMG+tBp3GoF9p+OFOTrYvAq9+PvGcWOrqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971290; c=relaxed/simple;
	bh=XlM6zyA0LvUUuCH/AXIgvkuM1NoxliRKcWKJJUdX7P0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m5jOcO9Oy017ETnjvk0vR2RWBYW/8R/bhpDBzr9tzl3uTtWX81Rd3MUBn4Jeu7EZn84EteX26Y3m/AIxg6WUIELSBMfWIpJv3c3c+8Z1KVTkkNvroV8++Dl6GyrGz0dcfXwe51jR8ONRW+Ttnrc2bcAFbpBvDiA49ysjP9Qa62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPT+E82r; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPT+E82r"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c4cfe08c9dso10313404eec.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774971286; x=1775576086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1KcB7wDgOOcYSPfeHFcgAc3CokvxeOaMFZ2tqdVYZis=;
        b=HPT+E82rAHEC8wnHmq8HnZnQzuGpSGy4HB490c98euo550nPv5IS5e22lzvpIRNYiF
         ugfpPQUSstV8wfMDjhotzOB+fpNh8gz7Dogkf/M5qFp4jI5v3k4UykIA3wQfRpaNc3kf
         YWBcNDDJXSJVL7ohEB2oYra8NU1WPmvfanZG+mTCg9wvsQz0qjve667BABoZpmHNKuZu
         P2Gza0eZ+ytjc20WLN307Ah1xdSD+6fvEAxFN8slkHgNr1yNY/Ma2ORieA2ytHn9XmhN
         9/aNHG35ryzG1A0AaSpsjMoEmuog4opEBmuEDgY469CoetA6aeC4GaeYp421weEJFMQI
         icew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971286; x=1775576086;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KcB7wDgOOcYSPfeHFcgAc3CokvxeOaMFZ2tqdVYZis=;
        b=e7qtQfZl3rQpepPkRXdoGdaumMKLdGRan6LfFiR/9n5z2xDkEBlZ2QGZqPxuRWlQq1
         aIR8MK7c9XZZ2+zGRWE9Z7OqlpyOvQttQ+jhG7M7bwaLbO7+YufO9dUBnY5wC9xcPQmE
         EAE6hNqP4mNm7BVBXq64OYn8EYA8/ObExtVKYmvtqILeBigrTgz7mq+tpOaZmfCCpHMO
         n/fltMH258E2rksjbBunB5BM0da0JkkPCF3Lpr8gP+Z+ZVQxCUDJTcv6jBX54uMqOe2O
         3NMLgirH8jsIBs4KtMejhxT688KCm+5qOx8yldafCz2woAf5vBcYnQ7422M7lduAwbkl
         UkPw==
X-Forwarded-Encrypted: i=1; AJvYcCW6DhZNBm8ugfgFVxslKWKuwgrf3Ex3D9YrrnyyxXXFVFV5owobymeJjf1XzMaf/Y8nljI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5Bz0xcXKt8Y8anpNdIxsg+hfyfrrvzQHUVVZ/X9va+oU9mqF
	7KOnuQPUy9+5bRH4NucicYdZI5jRm27TSWBrMqCT0ZVMOOINt7niNsB3pXr98Xs6j2bwF2SpDdX
	6GdU2n7gfR73WxA==
X-Received: from dycts10.prod.google.com ([2002:a05:693c:3e0a:b0:2c5:70cd:ff53])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:a146:b0:2be:2cfe:68b7 with SMTP id 5a478bee46e88-2c185cd44a5mr9098490eec.11.1774971285561;
 Tue, 31 Mar 2026 08:34:45 -0700 (PDT)
Date: Tue, 31 Mar 2026 08:34:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331153413.2469218-1-wusamuel@google.com>
Subject: [PATCH v3 0/2] Support BPF traversal of wakeup sources
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patchset adds requisite kfuncs for BPF programs to safely traverse
wakeup_sources, and puts a config flag around the sysfs interface.

Currently, a traversal of wakeup sources require going through
/sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
wakeup source also having multiple attributes. debugfs is unstable and
insecure.

Adding kfuncs to lock/unlock wakeup sources allows BPF program to safely
traverse the wakeup sources list. The head address of wakeup_sources can
safely be resolved through BPF helper functions or variable attributes.

On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34x
speedup (sampled 75 times in table below). For a device under load, the
speedup is greater.
+-------+----+----------+----------+
|       | n  | AVG (ms) | STD (ms) |
+-------+----+----------+----------+
| sysfs | 75 | 44.9     | 12.6     |
+-------+----+----------+----------+
| BPF   | 75 | 1.3      | 0.7      |
+-------+----+----------+----------+

The initial attempts for BPF traversal of wakeup_sources was with BPF
iterators [1]. However, BPF already allows for traversing of a simple list
with bpf_for(), and this current patchset has the added benefit of being
~2-3x more performant than BPF iterators.

[1]: https://lore.kernel.org/all/20260225210820.177674-1-wusamuel@google.com/

Changes in v3:
- Changed return type of bpf_wakeup_sources_get_head() to `void *` per Alexei
- Added failure test for direct dereference of wakeup source head
- Use bpf_core_cast() instead of macros in BPF program per Kumar
- v2 link: https://lore.kernel.org/all/20260326112521.2827500-1-wusamuel@google.com/

Changes in v2:
- Dropped CONFIG_PM_WAKEUP_STATS_SYSFS patch for future patchset
- Added declarations for kfuncs to .h to fix sparse and checkpatch warnings
- Added kfunc to get address of wakeup_source's head
- Added example bpf prog selftest for traversal of wakeup sources per Kumar
- Added *_fail.c selftest per Kumar
- More concise commit message in patch 1/2
- v1 link: https://lore.kernel.org/all/20260320160055.4114055-1-wusamuel@google.com/

Samuel Wu (2):
  PM: wakeup: Add kfuncs to traverse over wakeup_sources
  selftests/bpf: Add tests for wakeup_sources kfuncs

 drivers/base/power/power.h                    |   7 ++
 drivers/base/power/wakeup.c                   |  72 ++++++++++++-
 tools/testing/selftests/bpf/config            |   3 +-
 .../selftests/bpf/prog_tests/wakeup_source.c  | 101 ++++++++++++++++++
 .../selftests/bpf/progs/test_wakeup_source.c  |  92 ++++++++++++++++
 .../selftests/bpf/progs/wakeup_source.h       |  22 ++++
 .../selftests/bpf/progs/wakeup_source_fail.c  |  76 +++++++++++++
 7 files changed, 370 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_wakeup_source.c
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source.h
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_fail.c

-- 
2.53.0.1018.g2bb0e51243-goog


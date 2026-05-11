Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43E4657DB
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521809; cv=none; b=fKTDPcV4gMVk39wkgRDF3W0zCwk5AtcIhYrpWWrJUedmbGuBOjxMzrJ4H5bYOyGwvJeyaEvyKY2ssGJukSzIdB/upy+Nleq+l7A6ESUZ9pfwx9E9JHz35T4rSuMH0R1cQS+MOBZIJPAK4qwYa25qx95PDmU3awgTZGJs76XVfKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521809; c=relaxed/simple;
	bh=g1G/+PoWZdAvQmXojSHIDbtBFrtB6n8uPkg6HEziu0I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nEOpka+W5fzowd66udSH2vcKaipedgIkGsIjKupZ9ywRG0ma+1KfUNlQVR9HrQQgp8/0MtTmo3LTU9N1pMCSwi22VIJNcMyWiQXl7mxtldkRvLEjZZkrboxwBwUUwO48cR7+a0kBSuEXtvFlt8UcTof3wkLgkRaY6G4V8hNpxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YX8qbPQF; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YX8qbPQF"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bda35eab74so3756355eec.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778521807; x=1779126607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F3SSM/7OmGT1DQhDHuFPYpuDPGpRg8FSNXFpqlLPkoo=;
        b=YX8qbPQFuxrP3RQRrJxvUSFsjDfM7kSkA2R8elGiHDepCtquMaq5t2sk3du0ILffT9
         qkl3XvSIwPvMCV5l9hviHDPvTF6mJenOIUEYnMJiBpMQt1q7l7Q7UJ3lwaman0y5ZQtK
         tYJBS2baMTV6Wni+CUo8hMIXTpEI+7TeU5eSy0uoOEYfYJKVc7TdF0alM51v9ShKOULs
         2jOIfNY4csPn2JIqo/y1uQsvvp0gMMsqLnaE2pU8ub38Y0Bi6P14eCWEGHc7z5HXUp5n
         PjYunRhoKdvKPbSWLHEZcqf3Fggl9eRxtktyD6UnwLbc/X8xTub7qStEPoUcPchReEWK
         DmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521807; x=1779126607;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3SSM/7OmGT1DQhDHuFPYpuDPGpRg8FSNXFpqlLPkoo=;
        b=RxMts4AApu5TwCVWeE8u/v8+A6NzOG+2xAPP76nvePDk42ngalrq+TjEhuBggseE9W
         leOei7jfilDv3Oxh4DnGpLsJDKy8mDbH0sXYY/lxbWqun+uTAvio35XAAKA8ql1Daiss
         RcXryacvI9wtWQqihq+bObMXIGQKAPhfDKZdOpYS63Rjg5QCAxGsL8jqPlv8wdos4cUp
         q0juyok4VxcxlWLBRlAbr91TfAQScHLZ4mdFnv7m8tKdbiS11nmQKM3DCG5ZwsZQxDsG
         /tv7OgF4C6nI2MNjbuCcLSnaeWzkOzRp26S30SfIpd3mVytcMj3cnYhsNzMeWVd2dN56
         wW0g==
X-Forwarded-Encrypted: i=1; AFNElJ978OtqPzW7fFmvXrpLpOvSWAyQSc17CgGAIwjg7yzTvWK32si6uXF+IoYzOOlvan+uQi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT+TQz2gHLXMye5DrwvaRHXG0TlfVGqY2HXQP31zYqS8903CFJ
	ISjA9SWgN9pjrYeFAF4TYhQDvbFKHDrUns3um9CLnKcArVZc5H7Ga79xLsmb0szeFuL4KXD3vK9
	MZIUPFi9uFNMWRw==
X-Received: from dybdf6.prod.google.com ([2002:a05:7300:b586:b0:2da:4e8f:1752])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:5807:b0:2f0:ee2:f6c6 with SMTP id 5a478bee46e88-2ff95e5e234mr269219eec.19.1778521806295;
 Mon, 11 May 2026 10:50:06 -0700 (PDT)
Date: Mon, 11 May 2026 10:45:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511174559.659782-1-wusamuel@google.com>
Subject: [PATCH v4 0/2] Support BPF traversal of wakeup sources
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
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
traverse the wakeup sources list, and a kfunc to get head of wakeup
sources list is needed to start traversing the list.

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

Changes in v4:
- Removed `.owner = THIS_MODULE` for btf_kfunc_id_set per Greg
- Add a graceful exit in selftest if bpf_wakeup_sources_get_head() is not
  present due to kernel configs without CONFIG_PM_SLEEP (e.g. s390)
- Relaxed substr match in wakeup_source_unlock_null() selftest
- v3 link: https://lore.kernel.org/all/20260331153413.2469218-1-wusamuel@google.com/

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
 drivers/base/power/wakeup.c                   |  71 ++++++++++-
 tools/testing/selftests/bpf/config            |   3 +-
 .../selftests/bpf/prog_tests/wakeup_source.c  | 118 ++++++++++++++++++
 .../selftests/bpf/progs/test_wakeup_source.c  |  92 ++++++++++++++
 .../selftests/bpf/progs/wakeup_source.h       |  22 ++++
 .../selftests/bpf/progs/wakeup_source_fail.c  |  76 +++++++++++
 7 files changed, 386 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_wakeup_source.c
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source.h
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_fail.c

-- 
2.54.0.563.g4f69b47b94-goog


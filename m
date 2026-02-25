Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C46E30E852
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053724; cv=none; b=LxbuojEbZex2z9pZRQ8UkJ0Ql5gDUGp6w4tOnwXgakm6E8NoAU1vtRg4UT+WwVSrxbN1x6hKBb9rcvCiND0cb0bmeenNwmCXD2LPXZPaVwwpFVFWUwM1Vd9gwTlbVdUcX9g6KGY6LX9ssbI2EEz1bsefpwS8U5HXkKzsqTkI1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053724; c=relaxed/simple;
	bh=/8Vcz1prEbRK+dIJdMqcAygK+LDRxlZV6UmQxwtSlYQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P+Wg3yUchVOCDeljonTlGijxhE6nnfgX5fJrZUjHHWBlEzBHy+GUiRePWY79fIAiJM1uiIK9Y2ZmFFf2s79PPwu8waziISPz0LtZWceSK28k9/AdqEsE2hYN+6csDgiwGd2IH3aVoHIhe9Ko3718OM7iVo35MZRJiO5GGL1Q8Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jTYvnq2N; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTYvnq2N"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9f033a5bso1484107eec.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 13:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772053723; x=1772658523; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Of03JtVBl6x9wrND6zq4YBe9ooyHXbISaWzBe270tkw=;
        b=jTYvnq2NOJPbiEVPcuPQtz4ou84naqzmPYPlmrMJh19Z3LruJxrPhceojkvjXAqnty
         cgxO/uEgYkvRYT2sZuW9H29yluxXZXmDP5NWIiVQ0xqZR0uELgrRB9ca18ByKCZ2itEq
         o2JGwOruYlpB7RBTHPRgRKUBbR2HmS83DZdxyNWU8m99yzniH6geHlVCpKg5jYQz7sd+
         Nvp/TzurpDejQ1cvcanYHpRL7DMjDfQqom5VDAO0IA9PX1iXlQUZNkQ78Owhbj85Bl4H
         Dt8N5I4NdJTttLUK9Gs1dULHnDT/mUdLi07U8TSz0NyPhS+rKaxlwQW93eRfphceOJZn
         uZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772053723; x=1772658523;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Of03JtVBl6x9wrND6zq4YBe9ooyHXbISaWzBe270tkw=;
        b=wDz4GV7CXeZuFRMPupdoAfuj/gn1VaujIT6R04WKOmriBb6TNvI1swZ9rTHQtTLBjR
         tnUgtt3Gwqb0btbNEUsztmjaGutVZ22lYzqMV4SCHPFjCtNJokLfXnJxe6m0w67LacEC
         fluvoDQqeCKx+y4P/J+nPYrDIlo3PbNDWrAIS5iKvKhLxfHu0vVzT9rKzIbzseyTQV4s
         O+TOdWSBQBHKXRkU4vE8UNW4QTnn1I+V873lBKm7r4EmvPaD124YBZ08PJM72PdTkR5u
         W37NY1OElnxD3b+GMiDpP2VIUNpb0/L4h+YR0+nDQbOPERdyZJPQewDjr/ZBuVU5dqjV
         0hkg==
X-Forwarded-Encrypted: i=1; AJvYcCVwAKCjk99lg77/u+OAOh9tcRk0UuXXU7/NK2SJqS/vuNkx7gJps0mNlMj5DpV0aaOOT40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1VM4vU0KV3GuhJjSwcrIvmeA7Bysy4cUCkesVxA8Pf4rhtDYe
	eQV8+JQEa48fBL5ufrFPwN8IShLyiKmoKZes6I+yuHAv+dVGCgUkRSxh0WnZLQGj/hm45G9bgf/
	HKoZ0Jma1MZKG4A==
X-Received: from dydb17.prod.google.com ([2002:a05:7300:80d1:b0:2ba:acf0:ab76])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:23cc:b0:2ba:a440:79b0 with SMTP id 5a478bee46e88-2bd7bd711b5mr9002146eec.36.1772053722568;
 Wed, 25 Feb 2026 13:08:42 -0800 (PST)
Date: Wed, 25 Feb 2026 13:08:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260225210820.177674-1-wusamuel@google.com>
Subject: [PATCH bpf-next v5 0/2] Add wakeup_source iterators
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series introduces BPF iterators for wakeup_source, enabling
BPF programs to efficiently traverse a device's wakeup sources.

Currently, inspecting wakeup sources typically involves reading interfaces
like /sys/class/wakeup/* or debugfs. The repeated syscalls to query the
sysfs nodes is inefficient, as there can be hundreds of wakeup_sources, and
each wakeup source have multiple stats, with one sysfs node per stat.
debugfs is unstable and insecure.

The iterators utilize pre-existing wakeup_sources_walk_* functions to
traverse over the SRCU that backs the list of wakeup_sources.

Changes in v5:
 - Add CORE definitions for *__local variables to fix s390 build per bpf-ci
 - v4 link: https://lore.kernel.org/all/20260211235055.239024-1-wusamuel@google.com/

Changes in v4:
 - Proper init of variables in ws_iter_check_sleep_times() test per bpf-ci
 - Remove PM patch since it's already part of rebase
 - v3 link: https://lore.kernel.org/all/20260124012133.2451708-1-wusamuel@google.com/

Changes in v3:
 - Update wakeup_sources_walk_start() to handle an empty list per bpf-ci
 - Simplify read of a struct's field in BPF program selftest per Andrii
 - Drop open coded iterators for wakeup_sources
 - Fix condition from !get_ws_iter_stream to get_ws_iter_stream in selftest
 - Read event_count instead of wakeup_count in selftest
 - v2 link: https://lore.kernel.org/all/20260108225523.3268383-1-wusamuel@google.com/

Changes in v2:
 - Guard BPF Makefile with CONFIG_PM_SLEEP to fix build errors
 - Update copyright from 2025 to 2026
 - v1 link: https://lore.kernel.org/all/20251204025003.3162056-1-wusamuel@google.com/


Samuel Wu (2):
  bpf: Add wakeup_source iterator
  selftests/bpf: Add tests for wakeup_sources

 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/wakeup_source_iter.c               | 103 ++++++
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/wakeup_source_iter.c       | 300 ++++++++++++++++++
 .../selftests/bpf/progs/wakeup_source_iter.c  |  80 +++++
 5 files changed, 487 insertions(+)
 create mode 100644 kernel/bpf/wakeup_source_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_iter.c

-- 
2.53.0.473.g4a7958ca14-goog


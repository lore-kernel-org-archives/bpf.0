Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4BE344DAB
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711205; cv=none; b=JvL1jD+lwoGfltnd4NUMSrTH9YtC0HEL5wYwTy6O10cSJE3GpQWm2lzXMRz6A9gRl7/wXJFspvxLEGccD5bATwPxI6T60EV7SoUbAVUs69Qw9zTu+4Y4bWsc8EVvB76DF1I6tMMVJfABrc4YDPTK+XLQyYj4Bm3gMlBd3//5leA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711205; c=relaxed/simple;
	bh=RlOEpQFbLPEsoNk4ZVl9U5QrbBoIsEi83ZVcW6lMvc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNi5ASrnIi+WBx1RiFKmL+3T8b0B8BBxLq7XqubL6tzbGt/yuCQ78EOi4cDAshIv29aUicgMQTa95P0mCNu342Fr/heTw8zfL8W7cFmIaqodZQpLg4F+u4HGL2lXZIr5KBliSh/q7IYWTRFS3WCmQ4p52/ursrkOKziNcWELHWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AoR0yQoA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AoR0yQoA"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a2b383cefaso107533e87.2
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774711202; x=1775316002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z9nnBK0A0s0b0mb0vGDY9vi2MA+PChBVD8pdmgI/vI=;
        b=AoR0yQoAKNKEo2k/9a+Yegpfxi1+RhVcBfYYcZpcJfdFpNYNRJ+Jpn+NIDcBt2NXcp
         5OrwHGzcGUfmhZ67j7NV1VE9gXCKIBYnPv170+E1lvIFxuWyIwxDH8U5jbuGNLUl6Z9Z
         7I+Xz6LhFgvCIabxr8PrJH00VCxWMu+PKrDLiTthFJLvdk1cdQC4lfUW/wL55pz6Y/G8
         WpXQUVVlSEhNNmz6WCnJVNOZj1abcAIJ6bDt//tLzRnBWugHrSHCHnpShq+lPgScEnqB
         aQWga4g48h0Fj7B9/yGlAprbs/xQJea78fP+uvtjMI0racsFnj1kdxWJXy57Gyt+a7tl
         2hAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774711202; x=1775316002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z9nnBK0A0s0b0mb0vGDY9vi2MA+PChBVD8pdmgI/vI=;
        b=VcO0hcyEBFrVxDoMXRdE09XF6SoWVockKYy+0NM0eSRMS3bCP4/VM+ObDfL2QSdJ1S
         9Y4iQE+RqlypbvyAq+jg2IipDc0NBmvPQd3dCaBVnkiz9DeqogJI140EuNdqffnq4mGj
         LFnFsrkPnmPuoUzWektOpsMvKD/7pkw+xZ0hzMuxkGXFPw7aEphQPTpdcv+KoygOijX5
         Oe7VYgV6ZQ+InnTdQlLnPYoYGsKku7fNl48PUhOrsET9s83kEBtdjO0JtkquGrteXVMj
         k6ettUARnQriIuolXP4ocJROsww/oOjvuZ5pa/KioBhupbj6FuruVrhf8ylYKF8vdxch
         zm0Q==
X-Gm-Message-State: AOJu0Yxv9OAGCOBIozNbavv+fnjxq0zVOmP3SRXF4KbugwkO7xP5tnmo
	veZ8hiBsSbKNKScM7YAEcO7CyXMov1kVkmWKWWKL5qVkzKyBPt4uUpZMny3Fb77brff1T1h2DIH
	/ImGLp/Q=
X-Gm-Gg: ATEYQzxA3EY8khZmHhsjz6URCjbJ0PUATIc1yN/ZcfOSImN8bS6yUf6VsEi6BaBb3O1
	55fUlo9WDNWXFa4z7Ygy7SB9lR/09MKzFlhFtDgDQ6tlAPpaxijrlqboX9BiPKxSroERhkOYyyu
	W5FPGndssaKK8CvTWo0nng2qMVc9lupg8z2IvVAgiQovVjf/rS9rIsXFC1p76GPIR21b++HkX8p
	soNxJkMBsjB81fjdx5zdl8ZvJQzZdHU3xf/kpP7OWXUvFcOffNnQmTYYpq7GqK4GrfBUM7W3a7Z
	lc+gVlwwQTxB6VQjS7mYkvePQX9w+BtvIiEaB2pqfHvuXRjxXW28n/9H3BgErqseR9CnH1rWOTZ
	GbpSABR1ceVcwb02IIdC/d8JfA7XScpMxDexWJTpfRj6I6MuEP1qId/A1zoWv1QEkgGUemrjUzN
	zKkO+3ArJ4IKBuYd7aGTiOwEvMe6kPM2dINakzVA87mRyFgPnvtZzW6uXNVo3xdQ==
X-Received: by 2002:a05:600c:a06:b0:487:1108:48af with SMTP id 5b1f17b1804b1-48727d59ce3mr112021525e9.4.1774708008727;
        Sat, 28 Mar 2026 07:26:48 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916da892sm1874017a12.14.2026.03.28.07.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 07:26:47 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] libbpf: allow address-based single kprobe attach
Date: Sat, 28 Mar 2026 23:26:07 +0900
Message-ID: <20260328142643.627560-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today libbpf can attach a single kprobe only by function name, with an
optional offset. But the kernel also supports attaching a single kprobe
directly by raw kernel address, through both legacy tracefs/debugfs
kprobes and PMU-based non-legacy kprobes. Since libbpf doesn't support
this yet, callers that already have a target IP still have to drop down
to perf_event_open() or direct tracefs writes.

This patchset adds address-based single-kprobe attach support to
bpf_program__attach_kprobe_opts() and covers it in selftests/bpf. The
first commit adds bpf_kprobe_opts.addr so that libbpf can attach single
kprobes by raw address through both legacy tracefs/debugfs and PMU-based
non-legacy paths. The second commit extends attach_probe selftests/bpf
with address-based kprobe attach subtests for these paths.

Hoyeon Lee (2):
  libbpf: allow address-based single kprobe attach
  selftests/bpf: add test for address-based single kprobe attach

 tools/lib/bpf/libbpf.c                        | 77 +++++++++++++------
 tools/lib/bpf/libbpf.h                        |  5 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 49 ++++++++++++
 3 files changed, 106 insertions(+), 25 deletions(-)

-- 
2.52.0

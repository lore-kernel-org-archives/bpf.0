Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88451EEA54
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950067; cv=none; b=TQRBWwn7uA9pJQOaw5p0gr5aIgllH25qQ75PAi6fTNrm7xmSOh6rNw3bIZg+XwUn0FSIxQpKmlADnoLB1amavEnCIYnZGqZvQGGdZZVa6DhVxtFrkUWqMR93x7fLId7lvI6TybNNzXzkj7e09TPKj+Pn09X24ZkEkJ6FaMDVx1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950067; c=relaxed/simple;
	bh=TCDZXjqVtoY2KHfHv6iZ3WPVq39f3rhpWlgoNJz3sxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdtb+0dbAqhPr5Oep6AFzNMUdZGDAqHm4djzeijnQ9Pmcg9K7xbF2SqGvm9NlSnPPE80aAE4NFDthbrfJ/cVP56yXtA1NhRCWS0oyPKJpy10l4P06OApdYd90pU7DZAklEN9a7C4GQS3lADNWABUzVvVetjjjWFwUiTEk4GrWR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cxFdiCT8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cxFdiCT8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso4895155e9.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774950064; x=1775554864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nElztS2A7qJnb4rGn//Egowv7jR4mCwF4gH95YG4Lg8=;
        b=cxFdiCT8n0DnkvtxMe//I1ZrG42wM1tOhdgFZppeeN3Isn7xx+h1Jt6uNTsNkalZYT
         mqqoGXd1S+f1xTBhD/P1hJEbeyGIvX7a3WwJysfs0oYIHxeDnyi4N5ASuUrwG5lh3t8k
         0/X9ulK/b/7akohOfO34UX04G8xT/BEf7X9x5jzXQw0bQAjca1qeNpup4Vb8NRr6tb95
         yMeSlX9kOGwT4vT75g9TTRQD4FyOJKgs1pVep9Hv56iqowdMTUcfPejd0U2C1QiwOlD/
         eIvfOkHFxsSG1x6aHxVhNhF9B7rVk8bo5DITdxbJEzJHW8KZYzEigzZfi2w50lOZoXnt
         dDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774950064; x=1775554864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nElztS2A7qJnb4rGn//Egowv7jR4mCwF4gH95YG4Lg8=;
        b=X+U3caaBSZjWfNeUBI8HIpVtS+qWvkSvK8FasqoLzDSo0Bv+hofriV15N66+tPvhrr
         blS1OxhCROkeX33ha1BUcctDbe86fke+mQoylAIht8lwFfhwFADgPkTsY1ITiVfL2KJJ
         owpS0/geck44F6roqgGOCFi8aXW5KiZjpOYFTe/YMciiTuW0ri6qopboMu2NhWfcHSGV
         7t0mpzAGDabROBoXMvSWv/K5vpM/2RvYdLXQl84GtE0ksWB+ntLSauTFE+nabqlcSzL9
         M3qE3G6Lp6jiRwtnOaqDBsiLab/AN8CN7B+Uo9zycSjUiTYvKCJ+WVa1YdrykHKocbz+
         cimQ==
X-Gm-Message-State: AOJu0Yyk8h5O6QaAQ9yTCUqHXX1m3fUt24CkcTp6Vz0MoL/4yCackgVB
	QTilzCcm9ajQmwo749pcbijXNv9B6KMVGUTBm+5o3vTmyOW7sJGrWGlWGpFJ5xUDxt2MKl0NXZf
	7Rmi7I04=
X-Gm-Gg: ATEYQzy/7SIr4LQ5WUdicC0c07bI60qI7rhdZZnKeA1R3vAaQ42z4Fc8d4j6XY7GoY1
	7WA0cB/E8ABMAGD/pdybG5haZ46PY15ImjCERhxsBf4bKH7dTv9y3zF+1SoJ9l5iKr2C3mUddKT
	+YJ/8QBh/TWnU75nlxztf/oQ5g6ZdQi6niHr44+ZL90FSkyPdtdTi2m4SYkGBb+DRjaDIMDejAY
	0M+jIHT5RY7Y+cNkqNcMVfFe/PUQWP8ASSo7dmczb2gxeYqsqGAeIBkgDU1zx7pf5ELdANEwOUM
	OKK5xGZqAbbvMVKkCQyYmPgsemsWA7Y0Al73Rn57D5X+InJv8cGbH5w3oaip4JHIn1rybYngAEr
	m+2GQuaegjuM9xnGUfCtHpuz/nUU5M0IXNBthteqoNLz2s5wBfmKPOMEfpxEF4Mrxix5QAZ3kpc
	jWmntdnOWBRXRnHlv3ntHBJuCL3eQodmY1B206JRjIqsJcV4AO/6bKtZMMMpanSA==
X-Received: by 2002:a05:600c:a06:b0:487:1108:48af with SMTP id 5b1f17b1804b1-48727d59ce3mr282261525e9.4.1774950064024;
        Tue, 31 Mar 2026 02:41:04 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427afbe0sm130079565ad.72.2026.03.31.02.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 02:41:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/2] libbpf: clarify raw-address single kprobe attach behavior
Date: Tue, 31 Mar 2026 18:37:45 +0900
Message-ID: <20260331094058.49229-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today libbpf documents single-kprobe attach through func_name, with an
optional offset. For the PMU-based non-legacy path, func_name = NULL
with an absolute address in offset already works as well, but that is
not described in the API.

This patchset clarifies this behavior. The first commit clarifies that,
for the PMU-based path, callers can use func_name = NULL with an
absolute address in offset for raw-address attach, and makes legacy
tracefs/debugfs kprobes reject that form. The second commit adds PERF
and LINK selftests for the raw-address form, and checks that LEGACY
rejects it.

---
Changes in v3:
- Drop bpf_kprobe_opts.addr and reuse offset when func_name is NULL
- Make legacy tracefs/debugfs kprobes reject the raw-address form
- Update selftests to cover PERF/LINK raw-address attach and LEGACY reject

Changes in v2:
- Fix line wrapping and indentation

Hoyeon Lee (2):
  libbpf: clarify raw-address single kprobe attach behavior
  selftests/bpf: add test for raw-address single kprobe attach

 tools/lib/bpf/libbpf.c                        | 33 ++++++--
 tools/lib/bpf/libbpf.h                        |  3 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 82 +++++++++++++++++++
 3 files changed, 108 insertions(+), 10 deletions(-)

-- 
2.52.0

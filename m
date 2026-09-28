Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2522DEA7B
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790554536; cv=none; b=ECD+nRNoSp6gY3gubah4+xvYP8JRrxKJKadON5Am0mdjXir3aZl8mFZYrCw3GSk4PXPTtNRmO7T0KMsNaf75Qp5Tz1T5BXpxa+2Pu9uFGtT3x1+sRQqcGdwl7BbEEWl2NzADQdhW7aNVLTkgrt5hUvSvvCVSucsy7oCE3UJFLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790554536; c=relaxed/simple;
	bh=B50cgGscspuRERLH6rJ3HSQKQJkNNKt5y/L5zBgynJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzNv7untm+27Kj9fm1YctvC3jVBpR1g6Bo7Tw2lUoMut8dxzM4h66wC+fpdp3WF3FqA5gGfvEus0e2L5dL0vdcbHn4eORU03TonloWdxCEMqG4Y10DbBoNCu0UAiY5LLpT8gKhplzrhDL4HyPbHqHJLy67P6GvXaRbEDdGWsmh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlGrjZYf; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlGrjZYf"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7dc4so2883942a12.3
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 17:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790554531; x=1791159331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wBFSv/2WUiaefYbyP94AR0Ydy/zI5IVO1ywaZPG9nDQ=;
        b=GlGrjZYfpc5RqwI5KK7G2784xqKtKud8ZGtLWS6NMnoF7ZsM9BYX5q0Jo876IJ2XuE
         2GD0/4pUjzKnvn59rV73BYc1wwTjxW1SPhkVFaxEAffP1rXvhuBF6LR/KaqCmpIYVpG7
         U8A4bdzXfe+JPYt0jD1XRFdBndpgPjGD2OMaQxgSQuY45V1jVzAY9vbUGfmorcGuGvCh
         GFbRIG7KEYXk/2KCmjQNna3DyMsWyM29CH+JqwIjXn1neL52z+KOVn1CQS5oU3FF5Nzb
         7m6M9YrQdTsky2f6s9J+FHGQ9FRM3MkeAA2EHR98PA3UDmw78xmMCEqIn4WeFPdB0Evi
         MMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790554531; x=1791159331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wBFSv/2WUiaefYbyP94AR0Ydy/zI5IVO1ywaZPG9nDQ=;
        b=J8V1fCkXyjUSPa/o1F4P6paPX8Pk5JBFd51lj+VomJk6LC+/1h7540jhU3JydAOxlj
         SMf8/ZdxSKtiIXRA3tqGfqrTu8IufD1bTX8OD8AdezkXavUlcM6dhJ9KfblhgFalg+cB
         A8SArmLFzSoteGfyBDZWREcxiSa14fxfAmIJ7ib+obyQc3j7IFFxagjHmCOkqx0W6SIo
         04JIgXQcDo1Y2s6VzzyXVdthgmorpTdWMieNdvh5/minmKecjY2sut1J/z/6m74wYxJi
         XO14ROItnvot67ps/NRYn1c10hJVW7MSVjRaUdLK3tfpqmCqhAk+CTchmAdgZNtJ9XZr
         YbfQ==
X-Gm-Message-State: AFq9FYKbzWJwGCi3LgTKveqtmuZ9vq0Abihcvta8phRWh/YenRKWOBlu
	kqJpSrlwZ5HqoMmIkJlIE4syI/oZnK6gyaOjcwCvpZgBHPjuK78Ba/1XSYO+wTTBJ6w=
X-Gm-Gg: AYBFou3Phf3HcECo5QBfag+rqDKKzEgbVvQ6uUKASuK7X4zWqQX2236UEQkvbWvOR2S
	97igKp4259ix/pbJZhhdwbpZFiuoFBdZM4kBzYFzySQjQpN/cHZRMXszrsgDAG5y2Ypx9uw4kbp
	5QX2Kd7PDZg4CMrJqI/QzSb6Z/WCOHGZS4g7t6Tto+MqSfpzCfvI9oxdSRNUqKyK46W+LbQjicX
	+GZ5JB3+/Ei7e248kMP6oyiyGYt1BW+ZbgR6bFYsJHXNr/keG3x+fNhLOjRsmR9kmmtYeB01hn7
	/l1Lv2HMuw5GCTkDKE6CEPKg8mllmJW8zFo+dffiFcIQ2/SOzEHfbwbjd1ClLTRxMVaqBypeTHn
	TJ/16+ZAwLbKaHi3DBT6fD2yjyzta7KqHJv1V3dr98+gvDAs4WZsNXIgftFkCwyiz/qHu5eU/55
	0rFARzFYMd+BHR8Kp3FILeFtMucvK7Pr8VaO67Ir4bTPU+PnvG7WPuISLo6vgzC3wbpt4dFvb1h
	Ud2ajuXEbHVVK0=
X-Received: by 2002:a05:6402:4344:b0:6aa:f11d:b659 with SMTP id 4fb4d7f45d1cf-6aaf11db974mr5303923a12.7.1790554530452;
        Sun, 27 Sep 2026 17:15:30 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ab5be57b13sm1933955a12.33.2026.09.27.17.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 17:15:29 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kuba@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc
Subject: [PATCH bpf-next v4 0/2] bpftool: Fail map dump for maps that can't be iterated
Date: Mon, 28 Sep 2026 03:15:06 +0300
Message-ID: <20260928001513.7072-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"bpftool map dump" treats only ENOENT from bpf_map_get_next_key() as the
end of the map. Map types that can't be iterated (local storage, ringbuf,
bloom filter, arena, queue, stack) fail on the first key, and bpftool
prints an empty dump, "[]" or "Found 0 elements", with only a non-zero
exit status.

Patch 1 asks for the first key before printing anything and fails with
the map type and the error. Patch 2 adds a test_progs case on a socket
storage map, and on a queue map without BTF for the plain output path.

The new test fails without patch 1 and passes with it; the other
bpftool_* selftests pass. v4 was tested on x86_64 under a bpf-next
kernel (ea9358e1270a); earlier versions were also tested by hand on
queue, stack, bloom filter, ringbuf, arena, sk_storage and empty and
filled hash maps, and through BPF CI (x86_64, aarch64, s390x).

Changes in v4:
- selftests: socket storage always has BTF, so the "Found" check could
  never fail there; check the count on a queue map without BTF instead,
  and fix the comment on create_sk_storage_map() (bpf-ci)
- selftests: split into sk_storage and queue subtests, new subject
- rebase on current bpf-next, patch 1 unchanged

Changes in v3:
- shorter comment on the probe (Quentin)
- selftests: unlink the pin on every exit path, so a killed run doesn't
  leave a stale pin that fails every later run with EEXIST (Sashiko)
- collect Acked-by on patch 1

Changes in v2:
- probe the first key before any output instead of printing a hint for
  ENOTSUPP only, so every non-iterable type gets an error and stdout gets
  no "[]" (Alexei)
- drop the Fixes tag and use a neutral example map (Alexei)
- selftests: check that JSON output is only the error object and plain
  stdout has no elements or count; clear the output buffer before each
  run (Sashiko)
- multi-line comment style (bpf-ci)

v3: https://lore.kernel.org/bpf/20260926170149.541352-1-skokovmaksimevg@gmail.com/
v2: https://lore.kernel.org/bpf/20260925162031.27259-1-skokovmaksimevg@gmail.com/
v1: https://lore.kernel.org/bpf/20260924160732.485650-1-skokovmaksimevg@gmail.com/

Maxim Skokov (2):
  bpftool: Fail map dump for maps that can't be iterated
  selftests/bpf: Test bpftool map dump on maps that can't be iterated

 tools/bpf/bpftool/map.c                       |  23 ++-
 .../bpf/prog_tests/bpftool_map_dump.c         | 132 ++++++++++++++++++
 2 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c


base-commit: ea9358e1270ab2c3ba6f36bd9bdda68617665516
-- 
2.47.3


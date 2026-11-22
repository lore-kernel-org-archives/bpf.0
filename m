Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795350877;
	b=1hgadNYjfQa7XQxWaEp+oFqPulNvuzBSntpsVo7yUxpIx+SoX+VeElsIIKoA2Bzbkggh
	 HkZVnWy3TIyKCYBGuDwDUwanV+6THb5I+gkSzf1P1liID1TAO37TEYSFhorjtUf6QwWKY
	 zrPYJIv/yUtkStvkI09l1vrbx/3DdgGKAjG/mbjW8q0VJBrWQkumRzWzaWJGcvB9M5uqN
	 /mwloj4C5bRUgtVb0E/aP1O6f+61yUPxfAtQeqzV6rn6BS1QodQzPmw239jm3CiOeX5dU
	 kJTsS0ETHpZEBDMXOX4nY8zqGpIW6Z49Kt/pQI7cDGopypWvGbqBivtiM2Z/IHvvMRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795350877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JAwbBVLQ5Qw0WIo34F/0quqwwlp+frY0Yma8iuDK49U=;
	b=uNMK7TgG2tXSCnDt347m0ew8p6PTWR5qrxCr1G3i23uLQ0LHSF81kvjEJ8JpT/FpkoHO
	 Oct9e9itwPJdzpKQQUf4jyY9hEx1nt5A9VE6F0ITpFkxtBE7aOpFynFC25AJtZbhdtErw
	 UeyqHBTsFjVnQpnbDnoQwfix/eOqiK8stc4qT17bAmBE4knKFLeIWY9O8ZyjZraAUStpN
	 NZvHa1MgK3Bk19O7/QoVFHC2PtxqWWZK8I7k5nrbA/k2ZE2kRHRDiYEy0VQQcAXWUiatk
	 D9EqB8i5p6gPUY3kN3dCMYZGvfNMvMu3SLVB6mc0dqCG+iWUCKxAzQw6Kifg2NB1lcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=znXeNDjO;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C4A606A320
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 12:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00C4A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=znXeNDjO
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-382f4710a17so4126275eec.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 04:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795350876; x=1795955676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JAwbBVLQ5Qw0WIo34F/0quqwwlp+frY0Yma8iuDK49U=;
        b=znXeNDjOjC1CP3HbL8FdUyoqU+9GbcvYEv88CJsguyC0EYyeproOqZ4E9kyxXZhPOZ
         u0iuaNaFdDArEJC9W8YpggBe9H/fQH11Nvt/ebEWuW8wkeyAgYGwuSs+Ylh8pumR2zQ6
         yJNWSkcDYnTgJLfMi7q7TUnJwXWxB3QOPRKHndCF7kiQzwgkl1sZC4nqs+mrjeFBNO2K
         Zq7ESD+jpCB8hqVo3dLiEOiCdYvVlx6eTfEKkJNIkGYxvustd9LdJJlDEaz/MEGWHA/E
         AWRftIkr62icpY4ZSdMYt1C5QwGuRJ0evrYDNG3/2tnw480anZThBNkWvKfXa+QG7b+6
         VoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795350876; x=1795955676;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JAwbBVLQ5Qw0WIo34F/0quqwwlp+frY0Yma8iuDK49U=;
        b=ZEAMp8eRxA+yurhe8sNc5sW1KzSq5emRfXnHntmiu1FvjhCOk0hghP5e+wfw+FFVAS
         Fs+2/ABhujAJXyDhRR8ozEuT6jK4QvaRCYKv/5cf6FSBQhPVvIcc43JK1MLfc9S2CRNs
         HnDML9JZNW80uX6ZdmbzjSNpivBCHaSG+mpxcPDMBuRgf34wQTtCRF89BvW6tJzWxFZG
         +z7ojDY1D2qqs4HR07Lu1B1ROhQ8GtHtk1wPLptSp1SfI6ZGl5MYjD3dfHnQeadHPXls
         uN4LIvCXMKHfDdLVhI16k5mKxgvs8TSdep0WX9P42DWS9/mQg4XJXSrxYggOVPgVNyvv
         7/Tw==
X-Gm-Message-State: APuU4Z/OJiwhgJTebLax2zkIPnEMZQK1QwJ7+FkLsSDc+qcsROlj3cPr
	IH9a7C8+0ia6Qm49BStuBsKRDbPZPlsDwQ/tYhtAU0DSl+oQ6X6y/r7LzNvXUfdVYkA=
X-Gm-Gg: AZFdTZcZ5jo6LWbJdSZxCuDIxYnIaCjK2uPExbkPeYU7J4bRDlzxsPkDqBuG4ZFNO5K
	QCKLLCdYptfYe44xbZ8VVf0cW6qYX3lpcUMM4kRFMBRGW4Jk8NzxyNbsiQ4N8i/u1wBB/gKmur4
	5wfIQAP+w823+17UjvLmE6uXhRpkNRGqE6f4t887dAi1eI1CFQlI421ToHgZVde8RqmitO7vP4M
	pAxJROsdP1v1OArzJTi1XZvS5WuSoOXCmAShYC9HkUwkm9SpwQkAycHlr6DANOGw7UEVWrxxyLW
	muqTXRWU6PP632TjZiiVgX8FxFOp3WXmP30Aq5NIDMSQuYHxAOi12mUw/hfXN5vpN4HsQSHqGJQ
	xiUcVd+1/XXOxZ7i7KLgFyGYgkR1Hu7a19r/sd0UCvHL+NcsebEMOcbpMQau7hYl8Sjxq3+HXEW
	DnWDqujCb4VbOCygn5Xirk0CxOsMiwFXG0Dixu/fAvkMBAgw1bq6QpuMUwE3ucIKd2EHwV39fd2
	9eedsZShVOxryP3kcGRE/hxngdsKMOVOcIWDcgdD8vWvTW6GeCFC5Bck9AA4NC9wWKPbVKSGgwJ
	IPgw+HjDWif7my9UtVyk+YPb/UZsC7IEUhvQnyKF/toXcuW6ecjAHi9tDJmaFHZGTA==
X-Received: by 2002:a05:7301:4281:b0:386:a193:9afa with SMTP id 5a478bee46e88-386a1939c38mr3959805eec.11.1795350875844;
        Sun, 22 Nov 2026 04:34:35 -0800 (PST)
Received: from boogieman ([182.66.218.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm33372330eec.5.2026.11.22.04.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 04:34:35 -0800 (PST)
From: Abhishek Khade <abhishekkhade69@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	Abhishek Khade <abhishekkhade69@gmail.com>
Subject: [RFC PATCH bpf-next v2 0/2] bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs
Date: Sun, 22 Nov 2026 18:04:25 +0530
Message-ID: <20261122123427.287521-1-abhishekkhade69@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset introduces two new BPF kfuncs for binary-safe substring
searching:
  - bpf_memmem(): Searches flat memory slices for binary sequences.
  - bpf_dynptr_memmem(): Searches BPF dynptrs for binary sequences.

With the introduction of bpf_strstr, bpf_strnstr, bpf_strcasestr, and
bpf_strcasecmp in Linux 6.17–6.19, BPF programs gained solid support for
substring search in null-terminated C-strings.

However, in network packet inspection (TC/XDP, TLS SNI tagging, binary
protocol delimiters) and security monitoring (e.g. BPF LSM hooks
inspecting raw memory or binary execution buffers), data buffers are
frequently not null-terminated and often contain embedded '\0' bytes.
For these use cases, existing string kfuncs terminate prematurely at the
first null byte.

This RFC adds bpf_memmem() and bpf_dynptr_memmem(), wrapping an internal
allocation-free scanning routine based on the kernel's optimized
memchr() followed by memcmp(). Buffer sizes are capped at 2 MB
(BPF_MEMMEM_MAX_LEN) and needle sizes at 4 KB (BPF_MEMMEM_MAX_NEEDLE_SZ).
To prevent pathological quadratic O(N * M) RCU CPU stalls on repetitive
inputs, cumulative byte comparisons across memcmp calls are strictly
bounded by BPF_MEMMEM_MAX_LEN. Both kfuncs are registered in
common_btf_ids under BPF_PROG_TYPE_UNSPEC so all program types can call
them.

A comprehensive selftest suite of 25 test cases is added covering flat
buffers and dynptrs with embedded nulls, offsets, duplicate patterns,
overlapping prefixes, boundary limits, and error conditions.

Changes in v2:
  - Move bpf_memmem() and bpf_dynptr_memmem() outside #ifdef CONFIG_CGROUPS
    block (reported by Sashiko AI review).
  - Register kfuncs in common_btf_ids instead of generic_btf_ids so they
    are accessible across all BPF program types (BPF_PROG_TYPE_UNSPEC).
  - Fix dynptr size truncation by using u64 for __bpf_dynptr_size() to
    handle 64-bit dynptr sizes (e.g. file dynptrs).
  - Bound worst-case search complexity to prevent quadratic O(N * M)
    RCU CPU stalls: cap needle_sz at 4 KB (BPF_MEMMEM_MAX_NEEDLE_SZ) and
    bound cumulative comparisons to BPF_MEMMEM_MAX_LEN (2 MB).
  - Safely retrieve dynptr buffer using __bpf_dynptr_data() instead of
    direct struct field dereferencing.
  - Expand automated selftests from 19 to 25 test cases, validating exact
    2 MB boundary scans, oversized buffers (> 2 MB -> -E2BIG), and
    zero-length haystacks (-EINVAL) for both flat and dynptr buffers.

Abhishek Khade (2):
  bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs
  selftests/bpf: Add selftests for bpf_memmem and bpf_dynptr_memmem
    kfuncs

 kernel/bpf/helpers.c                          | 116 ++++++++
 .../selftests/bpf/prog_tests/memmem_kfunc.c   |   9 +
 .../selftests/bpf/progs/memmem_kfunc.c        | 259 ++++++++++++++++++
 3 files changed, 384 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memmem_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/memmem_kfunc.c

-- 
2.53.0


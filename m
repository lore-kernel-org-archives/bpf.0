Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B91946BC
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770849120; cv=none; b=nvRlCAriBLVz+7EZS3vNpSbomiiy8yVBTBNRS8ZFp2iWKnBrwxQWHW5H0cOf5A65aJlWrC7uWGqD14fNVRrfEvJGEGkhgLnimw94t1qwtrq0+GZXlTa/TJQF0bCV3EINLXGnDdwYbf8Dl81s9Eb2IZPttNQ6QRFRZdwo4t3Oo7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770849120; c=relaxed/simple;
	bh=DCSCoGzPqs8phuXBRWp6hj0onNdZ7ydy3n5jFak6/vA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=usnBrsoikn0rlZLM+HKtHxl2aOhARwVK4TtuY5E0KTLtXCkMcwQQpIcjV0fwfJpGWvZWlsHpwjx8IZk6HTc4InMEEYkujUL10wlCAiUqWixD5piNtqquixKxtGna6AVa3BkyrlKDc641Qs7gZw4wZp4Ri+7cJ4jgKxIbx53ro8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAO7eo1/; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAO7eo1/"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba88e53b46so773401eec.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770849118; x=1771453918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2AnU3KwlbrNVF1EWbnARa+KVdMJGLTPVMMGZqs/ACeQ=;
        b=JAO7eo1/V5QcDBQaPJudU4ml0xefXjW0wD1x1Qwf2qzTOXReNn0kvShbLmCgnZqrGB
         tmWq8Avz6JkI3H3NALJWWAdznv1m3azhmcbBNBQBOe4HxrQOJPps9lSiVYrfo0hw+HVy
         Zzzxd2hOL9etIkRes8WVVEUh0MQyn8TJnECc/qcY8PlHc4sifwPoeDcqtlPxzayBSHJ0
         ZF+ZsG7KUf/gHmsUdo8seDmTcWZ9HvcO2BVKo9EZu0W8mqj5dcoSqx/4u+JtWgX+ChMJ
         YeuOE/LeQq0CzvICxo2wmRjEZAoWMhXXaiX5+6+Z5J5fk8QXPBHtjf0/aQ82Aswdy1s+
         5+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770849118; x=1771453918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AnU3KwlbrNVF1EWbnARa+KVdMJGLTPVMMGZqs/ACeQ=;
        b=EiPvFc55Rf60gBIC9O6SCyb+LGMXXqSSV6xhupaREWMr1J50yGxroA9KYUPrP1p0He
         9ev5g0VQw6h24yG49QXVcOQt2Vi20y0MVTwsQ8R172yEhxPi0pOC8rd2CnN8FkOKx0R9
         BDySJCJ4TFBiXhyQwG0sMVHe7BP+Zs3XJmDXw87qTyvj6gLng8RfmIFAXnAAd4ZjejzZ
         9zOrLUTS4NYSJCajrxoT/C4TY6ZB5mx/sFdsw14QGxBAvGQJTcRqP8rJc6jpmkNyvGnH
         JekGyb70y0uE7rUaH01rdmSac23RWhJrer27usIKMtBiSE5mHbRnm6IoXbfDfY+qH1/m
         0OiQ==
X-Gm-Message-State: AOJu0YxuKml7TZTqMfcOWdLkXC3U7SrKTeipfgNRQ/0ARowPbkNeNg2U
	+YXW2XjI0w1LeMC5jPNAcLu9ptyDEcUBNN2lS/vN4g/PN1lEdjajFDBrUGXfdF3X
X-Gm-Gg: AZuq6aLy3ehjPXjt9kJrGTrS6+XDJlaNntL0tuKKH4y76fSJqlLaB+wB+JNAS9vCyUD
	q17deY2bOsm+pxQj07L6AtLf+edTrZU/rj6YtHhlFiLb65dcjGxoHl9jWyyRXWsTDF0WLmB1Vlx
	fWyTxvFZzOClZira0WRDQtiFeh60sRAHur53+R5sOKSNvmEkYAw7DdarS9p+y5OAq4BcQXWXdSj
	tzY2j5wRye+X2ygjDINcWWS8c2q3h8cZUmbeKto8jqKiyEdkuH06HiQHRHT1Gi3fuHEQXY6Cou7
	Gdxi+9vPAzAof6e4SzNk7bbyLoEIEcTvSjRn3+SEGBBkAmCvfE4FSI4JV1neZDVW0TlzINUqhn5
	20R+jq51co6qCCinaqT7mqkAnIi5bo9L0ZFhDJiYb1UKLsgvgqqCZM7VMvxCYBvDeAg+T4Uuqp9
	IIkLWv7Moo/v01GAWzIVfiQAKyNs35hrE/99cRjYg75r5NoiW3EYBTAtCmsorMwD/lJVHSJlCQr
	tWbZms=
X-Received: by 2002:a05:7300:7493:b0:2b7:5a7f:f74c with SMTP id 5a478bee46e88-2baab72308dmr233453eec.9.1770849118154;
        Wed, 11 Feb 2026 14:31:58 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:8141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd0609sm2639306eec.16.2026.02.11.14.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 14:31:57 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 0/3] bpf: consolidate pointer offset tracking in var_off
Date: Wed, 11 Feb 2026 14:31:37 -0800
Message-ID: <20260211-ptrs-off-migration-v1-0-996c2a37b063@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260211-ptrs-off-migration-9ad00d0c3f93
Content-Transfer-Encoding: 8bit

Consolidate static and varying pointer offset tracking logic in the
BPF verifier. All pointer offsets are now represented solely using
`reg->var_off` and min/max fields, simplifying pointer tracking code
and making it easier to widen pointer registers for loop convergence
checks.

Patch 1 is a preparatory refactoring of check_reg_sane_offset().
Patch 2 is the main change, moving pointer offsets from `reg->off`
  to `reg->var_off`.
Patch 3 renames the now-repurposed `reg->off` field to `reg->delta`,
  reflecting its remaining role as a constant delta between linked
  scalar registers.

---
Eduard Zingerman (3):
      bpf: split check_reg_sane_offset() in two parts
      bpf: use reg->var_off instead of reg->off for pointers
      bpf: rename bpf_reg_state->off to bpf_reg_state->delta

 include/linux/bpf_verifier.h                       |   5 +-
 kernel/bpf/log.c                                   |  10 +-
 kernel/bpf/verifier.c                              | 363 +++++++++------------
 .../testing/selftests/bpf/prog_tests/linked_list.c |   4 +-
 .../selftests/bpf/progs/exceptions_assert.c        |   2 +-
 tools/testing/selftests/bpf/progs/iters.c          |   6 +-
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     |   2 +-
 tools/testing/selftests/bpf/progs/verifier_align.c |  40 +--
 .../testing/selftests/bpf/progs/verifier_bounds.c  |   2 +-
 .../bpf/progs/verifier_direct_packet_access.c      |   4 +-
 tools/testing/selftests/bpf/progs/verifier_gotox.c |   4 +-
 .../bpf/progs/verifier_helper_packet_access.c      |   2 +-
 .../bpf/progs/verifier_helper_value_access.c       |   4 +-
 .../testing/selftests/bpf/progs/verifier_int_ptr.c |   2 +-
 .../selftests/bpf/progs/verifier_meta_access.c     |   2 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |   8 +-
 .../selftests/bpf/progs/verifier_stack_ptr.c       |   4 +-
 .../selftests/bpf/progs/verifier_value_ptr_arith.c |  10 +-
 .../bpf/progs/verifier_xdp_direct_packet_access.c  |  64 ++--
 tools/testing/selftests/bpf/verifier/calls.c       |   2 +-
 20 files changed, 235 insertions(+), 305 deletions(-)
---
base-commit: 4475cdac12c46fc26ee815de1b43cfe9f8375140
change-id: 20260211-ptrs-off-migration-9ad00d0c3f93

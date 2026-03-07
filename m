Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C81285CAA
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844885; cv=none; b=D7QJS7azGmm6vxpOqejfzZ1lCzUmx/d3q56nRW88usHi2Gwbw5bZhuomPiU2HqNDxr/bVJoUK+ZvFLdxFS0Il48NWUcXKgDSpx13/2QqPeiWZ2rzlWiT7gfxoZtz8+XZCGg9R9O2XT/FE0hTIgTqKppgaUo6SopWL4b/Fr8GCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844885; c=relaxed/simple;
	bh=Kxmt4WfEyYNC9B4OggoW30VD5UzDtIxDJwASqTNRxDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LJ0f6vvuyON84XiV0Q779x7BWHD/jT9SU7H/Yq4sK2cWO3+bwv+hcJz+Ha3LggLczRkGWsZcRTVBs/yNkwHaX4LJUvuZlEqQRiqKPERuOvE5ROK0eIIsSECgNZfbbG1GkM0HAbzgnJxWMDpe3m+ES2YlgcnEQP1GFVneD/ptWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eY0RdJLi; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY0RdJLi"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2be3bdfda8eso3001583eec.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 16:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772844883; x=1773449683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Le9mkTgn2CBuj1c4DzQEBUqZ8ua+0MeeZqh/9YSh2EY=;
        b=eY0RdJLieiQankcpp+R3DGkGeErs6ejUhU51AJp+VtkG9WlSSRBUFzpvIn7FVy7EMn
         Jjk9HPu5s81ESjWZYmmte05yFa1iAplDxRJ8zK/HMmVpHXQEjswwun/ID75skU2Tb/7P
         p6quIUqP7HnX9wQImA9cjWSA9zkN1rV4wYOmm2Xjf100WrzAQ7hS9F5apx1zuyIlbxlO
         K54yud77a1ka/ucj7bUpLGGiZ5BN50npSoA70S+6MnhR7bgWPRCI7lPcOJ2KBbNJcRms
         ZL7chWnMlpyvWbakppJ2Q5jWbx61Iug79Rtln0CVe2cFnwpoHa1ban0mxZJXNw6PJP+t
         ekFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772844883; x=1773449683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Le9mkTgn2CBuj1c4DzQEBUqZ8ua+0MeeZqh/9YSh2EY=;
        b=eF0BUTXCeKWMyr25i+bqRUlFxs6B9gWNSwLD0BFP7GaGwNV/5GDGeTGH+AOkYMnw9h
         jVZSuAvs1wFU6S6fOILU4VMzKfZpxFzsVvUC5wkI8mte6Mh6pT68oqHg2BD9mI/0n7av
         tOLm6LC8xr1pAlkYRiEqCwDJlHFhfcXPb3miLq9xb1RjNcsiLLQTk3YjByhQedpIUSfq
         o8LwyKi9ZlWj7+wmYwqo6V//7KhhjXijaQzbEc8cnQCOFOyft5nG6UYYXHbvvBUiySKL
         +ozAK9S0oz7WPOyKynUgidC530uoK452p8uGuB0wIAI+Xn8mG5Vyd8atFfYxSxp/WW8o
         nfWA==
X-Gm-Message-State: AOJu0Yw0TKQMExmFghIZBJg3kwHHKaKkQWerWIwew3dYdycD9CQHUGHw
	CcyKe8rlprnjF4zv2XN9TSeaMi0rJxcYTqQS4v6SbWAk7r/jiKDOQG6BknT+pZZt
X-Gm-Gg: ATEYQzzmW0g/0j0H5HY6KSEwEUkHgYqeASze8lZ+RFp4hVxiEpcQk5r4dMTwVXAyS1e
	xLQ+jvA3lXS9nZ9LXtDcrj5U8w9Q0TFGD5UqWarIHcQQhz3oL6toPvSvGqq/y6XNK2CY6W94qEl
	BxC2g93NSgj/lwKsFhesnjD+Oh8aWaLMZamT2MzO6xGU2VhigCABjnuUz8PWm0UWORI95VMNEef
	PbcT5Bc/4Gr0X2oumKR+hP2n46PpfWszyDUqSJ84y3vGZ/AyRD1bY4ZNEF/HL5fAJ3AgUgzv+8W
	rt1b+t29Im9T3CecpKOUrRSVw+SVSIsijloCQiECycHFSPC8V+K0Zj+5EuhSinWDX709gaUC2Zh
	uybm/TcHRPnlUZmXwmz0DuptBRtb5rd39J+of3irMsIIec5TRxDpjWpJaBDxhMfiP73LzHZmjcy
	2NDGsLQK6owD4mi7rK3A6pOLsg5NEQWO99qzLh6K4xiZG8DWVl/5tc9qdSHxExIQxdn35B2A2Wg
	2wQGXw=
X-Received: by 2002:a05:7300:ec17:b0:2ae:5e93:b6d with SMTP id 5a478bee46e88-2be4e06434amr1440661eec.38.1772844883342;
        Fri, 06 Mar 2026 16:54:43 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f62d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948390sm2235110eec.22.2026.03.06.16.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 16:54:43 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	emil@etsalapatis.com
Subject: [PATCH bpf v3 0/3] bpf: refine u32/s32 bounds when ranges cross min/max boundary
Date: Fri,  6 Mar 2026 16:54:23 -0800
Message-ID: <20260306-bpf-32-bit-range-overflow-v3-0-f7f67e060a6b@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260305-bpf-32-bit-range-overflow-00351dfb8083
Content-Transfer-Encoding: 8bit

Cover the following cases in range refinement logic for 32-bit ranges:
- s32 range crosses U32_MAX/0 boundary, positive part of the s32 range
  overlaps with u32 range.
- s32 range crosses U32_MAX/0 boundary, negative part of the s32 range
  overlaps with u32 range.

These cases are already handled for 64-bit range refinement.

Changelog:
- v2 -> v3:
  - Reverted da653de268d3 (Paul)
  - Removed !BPF_F_TEST_REG_INVARIANTS flag from
    crossing_32_bit_signed_boundary_2() (Paul)
- v1 -> v2:
  - Extended commit message and comments (Emil)
  - Targeting 'bpf' tree instead of bpf-next (Alexei)

v1: https://lore.kernel.org/bpf/9a23fbacdc6d33ec8fcb3f6988395b5129f75369.camel@gmail.com/T
v2: https://lore.kernel.org/bpf/20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com/
---
Eduard Zingerman (3):
      bpf: refine u32/s32 bounds when ranges cross min/max boundary
      selftests/bpf: test refining u32/s32 bounds when ranges cross min/max boundary
      Revert "selftests/bpf: Update reg_bound range refinement logic"

 kernel/bpf/verifier.c                              | 24 +++++++
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 76 +++++++++++++++++-----
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 39 ++++++++++-
 3 files changed, 120 insertions(+), 19 deletions(-)
---
base-commit: 56145d237385ca0e7ca9ff7b226aaf2eb8ef368b
change-id: 20260305-bpf-32-bit-range-overflow-00351dfb8083

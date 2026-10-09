Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E54EE859
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791568097; cv=none; b=GS4B0Xox0XKevd14SvlLvkNzW1C2YofPJmc1ugg1LYIye7+W7VJdg8IRaLPbIqu0KWvIKNY7uAIZVTEi4DUS8QAW0oPOmmJbcz0tdBkV1AQgqeJrWAGd6pVh7lDPtaWzJPRKq366zm+FnI9I1vJaQSsvjToORa5jZKV27vimfU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791568097; c=relaxed/simple;
	bh=JgPaicxCucfdMkRINMIAPBjQlAb0HOrhvBZzO59T1bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inmrjdF1nlFGrmHFyTn55LJUUwmcW2GdsQ6+356qVBd1ozaIpMmMhwanHUEhKaLLl6NvG6AhYy42ZANX/bChew1TJ+CadcKMTTlu5J5farnIYbrdehjNVngXAimOvW0kYwSr+pQ6PVSCeLCdQMZJnlypfotrk5n/xEF62JaYv/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAuOrsvz; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAuOrsvz"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso6815323e87.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791568094; x=1792172894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pA8E/ThbMiBTOoyIyD/1D76SZ7hCfLkGZWv68NB0mJs=;
        b=YAuOrsvzMD0e/VL0IBVH9fLziRwJqN1laynw2JFcVT/5CkA88bLIMuKnHiBxE5m6Zn
         +s/ZzLHaBWSNKrsXM7wp8o/eI2N1nOTlFB5V4Ty/Yq2N/Xf3/PW68IehFvokUbm08oAt
         DSFtzUMwZh1/Rj6XDF4QG4cjoTjptWv47hjgRCe5UbXmM01UbZePvAOXVrIHIlRDGKew
         x0cW9sGD0iLDP8SzcS/jhemyrn90Z6YKr0Wym/VSAPIZq7SeseqEwfoE9eOJxOHSYLIa
         UUKdYKVJo2ORtsBUhaIvGnIpNi7vfns0m+TbQDbkUHo4fKZO2m1gGxj6EolQNwAYARru
         E7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791568094; x=1792172894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pA8E/ThbMiBTOoyIyD/1D76SZ7hCfLkGZWv68NB0mJs=;
        b=hMPNiwS94IY1vaEtLlQhAXCp0fc50tWTLY0Kkji+s3fe9N4LWodrrp/Eh4pING3+Yt
         nPj+z43MRl7X/QXgO/fhZvlHBmME95COnoA5SVzJDPR+23g/DTas2sw8olCl8/U65rdO
         JeAD1fZr6OS6h5xyOtu2yrRDrrS+u7VoyLJ5r8hWeBRmjtMAYOp7bsmZs7w8cXy43R0z
         CNgemsXyaVPYSsiHcYdPnw0CJ0gqnVvjlHcjKSz1edeQgK/h/DWjsSGNPUVrYMPgUgAQ
         onCmV/6YOX4JpOeVMx9pyEWo+gs04q9CH7wsjXC76X5NaBtva7xc8JmZwkPqo/j+hjhD
         qsew==
X-Gm-Message-State: AFq9FYIuhRth0yPGms/gA9UqYppIqd/AhHUk7OYkRREJ02q72ofPSJeu
	6U8ROuvwHX5YgpovetX9xu5EyS0yZluNPXOD5Jr6aDp+AWn0T+N/RSkKGl116IA69hQ=
X-Gm-Gg: AYBFou2odSDcaLYhIsdbDq+1RQB46Vcqh/SzQsE3KYVlUz6Fp3O+f+dsfwsaXJtKF5j
	ADqDWLL1TYW+WNJIyEsr9Ruvpk+Pi2+LKab+yS85Pr6uttLQ8tpiUlB5kPkcfqwSPicmGheUU9j
	huZdDYavDbibSMGHZRTHuu6UeqL1kqM6OC6ROSHnbSfhNTVnmueJVpanlK61E1DvJUv8JEFser4
	oktXtJqtE8Ma732vDroW5sprJn5T4QO6l9FE6Gu0QyitrUUbfFqPvr26M8kYOGryiM91SFnM1aF
	GelqCkPVohzK9iEtLBHjkTfUW0tok2XeXlQrAbYRaO81nm1tLFvtY8F2joEFOP9bUk/H8TCblt+
	gytNkaE1xGJHr6W6DMxL+AmTwARa/C6THqOzJn+2KpoCbV7XOLUAyBhSqnxLBgxb+GsQSO7rPp9
	fOf3rqtBsB8qgWzw2lsygNuiQfgRGxPABx+Dstn1i1giBywRKBkGv8S9kGcZsiLtMAbOsMxGHQr
	tTH5sswrKXHrGQs01KBYo1DG4sGPUDzRB+wzTw+7vxqMkC63+iO
X-Received: by 2002:a05:6512:3f24:b0:5b8:f533:d439 with SMTP id 2adb3069b0e04-5bcde8c1acdmr1016443e87.38.1791568093888;
        Fri, 09 Oct 2026 10:48:13 -0700 (PDT)
Received: from localhost.localdomain (95-24-167-79.broadband.corbina.ru. [95.24.167.79])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcddeb5604sm852635e87.63.2026.10.09.10.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:48:12 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxim Skokov <skokovmaksimevg@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf: test_run: Fix false -EBADMSG with BPF_F_TEST_SKB_CHECKSUM_COMPLETE
Date: Fri,  9 Oct 2026 20:47:46 +0300
Message-ID: <20261009174755.22026-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_PROG_TEST_RUN with BPF_F_TEST_SKB_CHECKSUM_COMPLETE returns -EBADMSG
for correct tc programs that call bpf_skb_change_tail(). The helper
moves the skb to CHECKSUM_NONE and leaves skb->csum stale, but the
post-run check added by commit a3cfe84cca28 ("bpf: Add CHECKSUM_COMPLETE
to bpf test progs") still compares against it.

Patch 1 only does the check while the skb is still CHECKSUM_COMPLETE.
Patch 2 adds selftests for a trim, a grow followed by a write, and a
negative case that keeps the skb CHECKSUM_COMPLETE with a stale
skb->csum.

Tested in a VM on bpf, with two kernels that differ only by patch 1
(subtest results):

                           without patch 1    with patch 1
  change_tail_trim         FAIL (-EBADMSG)    OK
  change_tail_grow_write   FAIL (-EBADMSG)    OK
  store_no_recompute       OK                 OK
  test_skb_pkt_end         OK                 OK

Changes in v2:
- Put the opening /* of multi-line comments on its own line (bpf-ci,
  Sashiko).

v1: https://lore.kernel.org/bpf/20261007181249.352831-1-skokovmaksimevg@gmail.com/

Maxim Skokov (2):
  bpf: test_run: Fix false -EBADMSG after skb leaves CHECKSUM_COMPLETE
  selftests/bpf: Cover test_run csum validation after
    bpf_skb_change_tail()

 net/bpf/test_run.c                            |  8 +++-
 .../bpf/prog_tests/skb_csum_complete.c        | 39 ++++++++++++++++
 .../selftests/bpf/progs/skb_csum_complete.c   | 46 +++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skb_csum_complete.c
 create mode 100644 tools/testing/selftests/bpf/progs/skb_csum_complete.c


base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
-- 
2.47.3


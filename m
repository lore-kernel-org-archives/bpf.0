Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4C576ED3
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097635; cv=none; b=RyM5qQ5qKxgmctLYRiNNdkKLMzimkZ0iSK1s70PE7jQtl0HrBxdiMoSL6pf74DxFfy/HO3GmlZXYysSEI0gTwyw2hkn3a2TRv1RnuYmmjLgFJOXQlMTQA/sHqrFCxJf6ft0Xl+iSvmcLh86mOwzHn7a6K3GuvIu/E/DhQUuMIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097635; c=relaxed/simple;
	bh=YGMK1R0R9ravte3mZzxq5dPBRIF9YN5gHhuG4Lxk7qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIhlRMWvOsvNmg8Aw/7oYRhldSflb8fAs5w1oxaJP9Ul8U3CxX0iZX678Y2kHzGuao8MNO0TWVDLzBlfT0+ZU0GplgHhqWxU7YvNT/J5jImkk6FIF14YXuvCuu7QxlqUgw48xlJYKcDeG6B2JXWuFcZIDA670t8ckpSo2Yx56Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=h3b12TkV; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="h3b12TkV"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so132441a91.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097632; x=1790702432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m73w8MScEFOpXNoHT5D1Hw0tXoHQrkRbgHhw9/iqEPI=;
        b=h3b12TkVAqVP4JPpixa1HMBZjEQ62G13iJNxkBlTstZmcKNDTiQtscvVZZY5Kyfe6B
         KhrLWP9PfhyMeAdT4/zEZHismXAPfvVrfJuf7/LSN50jeA/ZWqRULi5U10XcwfvdK6PQ
         l8hvFqPz7GxeQm5SITnhjl8Ui0YQbsTxNd7Qr/Yqmc3rr/uDGYUdqZK/Qz5e56E5OSpn
         Bk8oycG8B7LeZKLT1QBst4BpS9CYNls0Hd/pMgW5d3MwZ70l3pviKanSa3sjPeHtsLga
         Dn2KOn/ziatuN9bARR+XlFQSyPBJPXEuGLED83yMHUSp8FEcT7+Yjog/8gT8VkendGWP
         xFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097632; x=1790702432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m73w8MScEFOpXNoHT5D1Hw0tXoHQrkRbgHhw9/iqEPI=;
        b=W5zSFYie93NP3JeMUpnR0qS8M2qShqXN+Jvr++ayQ7USWbZyJR7wdd0sZOBhN8sopL
         kJW3J0AR9nFq7gzZFXEhXcc89uZFhzuV5W3Dhbplz+ocYEojIrJWnik60WCi3TXbar/U
         hngXoDTsGjduGW6V/z1rxjcFw6AohGhfEPUkXF4R1FSk8Brzwfup6vx6carUg9XXyLQC
         0bYo3qWK9f/NUOZgqjk/N9YrlF0Ix18uJGjmDzeNpXOdiexnlxSR9GVvO/LQnmGlC7ph
         ddF2YnnPQF2CySD+K80LYIfLnKJRq9CecERnBQAiwtrzzq+ao2CJ7/G9Xxu0h1aVC4WP
         r3Wg==
X-Gm-Message-State: AFuF++nNwObYXgIjgVdRKOZ39U2sWXkZhmx74a1qVNX6xh/sjMpfPEJV
	jHKTAn259hlX9810+d3QM2YOrxdFUOU7SGHWc8IRW50OR7yD6YEoiqDwA7BaAQT4T/888+xNVhW
	aSRas
X-Gm-Gg: AYBFou3OvMfoMAtLjQtfEGp7B9Gz81ygjGozXRXWSTuOElboXwc94vl94ZP+ZSDJfQP
	myCMKjlN+jFWSKo2sBuI5UHjoe3cVs1wnuroQbnQPXvc+YzK7v5DROMPp/GQz5Fs9blraoYvNLM
	RMEXkgt662Z0+Rt03ZUVOSVaqcngSVX/D3JphuQvtly5HJ6/dNme10xtQl8jTAg+px+SsCrcMQ9
	8iWKLymCfKT7HPQv7abMHpbYQbbWJNjBpv5ui3IEvAZblvzY2HKCcUqQ8qfgcoYpDhYMAW4QzXk
	5fNcS2nebNHVy3yS7vNU9B5ZTuHcQBIiHwE2O5uIQUy+NqBokYrCaCyilJvpqB1LMyKyqRNjyxr
	IP+p1AghVo6mb5vRAj3IvuugCfr3LKzBcn60JGR1DVuVF+hc5TNaRgau4TfzxDuo+AdgVpGFkNE
	qiSqhyLPEDEfg4YUgpHWJAYu6+c+erEeevqiNrEwlRV7RCC6l8xSGR0nlnw803KFzezfopDDXot
	Q/tgEYqX8EAO38XQ7TC1pijADJ/kIEIAnGDk//2Ig==
X-Received: by 2002:a17:90a:d64f:b0:3a0:7d88:c2ac with SMTP id 98e67ed59e1d1-3a07e65d0bemr104505a91.18.1790097631698;
        Tue, 22 Sep 2026 10:20:31 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:31 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 00/11] skb/arena bugfixes
Date: Tue, 22 Sep 2026 17:20:17 +0000
Message-ID: <20260922172028.6269-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set of verifier-focused bugfixes related to dynptrs, SKB
management in BPF, and dynptrs.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

v1 -> v2 (https://lore.kernel.org/bpf/20260916050830.8774-1-emil@etsalapatis.com/)

- (01/11) Adjust typecasting to just be unsigned int (Jakub)
- (09/11) Test for the new field in stacksafe when comparing registers (bot-ci)
- (01/11, 03/11) Added Reviewed-by by Jiayuan

Emil Tsalapatis (11):
  bpf: Fix bounds check for skb-backed dynptrs
  selftests/bpf: Test dynptr slices past end of skb
  bpf: Fix bpf_sock context code generation
  selftests/bpf: Add selftests for rx_queue_mapping context access
  bpf: Reject pkt arguments in mutating subprogs
  selftests/bpf: Test rejection of pkt args to mutating subprogs
  bpf: Prevent variable arena/non-arena register contents
  selftests/bpf: Test for mixed arena/nonarena code paths
  bpf: Track whether dynptr type is known
  bpf: Track skb memory invalidation by packet-backed dynptrs
  selftests/bpf: Test dynptr slice invalidation on skb clobber

 include/linux/bpf_verifier.h                  |   5 +
 include/linux/skbuff.h                        |   5 +-
 kernel/bpf/cfg.c                              |  10 +-
 kernel/bpf/states.c                           |   1 +
 kernel/bpf/verifier.c                         | 112 +++++++++--
 net/core/filter.c                             |   7 +-
 .../testing/selftests/bpf/prog_tests/dynptr.c |  10 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 183 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      |  20 ++
 .../selftests/bpf/progs/verifier_arena.c      |  49 +++++
 .../bpf/progs/verifier_global_ptr_args.c      |  53 +++++
 .../selftests/bpf/progs/verifier_sock.c       |  38 ++++
 12 files changed, 475 insertions(+), 18 deletions(-)

-- 
2.54.0


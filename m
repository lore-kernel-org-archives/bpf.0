Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9907238DC54
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521541; cv=none; b=lV0TPE2489kUK3lzlcWJD1vYpEqF2wGwJUdMQToGmcGy7/0/CUh/7pzJjhoTZLGbNFDN3dZ3ZFbxGzuYmjGRosBhnL9HsJKqJuYJB3LKhGXoNcsOqX1JX6GB5Vg2IqDBzk5yAiGMU4Kor+eWiYK+JzT8J8KY4nm7iP9xmq9WKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521541; c=relaxed/simple;
	bh=RMBDjkqGbWm9wJAukPt1Kd7KynCKqGe6GMaTE99xMPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tqgxDr8oI5VO8X1lpPnA1A5TAT7ubzEIZec5yxn+xVKDdbExWhQTFm0E+ahLxaTaj3PJsRO+i3Rcw/m9IpzyTNhgeUGpEcz/O7fvuwuzdwhIXbYkueVQmYvK51U55Ski6FEcziZRNuytuB3qo17mJhAX13ZXPFAlgL/+bCLL/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JA/ke9pl; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA/ke9pl"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-398b9f722abso1904985a91.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 18:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789521540; x=1790126340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LV2V3CfURWjJXxuTqv+U6k5yBJAt7hjXFfxVOqTsIDc=;
        b=JA/ke9plsY6+AXdPcN4IeDxjEVZ/uTCxmUpVArwxhjP5SphbmiNhgenXLDk6gANRs0
         qR3CcUdSy0la4eEUJ+Enoj9O8Qe1V4IhObWpijWu6XNuoHZa3MgpXbk5pr56y4G4nKB9
         vE3meyNHSfk6r66uWQsQtXskAgk+qZJI+5t3dztLmg5KWrBP8Fn60AMpQGpqP79euKAQ
         Da3rehzCpXkyS7DxWAgpmVwkiALsN1cFgqUbK0o3IfiLQRKtUyjRMU1rZUV8YbxILlSI
         rkNMjKxlvWoCKB89tCC2T+vEuyp8uW47jT5GNDA6ec7fRXmtP0oFI1V6IcEydRI1s/+y
         stTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789521540; x=1790126340;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LV2V3CfURWjJXxuTqv+U6k5yBJAt7hjXFfxVOqTsIDc=;
        b=k/gHYuBiRP0pRRqaHlBYS/I2sXsHbpEPsPukbSsdsIOyNC2S0nBPj7hPx45ZTSoeSn
         tgHUhonwvFy0hyfJP4BNiFMtfeGGXDmuTA/HY+BZJJKZ9R6jKCrIQaZimtd8JLW8CC5k
         Uhhz0I+ARVp/RsScacnthFOPXxct+WZYSevMfnLrOixGvfykBKJsKvsnCyuzfQ9XwHlU
         bBv6l5UbaA2ME2fn6C1KJoSIKRqP2zJvo6hMM40UumOtF+/HRApixGhkbIBeF+8cmmeU
         FtKTIXsjRlqjYlzpvqWJlYbAqqkq0n3SN0QGbL0eplvqX6VPxEobGymdTBPuqdCJp8Lz
         93jQ==
X-Gm-Message-State: AFuF++ljsBnFjbuo/1CBbnvkXnm1qSx1z+nKqELhdhhWHS7C8uCYY3do
	Fvq0yjAm6qWEte4fA9KnV72AFOYwG+SXaNKwLvsR+jd+an0gxD46AQSt
X-Gm-Gg: AYBFou3abM3Zo2xf4OIgwTUWgQMkzA2TvnmeAM9zaC+QtCY4wjCzUBMG+PnOZDQId/t
	AFH7LRTHa8Wh+m73N8uMsUOxkYK8Mp6AbbvxA1rRipH0aCQG7HZ5+hxpvrSjfvNK0kx70rUaYPN
	H7H4tmiwI6BJQpMNmloAAM4+a0gR/3p58mgZzi4HA8LOFLnfuf5XtpFuoCzCAcVtsD0UL90yt/2
	QDlvTc3xcmdKcLla1QNkC7cbgm/m8+WW9GRnLAlVsJgJZov5Pa+nrLK9CW+vj2xOJb1hmNTOyPj
	F5RbyfyCJQDjgKyV6xf8KGgux5rCxkNnehrYiA6Gzs160RT4+goejvprswwrNE0HUXjg0p267g8
	SSD6Ea01l5ljw6QcUc7fiLrshcCiJ0XpsfTgY1rH6eA5cbm6wLhn+VFtkoIHmIB07O+ixUKUYMk
	DzV2Kk9r1nUOrNXjIZhZ/cmBFbCpMsjC5BHNDIIAlqPPenVAw=
X-Received: by 2002:a17:90b:1dce:b0:39e:89d:21c9 with SMTP id 98e67ed59e1d1-39e1e4431c2mr1577442a91.11.1789521539918;
        Tue, 15 Sep 2026 18:18:59 -0700 (PDT)
Received: from 192.168.5.7 ([2602:f921:f20:17::a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a182sm2799980eec.8.2026.09.15.18.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 18:18:59 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: kernel-ci@meta.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev
Subject: Re: [PATCH bpf v3] selftests/bpf: Check returned keys in map batch validators
Date: Wed, 16 Sep 2026 09:18:55 +0800
Message-ID: <20260916011855.1563648-1-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2b6eb4563b296447ef2011962270b7da14edcc84eded24e3784dd20c8f6f6b5e@mail.kernel.org>
References: <20260911025036.190487-1-diannaaav@gmail.com> <2b6eb4563b296447ef2011962270b7da14edcc84eded24e3784dd20c8f6f6b5e@mail.kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi CI team,

The latest failure for series 1162495 is in VM startup, before veristat
runs. Could you refresh the vmtest executable and rerun the failed job?

The sole failing job is x86_64 GCC 15 / veristat-meta:
https://github.com/kernel-patches/bpf/actions/runs/34808652400/job/103868698882

Its /usr/bin/vmtest appears to contain an HTML document rather than the
expected executable. The log reports:

  /usr/bin/vmtest: line 1: !DOCTYPE: No such file or directory
  /usr/bin/vmtest: line 4: Hello: command not found

It then exits 2 with an unmatched-quote error before the guest starts.
There is no verifier regression result from this job.

The action requests vmtest v0.18.0. The run-vmtest installer in libbpf/ci
uses curl -L to write directly to /usr/bin/vmtest, followed by chmod,
without HTTP failure checking or executable-content validation. Adding
those checks would make this fail clearly at download/install time
instead of trying to execute an HTML response. The log does not identify
which HTTP response or intermediary supplied the page.

The earlier run of this same patch version completed veristat-meta and
reported that its output matched its baseline:
https://github.com/kernel-patches/bpf/actions/runs/34800861264/job/103846813446

The latest run's test_maps jobs also passed on x86_64 GCC, x86_64 LLVM
and aarch64 GCC. This patch changes only three map_tests validators;
it does not change vmtest, CI scripts or the verifier. I am keeping v3
unchanged for this infrastructure failure.

Thanks,
Tianyi

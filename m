Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D65239E7D
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 03:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775618072; cv=none; b=k5Sam/S9R6G6YonZjwFFYCqMu6EGBTrYVKG1kfhRhHKsytGk2r0GJb3e5x2kZpiRdcW/54lg70yJI4brtuiBKg+T3yGeu6HSj0VpvOvyfPLK8dWr50Mnxr7A5/OSeP1oVvuYqYg73f7N8uTcL4pMMqFkKzpJREmOeM2xqSfy1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775618072; c=relaxed/simple;
	bh=k6bJloJYtw8y7wyBAFFrsNS+t6UXJtRmAyGG9edLQKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XT+15RsH4rtcKDe/qcQ28PG3EMii/POSapeZUA4rmqo9wdO2UhRzTfp3hAjUc8OET+FT9SaeBeYFqsdMeJIXwQvj7fPLM6tYXMMUb0450BprAMuCSaiSyiwaGySD/C9YYoGAuD2qC91Twtp2vVYUxGKN2rvC+hSqxmXi/1s2Zlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bc2PTMnP; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc2PTMnP"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-35d90833cacso3544832a91.2
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 20:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775618071; x=1776222871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KjCwjmm5FMl1mBDFLPEpQ/1ZQNj7Ms/Y3OHB07UOpRY=;
        b=Bc2PTMnPoJUF3x+bnBtclT2xlpcHoJ40TzP+iQjb1jVNf62SrEM6JD4n7ruTXI33W1
         UmBHCDRrWNhmyadkCvAX/XRfLYYO/0Nk+GWNzkjPxHzqNQUDnCZGuJMz21FDyBnWAlMW
         E4h+yfzQSB74o/YGqolsetZVKkqxBgHyNXWweXUPds9YDEBKq6uQwH0f7GsHF2+m8h0Y
         a17LspHz0oq/563IVH+MhKeDP6MuI5+tx9NzX0wGb+B+hTTkaNuJaG9N7AlUIgoiKtNt
         6iRvxjzxC4Qp7GUgE+pCmRXPZe2l8LTAdeuBlpI2GelngtdZL7owr5VcQwSkjVeghjp1
         /cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775618071; x=1776222871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjCwjmm5FMl1mBDFLPEpQ/1ZQNj7Ms/Y3OHB07UOpRY=;
        b=d+6oBTmnw+kYZCiJ8hbTPsPEO6NiNPyIxTNO7Y24weuA+DATjvMK7DDvK3v2xJyePy
         tukkdQaqZcawBKcmt3d5PHltmU753raeVmzKlonPZFVq7NwZRbn0JkqJvfxkMgYjUdVq
         F5VBtbsbFWBX7/M+TKIrBj2AjMACFIT+O761421bPGXwPSpM8dMXzKXjLuncB9No5iXJ
         nA+Kjxz/DIuW1eaX8bD87ja3MXl9lXas2yLUyyPWcRSilqXrLKgfIg3sOUgvzgazWS0u
         gFWrKkDfik7pfomTmpLG9RtSNlTQIk/LYHY6vZjgsHjyW1sdG9BAW7Ux9QjM1zMFBkWA
         19ng==
X-Forwarded-Encrypted: i=1; AJvYcCXL6zU+0uRaXacpvrq49bfZlRKGdisVII1MPcw/8TQ+jBiC23uONq2Ct/wwmE+PaEGoc6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYhKdg8R9MReS3L82m4L0L13fM6J8bauOof7VGVYylhveJpyg
	dw2lY0bXv1whysWVtm7Tvc4SldpYXozb3OAYN8PY28fnuSoVweD2B/lF
X-Gm-Gg: AeBDiet6r9a+K5U++wuK/uggYXqpocFcpq21gdJqapcRrCcvniJMFShhxVpYVO0/3c5
	MdgmRpjABiyJHSsbG6IaGrqfnk/1WZQxLiJCzkHiHvfKuEUm5taOVmI4A7z9SFKndv9krM9gQkG
	+nrNYNpfsInYvEP+RC+T5jfVsiOUIUCgiQymgbAVSW6INaKr1edT3FfBnjpsNY+ts4LAyOGM1BW
	l7A9uFOrUSfB7OAJF/8ft4GVNeLwln/kDQGZkFLnDGXqNG/inuibcOkezOZ3p8a19vT1wrYjU+A
	pSomYHTp9+cj7jkaX8LajVcOB86DBRqBCfAAOBBVuPXsHPhZc9uGFGo31E+86vEDjWnves48V2D
	74cEFB/2NqyIaZwRCZoLHwW4DLBmQjSzKDZHxfLDaybtzHALa+Qr32kgN5H3422EQu+o3GEDAoS
	YXHAgHxh4KtWnnGhhqtuqz
X-Received: by 2002:a17:90b:4fc6:b0:35c:30a8:341 with SMTP id 98e67ed59e1d1-35de68b4c84mr20893495a91.13.1775618070776;
        Tue, 07 Apr 2026 20:14:30 -0700 (PDT)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe41b11fsm23506913a91.0.2026.04.07.20.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 20:14:30 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	emil@etsalapatis.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/3] bpf: add the missing fsession
Date: Wed,  8 Apr 2026 11:14:13 +0800
Message-ID: <20260408031416.266229-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing fsession attach type to the BPF docs, verifier log and
bpftool.

Menglong Dong (3):
  bpf: add missing fsession to the verifier log
  docs/bpf: add missing fsession attach type to docs
  bpftool: add missing fsession to the usage and docs of bpftool

 Documentation/bpf/drgn.rst                          | 4 ++--
 Documentation/bpf/libbpf/program_types.rst          | 4 ++++
 kernel/bpf/verifier.c                               | 8 ++++----
 tools/bpf/bpftool/Documentation/bpftool-prog.rst    | 2 +-
 tools/bpf/bpftool/bash-completion/bpftool           | 2 +-
 tools/bpf/bpftool/prog.c                            | 2 +-
 tools/testing/selftests/bpf/prog_tests/exceptions.c | 8 ++++----
 tools/testing/selftests/bpf/verifier/sleepable.c    | 2 +-
 8 files changed, 18 insertions(+), 14 deletions(-)

-- 
2.53.0


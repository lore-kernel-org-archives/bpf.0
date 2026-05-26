Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A53783D1
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810135; cv=none; b=ZBeQIsR2AJ4hUWgutPQbiJme2DWTKYsEWf9p8Qc6IocFR01vCX2XU+KpLbjbeKoLjiuLiIP+08gO3uOJoWhLtIX71TvCFvm4CYWX0x1Zfh7Yv2OGhk73kIST0ZbSS9+xWAQIkdMgAf+sWLB55QUG7OVo509VgSwXOiDqo9KPfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810135; c=relaxed/simple;
	bh=GX2vdzDQw0orDpF1KNiOJ+YXbUSF7H7c0zdw6D2rYGM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rD46Fp8k3XE+BYVV/BI6kiv12WAHjuQ9wPWt2NLY1ExOH7IRHQS+RS9M0EW2KjzVA4CTLDRMlCddtixgBIaL7CLwMH1ABOkgsuGQxrGk5JnDjAK/BPZmufvQ5ph/ppVRCiq7Ce3+wO0fgDTJde9RxUCNVMZegVBGhOPcHwp433E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DH2k2lZ6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH2k2lZ6"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43eb05b1875so5745365f8f.3
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779810130; x=1780414930; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDZTHc6BBusOWypWkW0rlAgV9n3xRkLBnweZCKkigSA=;
        b=DH2k2lZ6A15JD90r1OmMU6mZ/DWSu0W1PsL1Sgf/iurcWFvCjeIsg+E5kSIsKdS+0U
         PrP8Kd9EBqgI3QGB05S1hCS8eDjV70OQt/6sc2hvyjhG+ohrFXkYjNM4SZaTfco+dlxV
         pcpJLIfTxoXY6+Z1/Xl2rh88Q4SJQeZ/RxH05CdfYt1yzVo1W3BOsoB1kVdCzJWsxtTZ
         DXYubUPS1Gh2yDfdJfohRpM9zJC5Ig/S/oc35EOd7qnBu+559/wa22WVtvUl1HQfnVKi
         0j7QzF1NncKAhJ+f8xx43odTZrM5Eg5emJdPvbEjy0maYOh+7XGv3N/dEX5MpYHpyNDM
         Lg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779810130; x=1780414930;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDZTHc6BBusOWypWkW0rlAgV9n3xRkLBnweZCKkigSA=;
        b=AIBQ2Dzo+8MTa780kFLwrEPRp42WNN066S72CEeJC7rZOvS80pW4TC4VOKD9tr5lA8
         7MS+6UhwZGbL28lmC4Uxc7rabC0I0FYw5QxZ04youTdIF+0cMt+ekjD/76w9TnJdnbsf
         aYn/1afuoRyoVjZ+GdbWLdMKabsMazTUDtaRx9lrS2nxg41Ivq485ym9wIsiBPuOv0EG
         JGhEsg0Z6HKfXNiMtbpMXE/YwmhmSWyowgz/hy9RS+69oP7WbNMZv7k9VcEY68Duo3n4
         SBTE9ZkfbvLXj+fPgiizEt/qJTJ2/23lUhrbK4iSBD3w0eenq/kZ6YtNM+6WtUfSVBDy
         ZEww==
X-Forwarded-Encrypted: i=1; AFNElJ9+lrMOgCZnboaL2jjYTkkHBOFXSPkQfn5Bl2f1SsF8jvhzr4XTvNYBxC9jCTDfXqSPjCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4UfS5vXl7ahL0bCADGzaYZxwcVkpvoa0s3K5bY4LHo3JLm83o
	jxD1GX5ncVc/4SlFvvSTbHbaDkBp3DlFJIO17LZkdSEd4AtwtmxEz+vG
X-Gm-Gg: Acq92OE/ivVQHCTdf2iElsZXb7uXVkyF6TDcH4WsP0A9722TYBno3zo9COsfsCpIHzN
	7ZJ+zxu0rQMaxITnJLJCcfG0a/G/nLVBKzugywxSdjCVS/rMN5yPrFIGdR3Vwep6dQM2n4hBv3O
	GCQEfN1TE5p3G9diyVCUJsE19t0AhDO0uZyLBx3SWffdvcOw8qz9wJcsjdpHg8PqaCMhy+rRsLH
	OAwm9itI/zfANcELD6DLxItt7j4VTOxIRzJ31e5EiLsE+cdZKyob1FyHwyjiVZNgsSEi1i84sVt
	uI8kKrZ31DfJaKHsy++I9TIx+w50T0qf9YvLFI8UVo2/5LU+Tvn1b2UMAiMZa6u6QawGBNq8UZS
	YpdbYLLdaEP7OzhAsl4ehp5VSsT3pLiQxhFjtN+aUlf42I9mlf0wyQYFXrkCU/Oc5mwQMcYX2sk
	XbiHHuv0mYXGVLk97IjNc/CE529AlF8OA=
X-Received: by 2002:a05:6000:2688:b0:45e:c60d:ac2a with SMTP id ffacd0b85a97d-45ec60dac3bmr24637687f8f.12.1779810130080;
        Tue, 26 May 2026 08:42:10 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:4b00:f03c:ba00:3081:348a:50c4:2d80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5c32esm35301088f8f.26.2026.05.26.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:42:09 -0700 (PDT)
From: Jamie Hill-Daniel <clubby789@gmail.com>
X-Google-Original-From: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Subject: [PATCH RESEND 0/2] seccomp: Allow using `SECCOMP_MODE_STRICT` with
 `SECCOMP_MODE_FILTER`
Date: Tue, 26 May 2026 16:32:14 +0100
Message-Id: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779810129; l=1608;
 i=jamie@hill-daniel.co.uk; s=20260302; h=from:subject:message-id;
 bh=GX2vdzDQw0orDpF1KNiOJ+YXbUSF7H7c0zdw6D2rYGM=;
 b=OXrTw6xF/ecZYZ1dxc2m8CiFjiL33PvMa/qxStGbXxcF2fu7PQpVWt5ZPg4CpA40udjy1wjVl
 Vw9J7i3HoF2BLujaECVs2iAJHWiPTPqBGHiPOQVfzmhuRgu37yKLdvI
X-Developer-Key: i=jamie@hill-daniel.co.uk; a=ed25519;
 pk=ovqCXSlFUjrT82WuRtIuXB13U5n1yfxM6o0M5O5J2tA=

This patch adjusts the logic used by seccomp to allow applying both
`SECCOMP_MODE_FILTER` and `SECCOMP_MODE_STRICT` to the same process.

Currently, once seccomp has been initialized, a process may not
transition to a different mode (only add additional filters).
This means that in container environments such as Docker, which by
default runs with `SECCOMP_MODE_FILTER`, processes may not enable
`SECCOMP_MODE_STRICT`. This is an obstacle to using applications
requiring `SECCOMP_MODE_STRICT` in these environments, and requires
disabling these security measures.

This patch introduces a new `SECCOMP_MODE_COMBINED` (used internally,
not exposed to userspace). When a process attempts to apply
`SECCOMP_MODE_FILTER` or `SECCOMP_MODE_STRICT`, this mode will be used
instead if the other mode is already enabled.

When subsequently running secure computing checks, we run the strict
checks followed by any installed filters.

Link: https://github.com/moby/moby/issues/42082

Signed-off-by: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
---
Jamie Hill-Daniel (2):
      seccomp: Allow using `SECCOMP_MODE_STRICT` with `SECCOMP_MODE_FILTER`
      selftest: seccomp: Adjust test for using both `STRICT` and `FILTER`

 kernel/seccomp.c                              | 46 +++++++++++++++------------
 tools/testing/selftests/seccomp/seccomp_bpf.c |  5 ++-
 2 files changed, 28 insertions(+), 23 deletions(-)
---
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
change-id: 20260302-seccomp-combined-24bc3dbe32fd

Best regards,
-- 
Jamie Hill-Daniel <jamie@hill-daniel.co.uk>


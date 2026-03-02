Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04A13803C5
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484725; cv=none; b=V/MAsr4I3cLQf0G/oGb7o9Yi0Ha43A/1UtbYaxs4+k9xHIYEhTHvpdHF9zd0+XxkylWVwKFEq1dAq08tyTsoZYj3ypVXaNN61K4DqaMZ0d+l2quC51gH8lhJZndSAd8othQpz8U3Bd7TgISPdnsww0dNK8pmd5I+Silhk74XtdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484725; c=relaxed/simple;
	bh=GX2vdzDQw0orDpF1KNiOJ+YXbUSF7H7c0zdw6D2rYGM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DiZ0OM6tN4USGhfRQLbNryJju43kqwMFncwbCThlxVGmpycFODuIKkE8zmXTJAo+LWJk9Fi4841LEzLXFc9/Rv2Z0WXCDBAGCsLIiQeKurwj2o2EDkZ2GGGuC9QVqFFlMYBc+yhCJAthLwTbdkdXHloS3zqeAlyu8qGC+Dt+5/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcEc0k0x; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcEc0k0x"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48379a42f76so40160175e9.0
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 12:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772484721; x=1773089521; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDZTHc6BBusOWypWkW0rlAgV9n3xRkLBnweZCKkigSA=;
        b=BcEc0k0xnXwLqx3BAYn71fakEtFCvMpcx4Eg2m6NjO+ZaRsNg2PRm8rsYF3loqFX6M
         zF1DzQw6ZQeQUca4mpm+4zf5xz2nvj4pi2+hinTH6C7KQ8WYDCU8WMaZ8AdfKxwDaQY4
         1u0OdzEWWRpiubE8594uRO6hlpuBxFcfVEWtEgfnQdLSmtzvU6ZGHWNpUHmn9Tj1Gkdv
         hovJNq2GAReEHI8p0Fo/LqvtY00Hg2nfQGKcZWVmvFPDUsXsvJxmh/eS9SsFSVmtqa3i
         zXFMFZHYuX8fjbQiHoBLQvo+ABQNSniC/REf/OlPgtGXBX4Joi05VHNZ6mccVSd11Dip
         kqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772484721; x=1773089521;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDZTHc6BBusOWypWkW0rlAgV9n3xRkLBnweZCKkigSA=;
        b=MAq7KEa+S5krp2I2ZZ5grr+cRFSx/zEO1OCAUvV5+TZYZeX6RV4kmp0qk6nvxlooEz
         9MACnoOWGAmkVHu+MKezV3tSsKMJE8/QFA/Yc61Re8La2VIv2LoJ60fOs1hoWSJ3JkPD
         flr3TKqKzvIwE1wVfWZXTWwhO4hYqNC5Syqh9CjxjSl31yTeG+IGqDNuiaGY03CJUVQi
         wD0TlH7UMycXaop8m4JoQPTuDZ2cgfb3acBWA9e/22FvTf49zComiY8m9RqOS5zb2XKw
         Ru1shToZqu1QnWtjHXPDOqLSESBxjmaixlPNxVlndv9RBfoj64xV2HG6w2oCh43MIzpf
         r/5A==
X-Forwarded-Encrypted: i=1; AJvYcCUPkKGVQsnrH6nBeKQ8H1xROPIiX9aKYjzjbPSPTBpARWuOlVTqfsmPswo6LBtJ5gHUH8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj53E0cnEw8dvEK+gUpzc/cVGk44hu61I0dTb+H7tCAWtx/Xxm
	cHOKz495xaOJaz2N893kt6aQ1eG0gKcaXXLZ/MAvJG6k8ukSeUABmN7WN3/NdJLh
X-Gm-Gg: ATEYQzwtbPRq9H/wyoq/RWYUmIdVgcTwh2hEHOHpg4QDQnk+c4rcL4Bb/J1BvqJXVSb
	s7FSRuO7iP4qPDyF99JrWN3teKCJCwJGKd7mPKsfBNNkrv49Mqwpzx89IhTW9vGer5R4GInK5E1
	ckjWirNHe1H5BSVO8VJXJ4CLdQhuRkn+6i3e7AdIvibFX3HSJypj5qNmnPXv8RyFNo1CJLhtIPz
	q/XpyoE7XMZu/B730bVEnTn9leNPBa63LS432Jj/moxMwNBJ9inL5pAg/PyvFaGmbouXcceJ1f/
	e0eJj7PpKsS+dyemx83HkWnq9VMawk4UuC97MQGXafq0nmRGJToE48wBZYOp3kofjEyJ876VNSP
	uu0bJjQgWcwNYVgwRG2yBV2vAZ5oZ9I3zXnKK9MOU2qiQ1A+aq8lwZve3IhYL6wHuw5u/gvDlKs
	PJpPF+ETn6kwi+pTBCu4w1Ngjn6WvTjJGJrPOgSTtp1g==
X-Received: by 2002:a05:600c:34d6:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-483c9c1cc59mr250790135e9.31.1772484721113;
        Mon, 02 Mar 2026 12:52:01 -0800 (PST)
Received: from [127.0.1.1] ([2a01:4b00:f03c:ba00:3081:348a:50c4:2d80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485126705e5sm898705e9.5.2026.03.02.12.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 12:52:00 -0800 (PST)
From: Jamie Hill-Daniel <clubby789@gmail.com>
X-Google-Original-From: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Subject: [PATCH 0/2] seccomp: Allow using `SECCOMP_MODE_STRICT` with
 `SECCOMP_MODE_FILTER`
Date: Mon, 02 Mar 2026 20:51:50 +0000
Message-Id: <20260302-seccomp-combined-v1-0-c0cb7acb0f97@hill-daniel.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7TrA1OvSV6JC61h5SUYgg/HtLl
 4E5zLzQqDI1WNQLlW5unJPIOCjw554O0hzEAQ3OxhrUjbzPV9ECx4mCxsl5GxxZjAEkK5UiP/9
 y3Xr/AGc4iVZiAAAA
X-Change-ID: 20260302-seccomp-combined-24bc3dbe32fd
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772484719; l=1608;
 i=jamie@hill-daniel.co.uk; s=20260302; h=from:subject:message-id;
 bh=GX2vdzDQw0orDpF1KNiOJ+YXbUSF7H7c0zdw6D2rYGM=;
 b=naS1/aq+YoMzST/EZNS35eDMvxD1nHxkUULPJov97RZuOYvEodeTZipKJVNsGQNbzyJaR6OiM
 FrNvzsat+wtDFPXTRdZBYwK5BWKbYVFjdYhc5xpu+W43Sdh753XTf6+
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


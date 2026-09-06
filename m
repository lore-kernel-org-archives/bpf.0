Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809E3655D8
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710808; cv=none; b=lmswouG2Y6g1cnYsivSq1wBYaCMTXH1LCP3hdkz2zOHgMyp4/KHzL8m8acpMrUIRzfJdWnEXRRh7S1BDX4oSdNGUvN82UpHrrO9NwU4mGAPNzOt30Jzx/RHvgSA1xw9WiOewV7GcR5rTrI9Z2f/DeqndUioZ8KV0ilNcyAoIDDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710808; c=relaxed/simple;
	bh=jnZDT8Sv4Cj1A5f61+G4HgmBdnITr/OETP9KlUhlXV0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AH6yQynMnzEWUZ01vwGKyQslNHwsY8i3kwXHNY+lDYC5f/eBbqdcceLdWyI61+b79XSnF8HHJf2lyYfGpP2oL5PF1ir78aP46bpUXHU6numTZWJRxr6yD1WWGmnYNJt7csVXMC+vKsaO3JAIZmE8BroksPzjPw58dLb4tfuBURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhm8MoOU; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhm8MoOU"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-878ed0f17bfso741337b3.1
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788710805; x=1789315605; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wSFdM2TEvYurq7tSF4Gk6z6k0v1njEuK783Dp9gtcPA=;
        b=qhm8MoOU6224BW8Lh5oqJ27Goal5D3Z6xwXQEVuM4keSQbsohCllNIf8Q6SybzIFdE
         5Bdez5PpMvqStxRPyE8wVSmvvgIMyxGfUOjQrpmHfZrx0rQ/xk0UJ9EZAkocq+D7fXEN
         Dc/QU17+Acp71/Hg2o6O8pIFhIskb+Mtgf6pj9JojOL3x2hUY/9R2+3MEhekgPVmO+Ct
         IWE3byr46Gr1BHp+NvF6QYT4Xoar+bciRgQto9qEsgy9BZUyHUtKOJ72PcZXqI2ZgRqC
         8FfcaXUCnMOrt9OukN9J2213RgBRNs5z/JuLJG7ZeBp+O+7QiNI1gJXMmSJDdlurRLU0
         XUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788710805; x=1789315605;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wSFdM2TEvYurq7tSF4Gk6z6k0v1njEuK783Dp9gtcPA=;
        b=rfbuFGLm1XgqkaU25UrDLWOKfp8G/05K410YBtuYenA3Y2lwwDo6XDxW86wD7x/o2F
         OOfamfN03wIkIH2YRfwHJkSwizM3ABCZqxlTE42Y7CF4TcQC9cxPYyrQaWk3DDBwlt9I
         sSVj/tIVXM8sZ8DvbHDSyVGT67/PSZXh6+5ydYvHB7H3SvqxEzCNxFEfwl68AEciHl3v
         a9nfM2lshmYh9khKSCfW63nz2cSyDLLMWI6CjN8yw/9onb6j1FVUq0bq5bEjqeYwNj2c
         CNaxEiQITfwftm/M3cPe7is5tmqJjF4WaVDW3LupLB5G+Ff/WYH98kw5UrZY9lv6NBLm
         FiBg==
X-Forwarded-Encrypted: i=1; AKwUvByzCDyfgn6SpO1ZVNKbcHeBk5FJYATd2AG+Bv/2kifa3guiDqqNBY2EO7U+3BrbO0BVcIQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lQ/zr5fDMfw5W541wch3B8cGAtxFTxpXJNqbtMi4mUwCRx2Wrf
	Ro7s9ice4QWpi0rtVSNi7IL4SFcZQidfDkauQ4iNLDU6CACvP6OXiOXs
X-Gm-Gg: AYBFou207Iu2OutWGFvN/hpmgeuceR9SE5hQyjCbOtml8LF7McEIWGL4HNxPwsUnyO4
	wePpvMSzE+oyOEjcFfbPHOl44SSjiDA3FWzDZJJB8kKwazvwhemGy5hazp/NdBwbpYzozFrAOgk
	QT/mm59wlfj9MgeCxqMHxlnrT/VSUfqQuWAfKAk8PXn9flP7Vcr1zbzSB1fv/+KEO711PTsRL5g
	7uOzmy0tPyVttT0uHAnRk7vfMHfTe2nSZLpjkjwHazZMeBlx3+APq1LgD83W//WRHoDRBsC4DQ3
	7RjdSwbS2xI4NvLDMFMQIXt9VAOSXBOZ+hGEyVM/SSHuDLV2163pU++f148k9RpHrWMrRzi+JGx
	9nXN4+fn7z9QpH7PJWJuM/NBzqDwcll4hwPCJy73CaPVFV+61IdvksAf47R66IVifmGz7AusvKF
	gxvt31v2evJBKPCPcmrpYo3MX8VGaxN+2vcruDpwfKTqNbRuJn4W/vWaNBZwx/LA==
X-Received: by 2002:a05:690c:5:b0:873:5ddf:d85c with SMTP id 00721157ae682-8735ddfda02mr35034637b3.39.1788710804269;
        Sun, 06 Sep 2026 09:06:44 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62503dsm57819517b3.38.2026.09.06.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 09:06:43 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 0/2] perf tools: port UI from GTK2 to GTK4
Date: Sun, 06 Sep 2026 12:06:41 -0400
Message-Id: <20260906-perf-gtk2-v3-0-e1f2086214a0@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMwQ6CMBAFf4Xs2ZqypVU8+R/GQylbaBRKWtJoC
 P9u4eRBj/PyZhaIFBxFuBQLBEouOj9mEIcCTK/HjphrMwNyVLzmik0ULOvmBzIppdG8aholEfJ
 /CmTda2/d7pl7F2cf3ns6ldv6q5JKxtlJqqqxZ4lC19du0O55NH6ArZLwr4nZFGSMtVwK05bf5
 rquH94gwZ/cAAAA
X-Change-ID: 20260906-perf-gtk2-555ca04bb652
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3276; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=jnZDT8Sv4Cj1A5f61+G4HgmBdnITr/OETP9KlUhlXV0=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLm9k86sCNzyf/XgRu3LrN2/vbnzGkXdb/Cb1+SfRKXn
 glYYuu4u+MjC4MYF8NMMUWWuPWKLLPadiz1OS39C2YOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIziIXJ6DBqZxcWlqUW6aQVFDnn5JYklmfl5xXr5Bal5BekFemmZaSUZGflFxalAI/TyUkt
 MXR3djAwNTCwdLcycLBxNTZydnQyd3BwdnV2djCzNTQycLR1NXC3NGbg4BWCu6ZvNyLD+Xk04Y9
 j95hfb7mcw/WdtMvnUcjl3ge4Z4buGHjlnRe4yMkwq4OrNlu8+0m62/FJO6cYlvK1rTR5mKaRcY
 NRtWMOsxAcA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

GTK2 is long dead upstream and increasingly hard to keep building on
current distros. This series ports perf's GTK-based report browser to
GTK4 and fixes it up so it's actually loadable at runtime after the
port.

Patch 1 does the mechanical port (build system, widget API changes).
Patch 2 fixes a runtime issue found after the port that prevented the
browser from loading.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v3:
- Fix GMainLoop leak if perf_gtk__error() is called re-entrantly: track
  active loops in a list instead of a single global pointer
- Add explicit <stdarg.h>/<stdio.h> includes instead of relying on
  transitive inclusion, which musl doesn't guarantee
- Drop the gtk4-infobar feature check and HAVE_GTK_INFO_BAR_SUPPORT:
  GtkInfoBar has been unconditionally available since well before GTK 4,
  and the check was failing outright due to its deprecation warning
- Link to v2: https://lore.kernel.org/r/20260906-perf-gtk2-v2-0-3eccff053cd1@gmail.com

Changes in v2:
- Fix error dialog's nested GMainLoop hanging if the parent window
  closes or a signal arrives while the dialog is open (quit from
  "destroy", not just "response")
- Fix build with GTK_INFO_BAR_SUPPORT: gtk_info_bar_get_content_area()
  is gone in GTK 4, use gtk_info_bar_add_child() instead
- Fix use-after-free in the progress dialog on manual close
- Fix reuse of an exhausted va_list in the vasprintf() failure path
- Link to v1: https://lore.kernel.org/r/20260906-perf-gtk2-v1-0-7564bf8523a9@gmail.com

---
Matt Turner (2):
      tools: port perf ui from GTK 2 to GTK 4
      perf tools: make the GTK4 report browser actually loadable at runtime

 tools/build/Makefile.feature                     |  4 +-
 tools/build/feature/Makefile                     | 10 +--
 tools/build/feature/test-gtk2-infobar.c          | 12 ---
 tools/build/feature/{test-gtk2.c => test-gtk4.c} |  4 +-
 tools/perf/Documentation/perf-report.txt         |  2 +-
 tools/perf/Makefile                              |  2 +-
 tools/perf/Makefile.config                       | 27 +++----
 tools/perf/Makefile.perf                         |  6 +-
 tools/perf/builtin-annotate.c                    |  8 +-
 tools/perf/builtin-report.c                      |  8 +-
 tools/perf/scripts/install-build-deps.sh         |  4 +-
 tools/perf/tests/make                            |  4 +-
 tools/perf/ui/gtk/annotate.c                     | 27 +++----
 tools/perf/ui/gtk/browser.c                      | 56 ++++++++++----
 tools/perf/ui/gtk/gtk.h                          | 13 +---
 tools/perf/ui/gtk/hists.c                        | 33 +++-----
 tools/perf/ui/gtk/progress.c                     | 40 +++++++---
 tools/perf/ui/gtk/setup.c                        |  5 +-
 tools/perf/ui/gtk/util.c                         | 95 ++++++++++++++----------
 tools/perf/ui/setup.c                            |  2 +-
 tools/perf/util/annotate.c                       | 11 +++
 tools/perf/util/annotate.h                       | 12 +--
 22 files changed, 208 insertions(+), 177 deletions(-)
---
base-commit: 9f0346dcbea363787186c94ef94dd01aaa215afa
change-id: 20260906-perf-gtk2-555ca04bb652

Best regards,
-- 
Matt Turner <mattst88@gmail.com>


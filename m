Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC0B3C109A
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788719214; cv=none; b=eemuVJvPUCNEoFdkT36xFhFRgvAvqi0IkDhUSqF4MKnQP9NL1tq9rBkHNIpjosa05LkZHezyRBn0ZpyGeUQjadKfDlef0+yMP1RDb+WuraXU0cHS24T7264P5sSe9tcYD9XOk8iW2bg0kBFq0OzNqnWIg7zaMK2mK0W79NDr8O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788719214; c=relaxed/simple;
	bh=SgX1YF5BinqnYgFFhO7dDlEYttQMLZuaOdTahuCoQno=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mcFqKl5LG9HAerV34nhZs0RwXV7MSuZ/OOVreSoHZyQByqHoH5F3NwHAZXaS3NUAJAfiPn8p+oiTEQzYvWFS2IObf7jyD+GNKizXkV9f0WLQc57WS0zlN7kqd34bLcDxiB9/Ynstqxf49psSeJcueL4rVqi+RSZWRVFKLj7dC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anT2eLhr; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anT2eLhr"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66e63c2c9e1so3555859d50.0
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788719212; x=1789324012; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sKM47l7YkmZt/cmjld1HYUn2TA7R7T3CNQOleawZSeQ=;
        b=anT2eLhrEPpY2kPms8u2W2LEcbLVbZx6LRxybgjVugnFqR9EHhDuFzxsf2o+248ziM
         bB4OD0Mhvn3KTg96qj5jSsyw+Dxz0hALK782njJ7c8rHx7qppvKVXY2Uj/MXf8UQhb9s
         CItsKBsI+VrcKDzJ0FxYtRueL1i9a1uKosc8CNyHpIatuNykq0d4DGRfhm1Jt01uO+jp
         hQNwjZr4R9QXVlCIFoumus2rWGNLGt0xdagq+gEMMpQwtpcpJwhpfX7BOqk1qJ2WqJ1J
         KtVvSGYGM8HYY8OksZfr4dvVtlDYPaqzzhIIjXFYe86W1xVrE6i1LkMN8QdRrwkQ2FQy
         iLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788719212; x=1789324012;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sKM47l7YkmZt/cmjld1HYUn2TA7R7T3CNQOleawZSeQ=;
        b=bxOeDlniMu+4Q/aAwtk2o3TdVujbcLLjn3usRxYcWkFHGjm+lr7SEDyV7ycvT5NoAO
         IV4qyUoCaIogj/6i6nhz1YB/36vtYCMraKZyA1Z0/oE29qWR1vdrCG2jctrz/QFq0VJl
         zt90q5BpDRVK1D8KgVP5zw4kLCxBwtAGxgenrbjHmqlXDyZmAcR3lQxXsz0q8xsIFZbY
         EylGZRADVSiQnnYBGZu+OG6Nnn0RsBAoETLVswdkEXo7VT0Z1s9mlUVnPqMX9g8PezdM
         aY0IfbYpSIT8I+aPEaJ/MSbk/V++ADbjy07mHNSzQOTexp3TcqSFgSYUjBl11MVbEv+M
         ZTXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPwZZ7/NIXGiqKS3LEYT4IMDpe3sZERvJVEO8I3q1yG6Y3GB8t776hwguF6BSCVkKFUYM=@vger.kernel.org
X-Gm-Message-State: AFuF++mkIT+tBqHf95UD+N6U1IgOyBnEp+wZp3JdZrrF9BvE+ilxg/3b
	UYjzNGYtzvDPVWU+hQGZcIWXI6CZUy12FpR8tYqgnP4ElIchbp2/R+mZ
X-Gm-Gg: AYBFou39jZgJ4dYn5W3YrUZEa1s4i/lsMcohbaKElN+XLnhkFpzOcY9Hfzc5MShjrEC
	YCtH5p10M2PEcpphX2hbIg0oioyn0XPGBViCV5tYjOc+DSj1kQ7v0vLr1aqzto9f2Q+Offg7l4W
	NbrqPvkSpkrPX6V4hLNhv6Qv+ywLITu4biyRGu/srkZarEwfS6dnx9xXwiyDQYTwaXhB5nIFz9p
	D9p6LiGdSsA1qjODdP3MvcviGAkGSSQnCEbbkYNQZCzTPCwhhYkZZrIunB8ep5fp8H9+sLxy2FC
	2PDgoiqdX4j1cwe0wHMd5oG4p5H4chAT9pW4znVDy5F6MhIAOoo2YWi/SoIRx135duhVkHiUwPF
	VYVF0fuQK8393W54PpFzDd2HcqCeB87+wCyh7R47cyODceNNCCsEhS9FZVoGFFEJq+M8nraypbe
	R16dJYu6pctJUjt003ytAFwfLl0iOh+7Fw/yunXvoRy5T/OmS+nZO1hpRJT5qJjlO7++SYlao=
X-Received: by 2002:a05:690e:1a26:b0:66f:c1bc:404d with SMTP id 956f58d0204a3-66fc1bc448cmr1525418d50.46.1788719211893;
        Sun, 06 Sep 2026 11:26:51 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48f1646sm6778111d50.9.2026.09.06.11.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 11:26:51 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 0/2] perf tools: port UI from GTK2 to GTK4
Date: Sun, 06 Sep 2026 14:26:49 -0400
Message-Id: <20260906-perf-gtk2-v5-0-e8747a65c240@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMTQ6CMBCG4auYrq2ZTn8QV97DuChlCo0KpBCiI
 dzdwsoQWX6Ted6J9RQD9exymFikMfShbdLQxwNztW0q4qFMmyGggRwM7yh6Xg0P5FprZ0EVhdH
 I0n8XyYf32rrd065DP7Txs6ZHsVz/VUbBgWfaqMKfNUqbX6uXDc+Ta19sqYy4KzFJSc55D1q6U
 myl3JUySRIe4WxQKAtbqXalSjLPKEciyJL9lfM8fwGDyn+iUAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4960; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=SgX1YF5BinqnYgFFhO7dDlEYttQMLZuaOdTahuCoQno=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmbsgMTb//Q1PiFcOVVFcF0dcPTn02y3fsmvW7VzTWZ
 /adIwZyHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHPNxB8M/ws1bqnv6z
 pzuefrtN7Nc9nvcCUfCLRYs8zOoPWB18XZv2oZ/qfOvhF/WNJ+9r79hZs2XQl8sFsiW8Nc+dqGo
 28FuNYrm7ABAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

GTK2 is long dead upstream and increasingly hard to keep building on
current distros. This series ports perf's GTK-based report browser to
GTK4 and fixes it up so it's actually loadable at runtime after the
port.

Patch 1 does the mechanical port (build system, widget API changes),
including the leftover-GTK2-call and signal-handling fixes that were a
separate patch 3 in v4. Patch 2 fixes a runtime issue found after the
port that prevented the browser from loading.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v5:
- Fold v4's patch 3 into patch 1, since sigprocmask() only blocks
  delivery to the calling thread: it did nothing to stop the signal
  handler from running concurrently on another thread and doesn't make
  the handler's GSList calls async-signal-safe either
- Defer perf_gtk__exit() on SIGINT/SIGQUIT/SIGTERM to a GLib source via
  g_unix_signal_add() instead of running it straight out of a real
  signal handler, so it always runs on the main-loop thread, serialized
  with perf_gtk__error()'s updates to perf_gtk__error_loops, instead of
  racing them from arbitrary signal-handler context
- Keep a real handler for SIGSEGV/SIGFPE, since those are synchronous
  faults with no "later" to defer to, but pare it down to reporting and
  reraising the default disposition: there's no safe way to run
  GTK/GLib code from the faulting context itself
- Link to v4: https://lore.kernel.org/r/20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com

Changes in v4:
- Fix gtk_widget_show()/gtk_widget_hide() calls left over from the GTK2
  port: both were removed in GTK 4. Replace with gtk_widget_set_visible(),
  adding a small wrapper for the info-bar "response" signal callback
- Block SIGSEGV/SIGFPE/SIGINT/SIGQUIT/SIGTERM around the
  perf_gtk__error_loops list updates in perf_gtk__error(): the signal
  handler (perf_gtk__signal() -> perf_gtk__exit() ->
  perf_gtk__quit_error_dialog()) walks that same list and could fire
  mid-update, corrupting it
- Link to v3: https://lore.kernel.org/r/20260906-perf-gtk2-v3-0-e1f2086214a0@gmail.com

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
 tools/perf/ui/gtk/annotate.c                     | 35 ++++-----
 tools/perf/ui/gtk/browser.c                      | 96 ++++++++++++++++++-----
 tools/perf/ui/gtk/gtk.h                          | 16 ++--
 tools/perf/ui/gtk/hists.c                        | 41 ++++------
 tools/perf/ui/gtk/progress.c                     | 40 +++++++---
 tools/perf/ui/gtk/setup.c                        |  5 +-
 tools/perf/ui/gtk/util.c                         | 97 ++++++++++++++----------
 tools/perf/ui/setup.c                            |  2 +-
 tools/perf/util/annotate.c                       | 11 +++
 tools/perf/util/annotate.h                       | 12 +--
 22 files changed, 254 insertions(+), 192 deletions(-)
---
base-commit: 9f0346dcbea363787186c94ef94dd01aaa215afa
change-id: 20260906-perf-gtk2-555ca04bb652

Best regards,
-- 
Matt Turner <mattst88@gmail.com>


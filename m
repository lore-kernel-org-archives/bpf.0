Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773323BE162
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715096; cv=none; b=Isbet162Yaff5i0tpeDineRn6LV7ikYakbkepCOCYpb6zAqTdoLC3VP8Y/+fooUe9tXTmL8QTOkp4u02wjuNOfEboK7TM1w6WL3xXZLQ5vf6AGkKvyleDU/EmU3LtIF7wdso4wwdm1xiFWT5Hjk1uY4bAvw3oKOIuNcl8+7d9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715096; c=relaxed/simple;
	bh=WYWkloWX0WwYIbfuRU0AbifbyJ2iXxd78Hzjdu5xb60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZ/fqeCEu/753Sg57BQHY4d/KdYuc/83Pgwyeb/2WDgkTdwvH0vlNdcdHMnX7zD+4RThrysmY2yGp977lTThdolmLshM+gJoKz4y2hRgYiNMF4YOq59MfC1DhobNixeMcb3p7Nd+IRiU+VHS1L7ioURvaH8k9dVZmCIPQKCUdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ3RKGop; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ3RKGop"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-867a943b149so42803647b3.1
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788715093; x=1789319893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5Xptp4H+rxzUUCx4qt8Wtg7L4/4Oif3JrXMZT5ooQM=;
        b=KJ3RKGopVD+MUwJKsDfjsTr13qI4M9luSyJs4hA133gHsuBvrnUs0/+hrDcVadH03l
         nuFjLQF257l2gCXDcaeW/1MhQBbYFg+PyyxMmNjGUzf+pEnSMe+aYJVXAFO6d5Wx1kDn
         4129G0IxXCiqeIxTZIi3H6qxYwK3xpt92O64MvOHcrtSEwvanLI1KRyFdbWY11PT6kM/
         k178iCvIKm3Z7KsP399yzw4UXUQmtv3B1S6J5kUrIgYUTlyr0EDbaocABXkp8gzqiyFM
         24bv/Jw0lYGkXWjK1JVl4XdMCNBkrHz4tavFE05/sXTsIQZDjO3ObCWvkNwwqD9Sx7y5
         SLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788715093; x=1789319893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5Xptp4H+rxzUUCx4qt8Wtg7L4/4Oif3JrXMZT5ooQM=;
        b=Y+en9D6dmwSDUjGGYaHzIeG9lmid3UBJJA5ayDQ2Vbu67qMahjI9a5i7ujkYr9Fd2o
         U7H4wkRqJuGu7JitZ7lVez9sHs3ZXkvzjzjEI1KIVuL5LTHuzMsZSr5RXfY09Fw3EVev
         cMHbiYw9MfMF0B+ZqCKd3nhrJImDeIWjB3ZFTH8ltD5zO3r9k/Ws7pAdxa5tMuK161VU
         Wimd55+bBSvOvZGixGouZLTzpEvgFXj5vTZ3NzIuscYp2ZgyxoYIjSZW8QPazOLOJMRX
         FF8id56y5X139AWycb/l4Qqm0IIbpuibSFkyBNYOqSd/0XloVV2ldi34Lin1DFJj1cLX
         9HUg==
X-Forwarded-Encrypted: i=1; AKwUvBwvSS1tsld8Xw+LApSv48ntPTZeyxIwWqoSK4ESumLBYatpKWa2GClbR9rBaUAmM9kXo04=@vger.kernel.org
X-Gm-Message-State: AFuF++mlvs/DkYkGf2MavipdJixsWq6Qg1NDZ6MVh8FnZ11Wy5szsVVN
	ZUZWaLQndXBz0pvkaobnMt/MNkTKMB3umVmo7Oc1wCwYkU9M0ZpYUEW6
X-Gm-Gg: AYBFou0sNE0WhgaZzh1mtLAjUt9TwQjh/415c7MtJFnCQiHhWPq+rRJ2fDUUX3a9odP
	iF95OPSkvwla5LqIUXiPqqHcbVB4mEJk+ItqOwM08Aae0Dk96VO6dOP8mRLODK9trkxXq82Py19
	cZYkjUleIjRhNwf4/gmsjsW6SoGP5DUybZNRPk6on0u7SOkzkRYmCnj3eRU4RZ696tKGnOEgx0Q
	zKtNTxvK+NHd9uMwFLPm7DdwmQtkaQKjjqwQ2EnIHxjwNo6YhNGNoLmjnAAn0JJoDHWuUrug+BB
	TAFJKXa/elVGNPJKwXX2pptMSNqwAyJB8lMuRBHI7WxO8S1PaGhkZiEtfeJ1eVACAYqEyXkudnW
	EztOIp8OJKJAA+FiY6j2iM5j2dDTQVBNL2blvFmqI9RdIkwi5n34aE6UcArVNC2VhJdl8ku/FJ3
	Ei0FOwAldOfyQtZhhzy6QJbSy6wAfMchR31IQKEgIuq4L3yFhB7wbAfG5/9ZRlhw==
X-Received: by 2002:a05:690c:1a:b0:873:5bd1:98b1 with SMTP id 00721157ae682-8735bd19fa2mr41605437b3.35.1788715093078;
        Sun, 06 Sep 2026 10:18:13 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62bc77sm58248267b3.39.2026.09.06.10.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:18:12 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 06 Sep 2026 13:18:06 -0400
Subject: [PATCH v4 3/3] perf tools: fix GTK4 leftover show/hide calls and
 error-loop list race
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-perf-gtk2-v4-3-97e92ee07214@gmail.com>
References: <20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4571; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=WYWkloWX0WwYIbfuRU0AbifbyJ2iXxd78Hzjdu5xb60=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmLvBp23LZQib47aP9Z933OftXl5u5Vk3rqTmRt1s4O
 uXu2vDTHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHNNaQzDT8Yrs272TQ
 nT9+yyKnRWrdvCznxQI/uZlsq9oFKuTxwaLQx/xfYtbLF/eCdudyTzGbb6vdqBhdMSvaRbFe+W/
 97CveAvFwA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Sashiko AI review of the GTK2-to-GTK4 port flagged two real issues:

- gtk_widget_show()/gtk_widget_hide() were removed in GTK4 but three
  call sites were missed during the port. Replace with
  gtk_widget_set_visible(), adding a small wrapper for the
  info-bar "response" signal callback since gtk_widget_hide() no
  longer exists to pass directly.

- perf_gtk__error_loops is updated with g_slist_prepend()/
  g_slist_remove() in perf_gtk__error(), but perf_gtk__quit_error_dialog()
  walks the same list from a signal handler (perf_gtk__signal() ->
  perf_gtk__exit()) that can fire mid-update, corrupting the list.
  Block the relevant signals around the two list updates.
---
 tools/perf/ui/gtk/browser.c | 10 ++++++++--
 tools/perf/ui/gtk/util.c    | 27 ++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
index e1d286945832..40a413787192 100644
--- a/tools/perf/ui/gtk/browser.c
+++ b/tools/perf/ui/gtk/browser.c
@@ -74,6 +74,12 @@ const char *perf_gtk__get_percent_color(double percent)
 	return NULL;
 }
 
+static void perf_gtk__hide_widget(GtkWidget *widget, gint response_id __maybe_unused,
+				   gpointer data __maybe_unused)
+{
+	gtk_widget_set_visible(widget, FALSE);
+}
+
 GtkWidget *perf_gtk__setup_info_bar(void)
 {
 	GtkWidget *info_bar;
@@ -83,14 +89,14 @@ GtkWidget *perf_gtk__setup_info_bar(void)
 	gtk_widget_set_visible(info_bar, FALSE);
 
 	label = gtk_label_new("");
-	gtk_widget_show(label);
+	gtk_widget_set_visible(label, TRUE);
 
 	gtk_info_bar_add_child(GTK_INFO_BAR(info_bar), label);
 
 	gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), "_OK",
 				GTK_RESPONSE_OK);
 	g_signal_connect(info_bar, "response",
-			 G_CALLBACK(gtk_widget_hide), NULL);
+			 G_CALLBACK(perf_gtk__hide_widget), NULL);
 
 	pgctx->info_bar = info_bar;
 	pgctx->message_label = label;
diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
index 8a922851257e..f1dbd96e2370 100644
--- a/tools/perf/ui/gtk/util.c
+++ b/tools/perf/ui/gtk/util.c
@@ -2,6 +2,7 @@
 #include "../util.h"
 #include "gtk.h"
 
+#include <signal.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -48,6 +49,25 @@ void perf_gtk__quit_error_dialog(void)
 	g_slist_foreach(perf_gtk__error_loops, perf_gtk__quit_loop, NULL);
 }
 
+/*
+ * perf_gtk__signal() runs perf_gtk__quit_error_dialog() from a signal
+ * handler, which can preempt perf_gtk__error() while it is updating
+ * perf_gtk__error_loops below. Block those signals around the update so
+ * the list is never traversed half-modified.
+ */
+static void perf_gtk__block_exit_signals(sigset_t *old_set)
+{
+	sigset_t set;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGSEGV);
+	sigaddset(&set, SIGFPE);
+	sigaddset(&set, SIGINT);
+	sigaddset(&set, SIGQUIT);
+	sigaddset(&set, SIGTERM);
+	sigprocmask(SIG_BLOCK, &set, old_set);
+}
+
 static void perf_gtk__dialog_response(GtkDialog *dialog,
 				      gint response_id __maybe_unused,
 				      gpointer data __maybe_unused)
@@ -61,6 +81,7 @@ static int perf_gtk__error(const char *format, va_list args)
 	GtkWidget *dialog;
 	GMainLoop *loop;
 	va_list args_copy;
+	sigset_t old_set;
 
 	va_copy(args_copy, args);
 	if (!perf_gtk__is_active_context(pgctx) ||
@@ -86,7 +107,9 @@ static int perf_gtk__error(const char *format, va_list args)
 	 * outlive the dialog and hang.
 	 */
 	loop = g_main_loop_new(NULL, FALSE);
+	perf_gtk__block_exit_signals(&old_set);
 	perf_gtk__error_loops = g_slist_prepend(perf_gtk__error_loops, loop);
+	sigprocmask(SIG_SETMASK, &old_set, NULL);
 	g_signal_connect(dialog, "response",
 			 G_CALLBACK(perf_gtk__dialog_response), NULL);
 	g_signal_connect_swapped(dialog, "destroy",
@@ -94,7 +117,9 @@ static int perf_gtk__error(const char *format, va_list args)
 
 	gtk_widget_set_visible(dialog, TRUE);
 	g_main_loop_run(loop);
+	perf_gtk__block_exit_signals(&old_set);
 	perf_gtk__error_loops = g_slist_remove(perf_gtk__error_loops, loop);
+	sigprocmask(SIG_SETMASK, &old_set, NULL);
 	g_main_loop_unref(loop);
 
 	free(msg);
@@ -120,7 +145,7 @@ static int perf_gtk__warning_info_bar(const char *format, va_list args)
 	gtk_label_set_text(GTK_LABEL(pgctx->message_label), msg);
 	gtk_info_bar_set_message_type(GTK_INFO_BAR(pgctx->info_bar),
 				      GTK_MESSAGE_WARNING);
-	gtk_widget_show(pgctx->info_bar);
+	gtk_widget_set_visible(pgctx->info_bar, TRUE);
 
 	free(msg);
 	return 0;

-- 
2.54.0


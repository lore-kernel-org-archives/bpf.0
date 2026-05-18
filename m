Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE8E38654F
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 04:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079694; cv=none; b=hE12bGwA66paGvzXWtVJ+WswWiPpLRkdXjpLiGCjVVpTsez8+f3oNDPfMsKG3VMePPe5/GX37MDRkqQ93ShtZc5w3iKxaA7wXFLqNJl8s74r2juSJv56CY77Z+L1m3GY6Xse/khiKsxa+0k2mwKpBV7Qvx7kb5QYjL6pQ+SQtJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079694; c=relaxed/simple;
	bh=lKi589raivhsbwyLaj9XtBtQSUnfs3hz++4WpPhAN6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MD8q1+MdevqRi4KWEYFov5U+z1C+20EbNP5iyzhkCEWMv/SFuFktmXIyrn+svOscZWXZ/M5EZRXZGHxvvJmMH4kWv02XpTMilgUeRWFEOXIjBh9TEJXhl4Un2sdfb61UkJO5ESfgShNAo4EpYyfbv+H/jAtG7/NjC6+3zWC8rms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LN+EkcBz; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LN+EkcBz"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13537722193so3346579c88.0
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 21:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079692; x=1779684492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JU72sTCFhIbrBstza304DuXmMup6ne4nbZZzxxUn+Wk=;
        b=LN+EkcBzC8Y0ZPyxZ1hg2OFugRNrKjn7aYFelAX72YXGEkKwFAfopf9UDNkinTYiHH
         6JFsN9FUCnuhwZIhNUct0/5UXjiAjTn1C2CiMaN4v9lq4Qu0JVEaHwErXN2BRDwZSWOL
         wl1dVUrl23e4c8mOYUJLCaSEr74zf9HOr+Q26qTtvi2sTelGeMTInFyi3bfoWfbM8snh
         82MUk5EQiR0cWgsX2Fz47CB3K6THgJwbqHuCjZgkfoFv1h0Jhn+JaDf71StH/PqK+6lY
         odW7dyaevPHhldklvQriMJyrhHabp6Dp2x5UIkMnmogl67cn/sckfKS6G7kQTlz5dx/i
         3zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079692; x=1779684492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JU72sTCFhIbrBstza304DuXmMup6ne4nbZZzxxUn+Wk=;
        b=iJt6/VNi94yMv52y9HX1L6El4JZHoU6zl3GTxTpmGn3qTvD9NpkkxbL550sa2s04CZ
         Ehy8LPf2rW8FhCxZ+lk6RB2b3U2+ACvjwuRHs5Rd6PZcaSASGjBAieTvAvwZ0x4gAsV7
         z29mQapu9Muj3BXmSx+AXgHEJwEO43HXWj14lrPcY+rbYlawycYPrVVV7aDdEhJflPl5
         7BnQIph+CKGyyW3WwYHyzH6AugWS5YboaHdPvswuyYtNWtISCUZEzp799YUhw32IAQPK
         czyTCI7dhuycOuvzO1t5cu0u5OmVjJstBJQrYVt5dKje8fxFqDyWTqD7SuiHaGQE1g7z
         mrcg==
X-Forwarded-Encrypted: i=1; AFNElJ/+oWuPm8wmC2vSxGLQnfhpIyr005dpi1da30W5TlGYpKFv8bXeow1IJbcAr905HPji2V8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgi3O3mcEGNSa/xCtcPom/+pVCnSKDc3xMbTm6Z9MpnS7IDCZu
	BdzNPlcPB3ZVW/azVjdA0cypCQv815rWo9pN6qUrBEjv8J7OFJSvIp6d52ys4rpsjxVznV3LYQf
	cCoXk73Cb5A==
X-Received: from dlbqd21.prod.google.com ([2002:a05:7023:b15:b0:135:b432:37dc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:250e:b0:130:9f2d:ff99
 with SMTP id a92af1059eb24-1350473a5afmr5992444c88.20.1779079691614; Sun, 17
 May 2026 21:48:11 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:35 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com> <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-10-irogers@google.com>
Subject: [PATCH v6 09/14] perf build: Remove redundant libbpf feature check
 for static builds
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

By default, the perf tool compiles and statically links against its own
internal copy of libbpf (tools/lib/bpf/libbpf.a), setting LIBBPF_STATIC=1.

Despite this static linkage, Makefile.config unconditionally executed
$(call feature_check,libbpf), which forced a synchronous sub-make fork
during AST parsing to detect dynamic system libbpf libraries.

As noted in the internal Makefile comments, this check was executed purely
so that running `make VF=1` would display the detection status of system
libbpf. During standard builds without LIBBPF_DYNAMIC=1, the detection
result was entirely ignored.

Wrap the libbpf feature check inside LIBBPF_DYNAMIC=1 so Make avoids the
redundant sub-make fork overhead during standard static builds.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 8437c3f72125..26de7528d6ce 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -575,10 +575,8 @@ ifndef NO_LIBELF
 
   ifndef NO_LIBBPF
     ifeq ($(feature-bpf), 1)
-      # detecting libbpf without LIBBPF_DYNAMIC, so make VF=1 shows libbpf detection status
-      $(call feature_check,libbpf)
-
       ifdef LIBBPF_DYNAMIC
+        $(call feature_check,libbpf)
         ifeq ($(feature-libbpf), 1)
           EXTLIBS += -lbpf
           CFLAGS += -DHAVE_LIBBPF_SUPPORT
-- 
2.54.0.563.g4f69b47b94-goog


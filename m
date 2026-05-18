Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2F37BE70
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119239; cv=none; b=a7SwYAw/t79LTAo/l+bGs7nh6KGfL+zF+2OxAR6zPTdYJX+4vpV5JeZMNEX4w+OOkxYMNGK//uuxClRA5b9cDBKafVXRENpKzT5WlG8nbtcPv05Wxcq2DrcCcpasHAXSneTw7WiJ/3d3c3qQqOXflJeGveWHOftIMUmyJIA8y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119239; c=relaxed/simple;
	bh=UO8COcfsaqz02sjdD6/7eGxdxivUik5cN2WpzQTquMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XEvWj4FT/Oc5HtgnQZxRMYjsAHKZGSu+YjYvjKXjJQxPVnUUlSo1AC878kTbmAFqleB0O9bvFB/zapTK5DvyIbV3sGDq0x4PY7mcREmBSLU3Tjl8ipsMnr6zoMBxF/mjN8M6d+2Nl052g9nOqBca9KbW7bvSJ95x3FfJn9VoVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQinennJ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQinennJ"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30230e64087so2931028eec.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119230; x=1779724030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=elI3dCv9to9+reTrmH7gWaOOH/Cw1KfhvnnriZ/0VzQ=;
        b=YQinennJ2/LJQgmXBz3gMZ7CyttkpVcwJXMrMeHx2mQLenLMTeUngykZbXIHlXouNR
         G4PZjzpyffIvlUrc/h4Lenazi+T3qQhEpRhkHa2GDZ9CVYBowDTJxboi01Lfov39OwTB
         7ejTx/4uXOb//9n166LoA/O47fz52ijYatpFBySJTp2KH/lQLG7s7hVRRWnPg1WeZ/V0
         p2j+QAJP/ZbafhDW8APl0/DJNz8p7CM0s1TWnzTk6fdzhaSXg36YjSNJTRdSwr3PFRUn
         WlSgtfS/ED59N4tfqxI301J5ET19GsprrzV1Zjh0pFyIhoIglZ7s6s5RbWap0SXdEa8Q
         ROPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119230; x=1779724030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elI3dCv9to9+reTrmH7gWaOOH/Cw1KfhvnnriZ/0VzQ=;
        b=DBJAyFarfCCcaMA6paomhsPK22LkIv6x1VgXIdJICd0oa3g3m3/FW6k1bAR3hTuuUP
         ufEKDYpbja6dhTe2metKG/nEnEEwNOmTbjRXJwrP0h1opsHwseZ1sEPn38UXK0M4GUOX
         SwLLR0tdT8sgsW43sgZiznx2mkZ5pt/ngf7D1Bf1GAtFXGNW8pZjJwuF0NIIyBRrux0q
         Qsx7zYlyAqpR6VD2zRaLi0z9VJ3EGLue3m4ikGBMdwkbNW+kPzW8v0gloamp5PHeyDzu
         bLlQO9hULmQOR2ft23w6jnXmHi1dZhnf2Cxf7Yvs1sn4a+A3Nk4SCSqs2FIQ8RaPysEF
         RiXA==
X-Forwarded-Encrypted: i=1; AFNElJ9Du8kfCwfXCBl5/mKnh4th+IQ8usWwiQrE0nucnFMma0KHIix+CmDh9asN33zEeLDk83Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmfHibc5Nzf/vjpuZwsA/PDvFUQCnGcvctrNUGFiAWwJ61sGR
	gaaxsv8GU6Gh5LtAiEgSrlICMJT3vY0vsGZnGbTkpAD2j0l1vm0RSB/vcLhM1CkScK0TRW/tK2f
	YH20w4kKhSw==
X-Received: from dycmx4.prod.google.com ([2002:a05:693c:2884:b0:2ee:de47:cde3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d706:b0:2d9:f0b3:1d98
 with SMTP id 5a478bee46e88-303982860f0mr6417996eec.7.1779119229503; Mon, 18
 May 2026 08:47:09 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:36 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-13-irogers@google.com>
Subject: [PATCH v7 12/14] perf build: Prefix SCRIPTS with output directory to
 fix continuous rebuilds
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

In Makefile.perf, ALL_PROGRAMS includes SCRIPTS (perf-archive,
perf-iostat). However, unlike PROGRAMS and DLFILTERS, SCRIPTS was not
prefixed with $(OUTPUT).

During out-of-tree builds (or when O= is specified), Make checked for the
unprefixed target 'tools/perf/perf-archive'. Since the actual script was
installed into $(OUTPUT)perf-archive, Make concluded the target was
missing and continuously re-executed the script installation rule on every
single incremental build.

Prefix SCRIPTS with $(OUTPUT) and update the static pattern rule to ensure
Kbuild correctly tracks generated script prerequisites during incremental
builds.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b8a81c9749a8..fc92d6ceac5b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -405,7 +405,7 @@ python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT
 # Use the detected configuration
 -include $(OUTPUT).config-detected
 
-SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
+SCRIPTS = $(addprefix $(OUTPUT),$(patsubst %.sh,%,$(SCRIPT_SH)))
 
 PROGRAMS += $(OUTPUT)perf
 
@@ -592,8 +592,8 @@ $(GTK_IN): FORCE prepare
 $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
 	$(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_LIBS)
 
-$(SCRIPTS) : % : %.sh
-	$(QUIET_GEN)$(INSTALL) '$@.sh' '$(OUTPUT)$@'
+$(SCRIPTS) : $(OUTPUT)% : %.sh
+	$(QUIET_GEN)$(INSTALL) '$<' '$@'
 
 $(OUTPUT)PERF-VERSION-FILE: .FORCE-PERF-VERSION-FILE
 	$(Q)$(SHELL_PATH) util/PERF-VERSION-GEN $(OUTPUT)
-- 
2.54.0.563.g4f69b47b94-goog


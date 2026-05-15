Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351343F8ECB
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866768; cv=none; b=WLCyu12KmakNQST5bLjG7JczlG5vn+5KvezGjLBTXReYN7dWojd6vgrTNUPNIjKVZBwTr2BKcMr+4hlvlf/Uh9qVKjx+pTHRCjs3JJ4IJ7T5k12ifyNGS7uoUfH59Bx7hzWaiwLn+StmH3s9P3bkF2yghG3Tl8oC2/pMqzHT64g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866768; c=relaxed/simple;
	bh=UO8COcfsaqz02sjdD6/7eGxdxivUik5cN2WpzQTquMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UxMZn8d+hFia+5Hdr7BfjZ+2uDRNd3uYcReHsA654bRnJQ5UHnHwgQBDMXuQ6mepdfFckzqrJsx6AW2gJDRzBeMghI1nVG0p/qV/6VFsi63bPJCxGv9rUY6QjhSgo8Ym89jHkch22bitUlGPFyOInECGBRrQu/0YvAWI1fkBUN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iz3DoYic; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iz3DoYic"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13312be8a31so5299c88.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 10:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866765; x=1779471565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=elI3dCv9to9+reTrmH7gWaOOH/Cw1KfhvnnriZ/0VzQ=;
        b=iz3DoYicMd8gb4mTbQZ6CpfKw02+ghudu9zxGsjY4Wh7S3N5oCAce0fu+bwR2dpBUd
         yhD/tq+J3BlKtYIas9RR4raE4lkIG1vQH5ZGixAULLNiwNjlia4Y6cB6DMhazYeHCJtn
         mVEc0uv31H1eycoidZb18IWOpX9gEdn/rAzKMTT33V11ixLqa4PpkwE+zmkZ1d+YSp5q
         7dVR8Kb16bl9ezvtlhtWg1OyQLyD2U4597nDhpU3fQqK8CnW+bnhg/NWTBHhGuLBhPMI
         drwswap8C+6N6+9wbYvXWFBMb813PXgeLDOyqZ64nWqbtZMqOOvD1kHCtnVtnU5VPGZ1
         tr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866765; x=1779471565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elI3dCv9to9+reTrmH7gWaOOH/Cw1KfhvnnriZ/0VzQ=;
        b=j62yu/cOdCH9duHO4IzSLyI24SYPzuwrL3oTJe+Jdf3NHMllgo1dMXLL/AD+cynR7U
         WY2WxZSAbep+e+XRMskOestwrNsbZQ3tFU5KBM3/8vO1L25Y4ddA1hlQPQFWwuhI4NCI
         FsUVj86RH5EjBpMT6gUCj9wyufU8Hn5ntTizGGv19gnlKK5nrTwnlL0e7wnpcJEMM5fR
         MBixVJv+g8tF6eSaX4/VV6PmoFFvgbTaOwf9DSUG33f/htguRtVNULujqXP0iGs0ObZh
         DS2KOwo0ufFRdxvVn4zaXvE+8KbIjc9FiopTu8RG2pX2k1F0ghqSHmwIqrrzGlGaOgJF
         E6Tw==
X-Forwarded-Encrypted: i=1; AFNElJ+ClOWjhn629di/SII5OpT3sythDOfGido151g05NfO10z/CqsHegPDLECTQJx9usQ8RQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDqiQdqF9DDUdS854aXVQh46hQ7rHQtfCyZa3sMizIHQ/z+Zq/
	G/8PnUT1+5lTyWRPG0jnk2PLIB5h1bTkDaEIlayB2mnLHhh6scPiFpQ37VmINg4iZKRKEcNKPHO
	ntfwZ/+kYtQ==
X-Received: from dlbvg5.prod.google.com ([2002:a05:7022:7f05:b0:134:74a7:dae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6992:b0:132:83e6:41
 with SMTP id a92af1059eb24-13504c5dbb8mr2157263c88.13.1778866764333; Fri, 15
 May 2026 10:39:24 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:49 -0700
In-Reply-To: <20260515173852.1378571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515173852.1378571-13-irogers@google.com>
Subject: [PATCH v4 12/14] perf build: Prefix SCRIPTS with output directory to
 fix continuous rebuilds
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965314;
	b=3b2vyXPpvdmYtSL+5kYosTFxVFEwTbQ70Jsn0hL5UrUsMtutWGQSM8hA/oIOajxgnL58
	 P6bibo04UhaqulJ+lQ/H1eZAxot14Uphw0BAV5fYw1fl5hRiPGYCCUNTH+9kslTDhaDfX
	 wfAfUCd3UbJXA15SFUyWDKaVROs7vw/8qd+O9slGO6dO/1jfeSw2NkZMHy6gwrXkJx7fG
	 7J6g8OlkDeEls2FA3ZewUL7AmvHoifPSkyO2LjEpIhgZOHMETr6H7BRAmfX1A+HWUcLPZ
	 Hz+XBoqGu7O4jE5DP873fi+iBRyA2kjNLC/RntEZ4TnPMTaJQbevRszGAMMcGX4jekg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Content-Type;
	bh=Zt7QpncNg8RgMDpa8gtNEv/aMDccF33cLy1R11uT760=;
	b=vULJvvBuSjQcgxhgomKMfswt4NwRAThvJ4kt1RuvRLcsB16aNO3ee6rZLfbgNnJ3mcew
	 sWc4KJSJVCBpOKu6OmAN4kPATAvsdXwe+92sCXs7BPTnrKLiVSHQAzwQtOQMFB9J0vnoH
	 LlC7W4vuQC6kp5V1HaYp+L88y6W5wlsPdjjQr9Dg0sznu1+IN91z83lmZkOvGOU0jaJNo
	 N0c7jMtGj4iGwlD+mwiuU1aRpdEFZdsB7btYCPmdgV+xJqYmEW1iWOLiCbjpgaGcrdNEe
	 wvBNrzhiTtNkGa3XnIydO/Py8O0ay4okDIKNDvuiyWfVspGe99r8LBzx9FPFaBIXifg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QK9pL7Po;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF5F606A31D
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 21:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EF5F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QK9pL7Po
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35cbea41088so3826437eec.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 14:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792965313; x=1793570113; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Zt7QpncNg8RgMDpa8gtNEv/aMDccF33cLy1R11uT760=;
        b=QK9pL7Pokm+Dr16jmVw+fckfMh7IrOQTGJYQHgRFKgn+qoPBYNzIV1kr7LgemD5w2G
         oQCEE/eENURG4JP0BAe/uGqnpu9sDhyqsWA2d8YzLCjvdaJDgVWP2ivwNZ5fss48HWpz
         b6xiCrqONmQzzUqhwkHr0/fb8gZDPuzkvNwIE0y0b0f1VH5OQCfIeIW5Y0SYjqq+BIqN
         rGVET2A3C8DiB40mw6ay+S8gISusBgr7odUZC57LZgK/4bHqsE23i4znfCUODXZcXrqM
         Q3QEz4zzcs5U34P14xyRVUYdKayMguiY3IyYJ5TvUtsFfVXixv3ch7fDg97Wu73tHpmu
         5+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792965313; x=1793570113;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zt7QpncNg8RgMDpa8gtNEv/aMDccF33cLy1R11uT760=;
        b=0rpzs5KdrWY0LqPbgUWt5KsrQbd3GWdtbg0MxEciHKgJycKYCtPU8WiKpSGKAgtjOl
         eb8nY4mjChMsVeZCd9wXlrGsJjv+Pw0jp732iT2bw0gC6FiKNWkhsq+bGMGFhPMdQKUB
         PkHy9v0Ab7A/OiFE955KGWtKLF7AF0Moe6nAgDnbjSYUobS6WdvvN4We5HgkyaWSTzaY
         NvgnKwBSPvKl5hyRF1p2ZcTckE52FcgBbNeRiiVVNYyL8hsw5rIh4QZzys9BwGkvR8qi
         1jwjzM79InWffSub16AcLAUTeTzoTVvwGh0oomqfxaJxFMhTmepVnzr1sm7XxoQUbsMQ
         fpVg==
X-Forwarded-Encrypted: i=1; AKwUvBwn/XipIj34SRAVRtg3NeXoKzUJT+R+Kdj5pu7dNja2bbQPS/R9SNwNiBLS/D2vY21xqKM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyZgC5TetK4w+6PeIn1fbLa/cH6Try6gK2e96zmP6RemYbg4ix
	msn0VNJ7Uv7GWFKALYklppu5KUAf555rgXroWGqLxeHf26VTN3fKna9pG/3Oq0dQSvMgdJVs2+V
	1gq23Ugl7wg==
X-Received: from dlbou3.prod.google.com ([2002:a05:7022:1103:b0:19b:4a9b:8cc1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e803:b0:16e:4723:5f86
 with SMTP id a92af1059eb24-19936a60764mr8643547c88.29.1792965312166; Sun, 25
 Oct 2026 14:55:12 -0700 (PDT)
Date: Sun, 25 Oct 2026 14:55:07 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025215508.1237480-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf/core: Include attr.defer_output in is_sb_event()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Events configured with attr.defer_output = 1 receive deferred callchain
sideband records (PERF_RECORD_CALLCHAIN_DEFERRED) via perf_iterate_sb().
Include attr->defer_output in is_sb_event() so that such events are
attached to the sideband event list even when no other sideband flags
(such as mmap or comm) are enabled on the event.

Fixes: c69993ecdd4d ("perf: Support deferred user unwind")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c4217c996f5a..b43883a42566 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5347,7 +5347,7 @@ static bool is_sb_event(struct perf_event *event)
 	    attr->comm || attr->comm_exec ||
 	    attr->task || attr->ksymbol ||
 	    attr->context_switch || attr->text_poke ||
-	    attr->bpf_event)
+	    attr->bpf_event || attr->defer_output)
 		return true;
 
 	return false;
-- 
2.56.0.307.g5fe7bd680c-goog


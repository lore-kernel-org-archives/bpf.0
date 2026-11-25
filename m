Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567886;
	b=3aHfx0dlAPUedRxwIjz/ylsMCarTiVTqmb7+Be9fUCtQj6vIMjUu3WgRVczLxgOiaG0d
	 fVtZ3b89XbeMYTcRKHdF7RaXtk7hdiqNZgbSUBqQ4TuBw1h2JY+aFmuDEFRh0e1g6B29R
	 QtTs80bS4XWdV7JXLv334fqxY/WYqNRuhS4MGVvDw+JUZsTKRoGUuvkT6T4rEcEVfw2F1
	 w39a/TVOP0ULNwI0PgfTFVdBu7kCTjp/IVaTuWahG3vUgsO7vAs90O0kgrIgAvJ8WTHqe
	 K2Zey63a+C4QXCoU+YaeIhqArBA8PkzdLoQlEDLWMez+D26YSnSLFR9PfmiPu0rm69Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0Bm9NXQn0v9M2tyfxAozRt5jQau1vpJZk8wO8ZZv9cE=;
	b=ie2f4NVsprJqtj2TIOzHpdzWSSTUdY+AzZKqBjc6s4ie9zVo+YcZjkknFO106hJtArKI
	 vpPmoxCs2YvMbGVpkyNeC4aylC5t1nyiFNO/3sRloFYHwjJgANFL/BLTebCcyrFLBxl32
	 CKfS0szNskKYkvjaOffQ4Se4OOmsGr3inCj+BIPpqMv3TXsXW2cpF996ELUuG3ydRgBOB
	 CCMDYIG96SWMYZSWp8qWMB+moMm6vuxd3ArntKz5OnSFldi9Hwn21ygl/enaSDOLncp36
	 uqhYYYYXiyFUOR7mhvmDquF12bEq8/BdWpdWgERRP1sLb/1huP7SPVwoHns7GV3iTlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hGl4ayoc;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E8606A692
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 00:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B61E8606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hGl4ayoc
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso5670689eec.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 16:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567885; x=1796172685; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Bm9NXQn0v9M2tyfxAozRt5jQau1vpJZk8wO8ZZv9cE=;
        b=hGl4ayocEX9r6evkVwQoj0cjaNV1eTxHvPVmiy3qklo0GBOKY/Vqu0SaA1NrQNhTxZ
         Pcga+1U3bUy0cKt9PVlVBowS2x1IoS2tfeQZis3i49cFBo4hwVYrfUKmgRunhFXL/S5F
         JWBrW6/gw3Hb+COVmRqu1cr00rB7eVWQlo/Y5LdRMO6rpc2BA2Y9hrzwaPxC9Lw7TEEe
         kPjVRiIAe9+FU77VM4mimnAEHljfrCr+Hj7l+VGYSSDKPHremnSHuxkk7TRjlvc/I0KV
         u0jBx/XaISOEpsd5A1xvrXpIkvYH7WYDMrEmajE7R70+L+rXLO62WfculirBEGeBn03c
         rH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567885; x=1796172685;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Bm9NXQn0v9M2tyfxAozRt5jQau1vpJZk8wO8ZZv9cE=;
        b=tFBAsCEVtrQx5LlE+rhW5BxJhhUcc3EGwLbkMsrNosAErQPEwwT/ESJe1cLTlwvbo7
         o5Mqepqf5TA2wt8+WX3WCM0oM51tohg+8Q+1Q/DEE559KvX9oPRN7Ntc3lxBV3D5WaYQ
         mQOqu/lfp3jP9s8XY1yHO3vJCKpifjSfSIDic6+zziG4DYQDELgZ3wVRmpUbV6LC2HoS
         LXKWBBdmZtx77b69y1gKfg5RqCukm0UObVgUDaMuCq3odKtw14uU0IoWiu9MZTs3L1SQ
         P4c9fH+J9eIlrjgQYK8VM6s7xviEWj0XW9sWgNEJG80WR0qeoQWzxze2mKsp9dBshhIL
         QoBw==
X-Forwarded-Encrypted: i=1; AL+hErFq9tSwHOAuHiIB5THq0DulabF+bvi5Pc9othOLKCVi6DAei6XzNqB273jLwqJPz43M7Mo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+g/fZmBgRRq0mVGiFde+Yag4DMhx1O+mKe4tU2H92PktHgnDJx
	X0/89dDw8+uFTwpnsLJKvWh3oMmi2s5cCGeKI2xnRDrR7oX1Mf1Unoot5zQQM7m+L/5O21ARFD+
	LF1cAgO0K3A==
X-Received: from dybcn8.prod.google.com ([2002:a05:7300:a908:b0:36f:5688:8a11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:182:b0:386:b4db:74d3
 with SMTP id 5a478bee46e88-386b4db7924mr6776155eec.21.1795567884395; Tue, 24
 Nov 2026 16:51:24 -0800 (PST)
Date: Tue, 24 Nov 2026 16:50:51 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-3-irogers@google.com>
Subject: [PATCH v4 02/19] perf/uapi: Factor perf_build_id out into its own
 top-level struct
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Document struct perf_build_id as a top-level structure in the perf_event
UAPI comment and add it to the PERF_RECORD_MMAP2 union comment so future
sample types can reference struct perf_build_id directly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/uapi/linux/perf_event.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index c49fc76292f7..deb7c42d109b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1099,6 +1099,18 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_SAMPLE			= 9,
 
+	/*
+	 * Build IDs may be present in a number of events. They have a
+	 * consistent encoding of:
+	 *
+	 * struct perf_build_id {
+	 *	u8		size;
+	 *	u8		__reserved_1;
+	 *	u16		__reserved_2;
+	 *	u8		data[20];
+	 * };
+	 */
+
 	/*
 	 * The MMAP2 records are an augmented version of MMAP, they add
 	 * maj, min, ino numbers to be used to uniquely identify each mapping
@@ -1123,6 +1135,7 @@ enum perf_event_type {
 	 *			u16		__reserved_2;
 	 *			u8		build_id[20];
 	 *		};
+	 *		struct perf_build_id	bid;
 	 *	};
 	 *	u32				prot, flags;
 	 *	char				filename[];
-- 
2.56.1.831.g720f3f5937-goog


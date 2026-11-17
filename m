Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941382;
	b=Ra2aDZq9WheNJL3L4jDZjYl7yTmqA305wrsc6jLp3PhveBy6FdB3RBpyY3Qn+oHRxbL0
	 MrnNWNqqWK51DmYMSbQKdUY/sci3Yc+jOLgtdhZcvbMOGISQpJ5YaeEj+s8wirniR39Be
	 jtvcvQqOj8xlgQKPO2feSMZnU4oH5p/v0HYsdrI6E8eMC8afrNDyi4YQ4Y9XBmCqW1DEV
	 PhhemkyYIAxydofRbBmC9tL4nDoX+cvs7X1cdvHg/AZCajpgZGDhBB66JaiGZ6+ffEIwT
	 o4420B+UtHn7HIKyZB0sJeU+5aK5mjIHxtXfq2NrsPE+xFVv8UBK+xTrPcfsYOSiwnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=cIns1XYte8UDzFFuNR3YrTGqD06ckSGcPH9S6KlBvtI=;
	b=4CWiOE+EZ854YPOrmmsEp/iKVq+lw7iXKIqh1BGt+MzcZn+eTgkN1Y1sTEhuA6Of8oLE
	 yYIeuLi+xNpLjsxMAjdg2EUP9BIz9R6poyD+0d37L0cUSH/wsZlsRUXf6XESIgwYqJ8bL
	 TIpg0FwEg3xHVIDaXT6TX5ykTAdQjyzWd52aUObkNuFTvUV/dW23Aw3fp0hFHoZHQ+SoS
	 tZ4CqZtRyCG07gutl6MAtDH6Nr/K47ifzMatS1EI2dIFHFBOiom9x6nc9aQMCOiBgMqqM
	 hHZyPDL+KffeloWZpKy2ClIH8aieiD//L1n1VT8HxR9o+jkrZLvy0qqXhAoNfdetllA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KcbUTXKi;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2B60A2601
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 18:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E2B60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KcbUTXKi
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b3ae17c536so127267c88.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 10:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941382; x=1795546182; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIns1XYte8UDzFFuNR3YrTGqD06ckSGcPH9S6KlBvtI=;
        b=KcbUTXKiIISiQrhN+tqjfw1wJazs8I7PQbXSul5QQlF1kzy4m0NuqCWIgN1i564ung
         4l7FlyypuqV0Y+yN94ccN6uOl2l5ib1xGYkH0+uXjYXDv7+B3QntNL5SC2iaVh30sHpC
         uE8EOmNHaRR18FRUIe7qiaYxhOBryuRk3FnYoyvHFs05VoDtX7X8BgG2l7Y7sJLCDwkL
         xHekpRuYhrX/WcpIF5MImCHO+A3SGVoLCLpvopBKLy+49qNGU89tkryY+5Cs9F4ELbvA
         Pon2OPPGZsGq3f4a1idekt5CO8ApS2jHd4CkGLuVy16K8ElFIkvjghefzx7/vRtobkNQ
         uSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941382; x=1795546182;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cIns1XYte8UDzFFuNR3YrTGqD06ckSGcPH9S6KlBvtI=;
        b=W6O6Y7iJhf2XAZyUgtXSmx67ES8zzrKUfb5QFxsFnCIeGAw7E/HGqC1r+UY8q4GOM8
         cZZA5hSlMueug5xmfTE+F/2sRmI32Mt7PuNY0+YoAp9Umtxb2eNpasTIVZU+zWvbigyW
         EVUljrGFxDkEXrITdz7MSVQmK0q25bad6+kqI9iRzWBc2EG07DGe3Cv7EuDILuF/7eBA
         RLtBJV2tOZBTVZu0E3+FGCCtxWD9O7FC+htn8UBavklR4Eyf4nl2o49PuR/F99FdxC7+
         /ULGfx14Er+Qb3P4NO0d6B+XIpfT8QOIulKPsdWtte4H6g9QEHOW9WKf7bvbwGJddHPT
         5tYA==
X-Forwarded-Encrypted: i=1; AL+hErHCkExW9IRCvPK/T/BpMfpGKzMiOh0U7mvFflcgIeOLh/vSZ/jOgK1rTNke220MEQlnz/8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9I0TLQ3YoykiQdjQBgb3eXkYmimg2bjyq/MoopWQo1O7wsiA0u
	ztYFh/SxfLrAjvZGBw4CZWoBGSCANil5uRabeOBh0Fl9aEpqrm1xXv4f1zUnHYJknjt4tz7jxAA
	35vcgmtouPw==
X-Received: from dleh20.prod.google.com ([2002:a05:701b:4354:b0:1b3:befc:72bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:20ce:20b0:1b3:af3a:e78f
 with SMTP id a92af1059eb24-1b543be37damr377223c88.27.1794941381255; Tue, 17
 Nov 2026 10:49:41 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:40 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-20-irogers@google.com>
Subject: [PATCH v14 19/23] perf maps: Fix lock inversion in maps__load_first()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In maps__load_first(), take a reference to the first map and drop
maps__lock(maps) before calling map__load() to avoid a read-to-write
self-deadlock when loading kernel maps inserts extra trampoline maps.

Fixes: e77b0236cd0c ("perf maps: Add maps__load_first()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 675fe0223faa..7e863f0f4a4f 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1460,10 +1460,15 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 
 void maps__load_first(struct maps *maps)
 {
-	down_read(maps__lock(maps));
+	struct map *first = NULL;
 
+	down_read(maps__lock(maps));
 	if (maps__nr_maps(maps) > 0)
-		map__load(maps__maps_by_address(maps)[0]);
-
+		first = map__get(maps__maps_by_address(maps)[0]);
 	up_read(maps__lock(maps));
+
+	if (first) {
+		map__load(first);
+		map__put(first);
+	}
 }
-- 
2.56.1.703.gf848ed807c-goog


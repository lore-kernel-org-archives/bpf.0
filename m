Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8912D1E6
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037010; cv=none; b=c79JTv4HifUY6i6DRwOz9xERXNByftFyaQMY5a5ntm7MEjJzZ36JNzp/xSmPYDOk6u7WGB0NSqeu3AlGMVLnvt6tMQFtNndAkGHSrx8BgHd/kkGJYoeVJHGfCj0Jo6lUvRcJ1LlAqNGjVRfoOXHnFOkWIafWL7IUmAsVI82XqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037010; c=relaxed/simple;
	bh=9dGUST8fNArFOG69zr0ELlXx+wbNrZRxfaYe9UCGBtM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QLqv21bj5Dv27YgrV/PCzWDKOmJJE353j1lPVqU+0n0oxMT/lI4kyxpHUCH0KoVZVitErfsnP/2CI+5iQBdpJ8CFw+Bko7L7BoHXIamRQzFbjcL+5Lr8MRiuej9s27SjrdgAHiCxExzvE/l+bGTb0xJq63VWji5lyVQOQRF0lrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=37KVxsTy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="37KVxsTy"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61100c749afso19944137b3.2
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711037008; x=1711641808; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vEQ5BBsljQyJP/Rmf1XGwbxQw69MXA9Ie8L3tI9K1qI=;
        b=37KVxsTyeUADNFUJc/sDeUnAdhtdG3vJ7XadfPwphfMCGwwzkBqjfXmdZ9fGFAvypT
         UzEejvbTZRgMncyzEFGze3mJLEfluNABvvJjZzmas1EntJrY/eixgixf1H97qvRU4BzY
         2FTRjYB+dvns4/nVmnQzcStngFyKh8EaRRvI+T0MNbj5tbuDAPIM5C7pRcRsJWxYtEIv
         hvpAhoxB5VJucOHf/9P+gwk6QgQf+IXDOtE772edQlSPYken9PFrrZoDh2BwUL+Zg1NS
         ytTM5H3Iqt0qUXmKMbXmtXmcRebBNlJDU6bqyfsYmSSudQEt4cI0bp0gHSUUEx2/24sp
         iabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711037008; x=1711641808;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEQ5BBsljQyJP/Rmf1XGwbxQw69MXA9Ie8L3tI9K1qI=;
        b=c/RS/vqzA1iON+f31+coPdKyipj+yM+ZOfvooUOKGNv4muJ1PuncyV3BHbSiky9A/D
         tKhNqpzu181sUEghHvaefD1FuPEpbrcuprYxK14fccYlpxbGxvMboT9juotTxQMdDgKU
         VmyHX7GD2A/rnpFdrSpwBl410015fvesH554iloZZRCrN88Omx6tsmQkj9OOJlRmaI8j
         Mc4EfUdF5rTpwHOD9MLcA1LfMY8LnxGZjLBAUrzwbXjlokSp4OT5QfRgHHVnBRkFHl/C
         3oHOy9XnCiPf69wmI5BiDKf3LU39v3hGD/NMVcAlwfYLCLoovCwF7bwdkh/HBuP4UhLD
         xMYA==
X-Forwarded-Encrypted: i=1; AJvYcCUpXqt6UIo0tUIvC+oX0u8eAECy48YOHcZtW39cR0YPcIzCVdvC0TNgt1cc0ExeERLn0ORuJI1dZQ8Av5iGk/unhNiQ
X-Gm-Message-State: AOJu0YwaBy8W1AQouWN3Tu0FIVSRK/ON5T+Cmr3cVigiBdNzjj8CZ4bd
	ieQrKp41umH/hk+BRDwkxroGrnxlTsPjijA36MfCt5a4lqVn9tZDg34D2gFQdgKZ69Qzfc7t112
	9sIBQog==
X-Google-Smtp-Source: AGHT+IHHuNe2YarMJ2QH01M6jUApwN+PIyvS2BuY1tpPY0Gq4YDWkdVdOSojL0Cyst7T6UGGvz2eBpWLHrfP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a05:6902:100e:b0:dc9:5ef8:2b2d with SMTP
 id w14-20020a056902100e00b00dc95ef82b2dmr5505080ybt.4.1711037007909; Thu, 21
 Mar 2024 09:03:27 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:02:55 -0700
In-Reply-To: <20240321160300.1635121-1-irogers@google.com>
Message-Id: <20240321160300.1635121-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321160300.1635121-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v2 08/13] perf dsos: Remove __dsos__addnew
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Paran Lee <p4ranlee@gmail.com>, 
	Li Dong <lidong@vivo.com>, elfring@users.sourceforge.net, 
	Andi Kleen <ak@linux.intel.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Function no longer used so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 5 -----
 tools/perf/util/dsos.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index cfc10e1a6802..1495ab1cd7a0 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -341,11 +341,6 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	return dso;
 }
 
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
-{
-	return __dsos__addnew_id(dsos, name, NULL);
-}
-
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index c1b3979ad4bd..d1497b11d64c 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -30,7 +30,6 @@ void dsos__exit(struct dsos *dsos);
 
 int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
-- 
2.44.0.396.g6e790dbe36-goog


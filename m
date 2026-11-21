Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244341;
	b=W438t2c9lVSY8eRGtWcVPJP6CWm4qP9QAAkSx1s3CrmDArWgYBFwO9r1W3FUC2ofFGQX
	 +VALOGF7YFzQgZW6sA4EP1IWiUlJBG5DgFj6+85SAYRnKGsW2GutlJx06OJXcp/czxfu6
	 lpK0/nEHd7KfLgHMsYaJlFeEXUnd3Q3HqZdsH8jX0tk/yZrtD+fwZGgMVaBDqBycyqhdz
	 zBJcJ/068F8yQPf1XBv8Mj2isPgUqdfwa1PiKJeCnSCwswaNRj6eh7hV6PLNRELKY7+yE
	 R6scQr8+l5aakm24n7xwzjZVaJdIdOB0slev1EBgl4SiUS70I3KJyMTf8coXCfCTqEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=5uxDxgfBGA5yTPHcCIqyXHP3BnAmG6Jm0Jp5UQ/3dx8=;
	b=euyj8oSSC/8YATYjZwkeuUU1Tfxqiykjv07HMBtW9JdUgp2KtUDRWK6Dmu/LmQoVGEOt
	 u3oan0M+YHBiNxhBWPmLrkphaBfxVhB7r+l93nq+fd0UMw+kUND4k58kQdlVILud3kADC
	 SwQ4zmli0/gN6ld97lzBFOapsRnqjrU0Fc5EFdK8mU1m6OzId/cQYzn+ec0YI98RoB6uH
	 wo1QlEC1BOeri9Y71ySKyf4QFN/mpobn+B9IVCt8NF+3DUUOgwSvQipbuE8UYVIcWIv59
	 863oR7djFE+nHX2WJpe8BzWYj2Jo6xMcJPEBL4S56q75r5NcTAWNAIGm9aJwzp02vtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RXfniuAf;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AFA606A336
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 06:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92AFA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RXfniuAf
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-862a5ad18d0so2153711a34.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 22:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244340; x=1795849140; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5uxDxgfBGA5yTPHcCIqyXHP3BnAmG6Jm0Jp5UQ/3dx8=;
        b=RXfniuAfp3EtgdBAKLr75KxU1qE5n7pDoI4d1alzGAlfMRAwN3+g3ZJnmIGW4r1buS
         0NF7vvAxIMfQLGu2DiyROfiBeiWT50y0M9CRyJrT5qpvGCRcoKV1gO7XCWzbUrIhH6po
         KyzoqFq/Aj/ZvpMLYhuGzkTV9W7IoPEFMAHmkjc19hMbMZ5yxxr+wk2AL4Ylo8qzKAqr
         +FwiIPzRmEtTe4ZjvPr0OdLQboYn84U7cpF6/on+F3ewqtk65+gr5q4YhrUINMSpSbe0
         KcxKZlQh/2El9pk+oyQ9X/EjtaDhXnNfpUx6x9DbbYd0iA+9I6jOpHZ7YoKXp+80Lpkj
         9nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244340; x=1795849140;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5uxDxgfBGA5yTPHcCIqyXHP3BnAmG6Jm0Jp5UQ/3dx8=;
        b=a9sw8nJqdPPzG5Pss1vKOeXc5WCqG4ma33EFdA41tUkiu0I/b/aUjmiAQY+oRaLWw4
         zOyXjqNCugeHfVwqVy7y0vjjXAt3Xzb54pzLX6tHqMWTmvPJCLM9rfRNZnkrQwhHNwGa
         34KJ+X20HgpwG7mO6PDOjhEMcOrU0KirLnpM7KuNgii3bBNt0zg5NcR5dqvdrMHhDZAG
         PT/3DpgCfa7/3JsemTaS/FUIKu+Xa66oe7ooWD6Zxil9icjsk15Sj697YAX6NZiAhhY/
         5XU7/FaWeRgN5NruKDH2mzqFOc8+9Zfk/1u3LKL4Bjz6XhWpx6CBY282ksAl4pBX2PmY
         0/Ng==
X-Forwarded-Encrypted: i=1; AL+hErHqJOlZDe/36ulonx+70Mwc5CskOYJu7qQVu0ZMSdmhY72SxgZniuei4rQ+ntDiHeeGkOc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aSUJuSl/Pni9SfDTO7hmDexo5tfkV3c4d20Pvs5nCydSzUm3c
	z695LG2EYMMCVUFRoipnctcOaGLmSlkxtKohpybRuxzdatofsKzAgYoLIVtkvn3Xqp5NRqNbNxS
	5PZB2NIVc7A==
X-Received: from iobdo25.prod.google.com ([2002:a05:6602:4619:b0:9ca:bcca:dd8b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:640a:b0:572:e8fb:2125
 with SMTP id 5614622812f47-57a09504aadmr5490293b6e.20.1795244340118; Fri, 20
 Nov 2026 22:59:00 -0800 (PST)
Date: Fri, 20 Nov 2026 22:57:55 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-7-irogers@google.com>
Subject: [PATCH v15 06/23] perf comm: Add __guarded_by annotations to struct comm_strs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Annotate strs, num_strs, and capacity in struct comm_strs with
__guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
accesses hold comm_strs->lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/comm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 6343a3c9debe..9fc4e91a36e9 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -16,9 +16,9 @@ DECLARE_RC_STRUCT(comm_str) {
 
 static struct comm_strs {
 	struct rw_semaphore lock;
-	struct comm_str **strs;
-	int num_strs;
-	int capacity;
+	struct comm_str **strs __pt_guarded_by(&lock) __guarded_by(&lock);
+	int num_strs __guarded_by(&lock);
+	int capacity __guarded_by(&lock);
 } _comm_strs;
 
 static void comm_strs__remove_if_last(struct comm_str *cs);
-- 
2.56.1.750.gf70dc682cf-goog


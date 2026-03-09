Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883B33ACEE8
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058244; cv=none; b=B/a1GPRD/sAPq90KWpPzVdErMW3pslnofbWzdNoW4XaCkc5+RkWlZIJhjXkvhiAUMeg2YTXO8tvCrXjN1xfScAa0pU3Eu9a1+qNNj2I20VFufan5r/rKee5mIvoODBF0HdbaCg99fELtB3NOYV4bXlcl1fnUaKL1J4qsu2n4Sq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058244; c=relaxed/simple;
	bh=ZboW/udUnZLr3DpnSQSypW4B3rNXIC1R/Cck/6mcY4I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gChZOTweblnoYdjnRbhxRga1eUTBRs/lVWgvRhFEF+9l1gKOUebdPhOt+nSEszJnM3NFrRcO/QPLEhwL7vWgg4/nX06IMBpR2tIaMTnFECuYDky9NA+4TmSGVJ7Ff47QSpGYwprF2ugIN3+n7YpxizOUg50/wXIy1cKMBUhV3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s26i80Jk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s26i80Jk"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so3018775e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 05:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773058242; x=1773663042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rCo2rIiouMfwX2ZUpe0hC69qR3TuDKUYi7cYN13hy24=;
        b=s26i80JkWTMygZIoZ8ZRiYn3CXXzKjL+Hc28qjdWOYlNzdiMvIMj/4lNNgXflN0Xcs
         iTSnJuezIB1ggk7GvSts9temcpXKI18PhhdmbuApx1SvUYDajDf5EMElszyTVufWDZX4
         cqzEuzV4+tzl6Fzbh8jGAwoYDp3XYcolOry7i1t7Ehu3XuqV886SAwjiUgEVVAPpdssa
         piStm1EhjVFAuEJWOg1BqgIrq5wSbWSWlAXW7rb3eLwSArCDLQZLQJfNXFrf0kTPO9LU
         vWKjSuWi0gXfyksKHrkbgmN3AfmxazVCjYbvOtZoU9HNpb4PsUn+UfKPWRFIIX0jLQnd
         5Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773058242; x=1773663042;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCo2rIiouMfwX2ZUpe0hC69qR3TuDKUYi7cYN13hy24=;
        b=MC/Y0uwnJO8KZYw4FVn94EuvubPApXPh1NyYE+bnhEu+jAm6uKwVznK7ETgV2FtCcl
         rUkVGJyB14CAwg8GBdHSj3TRfLRFKy7ZILVyJcAFiux88gOWSROJOhUwzhBVCtly+Jsf
         +xA9mwu7XhsnXpbh/bwfpippSqQJxGYuAfJCl+/qQdEsbZWMYIPiE+2wTh+uHcBIiKHy
         ynW4J5CYQ4FjXyRbjXOcKAKp8VWby4hbwwJCXOVTl3mTJSXyOhrn43/9MPSvz9AzPTac
         +7scwS97um+yqAaUvaLJVMqt/oyqpFb/nkRi6fbThr1ySbeOw3otfSyPTaejSw1sG5Qi
         duUA==
X-Forwarded-Encrypted: i=1; AJvYcCVhX9p2lmImD+tDmk1z/LzHPf2lOVI48S4mrBy9j99o9SsvyUruBuJBwcbmf3mzh797/JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPHPpWa7NCtW9QGjeEvtIg/jTz0RN4tTsn5PiPomgzcy7vk6N+
	PlMTFDyE6xsWCmtcsGUayQ6Ul/xQsfT2HK18Q/gPlkNDEC3WTUKzmSUyvABxA2zmNZwUmA==
X-Received: from wmbgz6.prod.google.com ([2002:a05:600c:8886:b0:485:3925:a794])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b17:b0:477:76bf:e1fb
 with SMTP id 5b1f17b1804b1-485269587bbmr177507875e9.16.1773058241842; Mon, 09
 Mar 2026 05:10:41 -0700 (PDT)
Date: Mon,  9 Mar 2026 12:10:15 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309121033.2594457-1-bqe@google.com>
Subject: [RFC PATCH 0/1] bpf, docs: structured overview of verifier
From: Burak Emir <bqe@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Burak Emir <bqe@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is an RFC for adding overview documentation for the BPF verifier.

The existing verifier.rst has detail but IMHO it lacks structure and
background. Here is my humble proposal to make the verifier docs
more helpful for newcomers.

Finding a balance between overview and detail in documentation is 
never easy. The idea here is to describe abstract interpretation and have
enough information that anyone interested can learn what is going on. 

Please let me know what you think. I used Gemini 3 to get a first draft,
which I then checked word-for-word and reworked.

Burak Emir (1):
  bpf, docs: structured docs for the verifier

 Documentation/bpf/index.rst                   |  1 +
 .../bpf/verifier-overview-1-abstr-interp.rst  | 74 +++++++++++++++
 .../bpf/verifier-overview-2-domain.rst        | 91 +++++++++++++++++++
 .../bpf/verifier-overview-3-dataflow.rst      | 83 +++++++++++++++++
 .../bpf/verifier-overview-4-pruning.rst       | 59 ++++++++++++
 .../bpf/verifier-overview-5-advanced.rst      | 70 ++++++++++++++
 Documentation/bpf/verifier-overview-index.rst | 17 ++++
 7 files changed, 395 insertions(+)
 create mode 100644 Documentation/bpf/verifier-overview-1-abstr-interp.rst
 create mode 100644 Documentation/bpf/verifier-overview-2-domain.rst
 create mode 100644 Documentation/bpf/verifier-overview-3-dataflow.rst
 create mode 100644 Documentation/bpf/verifier-overview-4-pruning.rst
 create mode 100644 Documentation/bpf/verifier-overview-5-advanced.rst
 create mode 100644 Documentation/bpf/verifier-overview-index.rst

-- 
2.53.0.473.g4a7958ca14-goog


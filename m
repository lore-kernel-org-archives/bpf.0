Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21F2472AF
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 06:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775541748; cv=none; b=pFaL85mjkbpBYPbwwVTjhtadRlbfbeC/4AswUAahwaVzifRnwomj/XiD/c1ExgRiq2EdeCS3wChe1+rlYjXI2MrH75+OrVvq6i1ZZHToKlGPZhotgMSixCL9C4AWEr5gl0RGQM8TcxrS4q0CD1YfNDgZJfecLeronpqSzGcLzUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775541748; c=relaxed/simple;
	bh=0H9VniHkzeScDYxm/6T7jaHVl7KRkm/Ov7jjRgrBk6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6SzA2WFLEQr632X9b0wcmZTNf+tKE4hTFmUaND7n1zSy0bLurr3q+f0IaffFJEBDXeBqq9j0NrCimxmlI4XoBrt+2xEzdyeh2QUy5hrsdvRVqr8NKwaCl8Bw7vtIpiHqAntDtjkPlYjT4qiLyarMa5soI1O0spVSi6zydBhCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSYr6cPA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSYr6cPA"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b258576d8cso29421165ad.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 23:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775541746; x=1776146546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+UZVknFvzZ+CFZRKBwEomqUEvo570iJuDBzJawHtDk=;
        b=aSYr6cPAGxt3Xk7EuXlKysqU+50BosfIlUki+v2Tc6Dy69Vt4fbcu5g5c6yVihUJ3t
         DkTesnWuWRCGo6N88hNEHSWWB6mzLnrhwbfLkSxL5Fdzn/l1lDUObjz3br7yX8Dnwjyt
         gOv8yrWj5sFA0mvKE2XFc6JqanDjZgV0ZGJqLBcd/H/GVOfYE0sSgcPup36Sdt1pWRaa
         ASLsKJOep6FXQ60U9TGbZ58SlIFrlg98y1s9K9xSavQDRvCt2m4Fr4ycN1i5UW0kyqo8
         DJrOjYjXksVBZbmBTv5Qz+Ts9X1qIqsjXK62dre58mSpUIA+s/HJZxBrtfKuKT0FiS1L
         HpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775541746; x=1776146546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+UZVknFvzZ+CFZRKBwEomqUEvo570iJuDBzJawHtDk=;
        b=DmjMLsvO/DMX9MWj0tKQgz1U2Ni04amIoPFviXHmZNDStZKITTSfAPyot30qnI0LTy
         4u+1fN6hvA5NAeUlr8mD38w4yoG3KfXk6lGhcmrosUN8nm4H9GfXzHGeYjY65RPIE/Bf
         u0ffh1pTNETGVuKqamz/X1SYyeUboGRkVgHNKSqTnCLSobGW6fO9DeztBUteq4xJdMaf
         KO/O8pwfJdcCgjTE4GEfMopQvfRxsK+U1Bm8xMOi5DUVAe11wDwDXHmyGTHqSb0jVwP5
         U1ZkmrVGK3SPh49SufHSCP5zwfIBDemDbI5+TjAlh5MO1X16jbHber+eQ7JzhsRYoHsL
         Nw3Q==
X-Gm-Message-State: AOJu0YwXeZOmFju1J//LED4fvDIt10OG/1se4ohuGxU9KTRn3nMH66yI
	uRtFUX4ZV5y7oAo67rH/iTQ/HGVAX28gqn6ZJzscyWT8fRgpetfLQnq0EY0QNHE686A=
X-Gm-Gg: AeBDietEY2dW3gDn7YJiIOVzUUoYxKN5K6bK7oPjgmocy6MnjGQ0Zjrhl0lMHgKw2Mk
	HF1XVMUOAQP3fF1Y2VzKmxo3IMlUQXny6rdEwGLaKZSqAiGZ9p4F7+biYuEiT2ou2YN/CABd6UA
	P5cWnYDENEMzLqjZeiTM93UMSgoa2ZvuFemLlJ0eLlLlX33Fv2QARcPGMSu1lwJLDhfJdxRMbJT
	AO8PFpqTrnfV3HYkRBWbbkFZjCGcJBikFqRdQDJdINh+vGOLwKOtEaKKRvSvaLvbz6lwRPWVBOE
	MXPNyF+FbFbZzNLY/0/I5hyovUzr2IjYQRdVAaTjAf6MTL2McaTlky5r4BpTnQGhflMG/yNqGIt
	VCsw9dCConwQlZhLg3BMzksTSwLigGMVctNuY36p2PUlbodXTcjrZDi3+7lezFWD+gQQXOCPfcU
	K3+NhR8qNkaucLjeEbnalB7qx3DAwTqk3csnk=
X-Received: by 2002:a17:903:22c6:b0:2b2:680c:2193 with SMTP id d9443c01a7336-2b2818b3ae8mr164243585ad.31.1775541745820;
        Mon, 06 Apr 2026 23:02:25 -0700 (PDT)
Received: from C6-AF-E1-B8-1C-91 ([106.216.138.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm174986745ad.29.2026.04.06.23.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 23:02:25 -0700 (PDT)
From: Adith-Joshua <adithalex29@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [RFC bpf] Ingress RX queue provenance across cpumap redirect
Date: Tue,  7 Apr 2026 11:32:03 +0530
Message-ID: <20260407060203.3391-1-adithalex29@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

While working with XDP programs using cpumap redirection, I observed that
ctx->rx_queue_index becomes 0 after xdp_buff -> xdp_frame conversion and
execution on the remote CPU.

This is expected since xdp_frame does not carry xdp_rxq_info and cpumap
re-invokes XDP in a new execution context.

---

## Motivation

Some XDP deployments use cpumap as part of a multi-stage packet processing
pipeline, where XDP is effectively used as a distributed processing model
across CPUs rather than a single RX invocation.

In such setups, ingress RX queue identity (rx_queue_index) is sometimes
used beyond the initial hook not only for debugging, but for maintaining
consistent observability and pipeline semantics across stages. This includes:

  - maintaining consistent per-RX-queue accounting across cpumap and later
    XDP stages
  - preserving RSS-based classification identity for traffic analysis and
    validation of NIC steering behavior across a distributed pipeline
  - enabling end-to-end telemetry correlation from hardware queue origin
    through CPU-side processing
  - supporting reproducibility of packet processing paths in asynchronous
    cpumap-driven execution where scheduling and CPU assignment may vary

In these cases, rx_queue_index acts as a stable ingress classification anchor.
Losing this information at the cpumap boundary breaks the assumption that
XDP programs operate on a logically continuous packet context across stages.

---

## Design observation

Current behavior appears intentional:

  - xdp_frame does not carry xdp_rxq_info
  - cpumap executes XDP in a new RX context
  - RX metadata is not considered part of redirected packet state

This suggests that RX provenance is currently scoped strictly to the NIC RX
invocation context, and is not carried across execution boundaries such as
cpumap or devmap.

---

## Question

Is RX queue provenance expected to be part of the XDP execution model across
redirect boundaries, or is it explicitly considered out of scope once a packet
is passed through cpumap/devmap?

---

## Alternative direction (for clarification only)

One possible model could be to treat ingress RX metadata as optional,
non-authoritative context and expose it via a helper-based mechanism
(e.g. ingress queue accessor), rather than embedding it in xdp_frame or
xdp_rxq_info.

However, I am not assuming this is aligned with existing design principles,
and would appreciate clarification on whether such a model is desirable at all.

To be explicit, I am not proposing that rx_queue_index itself be preserved
in xdp_frame or across cpumap, nor any change to existing struct layouts.

The question is whether ingress RX queue identity is intended to be
representable beyond the initial NIC RX invocation, particularly in
redirect-based XDP pipelines.

This question is motivated by cases where cpumap is used as part of a
multi-stage XDP processing pipeline, where loss of ingress queue identity
removes a stable classification signal that can otherwise be useful for:

  - correlating packets across distributed XDP execution stages
  - validating RSS / hardware steering behavior in software datapaths
  - maintaining consistent per-queue observability across cpumap boundaries
  - reconstructing ingress-to-processing paths in asynchronous CPU offload

The intent is to understand whether these requirements are intentionally
out of scope in the current XDP execution model, or whether a helper-based
or metadata-based abstraction is expected for such use cases.

---

## Follow-up

If this aligns with intended design, I would be happy to explore a concrete
proposal or implementation.

Thanks,
Adith

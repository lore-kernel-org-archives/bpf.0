Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672341B340
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828719; cv=none; b=qYjLeO4reGJ11x4D2drBTKaaG8djp3uGBPkdI5hzEqEARmTHcUFvDO1CJusdn0UONZcCkzhzfCaEqsHOtjTu34glleiQmRi4CZkOQ7mWLF2mpbpkyuoV3l84R0ouDah7G7CQn6fDz54QqGbQ4qLIElC/yNyRyYpVjxpxLeOoVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828719; c=relaxed/simple;
	bh=0REPJZWgy26KLZImfE6C/k7ngFC7w8U4HrlxVJBXBhY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bR3plz8wv5V5rJVyOq3y/GewiqUS0F/42RbSujy6wrydhK4nP/Cbg51q8+wIkNO6CK1lc2HBdCkoWS0xZ5Y76AsYx4pw8n3veaacmAB63z2PUqHveNPUGyD3LvPBIzd6Bv+RgWMjNVM5yvd3ZVmC4kNNXjW96A6Sf61V/wm++1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bN3IcTWH; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bN3IcTWH"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30c42d96713so3195355eec.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 07:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782828717; x=1783433517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cuguFRZMMlHldO3fkFlINbVPdU9xBxBAq2byqlzm4/8=;
        b=bN3IcTWHyCNew+3PhPrtr9lMP3X1wtuC9TJIR0GTXmdlbx0+79FfbVHYRU5PGCteSC
         XIAq9ntBOTaZLGYwLRXETxOj7V71PCIUdedV5c4ePD7DCJi3LGOllve6jCEAMmMll+Jo
         C1d0h+DgHC8ExabttR0cntHDGVrlKBd+BhShBmsUZCdJzKRvAJW/NOstVLStxlPYPuBL
         /w815ZryQZFAXFC8PYszWIY6GjjMLfj7ZRYvpZN9TRfI8oazVYHDmbzITaYZoRihGYHq
         /dq9QGNbVD4FmxK2a3HZFPwmkTihRmr50UpE+z1WKcmv8YbifaVUwDrzmlfu0XARl8Wy
         88qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828717; x=1783433517;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cuguFRZMMlHldO3fkFlINbVPdU9xBxBAq2byqlzm4/8=;
        b=Plp/fv2Y3zkrHXkrS4Z16EKQhiK/Z/wuX5PCabfv4uZyKmso8iBRW+0hFDRuJIzO+k
         BZYFgq/oJeT/1okrpbHVneHMLXchx3np1U3U7nFCURMgRraaCpvpn1PE6jc5eDsHSePX
         49BYCdm5j1bX6dabyHv4mo5jiFbS9IfIDWOpOdO+dLJstawEf6n0IqZUkWS74cc9hn1+
         XzRjYbMW/dBPQtdcyV1oLjpdyD7LFqBzSsuZYsrMkG5u8a46bkvYu7P93CQHKt/rltlZ
         ZoXULQ0aoTqFmbyrNzAFZZBj4Xb/m2yYG8qkrXto+04IWRa/muW4gQwuFsg2BYV+FQ/S
         ixUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMktChvNkqpq0JJ8Z44oH84yAeIYscrCzZ7Ar3mxFCtAVIHTmazzO5cNC0+4Z9fFNfZe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVHB8gv8QLyPcwW+ARPcJH7QMZUoFDkag90hSsD6EXHgZCcPtX
	mLZx8Oea+zHnmYk6dHzPAFwI6T7q4RryIYxgXC4G+oK7kzkVMxHA1czarHmjyAl4Ml63yfIn/+E
	BA6RejVLmY0v+HaXym5N+3w==
X-Received: from dyce12.prod.google.com ([2002:a05:7300:724c:b0:30c:2df8:2138])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:7241:b0:304:c9f1:a0f6 with SMTP id 5a478bee46e88-30ee147093fmr3313716eec.33.1782828716477;
 Tue, 30 Jun 2026 07:11:56 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:11:51 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630141152.3757722-1-aaronlewis@google.com>
Subject: [PATCH 0/1] Introduce an instrumented profiler using BpfTrace
From: Aaron Lewis <aaronlewis@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, seanjc@google.com, dmatlack@google.com
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

I am proposing this patch as a simple way of turning BpfTrace into an
instrumented profiler. This approach has come in handy for me more than
once, so I felt like it could be useful for others as well.

I am not entirely sure where something like this should live in the
kernel tree, so I took a chance and put it in
"tools/bpftrace/instrumented_profiler". I am not attached to this
location, so please feel free to recommend a better place for it to live
if this doesn't seem appropriate.

I have included two samples as examples of how a trace can be set up
(`kvm_trace.bt` and `vfio_trace.bt`). The included Python script then
runs over the output of these traces to generate the final profiler
results.  Example output can be seen in the patch itself.

Aaron Lewis (1):
  tools/bpftrace: Add a simple instrumented kernel profiler

 .../aggregate_bpf_results.py                  | 318 ++++++++++++++++++
 .../samples/kvm_trace.bt                      | 197 +++++++++++
 .../samples/vfio_trace.bt                     | 315 +++++++++++++++++
 3 files changed, 830 insertions(+)
 create mode 100644 tools/bpftrace/instrumented_profiler/aggregate_bpf_results.py
 create mode 100644 tools/bpftrace/instrumented_profiler/samples/kvm_trace.bt
 create mode 100644 tools/bpftrace/instrumented_profiler/samples/vfio_trace.bt

-- 
2.55.0.rc0.799.gd6f94ed593-goog


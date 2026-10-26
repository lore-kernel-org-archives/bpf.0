Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983652;
	b=ddzMSA+yvQYo1HEtx4NDpBarnWsXpl+YlvOo5Be+zYIljY/ZEMBykIedCg8HhVM4ypKM
	 0ua4OfbKpTWAKEU/koqM8lRdJAZ+LW5MGCImcRtoawCJ40LMzjW71NWrhceTlyfr5NvGw
	 7GskaschpZr5qyE15JHw30o4XHW+RKEqf2bKii82j0RAzfIiL4/ZKr4RN/L7qyCnMF+XX
	 ThGZLvvH3IVdcmBX0QplEDwlReolkNB63f1ROz3g3os4I0o4GGkq8oyurOeDumpJF9hst
	 TLOp0IvKOa1dfoDzeOJNDP6ORWTo7JxHTDMepspgcq06cGU26Jl2hSCAmAS9gHzy0PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SBJH4wkqnKo8HjOIpQ4O2lmqpnZtwQWQMRaCPfmcYq8=;
	b=H9M/uwnEEp4RD6k6Nfalh69DsE34cw4iGqSnKDT/jKHwpJ6spTMRQ+M0NWyOPpPHvOHm
	 PDtf4KcinObrVdwvo04ow6/bsD/+bBM66XyWXVUxd0hPMCHZbL7Lusxm8Zi6n0RTlPqH/
	 KnajB+wOc7EkA6miwtHPO+YjSbvVaTEkdbI2erYd68ZtL8e8MfR9zKwZvWo7ugEVbb0o4
	 CE9BrGfTdM4cRft9r2sZGEkGBQS1UqCd5dnx0cCuRRCqdBRahnhK9Rvonj6raO8NYC2HN
	 4fA9leKoQpKKoC3rqj6NHhTQ4xuu/HaKIb4QlDdCjzmyJLIu8+//LxvYENCWg4NvyzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ifPfZC0w;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438B606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3438B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ifPfZC0w
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1653554a91.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983652; x=1793588452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBJH4wkqnKo8HjOIpQ4O2lmqpnZtwQWQMRaCPfmcYq8=;
        b=ifPfZC0wE5HLU3cz51aJG+TK0K4PkiYIcTXwgiVXltEoK8BGenaQyAKvUAx327wt/L
         /GJ2EJPa1vV8YJUZsv1EIcpPA4DK065E0wYquWAS2X7RRn8JnC3WxmvUlDXy9VCQxpBf
         VPG8L9jUx/yTZygtnaxb+KFk5Sf0HxyyRSNvdjFIsbfxM/QTCpFn+q5gdCRSDSwz6rST
         iajiHRWl9I2xtZfpbaT8SbPgIx7LEDcUKTTBG1Pie4VGXEdkeCEEeB0dg0he3L1HWEnH
         DUWv+ILXvoZYjNhGxaMNB0QlrSCQFd3x/a41PEQbSa0KgvmNa+i5cNhre4njdbxvLGen
         GIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983652; x=1793588452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SBJH4wkqnKo8HjOIpQ4O2lmqpnZtwQWQMRaCPfmcYq8=;
        b=EtTcG+Eiqkhe+5lUEb55R1Vg9kYynt+NXKJegkvSRwRpl1Hfyk0cQbcDrQv7MLsyEd
         jqTpuIBpOUtUSpUKMCu4y5rZwFleVoH11z2tS7y5jIo9dQQORJbhrpEgXf1lyPBC3zdi
         GIlnrpB/8hLTHUC/mWhQikhMjIN9Z4O4sIFerOA0kePnDMyRIcLHIDwf7XaohC6DVc7e
         Xc3pacxtn6PGs5/XHkwzfXaVhRgP3qhg0oCMN/0E+zyoUYIVh5Giqz9fkBuu6BDRe7FH
         Emq036XPXu6vpLB+E5MSM112x7VoeqFCnpWzmcWTcCTCfPiyFDowFNVFpRgAT8llge3j
         AR4Q==
X-Gm-Message-State: AFq9FYIMzTbpvklgYrssSN+qAqRLYGUGkegilgCMKdewdEELbcVR62iJ
	CRrEDTxZxDe4IexZTxMJbqg5MOzcWTWBQu4GP1Zb7GTmZo/fVERWd6fDJf0gsQ==
X-Gm-Gg: AYBFou2eC7Mf8/9XSPb4rEy5d1zM1dzyPRNWxIRxl54nImkPDUqiu93TsrIVvcMBkwT
	cfA0NER0biPVQ7wCm0Z7BiMtZxIbR9XC4eShLqk64vzSU6yfgmP51/FWoPQq4iu0eW+P7jrEWEF
	E2lVdkCMtLad5aRrsseTryX8wW0AO8RsfXzsu/12FnhN5gqq86UT1fxs08M/BIA/LVFoRZGT9CD
	19aQbSACxvXd7YnI27Oik2cLkYWd12Krcyr3Vst2d/mxw2AxKuhX3eNm+tev7kZ/kdPm7KQpGgx
	/+jicUhRKQetvWCnc/Epv+xAYm87vR1o/vmK61cj6siJSFrxpWT0W2vb1ZqkXTfjqYn4pIX9KHI
	P9IdqyNh85b5xQZVFD1nWKGJWhOu2gTFf1GQ8Vim/s0t7OFkHm8+BZIYByFfA8aI7spkcjp209K
	p8UMAHuSlUlqq6ed4xwFJmNrn7CayI3ssHu/eDER2NITTyxXIBO2iHrQBN5e6e2zxs9sh2qSmIo
	5D23974jzRWjoX2SFEw4Dp+iV2ncK4FwAwZ27OgcczlimC9bJjN4MnYbvQYfAYEQsMidos/VWkL
	UdLtBMNFl5cxXWIBFXRth9ISRQGze4hko4i4a+Eel8LnQ6QEXZLcgkGnJHColnDgiAhMRvknWz1
	e5JFK2NDkQneB1DfriGbKx8S3QOIG8g2yEjMVGJkYs2vZ46E=
X-Received: by 2002:a17:90b:564d:b0:3ac:aa8d:19ee with SMTP id 98e67ed59e1d1-3adeafd3cd0mr4337382a91.38.1792983651553;
        Sun, 25 Oct 2026 20:00:51 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe8f09csm6651713a91.7.2026.10.25.20.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:00:51 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 11/81] selftests/bpf: Wait for the last maps of map_kptr to be freed
Date: Mon, 26 Oct 2026 02:58:32 +0000
Message-ID: <20261026025943.404450-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

map_kptr_race/htab_leak fails occasionally in a complete run of test_progs:

  test_htab_leak:FAIL:htab refcount unexpected htab refcount:
  actual 6 != expected 2

This is a race between two tests. It is not a leak in the kernel.
 - map_kptr runs immediately before htab_leak. The two tests examine the
   refcount of the same test object.
 - The kernel frees maps asynchronously. Thus the maps drop their
   references some time after close().
 - map_kptr waits for that after each subtest, but not after the last one.

Wait after the last subtest too.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/map_kptr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index 17e707dddda8..f103f8cd458b 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -225,6 +225,11 @@ void serial_test_map_kptr(void)
 
 		/* Observe refcount dropping to 1 on map release. */
 		test_map_kptr_success(true);
+
+		/* The next test counts the same references */
+		ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
+		ASSERT_OK(kern_sync_rcu(), "sync rcu");
+		wait_for_map_release();
 	}
 
 	rcu_tasks_trace_gp__destroy(skel);
-- 
2.55.0


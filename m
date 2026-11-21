Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288428;
	b=B5Tc7VC1puAgPxAweDlTm0FqVbY6idb3FAVAZ1hsefhJ4fvQHt5ft2QdHJq1DFebJiTh
	 LXzhGU7AzGG3cbDMLbu6+Zb7LZsJ53Hd6B5x8sBnbUjNPl5XxwH/dI9vS0KdI38XZrbhP
	 F9Jt/DPhSX/dB27rYQL6yxyAa3hjuXepoiEyap2oc9dMJoB5mLAY/yriCa2lVpuTdkk5P
	 JqXzhhQmWQhgDyVsPXLNLbgoATLLwcubQJDbROiL6pwF/daz4HlVjyvfKkdGwd0Yc0fQg
	 LdOHVv+FOwt3DYoq7BVDZ6SFT0MKnbDwcAkvAJi8MROrLSy2lJiXHcCwe550gCLeXPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rJ6s9c22dWNR0VoMv7zYv5gDcANI8/zObL47I96NMec=;
	b=j5gg+rv44dzq1fByU9SUM5c+HPuzv/fOMrfZ53m3T8YEmQu7HVGmcFddejKNP2uLQ7cV
	 +sWnmc7Fj1f7gWHKUfjws25jAacbgp4BZ+NGZe5ABTCWrGr7KcaEjex8Pe6L4eMx5oSEn
	 7vfVTgRC6m5gZSS3BhZrAG/OelY1MzZtxtJfokvCtc0Uo5Fpug458L4AChGalwcAj7FBc
	 6UbuRhw79T7pfCPL9ZnR2CRTKmIlDMj9MYAJPWFh7UWMQOv9CVvajz/ohfqLF9TE0Z+96
	 8hyOqJ72KzmjvLh+6XS+Cmv2X/Ha6WofHmFkholIRa0IR3/8qaeQiwhwa0JFzIzZL4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0AF465U9;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337C606A337
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 19:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F337C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0AF465U9
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b3af93b85cso1169403a91.1
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795288427; x=1795893227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rJ6s9c22dWNR0VoMv7zYv5gDcANI8/zObL47I96NMec=;
        b=0AF465U9cVVMpggMWvt1ysLWx+blAuJ7AHXhry7WegUbTfOuthdyuw5VYlURy3Lo0m
         Qs7jh5zZoTGxfPm3i99DFlFr6ciITJQZJQK7SHqkTJE48hbXsQjIIsdWX3swRl0eflR7
         ySC1nGVaQU/fNqiup6vKHfArB49QC44c0Hw7DYQrAFzBmbJthh80A4PxrTS9YkqqdJpi
         KEqiNqBX03LqxObjjC2Ddp/9cXQ9NMb3gtvGabnlb2ELoPvDSx/jO8YZ02CGe/9lCUM2
         ZIAwNV1LSP1yCM+P6jyCFzW6eclSysx1X2Wbalw6IPEKa059k/Ppq959YHlDvMU0vzrY
         YOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795288427; x=1795893227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJ6s9c22dWNR0VoMv7zYv5gDcANI8/zObL47I96NMec=;
        b=LIvqlURRpnR69n/sVLmVefZTUBgr1/Tu3kBBdYf0C2JCurR7iACMO/Uiz7Ajx+O5BR
         V9KB/2p2Ua4uWpEEdcLVLXgolGwsezYNHIhc41sudNVfTQAj7xkPA3TPFNJPGecyf0j5
         hov0TpVjWKPyDgIhuCHJZS6X6sPwlpiNW4LJhCr6Y6uGQN3Fotpp3ZTsl699WM4pAYC1
         d0TEa5WhcHOfbyOoJqh/ugZt1Lie9N3hrv2abImF7BmsLNg2v+vmO9YO1p9oOiVb+pwF
         H5zqwMPnMHQQzjf+ZzwDwUbY+v7Un0PddlbFaqYSuoMMV2Aalrr40qCKUt/TF8KQKnpb
         wSUg==
X-Gm-Message-State: APuU4Z+yC2c6880mIgxARYNoBBgTO5QK8gpuQ+rjz5bSq0I3zeWfEN27
	mJFlSShUfOLAGRU0mqB+hb3oQh7pjEweETXHXtbKEMxpufMSz473fqx5a4q5nA==
X-Gm-Gg: AZFdTZcQvRY6iTxCO1ean5rutnOWOyOYcXBSRqwhcRiBJZLVo66UEf1XU9culoXDYzP
	MmrawFFVl8grim8A8NPmeo1Vkjj7nS98c+eajjHVmBIPZe4N1Hv9KvTjX5tXqPPV39UAQby4R/3
	Tp0jxEsEePbfVRQLGkUqCgkBV+YeBERAJKFINiuK4bYQZ3eKEWQihzzEq7ZjsdrJa9VLIyGjWrA
	fa45lyOEbTajUa2wWo+cRyLPebYDly/I08H7h+aIZIh6QgwjYtRZ7ZkFXV7WSLcoFaz2mI1G3zB
	t0AyCl3K+l16lWRbwH5IRDQ7eeBK0A0/lsxfWPypQNAWjYlR1VtAurTGCv1dQ0wYM6RLQnlFpV3
	bzz6qr4xBjfIcok0jnN4g28+HkeTWWGoOvdPzK6iaPJpoKGc6kLqftczYElzDFEi0RAWRmNcv7/
	ul215g9S6WX1vBMJDcgkFQ5hti1jitlu1yIm+9i1eGRhl8uDPAl5G7UrowIMUl0oCMlshkF97t5
	cO4r6lTfNGLoP9xs/6semvmaPTcJjYSHsHBNPTlWtZa18S44nyt0b8q4SdhWJma1SOKOSeiKEGw
	etq9tpa7sKg8uOapviQ4WXE5ogKdnCVpu1NoCRIfESfnNU8b7XhigfFSSTCIZTlQvj7KRUh7dIV
	U4lV0KuTWUQm1dLT2DWgZWb2ggYbuRVb7Jzwe1ieGJI0UHXJxLsQn62Un1ClQY1hOiWed5lAymg
	==
X-Received: by 2002:a17:90b:5887:b0:3aa:fc22:8aad with SMTP id 98e67ed59e1d1-3b41c97c995mr7011668a91.54.1795288427184;
        Sat, 21 Nov 2026 11:13:47 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d1361fsm12306254a91.6.2026.11.21.11.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:13:46 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/7] bpf: Fixes for the verifier passes
Date: Sat, 21 Nov 2026 19:13:35 +0000
Message-ID: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Fixes for the series "bpf: Verify in passes, with equations in the state".
None of the bugs makes the verifier accept an unsafe program.

Patch 1: the build fails without CONFIG_NET.
Patches 2, 3 and 5: the path-sensitive run finds a failing path that the
program does not have. It cuts the budget, and a valid program is rejected.
Patch 4: the log shows only the last basic block, not the path to the error.
Patch 6: after a failed allocation a load gets -E2BIG in place of -ENOMEM.
Patch 7: nfp can refuse to attach a valid offloaded program.

385572 programs of cilium, tetragon, tracee, scx, Meta, systemd, rust-bpf and
other projects have the same verdict and the same number of processed insns.

Alexei Starovoitov (7):
  bpf: Fix the build without CONFIG_NET
  bpf: Mark a skip of trips as a guess if the bound moves
  bpf: Mark a skip of trips as a guess if a 32-bit value wraps
  bpf: Do not lose the failing path if only an equation differs
  bpf: Drop a path of a path-sensitive run that is out of frames
  bpf: Return -ENOMEM if the next partition has no memory
  bpf: Replay an offloaded program with the precision of the good pass

 include/linux/bpf_verifier.h | 37 +++++++++++++++--
 kernel/bpf/equation_join.c   | 80 +++++++++++++++++++++++++++---------
 kernel/bpf/precision.c       | 22 ++++++----
 kernel/bpf/verifier.c        | 24 ++++++++---
 4 files changed, 127 insertions(+), 36 deletions(-)


base-commit: 9867c61abbd44f7053a871566b3d982f62c6d8dc
-- 
2.55.0


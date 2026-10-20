Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511940;
	b=Fo4Aevm6r0/dFU6l3KbLA00MwvxmxdlquUp39z8YvUmmz7mhvqM9Ps01OaZMVYxTcgmJ
	 XnWx4osg9xLHIM5YqGE9GPr2le4jUA492gVpaS43l0ivYxqqhEtP9l7uyuApzMvonsD5M
	 09USB9IEBAzjZwVQ2EKXnLoAO3TfWC21YlbDmfS14q7bWATV6ngJDhaUlNHukhcyKjvt4
	 FhCBUdijMvYNL37tOxV5mYEKB/s+2A/U3rLcf1hMsi1wOg66sCzAbpXOwmKXoEDR9X7e/
	 ysS1IzPSVhSTa0XZeNjrUhK24kCpTA5zn4Hf59OrkigeqL7QgLNUxaDEadQn70EENfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=H4H7iRSUlsSj9ifdlVtDp+ziRohA+ewp4DyoXrJPO6Q=;
	b=JWOCmrn89NH+eRwcU338slIMSPm5I4wcKhJgyW833a9/LeCSrwZtNYZYjqLxb6A4i+uG
	 c//rlb/9B3g+CxrFphYUJdq8zzlJyp6+Ld6x7znu+grv1EU/LOcT75LKiin9QjhS0M6XY
	 kYLLgvDU+IsZhrDqHxefv0QORuPQLZTrIPLJ5gvtue1AuxczpfsTdDe+YiIV6oSEybxeK
	 zW+Xj6S6fmF7WmlamtOGZg1cUIK4HO5eOjcIYBgy4YOM+ASY92MIkeCXLizIJzUXOg+h1
	 3/I5oNDK11A6YSR6BoCNBO7aOmscdQrVhHB/LT06df7KmQd6nss38mMx18VFyhivlrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R8iBNnGY;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D92B606A324
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 15:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D92B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R8iBNnGY
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so2470976f8f.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792511938; x=1793116738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H4H7iRSUlsSj9ifdlVtDp+ziRohA+ewp4DyoXrJPO6Q=;
        b=R8iBNnGYaqT/wGTjR7wkqrvY+S3fvytGSkjEUzOmFr8dCGfdqjyLMjhUjrzdLPNQar
         Qly8fNmIxnutCyFiTuBB9EZMl/5V3qTDS/UzBpZtriUgp1ryjFgaA1xM5JEXXSKPz+6W
         Iy6REj4P5u+N+0MX1VxxtNtesU9/+cTibZixvOYM5tawFdR8NuBDGj1lahLxq61D/Pte
         MkG4RP71Ysjh4yQoLQ07bDUCbEmbTQZYvRnvLzlEq3mGWa5E76ZUKrgA20C605xF1hjF
         3SOI5B7T4BIv0zDBqTa8WOHDjqQ0NiMNNuoLirHSLMmrKGL/VqmA5DSrxfChWBGkJXtQ
         x61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511938; x=1793116738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H4H7iRSUlsSj9ifdlVtDp+ziRohA+ewp4DyoXrJPO6Q=;
        b=KrWjngFPwyOFNtfePZOxHctwnQyWTcG2rfilN1X7b/x08tGaS0FgyT3FA5R5fEirCo
         bFKKATKCaPh1fb9PHU7SJTmHtXbnRjOup5jDnQmqELDRRMCXFcnc7qaqWvmG7mLAs2tH
         sh2FhOu1zY+AW2KxajJJAFQSrQGmt8Gaz1j57VlwbVPNGBrPlNgw6HG0I++1ookgpe3e
         N2xZvNWAN2XLPYgHtWfbufaPc+t8JSOcD53xQ+r0W4zEy590klpS/FqAaanZ13NiaBDz
         QxYFiPacJhvxv5I6dccGdPxSzPy6SOh92co5lYq8A7t+7vijNDBYl5ihT5S6HBdX1u0n
         QrOw==
X-Gm-Message-State: AFq9FYL6I6nmBXEonlRmKMcYX3SoaeQOAJddOymImVNsIPT8og9wSB3c
	QeBJ+HzcO85V9540XtCg3M8c8hvhHqnJoxLkFZDxxjQRVE9A2wSNzmJ0EKkE5XbLIVGT+A==
X-Gm-Gg: AYBFou3le/CtSWLdNNzHJOu60plZPh2uDixAebBkiP6dt+38/wIEJrQ3MfzASIpEIFO
	tInNs6ov26aRLhlDW6BWiR4yMH5/IEABZ/z+2fEYS8jxCwbF4WFVOrS2QCZiMsd8V+DSfDcst2G
	WMk9OP/d0xIcOhpJvsN4GICsnEAnzygGtFPHTURym8wb2VNeapxX58zQsaGI67brTsZ7mDALhfj
	H/X1BdaYLaxNTKEag75e6wllq7ulDbqCs/ZWWJQZLOZkgYv1g5pLZmt74W4LnpMx9GuZBkcarnr
	UIY+isqsizEX8zFnzbB/4+bu9x+4JFdWFWqjwRhVxfYhgLfeZSGo1It06Hf5B2ZcYgEJoxV02z/
	7miEsZ+Ift2I2f+rz7/D508ndHwBr9CnSJBojRFup/VszP718cj2U/l1un2LRQgdVEB54aadCh0
	5udSAlYSA1ESO50LS4u2r3bzq18QG96e3SSK2JF9cJST+ueKAcHYohy5HvKP4UMQ2VlYgktc4Mz
	2XgwMNc4mR9piRx/7+0ocWW2Mcct/N4QpAgWCbGXW1HOQ==
X-Received: by 2002:a05:600c:4fd4:b0:4a1:cd83:f027 with SMTP id 5b1f17b1804b1-4a1d7634bf5mr214566405e9.27.1792511938310;
        Tue, 20 Oct 2026 08:58:58 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1fb83ff02sm5627335e9.6.2026.10.20.08.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:58:57 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	willemb@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	horms@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuniyu@google.com,
	memxor@gmail.com,
	emil@etsalapatis.com,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v2 0/3] bpf: Add bpf_ksock_sendto() kfunc
Date: Tue, 20 Oct 2026 15:58:45 +0000
Message-ID: <20261020155848.75711-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This patch series improves the bpf_ksock infrastructure in line with the
work proposed during Prague Plumbers 2026 presentation[^1] by adding
the bpf_ksock_sendto() kfunc to complement the bpf_ksock_send().

This is useful when using ksock to reply to differents peers while
reusing the same UDP socket and generally works toward the goal of ksock
to support the basic socket operations.

[^1]: https://lpc.events/event/20/contributions/2430/

v2 updates:
- remove the LSM verifier filter refinements (alexei)
- remove allowing calling connect() from the send path (alexei)
- change order of the tests patches for signature definition (sashiko)

v1: https://lore.kernel.org/bpf/DM9RCU3BDWEG.1C32ZIVU95S76@gmail.com/

Mahe Tardy (3):
  bpf: add bpf_ksock_sendto() kfunc
  selftests/bpf: Test ksock sendto()
  selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach

 net/core/bpf_ksock.c                          |  96 +++++++++++-----
 .../selftests/bpf/prog_tests/ksock_sendto.c   | 108 ++++++++++++++++++
 .../selftests/bpf/progs/ksock_common.h        |   2 +
 .../selftests/bpf/progs/ksock_lsm_verifier.c  |  25 +++-
 .../selftests/bpf/progs/ksock_sendto.c        |  59 ++++++++++
 5 files changed, 262 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_sendto.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_sendto.c

--
2.43.0


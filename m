Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491923;
	b=oNuMnttCKwrkOS5FqGQ9bqsIbP9m3JNokIXgEOvIrnZ9q1+KufV1wAi0bm2D5yoMmUNE
	 pNkpEF4AiMqH35Fu+cNkonRe0W3ngGcyH0lMLvC/4Wvdob4REwzUlV8xB7iX6Y71giZ2K
	 rcPAu0E2yN9J4QhWpmg54wlKIyEOMJISWxhsZBnjmrv/eG/qnjfd3mbNcFsZDVx88ZCa+
	 ZrTsV5hWMctPmgXS1dkA0a0NxNjGFGlFpiasBEXLsw+hGHI/eXLM9rrl+nGFEhmhjBwhz
	 JnnP46yHO3Vy46jueP2s4+hJhKnn41BHfuIGQz3CqbIS8pCtvFrpIcaiwDXxduU/Ghw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NeXzTwoaQQsPfza4T2NcSCi4eYTRjgEtdtZmqGwt2Jc=;
	b=u/w9aK4Pi9uGZAnqxq5velAjtZ1LqIhoVDEfLLlF6JrMsS/xV3/5cO1JqGfZd+lUIpiK
	 JjUFmNZI+aUlXj7wipRRjo+/jPZZrRLcW9Re51ABsXlJpJn3glh8V6iHuTtz6fF+ettLH
	 pP+pIRfJqpGHK2n6kkxJHhCJk62KTRLFSmeDgtsfiHSXtKM5x4keg8IZR71UZ2UMQREP3
	 Q7q9+f8jESD+7FsszRKGrBI3HHJwm8hu9F2XUZ1vWs1zGtf/GWfY5pxVRER6qv+ROYlwG
	 Q7F9mybA8Xuov3I51wQwyiDFFeybTuYXEtrF6quEI32z/z0dvFRUAxQlXT63bIIVeuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hgzCAqZI;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A2606A31C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 923A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hgzCAqZI
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1dfd49525so19489225e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491922; x=1793096722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NeXzTwoaQQsPfza4T2NcSCi4eYTRjgEtdtZmqGwt2Jc=;
        b=hgzCAqZIJGESdXYWWGcjsj1KblLotcZdKXwuiV3LomaQCXNTnkafzqR1LT1mS6Y7fY
         D88Hat3EUlSgnlKepZFEH/T1/Li7EPJT8SOaX6xEOCffujYSXgSfetvrkI70izHAhArF
         blf+2HnLqeZXb+nL2nEHQu1YRhcswiXNJxGlIL8a07Ys0oTJeW5w7eFW5uutNDYTD4Pq
         NUGgNdI1aXqAlxkhkzPCpY7H/1laasN7FXjAyTXitHHE7ufsylYzCuCfwSvTWn6VoqQt
         SRj4oYwKtdVuCu2wVe8Grfyt08aVcOMidxOT8/v+asobMPgrvJEm/yQxFEAaohDA1M49
         OwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491922; x=1793096722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NeXzTwoaQQsPfza4T2NcSCi4eYTRjgEtdtZmqGwt2Jc=;
        b=I4TBUBr78mG0osksyWL+ZiIMgwvux8rqQxI3wKaKpZIiLsasGS5WtFYLPMwhCa2VAx
         YS0FGilalZ9DvHwOi9UEMC6CgdSCorX2bcDprh+Q/wkRTuI768UdaVg2baZA8dJYCgoe
         42lIUSgkJ1CApJzF3dIngyp/gCYZMxtqpJk4tYKP8GrjR5Eb27aaTNZ3BukKM8B/TrdS
         Ok4LlmzkuetMeQS81oFR5sJwi01mAaaOPqST+dE7pY0bJTrWHZFFFRPUk/djo513u6Bv
         tI9xn6gEtALNhicv3VtqdppFCGeEahNjCxv37YJQZNPkGUohCvguq44Lv5o41ikeIbKb
         vlmg==
X-Gm-Message-State: AFq9FYK2NAFfwvQBMhp1QGlQDHacDAt9j4vpAQWaFcNUr3O0A+xeILYP
	wqbeDNG0mmHeDsx2NYQ0YQnIZ1rzmkPydL29RuwcpV/if/FZ1o7LzjWL/d1s4bbL8zk=
X-Gm-Gg: AYBFou176RNAYDvD67LY7VJWWubMoi5qD6RQqLlnIKZuBWLWIoxQ/gsFEKwqOGFDcHz
	Mit/YVgQeXWk52RWXyzx0ax8d7B/4SBnsIF8dOYDfrE5z6n8/mAs6Abje0bE92+aahqwg+IYk/N
	AXl1QEkH9gKqb0VgJX7os5q5IVXBKs7n1nw8UNrG8JsiMTwgaC0vIbqsPjKg0OizL6C2d4uquBu
	5pIIpAgmjC69BNll97F9vqLieiMNVU3ByiQyzFBNVoB/yaX6khvxiuw6PpZdBvhZ40JYfEj5iKn
	sFmQDdcpWPXwgS3ghoAxeo0SnOlo/5D++r1ojTFqEDST3wPTDgKQyYQJ6nRrdrHQj54yLRY1LCe
	OPN+znyD2g8XxZqoENRqBc2DaijYUoD1GMYrAX513cyfXT+AUSvTC7tWeCPryHIi/LiVJ91Vb5l
	64C6HP3bpLRsTHiDanU+Al9zPXAg8X/gWAwMGuwfXCsF8j29GRRp3cjZ5SMOclOIXfgnaGZhqTK
	pAOHxTSXNHCwrqNCOUpqBShCA37D71DTc0WzNykvwTZpA==
X-Received: by 2002:a05:600c:b86:b0:4a1:d459:db4b with SMTP id 5b1f17b1804b1-4a1d7610722mr208729645e9.24.1792491921643;
        Tue, 20 Oct 2026 03:25:21 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:21 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/8] bpf: Expand ksock send-path support
Date: Tue, 20 Oct 2026 10:25:04 +0000
Message-ID: <20261020102512.518479-1-mahe.tardy@gmail.com>
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
work proposed during Prague Plumbers 2026 presentation[^1]:
* refine the LSM verifier filter
* allow bpf_ksock_connect() to be called in the send path
* add bpf_ksock_sendto() kfunc to complement to bpf_ksock_send()

This is useful when using ksock to reply to differents peers while
reusing the same UDP socket and generally works toward the goal of ksock
to support the basic socket operations.

[^1]: https://lpc.events/event/20/contributions/2430/

Mahe Tardy (8):
  bpf: improve ksock_kfunc_set LSM recursion filter
  selftests/bpf: Test allowed bpf_ksock operations at send LSM attach
  bpf: move ksock_connect() out of init kfunc set
  selftests/bpf: Test verifier filter for ksock connect on LSM attach
  selftests/bpf: Test ksock connect/send combinations
  bpf: add bpf_ksock_sendto() kfunc
  selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach
  selftests/bpf: Test ksock sendto()

 net/core/bpf_ksock.c                          | 129 +++++++++++++-----
 .../testing/selftests/bpf/prog_tests/ksock.c  |  53 +++++--
 .../selftests/bpf/prog_tests/ksock_sendto.c   | 108 +++++++++++++++
 .../selftests/bpf/progs/ksock_common.h        |   2 +
 tools/testing/selftests/bpf/progs/ksock_lsm.c |  32 +++--
 .../selftests/bpf/progs/ksock_lsm_verifier.c  |  98 ++++++++++++-
 .../selftests/bpf/progs/ksock_sendto.c        |  59 ++++++++
 7 files changed, 432 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_sendto.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_sendto.c

--
2.43.0


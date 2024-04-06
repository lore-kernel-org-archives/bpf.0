Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C583BBF3
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395225; cv=none; b=ndbBi/67Nrbpk3R/8pwpvi2s0iMGGzHiaMbOlFM5D32QF4F3/zn92Zd/BGoGZsu8PRnXYQtIG1ILdKQxXDoJGzoigR6EQEfsA5570v+ljsnWf+WJ0VWQfJy5iksjXuSmpBi923qwZOBFSITkDZSVkcN9ku5l4y/+WBAiaIMNsU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395225; c=relaxed/simple;
	bh=wls7Uj9lvj1C2cR+9fWVS8Sq79ZqlDYd8ckzjVd9vKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J3ubKM9Dv8mR+dJjyO7HjK13na4LsHsjxAovarLRjvqGQdsK6QfdvMJLJ67MwS7TEjwEskWaaq4F3PbESfWOANrpJiBC8Y0PKWHuWb3qOD+QPQLiqFOmLF5f5EeUtedDhH46elRJGwkG0NRseC3XtmTsB5bjp8G37nsQdS00t4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ef9SYQLw; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ef9SYQLw"
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B5EFB3FB6E
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 09:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712395213;
	bh=yx7vpzXIHTYh5j3nTDQp+mlNbiWJAYHc0w9red4g/BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ef9SYQLwE9d+6wxnMS9dTY3+PK8ZESj2CkVelEcmeAU8NfK4DVYC8fsj+gRrkgbix
	 v8QoZ1ejVRf52Mt6c6ehWNJ2rsOex411cVswKIOh7jIRInT9IApH3SaFvrRlNDGXgR
	 Toh6eVpW1CzRmkqkRFmFfB6/EXy5rZhPBy3uxtrDIf4WPnpKkTlQXDeMhGqGJiYjvT
	 DVyzHptc+EXw8/LPa8FtDRmWYfjE8L3aL2A982JlpyMXPPezABQrH999TZyQD+fHGD
	 EqM3hOfqgDeG26yBINMSKH+WOE9vDMDofRETxSI181D4kNyYg5rf0uht2Uw0lO2y4P
	 4RH6Kp9i+OMzw==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41489c04e3aso13581175e9.0
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 02:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712395212; x=1713000012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yx7vpzXIHTYh5j3nTDQp+mlNbiWJAYHc0w9red4g/BM=;
        b=PfeaxV/HpB6uW2BNi57NV8pujwhVRUiCVDdR1Z9um5R8Bwl1qoo/wd+PDFmwToEB3t
         MXAqWOf71BIxs7FwsFhwZFQVP+W4yFW/wSCHxgDv04K8p1Rb0r1Dyy0gvB4RIg37hwq3
         Dq6FqCzAx0W+b5h35MSGcGK4RRVvaMOq/3COHMazEhhsSAI11doUoFL51Lq7089edK46
         YLpQYj4qPifrBaEkXx9dsCcS65IW9fty8XVgLizYkoizKKMa11ruMzpk5h+Mudz0dYMA
         m98OWsv5XBxdcj4XjD7/wvY9zqUprsuR87DCQnz3pzjwfqyPLl0bcmqo1RX5CP7Dnq+z
         IxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8MoRTMVs1zbzb1qQow3DoaX+1UV5o7Fp3AKoHYOhjaMoyCPO3kxvaZ8OJO3mt/MFB346GNOkMO8e6Fzq18xmOfQq7
X-Gm-Message-State: AOJu0YyW3bgzJRYQJJZg4G+AtcbaxtlEbFxYBYAdFeq7s8D7YiZzHM+y
	+OL+L4hrfprZpxdw69kXOkaurKUe29qhC3sIve49rUek6z0+3XjbfY188tqjjr9Og9VhY7dL/0A
	97MTB6v/UMq2fMkZa6pCzhNKAJG90Sm+UFr50ObqQlJ6y6MXCYEfuYYrENdNnKiw6uA==
X-Received: by 2002:a05:600c:4e93:b0:415:691c:f83d with SMTP id f19-20020a05600c4e9300b00415691cf83dmr2852406wmq.33.1712395212478;
        Sat, 06 Apr 2024 02:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHit5kOPUjw5jx+vy2tg5jUYvea3lG9TQoPRZVf5aXYZyCaWrS8RAEXac+i+7u4IVkSCPt8Yg==
X-Received: by 2002:a05:600c:4e93:b0:415:691c:f83d with SMTP id f19-20020a05600c4e9300b00415691cf83dmr2852376wmq.33.1712395211958;
        Sat, 06 Apr 2024 02:20:11 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b00414924f307csm5779993wmi.26.2024.04.06.02.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:20:11 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] libbpf: API to partially consume items from ringbuffer
Date: Sat,  6 Apr 2024 11:15:40 +0200
Message-ID: <20240406092005.92399-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce ring__consume_n() and ring_buffer__consume_n() API to
partially consume items from one (or more) ringbuffer(s).

This can be useful, for example, to consume just a single item or when
we need to copy multiple items to a limited user-space buffer from the
ringbuffer callback.

Practical example (where this API can be used):
https://github.com/sched-ext/scx/blob/b7c06b9ed9f72cad83c31e39e9c4e2cfd8683a55/rust/scx_rustland_core/src/bpf.rs#L217

See also:
https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T/#u

v4:
 - add a selftest to test the new API
 - open a new 1.5.0 cycle

v3:
 - rename ring__consume_max() -> ring__consume_n() and
   ring_buffer__consume_max() -> ring_buffer__consume_n()
 - add new API to a new 1.5.0 cycle
 - fixed minor nits / comments

v2:
 - introduce a new API instead of changing the callback's retcode
   behavior

Andrea Righi (4):
      libbpf: Start v1.5 development cycle
      libbpf: ringbuf: allow to consume up to a certain amount of items
      libbpf: Add ring__consume_n / ring_buffer__consume_n
      selftests/bpf: Add tests for ring__consume_n and ring_buffer__consume_n

 tools/lib/bpf/libbpf.h                           | 12 +++++
 tools/lib/bpf/libbpf.map                         |  6 +++
 tools/lib/bpf/libbpf_version.h                   |  2 +-
 tools/lib/bpf/ringbuf.c                          | 59 ++++++++++++++++++++----
 tools/testing/selftests/bpf/prog_tests/ringbuf.c |  8 ++++
 5 files changed, 76 insertions(+), 11 deletions(-)

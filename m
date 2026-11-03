Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732518;
	b=S6hP2P7jtuZnlAoi8a6YGb2H02IHm8oR1IipQxpiZm6qGejkQYgFM36Cz7MobvVRdmk5
	 1YxhD2Jf9hnKeYnd7rQ1xu57hT8iN/ApYAtsmVj+ftZ4hZI/wYdRIhJBr9IEKJVL5YN6m
	 DDvKfvGw+OG8uQvqcYKweugNVZTiurbp7jZxDIUrKKoIgRMeGWr4LljMDVSDWlGGcSoI5
	 4//IW9We9cG8cPyZaiQhQguV0AQAvCh9hB84uv2JhhClc/4mzIkXrQI2JTC83wmTsEsLZ
	 XbW/nqKJVSD9eBTkLB78UXjIr61J1WXmVR0unQyjEuaOZ9PvxhEjdkuxBgho1VG6/sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732518;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:From:Date:Subject:To:
	 Cc:X-Envelope-From;
	bh=FJ4h+YnyaLgUIGCR3B3/vMguXn3tVihBsJl6Sia2pRM=;
	b=xfnSb5o5pq4bKkFx407ZXdTO6lUPOscchaywefiPlcsPXQmli4KdIRZ2a9g1EUIZ4bgO
	 s+uzSNj/AupJ2nGUht3F/6YTgwnKktJu0DHcbWQfeeuPvU+ARwgc5s1+sMFYEbdNvL8SB
	 yNcBcCWFfGNeXH0U7YHcnRWip2u673E5djNwWcruBJ379vbVoLqmgp/nPJOpARw0/JJPj
	 zXZFSq0sfeI/NUXfTeFhK9/uoOgyHHzl3KzNCYLClBGxioACDyDZW7cS0lTLi1jUY15S9
	 rPYdqcHd72XAvhOlnvhIuUI7vb34sWiDMiHqcowEQXxPNI+wE7xqQ43ikFyBmd9Jdeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=i6td7gWW;
	arc=none smtp.remote-ip=198.54.127.131
Received: from out-2z4y-a131.jellyfish.systems (out-2z4y-a131.jellyfish.systems [198.54.127.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A85606A32C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 19:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A85606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=i6td7gWW
Received: from [10.18.116.108] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jJyby1hG3z8sWS;
	Tue, 03 Nov 2026 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793732514;
	bh=FJ4h+YnyaLgUIGCR3B3/vMguXn3tVihBsJl6Sia2pRM=;
	h=From:Date:Subject:To:Cc:From;
	b=i6td7gWWnrq4zoMMCT/0W9ecYzKuRDVqGmoRt5Dp6YcC/10U6LPPXRgKx3pZlARu/
	 +bkT2Q2WwseVs2KpLelgp0xTbQFfr+pAe7jIFPEDFH+vQdcmgQJSeoWJ/ZBmBsV30k
	 ZWwWZOW3xFZMSUHXV3aynVTAdqq61qKwjvJ6pPTQuy008a9cRr1BQ20V2yFPgHzjWT
	 tR4rbb2kyYzDgtWlZjSunpqJ8te6TAgyK+76LEJuK10sR4Mf5SIAL9QdRE3eTb9W0k
	 sF0RWgWyVn0CGtWNjV4vk1PAP/bCw65S4VgdvoOW0Xw0GFeN/9gP2G6Clb3cWJgFco
	 9/Qu3NIZwfhLQ==
Message-ID: <cover.1793732386.git.hi@tychen.cc>
From: Tianyi Chen <hi@tychen.cc>
Date: Wed, 04 Nov 2026 04:01:49 +0900
Subject: [PATCH bpf-next v7 0/2] bpftool: Batch hash map dumps with bounded buffers
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
    andrii@kernel.org,
    eddyz87@gmail.com,
    ihor.solodrai@linux.dev,
    linux-kselftest@vger.kernel.org,
    daniel@iogearbox.net,
    ast@kernel.org,
    hi@tychen.cc
X-Envelope-From: hi@tychen.cc
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Rebased on current bpf-next, retaining Quentin's Acked-by.

Changes in v7:
- Use the upstream error formatter for batch failures.
- Refresh the matched-base timings and syscall counts in patch 1.

The 12 batch tests and both upstream non-iterable-map tests pass on
x86-64 KVM with Linux 7.2.13 and 7.3.0. All 33 focused subtests also pass
with the map-info/recursive series; per-CPU fallback output is unchanged.

v6: https://lore.kernel.org/r/20260925174412.2028749-1-hi@tychen.cc

Tianyi Chen (2):
  bpftool: Use batch lookups for hash map dumps
  selftests/bpf: Check bpftool batch map dump contents

 tools/bpf/bpftool/map.c                       | 123 ++++++++++-
 .../bpf/prog_tests/bpftool_map_batch.c        | 191 ++++++++++++++++++
 2 files changed, 306 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c


base-commit: cd5bc55288d4fd999595c8f2af6a5408cbe92a52
-- 
2.56.0


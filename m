Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793792281;
	b=ePvYPSskbqv5tBJDjOGULzcERHf7DvtpsHW/yZTEPq5Eup/YPxDeEGpuTib7nRgeTI1C
	 eqwHlt53jBJc/MTUr3J54Ui8WlP37Y8abif6MQumbZgC3JC6UC8XoA3hwJDGxsob3gY5R
	 PlR8qCwsbyaLc+O7Pm5Y06jFm5s3cryBd92Yi7WGbfnXMCuzO2SJVThqJ2HRG2XedMyb1
	 Y4HpqkQx/fV3DXVi4oHDbKTBuAKRLU7OtqgL1WqqvvTAb+tWbWgA9piQ2Fd/SNyEIOS3e
	 5aagbBsIiMHv3xYG/dRI2/AxuYCE1UFcfKAHbHjAow1bnhB72FhvrkKD6R9o8id/bow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792281;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=i4o/1Ov+Rk4PSAZfblqY+qRYIgcMzFlXPluPXC1UsjY=;
	b=zmWYK6okbBVdYHo+pR5oomYQmlTxoeuXqqQl2QvM7Y6BFNRNuQleY5nI8gyxMSqX8Y3p
	 YIncDOpH3XiUzMNX9si6fFo/vecaRsweABcCPjMkrxzskn+KgntmnsqsvwQxWihdFTRpU
	 m8rtsZI6SpKbeL3b7jymxQM5slrO25iHdD9RYlgLwp2U1Zz1jL9FKIwdbMBj4IplhO01m
	 Dp5S/vhEXIgpcGfJM4BqKTlHLSs4FO1hCCWU+1x9CPVjI8wgH4opYlIbqIyAdOoVjxtsL
	 yyxCnCs0kV/11CISeV/JIO3oijoOFwNOvZR36S+3sjjL0OrzXF5dF0J2Xt/3LAfNluQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBxr1yhv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A36606A332;
	Wed,  4 Nov 2026 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBxr1yhv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793792281;
	b=jWQpCriwAskY/KjBg5g5XhDo3wzqodGqf1GmHkdA/0fWU9ByL1fjlqAHmcLSL74Y7xMh
	 iZEtAoxtuJyoqbD+AwirUI/kcTTGVtE3oBc+qj2CUHURFlW7zrDNY54qqRKCtnrOPTbZL
	 g9lBJfFVrhxXOVHBXcGtk9qduKqd6Pu0/4IdzVe6j0PzL9VYnwvf1HrQ0O3qAf7zlbAGD
	 54hyFjhEXR/AqSh3dqSzVaSIzhhJDYO5CujYJT7Tf4lsiRNVGMo1al4ytfmWAwIq73xVt
	 0NXeDnaI0ZvCzk5OMqTcEWqly837MubYbsW3j6/L88bpKJJupt52mjXpkLaBdcJZ69w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793792281;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=i4o/1Ov+Rk4PSAZfblqY+qRYIgcMzFlXPluPXC1UsjY=;
	b=nUKLNZ40qcq6i+GpxrLJL3HKlIABNCLaF6iMD5IiF3hPSIv0ykxD2qyvdBBquLcxakeL
	 4W6Y1alk/mVi2H1vOoAsg+ZZpPGCrykj+L7n5UxsZUDr0KuG3AxFWPcAFLW41y0QQo8zY
	 7d6IhuxPwDMqXSjO//NgK3keZK4Y47OIYYBqiDuszrtjbMO/MoaG8m86WXpfPWMRAGHjm
	 3G+b/nDHAgiz29g0D7JodvEzg2ZlMFIBT9F0Z4C+AEOl0GkU9znz0tL3M5bwZTVcrpEIJ
	 bKZ6mywLljPaTK8qoD09jlA5scbGykYbtJZae2m0zObmNHFQydN/TdSC5jdQ6osSDxQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A5E111F00919;
	Wed,  4 Nov 2026 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793792281;
	bh=i4o/1Ov+Rk4PSAZfblqY+qRYIgcMzFlXPluPXC1UsjY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=nBxr1yhvpdWcKBD0Gmn6Hehj3DhnKK3TvpmTj+16u6NhviH1GEh9zF7C7KCD5XFuM
	 b8v4DhCGJJvzUpVyVc/2ZKVg4Wp0+o77OsNpuvuSbsFQCxW8qTALDXvb4n1nxloxwh
	 ttunfDURxhhNaAV/IrYqqkb/bYZgjDFaOY5Sbu+yGLCdPtQLHYF1hjHAC3gh0FlsM9
	 haSY63xH4MrOdthC6WNDjHQJWcLjfhjreRCnuHKsFmAUocrHYdp0f+/S4TsLvbz+XH
	 2kETG401XNvYGGHtrOUfA4cgvBqW+uOiHK9I7+gwNszY8mrqsDScTypcT0ze1gDM/r
	 DNPY/yd8DTWYg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F352246DEF;
	Wed,  4 Nov 2026 11:37:59 +0000 (UTC)
From: Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org>
Subject: [PATCH bpf-next 0/2] Limit local storage value size to max
 kmalloc_nolock() allocation
Date: Wed, 04 Nov 2026 18:37:56 +0700
Message-Id: <20261104-local-storage-max-v1-0-c836731bd184@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkErivpKdLBtrYXS0Agh+nvSc
 RhmHogchCMMxQOBb4niXQZdFkCbcSujLJmhUlWrtWpw92R2jJcPJsvDJKS6U72lpbUzQe7OwFb
 S/xxhPi06ThdM7/sB9RsjSm0AAAA=
X-Change-ID: 20261104-local-storage-max-c3709fcd6fbc
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Amery Hung <ameryhung@gmail.com>, 
 Slava Imameev <slava.imameev@crowdstrike.com>, 
 Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793792278; l=1220;
 i=thamrinjonathan@gmail.com; s=20261102; h=from:subject:message-id;
 bh=7tD517TNGR3Xl9ZhLbA/MFMMtT5aaAkfnZnVLX73hmk=;
 b=BTjv2wvo5BWzwx918zqZt/0lRYf+OY3GGArIhxuadr66khkgWOYChCNRIt5GSWBeo9az5Vlkq
 IzS0MoJgwM/C1N4drlaatguxem7qKp38vJMK7tgaLY+YI/6rDQzFvAJ
X-Developer-Key: i=thamrinjonathan@gmail.com; a=ed25519;
 pk=mr0q5PZVaUIrv8WvTxIfK7QVcAiRSYI8hOByBQL1ZRo=
X-Endpoint-Received: by B4 Relay for thamrinjonathan@gmail.com/20261102
 with auth_id=1383
X-Original-From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Reply-To: thamrinjonathan@gmail.com

BPF local storage elements are allocated using kmalloc_nolock()
but map creation is still allowed with values up to kmalloc()'s
larger limit. BPF_LOCAL_STORAGE_MAX_VALUE_SIZE is changed to be
based on KMALLOC_MAX_CACHE_SIZE instead and maps with larger
values fail on creation with E2BIG. Cgroup storage
(BPF_MAP_TYPE_CGROUP_STORAGE) uses the previous limit since it
allocates with kmalloc().

A selftest is also added to both find the largest task storage
size and test that this value can be stored. It also checks
that the size is at least 4096 to check that the limit isn't too
low.

---
Jonathan Bastari Thamrin (2):
      bpf: Limit local storage value size to max kmalloc_nolock() allocation
      selftests/bpf: Test local storage max value size

 include/linux/bpf_local_storage.h                  | 10 +--
 kernel/bpf/local_storage.c                         | 13 +++-
 .../selftests/bpf/prog_tests/task_local_storage.c  | 87 ++++++++++++++++++++++
 3 files changed, 103 insertions(+), 7 deletions(-)
---
base-commit: d346f59069676eda84b3313cbd2c2ab21045d3ee
change-id: 20261104-local-storage-max-c3709fcd6fbc

Best regards,
-- 
Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>



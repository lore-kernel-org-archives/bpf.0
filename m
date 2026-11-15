Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794738422;
	b=oUTe9DM5NDpuGv5xt/BWbFx3fNYyNIi+oD2JEGi6W9UnTS7vLxtXEZKN8Dni4IKYaI/U
	 moVFVjU3ihhrvZQxl1TnRMpNjYpGcSwKlyAqJPEMYSgAPJogID43yxTUiY7Gpr/sFAoEK
	 5MdF80A4ox0On3pqJTllNllOQW04yNyr1njZkw2r/n/ES5qgUaDK8m0m8ph4En11FGOrb
	 u3xzY9f/ddjG0gZ52EefjpFCVCsJm/7lBwfGs6p7rpYv4Sq0CEzVJjcUOAnyV6HXACUH2
	 4FyuOuA5pXpKBEYV5YTBMcox+V9qV+i52sEFkERkPmVy6ysCWIYhxX+jwZWqV2fiMZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794738422;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:Sender:X-CM-SenderInfo;
	bh=1azWyhbD9K52O9zP67BPxVg08oy4qhI69qmDlV855Hg=;
	b=ntFx1EUq34rQzz0U2SyoyCqV8YEHWLXy4EQ1Mca7UyZr0NhdfkE2Q39gVHMJN5jZkzra
	 kIdlQftxB2mDpFobHtz1zPKB2/9fSNM5dbWs3fI7pJE7ywstjcMbYuT99mwFyJh+0YtMj
	 HSCDUIYFrwNstOlDnk+tIg0//OsfhN+APHsIfYMs0KQCflN7b4+h6PNtFNDkroBouNeqT
	 /zpQEVNQ+wKYRhf8Qx2da1A+uXoTtwTRHHz3/ocEXDn9bacq2GDOAYIA1jKo5QeqZKlbh
	 d0H/eVquk9n/F3vUSVrq8ke5LllAnkpYjt9YpejjmZjpelLSoJiMkIHbVzlwQPv3OGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=azqiNrDc;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67885606A31E;
	Sun, 15 Nov 2026 10:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67885606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=azqiNrDc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1a
	zWyhbD9K52O9zP67BPxVg08oy4qhI69qmDlV855Hg=; b=azqiNrDchmfxqCncY8
	zL+iBeSsl2dUTJmpG5X1P1kurzY8yzH2rb3OxBmNwhN6BE6s1kWE8oL2ts9ZmAzS
	YCoPleTDznK81DD/2+gbfZNwlYZX18QNiRGdH4icHNLsRskTN0EaX+ck/7qRO9Pn
	srel+EJHyBtqLt6UVwuZzYyO8=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3X7S+iPlqHVcuGA--.3517S2;
	Sun, 15 Nov 2026 18:26:08 +0800 (CST)
From: Yuan Chen <chenyuan@kylinos.cn>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next 0/2] bpf: Fix the array map gen_lookup index bounds check
Date: Sun, 15 Nov 2026 18:25:57 +0800
Message-ID: <20261115102559.465375-1-chenyuan@kylinos.cn>
X-Mailer: git-send-email 2.54.0
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
X-CM-TRANSID:QCgvCgD3X7S+iPlqHVcuGA--.3517S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw48KF13Gw18tFykJw1kXwb_yoWDAFXE93
	yqkr97Xr4Yka4jqFWI9r1Yy3s3Ca1UCFykAFykXr17Wr4rXF45Cr4kCFykX3s7GrW3Xr93
	Zrn0qa4Ivr1j9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8wa93UUUUU==
Sender: chenyuan_fl@163.com
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5QFrKWr5iMGXSQAA3i

The inlined bpf_map_lookup_elem() of the array map flavors bounds the
index with a 64-bit JGE against map->max_entries.  The index is a
zero-extended u32, but the immediate of a 64-bit JGE is sign-extended,
so for max_entries >= 0x80000000 the compare is never true.

With bypass_spec_v1 the inlined code then addresses the array out of
bounds; without it the index_mask AND keeps the access in bounds, but an
out-of-range key returns a masked element instead of NULL.

Patch 1 switches the three compares to BPF_JMP32_IMM().  Patch 2 adds a
selftest that checks the emitted compare in the translated program.

Yuan Chen (2):
  bpf: Use a 32-bit compare in the array map gen_lookups
  selftests/bpf: Test the emitted bounds check of the array gen_lookup

 kernel/bpf/arraymap.c                         |  12 +-
 .../bpf/prog_tests/array_gen_lookup_jmp32.c   | 204 ++++++++++++++++++
 2 files changed, 210 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/array_gen_lookup_jmp32.c

-- 
2.54.0


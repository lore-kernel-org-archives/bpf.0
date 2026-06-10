Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1D3C108E;
	Wed, 10 Jun 2026 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103110; cv=none; b=hDDiHYNXeiM6JIibC1U/jcz58TTU78y5yqy38YUqUUbz/cX12XGQfqQ/2XC7svr0fhN0mp3nbv2bldQcb97M4ZHOL1VWZ2MrfHfvlSopehoNllsxP+6DIJsXuvWdvZJ/6es/4R02J/v4teWzUSqESKVUmjXQdfj/1LgrL7XkfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103110; c=relaxed/simple;
	bh=k3j7haDiPWx2r/WuDA82ddibQxZP8kDNU4t+BEqEEzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHmKtm9fzy8QnYLV/2WwHukTb0rb4hSZUdC0i3tOkVLl4lxQPqzdQl7LARQnHT+OHxeWRm+2eqQLN0jASrq22nvQtOaAT3DZ4AIIqywCQ9rQSkDHG6EJWm13DdMustbD2oja89HKldjerkT3Sz3VOhROHQBWShjk/L3yEKY/buQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XfdJnRKK; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XfdJnRKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=lCbifsVtabst5GWFE1KDmho5S3ZBJefm4Y8R6wyfo54=;
	b=XfdJnRKKchrNw7FbN7Jfv5xxdCRPLQzPfSDUqowqaRpYspn7JEn7yxP4BJPIVb
	C0NJ28Gzltu2fejEHgpZknrPMwq6BqN9bezzGwLEGV25qoRHl4e3854hLmPAlCDI
	VfnDWSdivMKZmKX+HygVRC8UMqFtFrnB5CIylCRwV//Gs=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3sr_ZeSlqaWzoBQ--.16220S2;
	Wed, 10 Jun 2026 22:51:08 +0800 (CST)
From: chenyuan_fl@163.com
To: chenyuan_fl@163.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	mykyta.yatsenko5@gmail.com,
	andrii.nakryiko@gmail.com
Subject: [PATCH bpf-next v3 0/2] libbpf: fix implicit BPF token feature probe failures
Date: Wed, 10 Jun 2026 22:50:52 +0800
Message-ID: <20260610145059.113412-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604031033.806727-1-chenyuan_fl@163.com>
References: <20260604031033.806727-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgC3sr_ZeSlqaWzoBQ--.16220S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1UWrWruryxZF4rAr1kXwb_yoW5GF4fpF
	Z5W345GF1kJFyIqws3Jr4Uu3yF9ws5Aa1UGr9Iqw13Xw4jgay8Zr1fKa1YvF1UAryF9w1Y
	qFyYvF98Cw4DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pizpB3UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5hx6OGopedxCBQAA3Z

From: Yuan Chen <chenyuan@kylinos.cn>

v2: https://lore.kernel.org/bpf/CAEf4BzbbmTFaNjT4bRTEm3BxAROkRrTdfxwPNy9HmMt_LFaSHw@mail.gmail.com/

When BPF programs reference global variables (e.g., struct_ops
programs with global data), libbpf creates internal ARRAY maps to
back them.  This depends on FEAT_GLOBAL_DATA, which is gated by
feature probes that load test programs (SOCKET_FILTER, KPROBE, etc.)
into the kernel.

In a user namespace with an implicit BPF token, two problems arise:

 1. bpf_object__probe_loading() passes the token fd to test program
    loads.  When the token's allowed program type mask excludes the
    probe types, the kernel drops the token reference, causing
    subsequent struct_ops loads to fail because the token object
    has been released.

 2. Feature probes hardcode SOCKET_FILTER/TRACEPOINT as the program
    type for their test loads.  When the token restricts program
    types, these loads fail and features (FEAT_GLOBAL_DATA, etc.)
    are incorrectly reported as missing, so internal maps for global
    data are never created.

Together, these cause struct_ops programs referencing global data
to fail verification with "fd X is not pointing to valid bpf_map".

This series fixes both issues:

  Patch 1: Skip bpf_object__probe_loading() entirely when a BPF
           token is present.  Token creation itself proves the
           kernel BPF subsystem works.
           Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

  Patch 2: Fetch the first probeable program type from the token's
           allowed_progs mask instead of hardcoding SOCKET_FILTER
           or TRACEPOINT.  When no probeable type exists, return
           success (token creation proves the BPF subsystem works).

v3 changes:
- Drop the selftest patch (ARRAY map type addition) — no longer needed.
- Patch 2: implement reviewer's suggestion to fetch the first supported
  program type from the token instead of blanket skipping.  Use an
  18-type probeable list of types known to accept trivial "return 0"
  programs without specific expected_attach_type.  When no probeable
  type exists (e.g. only STRUCT_OPS), assume the feature is supported.

v2 changes:
- Replace the workaround of granting SOCKET_FILTER/KPROBE permissions
  in the token with a proper fix at the feature probe level in libbpf.

Yuan Chen (2):
  libbpf: Skip bpf_object__probe_loading() when BPF token is in use
  libbpf: fetch probeable prog type from token for feature probes

 tools/lib/bpf/features.c | 97 ++++++++++++++++++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf.c   | 10 ++---
 2 files changed, 93 insertions(+), 14 deletions(-)

-- 
2.54.0


Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DA439A07C;
	Sat, 20 Jun 2026 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970447; cv=none; b=pHg3HHSq2+YLmuEzttiWN2ZEYjN5vLGoeWJ2+ElTDP8ZRmous9WPJc2huxcRFnEVv2sVvMJS31WNewrsbX2Lt6DokoLOFWUrV/5TApC0dmK6B16YTDVaJHSDbVOuJaIaDiU+6LSBUhSlDWW7K2wiZ2uUxw4tVUjcEfoNSbaqP9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970447; c=relaxed/simple;
	bh=aA4qviSg78eePkv/mSeEzpHk8t8YHzBmMzxLafSjEbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JAIon5tR12bMdvTJllpsx/9PVKZD6+u+SMx7u/fAVjKTqJgzvkiu2DpCXzp1DT3PC8yrsV4n13+MzTDstyA7WSIeX76WxcA+DnYPjO4Q7ruSBpI8gc+gBgxdqKWb5lMfmQ3nsH8NlR8UtKiKG5nhFYx92ABKn/NEwCJwhq2dDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=LNZg19jr; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="LNZg19jr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=EZbOCfzydTtXuw3QTDn7U6GR26rAzEd
	n1xzzQrw/Q3w=; b=LNZg19jru3q5ZcKEVGBgwQsTu9u8m9GJxO3ccX3yysAw9QZ
	xStb6JP40Vuh2E1h3bMRMviOnuDTaOs38DRiZjooz8+R9NMM2j+PSvcmi8pub9m0
	SFqb4zmNNsGVx4zZf+q7TF1AjZiYh8XduuO4gj5QVm+CeiDHdjriNlD0vhXs=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCHY5v_tTZqCNRtAg--.19521S4;
	Sat, 20 Jun 2026 23:47:12 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sat, 20 Jun 2026 23:47:10 +0800
Subject: [PATCH bpf 2/2] selftests/bpf: Cover bpf_get_kmem_cache() null
 return
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-f01-16-kmem-cache-ret-null-v1-2-c146154a2816@mails.tsinghua.edu.cn>
References: <20260620-f01-16-kmem-cache-ret-null-v1-0-c146154a2816@mails.tsinghua.edu.cn>
In-Reply-To: <20260620-f01-16-kmem-cache-ret-null-v1-0-c146154a2816@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781970433; l=1401;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=aA4qviSg78eePkv/mSeEzpHk8t8YHzBmMzxLafSjEbQ=;
 b=jhA1b4kowIaZnozamwqxKKm+iinTWM25WGU+cOKWcN6qPrfvcwqdaYMAtLnVWh04lTPs8BhU6
 EWMQmmGaDTTDclTqaJ1lMEPSxCXxZsVDvb2tXOJkmfE2oUW/L8bc3mU
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQCHY5v_tTZqCNRtAg--.19521S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1kWFW3Kw4rJrWfAw4ruFg_yoW8Gw47pF
	1xGryakr1kur47Gw1fJF4DZF1rWF1kAFyUAa1Ig3W5ZF1kZw4kJF48GF1UWry5ur95Kw4S
	v3W0ga4ruw48Ar7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
	4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU8EAp5UUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQIEA2o1wTCydAACsu

Add verifier coverage for bpf_get_kmem_cache(0). A direct read from the
returned kmem_cache pointer must reject because the kfunc can return NULL,
while the same read after an explicit null check remains accepted.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 .../bpf/progs/verifier_kfunc_prog_types.c          | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
index 1fce7a7e8d030..a062f3b7bc756 100644
--- a/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
@@ -168,3 +168,32 @@ int BPF_PROG(cpumask_kfunc_perf_event)
 	cpumask_kfunc_load_test();
 	return 0;
 }
+
+/*********************
+ * kmem_cache kfunc *
+ *********************/
+
+extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym;
+
+SEC("raw_tp")
+__failure __msg("R0 invalid mem access 'untrusted_ptr_or_null_'")
+int bpf_get_kmem_cache_no_null_check(void *ctx)
+{
+	struct kmem_cache *s;
+
+	s = bpf_get_kmem_cache(0);
+	return s->size;
+}
+
+SEC("raw_tp")
+__success
+int bpf_get_kmem_cache_null_check(void *ctx)
+{
+	struct kmem_cache *s;
+
+	s = bpf_get_kmem_cache(0);
+	if (!s)
+		return 0;
+
+	return s->size;
+}

-- 
2.34.1


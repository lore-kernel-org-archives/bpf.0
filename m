Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413498;
	b=gEYXqEkbCHNq7xnbsQ6/54AiTfwzCCba5geiwlboQxaXAe7g7xuci/trJf0wt8sjT9ai
	 bX1KtLDUZUKY077H9PFH+4ra3ro4Hd9GmrSOONPlb2F/jod8rPoISifGdr6Rc0FQlDZrZ
	 xQ3LHwaYrPPNExuQFezZayvYfEzAhcouZm782vvHAhI1nH6YngzuXSRnTJgbiCbzQhNUm
	 TtWP4jRVpjwSyCS2eKr0RZTi3mzWmJH+MJIYs4C0Xm11eGB8yIfv7lVfc60OVuvIELLBk
	 mioRH/6gDaGoQbxkrjdd4XE0Cfwy3IkPMUsFVJFJ4ODsM2uuTX0AmInHHsokkovkAOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413498;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=BBNEfQ40GCfRqMHJsYNRkcOVwGniksg/Zh2UT3SHlZE=;
	b=0TWHaaMnmJFuW4njujsBRkkM16SLkC7r6ZFZ41BzSnz3uICmuy/csw7foF58JwUEecs2
	 7E0nQ3+V6qQrhaSXHFnLm1Yh+ZUEAr8WLA8jz4NrxsdNTVpbV7O0leDIXO2I7gC3H9sR3
	 Rh4YYH4zw2ld7TMSNwByXFZ2VG9Ex1my97/xvB83P6TKiyIMRNsKKPNxahkix3ArnoXt6
	 4aLBYyKYVeUrNKaY2E6+B1529vZ6AikrhoT2NIsWcEgt/p+GTLageN/u28Ew893TMMYHb
	 zS+GHdgGwN0/UBk3ynG5IX6UXnu7quXoCcFlfcWX1JP1o9pGmJvHpDLZofn6FrVcpng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QFQvh8Fu;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368C606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 05:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B368C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QFQvh8Fu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=BB
	NEfQ40GCfRqMHJsYNRkcOVwGniksg/Zh2UT3SHlZE=; b=QFQvh8FudD6HwjuZYM
	CVJp5sI/ErwZNpEyXOlLQ/uBKZhwScM+o0VcCiwFG/ZkekCgHqjUvtfkGdMGejJM
	y4VIhFVoqHFfc/TwpX7u/rZNsxppGf8exWjZyi1TyB5Lm/cBiuC19DdBgsMh5aNF
	4gqreVVqMrspn5ecGq8GiF/t4=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3dzy+1QNrMgTmJg--.22062S4;
	Mon, 23 Nov 2026 13:57:25 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	ihor.solodrai@linux.dev,
	memxor@gmail.com,
	nirmoyd@nvidia.com,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v7 2/2] selftests/bpf: strengthen bpf_kfunc_implicit_arg to verify aux injection
Date: Mon, 23 Nov 2026 13:57:08 +0800
Message-ID: <20261123055708.684107-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123055708.684107-1-chenyuan_fl@163.com>
References: <20261123055708.684107-1-chenyuan_fl@163.com>
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
X-CM-TRANSID:_____wD3dzy+1QNrMgTmJg--.22062S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW3Cr1DGr4xCFWUKrWDtwb_yoW8Xry8pa
	yxJw1jkr1kXa17XF1xGF48WFWrGFs3XrWUJF4UJ3sxZrs5Xw1SqF18KF10vFnIkrWFq34f
	Aw1SgFZ8u3y8ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4PfQUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQVCAGsD1cVjwwAA3e

From: Yuan Chen <chenyuan@kylinos.cn>

The kfunc_implicit_args selftest calls bpf_kfunc_implicit_arg(5) and
expects 5.  The kfunc only checks that the implicit bpf_prog_aux argument
is non-NULL, so the test still passes if the verifier fails to inject aux
and the stale register happens to hold a non-NULL value.

Verify the injected pointer by checking that aux->prog->aux points back
to aux, which holds for every real bpf_prog_aux.  Do not match on
aux->name: the tracing selftest calls the same kfunc from programs named
trace_implicit_arg_*, which do not share the syscall test's name prefix.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c     | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1906,7 +1906,13 @@ int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args, struct bpf_pro
 
 int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux)
 {
-	if (aux && a > 0)
+	/*
+	 * Verify that the verifier injected a real bpf_prog_aux instead
+	 * of leaving a stale register value.
+	 */
+	if (!aux || aux->prog->aux != aux)
+		return -EINVAL;
+	if (a > 0)
 		return a;
 	return -EINVAL;
 }
-- 
2.54.0


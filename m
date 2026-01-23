Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67691299949;
	Fri, 23 Jan 2026 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189959; cv=none; b=BtfhSVdZxYb37d/AEnaBYas7rkdtfnic1asay/qv0tHDz+r1bnZbjw0uh9QLER98HBeSyRS0B+vxNiYIcCEfkL7juEqR0AUvucWnexANQXROcyJhL84Q3b4Al8yE8JTJGtiPamNhIhRrqhmwR5MHc99YF/kMev1ZLsffgxfDR/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189959; c=relaxed/simple;
	bh=aCQJ96HF6HX3gxo1ZlOC0iMZDoBqkwV0MdFHkSm3ac4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQOln8nqDmRR+SOWBP6WgEbiLnC6kjWkUIfogMW33cnpD63bIUqiACDLSijCwkAIHO5OkM8RB5SG3X1DRVMqGlCPbh9fvQchFqgQNBa+qMu/QS49uNLswPj84brk6v17wLoPkHpVlCszrt4pF/qS2NAxJKbNa4c4RV6SiYjM+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ebqpkC8s; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ebqpkC8s"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vjJpZ-00F9BQ-HF; Fri, 23 Jan 2026 17:16:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=HKiyxtYlIkooF5ZOJyoVcBXDsKz43U5zXOTINvVN0OA=; b=ebqpkC8sGKeUJs8cePNUFvhNTH
	pyS/00y4Ybjd7vwQohOm6TtQMT4Qd40wPQ74j7PYIFxSyCLm0ONeIhqVEbvcDIXaiKmyUkxWB0LNh
	CrWVao+648L42KLkp68i4zPaOQNYzKXDdAxq37TWZGNEeCs84fqoRbql1opKZPWnCB9SPmOLMi/l8
	gjEO6gredzOpTHYRR4tyL1V4Ne7g6D1+EuVK8dctyHA52J54DS6rtiy5IEuH1F2kWw57mB7VC/pgI
	sTjrWokKu1eQAKJeuz7r+LhXgmG2h5D0w86XxFGSTXx9Zc/2Z5qUv5G1NyGATq4bHzWYGVVLHlIfK
	7eJwwuyA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vjJpZ-0002eg-3L; Fri, 23 Jan 2026 17:16:17 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vjJpK-003pZ3-UE; Fri, 23 Jan 2026 17:16:03 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 23 Jan 2026 17:15:56 +0100
Subject: [PATCH bpf-next 1/2] selftests/bpf: Add xpthread_cancel() to
 sockmap_helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-selftest-signal-on-connect-v1-1-b0256e7025b6@rbox.co>
References: <20260123-selftest-signal-on-connect-v1-0-b0256e7025b6@rbox.co>
In-Reply-To: <20260123-selftest-signal-on-connect-v1-0-b0256e7025b6@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

Thin wrapper reporting failure, in the spirit of xpthread_create() and
xpthread_join().

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index d815efac52fd..209f2e4fb627 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -60,6 +60,15 @@
 		__ret;                                                         \
 	})
 
+#define xpthread_cancel(thread)                                                \
+	({                                                                     \
+		int __ret = pthread_cancel((thread));                          \
+		errno = __ret;                                                 \
+		if (__ret)                                                     \
+			FAIL_ERRNO("pthread_cancel");                          \
+		__ret;                                                         \
+	})
+
 #define xpthread_join(thread, retval)                                          \
 	({                                                                     \
 		int __ret = pthread_join((thread), (retval));                  \

-- 
2.52.0


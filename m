Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3D25777
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740002; cv=none; b=jaBUsS1w029yNIUzL+adicdenjMvV0rVl1YUXddnURjWieianhYJfTrw+2AmAgpIunz+fTtcoXLbnT9q10Ksl3bQIg2TQrag7eUOXVv73cba2DkjKeFM9Bm44MmJslv9G9Z4XcJX4yNCN5PBMjvafw270XwSGkWhimRsdJTRZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740002; c=relaxed/simple;
	bh=X1TbuMHoleP7CfuoPSPY5DaocW44cFI3B40G/uoR0EE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JxdSajbRxiQhKseHSFn3gH5nZhSXSDB0ts+XQmYh+4bdG5oIsJH2Lu1w4NV9HFQlaEcrSctgld/9nh5cIoRyM5HR6TQnKqSrAM+LSAP9EKydgiHB6oxZS7ea+piuo0X+wBN/mNdSk3kMwG4ROs3IPJxXvYrtKlzGCW2Vuhx2doY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fntEcFJt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fntEcFJt"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dced704f17cso3902287276.1
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 12:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711739999; x=1712344799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GxOJxV7C93f80JjMcGj5DhuREG1NQh5Bl14os2SU3XM=;
        b=fntEcFJtlvA5XsbBc+IFXpOLVMeQtfuXfKqLdRZ/yc5e3HJiUez4L1vt4E9ql+wZ3Y
         df5hgjHSfsBLm9NBzidjXyezQ62mzLpplwlwf29E8cQ69q+n7L9wCgVknoixOaoqNg1T
         zqVK/Uk6NmIj640xSuTlZg8Ef72tKvVk6d1dAiBPy1c/u0rUkhZqu2t7RKxuMywyHZoQ
         nzZU49nD+6c2ZjQyo2lPuveCs5XOMGkxm/q8BHE1HiBR67INTKsd2UGD4JNxuCiOaq2d
         ikou/GfWc6kvb9CJQV2Iz+lK3//vbSPqPcS61C2WJTJaDk2P/T5ukCEGfXEIQyk0bzr6
         9Tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739999; x=1712344799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxOJxV7C93f80JjMcGj5DhuREG1NQh5Bl14os2SU3XM=;
        b=fXlSsoIYkNUWaQi6iTENGP5fjMMXjkkTrQOhhct1LAwEr3jx2mK7u+Fct5eBjtCJLV
         01PhS1bjStEbqt1xKeZVYYI20KJuSbXgsUeY2VWf0kXl6BTh1K9uETDnCW8LunezlbA+
         mBONsGZvcjc8+l1e4nj4OlnVN7r+hX/bS6zpfehY1D2y4JHY7piNr7WMkm4LbT9zjuaV
         T44gWS5hqoN+5WVk+KRc9iCBMB4OMfXOvDk9sli8Uftrf/8cqBf/nxsW2+nOQT1jAXWj
         rav09/gnnmi85B8nDEpD+nTkICFQ/bF/oj7Pp2yL5J4/++lMWSMLqL6pPYcyUGxHFUPB
         +tHA==
X-Gm-Message-State: AOJu0YxCY++kSq8S6D9v5URyfWbOQjtybLr3nPEiVX3P1Mbq2FHTT0kz
	OeANCfd68TsZV+/D9ayikgZcw/0bEjuk3J7IR1fP+sI1ypK8WyTEJZKipNzLcScvTWTzQ+wtDpy
	1IvcnOq1BBMCXcg5QlcTrO5ZolYkQ4yQSTSzvCmAFQQ4skCGk5cdKjsDh+EhdPHtpw/pMVWV9K6
	fpYhAz4Q0Pd7lP1+DuCzkSuVs=
X-Google-Smtp-Source: AGHT+IH2i8Os2O9p1v2f6xqox5g0brFwHzIYIqzJjgFXwfBLBENk4YiWQ9985pU5BPfz5rHyoZOonZ1Q2Q==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:1006:b0:dcc:94b7:a7a3 with SMTP id
 w6-20020a056902100600b00dcc94b7a7a3mr254520ybt.12.1711739999404; Fri, 29 Mar
 2024 12:19:59 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:18:48 -0500
In-Reply-To: <20240329191907.1808635-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329191907.1808635-4-jrife@google.com>
Subject: [PATCH v1 bpf-next 3/8] selftests/bpf: Factor out cmp_addr
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Factor out cmp_addr into network_helpers.c to so that it can be used by
the sock_addr_kern test program.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 34 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  4 +++
 .../selftests/bpf/prog_tests/sock_addr.c      | 34 -------------------
 3 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 6db27a9088e97..8eae4afe3ec3d 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -497,3 +497,37 @@ int get_socket_local_port(int sock_fd)
 
 	return -1;
 }
+
+int cmp_addr(const struct sockaddr_storage *addr1, socklen_t addr1_len,
+	     const struct sockaddr_storage *addr2, socklen_t addr2_len,
+	     bool cmp_port)
+{
+	const struct sockaddr_in *four1, *four2;
+	const struct sockaddr_in6 *six1, *six2;
+	const struct sockaddr_un *un1, *un2;
+
+	if (addr1->ss_family != addr2->ss_family)
+		return -1;
+
+	if (addr1_len != addr2_len)
+		return -1;
+
+	if (addr1->ss_family == AF_INET) {
+		four1 = (const struct sockaddr_in *)addr1;
+		four2 = (const struct sockaddr_in *)addr2;
+		return !((four1->sin_port == four2->sin_port || !cmp_port) &&
+			 four1->sin_addr.s_addr == four2->sin_addr.s_addr);
+	} else if (addr1->ss_family == AF_INET6) {
+		six1 = (const struct sockaddr_in6 *)addr1;
+		six2 = (const struct sockaddr_in6 *)addr2;
+		return !((six1->sin6_port == six2->sin6_port || !cmp_port) &&
+			 !memcmp(&six1->sin6_addr, &six2->sin6_addr,
+				 sizeof(struct in6_addr)));
+	} else if (addr1->ss_family == AF_UNIX) {
+		un1 = (const struct sockaddr_un *)addr1;
+		un2 = (const struct sockaddr_un *)addr2;
+		return memcmp(un1, un2, addr1_len);
+	}
+
+	return -1;
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 94b9be24e39bc..a4a458c858d59 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -61,6 +61,10 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
+int cmp_addr(const struct sockaddr_storage *addr1, socklen_t addr1_len,
+	     const struct sockaddr_storage *addr2, socklen_t addr2_len,
+	     bool cmp_port);
+
 
 struct nstoken;
 /**
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 5fd6177189915..c1db1d7e08b04 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -246,40 +246,6 @@ static struct sock_addr_test tests[] = {
 
 typedef int (*info_fn)(int, struct sockaddr *, socklen_t *);
 
-static int cmp_addr(const struct sockaddr_storage *addr1, socklen_t addr1_len,
-		    const struct sockaddr_storage *addr2, socklen_t addr2_len,
-		    bool cmp_port)
-{
-	const struct sockaddr_in *four1, *four2;
-	const struct sockaddr_in6 *six1, *six2;
-	const struct sockaddr_un *un1, *un2;
-
-	if (addr1->ss_family != addr2->ss_family)
-		return -1;
-
-	if (addr1_len != addr2_len)
-		return -1;
-
-	if (addr1->ss_family == AF_INET) {
-		four1 = (const struct sockaddr_in *)addr1;
-		four2 = (const struct sockaddr_in *)addr2;
-		return !((four1->sin_port == four2->sin_port || !cmp_port) &&
-			 four1->sin_addr.s_addr == four2->sin_addr.s_addr);
-	} else if (addr1->ss_family == AF_INET6) {
-		six1 = (const struct sockaddr_in6 *)addr1;
-		six2 = (const struct sockaddr_in6 *)addr2;
-		return !((six1->sin6_port == six2->sin6_port || !cmp_port) &&
-			 !memcmp(&six1->sin6_addr, &six2->sin6_addr,
-				 sizeof(struct in6_addr)));
-	} else if (addr1->ss_family == AF_UNIX) {
-		un1 = (const struct sockaddr_un *)addr1;
-		un2 = (const struct sockaddr_un *)addr2;
-		return memcmp(un1, un2, addr1_len);
-	}
-
-	return -1;
-}
-
 static int cmp_sock_addr(info_fn fn, int sock1,
 			 const struct sockaddr_storage *addr2,
 			 socklen_t addr2_len, bool cmp_port)
-- 
2.44.0.478.gd926399ef9-goog


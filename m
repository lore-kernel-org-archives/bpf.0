Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD5B2F8E8F;
	Thu,  8 Oct 2026 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479572; cv=none; b=FwFkdXE2WzJQVEFAsZ2tTl1wNobSvevyTk/ky3DBasMzUZX3LpFXB0rLSLSya0EuN8mparU4OXhRaV4cIUx83xwfg44SV2x82QDAyys1MHQfi8PhiwMfXO9ixKyqMJvnE+4bMrkyVJ78ip6lJlRYJe9D4KPr+klt9CUWVBZZDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479572; c=relaxed/simple;
	bh=qVP//0v3O30bvMDrXzIZA3OqyjiI5lij9RLIwJfZhas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aT3Zbj1Eiy9fwYSQE/xDAJILtqNpp0I7jFJ4PKdrvpY2MvsIt0lM/UCaOTZ2BIpdFPLoVQ99L2gSegQWVF6BNKqrnCtKJ4NSLYH6Op7ExOJ7orU1QHmGxZbVqLAFo9BZVgfpWyQOC9T6QvHQIVfprwzmQV1ZMPTaY2pW15gdaUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZdbVxgI6; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZdbVxgI6"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xErfZ-005Qkh-0o; Thu, 08 Oct 2026 19:12:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=UYOo421Yw7/Xv7jeCLkN+7Vf+jpi3svVWN1flCjNphw=; b=ZdbVxgI6Sdq7UZNPIsS6kPDJt3
	EuOEivBEHLdaORiFX9jPEo672ygz2tL3rKlvY5G8HcqXVjrhHWZJZuZs89kV+3KZpm44qTn9Fe1DT
	A9HNsi1u/5uF8YENETpfaFB+oVMzsVVIy9WlB17Vv6xOejD8x7NEoI2V55OErPIVvRW7U7iL8vI/X
	bq2YKrQ6OeyXdQMLcWvCJNPeLnPLC5WoVIXOclrJlFMYcEtjfbdTw1yDeSB8KAzxZHSRc2LpmhTFV
	QCzAJXfJuksXYp0/IEPJCfHu167kQnMdS4x8LlTPT1caJ/V3hW7NwFP6dEsW8BgFJiGzYek0Ur02R
	KmJcmTZQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xErfY-0001sT-BT; Thu, 08 Oct 2026 19:12:36 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xErfJ-006XMM-BQ;
	Thu, 08 Oct 2026 19:12:21 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 08 Oct 2026 19:12:15 +0200
Subject: [PATCH bpf-next] selftests/bpf: Clean up sa_family_t-stringifier
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-selftests-sockmap_listen-cleanup-v1-1-f6d1a4ff540d@rbox.co>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNUQrCMBAFr1L224U2lBa9iogk6YtGYxqyqRRK7
 27Uz2FgZiNB9hA6NRtlvL34OVboDg3Zu443sJ8qk2rV0I6qZ0FwBVKEZbbPl07X4KUgsg3QcUk
 8Oqc6HA0mO1DNpAzn19/iTCY5jlgLXf5GFvOALd8D7fsHxa9plI4AAAA=
X-Change-ID: 20260724-selftests-sockmap_listen-cleanup-7ff21e9bedc6
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Following commit f3de1cf621f7 ("selftests/bpf: sockmap_listen cleanup: Drop
af_unix redir tests") and commit 9266e49d608c ("selftests/bpf:
sockmap_listen cleanup: Drop af_vsock redir tests"), sockmap_listen.c:
family_str() becomes functionally identical to select_reuseport.c:
family_str(). Move the logic to socket_helpers.h.

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://msgid.link/CAAVpQUDULzZh58oKkRaYqgM9bRToGb7wHrzT+cZNpRmAtM12Ow@mail.gmail.com
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/select_reuseport.c    | 16 +++-------------
 .../selftests/bpf/prog_tests/socket_helpers.h      | 12 ++++++++++++
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 22 +++-------------------
 3 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 3dbcc091f16c..3b4b233e21d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -6,6 +6,7 @@
 #include <stdbool.h>
 #include <string.h>
 #include <errno.h>
+#include <error.h>
 #include <assert.h>
 #include <fcntl.h>
 #include <linux/bpf.h>
@@ -21,6 +22,7 @@
 #include "bpf_util.h"
 
 #include "test_progs.h"
+#include "socket_helpers.h"
 #include "test_select_reuseport_common.h"
 
 #define MAX_TEST_NAME 80
@@ -740,18 +742,6 @@ static const char *maptype_str(enum bpf_map_type type)
 	}
 }
 
-static const char *family_str(sa_family_t family)
-{
-	switch (family) {
-	case AF_INET:
-		return "IPv4";
-	case AF_INET6:
-		return "IPv6";
-	default:
-		return "unknown";
-	}
-}
-
 static const char *sotype_str(int sotype)
 {
 	switch (sotype) {
@@ -794,7 +784,7 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 
 		snprintf(s, sizeof(s), "%s %s/%s %s %s",
 			 maptype_str(inner_map_type),
-			 family_str(family), sotype_str(sotype),
+			 inet_family_str(family), sotype_str(sotype),
 			 inany ? "INANY" : "LOOPBACK", t->name);
 
 		if (!test__start_subtest(s))
diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index 0d59503a0c73..4a570998612d 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -470,4 +470,16 @@ static inline const char *socket_kind_to_str(int sock_fd)
 	return "???";
 }
 
+static inline const char *inet_family_str(sa_family_t family)
+{
+	switch (family) {
+	case AF_INET:
+		return "IPv4";
+	case AF_INET6:
+		return "IPv6";
+	default:
+		return "unknown";
+	}
+}
+
 #endif // __SOCKET_HELPERS__
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 1c96a3cf4b97..235e1d56f044 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1232,22 +1232,6 @@ static void test_ops_cleanup(const struct bpf_map *map)
 	}
 }
 
-static const char *family_str(sa_family_t family)
-{
-	switch (family) {
-	case AF_INET:
-		return "IPv4";
-	case AF_INET6:
-		return "IPv6";
-	case AF_UNIX:
-		return "Unix";
-	case AF_VSOCK:
-		return "VSOCK";
-	default:
-		return "unknown";
-	}
-}
-
 static const char *map_type_str(const struct bpf_map *map)
 {
 	int type;
@@ -1315,7 +1299,7 @@ static void test_ops(struct test_sockmap_listen *skel, struct bpf_map *map,
 	char s[MAX_TEST_NAME];
 	int map_fd;
 
-	family_name = family_str(family);
+	family_name = inet_family_str(family);
 	map_name = map_type_str(map);
 	sotype_name = sotype_str(sotype);
 	map_fd = bpf_map__fd(map);
@@ -1355,7 +1339,7 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
 	const struct redir_test *t;
 	char s[MAX_TEST_NAME];
 
-	family_name = family_str(family);
+	family_name = inet_family_str(family);
 	map_name = map_type_str(map);
 
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
@@ -1387,7 +1371,7 @@ static void test_reuseport(struct test_sockmap_listen *skel,
 	const struct reuseport_test *t;
 	char s[MAX_TEST_NAME];
 
-	family_name = family_str(family);
+	family_name = inet_family_str(family);
 	map_name = map_type_str(map);
 	sotype_name = sotype_str(sotype);
 

---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20260724-selftests-sockmap_listen-cleanup-7ff21e9bedc6

Best regards,
--  
Michal Luczaj <mhal@rbox.co>


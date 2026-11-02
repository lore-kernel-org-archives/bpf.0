Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793592920;
	b=UNw5EbttF4p0QlhpP3ASkI7BCfGnyb32oRxkIaNlLNeb2vUPk3sOgGzd6E18N+VTrtAZ
	 Wp83MHiy6YtV1Bpy65sLYwW661DeoHWVDs0pT9t/yeGsjEaRZQPiAdt0aww6m2fD+cSGX
	 cKPJyvX7nlUAHyNyoRDUclzmUk5he6YQuD62X0OrZoevM4nbxMj4qTjchXohkIE8KvUuh
	 wb1YRpDNkD2WafnsK7uT2b1g/z+/hMacMeIQB/M77AbmTzo8H0ijZfTYSNQWL7v2Ubu3L
	 n2TqmyQUfoSLFMs+yRp602YZkGiljLwc/D6KmTMFH9AOrzA0LLcyxv1SDkW2KwaqNIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793592920;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hyHLxgFFM5UwytLaR9tbayyj8T/pSPedO9J/t+f+U88=;
	b=pdOjDfep56vW//6ON6CqQWoqpbFCpGU1UcsKGUQDHDKwLZntblsYk0cq7RAFS9OaNa7T
	 CP/+BOfoSsl7mTbFe/Rw4rt1QfgEumFgxDLz24I7EvSxXtFP1ScNCnvxo3Q4FFjlG2Ack
	 JOcT3G7ROpLo97PhV1W8ddEAau8dgMaCjpw+Oixo7aXPpqs/J6ko5BFxles4e5mZ4Ilmn
	 OhQchGYPjqlwrDijV1IxyoU/pylLwxjr/bXsr4Pn9T0FVjb7mR2KagnZ8H72OnfZd4e0n
	 EGOP5jZ1uxW9bHyugtXNuXnMz8nmxYg6ntjSIoMDw29wYkSuJxfMBaj7ngJdNhxSaKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Yhlt/D/W";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5490606A324;
	Mon,  2 Nov 2026 04:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yhlt/D/W
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793592919;
	b=Y8k6jv/+4mQ1PQvzcVC//cfIeU66Wtx5l+GdD1j/JfPEVRia8CO3DMbJrAyzeHKpSOSk
	 8ORiv9bG5BpmzxgnFsz1thTJJJB0jw03xjf6PjHQpNY9q2wmvuNVa1f83GgQiD7k/XLam
	 uQATTx4pBH0OR96GO7YzKjGPIShlQAlSgbOhm7BlrNWxKqALViXSq6b8MZsdZ+TSMRFqc
	 XoAmsY9cOz5w50xTcP/ZK0RVfq2QGLxpGwXKY8hE4/kk03RhWtzpxsHJ+DmonD1O8Q4V+
	 A/J6mklf1UdmCBCgM2XQBM93r49NIgpDip565DbpdlS/mFp/Zhj3fTlqxGVIniYizcQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793592919;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hyHLxgFFM5UwytLaR9tbayyj8T/pSPedO9J/t+f+U88=;
	b=aLnbsyHuPsoR9Yb9c19i4EQb/uK+NYOYUVaJhcKClciKc8tSXSmYfbLwNMhXPIlnOItg
	 IyWC7+rH/XEUwOB2lZP9OsPeskNRhttj1K/W2igTaCXIqjrH7Ne45kzDDvcvfiBvOFQbt
	 olnkfq/j2Q8+zTSuxj/Q9+/PGe+UoKrzDo79M+GMPodoU+SR7hRYbe0nwh5GpcLX/ObAa
	 JzsWrgIKDeQG5vWlAuYbXc28vxU1hANaPiRk5Y1rYGMgVD52LpuLYU3fAKRZtTAWgj+p4
	 YU/25alctjjLDG4Z66eZp4hadKB5LodZElmR3dd/oXGUH6nUh0tJta4CNp9Gxsu1YAw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 81B251F000C1;
	Mon,  2 Nov 2026 04:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793592919;
	bh=hyHLxgFFM5UwytLaR9tbayyj8T/pSPedO9J/t+f+U88=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Yhlt/D/WZ24GTNwNxw2aNZWkwLBGXDWSU8JICyOoTwoyj0Q/wvTxdll4vYO66vjcu
	 8ZDrcPNUYI8wen02tc6rje3Lt79ogBcGFCXJazQEJLH1d53iAa5bnLsMKCgXX7r/Et
	 scOFw3CxuSum61JKtyW7BfRMMlGgyNm/A0LzhiWrR/cVE+NUflM9uax6Df2SR0LlIs
	 5zGW7dmUL3OTz8z0Ftn+CkMvru4s4/jugTgMiVQMt6O8EGotZ6xgyScxy+qLdLAN0E
	 pu/ohvBj9C1/udzL6Q03SwAGMoLwRudEDPQlsIkuX7SbydCE/z8nRyimNfUQvSk2Vh
	 kJvZAEnydSzTQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D1AAE46357;
	Mon,  2 Nov 2026 04:15:17 +0000 (UTC)
From: Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org>
Date: Mon, 02 Nov 2026 11:15:15 +0700
Subject: [PATCH bpf-next] selftests/bpf: Use memfd_create instead of
 mkstemp in d_path
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
Message-Id: <20261102-d-path-memfd-v1-1-692a5664b36d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtIg6yuEi3KGWsWmWhEEN49a
 fkW/7+QOAonGKsXIt+S5PQFqq7A7ovfGIWKQTe6U6rRSBiWa8eDD0c49Ko3w2qpJQMlCZGdPP9
 ugjU49PxcMOf8AVqhSIFoAAAA
X-Change-ID: 20261102-d-path-memfd-981879bcd3d7
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shuran Liu <electronlsr@gmail.com>, 
 Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793592917; l=1984;
 i=thamrinjonathan@gmail.com; s=20261005; h=from:subject:message-id;
 bh=TeJTaf4tRSKGbLwDa/44eFD6DQOyzppP99cx6sinrxM=;
 b=tCepcmKWaKlDygccQxSfS6IBJUclXSj5Eujzq3IucunRtsSHY72EraktC+4Qp4ocgMRskLro9
 8AvEPe3dLaVBfmEhdMInkWogaim0kdC4rK8pIDSb/DnFGXGV2xZrNI/
X-Developer-Key: i=thamrinjonathan@gmail.com; a=ed25519;
 pk=QU907bIMYty/tEI/iJF2SrD1lqOf/+2B1MI1zwJ5cBw=
X-Endpoint-Received: by B4 Relay for thamrinjonathan@gmail.com/20261005
 with auth_id=1114
X-Original-From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Reply-To: thamrinjonathan@gmail.com
Content-Transfer-Encoding: 7bit

From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

check_mem_access currently creates a temp file in /dev/shm, which
isn't mounted under vmtest.sh in local runs. This causes mkstemp
to fail with ENOENT. The fix is similar to
commit 47687a29b2c3 ("selftests/bpf: Use memfd_create instead of
shm_open in cgroup_iter_memcg") where memfd_create gives a
shmem-backed file with no mount needed while still reaching
vfs_fallocate.

Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/d_path.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index 1a2a2f1abf03..0f0150d73262 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -4,6 +4,7 @@
 #include <sys/stat.h>
 #include <linux/sched.h>
 #include <sys/syscall.h>
+#include <sys/mman.h>
 
 #define MAX_PATH_LEN		128
 #define MAX_FILES		7
@@ -220,7 +221,6 @@ static void test_d_path_check_types(void)
 static void test_d_path_mem_access(void)
 {
 	int localfd = -1;
-	char path_template[] = "/dev/shm/d_path_loadgen.XXXXXX";
 	struct test_d_path__bss *bss;
 	struct test_d_path *skel;
 
@@ -230,13 +230,12 @@ static void test_d_path_mem_access(void)
 
 	bss = skel->bss;
 
-	localfd = mkstemp(path_template);
-	if (CHECK(localfd < 0, "trigger", "mkstemp failed\n"))
+	localfd = memfd_create("d_path_loadgen", 0);
+	if (CHECK(localfd < 0, "trigger", "memfd_create failed\n"))
 		goto cleanup;
 
 	if (CHECK(fallocate(localfd, 0, 0, 1024) < 0, "trigger", "fallocate failed\n"))
 		goto cleanup;
-	remove(path_template);
 
 	if (CHECK(!bss->path_match_fallocate, "check",
 		  "failed to read fallocate path"))

---
base-commit: a30c772627b2ef4bc715332b1b04938a914556cd
change-id: 20261102-d-path-memfd-981879bcd3d7

Best regards,
-- 
Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>



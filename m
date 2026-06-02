Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6918F3E7BA3
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407064; cv=none; b=misIo6HKJTG9vqklypJG3uggyISaVasDZaHeOtWyyqZUlto5XHBKo4DfTCshei4IO3zxGQimXtt9i+ua1DYxrqKOD/SRPPcO/x/HH3MKDRPvd8/5gaRXqYtF9PSqfDWuU4Vyx+zFBOBGymW+0pybUh27KncAAEqbywUbOaT8eko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407064; c=relaxed/simple;
	bh=rzOs2ROVlRUYlWVAgFsC5/xCEtouzJrcNOa6V02gQSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msGxecLidEdw61ZRzArhgaE1PabRXCzchluAZLJw6+YqsC1RmkfDb/ynW1jku9EOzdOTls7Q90GsZ+uU95JDhKu9u2KIDLpzZQGiTvyyCefCeO64pzBOr4Igw+4PrP78WHdwe3cbaYcy1Q3xZrdCMNkVq2oBzZbO4Jw60m7Zito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QbySsbcK; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QbySsbcK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oXvgaSWF0gngFmIrIHkKAjNaULsSYLEaqnPsIYwhTXw=; b=QbySsbcKtDOk0A8xp0oue4AHT5
	kwEQ30s5hzyWgCw3ivXuZkadm4IWxSdKr2D18+n4Uo0JUcC877VNosOQJoffk3neuubHdDqGVB69z
	r1Chaz7/2XA54XZxrsiPdFxw/wSZQLxuZ4HihEiHY/Kd6Btv6bDsZqFt48tmKqL+uIMzZAUNslRos
	WePdkV8eawPdgcwMBak68IIa4ZASOvdia3B1hdA4uTUc2Z7mc+yLu1JwCi3b73lXo0z8EaWEzAznt
	lgEs20qnlv5Iuip4GoAZqECqLGYa21N51N2RgK5zKn2Tqxw+xYTCnvuWgRii4c9X/rPGAP0AJkDpr
	PECIVj1g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wUPCp-0007Io-1k;
	Tue, 02 Jun 2026 15:30:55 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf-next 4/4] selftests/bpf: Test that exclusive maps are rejected as iter targets
Date: Tue,  2 Jun 2026 15:30:52 +0200
Message-ID: <20260602133052.423725-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602133052.423725-1-daniel@iogearbox.net>
References: <20260602133052.423725-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28019/Tue Jun  2 08:33:27 2026)

Add a subtest to map_excl that creates an exclusive map and verifies a
bpf_map_elem iterator cannot be attached to it, which would otherwise
let an unrelated program read and overwrite the map's contents through
the iterator's writable value buffer.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t map_excl
  [...]
  ./test_progs -t map_excl
  [    1.704382] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.706068] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #215/1   map_excl/map_excl_allowed:OK
  #215/2   map_excl/map_excl_denied:OK
  #215/3   map_excl/map_excl_no_map_in_map:OK
  #215/4   map_excl/map_excl_no_map_iter:OK
  #215     map_excl:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/map_excl.c       | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_excl.c b/tools/testing/selftests/bpf/prog_tests/map_excl.c
index a213dd559aae..3088668e2e45 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_excl.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_excl.c
@@ -7,6 +7,7 @@
 #include <bpf/btf.h>
 
 #include "map_excl.skel.h"
+#include "bpf_iter_bpf_array_map.skel.h"
 
 #ifndef SHA256_DIGEST_SIZE
 #define SHA256_DIGEST_SIZE	32
@@ -89,6 +90,42 @@ static void test_map_excl_no_map_in_map(void)
 	close(excl_fd);
 }
 
+static void test_map_excl_no_map_iter(void)
+{
+	__u8 hash[SHA256_DIGEST_SIZE] = {};
+	LIBBPF_OPTS(bpf_map_create_opts, excl_opts,
+		    .excl_prog_hash = hash,
+		    .excl_prog_hash_size = sizeof(hash));
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct bpf_iter_bpf_array_map *skel = NULL;
+	union bpf_iter_link_info linfo;
+	struct bpf_link *link;
+	int excl_fd;
+
+	excl_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "excl_iter", 4, 8, 3, &excl_opts);
+	if (!ASSERT_OK_FD(excl_fd, "create exclusive map"))
+		return;
+
+	skel = bpf_iter_bpf_array_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_array_map__open_and_load"))
+		goto out;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.map.map_fd = excl_fd;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(skel->progs.dump_bpf_array_map, &opts);
+	if (!ASSERT_ERR_PTR(link, "reject exclusive map as iter target")) {
+		bpf_link__destroy(link);
+		goto out;
+	}
+	ASSERT_EQ(libbpf_get_error(link), -EPERM, "iter attach errno");
+out:
+	bpf_iter_bpf_array_map__destroy(skel);
+	close(excl_fd);
+}
+
 void test_map_excl(void)
 {
 	if (test__start_subtest("map_excl_allowed"))
@@ -97,4 +134,6 @@ void test_map_excl(void)
 		test_map_excl_denied();
 	if (test__start_subtest("map_excl_no_map_in_map"))
 		test_map_excl_no_map_in_map();
+	if (test__start_subtest("map_excl_no_map_iter"))
+		test_map_excl_no_map_iter();
 }
-- 
2.43.0


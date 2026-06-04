Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1658243964;
	Thu,  4 Jun 2026 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542684; cv=none; b=Kf56DXIxf5s0wh82k+h3cQwieouklKsda3X5vxQCqQrpZwLGrsG4PQGiWY87NXC7K+caUFT7CNxjDFARMGkD3H1zBraCci/4BMiVeJIzMz6X1nOOwHNuy7ZTVs3hcOROJel93MAzXcZhrN/7h3KnYA3WOuvQ5//9FpHfwzxy4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542684; c=relaxed/simple;
	bh=IYa8P2RTOneK+QluhF/NhnLhNdsUiCCJb9BHqONYjCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3U+Sx2ImEdPg/Nq14Bb4fur3b+snt0jwDmYIVigzEMd0RGRFuOuRUZjuUsN8M4J3e6f8bK+aRCPA49q9UjnjtLz5I2pxlI/n7GtiBZoJ2QGFKK6lUTUWiG3NuIGF4Fh/YDUd0YZHQSE3AqWkJT6/yzMe3UCJk/8HsRCxPF5AZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j4GZ46x+; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j4GZ46x+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Im
	VrToeM3zhho5qrpxk1WDsFugnd8GGgzTsb2nCyJx8=; b=j4GZ46x+UHxmRX70M1
	gemyJIJhnIsuWRoekONN49tH7lDFhArPr3GK0AZ/8dJ2NlkZihDs+7DEw2WIrjNT
	igJmNURVrLa+cupIRyrlrR21tAz7LA2wvFU4YljwZwT+7jhMBCUNv2S0O0wPd6Qi
	dGbUb6+7LOUh8+5Ntz/HM9FHg=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCnNjaz7CBq76U8BQ--.63531S4;
	Thu, 04 Jun 2026 11:10:51 +0800 (CST)
From: chenyuan_fl@163.com
To: chenyuan_fl@163.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Add ARRAY map type to token tests that use struct_ops global data
Date: Thu,  4 Jun 2026 11:10:32 +0800
Message-ID: <20260604031033.806727-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604031033.806727-1-chenyuan_fl@163.com>
References: <20260529031604.888137-1-chenyuan_fl@163.com>
 <20260604031033.806727-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnNjaz7CBq76U8BQ--.63531S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryUZw1xtw43Gw18Wr4fGrg_yoW8tF17pw
	1kWa9rt3W3XFWxtr4qqay7ur10kF1xZF15Cr4DZ347AFsFyrn7tF1j9a4vywnxWrW5u3sI
	v3WY9rn3ua1kCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zETa0JUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAhsMyWog7LtksgAA3X

From: Yuan Chen <chenyuan@kylinos.cn>

obj_priv_btf_success, obj_priv_implicit_token and
obj_priv_implicit_token_envvar use the dummy_st_ops_success skeleton,
whose struct_ops programs reference global variables backed by ARRAY
maps.  Without BPF_MAP_TYPE_ARRAY in the token allowed map types,
bpf_object__load() fails because the kernel rejects ARRAY map creation
for global data.

Add BPF_MAP_TYPE_ARRAY to the token permission mask for these three
subtests so their skeletons can load successfully.

This is distinct from the libbpf probe issue: the skeletons genuinely
require ARRAY maps for their global data, not merely for probing.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/token.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index f2f5d36ae00a..1812de87bedb 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -1214,7 +1214,7 @@ void serial_test_token(void)
 		struct bpffs_opts opts = {
 			/* allow BTF loading */
 			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
-			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS),
+			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS) | bit(BPF_MAP_TYPE_ARRAY),
 			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS),
 			.attachs = ~0ULL,
 		};
@@ -1225,7 +1225,7 @@ void serial_test_token(void)
 		struct bpffs_opts opts = {
 			/* allow BTF loading */
 			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
-			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS),
+			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS) | bit(BPF_MAP_TYPE_ARRAY),
 			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS),
 			.attachs = ~0ULL,
 		};
@@ -1236,7 +1236,7 @@ void serial_test_token(void)
 		struct bpffs_opts opts = {
 			/* allow BTF loading */
 			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
-			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS),
+			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS) | bit(BPF_MAP_TYPE_ARRAY),
 			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS),
 			.attachs = ~0ULL,
 		};
-- 
2.54.0


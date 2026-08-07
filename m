Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C547A89F;
	Fri,  7 Aug 2026 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110254; cv=none; b=hcpByUx8Vfvf53r8hwqpwn9x6/BZM/yXSG9ErChmjb8JxA/+JB2WLGvIyYmgMSvLUW8P+DvVdQ8qO+s+3fRM4vuK6huoYwMRVhYTh9LZE8wjxAMhKWMcI/nnk9EC7wbTXQhUPY0NCdvzclmR+T1eW3VbOQ3Hyl6fclANJiWgNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110254; c=relaxed/simple;
	bh=rbttYnqqPeUThs9qfRH4ROGJK2m4SsnWre9wM40wIew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqBQI305cFDQacaG/F/dfxs4aF7YUuBMqjNJFwvZqmYCaB1Y3CNz/U12iRJ/eY4w5TY5KqURqCBgq028EQFtK44hVxZQEVhdbk3yM80w/n9VtRw4thnZuqYDLQCW89fpWa5QTeTKcSVqZisY48WsHQU24xr9HXVDpL2IRcWK2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eu5KbGPJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eu5KbGPJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786110251; x=1817646251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rbttYnqqPeUThs9qfRH4ROGJK2m4SsnWre9wM40wIew=;
  b=Eu5KbGPJXzOfbUjoH2DxJzo8dgveYvyOwytD01SCV6+Xd1MFuw8CEF22
   Kh94cHQ8HNYtuXyHuP36MGXfe4ycJky7KRYK9Ob9NzJS2r4lGFgkEbZ/I
   5NOSNt/bkbExv16M4knwkwY5PI64v93aCqyj77kO7WvdibEDf1MdrJZLT
   lxIZbO5hAnJU0qKidWQs3u+Cn0N60D+rXrnZjGLSZXxuvAqwNQfc8E9g4
   RHAI1umhwwK6kPAw7cK3IsxF0TDyIKbqqXaBSpnnoJskTCJIyG/ZP6XW9
   y25jc4TaZ/0mQBWaAkWsEsqZ/saLDVKwyGe2ewpVqLckCnk+AjuqlB80s
   Q==;
X-CSE-ConnectionGUID: wSHPk/3qQQaCiBYt86W93A==
X-CSE-MsgGUID: 2K2mux0OQs2dzRN8jj1GNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="98079940"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="98079940"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:44:09 -0700
X-CSE-ConnectionGUID: HY8kSnxTQ6ifDc6pZTu82g==
X-CSE-MsgGUID: dDTptrCJQlGB96cImmPYXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="287080054"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:44:05 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	stfomichev@gmail.com,
	kernelxing@tencent.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com,
	andrii@kernel.org
Cc: bpf@vger.kernel.org
Subject: [PATCH net-next 2/5] selftests/xsk: roll back partial socket setup on configure failures
Date: Fri,  7 Aug 2026 13:42:06 +0000
Message-ID: <20260807134209.3794735-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807134209.3794735-1-tushar.vyavahare@intel.com>
References: <20260807134209.3794735-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When xsk_socket__create() fails after all retries, or when busy-poll
setup fails after the socket is created, already-configured sockets for
the same ifobject are leaked.

Add xsk_configure_rollback() to call xsk_delete_socket_batch() on all
sockets configured so far, and wire it into both failure paths in
xsk_configure().

As part of this change, move xsk_delete_socket_batch() next to
xsk_configure_rollback() so rollback helpers are grouped with
xsk_configure()-local failure handling.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 41 +++++++++++++------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 4ccdb0825130..de0d8f51f846 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1484,6 +1484,28 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
 	return TEST_PASS;
 }
 
+static void xsk_delete_socket_batch(struct ifobject *ifobject, u32 count)
+{
+	u32 i;
+
+	if (!ifobject)
+		return;
+
+	for (i = count; i > 0; i--)
+		xsk_delete_socket(&ifobject->xsk_arr[i - 1]);
+}
+
+static void xsk_configure_rollback(struct ifobject *ifobject, int last)
+{
+	u32 count;
+
+	if (!ifobject || last < 0)
+		return;
+
+	count = last + 1;
+	xsk_delete_socket_batch(ifobject, count);
+}
+
 static int xsk_configure(struct test_spec *test, struct ifobject *ifobject,
 			  struct xsk_umem_info *umem, bool tx)
 {
@@ -1500,14 +1522,18 @@ static int xsk_configure(struct test_spec *test, struct ifobject *ifobject,
 				break;
 
 			/* Retry if it fails as xsk_socket__create() is asynchronous */
-			if (ctr >= SOCK_RECONF_CTR)
+			if (ctr >= SOCK_RECONF_CTR) {
+				xsk_configure_rollback(ifobject, i);
 				return ret;
+			}
 			usleep(USLEEP_MAX);
 		}
 		if (ifobject->busy_poll) {
 			ret = enable_busy_poll(&ifobject->xsk_arr[i]);
-			if (ret)
+			if (ret) {
+				xsk_configure_rollback(ifobject, i);
 				return ret;
+			}
 		}
 	}
 
@@ -1766,17 +1792,6 @@ void xsk_delete_socket(struct xsk_socket_info *xsk)
 	}
 }
 
-static void xsk_delete_socket_batch(struct ifobject *ifobject, u32 count)
-{
-	u32 i;
-
-	if (!ifobject)
-		return;
-
-	for (i = count; i > 0; i--)
-		xsk_delete_socket(&ifobject->xsk_arr[i - 1]);
-}
-
 static void xsk_delete_all_ifobj_sockets(struct test_spec *test, struct ifobject *ifobj)
 {
 	if (!ifobj)
-- 
2.43.0


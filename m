Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD294251793
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771269485; cv=none; b=FBDOLuKOSbKNl8y4odztYn0P3bwr3vBVJ91ATgazgii9JGOAx3OSt8Yza0Fcjl0rC5R0K6gkRgZPJlayd6YSiZ+U0x3RH6gUXC6e3ewr7dY3HY9CYmJIQ6/tVnEjv0b/W+k07gc22/FwzH8aiqagEZDKo7oXjzKopEb9eDgYLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771269485; c=relaxed/simple;
	bh=o078/X5wm82OPWgguQA+ZgRmaoQTdJPdi6+Y1Uf2YlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drTJt25fNTFP9VpdrFvyhPRKSiPPm2B33ZDBTkQqt9a55S41+SbpDinLFMqoiUS6W1vRBWiMDuKSzQO/88QZPV6aKWlV4sYjsf04miUEiGURhWcoFboWqu9sAxNgxjHmpou7PuSi37cGz9B7BBcTXhGt/oIF2TPkWwtLSRXQ4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLoi8cVY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLoi8cVY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771269482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ITufXC05vOjs5DlZjeQXK2W8zqVewmQ1l83ijhbX0s=;
	b=CLoi8cVYVi1iKZsKf8X72S6Nk5PVNaM3IzaJPAXjT4MXmSznKIKLf0O+FplwnJ2XUSggq3
	5ROwFwJrx5Ecp4GLLpCCIBjw9DDnU+d13D2sLXdcwVgUtccLEUzbvhgM9AQ3fs931qEoCf
	ftAqj+nL/z1XGSwbwLQzAE3/NnXxsM0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-GMOTIeZHNCyS76fw4i2IZQ-1; Mon,
 16 Feb 2026 14:17:59 -0500
X-MC-Unique: GMOTIeZHNCyS76fw4i2IZQ-1
X-Mimecast-MFC-AGG-ID: GMOTIeZHNCyS76fw4i2IZQ_1771269477
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 853901956053;
	Mon, 16 Feb 2026 19:17:57 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.65.177])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E3C71955F43;
	Mon, 16 Feb 2026 19:17:54 +0000 (UTC)
From: Gregory Bell <grbell@redhat.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	Gregory Bell <grbell@redhat.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: align build_id test mapping to 64K page size
Date: Mon, 16 Feb 2026 14:17:24 -0500
Message-ID: <3fbc35d6e8382011e6d7e8d8c2a3e7717da40437.1771267122.git.grbell@redhat.com>
In-Reply-To: <cover.1771267122.git.grbell@redhat.com>
References: <cover.1771267122.git.grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Some architectures require mappings to be aligned to the system page size.
The build_id selftest currently uses a smaller alignment, which can result
in madvise operations executing on a different page than intended.

Increase the mapping alignment to 64K so the buffer is page-aligned on
all supported architectures.

Signed-off-by: Gregory Bell <grbell@redhat.com>
---
 tools/testing/selftests/bpf/uprobe_multi.ld | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/uprobe_multi.ld b/tools/testing/selftests/bpf/uprobe_multi.ld
index a2e94828bc8c..2063714b2899 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.ld
+++ b/tools/testing/selftests/bpf/uprobe_multi.ld
@@ -1,8 +1,8 @@
 SECTIONS
 {
-	. = ALIGN(4096);
+	. = ALIGN(65536);
 	.note.gnu.build-id : { *(.note.gnu.build-id) }
-	. = ALIGN(4096);
+	. = ALIGN(65536);
 }
 INSERT AFTER .text;
 
-- 
2.52.0


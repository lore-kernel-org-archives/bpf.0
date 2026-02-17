Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68136BCE6
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338812; cv=none; b=LSopOt8TaPb0P0LBVSrgGzo0bh3C5NLCyd6g0SrGsxZIwL4i2K0AWc1qTb6IbTBmvTSQWLBl8ZzBkEv7IMYpIZMt5bSRBJ0t6+9cxtYJJ2uD9Eb9G7xRw6MByMWvtb55rRAyqXWd614J2DUIbxdbQHcGZq/HeW5wx54mauVrl3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338812; c=relaxed/simple;
	bh=o078/X5wm82OPWgguQA+ZgRmaoQTdJPdi6+Y1Uf2YlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4AKU0XIcryAs0XmtfIfewVUc4finR/X3hmW9Mmlzrj/BSlXjejhliatPpOCgiZENPhbGLL2lVt3YtW4RahKArTT3hywlg2TtvTgRyvLt+OVNVrdKB1Nu0H5YAoZ5C2XyToUETsPPxoTu/CsL9GEMtr7Qf5GD4rOUjmWMR6U/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9YJEjZT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9YJEjZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771338810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ITufXC05vOjs5DlZjeQXK2W8zqVewmQ1l83ijhbX0s=;
	b=T9YJEjZTx+bfDD/14KNXZz/21fRaLDH+f7nsaF+1sMgu5y63YRIaYQBbH5B5JEycPlm8ms
	P1gBUcci+NqZay3ySi4wNjMRqaeaP0ZZbrSt55iH9yRiSWrPIg0/lZocL5oyHFtOG3Gsof
	DqlLkgl+ejfM0fxjdWUkQMPsjpatnRU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-uyC3zjP9PtWLHo5FUkffdg-1; Tue,
 17 Feb 2026 09:33:29 -0500
X-MC-Unique: uyC3zjP9PtWLHo5FUkffdg-1
X-Mimecast-MFC-AGG-ID: uyC3zjP9PtWLHo5FUkffdg_1771338807
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1C1F1956048;
	Tue, 17 Feb 2026 14:33:26 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.81.92])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50D2419560A2;
	Tue, 17 Feb 2026 14:33:23 +0000 (UTC)
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: align build_id test mapping to 64K page size
Date: Tue, 17 Feb 2026 09:32:37 -0500
Message-ID: <93543253b32d1cb178ab6e31e4291e387ba1c372.1771338492.git.grbell@redhat.com>
In-Reply-To: <cover.1771338492.git.grbell@redhat.com>
References: <cover.1771338492.git.grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A66A8D2
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771269471; cv=none; b=sFeevodrPjUUpu3giuSFCdon4OykuDwgqRiNYai9RwShuCYb4TeIV8LWgtow07XTYyXzPUm99fT/rGgOufCCG2fFqLndNvRathd8vP6dSwdrzMDg8A5iw1oAlz7vQM6IAjNCJE7WcHUgzJn78nqsxyPBY/FskG9Wtj5ip1C6eF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771269471; c=relaxed/simple;
	bh=HSV2i/bzWTfwyBgq+oAX1yZtiBwbrbey3EbYB08kYrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTpCRUtwtbO0ysfLq48ac71Pu7pOA05dCTdSiFVhiA/5Lc64q9v2gb5zA189ecJ04XiZkU6ywqAlxO73a2QbPpksztsCQuhXtIacTLwk0FE8WhBexP8YbQuzKqs++K2B98vW94O/RZqcaAWvull2Aw19z4UDZOweu/Vnu1ZmxXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWXy5rvE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWXy5rvE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771269468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fh6Eq3Xd/0OVxNCu8mZnpBg6O5k+x2P0X3kQARazEks=;
	b=DWXy5rvERZwNSnij8AFLyXNdT16+ry8lGYyUbVJjl/Xv0JYWEwjx5/M/3ToSQ5NesB8JEz
	6E4aovKSuS55dkedOjhhmZAkUEwQ65ag6g8l4fneivQUSX33dMuCvaFnBo1mhRRGcof0V5
	f2dKQYpVOGFJ0BTAGD3UPuNILRvKClI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-dyaw9UR4NCuXsZSqaUCvCQ-1; Mon,
 16 Feb 2026 14:17:45 -0500
X-MC-Unique: dyaw9UR4NCuXsZSqaUCvCQ-1
X-Mimecast-MFC-AGG-ID: dyaw9UR4NCuXsZSqaUCvCQ_1771269463
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C18B31955BCB;
	Mon, 16 Feb 2026 19:17:42 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.65.177])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2EC9F195410D;
	Mon, 16 Feb 2026 19:17:38 +0000 (UTC)
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
Subject: [PATCH bpf-next 0/2] selftests/bpf: fix flaky build_id test
Date: Mon, 16 Feb 2026 14:17:22 -0500
Message-ID: <cover.1771267122.git.grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The build_id selftest intermittently fails with the following error:

	./test_progs -t build_id/nofault-paged-out
 	serial_test_build_id:PASS:parse_build_id 0 nsec
 	subtest_nofault:PASS:skel_open 0 nsec
 	subtest_nofault:PASS:link 0 nsec
 	subtest_nofault:PASS:trigger_uprobe 0 nsec
 	subtest_nofault:PASS:res 0 nsec
 	subtest_nofault:FAIL:build_id_status unexpected build_id_status: actual 1 != expected 2
 	46/1    build_id/nofault-paged-out:FAIL
 	46      build_id:FAIL
 	397     stacktrace_build_id:OK
 	398     stacktrace_build_id_nmi:OK

On RHEL we consistently hit the reported failure on the first run of
the test following installation, after which subsequent runs pass.

This patch implements the approach discussed in the following thread:
https://lore.kernel.org/all/CAEf4BzYWVtfZh07iQm5Fo=kMm+8hgAu+rXRx1uLRHz07wc59+Q@mail.gmail.com/

Following the discussion, the fix makes the test verify eviction rather
than assuming it. In the discussion it was recommended to add a sleep before
and after the madvise operations, this did not resolve the issue in our case,
rather the test timed out every time. I was successful by retrying the
page-out sequence until the page is actually evicted.

Additionally, the mapping alignment is increased to
64K so the test operates on a properly page-aligned buffer across
supported architectures.

Gregory Bell (2):
  selftests/bpf: fix flaky build_id test
  selftests/bpf: align build_id test mapping to 64K page size

 tools/testing/selftests/bpf/uprobe_multi.c  | 19 ++++++++++++++++---
 tools/testing/selftests/bpf/uprobe_multi.ld |  4 ++--
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.52.0


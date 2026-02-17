Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F936C5AD
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338786; cv=none; b=FGcHC7jAOV/BUYg4legS1111T7SLG4usE4e5gQIvOhcTPUZbh4NwN+uYH1zdBdFKDQyput61BX1g0eh51RAVvOBSe0AHvqeNfePGZ0VVEhLOcRAn3fr+C6IFRPXs+lCss1tZzi5CbFpNG+ZQo8Nr9qcnbQZMGWmhioNL26GVqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338786; c=relaxed/simple;
	bh=Fb/lrN/YmIgGqerLWDuu92vhItVB4eL/wJsyYxvVd3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpEk5d6AqLB4HkKuuDcf/tCurav8TkfNRMyTqJr07hnd2EZiXyt3CMHQKi7kgKrwo1Rn3ZZJH0LvFs8Ka9fqwp64Mw2l27/1nVly5076iuW+wAVfXl3kOyYT/78AGjDE102x+ycPLxsumVry2uMtw5WhQkNAI/goJ2LNFxEajow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSxe9BaV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSxe9BaV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771338784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Oh3tTGrvhGUp22U2BIC1uONODgBqPblJu8kWCDC9hhk=;
	b=CSxe9BaVfemcj1Lwz8is5veXhpEWgSmphce4wfwy64oEALbvkgFHp2SH4ylf4E3pJ/v/MU
	NHq1R23E7RpJSsSrrKokEW+symw+0KAwThctAVVhjeCcC0W05zKpftQ8lX1m6WJPldTSwv
	1+hi/FRLTvTYpvp7GuV4D8C3XRPPRYQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49---OYFUnlOG-Ob-HxiF-4dg-1; Tue,
 17 Feb 2026 09:33:00 -0500
X-MC-Unique: --OYFUnlOG-Ob-HxiF-4dg-1
X-Mimecast-MFC-AGG-ID: --OYFUnlOG-Ob-HxiF-4dg_1771338778
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9C4118004A9;
	Tue, 17 Feb 2026 14:32:57 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.81.92])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8412419560A2;
	Tue, 17 Feb 2026 14:32:54 +0000 (UTC)
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
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: fix flaky build_id test
Date: Tue, 17 Feb 2026 09:32:35 -0500
Message-ID: <cover.1771338492.git.grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

changelog:
 - fixed indentations
 - removed trailing whitespace
 - add space between opening and closing brackets
 
Gregory Bell (2):
  selftests/bpf: fix flaky build_id test
  selftests/bpf: align build_id test mapping to 64K page size

 tools/testing/selftests/bpf/uprobe_multi.c  | 19 ++++++++++++++++---
 tools/testing/selftests/bpf/uprobe_multi.ld |  4 ++--
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.52.0


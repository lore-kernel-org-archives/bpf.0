Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C773E9F9D
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174082; cv=none; b=IORoyQOoAgGRrQddz35UNcRSPDp4/pUa0weq/C33QpfkRUFxTJ+nWuaN12u1Z3FDFxCMf5V+rRt/NeUkX9J3OYJ3eJNK12m+DZ4BRTAYYC80Zu5uIt/ZIsXVQAb3BeB2vicjtC1NSyTNxUrTy3ctLsPj/TSTp85a4+DuRyZ/jlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174082; c=relaxed/simple;
	bh=MAAuyB9Pcwe4MtJ7KeINtACUoYETJVIh5qhuPRUlMOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8w8LgR+uVYKhLmG/ZSJSILuOZgwXK87gY6JhEjkItBr/OalrAfnQcP/UhJXQuA49k5MMEeIa/iESjSBYcd+Uf9C/kpSQHUC3nbitGy6Y3Hx+150TfiqqChIckzjFSV/LVnvlEaXT03yFiX/C0ac5s3i7lGwYOckC1gzCrMfeNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5Ueet9G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5Ueet9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773174080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ToviXSUiN9JXVnvuExY/Z+f/0xWgRGfNYe4mMPqlw/M=;
	b=i5Ueet9GoAHOQq38y7LgkxoszN04jalLBwME+lYZ1e53cmBB1AXxCmV0x2Sya/6bDTjbCx
	e6IiEBDwBAQ11tAbsR6jBBw3Yakp9VJQNfsRH60Kfye5xQIWFd3mYpgfi3CPOxP4OM0Izu
	aa7E+iO7ytXggDTijWG6wB5qWpyXDbI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-75adqp5JMjeSaPsSZoBDRg-1; Tue,
 10 Mar 2026 16:21:16 -0400
X-MC-Unique: 75adqp5JMjeSaPsSZoBDRg-1
X-Mimecast-MFC-AGG-ID: 75adqp5JMjeSaPsSZoBDRg_1773174074
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26A621956054;
	Tue, 10 Mar 2026 20:21:14 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.80.152])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7000B180049D;
	Tue, 10 Mar 2026 20:21:11 +0000 (UTC)
From: Gregory Bell <grbell@redhat.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	Gregory Bell <grbell@redhat.com>
Subject: [PATCH bpf-next 0/1] Fix BPF struct_ops BTF cleanup race condition
Date: Tue, 10 Mar 2026 16:21:01 -0400
Message-ID: <cover.1773170190.git.grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This patch fixes a race condition in BPF struct_ops where consecutive
test runs fail due to a timing mismatch between BTF object cleanup and
BTF module removal.

When running BPF struct_ops tests consecutively, the second test fails
because BTF object references take longer to be released while their
associated module is removed from btf_modules list immediately
during module unload. This creates a race condition where the second
test retrieves the cached BTF object but cannot find valid module
information, causing btf_try_get_module() to return NULL.

The fix synchronizes these cleanup operations by waiting for active BTF
references to be released before completing module cleanup, eliminating
the race condition.

This issue is reproducible with any of the following tests: global_map_resize,
pro_epilogue, struct_ops_module and struct_ops_multi

	./test_progs -t global_map_resize; ./test_progs -t global_map_resize

	#134/1   global_map_resize/global_map_resize_bss:OK
	#134/2   global_map_resize/global_map_resize_data:OK
	#134/3   global_map_resize/global_map_resize_invalid:OK
	#134     global_map_resize:OK
	Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
	global_map_resize_bss_subtest:PASS:test_global_map_resize__open 0 nsec
	libbpf: map 'test_glo.bss': cannot be resized, last var must be an array
	libbpf: map 'test_glo.bss': failed to adjust resized BTF, clearing BTF key/value info: -EINVAL
	global_map_resize_bss_subtest:PASS:bpf_map__set_value_size 0 nsec
	global_map_resize_bss_subtest:PASS:resize 0 nsec
	global_map_resize_bss_subtest:PASS:percpu_arr_resize 0 nsec
	global_map_resize_bss_subtest:PASS:array_len 0 nsec
	global_map_resize_bss_subtest:PASS:bpf_map__initial_value (ptr) 0 nsec
	global_map_resize_bss_subtest:PASS:bpf_map__initial_value (size) 0 nsec
	libbpf: map 'st_ops_resize': failed to create: -EINVAL
	libbpf: failed to load BPF skeleton 'test_global_map_resize': -EINVAL
	global_map_resize_bss_subtest:FAIL:test_global_map_resize__load unexpected error: -22 (errno 22)
	#134/1   global_map_resize/global_map_resize_bss:FAIL
	global_map_resize_data_subtest:PASS:test_global_map_resize__open 0 nsec
	global_map_resize_data_subtest:PASS:bpf_map__set_value_size 0 nsec
	global_map_resize_data_subtest:PASS:resize 0 nsec
	global_map_resize_data_subtest:PASS:percpu_arr_resize 0 nsec
	global_map_resize_data_subtest:PASS:array_len 0 nsec
	global_map_resize_data_subtest:PASS:bpf_map__initial_value (ptr) 0 nsec
	global_map_resize_data_subtest:PASS:bpf_map__initial_value (size) 0 nsec
	libbpf: map 'st_ops_resize': failed to create: -EINVAL
	libbpf: failed to load BPF skeleton 'test_global_map_resize': -EINVAL
	global_map_resize_data_subtest:FAIL:test_global_map_resize__load unexpected error: -22 (errno 22)
	#134/2   global_map_resize/global_map_resize_data:FAIL
	#134/3   global_map_resize/global_map_resize_invalid:OK
	#134     global_map_resize:FAIL

After the fix, consecutive runs work reliably without requiring delays.

Gregory Bell (1):
  bpf: Fix BTF module cleanup race condition in struct_ops

 kernel/bpf/btf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.52.0


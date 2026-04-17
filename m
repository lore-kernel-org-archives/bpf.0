Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256D3358BE
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440497; cv=none; b=lIzLj9pLKlN2p1D3gDf/9t1buVoa6ZDnnxAczkk8TfTRCosoeCGDiowa6R+1bBBGtZSr2l974b9g/mZvvfjFGQffMfNEayrP5LL1arUYv/mewVr88TR5Ukw7iwKckDZ/eO2AlAWgioVrytLY1Xo8ciZjSZyEGdi8RyCXkAeGaS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440497; c=relaxed/simple;
	bh=ALvey8P6YKlPV4oOQQFaGesCfd0V1JWHK8yL3kozQ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gtUjJyFDa9ln5fGu1RoCtuGXm3bfCxfgu/e96yiCi0Gm8gJRxqb9tm5Ty9WtS/FG0Cf/MRAXXbxD5wnZ0PROrRlR/F/Cp6KE80jIvsgjOmjQPqq8FM+DZjKZ1ynzAGcYs3jdwWVJp+cslWNzkNJYBMRHaV7U9AJYQVYqqiF/XsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtDmjSJn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtDmjSJn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776440495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IqhjsGVXi8xeQG3XCPpwpdp+0A0uMM2OQLLGbUQdbEw=;
	b=WtDmjSJni91r97HLHNEMHM7dvQMwFN9BIfmbmhXtGKJ0+GCgOsCgYqZuSfqNRe3XvPJgzS
	HSiS4YD9bvVyDb+h37ekTRx3oPBvNI2dG3R2/L5U5OVbS8jH2JbyHOsFEDGc7ha7S1IP42
	9KT1lybbcVLXrYfhVvlB5ATPTC8/Cl8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-siVA9b6kPP-XSDA0cLjQ7Q-1; Fri,
 17 Apr 2026 11:41:31 -0400
X-MC-Unique: siVA9b6kPP-XSDA0cLjQ7Q-1
X-Mimecast-MFC-AGG-ID: siVA9b6kPP-XSDA0cLjQ7Q_1776440488
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0663519560B0;
	Fri, 17 Apr 2026 15:41:28 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.88.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 203FA195608E;
	Fri, 17 Apr 2026 15:41:25 +0000 (UTC)
From: Gregory Bell <grbell@redhat.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	alan.maguire@oracle.com,
	Gregory Bell <grbell@redhat.com>
Subject: [PATCH v2 0/2] selftests/bpf: Use local types for kfunc declarations
Date: Fri, 17 Apr 2026 11:41:20 -0400
Message-ID: <20260417154122.2558890-1-grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The xdp_flowtable and test_tunnel_kern selftests were previously
rewritten to compile with CONFIG_NF_FLOW_TABLE=m and CONFIG_NET_FOU=m.
While the compilation issues were resolved, the tests fail at
runtime. In test_tunnel_kern.c, struct bpf_fou_encap___local is
defined with the correct fields but the kfunc declarations still
reference the forward-declared struct bpf_fou_encap. Similarly,
xdp_flowtable.c uses a forward-declared struct flow_offload_tuple_rhash
as the return type for bpf_xdp_flow_lookup(). Clang emits these forward
declarations as BTF FWD types, which fail to resolve against the
module-defined STRUCT types at run time:

libbpf: extern (func ksym) 'bpf_xdp_flow_lookup': func_proto [51] incompatible with nf_flow_table [128640]
libbpf: extern (func ksym) 'bpf_skb_get_fou_encap': func_proto [79] incompatible with fou [135045]

This patch updates both selftests to use ___local type suffixes
for kernel struct type, replacing the forward declarations.

struct flow_offload_tuple_rhash___local is defined without fields
because the test only uses the returned pointer for a null check.
This avoids needing to locally define its nested types,
struct rhash_head and struct flow_offload_tuple.

I understand that fixing selftests for specific config options is
generally not a priority, but since these tests were already
rewritten to support these configs, they should work correctly
with them.

Fixes: d17f9b370df6 ("selftests/bpf: Fix compilation failure when CONFIG_NET_FOU!=y")
Fixes: eeb23b54e447 ("selftests/bpf: fix compilation failure when CONFIG_NF_FLOW_TABLE=m")

Signed-off-by: Gregory Bell <grbell@redhat.com>

change log:
[0] https://lore.kernel.org/all/cover.1776280396.git.grbell@redhat.com/
- Add BPF_NO_KFUNC_PROTOTYPES macro to test_tunnel_kern.c so the test compiles 
  when CONFIG_NET_FOU=y. Without it the function prototypes conflict with vmlinux.h

Gregory Bell (2):
  selftests/bpf: Use local type for flow_offload_tuple_rhash in
    xdp_flowtable
  selftests/bpf: Use local type for bpf_fou_encap in test_tunnel_kern

 .../testing/selftests/bpf/progs/test_tunnel_kern.c  | 13 ++++++-------
 tools/testing/selftests/bpf/progs/xdp_flowtable.c   |  7 +++++--
 2 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.52.0


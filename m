Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11121D3F4
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776283239; cv=none; b=tHQI/99a5Ft1zJzCgmHnxtXrKc7iXWjQsuvcsTGEFbejYY33nkw50rKkGvE2fhA/fdfCURhdimYWpCq8r+2BkqBaioGSiMAYRbzqcji10xIqYPcOoyfE9i8oZk5tnDWxLAKzFLHEeO4vBC7pNQtuvP5Vw2pe40sn6a1dwq4HBPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776283239; c=relaxed/simple;
	bh=BbP/AOA8v9F/vBRq/NU6JOvUgvclQ6IE1liN3LTUCcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFFvelYSQJft33Nxf7pBVlaNy0MXMyd/SZgS8sRj/ibvHxyErQBQuTRLpLtZFPbXGQ/AKLVJMGFm/oBOIIOmZUZ7ByJjFLA35SBrv/sq02x/QkthT4odHK6QmjsYoWk7x5Y+/0Ht/ZDybS72n53F+2Ntu5m6eNAknsSNwcAWqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHcaEy+X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHcaEy+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776283237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=15PtybODMJ7suSOD+R2pBnghD+nP2cyGJ50nP85AKxA=;
	b=WHcaEy+X6uXBtS9dl4+ir+KYQPIr3PvImMpq0NyIAAI+H7aZtR9ty36/WsDGDFPYXEGR1D
	3Yv7xGgUnX05YHFS04W84Iwh4cMeRFZ7QB+6w48fhREIUiOGs4ExFWuQrVTJJvvKzATJBb
	Ojmohu103x9NgB/lP/rXheeVtw19gHs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-4dNQZr5UPhS2cmms9tMMgg-1; Wed,
 15 Apr 2026 16:00:29 -0400
X-MC-Unique: 4dNQZr5UPhS2cmms9tMMgg-1
X-Mimecast-MFC-AGG-ID: 4dNQZr5UPhS2cmms9tMMgg_1776283226
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26C8A1800366;
	Wed, 15 Apr 2026 20:00:26 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.88.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D086A1800446;
	Wed, 15 Apr 2026 20:00:21 +0000 (UTC)
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
Subject: [PATCH bpf-next 0/2] selftests/bpf: Use local types for kfunc declarations
Date: Wed, 15 Apr 2026 16:00:12 -0400
Message-ID: <cover.1776280396.git.grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Fixes: d17f9b3 ("selftests/bpf: Fix compilation failure when CONFIG_NET_FOU!=y")
Fixes: eeb23b5 ("selftests/bpf: fix compilation failure when CONFIG_NF_FLOW_TABLE=m")

Signed-off-by: Gregory Bell <grbell@redhat.com>

Gregory Bell (2):
  selftests/bpf: Use local type for flow_offload_tuple_rhash in
    xdp_flowtable
  selftests/bpf: Use local type for bpf_fou_encap in test_tunnel_kern

 tools/testing/selftests/bpf/progs/test_tunnel_kern.c | 12 +++++-------
 tools/testing/selftests/bpf/progs/xdp_flowtable.c    |  7 +++++--
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.52.0


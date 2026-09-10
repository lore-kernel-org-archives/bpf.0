Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC0489FD1
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048966; cv=none; b=rsjsOUvSARuLXpsb/Dm+/VSjwDsxFlF81eVegsyWiEmJCc22uDM45wKegi9jsH41XcnwLAyJlC7DIuEL7h82xXDLnM/DHogOql4H250WwUaHfSURPYs38h53pvoEmpWrebVG2KFyomldz65mlvjNllDT5MWkMssmXjS3JkKEWxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048966; c=relaxed/simple;
	bh=AoTffK0RVfMhEWJqOE4dbqbkq21vbNmGEqhBV8DDP2A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EYJnL4jcySrmBvR6PbbdAVGnB4Nn5ZSCvg87vVIT82lyn+5cTzbndKOe6XET2S34Y/dqo8Qa4dQ1UQawmVUMDuuFAm1/CCf0IusUiC1tFhO0Pemp1N0PtM3E4mi3tCi3ZWRbOIBOc8hwFS6m0Qc41OiB0mlzZfgOBYa2pLJefS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JodYtPE6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JodYtPE6"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c294bdd76cdso131940466b.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048963; x=1789653763; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZzCWTwY8rHBsIIFWY/SX91KgLEXQq69JPWWLlcB9jtc=;
        b=JodYtPE6cIaALgHwud+t5DvyT3NAPGrDDZk4ZdbqB6XW9Yx85ncn9KZJceo6UQ49FD
         mcEqQiVzUGCp0ZgIH8QxpOvkhHYBB4Txk/oflF5kZniicWp4ZESilHtkNQ+a1hRqPIlO
         9Dxz3autJ++4rWPqgprMYI7EXrB3ql2DX0mmKLS4Gq8y5aLucBx9eHYTxnCEwMdNBf18
         hIS2NVPyz1wPXFPfHaBqQ9/2gTodJxynD8knrvo6zimE9+JtzUooB0XnR05a5E1G4S68
         FseZwaV1amNlqi4Oh+Q0UMyZfMK1axM07OQyN1apEKITf8tCHi91UM5UkzKA151VO+X2
         r8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048963; x=1789653763;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZzCWTwY8rHBsIIFWY/SX91KgLEXQq69JPWWLlcB9jtc=;
        b=qZZafjhcnauA9wKNsQZIMp1pljzS9tnRQrPTpDu4PkSrfZosuzfPWbM5Ai4+AQ5Dn5
         lxIRFaeICKbwXLFDoHbYtXJgopucrxVg5g3y7NhcgazkJQXIM5528YxEoqU5vDxONs1z
         OSKdGCfOThl7/v8E9Jdrj5oL2F18f3WRO/ajwmHZbcK9c3CtrTWN+eFNMpiK9AJo6I4m
         Wm0hGFaWT0EdwOcCzjnYWJqWH8Te7NY6rvubamQWX+NYE7QfRC7j8nyelhy+S7KIF3mV
         pjlFU2JP/83YgWTmduBnnSdOKXXPu6yE9OFZRNUunSKmi3898WbtLMTwD3U5Mvxvm2sr
         x50w==
X-Gm-Message-State: AFuF++m8H9zlQgdNi/TdhXse1SZag/UUDBuJhEUwKf94lqGzG5mpfZwo
	84PRFy2sFRL/tGBvmj28dF1Ae78y/XC5zQEoELlimly7g/60dANfA5GlOAOwVyIFTGk=
X-Gm-Gg: AYBFou2cOXG2Vr351bOgeQyp7ESupbylEd8Qjw0m1WBR69zvGauqzekugrJ4BIIOB0t
	bhWevTWgOy78Jw0DLCkkhSqi/EXwp/ASkfkjUSfiVJEPGbEyU5ch02h8MNYR7PmcRfX/fo2ihdw
	0RLeDZWUPEimbArnpdtTA6NZitS38K2eL/GYzIqRlLfZmkOo9aDuzSe3olMbQlhZP7OgIzNMyrw
	0GP6IvQS8g+QeWBAkDlEc+XwlVdsxAlEFE1Jo0z4Nk/Gx9uSwVaYYBTuISpobfZNrLAHtU0JgDq
	FdDLrQpAZKgjzqH0YgnUjxKfB44Az2aBdwbGNuT14hAf7O2rIbR4NCDhM847MWpt08P9kUeWs/2
	1wD3DXnyqvQY+rV4Yj1K2fCBEK/HWG1p0RWxhGSFxNd7G/NHwTw//zC2ssUeqyjEMG/yjHO4PUG
	WETEfoodHzMyE4gsDy6hiF4BHZ8Xth6q5hogLI6qMf1rgI7elAy7rY5SJagQ1rFwDfEPuJkqv1H
	yvIHSUMygv1zQpDDIehOpxchNIUlMbTLSbIxs7YNtoweP3m
X-Received: by 2002:a17:907:940b:b0:c26:1691:b366 with SMTP id a640c23a62f3a-c261691b9d4mr1613152666b.31.1789048962854;
        Thu, 10 Sep 2026 07:02:42 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5b371esm924512366b.54.2026.09.10.07.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:42 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next v2 00/14] skb extension for BPF metadata
Date: Thu, 10 Sep 2026 16:02:35 +0200
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHu4omoC/4WOQQ6CMBREr2K69htapa2uvIdhAe2vVKGQthAM4
 e5CXRrjcjIzb2YmAb3FQC67mXgcbbCdWwXb74iqS3dHsHrVhGWMZ5wdoeoNtBhLsC5YjRCeFeA
 UwRhG1ZlKlMqQtd17NHZK5BtxGMGtKVJ8nDBUD1RxA2/Z2obY+Vc6MdLUSHuCnn7ujRQyyKWgK
 hOl1JpfVdMN2jSlx4Pq2o2bIPIfRHCBWkvOeP4FKZZleQOPpjdbJAEAAA==
X-Change-ID: 20260623-bpf-meta-inside-skb-ext-ff21c918e8cf
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Jack Wang <163wangjack@gmail.com>
X-Mailer: b4 0.16.0

This is the second spin of the per-packet metadata for BPF. See the RFC
cover letter for the full overview and motivation [1].

Since v1 the focus has been on getting skb scrubbing and extension sharing
right, driven by Sashiko's review:

1) skb scrubbing now simply deactivates all the extensions but the BPF
metadata. Made possible due to recent change in skb_ext_del semantics [2]
that already landed in net-next. Thanks to Florian and Paolo for guidance
on this.

2) Clones made by bpf_clone_redirect() share the extension block. A write
through a previously acquired writable dynptr would land in the shared
block and become visible to the clone, so v2 makes such writes fail until
the program re-acquires the dynptr with BPF_SKB_EXT_F_CREATE, which COWs
the block into a private writable copy.

3) Re-acquiring the extension with BPF_SKB_EXT_F_CREATE can COW and free
the old block, so a dynptr slice taken before that re-acquire would be left
pointing into freed memory. bpf_dynptr_from_skb_ext() is therefore marked
packet-changing, making the verifier invalidate such slices and forcing the
program to re-take them after the re-acquire.

4) Tracing and LSM programs can run on a shared skb concurrently on another
CPU, so creating the extension there would mutate skb->extensions without
synchronization. v2 rejects BPF_SKB_EXT_F_CREATE in these program types at
load time; read-only access remains available.

Regarding performance compared to consume_skb+kfree_skb tracepoints, I have
not yet re-run the experiment measuring the overhead when attaching
metadata to 5% instead of 1% of skbs in flight; happy to do so if it is a
blocker.

That said, as things stand we have already established in v1 [3] that for
our existing use case - attaching metadata to <1% of skbs - the
tracepoint-based approach is prohibitively expensive (+5% of CPU time), as
Jesper noted.

The skb-extension-based solution, in contrast, shows comparable-or-lower
overhead, making it a viable drop-in replacement that enables new use cases
for us and potentially offers a performance win.

Thanks,
-jkbs

[1] https://patch.msgid.link/20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com
[2] https://lore.kernel.org/all/20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com/
[3] https://patch.msgid.link/20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v2:
- Rework skb_ext_scrub() to simply delete all extensions but bpf_skb_ext
  now that the delete operation is idempotent. (Florian, sashiko)
- Fail writes through a dynptr while the extension block is shared with
  clones: bpf_dynptr_write() now returns -EBUSY and bpf_dynptr_slice_rdwr()
  returns NULL; re-acquiring the dynptr with BPF_SKB_EXT_F_CREATE COWs the
  block and restores write access. (sashiko)
- Mark bpf_dynptr_from_skb_ext() as packet-changing so the verifier
  invalidates slices from an earlier dynptr when a re-open with F_CREATE
  can COW the block and leave them dangling (use-after-free). (sashiko)
- Reject bpf_dynptr_from_skb_ext(BPF_SKB_EXT_F_CREATE) in tracing and LSM
  programs, which can run on a shared skb concurrently on another CPU;
  require a constant flags argument without F_CREATE at load time, keeping
  read-only access. (sashiko)
- selftests: Add verifier negative tests for the new tracing/LSM
  restrictions (F_CREATE and non-constant flags rejected). (sashiko)
- selftests: Add clone_redirect coverage into the cloned-skbs test
  (clone_redir_ext_write_after / clone_redir_ext_slice_write_after),
  queueing the clone on a netem-delayed loopback; enable
  CONFIG_NET_SCH_NETEM.
- selftests: Fix if_nametoindex() assertions to use ASSERT_GT(..., 0) so a
  lookup failure is not silently accepted as ifindex 0. (sashiko)
- selftests: Use int (not __be16) for get_socket_local_port() so a negative
  error is not truncated and masked. (sashiko)
- selftests: Validate send()/recv() return values and switch the sk_skb
  stream test to recv_timeout() to avoid a hang when the data path
  regresses. (Jack Wang, sashiko)
- selftests: Split the LWT test cleanup so bpf_tc_hook_destroy() does not
  delete the base-namespace clsact qdisc on the error path. (sashiko)
- selftests: Unify multi-line function comments to the "/*" on its own line
  style. (sashiko)
- Link to v1: https://patch.msgid.link/20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com

Changes in v1:
- Don't scrub BPF skb extension. Remove F_NO_SCRUB flag. (Stan)
- Allow calling bpf_dynptr_from_skb_ext from NETFILTER, LWT_*, SK_SKB progs.
- Reorg tests into smaller commits. Add missing coverage.
- Link to RFC: https://patch.msgid.link/20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com

---
Jakub Sitnicki (14):
      bpf: Introduce per-packet metadata storage for BPF programs
      bpf: Allow access to bpf_sock_ops_kern->skb
      bpf: Make BPF skb extension survive packet scrubbing
      selftests/bpf: Add tests for bpf_dynptr_from_skb_ext
      selftests/bpf: Test skb_ext on cloned skbs
      selftests/bpf: Test skb_ext survival across veth and GRE
      selftests/bpf: Test skb_ext read from cgroup_skb and sk_filter hooks
      selftests/bpf: Test skb_ext read from sock_ops and LSM hooks
      selftests/bpf: Test skb_ext read from kfree_skb tracepoint
      selftests/bpf: Test skb_ext read from netfilter hook
      selftests/bpf: Test skb_ext from LWT in, out, and xmit hooks
      selftests/bpf: Test skb_ext read from seg6local End.BPF hook
      selftests/bpf: Test skb_ext read from sk_skb stream verdict hook
      selftests/bpf: Use non-trivial test payload in xdp_context tests

 include/linux/bpf.h                                |   10 +
 include/linux/filter.h                             |   27 +
 include/linux/skbuff.h                             |   13 +
 include/uapi/linux/bpf.h                           |    5 +
 kernel/bpf/helpers.c                               |   21 +-
 kernel/bpf/log.c                                   |    2 +
 kernel/bpf/verifier.c                              |   25 +-
 net/Kconfig                                        |   20 +
 net/core/filter.c                                  |  149 +++
 net/core/skbuff.c                                  |   27 +-
 net/ipv4/udp.c                                     |    6 +-
 tools/testing/selftests/bpf/config                 |    2 +
 .../selftests/bpf/prog_tests/socket_helpers.h      |    1 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    2 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 1117 +++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  569 +++++++++-
 .../testing/selftests/bpf/progs/verifier_skb_ext.c |  122 +++
 17 files changed, 2094 insertions(+), 24 deletions(-)


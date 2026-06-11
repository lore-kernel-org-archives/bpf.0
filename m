Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C072D73BC
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181453; cv=none; b=jBOoimgmsai7Tem45LggtIMM+MJ8buHgM+vrs8cD2WWVSyTIdQlVRpsDNWYlc/tH/B28Wsxx0l0xvo1M4YjYYBDtGZS/J0KnODaLdwZ5h+KAX3BF7XzrcIopnaJfrZiWBDMtOKE9c6Q9x9JAphbBzQDR6KpfS8DNT91idEnsTC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181453; c=relaxed/simple;
	bh=8b/7eQFjT+UITLfSGtnmzyLGSOXLDyFeawmU0GSKuxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WaI6uOXSaKNeNyK13tRGXCiqci65ynb1P9fRcU4xX3r0TA16bod0/NGR7wHWGrg8VMyGz5Tv7VdX/VWdYaV8+aGt8tkEr6oo7HVOHZJuGBmApQ2nmIV94vrnqb511yMhhvKSiw1CKUyzt0K/mvFt4JW5h8yK9Q3aqRbYsgnoIoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lZj32ePO; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lZj32ePO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781181439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YYHg5dkLLTur5IAmFlDfUGRLb6K3EKX9VBpaTCIihkU=;
	b=lZj32ePOnIe61cEiX71wq5QJaaiIJUG4Ri/naMj9N5/IWHFQyjNNAjZ1s+nWJP9xyuV/3A
	T0MhotjaoV31MmhwDsuhbPrhEtBIVkQrnOuG/+LfH32nUErO3IL9As3scKofyMPbjqrrDy
	mAfHn1nJc16IJQk1d2ZrwHeIRiJ0Qc8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Cong Wang <cong.wang@bytedance.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 0/7] bpf, skmsg: some fixes for skmsg
Date: Thu, 11 Jun 2026 20:34:08 +0800
Message-ID: <20260611123538.156005-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


All fixes are from previous patches sent by Weiming Shi, Zhang Cen,
Kuniyuki and Sechang Lim, which have already been reviewed by me and John and Jakub.

https://lore.kernel.org/bpf/20260610081218.506709-2-rhkrqnwk98@gmail.com/
https://lore.kernel.org/bpf/20260520102715.3033936-1-rollkingzzc@gmail.com/
https://lore.kernel.org/bpf/20260424190310.1520555-2-bestswngs@gmail.com/
https://lore.kernel.org/bpf/20260424191602.1522411-3-bestswngs@gmail.com/
https://lore.kernel.org/bpf/20260423155807.1245644-2-bestswngs@gmail.com/
https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/

The automated reviewer (sashiko) may still flag a few other potential
issues on top of this series. After looking into them, they are either
already covered by the patches here, or only reachable under very narrow
conditions that require a specially crafted BPF program and an unusual
sk_msg ring state, so they are not practical to trigger and are left out
of this series. I'm collecting these fixes together because the same
problems have been re-sent many times in slightly different forms, and I
hope this series can be prioritized for merging so the duplicates can
finally settle. With so many AI-generated patches floating around for
these spots, leaving them unmerged just keeps wasting maintainer review
cycles on the same issues.

v1->v2: fix problem when fix the conflict.

Kuniyuki Iwashima (1):
  sockmap: Fix use-after-free in udp_bpf_recvmsg()

Sechang Lim (2):
  bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
  selftests/bpf: add test for bpf_msg_pop_data() overflow

Weiming Shi (3):
  bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()
  bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
  bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data

Zhang Cen (1):
  bpf, sockmap: keep sk_msg copy state in sync

 net/core/filter.c                             | 99 +++++++++++++++++--
 net/ipv4/udp_bpf.c                            |  9 ++
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 48 +++++++++
 .../bpf/progs/test_sockmap_msg_pop_data.c     | 27 +++++
 4 files changed, 174 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c

-- 
2.43.0


Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675FC3B4EA5;
	Mon, 17 Aug 2026 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999746; cv=none; b=l7JNN9GvouFPlwWQZ3DIQf6gdeie108GNAusgtvUQ2FYmvwN18TBEDavpvh7uu9ivPceLkDlE7MGLwHjtb+dsAmQDIeDFolpqM9ub+0eoRL9AQXApKeYedKXNazUQIH6IqmfEzb6zr2COEnTq+7xIJBECXBRHyAka7l4U7mN6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999746; c=relaxed/simple;
	bh=Zz6vKr+GZTpCITY+IDx9ai59IHH63ggaEJd9wjoO/aA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FmOGzfWbteewXuisvC54mrfhKxcZp9eTRa883/BgfgiW2v2dI3fWkSxQDQ2lhv+Uply2ZPhFXHESEFO+02AR010A3BqV93mFbTZbcIXcWvclVr1BY4xy2QNDkB7MhNBwlXrjRBWbm6+Z9fh/oC8l4djSR6f+6hcD3+Ad0WEinq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=JoaEAYSc; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="JoaEAYSc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AnTXcLsr9bIZhEz+JJf1TFg+oAF8a4c/J+0ra6usZ+o=; b=JoaEAYSc+jC8GJ7k0dJxCwDFez
	pHCZ+/o7koT7iMlfqVl9XTU0oDsIm/hgAb5NsbVx7eQ/VKVCigaEdbrPSQvhfVUK7NJYzfYJknL7T
	aX2HIAEUjdEA0Vq8+zdvSxg6rxw+1jYW0uHZXgrgly9QuShM3/73C3dINkY2tWC3kES4bFtRIKnjA
	V0WYBFmpEJ7oiAuXbVbo/N5vEutyZR/NDiYKmuokvBsEsq2qiuRF7u/A0gOUjx71/ToDE3vLhTUFy
	BbGVDVpSr6pJFue1A6YdHDK2pHwWZyUXg4YkRBE6YzK3/xSJ2IsU7Xara9QprehwBGiyPaA3sQ0Et
	zjk3mAag==;
Received: from [151.115.150.205] (port=43084 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1ww4GN-0000000CoBp-0CrW;
	Mon, 17 Aug 2026 22:48:54 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v2 0/2] bpf: reject stack-argument callback subprograms
Date: Mon, 17 Aug 2026 20:48:10 +0000
Message-ID: <20260817204812.1637171-1-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

Thanks for the feedbacks. Here is the v2 that splits the patch into
two commits. I hope I made it correctly.

/Jérémy

---

Helper callbacks enter BPF subprograms through bpf_callback_t, whose
runtime ABI supplies five arguments. BTF validation nevertheless permits
static callback subprograms to declare more than five arguments when JIT
stack arguments are supported.

This lets verifier state for a callback use outgoing stack argument slots
prepared at the helper call site. The helper does not pass those slots. On
x86-64, callback loads of arguments seven and later therefore read the
helper native frame instead of the synthetic values checked by the
verifier.

This series rejects callback subprograms with incoming stack arguments and
adds verifier coverage for the rejection.

Changes v1 -> v2:
- split the verifier fix and selftest into separate patches;
- drop the callback-specific verifier log message and stop matching it in
  the selftest;
- use __clobber_common plus r6 in the selftest.

Jérémy Jean (2):
  bpf: reject stack-argument callback subprograms
  selftests/bpf: add callback stack-argument rejection test

v1: https://lore.kernel.org/bpf/14a7e7c2-36f7-4aa2-9b20-cc54700a9f1b@linux.dev/T/

 kernel/bpf/verifier.c                         |  2 ++
 .../selftests/bpf/progs/verifier_stack_arg.c  | 32 +++++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.47.3

Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BA6476CF9;
	Thu, 13 Aug 2026 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786624962; cv=none; b=H4yY3onkhcyPFzo//EfSZgG4HwU+dFLSIyrIKd9pNxhG6X/O5xD/KdHieXln9qabss3F+IhGb6iUa4VFllfKjHL521PmOQkGC/6PeVyFqI9rjSYIsd4Ql3w++C3i1Cragn9S5utupRS4rbZ59ArFec6Y42oBuT3s0mG9BEmDsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786624962; c=relaxed/simple;
	bh=B2RyFg/AGbkbG1K1Z3xZi6c0vkf/D2klxlraeSeY4/s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JLQpibf8s/xG4ajbKlc4PSZvc/SHX4tFOasow1+ehjP50bf616dBuTcBF2Rx6sLBEygr6uTblQ30+poz7zxMEYlTsMKln63SlXaPwwdAaTAksUSfPcvcdn6RZUSLGYKzQZ116htxJdyYTmA/IEp/St1LdJ5ixE4NSPUDPFqXKyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=mkWgOQFh; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="mkWgOQFh"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wuUlR-002U7n-Ny; Thu, 13 Aug 2026 14:42:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=z0qDURD+TyKvmTkMZ4uQZFnNZ/ey+9A/mn1mDzPx588=
	; b=mkWgOQFhvgbD0/a6PHYpfkY2nztKXHn/C5klUA8DTpZ3+HnTAp70mQgbxPkvXJ6LDRdgsRX50
	orfghEi8haH9gidDF9WppMdekuAB/CAINhCSED/urZoxbFmZ8BN4TKbvzZ0bpb2zynFDb0CkAg2M7
	J3WPBzp0L/oqmuswCQJwU9R6phF5futWlEVwQAu2nJPEmAZLAPs45lZ3ph7YjOKFrZzuw8+vU9p7H
	aZYnwhaYNKFDWwVrcHL989c4Hp5cjbE8KRvx133Tlfn2bxFnXWcfY1q+2MO8QbpVHggJlwm5QlOKv
	FB1zb7yCeD5Zb8xsrDeFg2acT5dzQokoxyKYAQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wuUlQ-0000DP-NG; Thu, 13 Aug 2026 14:42:28 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wuUlD-001YW5-Jj;
	Thu, 13 Aug 2026 14:42:15 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf-next 0/2] bpf: Cleanup & optimization
Date: Thu, 13 Aug 2026 14:41:58 +0200
Message-Id: <20260813-sockmap-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBBFr0Jm7SSlGDRexbiAOoMj2jadQkgId
 6fo8v2f91ZQSkIKt2qFRLOoBF+gPlXgXp0fCOVZGKyxrbmaBjW48dtF/IQwThEHypiIseFLS2d
 XM5OFIscyyvIL36GPjJ6WDI//o1P/JpePLmzbDg1xJV2EAAAA
X-Change-ID: 20260803-sockmap-lookup-get-ref-3f76e4c1ffe2
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Non-functional cleanup and a refcnt bumping simplification.

Series extracted from a fix attempt[1] currently under discussion.

[1]: https://lore.kernel.org/bpf/20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (2):
      bpf: Extract shared reqsk-to-listener upgrade
      bpf, sockmap: Use sock_hold() instead of refcount_inc_not_zero() in lookup

 net/core/filter.c   | 58 ++++++++++++++++++++++++-----------------------------
 net/core/sock_map.c |  8 ++++----
 2 files changed, 30 insertions(+), 36 deletions(-)
---
base-commit: 6f033615ef8fb2374daa7e50a8ff68616bc850d2
change-id: 20260803-sockmap-lookup-get-ref-3f76e4c1ffe2

Best regards,
--  
Michal Luczaj <mhal@rbox.co>


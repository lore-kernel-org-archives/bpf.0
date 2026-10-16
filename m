Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E63D0919;
	Fri, 16 Oct 2026 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792188855; cv=none; b=fsFS1y+ZrVr47kQGzkubiL9CimE0oiJfT6/XyrtrvkKTwlQuS6ogGOQ/B7yWrM1Co1R2UJBD/ULWTv5scLBk3ry9Kfo/C4eE7HNoGbYT/ipkWf56Etg32M+8WAXfR54M6hW76KprBmIRLoZZAiJ7243kVvBoE/J4JlN6n8DN7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792188855; c=relaxed/simple;
	bh=VjnOgRf/vzS0Qw2W1u4f4sJ7ki0rNAEg6xtHGo3pg8o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X41iY9ItogNt79+jCqIykNlA0kYEsTAPWyDpeN2lKAIu2KooNj3hgHQWg1YgedDTL+aNX4qfp+DWZhXqGDkr5eiSpyg8PetVj3PqqFvUtq2IrJLhASBQAeEBEOjeL5sXkSf6V7xxzEXpS+nbAx+CbP7GdVFwjYudsqlF/zmg90c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=V+X/WUVL; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="V+X/WUVL"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xHpC3-00Csi4-LW; Fri, 16 Oct 2026 23:10:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=l459rReme3m9xUy/xeunU376dytq1eQbs4qJt+fMUNo=
	; b=V+X/WUVL7ay13PKg8cQaYK/rhEHpBstkjOvqmuu6AeAZL1LWXdXdqUK6NZA2Owt/S1EXrhjVM
	XJKeRkXOrX3n0sV0Wen1p25Fa1pZOapQXzLuvKG1odOXDqEtPUOfvwUB5fGNdE6bc7+8lGhPFSpP/
	mmKZzN4l7gREas6zua2aH7BqgZLJCMIFhX0ai6plugVbFEsLMAQLKvpSqliTRbyO47MH99vSzlfAc
	wo5Gt+VuEPI3Oyw2Wsk5+16cOS9CKc+KpL52P5j3AKo1xhkfy5pV4DdF8PU3uqeRnBFqNDZ9KSNL7
	b5cKLpTme5BFbcYnfu3hqRmnRsUDeB+txyVsbQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xHpC0-0000vk-Qv; Fri, 16 Oct 2026 23:10:20 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xHpBm-00G3o2-Nm;
	Fri, 16 Oct 2026 23:10:06 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf-next 0/3] bpf, sockmap: Restrict iter-context sockmap
 updates to sockmap iterators
Date: Fri, 16 Oct 2026 23:09:12 +0200
Message-Id: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBAAv1L27EIaqVW/Ih7SZKOrNg3ZrRRK/
 27U4zDMrCBUmATOzQqF3iw8pQrtrgF/d+lGyKEyWGMPrTFHlMk/R5dxzsEp4YtHVmSlgsHsydk
 unvq+g9rnQpGX3/sCQ46YaFG4/o3Mw4O8ftewbR8J/8YphwAAAA==
X-Change-ID: 20261008-sockmap-update-limit-iter-d03ea25f9775
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Lorenz Bauer <lmb@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 Sashiko <sashiko-bot@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>
X-Mailer: b4 0.15.2

Follow-up to Sashiko's report [1] and the decision to restrict which
iterator may perform sockmap updates [2].

Three-patch set: remove about-to-be-stale test, restrict updates, add a
negative test.

[1]: https://msgid.link/20260626205814.BAC3C1F000E9@smtp.kernel.org
[2]: https://msgid.link/87echn2fhd.fsf@cloudflare.com

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (3):
      selftests/bpf: Remove sockmap update from bpf_iter_unix
      bpf, sockmap: Restrict iter-context sockmap updates to iter/sockmap
      selftests/bpf: Add negative test for sockmap update from non-sockmap iter

 kernel/bpf/verifier.c                                      |  8 +++++++-
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c          | 10 ----------
 .../testing/selftests/bpf/progs/verifier_sockmap_mutate.c  | 14 ++++++++++++++
 3 files changed, 21 insertions(+), 11 deletions(-)
---
base-commit: 645f5fcf7a5582f5d6ed2322f41cb34076c63b2c
change-id: 20261008-sockmap-update-limit-iter-d03ea25f9775

Best regards,
--  
Michal Luczaj <mhal@rbox.co>


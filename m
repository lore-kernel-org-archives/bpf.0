Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708096;
	b=2U7reRr9uZ6CZKia+iix3T0Vv7vyK7/0o+pdOoYgmPqHQiHfMk1ltaJ3JbEBDRSUTD1C
	 0MayR4kuZBPOGtzNAy5FRisyt3ByftRtxEWMuD2mh6UDv5IXkJ2DKOW13RxxlzQCKfI18
	 W02bN1C9aG1IM2v2JSxrlttQc93vQm1jxyoYdaNUo6Y6ZvEvBSSTmCjpXwt4/ZQgJMlGT
	 WTmYCoUQmA/d5cF7DXzoQJXPzaOcuedgaxYToyMhIetECGgUkCeQn7UcsxQyHgEA0CNkP
	 fQLg1NwY/UyZQC1F9hVAOCf0k4YMQGaD40XRsSz87iieC9Eul4Zv72ijbsa54ZSXygQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708096;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iqhBRS59PTgKeV6kXKxuNnAYvtcJ2dXB934gAWnaYIg=;
	b=Wfj1gzyO3WjcV5hiL9uf4EECU7Vu3sHUAOh1X1uc9sYqXS/Chmt0A3ND2vOKKbNSNQYL
	 LxuISxywW4uGv+gi/Yhi67KzXVlsH+E0tzJr2vQVkH0gxXOrzEcFAJuM3YHnCiR9ude3Y
	 HnDwxo2p1S6cR51HHtCeg5dzuAUaJTlQCnTYlazT44WycptnXUdlplMX3TTWtitVt8NwD
	 0m0dXOM1J9E1S1W4RdU5PPihO70pO4ASyUrrqM2+NDV2yEOS4Uog6mfcOf4uc1KYnFEtT
	 wqTB74ONPgn27pMVNsN4hg7nCT3QPf+2X6cdj2UWo6YGtbSALOvPwtErGvGUcf8QkAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kyELCG8s;
	arc=none smtp.remote-ip=91.218.175.35
Received: from mta0.migadu.com (out-35.mta0.migadu.com [91.218.175.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC125606A32C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC125606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kyELCG8s
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+LBJkLt2mDpgOjIwkdoz+vWwwjI9J6p/J12jl6W3mmo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795708093; v=1; x=1796312893;
 b=kyELCG8sa16zhs1LFw6wXdoFH1oygP4o7X6g58cs0VFfcPizCvYFzXOxvabHz6WC8a2240LK
 CHnByD7bOiXFitP/sM/dLoJ0zdJMDcZ+bnx0WaNRhnhQ+a9QXOkRd55IJ2UXvWncPxjrsjZKvgH
 s1HNco/jzcQVdhuPhrUR65EY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5a70713291a611fb;
	Thu, 26 Nov 2026 15:48:12 +0000
X-Mizu-Trace-ID: 5a70713291a611fb
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guillaume Laporte <glapt.pro@outlook.com>,
	Vincent Thiberville <vincent@harfanglab.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH 6.18.y 0/4] bpf: Fix interpreter-unsupported insns
Date: Thu, 26 Nov 2026 15:47:09 +0000
Message-ID: <20261126154714.169698-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Request from Guillaume and Vincent [1][2], backport the following commits to
linux-6.18.y with editing the commits manually, excluding patch 3.

9a6df65d5c6a ("bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()")
f1c27922576e ("bpf: Reject programs with inlined helpers if JIT is not available")
34746b5a84ec ("bpf: Disallow interpreter fallback for arena-related insns")
7a0855e73757 ("bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn")

As there was a big code refactoring in linux 7.1, the changes in the new
file kernel/bpf/fixups.c will be backported to the positions in
kernel/bpf/verifier.c.

Patch 1 introduces a new bit 'jit_required' in struct bpf_prog. The
other patches set 'jit_required' to fix the issues.

Unlike the backporting to 6.12.y, no manual editing in patch 3.

Links:
[1] https://lore.kernel.org/bpf/BESPR02MB12296D62B1B3F33BA21C4F24AF1432@BESPR02MB12296.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/bpf/MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM/

Leon Hwang (2):
  bpf: Disallow interpreter fallback for arena-related insns
  bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn

Tiezhu Yang (2):
  bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()
  bpf: Reject programs with inlined helpers if JIT is not available

 include/linux/bpf.h   | 22 +++++++++++++++-------
 kernel/bpf/core.c     |  7 ++-----
 kernel/bpf/verifier.c | 21 ++++++++++++---------
 3 files changed, 29 insertions(+), 21 deletions(-)

-- 
2.55.0


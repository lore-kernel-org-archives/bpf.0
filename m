Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9983F6613
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620984; cv=none; b=GdKt5q0NlOpoY/XGP+uEfOl+xIQlIuehsNezjTIT4gfE0S4S1J34m5OVCBeFke40YPbsMF8NHzdbYEE9iEQvNIIKxqx0m2Is+AvPfAqj/6BtUHWime72w1mU/CKd3Pf6cywORkzAsEkglNMTs1sz4snkeO+7HVbyOuUxqvYP7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620984; c=relaxed/simple;
	bh=e2+JS5Yp1/AVGJk+LSABDSeuGsPf3k3Eor161jNWxWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gU1atPYv5Z6Qm0R6d4ZBR9DPTIdh+4UggvzVgKg2Q7C9ePnJVb/pb0kNQ5Zgu11Y72u/8EJH0Uq/rpnQvgKCC0hSLQNH+Rd3GrmscxvyaRQ0rTrSCxfwTrpuXSFZwNeDuOkgnc8r4DYoyDEMPZVh53BRQ3cd/bevczPydBRLBPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4v9uhrc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4v9uhrc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad21f437eeso13937875ad.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774620980; x=1775225780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdOqqV7IplzNrdbF0+0H27VtKzl7S3MD/ZAuINMKre4=;
        b=Z4v9uhrcztq13ZpqT+KQELZ+zq3lfD1cuyPG4GrsXvoMx3uC5xftgzUUWi58AxZj0e
         EhGxKpZArQBOuZ0mGDTcSHswWU/7SZYRSWRld4oRRgR0LbEAtRuobAFUy4rLehW4N4c2
         obmSg9qBBUgkWUS9r7CVBBTbWoi6yoi30TNJp4fcw58loqCchy3C7phf5X8QrCNaOIiS
         a0lx1OMEIGX6jg2xlpjbLaFL/6quWZc1tw7RilGCxY8vWghxPpv4VM3UYTm4dQKd/v0z
         /Tu1rU6ffCflMK+lAbXZObNUmGvNmmdBqG15mNOflZFW83x7KFMayuw/us543busrX9U
         EFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620980; x=1775225780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdOqqV7IplzNrdbF0+0H27VtKzl7S3MD/ZAuINMKre4=;
        b=tSfKpiLyEcZsYnHayL1N7q0zQ7MktfVsMjSGYdidUDSKliZ4OQK3s0tqvQZpy1DfJH
         v374XvaoPSacyar4OLrzFqw5zbHEPnnVfGh9KL0xdhqsOgOdYNegWUCyp+HPyNu0qBdp
         OWsLxKM+oafjE85CyCaAOGDCHc7Nx6ZmSt/UjexkzdzLKXyF6GrEddXL9jezWLb2POTK
         Bn5OgLM7K8tIMoT+lZVQlhN0lky77lEwCQZ6AmcduvOfXvXqxP8n9MPMJ131ZjSXxH3Z
         lbtdnHtObffyaAtPlEazhUXcit3RUnxHwBGbtXQwBs33tgynG+tpp+Xqr4uAi6441wRY
         j3FQ==
X-Gm-Message-State: AOJu0YwaF2xDRVTPXwQLWu2FsCzWlnyDGAnz27UO3Lu/auC5rAaS2inG
	IW1PTKMNIuPVVwcF3mWwTe4fZS+JW1nySjewaKsu4n9km8vq9tj1WqNLhzA8xQ==
X-Gm-Gg: ATEYQzx7PdA1W/iJNeWj092o8UelvtVUUXmjjfAU1RWUW5ohDrierRADyVDXNqxEQ3d
	dlLYmBfHe4zjIOdpQsL0yckba7oEHPq1rLKPMA5pOZ8xkYfkwGO5UNx/yKujD2wcclNXg6c790S
	NwNqSLZEQIS10Ra+CUKsRDYbfDiP8aLvP3DohmWhk5Ah36rIf7HnwDGPwKLJFqvXROVKXN54qy/
	hp54+XHOOqIFi4hYH1YpKiOl2mYpd3XRnobzQG3BXuvPYRVnVfbk5gmZDSK1HYtjX3MAKp0uZxW
	SNJ6TsBYCLNP4U1Vh/5gNazqez4dVsZ1F3kmwYaZWONMeVxVW0q/xt9ocbow/E5w0CZ+LBvpfYI
	kKTwKkYxd+SDWxSHUwMsae+WVoDi+iPTcYCXbj8ww8Yw+MtCzW9TWsr8NvJUD9Kjb/NENIkZriQ
	HBybKS/rIr08aOv7RFQiRGni5LIcDulC3XImi0Nc6g5BMeDHmez5EZZhSiHgRHxrrVjRdXmLQGG
	t2+uX5JJUAQK4OSEi9r0s11l6Qnk7JNsw==
X-Received: by 2002:a17:903:2288:b0:2b0:bcda:76c3 with SMTP id d9443c01a7336-2b0c4929f65mr53849025ad.23.1774620979961;
        Fri, 27 Mar 2026 07:16:19 -0700 (PDT)
Received: from lab-kiba-ocxma-dut-01.. (191.68.231.218.rev.ocx2915.net. [218.231.68.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8e958csm61371365ad.66.2026.03.27.07.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:16:19 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	x86@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: enable x86 fentry on tail-called programs
Date: Fri, 27 Mar 2026 14:16:00 +0000
Message-ID: <20260327141616.1961457-1-hayatake396@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables fentry on x86 BPF programs reached via tail calls
and adds a focused selftest for the expected behavior.

Patch 1 fixes the x86 mirrored text-poke lookup so the tail-call landing
slot is patched on both IBT and non-IBT JITs.

Patch 2 adds a selftest that checks both direct entry and tail-called
entry for a tailcall callee with fentry attached.

Takeru Hayasaka (2):
  bpf, x86: patch tail-call fentry slot on non-IBT JITs
  selftests/bpf: cover fentry on tailcalled programs

 arch/x86/net/bpf_jit_comp.c                   |  47 +++++++-
 .../selftests/bpf/prog_tests/tailcalls.c      | 110 ++++++++++++++++++
 .../bpf/progs/tailcall_fentry_probe.c         |  16 +++
 .../bpf/progs/tailcall_fentry_target.c        |  27 +++++
 4 files changed, 197 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_fentry_probe.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_fentry_target.c

-- 
2.43.0


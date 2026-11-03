Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747974;
	b=nB4riNJHNMtQIPmlDQ9OLcYBzDlx+x/4xHO8eFCz3lfsU9tvQMOtZy1rIePI4O0LZzmV
	 7iBKBqGcv9pC8AbbmKG0lOedB7fLsTIvvLAfn7YnEXieiUMNBsPI2G5LRZ9QatBV749wB
	 hQ5hxg5xA+lsv53PPftpXq5KYzoZYl7CGxpnXHBukfAdsKom6l7Sc3wgOPIk6HVBc0Uji
	 nJnOUThuilXJzWy1QPZ1z7XRX1Z+x7vXkDJXlOjp1jue5fjvSS2KnK0GmpEGBruT+DPO5
	 XlZGt06XsOoXWcOHIQsDPTjcK3Yf9KnGXHFO9z9dpapb025sdbS/ZRkdqsrkuH9zcig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zHUSU5M3zCF7LVnZEp5xoq5bvGi591tkTyM0DN7bksk=;
	b=eExsZ/0c1D3TYHN2Wubl/pYAxdaCWAehcjkJVKEt4LvZqAMiM1d+yfz73r+xZsWtFLlM
	 XQkAwHkeA8nbpxTQ/eP2Bf9VI/cNAp0ZUKdbKQ24oe0dcOXLFHOB/cFZOYfE8ZrXA+iJ5
	 ASrchNPMNwcUAxzba4kfnptgMnQYldVlaqkYcFaNVvp4vwfoTOI1IZR3IHOXdev7c+B4s
	 GKKDSlho0Swq3TVzHJfveKwtB57o8YxhviyOhHlkzf2PEZR3712pLxJEFrAK5U5ioE9WN
	 Yh/KVbm8zmtnKXaFGE2jOg/3Zghl+sVL1gNDXrsprs4WlkZ+AZXXuFV+wRJyZxLXg4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vle8OhdG;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA18606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FA18606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vle8OhdG
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso103718a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793747974; x=1794352774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zHUSU5M3zCF7LVnZEp5xoq5bvGi591tkTyM0DN7bksk=;
        b=vle8OhdGe63JHCDTmIOomoBEh00a0knPA5MZV8o4KMhFVWUFQ5w10gdkYHnDdpl0QM
         fAljmfVfl/COeB6hcao5KdjyXidBZpSWeTA86AmYAHL6PUBv20yzDhs12Mu6qgW22hBG
         szj9MlTTy4Dg14SlGS81U0/mHf5ZebyP/bvlpIuCzweIPLeHvKDyy7kcIMeZvFOeuRlP
         1/cD8g74+aKUfX43ddtNNIiKdRZVMOXpM9kmm0dt3h4EyOwREj//dcpWccVjy5WgLXjK
         +kNTkFGAmBbKACKTL26o11SaPI4HrQrO0/tK1o3o77KgqMyAMponJeOKAg3ajB5PhXYO
         xf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793747974; x=1794352774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHUSU5M3zCF7LVnZEp5xoq5bvGi591tkTyM0DN7bksk=;
        b=eRChSrkugW4QRTsPKJrN06t2ErdNFLLHz+a/VGFLyZm+us416slQnA7OqhWAxpawlG
         EusDpjELwrugrgyG+d6vnulWjHNAL9bZ4IZPmb64PThKL6GhQdkMXThQTsooK3UmsvIT
         BTu2xLUtBRtGmcxIfPyRH4osxUan+6E473dIDrME+8HZEdJFxBqn95DioojJhdYBYhiy
         T4ydlUyqvL1+wb29BxPEd2bdfhm3SRI3D8u1hC5etsdUfU8IogKUM3E1hRTmzkepA2pW
         WjxG/SS24MsNEJXH2xuuEE8GMsuXJqddGvSkIHQ+PFW6CYB5NhRePE3JgpV7wkDQv/ek
         +OiA==
X-Gm-Message-State: APuU4Z80xsU2XT+rpraDPglc0WeDY4p9aEP0wEXa3C7GnUkOY1S5CU6s
	5hzUc2MHMsmjaA9pkGbAedA1f3aMXYSNKQKYAac6PbDRSXLZLJqLQC2AyQLUng==
X-Gm-Gg: AYBFou2dF03aSRyBMYvRsjfrJI1w5Hb+JgJq+qE1henqgKYEO4qhh9U3YqPjMGXlII4
	Ypd7Le81U5zxLG0vE0PRWLjh32Au1Ti298yow/nj9TAVpnzwB/EXQh3OWs99brX7iUZCqWXdzcu
	FVPT0Sc7QQ5CC+YeHa5deG4T7nZ/UTi1k7UQOP8G2hoxiv+L/Cr43x8wSTQ/DXSK+gKCsrZ/ExI
	dqmL48+99/LfRVTBz/4h7MwOAWMaGHVH5lnycWRFGNBe3oooBpxIb07QNnaFHZy6YMtZrfQZ+D7
	xEbg+W3lZ4mVFIJJrQGNFP4tnMc1rvR2Qio/GC3r6lwqZbWj30cE71wObsds/S6rX1h4lNH/Tty
	STb8Vbnk9B+Cd4WjYHHdmQ1SV/fDoHyfHd5s/Q4pr/iT8mxkDWB/CH5kbU2+UIlYiteygmXfHUj
	9omaIILEs8/tWM/y90fMS1r25x18yhfs6wQTsRPOy5iWawDVu26wV9EGMQPSYhQtVo31yEpkWm6
	OGf1A+uN4jJlH+XGfnxbm9REuoINwTRx4MLHReM4MkCgiWZdgMUfI/fSIaP2ampfPw74+HpKD8e
	vE0CukMzyOLQVfUrZ9jZOUfeofS5RWnud5eha2ez5zBEwXMr4AeyHTEcu1z/aCuffnZTeR2P8oh
	Dgas+Gra22HIVu7sXRRpRBzsGYELeDYIY7uw6okvPbIxJV2F2i0dfpSh0gysy1XyglQeI2A5uDg
	==
X-Received: by 2002:a17:90b:264c:b0:3ac:9463:83e6 with SMTP id 98e67ed59e1d1-3ae896f8520mr11040450a91.10.1793747973433;
        Tue, 03 Nov 2026 15:19:33 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094453532sm960200a91.3.2026.11.03.15.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:19:33 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/3] bpf, arm64: Keep BPF_PROBE_MEM loads away from tagged user addresses
Date: Tue,  3 Nov 2026 23:19:28 +0000
Message-ID: <20261103231931.89739-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

BPF CI on arm64 reported "BUG: sleeping function called from invalid
context" in subprogs_extable. The prog loads from 1ull << 60. arm64
ignores the top byte of a user address, so this is user address 0, but
the guard that the verifier puts around a BPF_PROBE_MEM load compares
the whole address with TASK_SIZE and lets it through. The page fault is
then handled as a user fault in the context of the prog.

Patch 1 removes the interpreter on x86-64 and arm64 when the JIT is
        built, so that a check in the JIT covers all progs.
Patch 2 tests bit 55 of the address in the arm64 JIT.
Patch 3 adds a test.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (3):
  bpf: Force BPF_JIT_ALWAYS_ON on x86-64 and arm64
  bpf, arm64: Filter user addresses of BPF_PROBE_MEM loads in the JIT
  selftests/bpf: Test a load from a tagged user address

 Documentation/admin-guide/sysctl/net.rst      |  3 +++
 Documentation/networking/filter.rst           |  3 ++-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/net/bpf_jit_comp.c                 | 24 +++++++++++++++++++
 arch/x86/Kconfig                              |  1 +
 kernel/bpf/Kconfig                            | 10 +++++++-
 .../bpf/progs/mem_rdonly_untrusted.c          | 16 +++++++++++++
 7 files changed, 56 insertions(+), 2 deletions(-)

-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106524;
	b=kgz67NlY3bjlwksOY8jGLczyDJmufhhTCNY5WDzUYBaNQe+VlETDFAIgCWtKRq6LN+8r
	 evJ2SbH6CBfQulCoTgganoTUMgXsCO9bggkPTL4BsgTu1WVjq0gHD9y9MBDUD2I0iiZZ/
	 i4zk9nVhDwDFG3HX4R+rZzO9st1XsmyTxE7SvPXXQEz1EjXAMKl5dKSS2LOwrWJc/plic
	 qqLXutvDDSiZB200VRDRgetpRtdZd6tAwIlKRU2gxn28ui3ZxEqBepfiuO92eBNnpaz32
	 7VOzSMzMeNyGLjyfc2pW3D/SZriCzDLjBM6oZ9GyyWc24UUfaPEM+P544/kfIYoHi6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HgDd5L0VIORH2VG2v5Fp/wWX0U3z/GJXEnBUz5v1RkU=;
	b=mm/vUDKfQ/qzUAAdPHZK8xLu73NP+Xbh0kJuqNpa0By87RTS9T07YxJ0SS7nonGz7Jj4
	 qice0pKFK9nrQyk6OL/Lr0/AzrF2D/ydYUND2iTTer9ljzzF3Gx5bJf3cbxT1Ab70sTQ/
	 QrVobbIrRaf4sttbWzGUqbvDm1fq3NDTJW1Lk2Vi5Z88wBqYKtF7zVYAMFE4MQBiqTN66
	 B52mPLcpJJb3dVIKerrd1CkGiN5raylBdoNySm07neFkHaZZRIyvQKrZUf2tmZHvusqzQ
	 W8Jr71dVOeLDMOBhqbEihVgvSq3O/X+qqwxyowJQfplbeKJW+gFHrpDKPu2g94NEw8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZTLbUhHH;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C07606A333
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 16:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89C07606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZTLbUhHH
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a3c08d6928so3380802c88.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 08:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795106523; x=1795711323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HgDd5L0VIORH2VG2v5Fp/wWX0U3z/GJXEnBUz5v1RkU=;
        b=ZTLbUhHHtbEifkw55T/7SASi3uFaklxp2yFg3vzaGeTR8ge312YjkAunBIvmi4rQSO
         udI3e3qpMJBVO2EYnEHMvJaN+g2HjnJpcL6Lku4FYz3/GLmZx1LFkh8FDvLQrAb6olQ1
         GXbTxh82NeNBoLcMaCKyPHvfHxPC0yaCrtyHxfMWmgM+8CFXqV0CzAEgj0kYjSo5m5/M
         P3gX292QVX+GAP5nmc+W7CZP11Vm4nAelZC49qbxYqk3aT/DUDSVt9z3Bi8kMTxMuKNX
         nEWhaHYNkpvtGsHGYYaXjez5N5sAD8jj/w6877E5BOpcW3GbRm0xwC9eGRMmBdAE7Qw7
         iktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795106523; x=1795711323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HgDd5L0VIORH2VG2v5Fp/wWX0U3z/GJXEnBUz5v1RkU=;
        b=cr4y9ef3POiGUFRS4SPapVvWp1RkvIxCfsJEHqueHWe7xMCgDOaDusScysx8C86J08
         BlhuiXaNUhtrB34MOfVQ5VTyJqrhQnYx8LJRbvAa7ln5isgf83mw0EQ46dhYIFSBLUWc
         cjLEfDhw+PcxTYhyUdjuihDf/VXx7I9f5fmIX0J8hA/215CgPvUwlQL81v8JIgwNvq7b
         bo5wRTZF7ZnfFwMoaYvqPU50crUx3l9JenpCJcfasX6dYhTnZXeu3sZ06yMMvPlBXwJw
         0PtsE+IRZwjmgnlvQUEZPWCZuCsI11lTHXVQ7H0l+Z4160cRC9Alln6UrYSM7YdAYS9N
         l1Fg==
X-Gm-Message-State: APuU4Z9rHNKqcitaMaAS21oUSnlZ63z2mK/WoFp552Yp1gyKI1qRp9WF
	75J1JyGroI3TanVuMY8F+am2WggaYKdUMw6enSSlevPEl2PWK/LgweqWIazCZg==
X-Gm-Gg: AYBFou1H69TykRgAFT1SfqJOV5EaoQIq4flDZ/Zoy7N+s5EDq50A/4q/XgaZ9atLkOv
	DVKK4sFWpZKhwCY8xVC8pUHG9D8rSvsycE0O/pO3zVduMDdJdvHDuMCaY5UkzCl0Kf7jMiLSUUd
	t55l6LRllkv0IR6HNt6Wgs/pcWWGc4KlB1GXd3CRu9eC7AeD0RTDKGpVACPGfeNtkrou+41zZBT
	U4Wt3wyPgDYmtVpC+ztJcuajtCBoe5vpV/kiyAoYrLUbvZgUGnd3eMLEAgX9UWP4qpmfl5HcfNX
	uQq9WPScqgQK7TfMzRjgGCrWammcNAiQtqfHrdwoS02oOwEikjBG7yOh8L5c6zqIczvY54BfA6D
	ahM54Tn8BNGfgOqFAYuoEiEeVBTx0oqmsGLDfQ/yQh+aDqn1lObaVY4GJxwjMF86azbeGC9SZT8
	prT9apXD/hXGH8xTURMTcFi7F0mwvlIz3Q7SXZmbmgUmJXUnKX5L648J+4Bh0WkTzfnSrUB7UFN
	YFuMa61fkOff+6fhNWqa7FZS8QDZ4WWztcLxIBHqRq1PUThLF5/UKzv/lALMRfzsvriBIZgnbwR
	RvBiKwSO/Gz5ae5yqRcqs+Ai1HiLZMWN+363cU/2zl96Os1cD4LZJKnNbXt24Vuot2Esm2ojr2I
	Ba2nI0IYjHA==
X-Received: by 2002:a05:701b:2705:b0:1a0:f970:4f5d with SMTP id a92af1059eb24-1b55688b929mr201816c88.17.1795106522470;
        Thu, 19 Nov 2026 08:42:02 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55682d301sm327441c88.10.2026.11.19.08.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:42:02 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: reject override_return programs on uprobe_multi links
Date: Thu, 19 Nov 2026 16:41:40 +0000
Message-ID: <20261119164152.3678373-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

bpf_override_return() changes pt_regs->ip to the kernel's
just_return_func for kprobe error injection. Perf uprobes reject
programs using this helper, but uprobe_multi links accept them even
though their pt_regs belong to a user task. When the probe runs, the
task returns to user mode with a kernel address as its instruction
pointer, faults, and exposes that address in its signal frame.

Reject programs marked kprobe_override when creating an uprobe_multi
link. This covers both entry and return probes and matches the perf
uprobe restriction.

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/trace/bpf_trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d22e78e7f28d..45ff81dbca96 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3297,6 +3297,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (!is_uprobe_multi(prog))
 		return -EINVAL;
 
+	if (prog->kprobe_override)
+		return -EINVAL;
+
 	flags = attr->link_create.uprobe_multi.flags;
 	if (flags & ~(BPF_F_UPROBE_MULTI_RETURN | BPF_F_UPROBE_MULTI_PATH_FD))
 		return -EINVAL;
-- 
2.56.1


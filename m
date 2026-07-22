Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C04D2ECF
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720311; cv=none; b=LcNUQjE1pSMm79sCauirEasXxyiDcfZ0hfwcOap5liXfntvTUGAsnmBP7p6RhsGpLBbThMJahHAE1wOEUkJXB5oUNGD3Cd0anp7/GJ3X1wmKPTipFEsDNN8Qkl6a++A3PrS1R1Qyl7Xq5izxduPsZdEofBg7A2hEt2IhAFZSifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720311; c=relaxed/simple;
	bh=4SUTil00fqpgPAucthU6HTl2XlqWFfYKnVVCbAIsH5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEiCCSymL+r5owU5gb/nSNZ3mJAEBAo5G5MrrGOzXBzgS93sfPw97i+d2L26bX/oVcMgMDvQa1rS1I2vpnw1ed+vkkKeL3balzfwIGN777qlLkdpIbyhMaoBt13F3au+Ug+0EBxYTPDhhkdFH6NN+a3D1jA63gzSMnNP1YxjE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJeV4egu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJeV4egu"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceae1ed204so104255095ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784720307; x=1785325107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lz8wSJ72VvS/5HxQLoKKzBsvogEF0aAdv/0SLjzmBu8=;
        b=tJeV4eguW8FAaVkaKySpnAOrvCIjeRyybgvPdJmZscFO/Yk097+TE1rGHmf1gRu8v3
         V6CetvUQmLlRegbznt3g3WqraoaKpx9yVbf9r98EBx++RA0X0mWsxhjhDToVnho+PcaN
         rPw91ci6f7Kwm1V5VZQO13FPSAxEH6etsR5vVQ1KiWYhflb9AHWqOgztS5I2+ZQtBsBo
         mQ0v/6b/UsldAr4h7dAVW6HNIz1dhpxno8KJqXJz9DahTdReSA0WQWtZtl76d0o8p72h
         Y+NA8NeElGpRIF9aX+YbpvL8VaC/wZ5Rv7Fhc/zdK5YfyfEN717ObgOipH6bxY9YgI9v
         u6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784720307; x=1785325107;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lz8wSJ72VvS/5HxQLoKKzBsvogEF0aAdv/0SLjzmBu8=;
        b=a9yT1x0v0YBzoIBnyBCnUJHUrKcb8KjG6in5ZldJ2VkewiMvDuBnxW412accs9xkWd
         iiN9qB0lvqZgRk85Qhrv8El0s/CBTvdIKlhiwYqRKvX3wDr+T4IcuWAsXpf9k9sKW6gI
         7NjQX7H2IODxor+GAzRDtr4ifKBi7PrZOyAvHorImFgIXGGjkoT1LNwuQXDqD+s2L5+Q
         mHYobBk23z2dBRhFPYatUx2YAhd/Qyy1USaRUhxTcnLIXl0GL8bddaqxrSkP+Nvpj3ho
         zVLC3sVV3c+9S9ynqK0BO8/KhX27zF/72uar2gDywk/ibE1DsM8PjjDhua0gnouDRMX+
         rGaQ==
X-Forwarded-Encrypted: i=1; AHgh+Roe4iYWk9esGPC26neQgh/ntxqdEEEPrqrQbGVIf5XfqHnz6Tz0S+itEnlMwdVd3w3PCyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXJ27/ew70V6t6Gwu6m3Xdke2ogDrLgKSuy+8kRI2B8qvD3hm
	SXJuxwh/BJlkncHg3Rn+xg1U4UT9usk8cRUtiVzfsJM9HFnjqKlrdH+P
X-Gm-Gg: AR+sD11J8X6E2f0eqqzLlfTx+DARGVeEfosH+gAMzeK+hD1c7KRKGgifm+V3aJ8SSw7
	BaCOJDiC5ewXXWKX67A9Ydl/rMiatjFTLqztAIA+eDcEmSMNngscFrzkGrLBtJPTV5mM2ejN6Iy
	6EBK6t+8G44G1AoGVS9sx5tuHzgIE6nFR0D+NArGoxRxfLR5SQAJugDn+JV1nGfH1clCBHSOCc3
	f81S0P5I707Q0QhKVbXHnYWVzhKkvcKVuQUrH5PpRqDcbWLxW5pWcxZ6Dasxy2HPrpGH1nuc3SY
	DLRosvhNMXdBRTjWGGPfFNSgQwat1cL3lnaxBZWBEbRPqfgavwAjItlxbPenFDLRAIB+CTzSsrr
	Be0tq7Ft5rHxVb+Pf2sIWUAQB5FLaeufk2EqMtKsfYQkYkvHe2YgLO8OBFvUwCKTJ1h7zhj7jcc
	vQJJ4a+m64Xwmz/LwLLQsVkEGcl6hfGMJkh4vgV7NGG4amkwxOHrZWhFG95zUdWX/n62ER/ZGj8
	G4D0d03o6I=
X-Received: by 2002:a17:903:1b2e:b0:2ca:281:27f9 with SMTP id d9443c01a7336-2cf349978f5mr237336055ad.27.1784720307137;
        Wed, 22 Jul 2026 04:38:27 -0700 (PDT)
Received: from kali ([115.131.60.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f31383bsm13110205ad.59.2026.07.22.04.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:38:26 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:08:09 +0930
From: Daniel Wade <danjwade95@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Jiri Olsa <jolsa@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Preserve pointer state for commuted arithmetic
Message-ID: <20260722210809.382642@kali>
In-Reply-To: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eduard, Yiyang,

Thanks for the pointer. I independently tested Yiyang's v3 series on the
source-matched f105f3631d51 base with the same kernel config used for my
original report.

Before the series, my impact witness reached chosen-address kernel
read/write and changed UID/GID 65534 with CAP_BPF and CAP_PERFMON to
UID/GID 0 in 3/3 runs. With all three v3 patches applied, the intended
untrusted-pointer positive control still passed, while the impact program
was rejected at "R0 pointer += pointer prohibited" before any address leak
or privilege transition in 3/3 runs.

I also ran the three focused cases added by the v3 series. All passed:

  mem_rdonly_untrusted/ldx_is_ok_commuted_addr
  dynptr/dynptr_slice_commuted_invalidate
  verifier_basic_stack/stack pointer arithmetic preserves frame number

Given that the affected code has shipped and the issue reaches kernel
read/write from a CAP_BPF and CAP_PERFMON context, should this be routed
through bpf and marked for stable rather than bpf-next?

For the v3 series:

Tested-by: Daniel Wade <danjwade95@gmail.com>

Regards,
Daniel


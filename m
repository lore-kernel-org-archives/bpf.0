Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118513;
	b=FkQVnjg/vT1EpoemK4c9FUIQHO4JkCUkcWDLtvde9uPxVNfLpIhgVPniyTQ0pwSIKxYE
	 87d8yTLgxYhyYYkwhAgEdZ0OCD5l9pQ9r7Q49OR5JCMOHg1j1/y7ENtP2cWd5K8e4uaLy
	 7JzKjwU7UhDdA0LLIue35tNJhFrxSIxC/oI9jORkjHTRw8jxZIGeYHFopRv/tMrmwGXKg
	 FJUUgXavI/jtmz51Q3ZpVQZwZzv6NgjfpedxuR11huc5WqyDhoZDrmTiX0HeMPTOl7eDg
	 lKDXWdddGZF08MJctYm9nUwEpRpbAfBHasSuZVYp79YYoNgvglUOhOeaO/ktiJt/EqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GFLyhPGygE9FE3T/bJ6qosTKHJ2H+zy5Cfl7e5f4qN8=;
	b=CEvI148ZD990HXyH1q/iW94BlvXgyYlKWmRuwTxu3+fEQnXkc+MyW700K6UmC7lrBl7m
	 xUx1b90jb55Bw2pgLsd/2NYbfdzUe5vjQlwpbLQWSni8j+5aGBbrQRz+UstbFhLYsDYhp
	 SHIurnyjYb3JFKBGQeN2y9Uo7xt3EOyIkqHVPBmvuKv4GK/TSwsbgm1g0NvKESc2pF7jn
	 DTQn6W3Ewe/x7X7CY7IcbrWZDr8Y9sfVGPRwwhdSkqRZ+E/+bELRqTRhtYXQHNgarkfcw
	 //T7NnAJTJKFUtjB+v3RKFbhz/qebIpEibomJpzsfnXiH8ELYScjrMHI4Eiteo9qfBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=MIVXnvEc;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C60C606A31E
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C60C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=MIVXnvEc
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a06e79e152so70663b3a.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793118511; x=1793723311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GFLyhPGygE9FE3T/bJ6qosTKHJ2H+zy5Cfl7e5f4qN8=;
        b=MIVXnvEcKrpsWCZ8EQsq17WGQ6p9ac169QFK2R4vdcYoOpETFPLHCpk19YKCgPeCHt
         I47U1/CggrrEB+0M6J2FMiTTLoa7wAy6X1zc1BZXr53tsRiuMtEgjinCmtYjIUjbk+L4
         e6Sp0FHWDmfLjKgvK7qhapahACLrtIRMX2apvZvPwgz76+sMLbZqX6Y9hlsfB9SD0qDm
         w+rDn0QJjtGnVC81rZbIM7MXyEa5ay0ro/xFreuxvSCjKkMUeWqcjWkLi72pGLTokRsu
         XWunrvX/gSZMKJOW/Gs043BrpWxH5bGEG3r0nuMGbfq2POuUiMJYvhCTZywXwyYD/Ci2
         jI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118511; x=1793723311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFLyhPGygE9FE3T/bJ6qosTKHJ2H+zy5Cfl7e5f4qN8=;
        b=TWt4c94Iz3hwB4Ind9UYOK9nB3PX/ujNDTA2ARNPftLWwyhppETK7153HII+sn1BO1
         H54o04l5bVj1tI+Epx53tGeRnliPoc/rSFYqz2N5IRTYUuD5ax5AWDlgJA+ZVm+qu4bx
         rrp8Wj10BTIl9tOSOfTsTWOTnycf8pdFUML4RFccggyFmbpff9noLLx7ZNKSRr48Rjp2
         sdmXo65NJZI7bhWFK243N3iRBuBA6+E52XJAzQgXgzRLSQAvUXxR4fHIUuZj9FD+hfXl
         MIWPnFCKwxLIKok/O7q9ILIDZ9SdQMkBb8wicLSHP4hVE7GkDzrrsf44uHrMwYxcBzH/
         SSgA==
X-Gm-Message-State: AFq9FYKUgLQwEfDbK8A3UxGv3QE79hhT/HbJV8D7j6ndmfs+s8cAvFr9
	RVqwUmQ9Ay/h4JXFhMLXipA53PV5+Zz3MqmjrWvAKrA4gKPvPsXiBzhFc1rFD+q+SPmVUJmsIHw
	UJl6Pjzw=
X-Gm-Gg: AYBFou3ed5z8jac6ILHkYQoMU2nAQcrYiGqjtL8Ke7ZLozD8AdkKxh7jwv7O3wU6q37
	933ETkOZv+qqSJMGdYfdTaQt93RdYbQgJk3JQqV/Q8475I1fwVvBDKW798F4Mnc56/ylxSnlwDc
	YYaL5AS+hsX/amsfidiSAK1w0WeMIhHYu0UXu4m1WTx4+gyG/H2+fJIo20+rO3l0W2attpDu7Ax
	pknt++EgEVGT8mEIaUBQzg9M6VHVx76UnwOJqRgQP6dJlLhPDzmW8b+qAl+9Efp8Z26CFelCEZ0
	53PcPSsj6BhPfmL7TvxqlpFeOSVbuy0QElN7zWg0jL515oa13SYNRIRiTkfs2G6kRXi0teAod0w
	iOrs3+8uvXRAllU7OWeWV+vOudT/P31EfjioxjxdDTXDtNsqrqWVDk+/I5ryuOyHEFmJoOwLlY9
	krI27bc77AVklZDgYrDaGq3HEeBbNQ7pD8ze/TZ/nEewRFukgObvvtqrqA1z6EbXTYiBk2ug/Yr
	idNjdXvIQZVvppQi22+xCJImu5AmpYstipNrctI7pqU+LwmbfTw5I/VD0+RvevAVrdX53viGaZy
	AjBQvhq7xDNN509HWA==
X-Received: by 2002:a05:6a00:4b11:b0:898:efb4:ec4 with SMTP id d2e1a72fcca58-8a369b1aac0mr8053417b3a.55.1793118511385;
        Tue, 27 Oct 2026 09:28:31 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662c913sm257286b3a.31.2026.10.27.09.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:28:25 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 0/7] bpf: Inline IRQ enter/exit instructions
Date: Tue, 27 Oct 2026 16:28:13 +0000
Message-ID: <20261027162820.10887-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
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

The functions bpf_local_irq_save and bpf_local_irq_restore are only
a couple instructions long, since they are thin wrappers around
local_irq_save()/local_irq_restore(). However, they still require
a full call along with caller register save and restore. Since these
functions are used extensively in performance-critical code like
spinlocks, it is desireable to reduce their overhead.

Add inlining for those functions. The inlining happens in two stages.
First replace the call itself with a special BPF instruction denoting
an IRQ disable-and save, or restore-and-enable. Those instructions
are translated by the architecture-specific JIT into the corresponding
operation. There is no functional difference between the emitted code
and local_irq_save/restore(). Inlining reduces the overall latency of
a no-op critical sections from 47ns to 29ns on a high-end Zen 5 machine.

Add support for this inlining to the x86 and aarch64 JITs. The fixup
does not happen for JITs without explicit support, or for kernel
configurations that change the code run during local_irq_save/restore().

Mark the functions as fastcalls to remove caller register pushing and
popping. The calls are only marked as fastcalls when they are valid
for inlining, so the calls are not marked if not eligible or in
architectures that do not support inlining.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (7):
  bpf: Add internal IRQ save and restore instructions
  x86, bpf: JIT internal IRQ save and restore instructions
  arm64, bpf: JIT internal IRQ save and restore instructions
  bpf: Inline local IRQ kfunc calls during verifier fixup
  selftests/bpf: Test local IRQ kfunc inlining
  bpf: Enable fastcall for inlined local IRQ kfuncs
  selftests/bpf: Verify register preservation for IRQ fastcalls

 arch/arm64/net/bpf_jit.h                      |   8 ++
 arch/arm64/net/bpf_jit_comp.c                 |  34 +++++
 arch/x86/net/bpf_jit_comp.c                   |  22 +++
 include/linux/filter.h                        |  13 ++
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/disasm.c                           |   8 ++
 kernel/bpf/helpers.c                          |   4 +-
 kernel/bpf/verifier.c                         |  17 +++
 .../selftests/bpf/prog_tests/irq_fastcall.c   |  71 ++++++++++
 .../selftests/bpf/prog_tests/irq_jit.c        | 128 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/irq.c       |  24 ++++
 .../selftests/bpf/progs/irq_fastcall.c        |  56 ++++++++
 tools/testing/selftests/bpf/progs/irq_jit.c   |  55 ++++++++
 13 files changed, 443 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/irq_fastcall.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/irq_jit.c
 create mode 100644 tools/testing/selftests/bpf/progs/irq_fastcall.c
 create mode 100644 tools/testing/selftests/bpf/progs/irq_jit.c

-- 
2.52.0


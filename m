Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795834402;
	b=OrG+UXzrdNBE6VixKW8mp0ridblSIr0ZsIlUQIMaeWfOwQMVkr01W38tiD9CdQSa6YSx
	 1+QyBrHDmlVfBPe9dsQZ+XXfDF9zM3XtD3q3iHv5urb59RtGfd9Oi6jcNHcEtiohah8tT
	 JWbTlAfXnhmHdi21XEHAHKXX4L4GwyuY4WGLuzxozNr+1iS36N/mxjNNB3jMHKdX2F6TN
	 o73q61G22tX175WcXfiMHsMkHqxCZojtQV82nrIkle3eQm2BG5Sdw7TilgqNSe0dYmgXU
	 +qsp3qCm/yb28/Fqx1RjpbedWKgxHw/zJKIupWeKJXhNDd5EZ7fhYisJpFQ1u8bGVzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=R0kCwO2dA78O9IErWGqjxytV2TbDnWKV61Iue3IYRdw=;
	b=J6AIu1j1JNxZeaZ8aB0sPQAIcD+iBrElXfJgRHdIOw1OI0NpRudhYIg6YgMYcaCUfl+v
	 BgRzf+w3dhJuMk6Gulp+lD0SrwL4dvgnC4sdHfYE36DbhdnWq+pAt46g2m6ZSpA4tI4tc
	 NWtqqDxCAhJ2hyNKD8Ysbnnbkop0vc9DR995Zu0Y4FZaeZYXs8eWmWRxTvbnxbudbe96c
	 makVeVEGXYA2+1IPTqFHvHwrPfvEJvhDNkUW/AqIcPGAX6WaP4a2IRR/8O+w/FEx4KX/g
	 L/ItIxjUeeuwrSUcYX1Mppd+Zw7Vov2/qWLKT6NYG7YLBDWu40lOu3WEMAFv9zyWzUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xz8iIQwP;
	arc=none smtp.remote-ip=74.125.231.134
Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DAC606A31C
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 02:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4DAC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xz8iIQwP
Received: by mail-oo2-f6.google.com with SMTP id 46e09a7af769-862990b7bbbso2705216a34.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 18:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795834401; x=1796439201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R0kCwO2dA78O9IErWGqjxytV2TbDnWKV61Iue3IYRdw=;
        b=Xz8iIQwPrz3UXXC7kRWAAxzvKVj/HU7EAdERFZunkGhTxzrDkFsAWIqJM0+E4/k7Vu
         yjDrWroAYQ+pKfzA17gl6LuEHH0huBIide5ecTQEc9tu7W592QR6Rvvob7UcoGVFV1VS
         Jhz/HjFsmHeRgwzHzhK5JhZYOwWY0nPw+HWcMxff7G+L/OLkc9bjJ4XmUwiHYoWlndUs
         ehplCIK6cWT7AUo/TyY2ADJLkg0dhxfcKQFxfas9/pK0aQHCiL4UU1FQ1Zs4ILwJLdU3
         aMkWa3w/krHXD9qsSFnX+fY636idLG1l11mf4Ymm1C3E0EdUhHJysCvBGuVw9zKT6f5m
         XQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795834401; x=1796439201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0kCwO2dA78O9IErWGqjxytV2TbDnWKV61Iue3IYRdw=;
        b=GDFFNl38nutfyVsbVxtdrpbcXmNlFada+Fh/oHUTITSSUcVX77bKsgCaffDUgfkL2n
         HZFGdrCTnWkx5cSNmlcBbHxLqQVMXkjPlmtqzSm81UE/7C3ClNiK0eHEN5g8sTDujXPc
         kpaglvTNFTickdpMN+PEEsaUVgtyoL1z8Y3Y+mRpo9sesrymfPMUwVcnDA3q7llO7WAZ
         /ZeY0W57qfM1avivJfRoVNd9zo6C4IKhYKgU8DZ+CNqSs2SylXUI8dKZGAlrSa6IFX1d
         W8HIF9s0YSpxcOksL2kqX8uUQsGcGywE0FcMppZdGlsUDbtRpJS4mdU+W0WcY0tAbHLW
         PSDg==
X-Gm-Message-State: APuU4Z+WopeT7K2fRpWxYRwifIRh1/BOXjmlqhY/5A5hFgd/4LAbC0qE
	q/sGYjT7pBNDQIs+66xY8rdTHosGqwMfad7/9aMXd6VBoSG9xfHoFl09pXtpDr9i+Ho=
X-Gm-Gg: AZFdTZf6IaK6O0gYHsxQaiDllTc6lZhDQwOc2PPqUtTPbE8tRevj1RTBbS3Whz1fqNM
	ystCi4QnifXo37Bt1JsFB9GCmo5RH/T1Zx2WtMAy3GtbIWMYBcAC5KT3moCQZtQIdpgUAEHyPI+
	IgaUsV8O583rvlZvZwbms0DIkX3H2PlB+31yU1/ASlGdkpmcEi/fiGa52nr6d/ZNrl1cFkiWsgl
	0VoRVoJ2FG45SIg80slZkXh79mgco3+zz1Vf9BWPJ/ZhXau93vuXw5a7DMjHXtaU785TMLUDTm2
	MpuYe1JYVUb+HBgq5J8ctQAkIeCzWQx6QBufrrhI7v7fRx2S/YIrLR0SBKqxVfHh/P/b5W3pwCA
	Rr6ik8lRc1tWqMe4SSvN5uKNnOfcgSCOco9fZXjFcLyLRKqs+WckXyAgLxgqpKhMIKDFf7+GwAN
	ZhwSaw5Lf4yhUjmC7vsMvMgImJnY28Nr2I4ExIRxFQGJj3gddP/iQ5U9wzE6bxq6LfxDnRV5DAz
	WVWUvBDunYm0/PpLOTp8jDDh/b/vW57L1EpOeVWGKk5SuQIDkAkoPoGD2rmD/tmhP6NJqISYAXM
	c8/5SGN67WJJE1LQDuCUU02TFIi+ZkobE3ey4OY9fiS3cMu4xH2moTEVgW1ZvTvh1JZFEqC03nj
	KqIEVuPWXd1j/+JmDC7bWRvh9QgIQgCzWXJxy
X-Received: by 2002:a05:6808:c3ee:b0:54f:c850:fa53 with SMTP id 5614622812f47-57a0891786amr30906094b6e.17.1795834400878;
        Fri, 27 Nov 2026 18:53:20 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm21381575fac.0.2026.11.27.18.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 18:53:19 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Puranjay Mohan <puranjay@kernel.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 0/3] bpf: Do not follow __iomem pointers
Date: Sat, 28 Nov 2026 03:53:14 +0100
Message-ID: <cover.1795834380.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; h=from:subject:message-id; bh=7KRdKeGEPtd7wqWnWHL9bmdrZHoQfk3ywZxqsxMmWK4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZvLiWflNaM5dXPXfZC1q0sP3/x98X674yvORjz5+tF/8vaF M3mkO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCR9bkM/2N3/EmqMNwWHGQjc0ry2B cRz+kb3t+ZFGjTrcCqd8nqSC4jw4ZZWiJe8d2zfTZ3as9+KFbY8p6PteTrY02n6E+/u1o7OAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A BPF tracing program can read a device register with a plain field walk,
for example mdev->common->device_status through a
struct virtio_pci_common_cfg __iomem *. The load is a PROBE_MEM load of a
mapped address, so it does not fault and reads the register. Such a read
can have side effects. This came up in the discussion of [1].

Patch 1 gives __iomem a BTF type tag, as __user, __percpu and __rcu have.
Patch 2 makes the verifier hand out a scalar for a struct member, function
argument or return value with that tag, so a program cannot load through
it. Patch 3 adds selftests.

  [1]: https://lore.kernel.org/bpf/DN6GS9V7A3HS.1COD0JUQQDHQ@gmail.com/

Kumar Kartikeya Dwivedi (3):
  compiler_types: Emit a BTF type tag for __iomem
  bpf: Treat __iomem pointers as scalars
  selftests/bpf: Test loads through __iomem pointers

 include/linux/compiler_types.h                |  2 +-
 kernel/bpf/btf.c                              | 15 +++++
 .../selftests/bpf/prog_tests/btf_tag.c        | 55 +++++++++++++++++++
 .../selftests/bpf/progs/btf_type_tag_iomem.c  | 49 +++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 15 +++++
 5 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag_iomem.c


base-commit: 71ad211eb086d0f8fc7ae595a37943bed58cad6f
-- 
2.53.1-Meta


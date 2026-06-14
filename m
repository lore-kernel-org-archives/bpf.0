Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D2399368
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429190; cv=none; b=Qr3zgqFwFs4uHBq0FmlRLl17H+5tRAE0M+Qi4OTSAeycr2fkG+L9mvnx2t8AvCBIppsAdfeld0aPYo9sgSR1zrdmhRhP+VaR6mmKdm2fdnqOlipoV9hF15OFfujFvy6tJU3qVLu9M5TLJpQ412D/055b5EptrMf+n8s4LCQELfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429190; c=relaxed/simple;
	bh=tl1gbtf86a0S1llqs4X38XTvX69cB6KA93mt/uCE6DU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVHS8tIqlEdantqhQkiBwNkaaufUtGAuozXBlZ91pjebQAmQAQlM+FZYoSSq3qiJInQgEDZn+7fqT6jdw6FsFinQUKfWSIS3FnPJhPJKzzBc3w9Q7bZ61hqg0qpe4aX5TwGWZqTu3mGalq8D8CC88iu5cU7Ov3CbboK3TA+SXBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJxYLBHY; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJxYLBHY"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c858014845aso936576a12.1
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781429186; x=1782033986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d16k0vZR1zettaTdZ3HXP0MjQdOsOHiGY8GKp79+E2s=;
        b=nJxYLBHYRr6bFb4koagSWnjAp6lTGLoCkFZJzRsoGSN1dT/1xDST6P72Y1rS4BBU1c
         /ksxdMoKaCFg7E2lOuTSwgDuOs6h1YkOhakArzUIdQhtTBByERozUohhr7mfOfEoK7V3
         0BNzn6CPonQ3WFkv9POg3+TS9a74S1jnU8jXget7Q/XfKXKB5fJF7gfxbzyKzHmUhM1N
         R6ZE6pHoq8UBJg7x3oKdcUGTC/PT+CgeJMPR+uJOwU3hed2+5CtwSPacXHBCSgsHlQpX
         r7Xcbi3hM8aZAYTYNTSbZJINtEu8SzEz1SFviVZmgUcrsQKTI/q59ows+4fRtb87EyMc
         RjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781429186; x=1782033986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d16k0vZR1zettaTdZ3HXP0MjQdOsOHiGY8GKp79+E2s=;
        b=ELVrMmbK9lQ6eDtM9qvM4kBAqjx/o7tgpOngCFH03Lq/KQhGq1qAXdYlYF/AkI6QKU
         IFAoSU4grTsPtkppAZM06+FUbkBCe4rOas7KeQGzt65lipgMLD7Plrsd5M5tk6BiHqS6
         +fVNAs8fIjs/YnXymz+67nlXP0jdUyLRri5+kMmVynwD4d11pwsaZVvUu9GPYcfvPrJN
         dbJvqP0U/VvoZkDrIilqITDIbvg0mIMYl4A4nX/HqeKumE//sVeOc3Jp5mh+WWtj66Lp
         RQoaklfAe3WXnAYP+TZOEtDGniNbgy5tKPkWMGCSqqvF5EKRG7Zh9dRAXIakx7rgZCt3
         l92g==
X-Forwarded-Encrypted: i=1; AFNElJ8DpAeaK9Dksij5e3DCDXC/thlbWQz8vN/VsbX3NcPs9Rx6zV40Ibw9ycKKfn1QiUJujrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnC148/HnFrNVB9GZzXjLGcwUleao+2JD1e93auiKjRZzOXDU
	X1OKNdiEvKhjI7+mhK8X9KowQsKbOf9Dx0mlL1ssonG/ZtPuqvqwA67R
X-Gm-Gg: Acq92OEJuYSgunVKQijIBtp+Njv36+jlyjsxCIbGnM9noThTFl8BhQG/89TwAlL+2lJ
	q5EoE3ieVvEsXBySUzkpv5ZrmtWl2jRe6arFEeck1e/SIdBCbXLUty9lfZHgIRT901yvd4nUXnS
	EhnxY8NE9IIcGM/6aeL6w9KugzPqsAMiMroAdAXYSeLeIrTEDeCNBzZp/cImeoaT1nPtv6A0a2E
	M/tmko6yvkZMTdyuIcskBeQI2VD5cOpqMs3i7hy8mEdWJvz4BhTmQAgnPHw/KFBIPraSmqMqgN6
	itSN3gDZwv4AJ+ZgzFakKXe8Ga/Zy1HS5uAj7uXXuD/HP8PKMiPLnhz/OCidTb47wz5aPWx09Dr
	eEMGjE6GaFJJkFyXBjNXe/+AiN2OAABIhUDUsWFTTvhqF0yAvoaMaG/Hhf85ZX3A6fkvAJwqr9F
	UyBMwOzBfpd4HASxi5ftVv7AYBs8fTyM81AzKrp/BlvPWTvjViEK+1G19aQGP37LK2vnOK4AvoI
	stMn7Hcc+4ia1Z7
X-Received: by 2002:a05:6a21:9207:b0:3b5:530d:d96d with SMTP id adf61e73a8af0-3b7857de1b2mr8737610637.12.1781429186348;
        Sun, 14 Jun 2026 02:26:26 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b057461sm8198423b3a.58.2026.06.14.02.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 02:26:25 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH bpf v2 0/2] libbpf: Reject out-of-range linker relocation offsets
Date: Sun, 14 Jun 2026 18:26:14 +0900
Message-ID: <20260614092616.165337-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The libbpf static linker validates relocation type, symbol index and
instruction alignment in linker_sanity_check_elf_relos(), but does not
check that the relocation offset is inside the relocated section.  A
malformed BPF object processed by the static linker (e.g. via
"bpftool gen object") can therefore carry an out-of-range r_offset that
linker_append_elf_relos() then uses to index the section data, reading
and writing past the buffer.

The normal object-loading path already rejects such offsets (libbpf.c,
rel->r_offset >= scn_data->d_size); the static linker path is the
missing sibling.  Patch 1 adds the same bound.  Patch 2 adds a selftest
that builds a tiny object with an out-of-range relocation offset and
checks that the linker now rejects it, with a valid relocation as a
positive control.

Reproduced with ASAN: before patch 1 the out-of-range relocation is
accepted (and triggers a heap-buffer-overflow); after, it is rejected
with -EINVAL.

Changes in v2:
- selftest: set the generated ELF object's EI_DATA from the host byte
  order instead of hardcoding little-endian, so it works on big-endian
  hosts (e.g. s390x).
- selftest: add fallback definitions for EM_BPF and R_BPF_64_64 for
  older system headers.
Patch 1 (the fix) is unchanged.

HyeongJun An (2):
  libbpf: Reject out-of-range linker relocation offsets
  selftests/bpf: Test linker rejects out-of-range relocation offset

 tools/lib/bpf/linker.c                        |   6 +
 .../selftests/bpf/prog_tests/libbpf_linker.c  | 231 ++++++++++++++++++
 2 files changed, 237 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_linker.c

-- 
2.43.0


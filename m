Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A232FE04E
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045489; cv=none; b=WSZZ68NIeKXHjVbpG/qIw2dGPEPjjCR0AmzYl9iFEO6QYwApRBszWQ7sf6D7M9ktEU2akF9s7AQl6jMeC+2xrknmC2q6cHZkL+U06ox2oBEzrECO3Y4Za0RjLI1ejbh4+HwlXqpu+cfrjjzqJ4iJmwGTqeYtUoppBmEeiNgo3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045489; c=relaxed/simple;
	bh=McsKewBnACnO0MD86xFLGwrmlKrGRkJ2pWHwqFUnxBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmgC/sDZtQ0rnua4OkaXyLkPI4gWoAbYP7kjiSEC82Gk6zxRueirIYq9amI0XMTPwMbJTm6J4evWOf3u1TrBuz7q/TovpD42aBmVhO3ZM512qG402SHjjmeP727n0EIR+zRMFGDVcIzVyiZDmqx+zB+pfLbogY0MjwzOzh1mkes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fo24WFdO; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo24WFdO"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-463208653d6so3194b6e.3
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 10:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772045483; x=1772650283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VzwK0Z8rjJM0P9pmY69UOy8HnPcPWzbCoNiQ5fea7ns=;
        b=fo24WFdOwzPCsGdssLJGrzWoJo+TSTYNNU8zM99d9mVBsOODUjes5HJ2uH0WwKs+nh
         XUpwRfpoCNOxAPZLMEFZia+Ma7xSXX0VPse0rQsoH0nMEO+Iq+9MzD4UkLEQvrQpsYu5
         BXQZT0p/2d71y9Hn6zZnsOqXrKY0NtZQ/ay2iIxowZo5uXUx7XrU+RfYZEhDpaDnwrG2
         F8NeLasvcacdMERT16JGbQJnqYxugvMC1TIpRaLH3p2FT3xzbvSXtm4XWpHi/c8HYTiN
         /UjfnomzFga7DFC5t/xQiouoENMteef+ra4WMHNDybUieeJRxvYY/c2Fna5nNuJ0L9F5
         e2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045483; x=1772650283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzwK0Z8rjJM0P9pmY69UOy8HnPcPWzbCoNiQ5fea7ns=;
        b=MaSFsj72jNXDW4XXsTLecqIv+QG5RlGdLS1vsBhFhSdUhUEH1g+NpYjAWc/0E/ikW6
         Jzbi4O+zv9VKYzy8vop24HX0xikWzU23p4omrhh8mEJ3CEzzWv2WbK7oxtDop4ciG2RY
         2GVby+1dTj19OF+R35Hz7TdaiZv2+/W08KVN/BgzJuFDeMSdWrO+krdiZLhBBVMcipIj
         23ZyLlGjJJZCHygtXMxdjUyzJPicH4KsM7BUcsrwtocXrix4cRjznuovTBVbUzIH6TUB
         qBK1cF7Eof/2tAjR3No7f4M9oOFOoP5PnGoHm27e0liLRXqYcEn9DkyWVARCbQ+0THrr
         zF9g==
X-Gm-Message-State: AOJu0YxvK3f14ksQcaQNecj5aXYXKuEW2Og64gO1AILNqzfFmg5ZPwBZ
	0ECxNX+/6e3bOh1qviKb7hwow/x/m5ILOCuup4QZ4oPKIv/HZkrN9Vv+0jvKRy6E
X-Gm-Gg: ATEYQzzLAtF9Fd68IFXeL/78Nut6fS2RsQSY5TXLKp4+2mzEtGfBnKtn/Dxbvgqqle4
	Kk3LLhrd62ngfEnwW8bLf9x6C7MpdrcdEZ/S9Fz5R4DD62f0MDaIhib3KLwv8bymnqE7S5cfr3C
	yy+DIpk0i2L8ad5a51c+yMvR0ag8Rs1CKuRskQarWm+nB4M0/wL3bPaNNjETuSKm3eFxe1SkGq1
	nJ+NKYPPW6YgziJZciHCX9tMgjY1U35ctV2SIHo+kwYpa3DkfEsPPMk5O0fwGlXZ8y4mtyTQ7OM
	wC57tgWmJwpFf24am7TYtwwQp0HAfmyxbr5t9ntFoVT8G5y8PSx+FCTPuWq5/Pu/+52U3TjI5i1
	sFUsd5dgykN2+NlvCXjq7FH2MKhrwy/QoBwCJBre+tMDgiW3ui8wH3c125Dr/mPvfCP8WpTMz0K
	7zt9KoOXgxqjXMiqNdPtZT6eaZOwVLt2Yiys14V/CqwjA=
X-Received: by 2002:a05:6808:309f:b0:45e:bfd1:c332 with SMTP id 5614622812f47-46446301ademr9887599b6e.32.1772045483104;
        Wed, 25 Feb 2026 10:51:23 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4644a05040asm9127127b6e.9.2026.02.25.10.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:51:22 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/4] Close race in freeing special fields and map value
Date: Wed, 25 Feb 2026 10:51:17 -0800
Message-ID: <20260225185121.2057388-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; h=from:subject; bh=McsKewBnACnO0MD86xFLGwrmlKrGRkJ2pWHwqFUnxBE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpn0QMBT1TugeIY+URCqif4JCRlWXinz7NVWkAVesx UefdSYaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaZ9EDAAKCRBM4MiGSL8RyqlZEA C2x2r4aA0FAOODVHNqYTftN1AcCxdmzKJv+RZVaQewKZAVkqZ8iAyXAfXnYQrLLMFUWisoUp5o+LgS rHd83ifY6UQMc5WL62NQZyyjgEtIZD9lRE2HMjnit4ETJvycbfnp/5v69l3kg4TIj8npWf3PbquyQ3 jGRhmDgWCslXfcxPwvqXW7F55WYEbEkJtLQdk/s7/JoZMXcg79yiJHL1mDreO/XC2K7tIft8M2/wET 6z3XfTbIUJpKrbDx6JlLKMzr+T+7qqHFMa2Yqb1sTighF26G5qkcu4J2DjSrV8BVM7m1aYNF70T/lr jBu/KifOOBlNaQevraWSWGK/7M/xz9qo2XVlWReWaFPZSKDabBH8LT6+nOoIUoL0JbMufQpj3l5q7E mkAEzjAmS/GSe/dU5xAmdswd7ccKkc9S7cRMOYvh3AG17RhHx0xp5NsQ3+NVYnMK9+GH/TrCXh8PVn 6hLBws+pDbqMxK8Tkmk3tyOslSuKd03Z0/sr746PoKah0qzxMS6bIj8Rv58x6JupFjcoWa24jj2ZdP zqQYGSG0KIPdq5BkdmeYTatkmajPls2LoCti4/uDs5IVrZerstVVgESaYaf0HlWuXFlLZB3h40k8GZ Zj0RJK0WR9/IdgGrZNMS3/TtIZM70taSGdvGAvxmUtYyy7iuGxBiH6FT1HyA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

There exists a race across various map types where the freeing of
special fields (tw, timer, wq, kptr, etc.) can be done eagerly when a
logical delete operation is done on a map value, such that the program
which continues to have access to such a map value can recreate the
fields and cause them to leak.

The set contains fixes for this case. It is a continuation of Mykyta's
previous attempt in [0], but applies to all fields. A test is included
which reproduces the bug reliably in absence of the fixes.

  [0]: https://lore.kernel.org/bpf/20260216131341.1285427-1-mykyta.yatsenko5@gmail.com

Kumar Kartikeya Dwivedi (4):
  bpf: Register dtor for freeing special fields
  bpf: Delay freeing fields in local storage
  bpf: Retire rcu_trace_implies_rcu_gp() from local storage
  selftests/bpf: Add tests for special fields races

 include/linux/bpf_mem_alloc.h                 |   4 +
 kernel/bpf/bpf_local_storage.c                |  65 ++++----
 kernel/bpf/hashtab.c                          |  37 +++++
 kernel/bpf/memalloc.c                         |  42 +++--
 .../selftests/bpf/prog_tests/map_kptr_race.c  | 155 ++++++++++++++++++
 .../selftests/bpf/progs/map_kptr_race.c       | 145 ++++++++++++++++
 6 files changed, 403 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_race.c


base-commit: f620af11c27b8ec9994a39fe968aa778112d1566
-- 
2.47.3


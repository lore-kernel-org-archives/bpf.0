Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A0D264617
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771622453; cv=none; b=FAU6bLOYcK+9EbtGJB3TQpC2s3UTQ/5RaZQl/Rmbzw02n8H04G42eX9ndSJG/N0mAVnMzNVYT4FFiEYhfRNpQcG8V82Ah7E3uZ1iMwxyOHhk3fpNCb9MRqVRJ4Yv+3YSugMifSYWQ0/ZFE84buUO/K3WKep0Gdu74utJZGVr14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771622453; c=relaxed/simple;
	bh=JGzBXIEWxMVzdJs/v3gBcy2Yi8BN32l4PuognsFfy4M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bCqH3wZOXNwlq3rZeKs9cKdYeFsIkO+qyhF5UdGsyX0l+gPe0lEbWH7DbbaATr21BQPytIT6OHiC5PkVEbaota8976Nc5x6thqR1MWoKqw/zwxImvbx5GMDOYicIhodyK/2nXhnCvIImp/MHIWAZBtInCW6HdVQR6LVaYANDZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=KRgOxgiE; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="KRgOxgiE"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-794f701a3e6so24852867b3.2
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 13:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771622451; x=1772227251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3Q54j8pg09MYguuOfuRlkT6/bDVNrzDDjbbL/IbP80=;
        b=KRgOxgiE4G5FzAqZq6JjmDvfBA+OjO69bZ3Uc+NnNLEcMwRaAQPUAX6k1R/9cDW0SP
         59eKbjEUKR/Ifj1vmdFdk9GLJbLU4RuPkgr/+K0Jt0L4Zyqq0ES9MfcmfX1rgnXllw8V
         kv2XOKrYWDw7paIUcwFbv4FdlvJeYVfE6DZGp+syyUOr5labV/PYMvthwploD6jdiwD2
         jXU6kM2rotuKOoZmXwa9bwna+liPlgiXmad93CVxnpg5xaIWcTBdnOgmA6082m75e8VJ
         Y2jS1yLJrEgv9atNxPUGmptkV/pqWWgxHXrehZOKvPxpIx0Uep/8YLoZ9ThrbRtSQQB5
         hKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771622451; x=1772227251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3Q54j8pg09MYguuOfuRlkT6/bDVNrzDDjbbL/IbP80=;
        b=DSkkR3o/KNB/E2Yog778mFU6ZC52YlrScB5ez67HUydDVf4h8X0mZs2a1zXW4nY9/W
         wHW5QtlEHREvf6LR5pJg8e1NEOHwySyic2XPY3z7miYhHwaat4/5pj/udtaqukuT2XoU
         hQCJzw75yX6kGqpd+TPcz6uFiBWm5sGn5avTLPuJK8R87RA0LKNF6/MXAVnpXVW5DHYG
         NsYz22T39XPaOOQNnTsr6vJ99QA6Dwi5IvSL0x2FptKSHX38ft1u63y8OyFWGbnnfQZJ
         rD9Xkg5Onpvw4yTjCdQgkhTN/9J/9QaUuwVougstgl5utBBkyYn7wxx2GvAp/U/fX/Qf
         sH6A==
X-Gm-Message-State: AOJu0Yx3xcKBIofFlpo5Ejn8oE4MJE3h8hWfL8fkbDsejkJR5o8CFabv
	yVpBs2h6ORTbS4ISrVvEPrExW4ndEHpojAEzbUXa9gjIGEIcm+jh5Y9l1P4kmT4kY1BP9fKoLts
	3e7zyP4suQ5QP
X-Gm-Gg: AZuq6aI/tQepieRJcE2WrACN2XJpp3P4Zckkdn4YG1BQIRRqO0hUeHAe8FZ+FDZJlTI
	R+D9J1Ugwxga0YzFVuzPVd/9fYgfjt9Agnatzym0sRHkuDOhhHlClJSHf5dBnoPmoLizTl58reW
	9KZTlwQyolN1SxBncx8mp2ThskCwMaQwmqmeBNZduJmoEP8OauT4qaTzJ5ivYK9s64TG+j7zNmy
	uAZKBEVbUG8/Borr4+d8GtapAMRsMSc64zGMBEL8AE6cp4iZy9zhoQPrmEGD7uVkhBUS6aXsLNh
	pcL4ODbjqVm3tlmhdTQjpVjS5TFAuwSNhu+MlaVtyS425GxBjOUmpGGcNvlfJuCWPx45Z9xFtVg
	PdRTgqxolIQCcvmXLh1IomlRnbIC7NZ/gKjYNvBVSpf+uY4xjp+gifvcKQEQ2Eg9fLJ8bpl9U5J
	0Wpkrk5aPcc1NnyzHcqHwWPXNNvw==
X-Received: by 2002:a05:690c:4d84:b0:796:3d5f:a2bb with SMTP id 00721157ae682-79828f02c54mr13897337b3.25.1771622451110;
        Fri, 20 Feb 2026 13:20:51 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982db94290sm1728197b3.1.2026.02.20.13.20.50
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 13:20:50 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Subject: [PATCH v3 0/3] libbpf/bpftool: support merging split BTFs
Date: Fri, 20 Feb 2026 16:20:41 -0500
Message-ID: <cover.1771622266.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/bpf/cover.1771605821.git.josef@toxicpanda.com/
v2: https://lore.kernel.org/bpf/cover.1771616227.git.josef@toxicpanda.com/

v1->v2:
- Added a btf__dedup() call to btf__add_btf() to ensure that we don't have
  duplicate types in the merged BTF.
v2->v3:
- AI review got confused about the UAF comment, so the comment was expanded to
  clarify the UAF potential.
- Fixed potential clobbering of errno in the error path.

--- Original email ---

Hello,

I'm extending systing to do introspection on vfio devices, which requires having
the structs I need from the kernel available in userspace. Normally these are
loadable modules, but in the case of vfio there's multiple structs across
multiple modules. Normally you'd do the following to generate your vmlinux.h
with a module

bpftool btf dump file /sys/kernel/btf/<module> format c \
	--base /sys/kernel/btf/vmlinux > vmlinux.h

but if you need multiple modules you have to hack together multiple dumps and
merge them together. This patch series adds support for merging multiple BTF
sources together, so you can do

bpftool btf dump file /sys/kernel/btf/<module1> \
	file /sys/kernel/btf/<module2> format c \
	--base /sys/kernel/btf/vmlinux > vmlinux.h

I tested this with my usecase and it works. Thanks,

Josef

Josef Bacik (3):
  libbpf: support appending split BTF in btf__add_btf()
  bpftool: support merging multiple module BTFs in btf dump
  selftests/bpf: add test for btf__add_btf() with split BTF sources

 tools/bpf/bpftool/btf.c                       | 135 ++++++++++++++++--
 tools/lib/bpf/btf.c                           |  44 ++++--
 .../selftests/bpf/prog_tests/btf_write.c      |  89 ++++++++++++
 3 files changed, 247 insertions(+), 21 deletions(-)

-- 
2.53.0


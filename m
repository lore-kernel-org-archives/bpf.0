Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B260194C95
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616414; cv=none; b=eysiw9j/XFUq+IsOs7WxyHi4cSkDbyu7cKV2Mb2QNeI92aFeozwOqNLWwCw8ylfLq6vd07q4xNXZ7LTdWNWNYWlFwqe4yIyobdW2MM89kPelrCB4tCgHbDfL+MxbI5BC3mDP509K/KjvZO1mhxHSJw5rs6QlRFNWFnwUsoBsRuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616414; c=relaxed/simple;
	bh=BRM5yDmydVypI9dAtZz2etHxbPcg2nc/xJNXc4VNzlA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lGEP/t+iLApRnsNo85D0WeS3x+spsJwuwm4lKC5fDRnVX/jV6mFPG3WxcK6s+RvpzazUSi/BA6/mQGMqIxUdAYDWHvk2V5B7ZqtvLyaikiLlGwM1pgN00/qtpE5uDwQ9ranxV5vNhD1sndB3onkLzF8hB5q2q1iBTxW1SvPDcOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=sSMDDhC1; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="sSMDDhC1"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506251815a3so21955081cf.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 11:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771616411; x=1772221211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k0RG2cM2IGHmVYqc7gHUK5YRNhPkj3fJl8KMCQc88l0=;
        b=sSMDDhC1JUxMYhByCeC7taDtp4+cZ7SWW9vEnosoZu3aFxvKqAb0pEMpovaQYyMn66
         n7tuIz6G1T4oQF3XsoX8mssiUcsyaHUEzvmisPOb8LEal6CkH+rl86ASBJKkl0CKDNFv
         g0PXb+Op4MkKJ5D1MdWPXkNcufE1qlp/xLoMK/qqibJtXG45QLY7r/B3D8bvPqdoukN3
         iE5dZjtxtpjKCLNYdn+hxQcN28hlmG4F4YGS06p5RuSnmt+4cvbTk7LvZrJwtBIYdiew
         MN+xiV5xIX5N9ym7fmxFLftFsKMsQhu6Zw9dpF+gCnW/OBexoOh/+Q9WeWtlxz5NHJed
         TLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771616411; x=1772221211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0RG2cM2IGHmVYqc7gHUK5YRNhPkj3fJl8KMCQc88l0=;
        b=MTnmKrp1bbtz67vpJaTo1Mjn56y0rFnhSxfgxRb/1yPvjoepYKNI3CFg3UeF3wonZK
         i4cxCbcAVIMAgiUhbEgDfrVfPs4CM6Lw731XcnHEEZak63J2RDTTzZC+7MCwGVFTUkUu
         +kRWUjXGmgyLayWvSOGJhquXBqTBF3gisimr8aubNfP6BFXM3CabUQVbvvW//mTWqATi
         i8WfcNq7laSnTZlbOOVr0Hw9pom18/lZ8M1gKiMFQBrH1TI5grO62m0iWiBpEBWTQwrl
         LaujC0j6z1bic/1tzKwz+yXW+U4qWig+3elzlBk9pzOahAzWJljtxBm7qJysitxfh4pY
         wkqQ==
X-Gm-Message-State: AOJu0Yww8E+E3/KW+oiUSCq2GM3hBBWZE3kTpIQ6rKiyzJk7QXvNhsIR
	egFB2FaxVdIjjOXazMKwfFNsy38SHxPhkNoWmCATPlIPLAGijOdb295sEXBdK+MYLXXEMsS+SMW
	ulv5v
X-Gm-Gg: AZuq6aK5c53kpz1HYw07mJCH28CvygZ9DyR79XokQzcGj5Vz7TCPCRbLnhF/h2tD7KP
	MZDwLMk+/HN7dPRUUapcCYvmTzyOOeDkjqk093FFDFzZf9V2MJWXCZAuKuNkMmN/U639kDj9e+/
	7oXa1AbSaCjmfskbXvcuJ4No0uAq/m24iXqo/ocIYIfyqG+Dp70nzo8+q6vvEfh5iswQeQBIy9s
	4HMbItaQ3KbCv1FcxTawyXUxM8xPMlnHP8hX/u0NkUSis6/y7CVNxQqq0eaR8CPm9MWA+/emwk9
	fVN8s25aKzy2fCRzpnpNVc1sF/GMmF4LqwveVs6APocxgPLQH7TIqFGjAfGRYZ2joyIoNuzRZ3q
	IVHxmvNpz+nQ/N4BPnpx090I4b+YXvSAQLC9wg9s58zC4DkwMcCAM1itOXfDTQmZkRBDDfz2BgK
	3UZV2BLLWaRn5UVcTF6nATApDCtA==
X-Received: by 2002:ac8:7d09:0:b0:502:9f71:6458 with SMTP id d75a77b69052e-5070bc719bcmr13767001cf.44.1771616411007;
        Fri, 20 Feb 2026 11:40:11 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f10asm1465791cf.8.2026.02.20.11.40.10
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:40:10 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Subject: [PATCH v2 0/3] libbpf/bpftool: support merging split BTFs
Date: Fri, 20 Feb 2026 14:40:00 -0500
Message-ID: <cover.1771616227.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/bpf/cover.1771605821.git.josef@toxicpanda.com/

v1->v2:
- Added a btf__dedup() call to btf__add_btf() to ensure that we don't have
  duplicate types in the merged BTF.

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
 tools/lib/bpf/btf.c                           |  38 +++--
 .../selftests/bpf/prog_tests/btf_write.c      |  89 ++++++++++++
 3 files changed, 241 insertions(+), 21 deletions(-)

-- 
2.53.0


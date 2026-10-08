Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A34349AC
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468180; cv=none; b=BsZPTcBYUq7ajvMtyS+3nfaj9E+CzwgSXd4nVNbMu5vV3oR+riUjHCXkMLgkUfRhuhmbDiEWxGEyi0YBhxOAxzBdPRlNKeIF4FffwohrMJgAuNSgcT0Ycf+MQzASZuMD3AQveYCAlm1d3rmIPOlOKRGuh/g9Y0oFVeq9YgJ+PEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468180; c=relaxed/simple;
	bh=9vEIq8s35Yk+XXCqIliiwsQELQdVvU4XCrhVGsyr2Kc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I9pwiG5qGvG5KBP70r9zHM4kTftixkfAmRd1cnJ8zC7/wQff+T118ebFAW3Z0IC5CA/NI6DA3loszPlxtqvknEAQcWA4zE6dlY1kzO5RHg8ch5tPJpBhock8ut59fHBVduY9JJ38eIc2Gf70OEugefKfXJhEosgcMCVnGogB0aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNbT8G+G; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNbT8G+G"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-14129667240so3295234c88.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791468178; x=1792072978; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m0/AX4wdp4zQXe8m4ttJ7s5X5KwvO5H0XCKrVAlNx1E=;
        b=RNbT8G+Gs/F8IuNYrzVQeZ4h/X6hzm0yKxER4y6WHf/8AoPtUCXG05Hx8g46u30yGL
         2ZlGoJYyB5xG8VVRDN8jR0Bti57K1LFA0jQsqCq2TuSkdfGfUazOm1fcF8LuQKqkbuG+
         9r1PsxL9ZL/rlQCAuLJ+jaNFKPqWHeSeMEL5xa4T298J4RL1yPOZ6Z9sfKEVgcJ2a7wI
         gCBCp1IvKrhjvwPDJuj2Ql11zGl9MUqAGoLpNsagYUNC336fU1fiYvG6BZRo7QKC1UbS
         cyK6rYez5ob8qH7X4T32ixEJGTRRZ3vv7DDXEGNtvJ/Lm59zVYmgKEJuoUYugo+08TPM
         oAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791468178; x=1792072978;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m0/AX4wdp4zQXe8m4ttJ7s5X5KwvO5H0XCKrVAlNx1E=;
        b=Fa4retCgSjErCu3EISBHDmzHfQMgKKSk8tQ/rQQMiibEGuOCvUy1Y5kyATPwBhSxFP
         TfL7ZJu9x2wYJWaqUEbKrZGbf1Si4um99sePKW+5T1GWCXmPqCGq+XyhlYgg2bbordi2
         LBsRq9Or7CCjpfTD6EY3RAmAxgCneBL3YWMFPwA3djZMddjEQm8LM/DgiVBIhdJ3Oq1n
         w/uUCFcKodhf2pNzNMphEeGRgZu7KsB+XB8Xd6DbCALiOot9rEuMCDuIOqtA/eKIbu4K
         UbCQTnd0J0TeuSrRuLeco+7U/81jglwd21o5I5U1IVRBYeh1IiVxR0Vl68zCH0UeqOnK
         fgqA==
X-Gm-Message-State: AFuF++m9/4zj52HvnHXAif13fF266Y+HLKKCX5OfU0qBgtClzihDCYkL
	0JmsF5n8+sy7EiCmU58zsDGvqGLUIwI23psCRKOndj+zuvJE4ctpXP8R
X-Gm-Gg: AYBFou0bHS1hO3DoDTwZX8hZet7X4CWmqOpyA0kOJaFRmbkp0ygY3snqcDIBqS4QQpp
	/PVjkSqEXZNgf55T1jZtcVIMQ+zY0vwr5P/rajbcgdXQ7XiYRuWwCSKpcsWqZdFTDoQ6AgB3ikX
	M/rEKrmCE3cr36uMUnWA4id40YqkpwIadmg4lreacbll37vUxix7pmW9on0QXiFoS20022DSOiL
	dbcGB10D8MQyj28BgnSmRlhWl7NH6uvpUpvTTaAEbkoh9la7vsHrU2WnJQc3O13kfQq2E8MHvlb
	yz5V678V+E6LG8jSnnd7ErY+RT1OzSCDvqp9U/OWhmAVfjwW+Xs1fDjkIaP/b87Cm7GswR+AY1L
	gefpj2oIjHbjn5aGNzrooNYfIKsBxDs+ILkTJHlhiIcsNJwzdrqp200BX3ntpWms+DuwJMYjsTJ
	kU1UlIE4Pe/ti5tDfXK0QxDiVkWtIuaUU4k/CyTp2Qlsf/j/sSpN6QHtq9ybiXUcwd7hA=
X-Received: by 2002:a05:701b:21ce:b0:144:c123:4036 with SMTP id a92af1059eb24-162074d60e3mr5774465c88.35.1791468177811;
        Thu, 08 Oct 2026 07:02:57 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616aa55195sm15973494c88.19.2026.10.08.07.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:02:57 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: Fix the bpffs handling of
 cgroup_hierarchical_stats
Date: Thu, 08 Oct 2026 22:02:48 +0800
Message-Id: <20261008-selftests-bpf-cgroup-stats-bpffs-v1-0-76b9a6d1be34@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIiix2oC/yWNQQqDMBBFryKz7kASo5RepXShyUQHSgyZKIJ49
 6a6fB/efwcIZSaBV3NApo2Fl1hBPxpw8xAnQvaVwSjTa6WeKPQNhaQIjimgm/KyJpQy3EMQtF1
 r/Wis152DepMyBd6vxBv+TqS9wOc8f3BwqPV8AAAA
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Yosry Ahmed <yosry@kernel.org>, Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

cgroup_hierarchical_stats mounts a bpffs on /sys/fs/bpf to pin its
iterators, and unmounts it in the end if the test mounted it itself.

It mounts a bpffs even when one is already there, and its cleanup checks
the other way around whether it did, so it never unmounts it. Each run
leaves another bpffs stacked on /sys/fs/bpf, and while the test runs,
tests running in parallel lose what they pinned, which makes
bpftool_maps_access and bpftool_metadata fail now and then.

Patch 1 makes the cleanup unmount the bpffs that the test mounted,
patch 2 stops mounting one over an existing bpffs.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (2):
      selftests/bpf: Unmount the bpffs that cgroup_hierarchical_stats mounted
      selftests/bpf: Don't stack a bpffs in cgroup_hierarchical_stats

 .../bpf/prog_tests/cgroup_hierarchical_stats.c      | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)
---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20261008-selftests-bpf-cgroup-stats-bpffs-4534db24d15c

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


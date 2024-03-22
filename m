Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA873FB3B
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116093; cv=none; b=ZHAgF2fnTSy4isZwK6h462hI9ZpPXDtqd241PUJKBmhY1qaf6hOWPYbMfNHrFLz+sDw5doO+jLReZFRBx2YBDrBCqnJu8H2Sb3P8xGdTlQ6mAKI1uTBAXtO5vzqc7obc4L0B/yslyQYzZPsnHBvjlg76saf8EM5EpahG6OlSI0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116093; c=relaxed/simple;
	bh=exkCE/luSg6YRCXyy86QYfhqqJOOQyARGMofod6Nb/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+0sMQYhFfREzRw0dNodPERQg78Xs1ifhiUpv1QfnpmZj+wgHjx37V4WCN7y4qqHGUiRz+voinPMaZ4Uj9QBAco1zLjrfwnSDmy7KEADgwh6ofOSuzhO429Blt1nntRY0hVQ2HzVaw9ySS7rjbMd0dXakc20JD366XY2bZouK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=bHU25gSx; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="bHU25gSx"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56bc7b07df7so3231519a12.0
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711116090; x=1711720890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1u3f2scwBBNSOuIyzyaSodKdzxPo1vE50ZNjF0/ZoDw=;
        b=bHU25gSxDOY/tm6egZ8AwzY20t2htUWFzhUYUUzi7ebb+OQIQmisTMHNl5iOhUswIl
         VAwJprwH3Zj9ImOW8aE3YTa2NNULdtFiokyuaVmrXENr82TsqkBRoPhK2vXGCz6qeXkZ
         VFaF3Ccu/Nt5+euodz7CoAtEo+eH7GC/4x4KKCkdSJLIuNoD+LtCuSkk+tTxiZjRHkTh
         cOdIsg4X/v8vLeIALzRucFKBsZTvxrThE2gx2tcxZ4Ve9WRZCwG/cCbY+vfmzqE/c8FG
         abRVDqWM+R0wH5uzE302jdaEeNpoKBDmuxp/b02TiYVFWcZ7BWmLycxEB7YTGHrxnekA
         Fymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116090; x=1711720890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1u3f2scwBBNSOuIyzyaSodKdzxPo1vE50ZNjF0/ZoDw=;
        b=XJIof3dsXIy2b2Jm7e2cjcg6MoJ0SwF6itEwXbnQaik6C9VGX+4JNIMsUjjtv2Zr46
         +8T2KXxgHFSylLocGdMKOMRozEkL3YxkeyT+ZZjCbmpqDtHhRr9dE9YHJKpS6rsoCzax
         Fs4xyu7abYhkLqweKO9MeqvC8mhLsS3YHKz+uM/FKCNWCatP35kF18TVab02zOu8rrUe
         X5tCOjaCGiPvCiz3PWGT8hgShPjACqnEzEUK5/Nc39SVQx/VPqP/1al45s53q6NhacRh
         d5NLNPbZOYNYH+MYzsGzHaaVpwQ+YCBL5yaLG7byF5sIe37bC8Pbnun4yaB4LqQusGCT
         aAHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMakQKhLk8H/IP+KtlNBIF14V1Nx+IjRogt85zxLx71I1XusKXLiE6Blz7qFh9nkkZYSLDiIXaSWccDMHVspEca7Vm
X-Gm-Message-State: AOJu0YzqESH2uBfPTSZb5x8gU6jwhWSl5iSCf+8hCHmrg9paMomz/QFr
	7F8rHe8/Bysi9V73oMuuoTaTt9BGxwJhDDTCKdcTw6752Ikea9MgCbvfSZw5IgE=
X-Google-Smtp-Source: AGHT+IHUpQuJu6eV2eoIZX53O7FWsmwyNAiv6bJeZCmzSoGQ94i4D6/PhyRvdBe7BX3s/myUY9Z7EQ==
X-Received: by 2002:a17:906:494b:b0:a46:fb47:7752 with SMTP id f11-20020a170906494b00b00a46fb477752mr1586633ejt.23.1711116089984;
        Fri, 22 Mar 2024 07:01:29 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709063e8600b00a45ffe583acsm1038929ejj.187.2024.03.22.07.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:01:29 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v1 bpf-next 0/2] BPF: support mark in bpf_fib_lookup
Date: Fri, 22 Mar 2024 14:02:42 +0000
Message-Id: <20240322140244.50971-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds policy routing support in bpf_fib_lookup.
This is a useful functionality which was missing for a long time,
as without it some networking setups can't be implemented in BPF.
One example can be found here [1].

A while ago there was an attempt to add this functionality [2] by
Rumen Telbizov and David Ahern. I've completely refactored the code,
except that the changes to the struct bpf_fib_lookup were copy-pasted
from the original patch.

The first patch implements the functionality, the second patch adds
a few selftests.

  [1] https://github.com/cilium/cilium/pull/12770
  [2] https://lore.kernel.org/all/20210629185537.78008-2-rumen.telbizov@menlosecurity.com/

Anton Protopopov (2):
  bpf: add support for passing mark with bpf_fib_lookup
  selftests/bpf: Add BPF_FIB_LOOKUP_MARK tests

 include/uapi/linux/bpf.h                      |  20 ++-
 net/core/filter.c                             |  12 +-
 tools/include/uapi/linux/bpf.h                |  20 ++-
 .../selftests/bpf/prog_tests/fib_lookup.c     | 160 ++++++++++++++----
 4 files changed, 176 insertions(+), 36 deletions(-)

-- 
2.34.1


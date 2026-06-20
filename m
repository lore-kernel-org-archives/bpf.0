Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CF40D597
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 02:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781923477; cv=none; b=inP7dG90wVW1ZC0trf/1b7LQpShit122F2AT2ShKVmDbpg3ciTwbZhzaLZEn8faIDX3Lo+x6TS+pIhWOYFGwO90vHe8fEF6+PV0AbKso88YNhFdYSC7H1ffjy7L8LTKYUyBzA96kRcEFgWSde/ESWnW2ULOjg5t6abzdqS6VwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781923477; c=relaxed/simple;
	bh=NP4quYUiUG5ir6Lfp/c0pxMjxtMtKmPdVnpeYKXlUh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1RPiENRUBcSVXIqb6JgYaMSShAQ+qax0gwUfSY1d5H7NzPmT19rTpAdxPlBcgJQmz+kiqj1AUU7KX8recLiL9QMINPcqjKSxSsUizPWQkQ/sBfW+I4uCqzlLIjCv843kCUOmJps0ngVs1nJldf8oGwiOULgCR/mXFeZnyivi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv1hXSxK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv1hXSxK"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37c8e7c8185so1567670a91.3
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 19:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781923476; x=1782528276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tEtBLcfn+4nL/oLFXcmstWWRDWBHHiHGLWZQy1ZHB3Y=;
        b=Dv1hXSxKUXJ9TVQynNVZA6sCZscNGNjyUl8o1fETyyQSirtnuAPVeKpX5BoLCbWuVC
         md18EqGZZovQGbvXGFqTDG+WpsXkUZVlX1BhQy28REFKzmtq6zw/zfEzqVQA4J5KQSgp
         bes/khJf490M9lrJm66nWmRTSmIe35AuV2d67ClIhGOFbAfARQ4Vd0UR0EhbkADcrwbQ
         BLkySwSFMcWaQvrfOINQzmOUsFphR5ue/T8PVVgJQYSUaU3LAI+zcQnuAbAdHlHoG65P
         a1OBGs3Ih+i0rA6vJ11aqEjeltGVp3twUfLPyDkpFMCQ9u/SNo6JeVGPzNd4mQH2eHcc
         pqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781923476; x=1782528276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEtBLcfn+4nL/oLFXcmstWWRDWBHHiHGLWZQy1ZHB3Y=;
        b=BrCH7RzWBZAi6dPR3+8naWOAoZugtFVMG+i83eMu5gN2n78V+HT2ldkWhqXrDxCEF1
         rhwha/uaHwrLZVAESlmG766lezjywdbfHn69BHTHYxFro8R90/MjwluT/v0ok8vDYlZZ
         ousjMhAM/fMcPwrQ1DObFeB8KFCTJwCVzwCEBQ3AS9wkQl0IUU/hXeorqZVQ343rFg5k
         UO996Eng8WCQxnHbS9t97Hr2/K9XJ9EYQe4IpDOaH/ZDa6nR8DDS7VZJoDysZ1bgLdZW
         rmED5xDj6q5cHgyNX8giaKsW4xyBu5A0pCSktsSePQtwCPfkVevhHlmdYnGYCHIvWyv7
         8cLw==
X-Forwarded-Encrypted: i=1; AFNElJ9/8Ac74y7wq8u+XUsvdQSN5cvDWqw2bRkMp8CBkcQvwK6VFWa0chyQH8vj6XSMax4FI9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPqALIeDCAF80M3M5J1LTqfj3AjNR+WREQxDb3/24mtvzX4Z/
	4KjuNNv6GS7eZVq9HCxUoAElGYSD30SkxCsL4sZVS+zhRzRmTRmXkgEZ
X-Gm-Gg: AfdE7cmhr7LJH1t6OkQhX+a/fe7BoegJSs2q2RzP279PJevK/2BKmt+ByrLRPtgXpk4
	g67YjSvMBVT20FOx0ys7PtaDvv8gdun9JSdAwyYgOxzrOwYEDIv1D4hbLFEN4cGGuGVaw1Wd0il
	egO9lvfUAVahPOZWtKO62YtXbCCWYJFp7/NL+M57DibdqLz3tT/hrrhjDFz27IW4VyFn/E6vp3f
	9+xr0OKSjsFIAq5kMhaX669OTUPq/yplDOgAxkJpaDnR0r/mJiHSHSguPw1HX8hDXiFVvvVo4YR
	Htpa1kxwM5BYwlHhDWHpZ5yQSUqnk8css2cD3DYGphYoRhSAjKj8EfVCMDVUC4BKNu5UpVdQ8fe
	KSBB2Yg8E4ycyGnJ/OSNF44Xgdq5/3cTG20sDno4kTfzdZQQ2lpjGQo0HPCEfivbiEXUj/MfqcR
	FUE10lH5Ozx+dchrj8LHWWA+kqqd5Y/3v59w4PLEgJhk9q1+IWzZs=
X-Received: by 2002:a17:90a:f94f:b0:365:a5f6:4a5c with SMTP id 98e67ed59e1d1-37d15dce559mr6675282a91.1.1781923475789;
        Fri, 19 Jun 2026 19:44:35 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1600975asm1087971a91.0.2026.06.19.19.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 19:44:35 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 0/3] bpf, sockmap: reject a packet-modifying SK_SKB stream parser
Date: Sat, 20 Jun 2026 02:44:15 +0000
Message-ID: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BPF_PROG_TYPE_SK_SKB stream parser runs on strparser's message head,
which can chain skbs through frag_list. A parser that resizes the skb
frees the frag_list segments that strparser still tracks through
skb_nextp, leading to a use-after-free.

A stream parser is only meant to measure the next message, not to modify
the packet, so reject a packet-modifying parser at attach time.

v5:
 - target bpf-next instead of bpf
 - add Reviewed-by tag (Jiayuan Chen)

v4:
 - https://lore.kernel.org/all/20260619062959.3277612-1-rhkrqnwk98@gmail.com/

v3:
 - https://lore.kernel.org/all/20260618102718.2331468-1-rhkrqnwk98@gmail.com/

v2:
 - https://lore.kernel.org/all/20260612123553.2724240-1-rhkrqnwk98@gmail.com/

v1:
 - https://lore.kernel.org/all/20260609112316.3685738-1-rhkrqnwk98@gmail.com/

Sechang Lim (3):
  selftests/bpf: don't modify the skb in the strparser parser prog
  bpf, sockmap: reject a packet-modifying SK_SKB stream parser
  selftests/bpf: test rejection of a packet-modifying SK_SKB stream
    parser

 net/core/sock_map.c                           | 20 ++++++++++++
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 31 +++++++++++++++++++
 .../selftests/bpf/progs/sockmap_parse_prog.c  | 22 -------------
 .../selftests/bpf/progs/test_sockmap_strp.c   |  7 +++++
 4 files changed, 58 insertions(+), 22 deletions(-)

-- 
2.43.0


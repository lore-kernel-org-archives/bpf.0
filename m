Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4223ED5B
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850645; cv=none; b=CHikwTbNgWPjqnpxmVMkWwEknuvx8xMqspSR8kh9nt/dM80hbspky9ZpJpCLTtmHek83xoC9x/B43GGR17HiyFVUsObX5u2v5R+pa3AVJpq2Qjki63Hm2Yu/UllBtWaK/WDJV/nYCz/o6HfbMjfN+ZYCnwVziDfFQPlaBeuPQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850645; c=relaxed/simple;
	bh=TqQB867N86wSav4oIi3xoeqdmuIgWtWi0oXKIdYe2EI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oj057NV1pysrtQrxGpDx6u7kxQjHGr/LAXh1KNLRN84qePMp42u9nVMhfjJxUF7c/wViGCSN/z9D+KUF5svaL/1OfjfNlN4QXLqWyLmo9J89/lbBWXV5c1UUx9vJb1aFsfnf+xZADRqPQz6/jnuyJ3V0GcrNe6af+W91HSptzzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca/8b/f3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca/8b/f3"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-842307472d4so778334b3a.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 23:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781850644; x=1782455444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1/ArZBR8AclmPo2AgBuJ0LqA7c+rabIabH9ua++1ms=;
        b=ca/8b/f3/E8ohvuXtS3L5Hrv1r+ikHr72uMY3Q9DGv/viCyjrs78XSNaBRyFs+4/NM
         EHBLWEuEWP31lHXzMMDljO8fEeQ/fntQHRjhlfDMMloNL+51qLRKjwicGqtizAPx7lsu
         UxKCxxW9RFWoY3bZOfRs5eBD9AvHn7Cn0eZg75aGYKoEzNs9+xF/p/5Pwl0Im4HRz08O
         xWakTuJdEoEdcbtbiiBFAfInz/q4xXW7F4DMywZBllwhgSvDM6eDC2xWX5mITRMEg067
         SP3p5LzxljLCVigXuVY69XFtLkjqFtQiHtsQe24ggVJBDqE/lwQ6giilFr1nUnQ38doG
         s4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781850644; x=1782455444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1/ArZBR8AclmPo2AgBuJ0LqA7c+rabIabH9ua++1ms=;
        b=fH3OtpfGnyN20gp0lTUN5LmT11vw4/8gXW/Wfshv1IdfiT8cEeovPTAhgA4ku0gmR9
         ijt5sM4SH8wNI5V21c+7f0qJPJnVoaudusb6ml8hy+3rveBX9hTpez7G/LSjN9ntc3CN
         LBmsL9s1qqzx934l3pZ6E9/SPWQ4UzH6nFcPCk4k2LKBu8DCzbFf6pPA3ZrmmA5toQGt
         CrdXFs5fKcQZFEyz4JbF8jUZMhjuRI975beFqzdOs/DTIeW4UHc1/47KaK8VxDwPZDIc
         B7+eZSDsEMoqFXCI1+8iRu+zlOXA/2BKRJhQ7kgkYttrOqbwP9r15YIrrcLSnDaGrfkt
         NbCg==
X-Forwarded-Encrypted: i=1; AFNElJ9vUtvEhMK9bLZdbN5a98pVBxxcIuhysotuyUMqSCHS/SqwaiUeU7LyUVxoyhn6eSXjFqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjPOZCE5RvvqfzpOiGv/Eui+2gSx8Du4oagg+MfcF0VmW7bYcy
	MSY7D5TPNhl5OxhzWnScZ6CmtHfHGPlJaomBpM3z4FEmkz0MK97eQdkb
X-Gm-Gg: AfdE7clZBtxk/J/xrK1uBzOk3tr9g5jHGDLCIqmCHpBtZjU3P5okzbjK3YdncYtH7jK
	nNIqD3eMV3y7iPe8sW0ONFkxiaX7MdJpiLUgpjA01o/y5/A3gL7mh/f274Ln7IzGWB0ihkdj/yt
	5afZ89gM66locdZTJHrmPUGT4JRstASu4kzlaBw3YlKzkQ/cLGvY2zhEZZuneF6SY0RvweGduxh
	Bu3LVjfkwKrPHpat+O17MGYzy8CzCtbCvYUdjihc8A6hWdlH10D6Y+e3QCXK8hPfSFyOOASeRW+
	2YyLn+zgqRC/6ATqF8Gjc683m2XMcL7fhKniF9L6c0Zxui4sFOI7+oI2vzQR6ygH0fis16JsX3F
	/Uw133r05WDAxkaKn7zonQhaPeR7zI34s4U9mfTDKVQbKbaqdAUBV/JlXUlESe8dzS20076Qvgr
	85C/1I8PYi2BznzQVYD744JS36D2+d6FhvWjCpwqKOZ2MIdYtrOp8=
X-Received: by 2002:a05:6a00:1a8f:b0:845:3ffb:ac2c with SMTP id d2e1a72fcca58-845508d71bcmr2333443b3a.46.1781850643354;
        Thu, 18 Jun 2026 23:30:43 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455382b886sm1380096b3a.51.2026.06.18.23.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 23:30:42 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 0/3] bpf, sockmap: reject a packet-modifying SK_SKB stream parser
Date: Fri, 19 Jun 2026 06:29:49 +0000
Message-ID: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
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

v4:
 - drop the Fixes tag (Jiayuan Chen)
 - drop the unsafe skb modification from the test prog (John Fastabend)

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


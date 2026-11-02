Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641445;
	b=Sdn7bCkB1YPPuajQS4wAza8n1x2SmOWXwW72JHHnBOCKKRzAGN49Aar/x+3GZTyq4yRG
	 cBaayCrojgWK+rEvf6GnPM6juMT16k56kORrqXiH9Of69MYfvF5z2ph2377cfHeEdoqWG
	 tIFjly3s86lDJwugW/eEl8MtiQTcm+iikcELjJ8LLr+/+REh+lry0Y+KMg5XukX6+Qn77
	 P/CThjuDiS0dhLOQzYMr0sR9xOcIIfiGXvhN81nAHFwJohbb8CEEB5tx5z9gQEZ0PBCrO
	 AthPg4fZOYnol9UoLRnokqvsJL+/PIGJsOILs/8Fwrbotf/T4GFqzD/FFTAUkNv294g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DU6n5xddllI3TFFpGzdMLCmW2JMizz1ppgKr4JRiny0=;
	b=1IkhvJKSL2HDh3eDzUHayWtr/Y+3Zqx2mZlfmk0l4Q492IKFT75qBZHM6fyIHUwAGpOV
	 9fdO7EPu0+/bUAorH89IHxIk5Mp1/aMP8qJEF0LMyTZorW8R4lQQQQTJmK9DVxnOqIvjE
	 JX0AZBTYJb5GzbMK6JImxNx2Gg3LPbVhuOTyXBSt+MLSLEPoLtRjm3MT1K/LQl9U7RtDY
	 xZ31TB3azHlOpxTXfKKl76fphmYcagaCOYyIUy7b24bbgpGZBS8/HuynTf5ce5t9FWSrN
	 0KIr1GNK2n6fnzS4Qs4xFzCIYJMHquLtkxDbysor4HEItkvMUT7M6zSnpcZm+aFsQVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ELreSK/6";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C52606B0E9
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13C52606B0E9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ELreSK/6
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so26801835e9.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793641443; x=1794246243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DU6n5xddllI3TFFpGzdMLCmW2JMizz1ppgKr4JRiny0=;
        b=ELreSK/6sFM2LAmhADhCQ+Je840uXhfuSmlxBE2nyYecZDxpNCEdvZIZP5MgGlerwN
         2bgPw5WGEZEfZ033KjYNcUP1+lOJmHbbChgRRqJhSpFcHXg8sUokgDDste67WVukBG5/
         nrW7Ho0LPvfbLnj8L6PkQKwAJCu1zz8d5ZXRcvFFZ69B4/OljG32iAn922CXQzvSfwmj
         JN27kOXyV1+LqkbrgJMW9xjKS/cWpKaVhcnSOJ0eD85iyBrsnHmXO6bXN2K+jP59ZoJh
         GnnrE26mDV7Svi4EToXq8/JYskzjJru9AgygJJvB35aBgSwpDO7ZGARzxTPAHHtdWvxy
         t46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793641443; x=1794246243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DU6n5xddllI3TFFpGzdMLCmW2JMizz1ppgKr4JRiny0=;
        b=qZPus0T+EdGF+5L9J2a710AfBiUa9Uel+/7FHvu06+Kt5RRl+2l1b6zAtzDNLAJRAH
         /bDoYSKRcpta16lcvc6ro0PPk9mVRSb0r9td05vWZwmewcX9h3MGOSTDASTj+1q0un/s
         ma2CUEZBGHcgP0kgCgtS+lPm8yWV2JTG+qyRZfYBIfSYET+eYpIOux95bYFljiLyt9ni
         XZhedqw5W+4jAMGoPSvJxBTQgLUZy1rklr1nfFNoFRIfwOxCZb6kXP1gl/09TbYKMZjv
         vk0Bpn4W5C58D332WWUEpLJAcq104Ecy4w+Nu48N/EhSimmnr2iWwbAfsZlgBi/rWMF1
         QPxg==
X-Gm-Message-State: AFq9FYJkmXdyZKjxPkvq2c2VFa/EcRcIzTDjS/iV7tvlSPow+qh6CLuV
	RVu3UlGzEqxBTOe8xJ2g2LbQc5sDMuxtSp3k6QcgSWdq/irOowK39a0Q1/Cy+X+B
X-Gm-Gg: AYBFou3AtqJ8xP1FSm+h4PHsGHEoZGAtWxcunY55ggKqIarzu7NiGJ1WoZ4ZbljSLvC
	1nLmBvZGe1bV/1V39s+dbsrhjZ4NBEOU1qtZUj5bIPwZOrSgjI+YH0fZ+8HkxtCndHP2PeemeWb
	lYSvB3TkfeykVxf7RT2F3wfKyLVOpqq7WRPe2n+8+L5c+2vihQ/h0pUATJqcpoy4QkjmdfdxbEz
	uhwPEaMca17Mm9gyOc4kBjzLgot2M5P/HH+uNxUlvoDsB9hyA0sVtUH+VH4jBLe52zfTEt27nM4
	Ap5DnJ8iym3X5o1WVn0wVGVeJMBnrIEUMcV3w8L1mM0LzbSblBYCFZOfAGgRQkPq9GteE1L7YfL
	/EGackQZmRvstjdIcC3iYqRuLrEoG46lmA57wooRUWlnSs7+RpbSp4QyUaIRYdrmmUEQRUhEXEu
	6K4QLPtfhQVfaDAR4fPESuL5fhLUaI9JZe5zMUOXLSqs35CJU5SF4xirtImba8NWPYzayQ/9Emj
	rUZa0Ypim+XCS8rc79FAK4McXTs1pmXvUAWpy5lLOp6ly8tRTqqLzCUomUr1ZQUoqE58OvEx7bm
	bJ35P1Xxm0R6PQenVgZasW6rLcASkDFEq3e6PWhpwKpmDlSJum8bce9rPT65HenvaKpxXo7bDza
	5VQ==
X-Received: by 2002:a05:600c:870f:b0:4a2:1612:6367 with SMTP id 5b1f17b1804b1-4ac185bcf74mr238434735e9.15.1793641443318;
        Mon, 02 Nov 2026 09:44:03 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4abea533a1esm196311865e9.1.2026.11.02.09.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:44:02 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Tianyi Chen <hi@tychen.cc>,
	Gyutae Bae <gyutae.bae@navercorp.com>,
	Hui Su <sh_def@163.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/5] libbpf: Support gen loader attach
Date: Mon,  2 Nov 2026 17:43:45 +0000
Message-ID: <20261102174350.472592-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hey,

I've been working on this in the context of Shirudo[^1]. The current
limitations we face is that gen_loader cannot attach the program it
loads so we still need a userspace component to be allowed to
BPF_LINK_CREATE and we'd like to gradually remove the allowed operations
done in userspace to solely rely on the signed program.

Note that there's no kernel modification in this series, it adds the
gen_attach options and code generation to libbpf and do the wiring from
bpftool. The kernel side was already allowed thanks to 'b1d18a7574d0
("bpf: Extend sys_bpf commands for bpf_syscall programs.")'.

Also note that I did some analyzis with Sashiko and it's been
complaining because I've followed the approach with the prog fds being
initialized to 0 (and not fixing the two fds to init to -1 sentinel
value), so maybe we should pre-patch this.

Lastly, I don't know much about bpftool so unsure if the way I've added
it is the most appropriate way for the lskel attach option.

[^1]: https://lpc.events/event/20/contributions/2437/

Mahe Tardy (5):
  libbpf: Count entry programs for bpf_gen__init()
  libbpf: Track generated loader link FDs
  libbpf: Emit BPF_LINK_CREATE calls in generated loaders
  bpftool: Add attach option for light skeleton generation
  selftests/bpf: Test gen loader attach

 .../bpf/bpftool/Documentation/bpftool-gen.rst |  11 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/gen.c                       |  67 +++--
 tools/lib/bpf/bpf_gen_internal.h              |   7 +
 tools/lib/bpf/gen_loader.c                    |  41 +++-
 tools/lib/bpf/libbpf.c                        |  56 ++++-
 tools/lib/bpf/libbpf.h                        |   3 +-
 tools/lib/bpf/skel_internal.h                 |   4 +
 .../bpf/prog_tests/gen_loader_attach.c        | 229 ++++++++++++++++++
 .../selftests/bpf/progs/gen_loader_attach.c   |  48 ++++
 10 files changed, 436 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/gen_loader_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/gen_loader_attach.c

--
2.43.0


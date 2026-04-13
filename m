Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282513033FE
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776123066; cv=none; b=kndR9nuF4iwf3enjQRNbEXcVzYyPUbEdGqlDfHfOGM8V2LYJzkFOyw7iXIGfgKMD7u2tPrFAMir/XrdHWCDC5Fe57i1plqCRZSv+0RGGFYvflwKB9MAUQxzm7HOaMFQWhEek0xpgGaZSXf61we2LbCJqNZrtwzuirpRXoBKtP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776123066; c=relaxed/simple;
	bh=jF+H3Kx55o0q4vgmlK2xVDGwqPS1a17gHM2lxqjHemk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pr+vpvSi8nDbipLqSyN4SZxNgh+AGpqKG/cJuotJhW1e7bKXvfmqP3QN0xtkMhkGHImPNHBBx22K8KwTOcXrUmDMVwTtY2ZzxlhE+tqm32ou6P4oq7llf798l1KI/7aiN3tv7uItUBkc/b5jsaxiRR4EIQsFZe/y07rdVXNRjGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLF5yR8r; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLF5yR8r"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35d90833cacso3012287a91.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776123064; x=1776727864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=13GOe81z8XuIFyvCEZ2bBQlwu2le5/awJCIzvOskjfo=;
        b=KLF5yR8rpBE2ZpqchRXqiNtXMvBxJFQBEwZJKRcpQjFL4d9v4aDIducnm6nb3sBnFq
         wvUmgCkFMqWCf51P123orc6VjkKuKV4HpU7pqxGow8vQ4fN4CUzE4S0khhkPaqsSvzjm
         x1EwoESNFInt8lUB1wKkoHILk19DulWqAjEe9Aum1Pc8V9v1fqbKU1TEBXekd+5ajwqR
         2XNVNuhGwn/HATDZt5BgV6c5Lii/eH5aj9McQpuPDyLat9T7hDhey1+DFRpKDugv/iGL
         kHUoaqNhW7GtGn0dyO6xZfwKm4jnXrpRvYMQYht9P1A5/hx899YYPPpZ7gjtUno62+9G
         6o8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776123064; x=1776727864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13GOe81z8XuIFyvCEZ2bBQlwu2le5/awJCIzvOskjfo=;
        b=DHIHo2hZoJlqSoWp60oj2rSc+4V8Mq/ND5Kn3ezYNqgtf4wSOCGwfLfcy6gMBMpwy7
         0Cv0dZ7Ulyz4isx/hyIIKc/F1fCbVOGg2WiekL8NuUBUdoRpg0I+t1H3NRSSs8m830Pg
         Cxkv7GOzif2ui50IaLrVqURkiy5jBCqbY/FIk88xAd7bcZD2my58v6xOHtBnAS02u2PG
         hG3txQpSwPyuda6zcpdaBTLPx8j8Tc1W3o2FFHnfVqONlSSXYUtGPzlhASgPm/RuHaE8
         e/+rgbzt6CPCK7poJJG4Bnp9yHK4rTtJdZBSKu+B+Bgfn+1h0XULW/K4EueyXeTRpNf7
         gl8g==
X-Gm-Message-State: AOJu0Yw654jpxpH5UpbLQgFhYlY9llvZXApc7YaaTHKG1Ms7VNkOp7VY
	HfbKCK/cN0tRqSQm9V1vbJztBh+YQ/Gstn1uLC0fTQHsPQM2WtBY46InQkAXiw==
X-Gm-Gg: AeBDieu90AT+JNG9coP4gW03YhCA+lF0DlRh2AI5Ld/SMjAXXZn9bAhjhdBHvTXiJJu
	AHJpOuhuwVAM0iv12CrW3jj4v5CGp/NdH2WJ8lKVX6LDLu4olMg+VyDhfybpzs6UpW3X0gMe3jI
	e5+BF2ygU8gzv07bnm4mI7y0/L1kiDkLd9u4bY3S9QaIpthnVaV9LESmb0mtUz7dboeziVWjOwu
	MY5PIAdSIOA+p60EmXVd2VH+1AjH1o8grsVqhV7jreVU4AePH31x28x/RNnXpLL1mSsWVjv2yCo
	YsEmp2GporSMvW6hWhAnSoRJm44TiCIMlQEwBBpuxMLIFTHt8RpiCQ3DT+G9RFE81/EhGd3HuIT
	clH4KCYxN5aXX0IHgXgzPepg+W0jqw91IWHDZUCbO2ZLthwytWxsSVsuPGBLjl3DhtctvN9pgCB
	8R47LGQmhwQysOQheBxE3PbaCnzYty3RCRpkKLyM2NAgjlrfJgBwQMH0UrBj8Qeo2EDBo=
X-Received: by 2002:a17:90b:3b49:b0:35d:a380:6d1a with SMTP id 98e67ed59e1d1-35e4274e3a9mr14109644a91.2.1776123064289;
        Mon, 13 Apr 2026 16:31:04 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc2bc5575sm584349a91.3.2026.04.13.16.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:31:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 0/2] bpf: arg tracking for imprecise/multi-offset BPF_ST/STX
Date: Mon, 13 Apr 2026 16:30:51 -0700
Message-ID: <20260413-stacklive-fixes-v2-0-398e126e5cf3@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260413-stacklive-fixes-42e258cf0397
Content-Transfer-Encoding: 8bit

When the static arg tracking analysis encounters a store through a
pointer with imprecise or multi-offset destination, it must use weak
updates (join) instead of strong updates (overwrite) for the affected
at_stack slots. At runtime only one slot is actually written; the
others retain their old values.

Two cases are addressed:
- BPF_STX, handled by spill_to_stack(). It was gated on
  `dst_is_local_fp = (frame == depth)`, which missed ARG_IMPRECISE
  pointers entirely.
- BPF_ST, handled by clear_stack_for_all_offs(). It delegates to
  clear_overlapping_stack_slots() which unconditionally set
  `at_stack[i] = none`. Change to `at_stack[i] = join(old, none)`
  when multiple candidate slots exist (cnt != 1), so that untouched
  slots preserve their tracked values.

No veristat diff compared to current master when tested on selftests,
sched_ext, cilium and a set of Meta internal programs.

This addresses issues reported by sashiko for patch #7 in [1].

[1] https://sashiko.dev/#/patchset/20260410-patch-set-v4-0-5d4eecb343db%40gmail.com

Changelog:
v2 -> v3:
- Use check_add_overflow() in arg_add() (Alexei).
- Add missing fixes tag (CI bot).
- Remove unused __imm in the selftest (sashiko).
v1 -> v2:
- Delete the OFF_IMPRECISE constant, always rely on
  arg_track->cnt == 0 as a marker the offset is imprecise.
  (Alexei).
- Squash all patches together to simplify backporting to
  'bpf' branch (Alexei).

v1: https://lore.kernel.org/bpf/20260413-stacklive-fixes-v1-0-9f48a9999d6e@gmail.com/T/
v2: https://lore.kernel.org/bpf/20260413-stacklive-fixes-v2-0-ff91c4f8d273@gmail.com/T/
---
Eduard Zingerman (2):
      bpf: fix arg tracking for imprecise/multi-offset BPF_ST/STX
      selftests/bpf: arg tracking for imprecise/multi-offset BPF_ST/STX

 kernel/bpf/liveness.c                              | 114 ++++++------
 .../selftests/bpf/progs/verifier_live_stack.c      | 193 +++++++++++++++++++++
 2 files changed, 255 insertions(+), 52 deletions(-)
---
base-commit: 71b500afd2f7336f5b6c6026f2af546fc079be26
change-id: 20260413-stacklive-fixes-42e258cf0397

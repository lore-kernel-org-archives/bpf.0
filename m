Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FAC63B9
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770932082; cv=none; b=Gg643My8Nlf15zK5CSsRtHIZz6a3GvTgSH0JMUx2A9ZFjXXZ+AN2qQfEsLj1OwI1EosLfI3veisQrYcRkENOHGBwbJXa5IyUMHVXFxZh39ga+DK7LCZY/g3JOTGVdzAvvBn9dgwNJh9TaxxnIV6efE/C0wqfPav9BI3a1BcYtGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770932082; c=relaxed/simple;
	bh=0RGfmkGaGwDtfdx7aTVYjPOf/6NZgw2J3jewDDzTmrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OzJrXdZFVHF574dopfF8m5QJ4taWqPH7H6g/oGb0cNJJiHevZVe6FtQNWXhT7lqmsT929imOEvvi5NuAcWCfYyZQB3tKldTRp7vtEmaeDOX5FqxAG9VPyI+UJegFALUUsre224kaDx7cYMh0su12Gn/EGuJhzfB0Zw3lqDTLxZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoPk0Wb2; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoPk0Wb2"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c633984fbeeso1026769a12.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 13:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770932080; x=1771536880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t30oWnFwxTyEeuptJ9JLuC3lb+/w1NCQfS8Y8PDEJpk=;
        b=CoPk0Wb2MWxJ+DEdDUetKTr7a9uQ3MCeti/vYy6x6n6K6ukDNFr8Kx9vrZaO6jahUX
         vydZSwW1Drvhpnzcf/dtdA0BajZBKW2f5yRyNJk8q23VUsjM4lEp/p+WeDjskCg5II+8
         NK3LnnNhZXjwuQwoG6S0W50ItSMDGqFCFRUpzo+L+Jj1p1K+3+Vzp8wPDwl9vRbTEsQU
         yvh5W3yvsrRjybjBbnFQUCo5KENNBGGVE26PcTRQHiytdOC+i4P15hF/jd1ikPG4P/HU
         Lj273Uq3XesTndK6fygVFUWubTVXqchMsbfUbA31xjQIhoxYlZuZ6KLiim3bx6YMLiQN
         ENIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770932080; x=1771536880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t30oWnFwxTyEeuptJ9JLuC3lb+/w1NCQfS8Y8PDEJpk=;
        b=M2/oFg9bMFu9l2ZZs2AlITgrU5g80xcCWfL3W7cZtRCn8wItWwTt+bVijrnXJ7a829
         TlugZO+/9jAt7S3U75TBA3mrj2Zy7VQBqX+l6z05/vZr2MUwNSRrn26cQgWepJyyk7TK
         QQtOb3Ry1RSM7Ps+X/u9p4PY/7GFtbw6Wvgt26zuHdeCtxHkwnlCSjLdPnzWVMe/b1dn
         u18ZghS9qUON7Wn60I8LnEknUHaIpNQ5lReD4umPFzDJKUPg6mPJJROXhk0iH4YJ0YUK
         eO7OpavhQEhfHvnY7INmmgOKSxSeR9p5yagpTM3GN13zkhH62YHIxRJXOOku5kcW3y/B
         z8zA==
X-Gm-Message-State: AOJu0YwyKR0A+GZZUmTA4080b8GCuejg/t2OwhFj5WG9xNIr7iV9gLen
	1ZywRS7OC5od/97GR/KPN3sJB97cdMoGihln8DOzZmUYTE9zJCOJ5vNYPXUEUiLw
X-Gm-Gg: AZuq6aJNfNJCkoWxmqYhs7gf0ChodeKr86+eRjHp+NDk7FbaoNoVCw95htqg/Y/6McU
	7wBu8g3U0G32XiJceSgQ8X/A7twB9+Ywsf2y1lm+MT4TneXWRF7htVdEU5riS2XBAFlub1EkSw5
	KPJqxw2RJ9zFRn65PBlQJW1CXZYUhXw0QECkT3q+f1VFQ+LOeviiz/Wf9vY+oLzxMcNVXZs2cHS
	rtd6Gj5orpnHEsUNmjBZSY2Kiv8a+PIciyPpJbwFeJtgy0jZPhNl9insi6Eo9WJ0V9UxOqHZ/X6
	lh8NLEcXX+c5aaSwzs+6ADpNzcZUNZHdyCCeM9nOon42V2RB5INuYEGjmaGL1WuV/BHF3Qff0fa
	cLnqchbPQaSZi28gwSvj/mrpijYbvjx7MQ22836DdWI+37kL2lhd4g+oYG1tGvQ6DscqjeIBu0Y
	yDuyLS+Ypxabh4m035HFRSWHdagiXUz0836qBIuJ36sJSoJ/Ut
X-Received: by 2002:a17:902:e742:b0:2a9:4357:225e with SMTP id d9443c01a7336-2ab3ac0d1dfmr32228755ad.23.1770932080083;
        Thu, 12 Feb 2026 13:34:40 -0800 (PST)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29979b13sm58728405ad.61.2026.02.12.13.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 13:34:39 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	kuba@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/4] bpf: consolidate pointer offset tracking in var_off
Date: Thu, 12 Feb 2026 13:34:20 -0800
Message-ID: <20260212-ptrs-off-migration-v2-0-00820e4d3438@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260211-ptrs-off-migration-9ad00d0c3f93
Content-Transfer-Encoding: 8bit

Consolidate static and varying pointer offset tracking logic in the
BPF verifier. All pointer offsets are now represented solely using
`reg->var_off` and min/max fields, simplifying pointer tracking code
and making it easier to widen pointer registers for loop convergence
checks.

Patch 1 is a preparatory refactoring of check_reg_sane_offset().
Patch 2 is the main change, moving pointer offsets from `reg->off`
  to `reg->var_off`.
Patch 3 removes references to `reg->off` in netronome code.
Patch 4 renames the now-repurposed `reg->off` field to `reg->delta`,
  reflecting its remaining role as a constant delta between linked
  scalar registers.

Note: netronome changes are compile-tested only!

Changelog:
v1 -> v2:
- put back WARN_ON_ONCE in mark_ptr_or_null_reg() (Alexei).
- references to `ptr->off` field are removed from netronome code
  (bot+bpf-ci, kernel test robot).
- fix for a comment referencing `ptr->off` in bpf_verifier.h
  (bot+bpf-ci).

v1: https://lore.kernel.org/bpf/20260211-ptrs-off-migration-v1-0-996c2a37b063@gmail.com/
---
Eduard Zingerman (4):
      bpf: split check_reg_sane_offset() in two parts
      bpf: use reg->var_off instead of reg->off for pointers
      nfp: bpf: remove references to bpf_reg_state->off for pointers
      bpf: rename bpf_reg_state->off to bpf_reg_state->delta

 drivers/net/ethernet/netronome/nfp/bpf/jit.c       |  18 +-
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c  |  12 +-
 include/linux/bpf_verifier.h                       |   9 +-
 kernel/bpf/log.c                                   |  10 +-
 kernel/bpf/verifier.c                              | 368 +++++++++------------
 .../testing/selftests/bpf/prog_tests/linked_list.c |   4 +-
 .../selftests/bpf/progs/exceptions_assert.c        |   2 +-
 tools/testing/selftests/bpf/progs/iters.c          |   6 +-
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     |   2 +-
 tools/testing/selftests/bpf/progs/verifier_align.c |  40 +--
 .../testing/selftests/bpf/progs/verifier_bounds.c  |   2 +-
 .../bpf/progs/verifier_direct_packet_access.c      |   4 +-
 tools/testing/selftests/bpf/progs/verifier_gotox.c |   4 +-
 .../bpf/progs/verifier_helper_packet_access.c      |   2 +-
 .../bpf/progs/verifier_helper_value_access.c       |   4 +-
 .../testing/selftests/bpf/progs/verifier_int_ptr.c |   2 +-
 .../selftests/bpf/progs/verifier_meta_access.c     |   2 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |   8 +-
 .../selftests/bpf/progs/verifier_stack_ptr.c       |   4 +-
 .../selftests/bpf/progs/verifier_value_ptr_arith.c |  10 +-
 .../bpf/progs/verifier_xdp_direct_packet_access.c  |  64 ++--
 tools/testing/selftests/bpf/verifier/calls.c       |   2 +-
 22 files changed, 260 insertions(+), 319 deletions(-)
---
base-commit: a86c608c067034f7e9da626cee81b75baeef16e8
change-id: 20260211-ptrs-off-migration-9ad00d0c3f93

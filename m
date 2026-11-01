Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793555048;
	b=f69KFC3vGy4UlEEWNTDx2WH3snrTwXGIGVeblXUpwOZaeUr0EpdmY3nHFEDgXmNOClJe
	 PDM9Ou1fi2Gp9Pu52mbXMy/Slwh/8sjCpVfApFuPDg88qtqMBe/em25FykrH8+hZ020xV
	 MEjwguvwu07PWQrRXh/11sdDlXqkgiscOsJbwNwbxpRlHuBjlkJmczIPrQsy1g0yURGKP
	 jjzLnCXSF0JM9T8WaN3ovRLnOFSrztktr5f3PdLp1f6nvtKIQKBL6zJCWi58OBcEV2eDK
	 aAjkHhuA9T8xbgh1HjoOX61tUO7agG+y2kT+1YRFofpPS2+lJxgFnPgiCKcSir4SdUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+75A1+X7H44L1DMecSaWeLChm6CIKubhIvEEQDDfU4o=;
	b=5lbX8ulIBNBsLx3njqc0prRVzKJKznyxHXtec6Uzm5yVspQ9gdBqJFqFJcfGEpn7xxvJ
	 v5lz6uqoA8M3dIsRwtBhmqou3Z5xHrZmtXd1QroVz7r77ZsgqRuLgGw8pIQ700Kcg57hX
	 3Eif5UAQjIM4z88B5/U8Li+BXjkf49osrmO2rk5LLVeXOd2HBexLwuyS3nej8ka0B68jE
	 fsaklR2zrGRuJzs8HF2+PG8WJiKKDiyieGM8igUK4ONYbE4aR3NUzwKGCHYXec02Z4KoH
	 Kcb+mJ5Yx1zqoew72c2lKIHsXVtSYT2DsEWRQWwZnj+dT3d409fY2LXlzdUTFbBpirQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Azc80EKE;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821EE606A326
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 17:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 821EE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Azc80EKE
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso1308831a12.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 09:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793555047; x=1794159847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+75A1+X7H44L1DMecSaWeLChm6CIKubhIvEEQDDfU4o=;
        b=Azc80EKEg5Zjav8NR0v8OroT+rIZFu6GGcPNkQ8Xb6YtC+wCkvSveA9OH8xPF/KxRS
         2NR4qFrIY4hXIVrRRHKxZy6xiD5rZyDDUbwZ6xVUcdVpD+FgA3lSKpw8VINwjxNFACaR
         cqJGndxRK3AC5+uEWD5+7y9/q43IxNhm715qV45GlMRfnZRukV6NLB9XEDw3BSzMWA8B
         aYmzpHtM/T7KeEy1MLVwFXFJSLt0YfVWEaIaXXO1Fcykv5Lo/446cdZyIde51m4NKJDw
         emdERviEuW8UdA7QYnAruDDQVp0/48ChU0nW5fVzoWxpTHV56xCQMPf0jW9RxGh2sDGY
         tEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793555047; x=1794159847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+75A1+X7H44L1DMecSaWeLChm6CIKubhIvEEQDDfU4o=;
        b=XGe367HIyCeUfim6kK0nshTcy+PM0kXkNuV1PeJqpcPPXBq9Vaz83UocvitNUsQgQM
         vwnPUcYzMRo/0YKg5asiltPxnBOzKaPmzP50SRcMT7dFSdB2nm8kZvcQqWh2GjWKcVml
         Z0Ryl5BdAW9pr/iLAZC0PG+vW5aDB9nkZd4xW32TrnUbL3KUoSMcVOtg2OgDE13nII+T
         UE9EcvecV4Xiv0+UR+XB7/cWccclZ4511HpKScCiDdhIEaNZ5h17oMHMqH71oWRYsBOe
         /K/uIjTkmiqRvqvcmzwB5xoe32Nfz24yzISw7THYCWbf4eZYVBZmd3AwOMYvM/i3+Ky8
         1PKQ==
X-Gm-Message-State: APuU4Z8hIaUMjBh6QjDs6xPBko59oes5LnGHyvol0fNjc/G8vvVz+brK
	/hTjCrqCgdWdweJuYTlzgaWwHTT1c5XvZfMelAomQEz3jqmdcymzbPehrluoEw==
X-Gm-Gg: AYBFou05B8GDitfAIjMNqKlcJgtGvfs+DMqHEM0sgjX/I9A+5Yvk/C7mMkxMi+EgLuw
	FRrIDAhSFyEMPoKzY+5kn+aka29b1LcC7p6tbTDi0c9tY67LYJRGTWfoTuq2oi6lBDGG2clb2py
	WF42qqsYXhMpjqUtSu7hDjDG1r78Vph0MFZ9N0cEdfaZRnJYthVvkyq6emAD/UzzRL+8LKMwJJM
	YRPgijndw3q/jh1uWVz0e5o7bcIu/R3pSnvRIMM7slvKQlvWXEmD6/P6U8RQVS5m1B/qj/VnNcb
	atLcUkA0F4dZklXjMY7BdBnQd4FiLG/KGhkOy0L+UCAadDDO10Kc2ZzsFj1bbjBjvf18ZKTnTkc
	XM/E/z0x+P6QLHdwQQKurJYOxVNz1LZhPt59rPMITmHg3R4M0xrIUEX+Bsww/NoxD3I+Z9lWKkS
	xE3wmnIkkTInxXaO+DIhDk+2NyDU8r9mpc7hvkBP7qN9gkBoN04zUkxis7psvKt8KT7yaxq+JKQ
	SY6cAO7I9F/HlkQ4MWqF3V9Nqf6tnK5I4x9fRB/h19eNhhOWgWySSvXyTgc7LpgZpGhSTdNt8/J
	najxkI8rCjglEmJi0It+xB4TGfFszZX6+sHz288UkIXUjFWPwgdGuzQ+alfnWv+WoTwYwlsEy82
	YCLvggJQFuEJz9penBafxeQSNM5sS46uBdF7bq9xs9j6utHfgtV/w+jBcHJJkxp4sq5uEbUvaLQ
	==
X-Received: by 2002:a17:90b:562d:b0:3ab:be66:ddbe with SMTP id 98e67ed59e1d1-3ae898146a0mr6444815a91.28.1793555047443;
        Sun, 01 Nov 2026 09:44:07 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87f99899sm6029821a91.2.2026.11.01.09.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 09:44:06 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/2] bpf: The register of an implicit kfunc argument is not live
Date: Sun,  1 Nov 2026 17:44:03 +0000
Message-ID: <20261101174405.4055052-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

The verifier fills in the last arguments of a kfunc that has
KF_IMPLICIT_ARGS, for example 'aux' of almost all scx_bpf_*() kfuncs. The
prog does not pass them. But the analysis of live registers counts their
registers as read by the call. Such a register is live from the previous
call to this one. Scalar evolution has no formula for it and gives up on
the loop, and the verifier compares it when it looks for an equal state.

Patch 1 does not count these registers as used. Patch 2 has the tests.

veristat, progs that load before (A) and after (B):

  progs of               progs  that change   insns
  ---------------------  -----  -----------  -------
  sched-ext/scx            493           26  -10.52%
  scx, as BPF CI has it    428           26  -18.87%
  tools/sched_ext          240            6   -0.08%
  selftests               3891           52   -0.32%
  36 builds of Cilium     5029            0

No verdict changes. Progs of sched-ext/scx that change by more than 4%, and
the progs that need more insns:

Program                Insns (A)  Insns (B)       Insns (DIFF)
---------------------  ---------  ---------  -----------------
lavd_dispatch             281049       5589  -275460 (-98.01%)
pandemonium_init             341         95     -246 (-72.14%)
arena_selftest_rbtree     140933      95177   -45756 (-32.47%)
arena_selftest_atq        171003     125246   -45757 (-26.76%)
p2dq_select_cpu             1179       1074      -105 (-8.91%)
chaos_select_cpu            1194       1089      -105 (-8.79%)
beerland_dispatch            551        515       -36 (-6.53%)
layered_running             1693       1590      -103 (-6.08%)
p2dq_update_idle             622        590       -32 (-5.14%)
mlfq_select_cpu             7227       6929      -298 (-4.12%)
mlfq_enqueue                3889       3893        +4 (+0.10%)
flow_enqueue              219201     219547      +346 (+0.16%)
lavd_enqueue              174292     176453     +2161 (+1.24%)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (2):
  bpf: The register of an implicit kfunc argument is not live
  selftests/bpf: Test liveness of an implicit kfunc argument

 include/linux/bpf_verifier.h                  |  2 +
 kernel/bpf/liveness.c                         |  3 +-
 kernel/bpf/verifier.c                         |  9 +++
 .../bpf/progs/compute_live_registers.c        | 13 +++++
 .../selftests/bpf/progs/kfunc_implicit_args.c | 55 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_scev.c       | 33 +++++++++++
 6 files changed, 114 insertions(+), 1 deletion(-)


base-commit: a30c772627b2ef4bc715332b1b04938a914556cd
-- 
2.55.0


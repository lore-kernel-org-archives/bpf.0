Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602892;
	b=f87wO1wdHBeTOPRIz/jH3c8ApvUB2fx9/JHv6bCzp3hodgNX+N70ynLeTaROXQk4By3B
	 rIytbML/rqGrAw5bvhEeCfzQ/12Gq2AwY/NpxOKr6NYfuZIHUlRDBlsS9P8nsYIU7s7fG
	 hSath+oJLV5gGOzoN9f76VOVPaK1rLoNtT52EfbcJSoV9l49Mu5zJMbqJPChkG4GtpDRq
	 FXavTWwNp3Or926Xoay+yUEM5+LGg7evHusVdHZFAFzWkGMzfTXdTQ3Udc0Fg/q9mY/ej
	 Pf1ND4pWcgAvl9wxcLkFt8vonDZNfwy4+WrPpYwXPalXSGKMCiPOE7SKkDhFLKwaxKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1LfQgKp0ztlf0EQ9y2RTrGf8UOpxokWsfVnFXAkS3BA=;
	b=L0OxGTyx0JTXu9icDJsbirsQFtpFRUeNul69dnKYa7U0yAytmiDTPKF5oznR/YfEPmgj
	 fiurXd/Afbf4bKuWWcoU4o9otNdJSgBYaJAxlerhOdsO4gSJ1lEXDH4NonmVA7C1KPRYU
	 wH6/R5tkeaNc5NihQweDfBflgzPQ1SGdYq7DzLAn/7RIFMKi3UwywraB2v8DqJ2Lo1tI/
	 zEuiJmPsSU4K0eQb3NPu0vRuJhTCFEqUYKN5FJ96rl1awmtV3OUD9gEI5uSVS7DiX9+B+
	 Y3PKtWJuuIMeeblapiCWtNTNzBk8iJbeQJKajGWQuAWQwxuttn3137CyfkVS6M+AW1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=gyrnnNCA;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51503606A31D
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51503606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=gyrnnNCA
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35943f55c06so99493eec.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792602889; x=1793207689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1LfQgKp0ztlf0EQ9y2RTrGf8UOpxokWsfVnFXAkS3BA=;
        b=gyrnnNCAok29B5+xIlr8Sc9LwxGU7weiLCTmja+5PDQ51jyX3L5E5jTHOBbHvb0EOc
         aJmUsu4f4VKzJPm5US+CpAyN5P2V5jP+qTW5fj4+oDwJMLPLuSc6vEZGUmrLnaR9Amq/
         CU2qjlqUvJHRLfize0/hrjt5c5q7ZzD6uNNSl4FxxDj8VuM+CXyUSxaIi0ffJdgPj5Vt
         VpV3uo1gpyhDLsla4BpwksK6CL+A/wY69psQHhtgUX0ZyQnzOCOWYXjdql7KS4m9elLR
         9fpDiFDNS9Qq44+MEgYuJVMmWY6DhP+MeHFXY5UOE6v1hlte2/M0dLUmowo/QwA+6BnO
         pQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602889; x=1793207689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1LfQgKp0ztlf0EQ9y2RTrGf8UOpxokWsfVnFXAkS3BA=;
        b=fnhKtBlls4KzSIwaT5B7V1KLJjHw5FA+rtAsizRA3DiSzY5FvWJKuZZbmOlD93Did1
         rD7ARM40IEYp1JWxD+sFImctuP3+Blhgr6+1pZrL5A68M2cyz8hJGIiIrr9Rg5xekycz
         3I7lPKwamhnUQYc+Qq5IMevdJBINLgWyXo37u0GDKozHvE1dcaeIQGApuWpmQ5QQfct+
         BN+MPu1Wsg0xOb2IKOV6Xrjfwta6yU9xW4E2hXYmUpQmv0RZaEaDAmlGdZA70svKR+BJ
         LiAqKTrdyxXEp9+ACTn0yOh54W/cGgXrUgsTOdcHVmaMxD1Sw4MscJAQt6rJiZ0zMw1T
         OFxA==
X-Forwarded-Encrypted: i=1; AKwUvBzMek/iuxPis587LcscayqEcb8g43CcFhdBkIk9y0Y0nnFXerJYVwXD9cG6Mey1YJS17mA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5wKVUXdAYz0WA9CtO4lb1DyqoW9OzpMV8rlCcu2CsdaG/5Zx5
	jBZrT0kb1fun73fpkXxGdAYZO8vQUHDG/YGo/b4/rqI5X8RWuughm1UzC8ZpRSjLV3o=
X-Gm-Gg: AYBFou0GMpS95uo0eyYKnFttrXTjWwlX6AF0Y1Keskh+P1BDXBs/OawdVAiHc2UpBNZ
	8a2BGpb/n5KrsyRRZOJ38szRyA6xVSMzEtY14VyooBFsXKhEKl+oanQDZJ22ltfRc5pVDDPn+ba
	i+sQ3QwN8IjTWYby9zsmE7sr9SOrN5WSqDeJ3eCj9n8bY/h/PyXoMAMwDcff6fEfXrPt1v5i8IC
	cUGIzL+tNDrUvyp+Z7eSQ8Bb9EqvefCnqTe8KiXxZ4hxOVVvjcrfzrlafd/UfVSq3DuRY2UyZLJ
	PBF6M8a0CnIP8eIUCIxezVSCqA39LsIGM7U1q5F6JKSG8fUsCzzKPvu0pQBo/MlKEUzLWhsnqHz
	WfwRoDnPKuh4kp3YURReHFd4hQ61KlB/xZkSUJ7fxaggOwM+4HhL+tXQ7ej48PALJzcqozsK227
	rM3vwuBzPTLwD4mUDrIOfTf/gmB9YY33XASaHPgOWiW73VOgGxlAFV0irJYCqGbzMj4XivUYeQ+
	3lUtJVk6R0t9z6drr357P+B6oopBb68bFmhbRUGDExDBmPyS23dAzzmDasyE3Y9ZzJtffQJLJ36
	wS6ojY4mo93zmB6qmyHac4ZHpCTOwReQM2184s69QCvvbETzgaVM
X-Received: by 2002:a05:7301:d804:b0:351:7848:85ca with SMTP id 5a478bee46e88-36888be04femr354554eec.7.1792602889175;
        Wed, 21 Oct 2026 10:14:49 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d059:e601:becb:a5ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc8439sm9458105eec.11.2026.10.21.10.14.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 10:14:48 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	olsajiri@gmail.com,
	paul.chaignon@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y] bpf: Check the helper function is valid in get_helper_proto
Date: Wed, 21 Oct 2026 13:14:44 -0400
Message-ID: <20261021171444.99931-1-artem@trailofbits.com>
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

From: Jiri Olsa <olsajiri@gmail.com>

[ Upstream commit e4414b01c1cd9887bbde92f946c1ba94e40d6d64 ]

kernel test robot reported verifier bug [1] where the helper func
pointer could be NULL due to disabled config option.

As Alexei suggested we could check on that in get_helper_proto
directly. Marking tail_call helper func with BPF_PTR_POISON,
because it is unused by design.

  [1] https://lore.kernel.org/oe-lkp/202507160818.68358831-lkp@intel.com

Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20250814200655.945632-1-jolsa@kernel.org
Closes: https://lore.kernel.org/oe-lkp/202507160818.68358831-lkp@intel.com
Assisted-by: LLM
[ Backport to 6.6.y: Apply the function-pointer validity check in
  check_helper_call(), because this target has no get_helper_proto().
  Refer to the target get_func_proto() callback in the tail-call comment.
  ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2025-39990 to 6.6.y.

The helper-validity check is applied in check_helper_call() and its
comment names the target get_func_proto() callback. See the bracketed
backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 kernel/bpf/core.c     |    5 ++++-
 kernel/bpf/verifier.c |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9fa984ee076bccbf5e90eb6a194cec68f2351200..bec8876f12375bbbe00d8cbe5ee7d410e48ecd88 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2959,7 +2959,10 @@ EXPORT_SYMBOL_GPL(bpf_event_output);
 
 /* Always built-in helper functions. */
 const struct bpf_func_proto bpf_tail_call_proto = {
-	.func		= NULL,
+	/* func is unused for tail_call, we set it to pass the
+	 * get_func_proto check
+	 */
+	.func		= BPF_PTR_POISON,
 	.gpl_only	= false,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_CTX,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 778a68bfb91dd4e765252cfb1bacb4b658d1381b..a72e1561464cb94942afa723e57c76f032d30dc0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10091,7 +10091,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	if (env->ops->get_func_proto)
 		fn = env->ops->get_func_proto(func_id, env->prog);
-	if (!fn) {
+	if (!fn || !fn->func) {
 		verbose(env, "unknown func %s#%d\n", func_id_name(func_id),
 			func_id);
 		return -EINVAL;

Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C5F175A6C
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117329; cv=none; b=o4NcWYjQiOc/PThp8eZkoRHl2MeJfkbVLc+RiYYUwMGy2GnTVFYtPNkVCurT/wwTJAx0fEnMRDj0ZPn7Dq/y7h5wSPw1gy/ZVgP1TdrwnEE5LJPa1WtUYzw05OJlvhYHx0TvM1hbQ7SSbc15g5gZGqVqIkhXWlWV+gVoPnQWSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117329; c=relaxed/simple;
	bh=7Q6IKmh8hgNOnP1yiHyT5ic6oYj4j7ar9wKDauewCns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCQjS343NA5/C94QEF1SKBx5OE1+OSXyBI/BZtW0H69WCUkzmZCMBqVMXE60duh+pFdn5wsPoIW7VGDiyZHvbaDez24lsEPpDMaWrzGZ6RLCQ9jdOChbAD8L+6WnAMuo/BjmDT8zoOFAG5BSR5wPyXFRsFMU7aY6yT89SwVrhqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Up0T6q48; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Up0T6q48"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1319960eec.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792117327; x=1792722127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1LfQgKp0ztlf0EQ9y2RTrGf8UOpxokWsfVnFXAkS3BA=;
        b=Up0T6q48dnYruownusx4TOFHibVfhtCfBD0GN95+Lzi/8/09hZ2aUm/YHhneZE8n80
         mSkO5hcXqSzrEDUalnJZqIvZjvOZ8wlgQwvdxCxKYXFSHoeFv6/C3cJG81y/m77eUCvQ
         kkeDtuygjPwad2J11xD+0XOd+VghjV5JJ1bJZJ/tu7cVbViueW9s2cBS+pjY/46A7uBC
         sMeeatDSWgbJ49aoVV/dBiPczUwOQe8qYCCeV6FlhcY/7VDhvTYk2Xmn1WHY01exIpZ+
         hMgwZwiYdfBv9R8ONhPaLqnunOptp+sCF6sWgwY/6CtR3y+cepTcXKZS5HCFVGpihXx6
         QVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117327; x=1792722127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1LfQgKp0ztlf0EQ9y2RTrGf8UOpxokWsfVnFXAkS3BA=;
        b=jGnOa0CrhGqSsH2BmPjf5vQOMKAtZmT2AEPVrXb9xjLQpLrBafIpIFW1DaBmVhr9RT
         PX1bsvpi8oI4zloNzIefPhc2WpE/f68fuqcl3lyi/3xJ6kRUnrhRKpIv99Jmg5pqvJmC
         tVGYdY34Xk0+6tja7SNBeVoFLPqPNAP5VnabTBAJW5B1RCVeoeYFi1k7WfSQt1eZTIEd
         LnbC9KPt/hTe0RO6y9bemnQxEaK659RvvqlAfXUKwsx9c0HEMTmNqUFgDr229ma2dDbj
         3Kw2L+sZYHM3Lr7FKetk+n/4VGv6IWyii+TOEgM1bJBvqwip/3hpAG/1wvESs72b+UdF
         15SA==
X-Forwarded-Encrypted: i=1; AKwUvBxdg6cUVZKfWqlE96mmHktEURMCCGNegXlWH+EUMs+R7bs2WB9hAjvXCwx9Ew4s1iWJxRE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLv34+mzw8JW6H0bGsNzycYDKbIg8DOFVXwC5GxG3vVjaH94ZIz
	d7wKXPW+pen5Zs3bXTbYlL15jUwtiCDvg+3sCxX6LTbSHagdiZFw/9oTvGv9Fkl5XV0=
X-Gm-Gg: AYBFou1OOQ24ZNw7rXMZMw1YngYtTxF68AzvpbGDpAAeYVaID6k/5KU5JGCDpnILAcG
	J4vUu/mjKGzXBK1vdoj/1dtxoaa5+IE8GLaMQTkNFT5uKF4ePRdeDcNIKfdieYirlGezj0kY5F1
	sY5DDUH6bag0ZmnYXkkMBdzuhR1T7xF8yz5gKi87ytWsunppM89faP2kqOXRQiM29iXA6rrohYD
	U21F38henQW7ez1Vjc+VpZlMQvuPaBvBh9jtvHo19s/KMMfyHSXndXsj06vTrmYIp834PQP9V9o
	xlCn/oKryWlkuGMoLbdVXHD9VutLVRcEAPysx6xzT9JhjVdLAMvlpiyrmLBQZLKDksGgyIQFdkO
	xEIDBra98i8PARaxZEmXIYKKB11Mw+mmYRt+JkFlnPa9eUFXhj1wfFYJc/eCwBr9BRS7hQw/JOn
	oN8RDGovd3XCOuiIXKZZ2uSUZVl0ft+Vs339vE3lR1rT/OxpB4Yrzw11eGwfsDBRGm8AgftHGdO
	dpsN56nyRO36JCR41ci6f624v3bp2AeRg8rbHkkMqRSoBcAn1Udc56BcZB8fUh2UAb7aQ==
X-Received: by 2002:a05:701b:2510:b0:13f:c85d:17bb with SMTP id a92af1059eb24-16a5888c49cmr30633764c88.1.1792117327042;
        Thu, 15 Oct 2026 19:22:07 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831bd28789sm1380909c88.19.2026.10.15.19.22.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:22:06 -0700 (PDT)
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
Date: Thu, 15 Oct 2026 22:22:03 -0400
Message-ID: <20261016022203.17034-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
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

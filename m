Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633496;
	b=Vlvb9841DitQC0gUduvB87tA+0JHPwBhKQN+z5rt7k+RkjcspmC0RUThGtVZEaXoENup
	 s+bPXTXSo466q1ma/YNb62CFmayXJB3oBo8vVLoXeYGYQsNoJ3K6YD/1qWHMS620Nr7wJ
	 +QygnH1STZUNOzTZd+xdmzekUd85LEwbodDreqgxwm+G0feQTpm+dbCfuRy+O88hba0PY
	 xC4xB0k28dAcZo675Osytiqfunl93crRyCWQFMrH+LuVfXCcjT2VUIhR3hvJkqMh+AcW9
	 X4wf1eLEl1CFIfkZsxmu+T62YYeURSi2CWR5wuo0QXMlbxNSJMjkf+QKZXqKP28UZUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H3hmPaShbwr78fI66noeoATtffti62xgKh213AqhveE=;
	b=uuQ3vqQLqZBe6vgsR9M9GI93Ix40couxzIyOFiFy1lMtTfShS6aynbrZ0q14TuU7cVXd
	 vdJKHtmmnC51Mk6w3JAaUmNkE2b5TjtY8lZMuMyqnaqLUzEySI3OFQIrHie1G/TQIN8VU
	 5i9585fkR6pDeS9u1+8viW8sPuQ2zlZkRX1GgQHh9Hs2twkAGepz0fsJAIxG65l5bVjgr
	 NjLJLHo3tgfYWfQjhaeEVPShq8SaDuNiHy/UlhI4brSbaGBn8zYOnzNYDOkWRXfXrdrhX
	 aeAgTK51DrAegDC9euStv7SP+4smELskW30rK9AMrfqBuCuX33KIpv0Q0YNlAex7WiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mmFjUbe2;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B0606A323
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 05:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 857B0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mmFjUbe2
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb684859cbso1573644a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633496; x=1795238296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H3hmPaShbwr78fI66noeoATtffti62xgKh213AqhveE=;
        b=mmFjUbe2vE5cMuEwnNXMjH8Lx7pnbpg3Nig+ufyJRAQWsKT68UhSj3GZbe6YFSePcD
         EVf/oxkcVhPBcKwO+XDvLOjR9A8D/txoUT1yn1e/7BILLeVPID0Mp2nD8W4XYCCZ+u7q
         JVHg2BON5zMVuoXtf4qOb2Hg3RCsH1sfpnRru9c3gr596JkkV96L61MHijzvhyTM4Q0g
         OLT9bnAfw1wD6enZ5sc3o2mWMZUf92I2ZaepkpTgyJ5AujxF+gwgO0IKZeGW3qYOV7MK
         3Cyj/aHd847YAejSfRbnSHd44hYFBuoDBhtWGz9xTQiWRu1r5xu1EAlwtnh8VIk2fw5M
         ZG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633496; x=1795238296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H3hmPaShbwr78fI66noeoATtffti62xgKh213AqhveE=;
        b=03fibF+ygR9tx99NcYv16759fWIY6zIo7oj7jhAAKCTkjlUIQ2tlNJjoOLtjOthpxe
         5ijrCxikLRon3IlO+WWqo025NfeiC/Cgd9OrogYj0Eb/HzH7tR+HUnJtDq2Z6bUqAhsf
         1Gp6/Pk9f18S0euXhbNIlsQDEunCownS5J+h7n5ip/VMQVjfw4DbzbpxVbWPHPZ2vonD
         zH80y+Pj4cTcWDMwNMRGnQlimEfzg28g+zbPCuikJpR6Cgfq7+m+shCR0Y6W27L33hzC
         z96++JQFiEJfqHxfKV7dK77KQ5qObItrPq0ik3zfJ84pKExughAPnTi81xIaguUi+owq
         vTlQ==
X-Gm-Message-State: APuU4Z9H6nNavnqVTVcGlzm/En+W82yPYVKVM1T1zdD4rODAcM1YIe+S
	BLZu3Fhal8P//aJoTs52uBZnn+pmKawyFbdAK4nWAcOhU6Ldxvfz6QimjZJfFQ==
X-Gm-Gg: AYBFou2RtQ9algFDpnzQEQINAoslGi16dDHqAOjMVDhElw3rOgrBfBrLWBFLH0WheQE
	xy1nnzVzv3qN0mPPtgDmdoq3XDHFNO9s6LbRkLXMN87fbhsduVGccCggk95EAQQW3FRn22Cfasq
	skI7cnjn9Wkg0mxxtJL8Y+yf4zaI3Bt4L0avx8NOcJAFMU6JPLwiQSctwMSjJJQ0tqgc5ChDebl
	gKoW3eZI27/iWsRHvaMKMHxGEzE2pkia1wbla0iz/lwRJ0h//a8jHD2ZsNtrkZvE4j2SnukSUvz
	E5IlhPfecddeys3eZjkfkj8g4mWmKKAB3TbjjsK7lLVutn0MXyqC5/8aDYtTZ07uobxADfpJemL
	D0U01zUdhwe7IlYdtoS2JWKZbj8Nd2RGO8URDx55YKh0FPGSSNjVgzrCHhb010a9b9rVDO+d8qY
	72RjTec2Usx2ohwFHrHOAizOESHVRcJh0VI90nvn8LCQJ0qPjpkSfIhRYRjNZgGQ5/eU7RUNwh0
	LPYvK+Qp04Hf81KeJpT0FfC9TyeFTv2fuIJANi1ptfpFxy64fI4RUigvfC/9QazLGxADlsrm6TY
	bKGGIO7e6L3Og8RA4rU+ajUZDb0kTpumd6UuSQaOZq0cMJ6NZBZF7LZMobiCQ460uV7oDADsjrD
	XHGDt2Tj9bZHrQcR508fiSKvA4vjACQ/IFH2ZWRMg/FcGgkiVQsCLQmoF28eSwsVQDbZMa4z43A
	==
X-Received: by 2002:a17:90a:e7cc:b0:3a8:59d3:5317 with SMTP id 98e67ed59e1d1-3b1b0a1000dmr4688318a91.32.1794633495566;
        Fri, 13 Nov 2026 21:18:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb3d2d4sm7402940a91.7.2026.11.13.21.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:18:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v3 bpf-next 01/11] selftests/bpf: Don't depend on the width of a BTF id in verifier_live_stack
Date: Sat, 14 Nov 2026 05:17:55 +0000
Message-ID: <20261114051805.683966-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
References: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
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

kfunc_iter_stack_liveness matches a line of the verifier log:

	 6: (85) call bpf_iter_num_new#95497          ; def: fp0-24 ..
	" 6: (85) call bpf_iter_num_new{{.*}}          ; def: fp0-24 .."

The pattern has "{{.*}}" for the id and then ten spaces. The verifier
pads the insn to a fixed column. An id of six digits leaves nine spaces,
and the test fails.

resolve_btfids sorts BTF by name. The next patches add about 11000 decl
tags to vmlinux. Their names start with "bpf_fmodret_retval:", so all of
them come before "bpf_iter_num_new":

	                      id of bpf_iter_num_new
	before this series      95497
	after this series      106933

Let "{{.*}}" match the spaces too, as other tests in this file do.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_live_stack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 2d31868bcfdb..4bc4091b17a5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -979,9 +979,9 @@ void __kfunc_btf_root(void)
  */
 SEC("socket")
 __success __log_level(2)
-__msg(" 6: (85) call bpf_iter_num_new{{.*}}          ; def: fp0-24 may_def: fp0-24{{$}}")
-__msg(" 9: (85) call bpf_iter_num_next{{.*}}         ; use: fp0-24 may_def: fp0-24{{$}}")
-__msg("14: (85) call bpf_iter_num_destroy{{.*}}      ; use: fp0-24 may_def: fp0-24{{$}}")
+__msg(" 6: (85) call bpf_iter_num_new{{.*}}; def: fp0-24 may_def: fp0-24{{$}}")
+__msg(" 9: (85) call bpf_iter_num_next{{.*}}; use: fp0-24 may_def: fp0-24{{$}}")
+__msg("14: (85) call bpf_iter_num_destroy{{.*}}; use: fp0-24 may_def: fp0-24{{$}}")
 __naked void kfunc_iter_stack_liveness(void)
 {
 	asm volatile (
-- 
2.55.0


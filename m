Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0186463B6D
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620054; cv=none; b=t7u/Xx+BAAJr/HMmWrderC2yDEldKw6yabIPyO/uflWEugp2VW7Ipr5lZh5NGNnZeEIFw4stJVHaM6LOl+HSEvC2cQqGc5Skqv3t17i/peUqyPRdgqxGkG3nw41jjzWMmIhUlz262AWUpTqjFCO715ihs4w4Sq7hqKskhAIvW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620054; c=relaxed/simple;
	bh=P5YIBD+IEF6HJRaAGNy7VzeGfJT29meHNSysVeIQ1pQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gInFFvXuM1zNvfbibDK/c/kEdsS/zbG65/KtpWqdb6L/PPrHM9XRs6ueXdTBX+DbsA1+f5waoC0s7f3RLj6J9+Cdfnt1HVytEF14ybNllpSrtuQ7kqRl4N8UVcIvz617YOCsHTdKTOKUnNkQRGUQojQCn+lT38T+IXt20/on2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afQ3Lhds; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afQ3Lhds"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso613705a91.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786620049; x=1787224849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N7j/+SMKaLuu1HBtE5dsP3tHnoNTq6cGaHA0oSdZ5Ek=;
        b=afQ3Lhdsyb9f7UkdQzrMv8gCdxmE90rI0IwwDCEIqG78Oqi0IrmQk0V+LAM5vgs/wY
         sgcoKlaOb/EwIM2Hb97/R/0utu6VZG+uVxNNug0hmefvaUMQJAlLwm/ExLWtiYoS8yY8
         D9bKu4R3dYYlam23aOAPPxyuP+U0ByAYHuenGqs8g98hWxfLBXYNbNhHWBpVMjnKF+EG
         jiZcGAkhrWodvpIYiW9CQsDa7/kf3GdVlPEtO3nPJJIrbr7lKFqeELosVQKgCxtxMsBj
         qV2Dh2TnAnTS4XB3V7RlTXheqOzwtHEQTo4mqNtT8XeXtEzUz44SNX+cgPBb7YCxB1MN
         7Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786620049; x=1787224849;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7j/+SMKaLuu1HBtE5dsP3tHnoNTq6cGaHA0oSdZ5Ek=;
        b=oraoMVzMr6vbdVJ+uB3bOMpY76pGa02lcTQ0hvwbDcUgIhHLvFRqlF52mI7kH8hAxq
         reovWHKbAe0idHt/8vBjRJ2FGImRDnkibRSEYq988hAxAy0QigQXxVZw+S+bTpO0qeLq
         oWgtyD2aHIi8hZXjKuIpoLibr9CL7tSpoQumCmL7RiTE1kdnCOu/J87XpjLUfWUfuq+u
         e3wXnhSPhBx92fIpEZysC8/x6HiNnNYsVdfjEZ2M7jc60QOEPCJfFOA5dwt/fdbJAeB4
         XeqxqYndnwdlTRXj16YC/itCfaPlX9IXUlSKM3O+ohQuihsd/jtAYGemJl8UQ5fTzRQQ
         kvUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCdu6gy2MPAXdOeNFtcRBY/n5E8If6/1rT8114sk+LhBOEli82WdRS03nCSL9dBtMLoSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dZdW+biFGQYjxp45kYnJB5rQrXAHVYbcG9/kYXhL4+Z7n2Wa
	D7Y2pvIlXrOuXQLDsOiGZLtSCEn3yoHtiNnGq3IasqiHtQdOqI9qbGe9BEvM6QVP5/cAD3hnag=
	=
X-Received: from dlbcm36.prod.google.com ([2002:a05:7022:68a4:b0:13c:fa0e:4693])
 (user=maze job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224d:b0:37d:f983:7b5
 with SMTP id 98e67ed59e1d1-3931e06a33bmr6076285a91.9.1786620048817; Thu, 13
 Aug 2026 04:20:48 -0700 (PDT)
Date: Thu, 13 Aug 2026 04:20:39 -0700
In-Reply-To: <20260813112039.247862-1-maze@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813112039.247862-1-maze@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813112039.247862-2-maze@google.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add tests for bpf_sockopt
 is_compat field
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sync tools/include/uapi/linux/bpf.h with the addition of the 'is_compat'
field in 'struct bpf_sockopt' and add test cases to 'prog_tests/sockopt.c'
to verify context access permissions:

 - Test reading 'ctx->is_compat' in 'cgroup/{g,s}etsockopt'
   (expecting 0 in native execution).
 - Check verifier rejects writes to 'ctx->is_compat'
   in 'cgroup/{g,s}etsockopt'.

Tested via:
  tools/testing/selftests/bpf/vmtest.sh -- ./test_progs -t sockopt

Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 tools/include/uapi/linux/bpf.h                |  1 +
 .../selftests/bpf/prog_tests/sockopt.c        | 86 +++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index ffd96e8b920b..15f712b5b164 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7616,6 +7616,7 @@ struct bpf_sockopt {
 	__s32	optname;
 	__s32	optlen;
 	__s32	retval;
+	__s32	is_compat;
 };
=20
 struct bpf_pidns_info {
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testi=
ng/selftests/bpf/prog_tests/sockopt.c
index eaac83a7f388..c7dd22d0e3f8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -215,6 +215,49 @@ static struct sockopt_test {
 		.get_optname =3D IP_TOS,
 		.get_optlen =3D 1,
 	},
+	{
+		.descr =3D "getsockopt: read ctx->is_compat",
+		.insns =3D {
+			/* r6 =3D ctx->is_compat */
+			BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
+				    offsetof(struct bpf_sockopt, is_compat)),
+
+			/* if (ctx->is_compat =3D=3D 0) { */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 4),
+			/* ctx->retval =3D 0 */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+				    offsetof(struct bpf_sockopt, retval)),
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_JMP_A(1),
+			/* } else { */
+			/* return 0 */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			/* } */
+			BPF_EXIT_INSN(),
+		},
+		.attach_type =3D BPF_CGROUP_GETSOCKOPT,
+		.expected_attach_type =3D BPF_CGROUP_GETSOCKOPT,
+
+		.get_level =3D SOL_IP,
+		.get_optname =3D IP_TOS,
+		.get_optlen =3D 1,
+	},
+	{
+		.descr =3D "getsockopt: deny writing to ctx->is_compat",
+		.insns =3D {
+			/* ctx->is_compat =3D 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+				    offsetof(struct bpf_sockopt, is_compat)),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type =3D BPF_CGROUP_GETSOCKOPT,
+		.expected_attach_type =3D BPF_CGROUP_GETSOCKOPT,
+
+		.error =3D DENY_LOAD,
+	},
 	{
 		.descr =3D "getsockopt: deny writing to ctx->optname",
 		.insns =3D {
@@ -609,6 +652,49 @@ static struct sockopt_test {
 		.get_optval =3D { 1 << 3 },
 		.get_optlen =3D 1,
 	},
+	{
+		.descr =3D "setsockopt: read ctx->is_compat",
+		.insns =3D {
+			/* r6 =3D ctx->is_compat */
+			BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
+				    offsetof(struct bpf_sockopt, is_compat)),
+
+			/* if (ctx->is_compat =3D=3D 0) { */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 4),
+			/* ctx->optlen =3D -1 */
+			BPF_MOV64_IMM(BPF_REG_0, -1),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+				    offsetof(struct bpf_sockopt, optlen)),
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_JMP_A(1),
+			/* } else { */
+			/* return 0 */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			/* } */
+			BPF_EXIT_INSN(),
+		},
+		.attach_type =3D BPF_CGROUP_SETSOCKOPT,
+		.expected_attach_type =3D BPF_CGROUP_SETSOCKOPT,
+
+		.set_optname =3D 123,
+		.set_optlen =3D 1,
+		.io_uring_support =3D true,
+	},
+	{
+		.descr =3D "setsockopt: deny writing to ctx->is_compat",
+		.insns =3D {
+			/* ctx->is_compat =3D 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+				    offsetof(struct bpf_sockopt, is_compat)),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type =3D BPF_CGROUP_SETSOCKOPT,
+		.expected_attach_type =3D BPF_CGROUP_SETSOCKOPT,
+
+		.error =3D DENY_LOAD,
+	},
 	{
 		.descr =3D "setsockopt: read ctx->optlen",
 		.insns =3D {
--=20
2.55.0.691.gc56d675ccc-goog


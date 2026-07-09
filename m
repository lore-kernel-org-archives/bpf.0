Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A613876B7
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612804; cv=none; b=FTcqoyXtQc+fNFVXOnDWIPfzy4ig5RWWGS9sfOCMw/UvqH4vz8UwiXnoLVnL2utdllkSEVVXrMirnYw57S+n8OEO2b0ZvrshnwNEhMeTvcX41x5seF4/ObIVmQu3BfgSkccKoK/4jt1g1KG/WW3UDkolONofl0fcLkRbIPq62N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612804; c=relaxed/simple;
	bh=n2bDzvxS7QLPaoMw2bG7woEYEskvuIwJqDN2pv/yex8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQfwc6XLMM6izxRMNCuadzT1JIJYcOZkeqZ6wiV7LBWsOhcenl56Usj+DIlM+omRLTFISTD6J0im5uPKj2T3NwmqAZAIutEIg1nr+HJh8r9WYfO/GLEPuNOHZnZZgpjY2U/nmwhoK0069wK8eUV6tuGdANaZZ8Mg1ysKVEBKXd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sN4Dih9u; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sN4Dih9u"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ee88fce476so524776d6.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783612802; x=1784217602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x6WYVTlSKQKPmt9ZW11eAwx3WpfcKGo82W6Ezv36x0g=;
        b=sN4Dih9uVc+uuikKCv/FO3r1zOEf6UiAzY9nfuGlUzK0aspl7MHjH7Q1uPleYxwtyz
         cMFh/G2WKXzlsTaoOIVCMOkT3ez+914229GJ2QXJFSDZC+NN0lknK5DsUIXMx6IbwVYd
         8pwF9Eyeb+3cFTW3DEiBq4Oqt6u4eqcdlWLoyziwFnpHOkbPs3c/Lx7QRwVr5w3maPtg
         aA6do2DnXMtQ0McxUIvmTvnToeIPclTzEi4wiELV4nrATg7ZZIPM51rldbvD3Qitho1Q
         7F6TvpZbu2LqZ+WuUNxA7MNeqyExJHIH+LBBZt2fyhBOHUlVgJcbM1NqtUlzytNf6SIE
         i4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612802; x=1784217602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x6WYVTlSKQKPmt9ZW11eAwx3WpfcKGo82W6Ezv36x0g=;
        b=svAmps/pn44Xlg/KkmUMQ4hEQTr2pymUhbRMmFbjxMCxNVTtSiwpnWuLkn7m2SJ8Ji
         x9jexV03ManNXSW7CxrOiMofS39gc+lnxD19OQSz5tPZISsFcn1PdU2UAvOGMCrYUTbX
         06P9StzZfo5I5wOtRgUBa9Qq7qUSxXe3birJiGMtyXHPs8vlB95zFtjh4YaXRPuTrHO+
         VY2kf+Qx6G21kPSnxus5jEWFFM/Te3Y0s5E65rsF1K0YK0G/1fXiu+SrUotMSsLeg6YO
         D7mynZnEjGq6cLjJvW4ecO8u9009HNp1eaTjHzBU6x3G5MTmkYCGXeW0p8LOxFl3qHa9
         Mi7Q==
X-Gm-Message-State: AOJu0Yw9Bb8WBnH1kBfWoC+4kTGxSWpuzuLnefAc+DZbOKX3oFc91te8
	TgNGDpXiIyY0jDr3A3qQ3bP/06XcA4CADzTuSC/rPPxPkAO8hcboB/2HShNOR7lr
X-Gm-Gg: AfdE7cnEQcZYEBPyV2HOQH2QRcVwConO1mT50++8Aj/h0F4Xwu/aS6HKujvx802KVdL
	XbVCmsb03bt73ZVDXBc6DP1sYv6+CLmW49CXcFAhgP3e41BIBi1S0IrL2rrfqsWVxD470J3Tp1F
	4wzm4AOxurxakdmeDZEIe59itC1cDG6wU8/Bj3Nzxg1yFOhZyi3omJIQ22UBc4lnBRyhkMzt0xy
	EhkR3oLiE/KFrfyawfhneTxOSCEFOz28kfsNRwMn/6aM+x/v0YY/GfmXJePi7GVf7pivO5YlEa5
	LRG5UTGf9iCgs1ODG3N8Fxk9zOc5k0Z1M9NFZqz9lS/nasTxD4zKhGBt8jawaHqSDbH8no5+dE/
	SSPx+7KJR9nsSI1dzH95bEgnba1aoXOHEn5c4aSWpolNTuyoXeUyn4uAscq/8YZAfqWpzOmD0YO
	yJIqHZVULsnZPFIQYGvpk=
X-Received: by 2002:a05:6214:1d0c:b0:8f2:f32c:6bbb with SMTP id 6a1803df08f44-8fec3145e28mr83686306d6.51.1783612802056;
        Thu, 09 Jul 2026 09:00:02 -0700 (PDT)
Received: from TurinLinux.. ([184.144.109.221])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e3083sm20418136d6.6.2026.07.09.09.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:00:01 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 1/2] bpf: reject rdonly/rdwr_buf_size kfunc arguments that exceed u32 max
Date: Thu,  9 Jul 2026 11:58:36 -0400
Message-Id: <20260709155837.1879230-2-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709155837.1879230-1-main.kalliope@gmail.com>
References: <20260709155837.1879230-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_kfunc_args() detects a kfunc argument named rdonly_buf_size or
rdwr_buf_size and stores reg->var_off.value into meta->r0_size, a u64,
and does not bound it. check_kfunc_call() later copies that value into
the returned register's mem_size field:

  meta->r0_size = reg->var_off.value;
  ...
  regs[BPF_REG_0].mem_size = meta.r0_size;

regs[BPF_REG_0].mem_size is u32. A constant whose upper 32 bits are
set, such as 2^64 - 192, truncates to 0xffffff40 instead of causing a
load-time rejection, so the verifier records a PTR_TO_MEM register
with an approximately 4 GiB mem_size for whatever allocation the kfunc
returned. A later access check against that register uses the
truncated, wrong bound.

check_kfunc_args() is the site that stores this value for kfuncs that
declare an rdonly_buf_size or rdwr_buf_size argument.
hid_bpf_get_data() (drivers/hid/bpf/hid_bpf_dispatch.c) takes an
rdwr_buf_size argument this way and is reachable from a
BPF_PROG_TYPE_STRUCT_OPS HID-BPF program; io_uring/bpf-ops.c:26,47
declares one as well. The fix belongs at check_kfunc_args(), the
truncation site. The kfunc's runtime check still guards its allocation
bound, but it should not have to defend against a size the verifier
already mis-recorded.

bpf_obj_new refuses a local type ID that does not fit u32
(check_special_kfunc()). check_kfunc_args() does not bound the
rdonly_buf_size/rdwr_buf_size value that feeds mem_size.

Reject rdonly_buf_size/rdwr_buf_size values that exceed U32_MAX at the
point meta->r0_size is set, ahead of mark_chain_precision() and the
later PTR_TO_MEM assignment. The preceding tnum_is_const() check
already requires the argument to be a known constant, so
reg->var_off.value is the exact size and rejecting it is sound. U32_MAX
is the minimal bound that keeps the recorded mem_size within the u32
field; a tighter semantic maximum is out of scope.

Fixes: eb1f7f71c126 ("bpf/verifier: allow kfunc to return an allocated mem")
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 233472a871be..c7fabe50e487 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12097,6 +12097,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 
 				meta->r0_size = reg->var_off.value;
+				if (meta->r0_size > U32_MAX) {
+					verbose(env, "%s rdonly/rdwr_buf_size exceeds u32 max\n",
+						reg_arg_name(env, argno));
+					return -EINVAL;
+				}
 				if (regno >= 0)
 					ret = mark_chain_precision(env, regno);
 				else
-- 
2.34.1


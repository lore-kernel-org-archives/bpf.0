Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA453932C3
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845475; cv=none; b=NEnsJ95Qfkk3BR1FTNJ6rKma4OY2lDowwrOEV0gq2jFBolswNCYa+Y3ajUPkJVmTSWKtAB5Asn+1ifR/nxkmYY4MX4G0WvzsWEaJr8VE5Ezdj+MWTrRKdrmrpE9nl8aBT2al/YOMSCBOjl31OeLildxWLzY5Ffkp9agkNtAWNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845475; c=relaxed/simple;
	bh=EfPktGjbTGdaC5xo9gt6XAA/vTOxcyNVWc+5oVpCcQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDmjafA2yOU3wcx4i+AQ7XLhBk7yXXytohSJxHbYYJrOgWyUXlTaf5frC2cyFQx5BP06KpA3DzxgwInj0sxrPct3iHY4uIM+Jxop5x4PgO/3AIWAZSkqBctS35qjCqDwMoqnKugEM2UUnA+Bm0iiAdU54/mhhBBDZly7e0mVj4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxCT9HYg; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxCT9HYg"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so9781135e9.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845472; x=1787450272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zu043QY8JcRklYW956dTLaFp3ndqiO5Yq08MCSw4Qj4=;
        b=OxCT9HYg5dAhcs00dDSh7svHcWUH3BLtlP2W2xZVGsqtEOhuxPa/1jd1ugZGzS+3po
         1npzNmE8sktm5SFX2wqVEj2Lj8nCU+q5szi6u7g+/pLQ4U+B1DsYekQdeqdxTAPp2yZO
         04vpbMRCpMVbRfu9t0PGcQoVqq8vdhYEqwVGCtPXMQ6sqDHBKlTZUHWNlCK6tUGtedk+
         npwPRfEWUCLaNWmSGAc3DJDVHXJ4Gl7Y++7wkS1JPqm4zS6t4DOAsR7GqgvwKEsVrqzp
         Z/a/QthJE8R8/TYgXQIzwaQCCor3dBeE0bz+V0V4l5B5kYx3bIaC9iAz/hY4MIU0dswx
         fjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845472; x=1787450272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zu043QY8JcRklYW956dTLaFp3ndqiO5Yq08MCSw4Qj4=;
        b=ZIfaVwMzeUmC9LJG2s4L9aZxA8md2qN7cOEIkLC8jouMTQ6KcqklKtwwUXqkDeqNAC
         t/hptoycGxPrvrBpxY2eGqRQxmDd7P+lE7PmqzrLK0qb5538BfePgtpUYUS4RYSIMJ/t
         hjbXcuTMeuI/IJqdUWdPi+2MDnKN0p2Us8gsUiV4EJOlmLBLJuKZH/WUJv/Hp6RyDhbi
         EJdLVZgFjZKo6Xeueh/g0xtXIS3obwW+eQc0yW/otfcxHwsIyY6eZOMwflKsIcjp3RLQ
         ezpvJLUjFSD1LdP476RsDpTwLtZP5u6LHTyXA/GEm1Zac9AfwWXrxURi2l8DHZV2/5M7
         xsEg==
X-Gm-Message-State: AOJu0Yw4EVe588kTOSQprR7euwH0o+PBM6mCeNh5d/pfs1KJ89wFkJGj
	9OdAje9qJTZ+OKovOX6DanNqz9aWU4w2eha1CRzgdcjFfeQouutMQdppO2lLxOHk
X-Gm-Gg: AR+sD10A2FZQqar5DPP7rgr41vsz1t3G8WnPfnCgsXNsagRtMphqCy34t0zyTzK91ZO
	yJjIRS42cdyibfsVpj/Rh5BO4ZD90pCXzIQiNQFue/xB4KrJTa8S+p+zZmF2A0IIb/iVl2qiNUh
	VNq6K0x/lNQoxHNe/maCE1fReYVbwDTZEV9zD4gkcgN1tgGpNmNpvDG7F4jvv+Gy4DS0MRyG1S8
	uJW558HZfrbgOkEaItDRcUhBoLzY2JrfgCLnVlmPDJlTgYE9/5Bu47WKanrGdRE6n0tVBco02J1
	cRMLgiamVCSHW8qk8b2JmOW/BH2oWFRfIXqOBKelkU6o51sV90Aul+cXmbSfQ5a/sGTm5o7bLTn
	StqVrrEA+wVTXnNs338XDoW4Bjb6lOVKXm0sQLGH985IUc6Aj4pAsUdG7KVubX6y2dGpkoHjP3+
	KURRPv/8LncvQt8IapK4ZGM+PVzRSjUZ9xunJC/vIPClrlBc8pGXwHO2uet2kdmypNAojHdk/FB
	70LAjxiTNU4i9sKn9WRSA2kLEmOXuL3H0kW15986g7AdbVGKhL9EVpiM9zypydqT6JFQ1H5LIHk
	m7wSFnDenIyrV1rp5pCKkANukIVkc8cF/LhCTg==
X-Received: by 2002:a05:600c:4fcf:b0:498:ee7:e40a with SMTP id 5b1f17b1804b1-49987992130mr201905155e9.16.1786845471824;
        Sat, 15 Aug 2026 18:57:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b3a6dcsm77558085e9.1.2026.08.15.18.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:57:51 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 03/14] bpf: Preserve R0 lineage across helper calls
Date: Sun, 16 Aug 2026 03:57:31 +0200
Message-ID: <20260816015746.2632990-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=memxor@gmail.com; h=from:subject; bh=EfPktGjbTGdaC5xo9gt6XAA/vTOxcyNVWc+5oVpCcQs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQvQOp/Fq2XBXqWrejf8fXK7PWVk9Jyzs2wfDnk8+6 by1O593lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIH0hj+CslVMdQo8Kx9Eyn/ zC05fofS5cYoFfsK4Q3fujbohV+KZvjv9P9qOMPSU0n1F2ek3jUOTTwQpDM5ZieHVtplhldpj56 wAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

check_helper_call() clears all caller-saved registers before taking the
diagnostic snapshot of R0. This records NOT_INIT as the old state for every
helper return and loses the lineage of the value held in R0 before the call.
bpf_diag_record_caller_saved() deliberately skips R0 because the paired
modification scope is responsible for it.

Open the R0 modification scope before clearing caller-saved registers,
matching the kfunc, ld_abs, and subprogram call paths.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/bpf/20260815073833.A93A91F000E9@smtp.kernel.org/
Link: https://lore.kernel.org/bpf/48e6f021b89562f68850fe21ef8c78719819b04cf9c4e4f50bc791937d37ace8@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5d0a2d3ef594..7ef324e384f4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11024,13 +11024,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	/* reset caller saved regs */
 	bpf_diag_record_caller_saved(env, regs);
+	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
 		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
 	}
 	invalidate_outgoing_stack_args(env, cur_func(env));
 
-	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
 	/* update return register (already marked as written above) */
 	ret_type = fn->ret_type;
 	ret_flag = type_flag(ret_type);
-- 
2.53.0


Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108E235C01
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 05:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783919149; cv=none; b=eH29Dw7nfuaG6L/JWjIdkRmDDBpqk43AMZMDuY5pnl/2UxDZ7UtwqdW2rFH7kUfLGUT5dGFhw5D3nPvjBVW//CocB7ZtvJQWQUCzrQYdRh3uSLk/96rsY6vDoY384fAHSY6rwFW0QU7rJ8k9sJnJQdgetLjLPF4NOSWtt6ID6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783919149; c=relaxed/simple;
	bh=m0A8EozCH90mxhahYcpCYb0x5lm8UVBXtH/iWhiwtjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0w+K1zccBEEhK2QZ00TgG1RQygwaHqR2Y7+8MzTyhUGScO8wO5Yc9vtEi0FzDlvei1MGh6j8AZItw/uUVHY2h2fHkS90uozO8Co/5wOfCq8DVz8vraixrepnCJbllxWpZZAYcxxIFlKQ+k5ruF45C78MIkZUZtTS64ukNjHEGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YAcr+4+K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YAcr+4+K"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493f6de72faso10006015e9.0
        for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 22:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783919146; x=1784523946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=noLX6ODwuKJAk11/kbsaLVVFKD51XS5bO5LrY4X2cno=;
        b=YAcr+4+K8zuEV2BH5mHpAkS3IrnT4P4KGrySkzkhgeTSM0ci2l3dmhM4qqOHbM0lXS
         RivXcQAtul2K15K/acrhWRXvkbbbYcOMquXv0+ttpIz8HXoPsJaKFHxRvbrQIDY4cywx
         FvtV23k6vkBih3UKJAB2WU5fAkMEtR2eZ13JKaWlP5jyGvvZxkFqdWILPV1WLm6DcLTY
         QP2cvs01jOGdUrj1SOQpW5Mye8UygxN8mu1VdCWR2Xo+okJSaxHE1IoBImPBt1uQIRQc
         eiVD44zwRdD/9jXoPsR3qAZFhMIAlX5KECQjHICRJtc67yWEn463Pf+MIZL5VW/t+PkW
         lI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783919146; x=1784523946;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=noLX6ODwuKJAk11/kbsaLVVFKD51XS5bO5LrY4X2cno=;
        b=sqRJlxmNRwu63N7YT3qLqdr2/3VP+/Mamfc0PXScIdr0N2dbTltXny8V+ImWVdW+pV
         qEyDlRpdn5yC+6nu900ElTKwAHy+MkJloO8n1X2lpuGVurvmHl+klKNzn6sHo65SAogI
         dfIZMOSwyeMekpY3cfQRePzay9NjXD4kN53Ew4BKh9yadrS+kqZGrR3IgM/uY5/IPb1w
         gAHBBKZWXed5HidNKHg82ySSiIQtUfWVXjSZ+JsmHOE3j1tiYwtqwpZRxQIV+6zQ0Oi9
         rkZ4WCTsQdgYCjFJeZtK9zr6aJq9c4QlPk2t93tw4AxEjjb/6C8/ybDP7yYwOpnyxBM9
         73zw==
X-Gm-Message-State: AOJu0YyrLkF3fKfCK9k+CT9kSgKfh+DEtPSwuiiK+7NklXGYCt3Xs5gM
	UXuJntMKggaUYB+1Bke4EIkc7pR0vP/hIJXSMNnPBE/jzwxdxnX5s1Z5n06QcV1aHYk=
X-Gm-Gg: AfdE7ckzdZISadLR5BSMNkWwwhhPDc3MDA63Www+wsLgsXx45g9h+Co7gNS6bizPkyk
	EWzzno9rQwHs1F0e+nBKhyYc0gJc5DthnikOqxAJNfe5nGzEbWeC93aqpALnYxbznq0xfIGiVgk
	Ro1FdVWaj1MbI0wW4O+kld9kX4pIld2G9FxDqt3i+LNeCMLdatP0Ja9XTPvoSlMZ6F1u/HJ997W
	EwxKKdQ59PcoBz72LnQzU790Egr03Aenldij1QP5xzUPfirR7rKscQrPnOfAAPxsMWBf78JxHi0
	IfijcVV24WXNGY6sRaPDeRuVRY4pR4E/r4bn86Duqu6QQO9HpZPimEKxrHRTdX89NQjKaja67Ro
	alzxaAx/xdtNtrOU02fSMmp94rASysy+y29uMQZcmifKsu1iPH2widjncyArBKJ3VgdvUH0v4un
	sxsMQEnb6CHxmw+eU8gHHzNgzKSqJmQbcaJc3wIa27
X-Received: by 2002:a05:600c:998:b0:493:a63b:1f62 with SMTP id 5b1f17b1804b1-493f2ac8ca3mr74593225e9.16.1783919146276;
        Sun, 12 Jul 2026 22:05:46 -0700 (PDT)
Received: from u94a (27-51-9-144.adsl.fetnet.net. [27.51.9.144])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-451916f31d4sm12679932fac.16.2026.07.12.22.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 22:05:44 -0700 (PDT)
Date: Mon, 13 Jul 2026 13:05:03 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: sun jian <sun.jian.kdev@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	shuah@kernel.org, mmullins@fb.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v4 1/2] bpf: Reject negative const offsets for buffer
 pointers
Message-ID: <alRtilWhKw4zzMkI@u94a>
References: <20260708090151.151729-1-sun.jian.kdev@gmail.com>
 <20260708090151.151729-2-sun.jian.kdev@gmail.com>
 <ak5HLLrYK3R_g2y_@u94a>
 <CABFUUZHpPwuTk69hb54WugJwssFuvoqFFPv34dZRbKLLc1PwwQ@mail.gmail.com>
 <ak8XSRiLKx5WcIQw@u94a>
 <1f8aad47f61fbf85eb55276e4bb01bfcff61393e.camel@gmail.com>
 <CABFUUZEXYduca34g22YZ1ESyYe3Yc3kYQrTEWLMxB5X0ZmYn8w@mail.gmail.com>
 <alCgmxFh9q-vjE0O@u94a>
 <CABFUUZEnd9f7tV-+jT+cgL7sFVp7pL5-tjdwMvxcR9ist1s-xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABFUUZEnd9f7tV-+jT+cgL7sFVp7pL5-tjdwMvxcR9ist1s-xg@mail.gmail.com>

On Fri, Jul 10, 2026 at 06:27:41PM +0800, sun jian wrote:
[...]
> One detail about the attach-time check: I agree that some negative-offset
> constructions can still be rejected later if the max_tp_access accounting
> produces a large value. But the runtime reproducer I used exercises this
> specific access:
> 
>     r6 = *(u64 *)(r1 + 0)
>     r6 += -8
>     *(u64 *)(r6 + 0) = 0
> 
> Here reg->var_off.value is (u64)-8, off is 0, and size is 8. With the current
> accounting,
>     reg->var_off.value + off + size
> wraps to 0. So max_tp_access records 0 and the attach-time writable_size check
> does not reject it, even though the effective access starts at -8.

Yes, that should had been rejected.

> On the bpf base without the verifier fix, the temporary reproducer did load
> and attach successfully:
>     negative_bpf_load: PASS
>     negative_raw_tp_open: PASS
>     negative_test_run: PASS
> and KASAN reported the stack-out-of-bounds write in ___bpf_prog_run.
> 
> So for this particular range, this looks like more than a load-time policy
> difference: the missing lower-bound check leaves the access executable on the
> bpf tree.

Actually I got this reproduced in the *bpf-next* tree now. And I think I
know why Eduard wasn't able to reproduce the issue.

The main problem was that CONFIG_BLK_DEV_NBD was not enabled in the
default BPF selftests configuration, so nbd_send_request wasn't
available, and thus the attachment always fail with -2 without
exercising the checks that we have in bpf_probe_register().

With CONFIG_BLK_DEV_NBD enabled, and negative_var_off_program[] updated
to do use offset of 0 (instead of 28 + 8), I was able to reproduce the
issue on top of commit `9a3a07d06e7d` "Merge branch
'bpf-fix-warning-in-bpf_trampoline_multi_detach'" with the following
updated version of your patch.

  0: R1=ctx() R10=fp0
  0: (79) r6 = *(u64 *)(r1 +0)          ; R1=ctx() R6=tp_buffer()
  1: (07) r6 += -8                      ; R6=tp_buffer(imm=-8)
  2: (79) r0 = *(u64 *)(r6 +0)          ; R0=scalar() R6=tp_buffer(imm=-8)
  3: (95) exit
  processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  tp_fd: 8
  check_nbd_attach_reject:FAIL:nbd_invalid_negative_var_off unexpected nbd_invalid_negative_var_off: actual 8 >= expected 0
  #319     raw_tp_writable_reject_nbd_invalid:FAIL

So I would say a fixes tag that points to 022ac0750883 is still needed
after all.

---

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index adb25146e88c..e1797bd87904 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -1,4 +1,5 @@
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_NBD=y
 CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1
 CONFIG_BPF=y
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
index 216b0dfac0fe..0ed1d560a2f4 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
@@ -4,12 +4,34 @@
 #include <linux/nbd.h>
 #include "bpf_util.h"
 
+static void check_nbd_attach_reject(const char *name,
+				    const struct bpf_insn *program, size_t prog_len)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	char error[8192];
+	int bpf_fd, tp_fd;
+
+	opts.log_level = 2;
+	opts.log_buf = error;
+	opts.log_size = sizeof(error);
+
+	bpf_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, NULL, "GPL v2",
+			       program, prog_len, &opts);
+	if (!ASSERT_GE(bpf_fd, 0, "prog_load"))
+		return;
+
+	printf("verifier log: %s", error);
+
+	tp_fd = bpf_raw_tracepoint_open("nbd_send_request", bpf_fd);
+	printf("tp_fd: %d\n", tp_fd);
+	if (!ASSERT_LT(tp_fd, 0, name))
+		close(tp_fd);
+
+	close(bpf_fd);
+}
+
 void test_raw_tp_writable_reject_nbd_invalid(void)
 {
-	__u32 duration = 0;
-	char error[4096];
-	int bpf_fd = -1, tp_fd = -1;
-
 	const struct bpf_insn program[] = {
 		/* r6 is our tp buffer */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
@@ -19,25 +41,17 @@ void test_raw_tp_writable_reject_nbd_invalid(void)
 		BPF_EXIT_INSN(),
 	};
 
-	LIBBPF_OPTS(bpf_prog_load_opts, opts,
-		.log_level = 2,
-		.log_buf = error,
-		.log_size = sizeof(error),
-	);
+	const struct bpf_insn negative_var_off_program[] = {
+		/* r6 is our tp buffer */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
+		/* eight bytes before the start of the nbd_request struct */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_6, 0),
+		BPF_EXIT_INSN(),
+	};
 
-	bpf_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, NULL, "GPL v2",
-			       program, ARRAY_SIZE(program),
-			       &opts);
-	if (CHECK(bpf_fd < 0, "bpf_raw_tracepoint_writable load",
-		  "failed: %d errno %d\n", bpf_fd, errno))
-		return;
-
-	tp_fd = bpf_raw_tracepoint_open("nbd_send_request", bpf_fd);
-	if (CHECK(tp_fd >= 0, "bpf_raw_tracepoint_writable open",
-		  "erroneously succeeded\n"))
-		goto out_bpffd;
-
-	close(tp_fd);
-out_bpffd:
-	close(bpf_fd);
+	check_nbd_attach_reject("nbd_invalid", program, ARRAY_SIZE(program));
+	check_nbd_attach_reject("nbd_invalid_negative_var_off",
+				negative_var_off_program,
+				ARRAY_SIZE(negative_var_off_program));
 }

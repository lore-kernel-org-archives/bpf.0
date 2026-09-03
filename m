Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA8329E55
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472087; cv=none; b=R05APuwKh6+725FbrMtGkutkR2V3fy3wdB6g0ZfMW34NRak4Y8Hkbk45Am4ex6I8lE6LkPNADcwFmGSdqUeAz22oX8xhNifKRx+S1NfHuYiS9OihcxvVX85VUY5tj72F0MKxUIAvfoeLBqGMgmAUZnjeScKA6Th5VicgdIu6vP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472087; c=relaxed/simple;
	bh=GXw0MNg3M1K0Eipjd0VbztESR/pRJw4y/ZFlYcTmN98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0iIjFJ9DzNKUVKXg01wkeQk7XNeK+s3JaxPnCPsPyxk2FtI8BqLLLsGbcgQDZ8nAGI+kRTCS1s4BhpvjJz2elw0SvVk95tA1XoUyT21EZNdxDIddjQeoX9gs9YAGKDbskudCEqBEL5XnHlEws/G2vTx2R+j3SLff/L7oIHUrfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXds7m9Y; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXds7m9Y"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49554457f71so165495e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 14:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788472084; x=1789076884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lnGR+VPiwd+5KTCL+4fQwf5CXe5FPf55RmxLbaudZNY=;
        b=dXds7m9YbvGJdh5Ngp7dxDPEM4HWKEq5FDpzP+/SeC5+25fnHVd+wUIdn0OicuY1X7
         Sljb0d5fU1fBbu4CcnkeGD9D9VZXb3TNNGD+QYZIR7yKCtsGHUqu95AQm3aSRshLAGoL
         /5s0Pn/hZTvcKX1dXhV6MaTT27SFHxdeRYOEKg/7HbdD81pMaX4fBy/24sP7d8+ue60i
         2DWZ7OOTNwGFvah+dcb17GUfUiMh0tSxUvvdLq1E9egsFfhjGbxDkoB6JIwVigFVR1xi
         rmITY17XsAYsK4Elrf4MWxwJJwwE9JLhzjVg2YwzsbLBC6AI0v6lCIHLrrdaKsnj6hLu
         L2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472084; x=1789076884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lnGR+VPiwd+5KTCL+4fQwf5CXe5FPf55RmxLbaudZNY=;
        b=jDUouPhpA8JUOV6irFHo+8QXZFMG2DBAGouoo7swaNQJ0miIwsANwD+SmJ+C4MsNDG
         Qb00912Pe0sh2pBbD8xteGAuMb0OUiQ5HLL/63APx41RZue0vJu5zyY7WDRf3I2Mmvee
         sqFqmVgzSCto+rokz6+BrPJcPvupExnXiPBoKJ60xYYzDXBjDgAG1kJOpDaXMD8SFP8m
         cl0aKRU7uerG0WcuuPjmyPMjk5UtdPNgpGi2H1uKNdh/ibzlRrNbXqVKcaXBOXfLU0ij
         Af3r/8JR/V2vl+OUgn9Umy/nW/EZw1VukRwTykDCb0bTbv+M5nWD/6jycv7fwULL8jcY
         /SlA==
X-Gm-Message-State: AFuF++mKb7JOTPiFLoamMy1zfzROPMRULUfk5YdVOGYuW282bVEUBuW7
	vc17JK9rijwHxambvbUl5AwMuuugpbDDQg67zERbarqpE9XYfHxYq2mmXvGWSdRf
X-Gm-Gg: AYBFou23ZnCcx7sp3lPL8qjYKdsACUzjlJleE+cO54Tc+jPlm3m+hnTJZhnT24bn48I
	+4o83ezHa9a9CsX5lvpWAYgN8S1GYHpv6z8h2pBN9chsNhcsc+wo1/x5acmwB7VSujJEQk08nPp
	Y7bymwjsQ/nGUJJ7JaX7/W6CJq5LIXKuKQ5KJBlGjamnEOtQGSf18Fk9s92wVoBsQQz+c2VeY+/
	5cip56b/tCChhJmImfE3dGQna4iqeTTMckbg3pGmu+H7NRwkSMI0tHbZwptu0RrmaDv2Yqo8vi0
	O+m8ktZZzYf/qx62AyDGDJXptE/dJ5OBdi7FEqvqTPscJ/wKDN4rKJGlIc1GMwEFGuW5X8u5JTI
	az4XhXWsvSCavNvQqhRpGTToQBJ0udYEzmkCKSq8fOc1jehssclH/Wlj5a2TZo6a7/PENZyhlyr
	70n6pWzSKfpg4I0xyqOwoA74wvR3rGYE+ZOR9Rp7CkvUKEvOxQGg9IV0Mi8XpBJh6JzUi5hAbQa
	rVRCvad58u7wkn4qt1Onfe0mrPN8CxFb4/VUkEHp3fsLR8l4jZj0EyFAoDQzU4TJ7tCIXXaCy5u
	bSRg2qk0lhcaWYkTCO5D/vyRZgk=
X-Received: by 2002:a05:600c:1388:b0:49c:eded:44e with SMTP id 5b1f17b1804b1-49cf82e5589mr5883055e9.7.1788472084116;
        Thu, 03 Sep 2026 14:48:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf771de2fsm17126145e9.8.2026.09.03.14.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:48:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 3/8] bpf: Mark bpf_btf_find_by_name_kind() as sleepable
Date: Thu,  3 Sep 2026 23:47:49 +0200
Message-ID: <20260903214758.2727663-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903214758.2727663-1-memxor@gmail.com>
References: <20260903214758.2727663-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=memxor@gmail.com; h=from:subject; bh=GXw0MNg3M1K0Eipjd0VbztESR/pRJw4y/ZFlYcTmN98=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvmaxbGjpM5N96xelwrChNwrHw1PUM5VvPIK5tFb2WqT 3a22zJ2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCK8UowMN1+ZcHWZOCw8cmsR j9qOu1LrMmYvXJEhvPPq5ncf9MQkYhn+1/8U+3smdKXfmpgtzrPWOVQsWF/xbq3jJsaLr195SL3 34QUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

When bpf_btf_find_by_name_kind() finds a type in module BTF, it
returns a new BTF object fd through __btf_new_fd(). This reaches
anon_inode_getfd(), which can sleep while allocating or expanding the
current task fd table.

The helper prototype does not set might_sleep, so the verifier allows
the helper in non-sleepable contexts such as BPF timer callbacks. The
fd allocation can then sleep in softirq context and install the fd into
the interrupted task.

Mark the helper as sleepable. This preserves calls from the main body
of a sleepable syscall program while rejecting calls from its
non-sleepable regions.

Fixes: 3d78417b60fb ("bpf: Add bpf_btf_find_by_name_kind() helper.")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/bpf/20260903155150.D57251F000E9@smtp.kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5d93fd82e764..9f33e95d5741 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8749,6 +8749,7 @@ BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int
 const struct bpf_func_proto bpf_btf_find_by_name_kind_proto = {
 	.func		= bpf_btf_find_by_name_kind,
 	.gpl_only	= false,
+	.might_sleep	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_MEM_SIZE,
-- 
2.53.0


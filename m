Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1454BB5A8
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446696; cv=none; b=KNphFcPF12cZUS2uAhGJA3CyGuTut0VuNlv0pZe2c5qNI14pX/PAD1skFeXncvp069H9KY0pXPzxJDOimTOR4+mkYDiS7XkzVwMcS+2h6RVlfSYqxnkUVXxAs/pJ2plwfOA3mWFC1zpzOzIKiWzRjykbOw2hlW6LJ6ibn0dGaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446696; c=relaxed/simple;
	bh=kO7UKa7UBCsa6TaXmiGPF0icbOvXNFtEejRzSr5u8kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0lYz7HVVVJQs5TuHICNClqGzp1nAWo1qMtzYa7fF73TIaQxoUT979FrG7G+VH5Lf7JeR82KRMvquvYLQIqhdIyaegIvTRMV0JvRyOx948PNJz+EQB9bi7tLiB8jdz/f6BNh6viLMAsj8WtOdstl4zk420Ky4Sx/EFeOP55AwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi4aTzKU; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi4aTzKU"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-485850cf4deso135193f8f.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446693; x=1789051493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5XPCtflHbk7hsJ9BrBOdxKOFFl5KzAp9+xG2XC2ho7o=;
        b=gi4aTzKUkmDcHgImGemiM2bfti+9yFMLyCxrvWq0eKSTV38QgETgPmPvNMEZ3RkOdc
         qvbsZQbO9XoANJ1OBFm+mTVuhU5dhhTCCRGuY396BW51d4BtNObwCxg/jfV4buksujvS
         JA2BgkWQUU8vZO9XJDVHT3FoTqKMr0VrZ+OBLcMsMkZY5ZyD8XaT0MQWCEfTB3deMCIh
         jqI8jdq+8xvRk0vJOERfkJ8ZDoOeLHzhamfgcxsmoSHwji6/OSlOJzG6X2BZmUm75gRp
         6VElIBC8wJVwbHjMq9XpUfOhLX0CRwn+5ig1BtQHJ4Kds4lM2EsIeU6AiTTH7kISxDEk
         75Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446693; x=1789051493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5XPCtflHbk7hsJ9BrBOdxKOFFl5KzAp9+xG2XC2ho7o=;
        b=juJ/iuTq6eLQEr9SX48X4WXFP1pfq2shPWiy6+hhVk1PSYlA+6zjUr2BsXhSiqNYFT
         620HqzEi2AH9v/N2ReKN7wH8U3oNDp3K4gspjY6lZAgesbKXaR0qcwo1uay/V5iOZ4hw
         E8+wUspLnhQYXaPUa3+Ofw7wRB+apvT5gyqRNxd0jQFGDxY4WGYxizdhacNjYl4JDzDY
         BJdvtSiF+D0EIKAmZZ48qYS0uuOvBlBmTVjzEx9RwqSZv8i9RoWtHCRMIkiRg2AQTRAi
         M6+koJncIAhJzjpqJ2oBTc4Dkan8GP5pIo3Bg2KR42QQ4q1B2oQeobdjjIXZJexafTQk
         KN1w==
X-Gm-Message-State: AFuF++ktu6Cx+ahkZngMDfybz/Hltoze/9MfBoLggKOfddccHYRH3mTc
	ugmCThj7JanmJ+y4VYiEW8OXLhpWQI+uuHnNGormfMQes3ji45lcBmZhcaYm/B/c
X-Gm-Gg: AYBFou0p9qhNLYhtPCUbtjdUnq/ZD//aCz3FeVmbUs++LhBv9tWoBOepWkWQ/BmdSC3
	NtEAc19N8abBI3DmMJDWHTX6Uew7QuY1NTlwPGxgcEdToSVGR1gyaTSWjBq01Cbjjur9wX3xeA3
	AwnSR0+RtX6YCUIkXK84Ebmi4tKkKnM9uZPa1Kw3oQ2CeOiDrv/BBzGtP0Htwg+LV0dfDCuvNK2
	hpXA4RvvOn5BCyfXS1sZNtxLoSe8ILL4+DYlJtJXVAXmLRGst76gGCTcM2Lvt0FkdTDVcuNDc2C
	GNqQyNeTzB9H23AAO4qEbf5EH16RJAb0BMb50NVjuV4TwFh1nIciDss70kiVC0DjizYzk7mE1bS
	Z165E+oEmJzyUdX5gMOYtLiHpq8V0X5pCWXFzoKt97sHtopjRXQFGGEzQ8o/WkEVnguUTTk93hL
	EMbBaq4mI5gw3VtGmoncHHIKJY0oZbz1L0+Yu7t37FyW15uRasVY3SkmIGCqPwYJbtpK5BHOLx9
	/3AqNgjPw8+DFNKRzi8Qstw+fNAn2WjiPIytJ+ckdXNR2UO/uNAjTDAIqwbKLBr467F3SlWDTJG
	ii4oasjFoV2Duq6C4WpFaGQ2blf/G7mEU4ictZFx
X-Received: by 2002:a05:6000:2f8a:b0:482:e64d:a1f7 with SMTP id ffacd0b85a97d-48488e0371cmr21221561f8f.11.1788446692494;
        Thu, 03 Sep 2026 07:44:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eeacbbsm13609705f8f.30.2026.09.03.07.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:44:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 10/10] selftests/bpf: Check syscall helpers in timer callbacks
Date: Thu,  3 Sep 2026 16:44:28 +0200
Message-ID: <20260903144433.1716731-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144433.1716731-1-memxor@gmail.com>
References: <20260903144433.1716731-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2456; i=memxor@gmail.com; h=from:subject; bh=kO7UKa7UBCsa6TaXmiGPF0icbOvXNFtEejRzSr5u8kE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtm8yTO/vvsv7teNH+45vuQ/8bvDVcX3c470vsmLe7Qw nwP32c9HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIi32MDJ3xpVkWoj8nPP18 yvH3r799gtbJl12TTkw/Vfdt/affy9kY/lmUH9ZsDFefwqvx8IgHz/QvzwxcTB29eHdde+f+7GW 7GzcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A BPF_PROG_TYPE_SYSCALL program is sleepable, but its bpf_timer callbacks
run in a non-sleepable hrtimer softirq context.

Add verifier cases that call bpf_sys_bpf() and bpf_sys_close() from timer
callbacks. Without the syscall helper prototype annotations these programs
load, so their failure expectations expose the bug.

Also add successful controls that call each helper from the syscall program
main body, ensuring that the intended sleepable use remains accepted.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_async_cb_context.c     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
index 6bf95550a024..a7c84d3fa4c7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
+++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
@@ -62,6 +62,70 @@ int timer_sleepable_prog(void *ctx)
 	return 0;
 }
 
+static int timer_sys_bpf_cb(void *map, int *key, struct bpf_timer *timer)
+{
+	__u64 attr = 0;
+
+	bpf_sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("sleepable helper bpf_sys_bpf#{{[0-9]+}} in non-sleepable prog")
+int timer_sys_bpf_prog(void *ctx)
+{
+	struct timer_elem *val;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&timer_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_timer_init(&val->t, &timer_map, 0);
+	bpf_timer_set_callback(&val->t, timer_sys_bpf_cb);
+	return 0;
+}
+
+static int timer_sys_close_cb(void *map, int *key, struct bpf_timer *timer)
+{
+	bpf_sys_close(0);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("sleepable helper bpf_sys_close#{{[0-9]+}} in non-sleepable prog")
+int timer_sys_close_prog(void *ctx)
+{
+	struct timer_elem *val;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&timer_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_timer_init(&val->t, &timer_map, 0);
+	bpf_timer_set_callback(&val->t, timer_sys_close_cb);
+	return 0;
+}
+
+SEC("syscall")
+__success
+int syscall_sys_bpf_prog(void *ctx)
+{
+	__u64 attr = 0;
+
+	bpf_sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
+	return 0;
+}
+
+SEC("syscall")
+__success
+int syscall_sys_close_prog(void *ctx)
+{
+	bpf_sys_close(0);
+	return 0;
+}
+
 /* Workqueue tests */
 
 struct wq_elem {
-- 
2.53.0


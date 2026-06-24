Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFAF2874E3
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299936; cv=none; b=eqKN6iOdjO/AxnIEoLOMT7yA7au3vge1PsjB9ja9TtH9eLECKnDT355sBhtdSpkT5QIyxGnCsC169oKWDHYcfxQnBf2pACsij0OlW3Ez113qGNS4ibkB0zy5SwAK5KXo0gpJ0bDXD4CL+QPJvex8zWhZRXLTqk9e7SrVRIg5FAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299936; c=relaxed/simple;
	bh=YcYgvjQQvfdK9csmMpftYfTGyBLTGAHCvrDLZlvhiWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9XIUCBiSZMYnUFes/IOb0rLCpCRzwGJJ6azYeqtRJXvz/seBq4et4bjmtIUq1Bt8kbwyDfE4ENI9oMMpaunfkCTA9CyBFj7DknTrIGn3cZfKbn5uHbviEKzEX2BrAS1f/5ubN1frj4Zw9wc3GZHxrC/QzuAO2Pecvxd7ACT9rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ8UWtsD; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ8UWtsD"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37d826e9811so584277a91.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782299934; x=1782904734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoO02AGMPuVaNHiQsRbyn16oX/4f9DidBoVMmT+JO/c=;
        b=IQ8UWtsD9SJeq744CUTfohNM+utAmHinYBZUR0rkEkh48lRJNi4qHlnPGc4acdJssQ
         G417Q+/dRObSUc2wn0Y/zyfFG1mz3OSeEH+88623KTaa37IM/Uacy/wZ+3OIWXs60X2W
         2SBS5W2h6jJMRMRSkw//o5heUsTzvZxKhvL/ZBnLvp7ijGYp74dE5tDYh8MzhlJEThQN
         7yvpXa0P5MNd0bPaPo7VFx70Awqk+gn6CYMO/zlx0WDVc3gGhU98krDz+oUOpbgVS3Zk
         uP55pAXiq4OXK9o2rjhrHDz5bQH/HVTclTWcYHjRXlz19zz8tT53KNMQz87Kvrmq9bUx
         8URA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782299934; x=1782904734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OoO02AGMPuVaNHiQsRbyn16oX/4f9DidBoVMmT+JO/c=;
        b=mMmj3z2pt/QcJnm1CQ/xjPwENjxQhl88UINq1lGb2vP6cucc9Pg+myH5i2D7786Bm4
         TFdKnYASorpLtxVBgqVHF6WUOxFNHk0cK3QVLQcmb+teY2k4BCxMRdXudeaYwlKva6CY
         DVRlGjL5r3XEHK+l45pG5d+fAvNIKxPiQwSxxNF1wTboNkZ4cwAOF2xOkuocL3679TcE
         9CcZc8hMi9PBulVZQHp/JnBMHLuEr2BkDCRwsQO1QPeQ7rDI5XFRJOh03kX/m5KJrYA5
         2kct7OSxw5LdZzFlF6YDReUNq7q+O3UKG56XfzsTajOg9y46sm3dX9Wiay8Ow4nuEAFO
         admw==
X-Gm-Message-State: AOJu0Yy4lulRmo9xISxaMPUwp+ghEt1H7VbIynGqp5lqfNdTeVyTOFh6
	t+BsHqvM3x3k2hmsPDT4HXvSknlDoGa7ulTl3l8CJcono84gaYQjTdwjCTiMsPCjMS8Ekg==
X-Gm-Gg: AfdE7ckpxGRvSUnbWinR81Pi0wQncLYCF9HChDLSbbydRBP3JzBc6BnN5mDDsZVakaV
	BU/VlQ8na0qOT3Rg/u6E37rHDyw7eW1nmpGyXawXKH2ouZfIJGk3y2FHX3UFTKk6Fl4oL8wZgg3
	F1bWGNRAyS2sRHkmw5/UTmmzF4ZufyIGjA/a5qFx5o99mMkWgmPrzq4ZIFmCH6IVqNL8ngJnwrC
	BCTaCzLwkScfnyqR3zfBQFq35J8ifEB6j7xG6EqRbhJh59fPVMpdqGcA/R6kRMn4ssNpbCkj3jz
	c53VjkwZUQCbbTres9wIL45sPV/yf97RbeHdPHwk7pG7XpAOI5g+vWwY30DusleAaSoC/gQy7mO
	dXU84oZ3wusMwnPcrQbq6e9xowo/NxK11ybuMQmCWzQiT6Tm9QPRt7wdCdswBBT4a0QBiUxKIYs
	e+V5S1c8WCySH3qtM5Klq8uud5locNb74vABsKd4P/isd2QRzsn+S+jJOU7thOCZIVk8K1e2f2S
	6hccXqUc6CP+/4qrmo4wJwPQBs=
X-Received: by 2002:a17:90b:5103:b0:368:a27f:9083 with SMTP id 98e67ed59e1d1-37de41c03b5mr2673857a91.7.1782299934149;
        Wed, 24 Jun 2026 04:18:54 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([202.8.105.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3aa1b1csm2290385a91.5.2026.06.24.04.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 04:18:53 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Cover link info metadata on ENOSPC
Date: Wed, 24 Jun 2026 19:18:37 +0800
Message-ID: <20260624111837.889209-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624111837.889209-1-sun.jian.kdev@gmail.com>
References: <20260624111837.889209-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a perf event tracepoint link info check with a one-byte tp_name
buffer. The query is expected to return -ENOSPC because the nested name
buffer is too small, but it should still report the top-level link type,
perf event type, cookie, and real tp_name length.

Before the fix, bpf_link_get_info_by_fd() returned -ENOSPC but did not
copy the top-level bpf_link_info back to userspace, leaving info.type as
zero.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/fill_link_info.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index f589eefbf9fb..95132c80b3b9 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -126,6 +126,37 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
 	return err;
 }
 
+static int verify_perf_tp_link_info_enospc(int fd)
+{
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	char buf[1] = {};
+	int err;
+
+	memset(&info, 0, sizeof(info));
+	info.perf_event.tracepoint.tp_name = ptr_to_u64(buf);
+	info.perf_event.tracepoint.name_len = sizeof(buf);
+
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	if (!ASSERT_EQ(err, -ENOSPC, "get_link_info_enospc"))
+		return -1;
+
+	if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_PERF_EVENT, "link_type_enospc"))
+		return -1;
+	if (!ASSERT_EQ(info.perf_event.type, BPF_PERF_EVENT_TRACEPOINT, "perf_type_enospc"))
+		return -1;
+	if (!ASSERT_EQ(info.perf_event.tracepoint.name_len, strlen(TP_NAME) + 1,
+		       "tp_name_len_enospc"))
+		return -1;
+	if (!ASSERT_EQ(info.perf_event.tracepoint.cookie, PERF_EVENT_COOKIE,
+		       "tp_cookie_enospc"))
+		return -1;
+	if (!ASSERT_EQ(buf[0], '\0', "short_tp_name_nul"))
+		return -1;
+
+	return 0;
+}
+
 static void kprobe_fill_invalid_user_buffer(int fd)
 {
 	struct bpf_link_info info;
@@ -200,6 +231,10 @@ static void test_tp_fill_link_info(struct test_fill_link_info *skel)
 	link_fd = bpf_link__fd(link);
 	err = verify_perf_link_info(link_fd, BPF_PERF_EVENT_TRACEPOINT, 0, 0, 0);
 	ASSERT_OK(err, "verify_perf_link_info");
+
+	err = verify_perf_tp_link_info_enospc(link_fd);
+	ASSERT_OK(err, "verify_perf_tp_link_info_enospc");
+
 	bpf_link__destroy(link);
 }
 
-- 
2.43.0


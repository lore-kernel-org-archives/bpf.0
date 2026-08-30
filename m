Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138A3A7D73
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788082528; cv=none; b=L+6ScTq8MdW8XuGL1DTxNSsUBY2wXmR7equfLbZUI84jmX5+QxyHhcX98nR7B062xRi6oApkHaT2Uy1P/9hDvsbYlmaQi531BwPBO5HP/AjQclYnmtAjv0Odj43wtZgac2Xy/t1I6OLgSe/jC+zpduNQ4W4DKX7pyabe/4W4ygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788082528; c=relaxed/simple;
	bh=yWpK2IZcVcTngbiEL/C3vd+XjYDq2UlJZIEHuhgje1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3t5AXNa01pXB2Vq1O/O+ez3s2wBy0DaHu4bxaDYFJEV89zXJWeWi0MC39NBBzszV7JG7t/tc3iSuJg/EX0WG9mrdrWcuQHiTTJJhYyU52gZ4AYtcjAVr9VxdQujoYR37YH0juLctGK5a4jmWj3HVL8PsX7IT23u9mbCL6DALxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJpeAHvH; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJpeAHvH"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49add2a23e5so10570045e9.1
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 02:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788082526; x=1788687326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bSR/5xUpxIezDCUz2ZcQzEZCKhSOYIxGW4L4XBtvZFw=;
        b=oJpeAHvHrahICExgdvOC+rBSZWwxMDjyNEs+/xh8T+f72O7CCWDeXTt5r0zExlRGHi
         NX7EQfQe2Up8usTToV1XgPTEZKQ81a/zeehPvyOQHtSV+e5DNroaQbybilPT8mrdzQjj
         oDA50LLPnD1O3mYgAp9+QafP+RBqyBcHH+PmYXE5xjCEGGT1RSk6N5gxTrnKGJMw3bTF
         ++bRQhhXiHPXbGpZhE2OhHfO3sX7VrZxCkcBtx/r/zbxG0ff3nfPJcO+OGYcb1Ie7XOg
         1IDSeOeyO1g32W6h65yBJeMi8PizjoL+6ASjLemcQI+ZNtIDcDCRKChSQZ93GCMxKOcv
         HQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788082526; x=1788687326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bSR/5xUpxIezDCUz2ZcQzEZCKhSOYIxGW4L4XBtvZFw=;
        b=Vf1ZXdpM0CpJ+U58SU4eSxif8zEn0y/TuyzZFqC7VX8mlJ1Ohpel/h8CnUDXbYhUKA
         IUFeBfrm3fN00iW7u98nOWl8R6xEYKbtJ+GXeC4dCSsX9h4NWmZryc51/XeQ7fvDhRgi
         4f1PMG7aOvGzJezcs9dckspGD5rF6nVtke0j2NQr6pxPQQW/36oKLe6Or7qHxA4NsuS5
         Cfysqao0W+bAXyS13yPezx9zFm12yLs05v+GbuYUNTrXBVoudoT/tx0GYzAqYlCbD8gx
         FjfvgxsMoESadbIE3NNSvW+vvynXocWdsUEsLLbx4zed4nFqbz7EVVUQK035+qBJ7PXv
         jyXA==
X-Gm-Message-State: AFuF++nbRMY9CnUI+NTLMHQ4ZVzkPo+bm2adl8pcbqDudq8HvNcDVRje
	grlgEyHTjfa4XkCqoS0MQ+VIrGVq93UhmPFHPqIygX9W3GEKsA0SxUG5gc2KjuxDM/s=
X-Gm-Gg: AR+sD13hWS65YhdTd7l+p0eNgYhP7L1V4NNiEcye+2vfnYBCD5nIabAY5WGshjPo8/H
	rwjMo5+p22m+J0hys7wQ1QvWt63WcAH4dwsui/+9m7yt1o7YAWckLSzs1NTf8kPe2s4l5nSaXfZ
	DOcXXCdjsvga6/gmXd9rQlp1+CQt+MQQDzG3hYX77vs6Aup26NjEhZ+48zTX4EC6hb53QR3QFkT
	6EsI3WXnMAZ6TOUlBmkcHey0RbmfAWHuOJvGc1Brb33LrYznJXExHQZLRJHSjCrKikxTe9/sLh1
	50PDvQsMeI7DFTUrKTeGGiJB631ZyoaPACUBqzlvdk0eEorlqMfVmj1NaFtFNnbpheuoMi8J+G8
	TdfgTWbfczUwroyc8DPcv54dSUerVtco/Mi6Cy+ttiBrXQP3ScTaXFKQsReRaR4051Y6vJt2y5m
	VvJjACYXKicV0mBqqeydn5ltMYJxnYjc6FUuAC/v/Li/QLLNDrq+xYyYSKOgfLCqb3KA7zOQmlV
	U51vHEHgXtEg8v0kOl9bv3W+OUKHifs7S2fZby/uhP+iEBdPD0apAGeD2/7x1GpjTjzrPZ0wE/K
	OUkM2iC2Fm2xqYcbOkYDur/rIW8=
X-Received: by 2002:a05:600c:1f8d:b0:499:621a:2ec2 with SMTP id 5b1f17b1804b1-49b91c17c41mr261281575e9.3.1788082525626;
        Sun, 30 Aug 2026 02:35:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb20793sm14873781f8f.17.2026.08.30.02.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 02:35:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 5/6] bpftool: Read program streams through file descriptors
Date: Sun, 30 Aug 2026 11:35:10 +0200
Message-ID: <20260830093514.4105972-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830093514.4105972-1-memxor@gmail.com>
References: <20260830093514.4105972-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; i=memxor@gmail.com; h=from:subject; bh=yWpK2IZcVcTngbiEL/C3vd+XjYDq2UlJZIEHuhgje1A=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvyx63Bc7sjs2cW+RTYm4gc/uNsdWD6wb+hx281uFRvX q8yJyS2o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPhnMvwz3rx7SLJ4z+/cQc5 r5yYkK9RefT8jZRzchd0t3+/wNs5R4zhfzLj2RlJSYnn2J8qzkk8XBHL/1hlx2+VVu+NRb3Peti amAE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Use bpf_prog_stream_open() in its default blocking mode when following a
program stream. This lets bpftool wait for later output instead of exiting
as soon as it drains the currently buffered bytes. Flush each chunk as it
arrives so redirected output is not held in stdio buffers while the next
read blocks.

Fall back to BPF_PROG_STREAM_READ_BY_FD when the open command returns
EINVAL. The bpf() syscall uses EINVAL for unknown commands, so this keeps a
new bpftool compatible with kernels that provide program streams but
predate their file descriptor interface.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/bpf/bpftool/prog.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a9f730d407a9..6b43cb43b27e 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1125,14 +1125,27 @@ prog_tracelog_stream(int prog_fd, enum prog_tracelog_mode mode)
 	FILE *file = mode == TRACE_STDOUT ? stdout : stderr;
 	int stream_id = mode == TRACE_STDOUT ? 1 : 2;
 	char buf[512];
-	int ret;
-
-	ret = 0;
-	do {
-		ret = bpf_prog_stream_read(prog_fd, stream_id, buf, sizeof(buf), NULL);
-		if (ret > 0)
-			fwrite(buf, sizeof(buf[0]), ret, file);
-	} while (ret > 0);
+	int fd, ret;
+
+	fd = bpf_prog_stream_open(prog_fd, stream_id, NULL);
+	if (fd == -EINVAL) {
+		do {
+			ret = bpf_prog_stream_read(prog_fd, stream_id, buf, sizeof(buf), NULL);
+			if (ret > 0)
+				fwrite(buf, sizeof(buf[0]), ret, file);
+		} while (ret > 0);
+	} else {
+		if (fd < 0)
+			return -1;
+		do {
+			ret = read(fd, buf, sizeof(buf));
+			if (ret > 0) {
+				fwrite(buf, sizeof(buf[0]), ret, file);
+				fflush(file);
+			}
+		} while (ret > 0);
+		close(fd);
+	}
 
 	fflush(file);
 	return ret ? -1 : 0;
-- 
2.53.0


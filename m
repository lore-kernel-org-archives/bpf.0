Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140162E7185
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787494681; cv=none; b=gzN457lqkvuOJmHId8cKAfeeKmDo/xAEBaAP7xSkqP/BJEKIzsNVqTk2P+1074Pb/fIswWsWbrJlWhuj9RQCdGDhpss1XgBH3KbmT7+Y1crCPl/aBrCdwCMTryZ2AVpoI1JuCNpLBfQ5SC5rxZEx07sIVm2i/KJtdGh274h8ln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787494681; c=relaxed/simple;
	bh=THAx6kKy6+ANuW2Ijm0TWq0Gw/XWcFP2cIc+C2dP7TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+lVsKr0wsyIFBSrnGTXuMpmE1Kq+RA7DQhMV599mEQt962mhCy0Ao6hBAxn4O+pIA1ziNloreC67Aw4hnq8ZxyH9auyLz27XTjda4KtmJHlVjPfy12fqJ+toNnmp7bZYWsW9ldXpJUcuqxM8S3brclfbvzPtQg+jLJNHMB/vIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2d323628f8bso602485ad.0
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 07:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787494679; x=1788099479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R/Ql4lEDJqP86btbQpei2w3GW3dnEXXUERLHfA2IhaU=;
        b=LIfKtp/iv/dc25Y4/Y3g+gNsEtEQh36X6eR2dtFDOA6MeakY2trbB7dqJkJjMcWrw3
         +karxo1i9Y58/xJqzcRKWWEOCvdSWKPB8LF7E3x/5A2mbBqIX2NzZEzHuKifTjQ6axZC
         c+/mkGAlyRLMYAhbUIskA4NEyA4BoHlKwVoZPwR5ni6Dchum0REzZ4TxIQvGPirOr37/
         PGcMStpAIESxWB4SzF35y9f/zsaFRVDFr4/7zCFrJYBdePsBzvr8Xlgac6Cf1H8/2cJP
         eJP4fN9wPhu7RfbeswT7CIRkVvVRdTh8s5TEU7i5x+arEqNDWNeZxda5pGulR4YVV4q2
         CAUA==
X-Gm-Message-State: AFuF++l572kaDDZhQkbrnqQO4t2uYHjxiLZMChm1mQiQLzGe9dOJl+uf
	mTBcBGWATIax8KJzYSNB2KhKUKHDQxXi9G+y6VGEuf3W5SD++/hIhTLoQ6EI//ioRK20RWhv
X-Gm-Gg: AR+sD11li8f10ytR3UQqOi+Fxdia1hvwq0ju2z3DR7Mw/oI+mPTvdQzduwBmXtDzS6w
	jd28FnoaT/wcNuefs/8zpO5YL4qglSVQjCcXVoPOFi6Jnn6s0pRLOnijD/PI++E7T679YZGZqzR
	8yMCd7NKEXbi8vOk+FqygnRkWZ1Mr9mTE7GV30CFKdjjC07hGfzoVi6VgDq7z8Cq9G0tVf/kvGq
	/qf+15BE4+8/kimXvcgxYxQQMpHUX89w2nIZfh4CQooclGHBKu1E5RU2s6Kv//UHtZscrkY1OFf
	v/lWK4kIeY5axyRXGzp3cc+Oeo7ePDdTL7BNGnlPNop59uDJVZHtTU+1irn82PKEIul1y0y0thE
	LhC2wK2Ea3ajVkVyqdvOnobQ1aYJv+pVI5ee2ELHk9Sn7+87ucwUv+avThMLyFuwQkvLc9sBI6L
	p0dkoqZ2eKHn3UjMVNJBSHA2zxYR9CbSVJeX8kOfF+xy+lZ+BsFcz9Iz8R5mUF/zI/Sy9JR4ALs
	CwVr9DtFC4cv6fC5Q==
X-Received: by 2002:a17:903:1b2d:b0:2cf:8aa7:7810 with SMTP id d9443c01a7336-2d64d136829mr214712585ad.2.1787494679307;
        Sun, 23 Aug 2026 07:17:59 -0700 (PDT)
Received: from localhost.localdomain ([180.153.160.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676791d44sm9944575ad.24.2026.08.23.07.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 07:17:58 -0700 (PDT)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org,
	memxor@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@chromium.org,
	sdf@falco.dk,
	haoluo@google.com,
	jolsa@kernel.org,
	emil@tsalapatis.com,
	pulehui@huawei.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 3/5] bpf: return partial progress from bpf_stream_read on fault
Date: Sun, 23 Aug 2026 22:17:26 +0800
Message-ID: <7668c5838c6beafeea719df8d55319e2fe08cfef.1787492521.git.shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787492521.git.shijianlin11@foxmail.com>
References: <cover.1787492521.git.shijianlin11@foxmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_stream_read() pops and frees stream elements after a successful
copy_to_user(). If a later copy_to_user() fails, it currently restores
only the current element's consumed_len and returns -EFAULT, hiding
bytes already delivered to userspace and making the consumed data
unrecoverable on retry.

On a short copy, keep the successfully copied prefix of the current
element and return the number of bytes copied. Return -EFAULT only when
no bytes were copied for the call.

Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 kernel/bpf/stream.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index a36fc9338967..09471a605268 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -167,6 +167,7 @@ static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, int len)
 
 	while (rem_len) {
 		int pos = len - rem_len;
+		int chunk, n;
 		bool cont;
 
 		node = bpf_stream_backlog_peek(stream);
@@ -180,13 +181,14 @@ static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, int len)
 
 		cons_len = elem->consumed_len;
 		cont = bpf_stream_consume_elem(elem, &rem_len) == false;
-
-		ret = copy_to_user(buf + pos, elem->str + cons_len,
-				   elem->consumed_len - cons_len);
-		/* Restore in case of error. */
-		if (ret) {
-			ret = -EFAULT;
-			elem->consumed_len = cons_len;
+		chunk = elem->consumed_len - cons_len;
+
+		n = copy_to_user(buf + pos, elem->str + cons_len, chunk);
+		if (n) {
+			/* Keep any successfully copied bytes; -EFAULT only if none. */
+			elem->consumed_len -= n;
+			rem_len += n;
+			ret = (len == rem_len) ? -EFAULT : 0;
 			break;
 		}
 
-- 
2.43.0


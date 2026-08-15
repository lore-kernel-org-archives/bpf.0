Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F09629898F
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786782001; cv=none; b=cucbSPb9HdZRDf+baJ7Yb6dJIhtGCsemJuXQvBCJYuP3370nfVy46ak72R6PlT8T9EvoWnpyOMoBQJ4cYldSx3p8ZfPHl1yziN7WmqMT7gsYjMNMJGbUVDrwOmGNvvAM5xovb0NreG/EGAeR4LAhp97RzGX0i1rL4cMrmA5/nSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786782001; c=relaxed/simple;
	bh=Vs5g3khHkihyDw3hVq3jxsqeUqUvikKNdyu2c3lVEf8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=BdHpMDZrUO/tVjBIci6lEquQUE+2QvI6gcXaAI85pazm2v+JOOPf+HQM1uRsxxDoXODGcnjbTrMRZqKpuA36UU7xsRXhcUtZrpCJGJjK800QH/yslrlft6h3QpN00tyGnaw6A1n99Tzzq3w7+IrXHd2T+4FOyyyr1egbwlewnsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=uToQWy/E; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="uToQWy/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1786781971;
	bh=PlTsX6f5WVGTG1fM/jy6eueWmXHqyeh0cZnGgAx93J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uToQWy/Eg66hSn6Xm1GrJVPoHT5GTCKiZmGwKM1r5Gr9QcihGQPe5HTDS0oRgGEJR
	 snhYyf8GVCJ5Hid8lw2TVowcprWNwddL1T9Sx7wsQ1v77TClzbF8piaJwnjcNXsa+V
	 YFL5rvilZJOMVyjYyO3L1VaHPpeXuUL60dAWiLVA=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 4D51223E; Sat, 15 Aug 2026 16:19:21 +0800
X-QQ-mid: xmsmtpt1786781967tqvaa414q
Message-ID: <tencent_69F268659554975ACE74F3E8A26880AE3D06@qq.com>
X-QQ-XMAILINFO: M+LbSN6IdDJLwMTXSHc1lUOejiM+Czskb7bwz1/zK9izEkY96RyjEFNHuQiI4m
	 9qRTH50Pmu4hHLpRgorb/65LaBIzp94kw8QQ7pwex2zB3Kq+vJA6YHZngLb2kFLT2+rkH0+9cCsC
	 7/wsnWLcIWQXDsmNTDCY7M2Up4cDDr2bo69LsipLFKhFRgbU0m+FwjtSrj2jIzBRO5dBAcn32T2j
	 KklZbIi1WescC620YWNvEznSDr1uyPrznqoO6f7FCvbtvqRnyIv9O4sHmc5P4fmZW8OanwawPgjt
	 We+13AS2Cst5E+I85eTxqiReQFsskK70DBN8FVSgU2evENFbJRdLRNupHh96B3buwxUael/3Yi97
	 ZPedRBHTTEpb4xWZWg8/Z1r3IZ1dr7nN0QQNDiR+u9COdeWS0sf/2wszCXBcJmEsXO/5r4WfSlGp
	 yBe431ux4Vgm/AZSt//9OXe9GP0nVVhYyqLzRbRr7k573jM+9uzD+nCi7agyu8yXLX9B8RL0PCgN
	 EA+/9vCjHDz43FMB6TJy4/vv5/ay7aK9Smuve8gYJJrrtetmLIwm+5uBydZEd5+yzpCY3MN73/Sv
	 W4VNlMtLeJW8kwdoBBll01mE7sdANjDEPeXUhX+WapdaRWSW3x/hlIqZ+PgnfLJYWEBMOB892HUi
	 ymU56mmAy0238wjkCWuUw35HQONlTBQxJtZKq2+vXGCwZvCKpYEqcnLXCftpSlNXauVqiMqcNC/M
	 nFot91ZKiVE4EtcyR26cfKbi6CL0REwaOjVnSPrNgosw12pX58Tdi9xSLHsV7ghI+ESQJghnVWjF
	 ww90Fcu+CAUWE5SSxJ2TmnAwJbUU5/seu+UcFAsB4w3JZlK2EdxwDy0IUHLYD0ylEwU3dPRYRoW7
	 Ry2Rd6S8GZk1TWfmzH21xs9pGfli2BsRCP8REvbkaMm2rsTlhslzBcoeLLGZbbNysvxRZiLpAQeB
	 NuIVsIn9vOSpHTKRYPWz92xsSlJxcLBFKfL73ttzHk1i1NM9ayxEDZf7dPxDsyepeKKcSK9kceyl
	 /djIlgSpIkRpElZq2Ku6dkI9Fk3gqkvBXE4pZxzXfzf2X4vOz4WORUXxI2PwBcsuTZoHlqoA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	memxor@gmail.com,
	pulehui@huawei.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/5] bpf: return partial progress from bpf_stream_read on fault
Date: Sat, 15 Aug 2026 16:19:18 +0800
X-OQ-MSGID: <20260815081920.609936-4-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815081920.609936-1-shijianlin11@foxmail.com>
References: <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
 <20260815081920.609936-1-shijianlin11@foxmail.com>
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
index ef5a7b06ffcb..c1077160074c 100644
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


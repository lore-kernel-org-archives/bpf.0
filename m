Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4C13B293
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200066; cv=none; b=RWwVCtTxV+td0raYE+e0COT3qZUP0Oj1D6PZT1T19UAmnpp9NWa5+FXcgZcgMPUCs3+tVcgHbbRs+MBw2FwURXfU/GSyka2HySERT7cE38jOiQKpJEJhLOVDo2WNyBYGDDlfoQsSBlxq2trS3ZzbHIGu7T7ywChb3UCLFfjYlwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200066; c=relaxed/simple;
	bh=xr/G1io/jcMfHrR984t0P/qxqDapvYkztkruKBNwPW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlWktriNRnI8b/fNZTaRgzPLetljGfrOvAbBFuPJywGR3U3JRDZiRVQhBrWzy+HYoPkJ7fLooFMIdE0sPGHcrBAea5kux/f/LArHFMgljxDER3kiwK1ayRDBkDt11+zjTKOAGRfGleuRlFtBL5d/g0WpUtcw4c0YyyrIJjQtYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD+Z0EdU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD+Z0EdU"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8897e83332fso974671b3a.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200064; x=1792804864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dvPXxhxftG/h1Xzj+1bIi+SrjJdEQHzmOQDpnqTY+d4=;
        b=gD+Z0EdU6fpgg+8WlHmQfx1Arv9j82qmjQZvTcZY2R/3H0Clr3YpoppCxntA0w31EL
         PMf8RbaziZhCkYjqrmS0rsrOzYCIMf5KbUircphdMEBO+7LntesK3xB30MG6dFuN5rZg
         UONajiqAiYc5zUjJRq+wtzTUOV2M5Q/dwrSqst3/6GnHY7pIPG+3fxdTx4qb/uck9vd9
         x7hW1PJjEuXPg25lQdt1NuC8sy9JGkA5XXZl9kHuF3jJW5xgrKeuebrzJaZ5dl7Z9sAU
         IXvE+8iNrH8pYYTqnPcqyVc7Zj8dakwxxSDi1KazOgQU2vY4sXhJjRDcgRo5Q0Z/5XHF
         rTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200064; x=1792804864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dvPXxhxftG/h1Xzj+1bIi+SrjJdEQHzmOQDpnqTY+d4=;
        b=qDYHDEzUWTBJ4mfGzsMLrfwj2Y9mXhcob094A183TMzSK3bZUVejwVsE95J5c9dD/0
         UevNrKQFB5+y0RUPuyLUx8PYJesE0w+jp9IRNGAPaLyPk3bnEP7LJ4Oe8yJBSfVGS0i+
         yN9/BTGcCiN9A00ZGbzR272yMERM/1wDK1geeUYyZ+tIPKn12NEjnDBPurI5aSo1WH2+
         aORr2Ry6k0u5b/NaTphpGuYqKLods40njBVqMhRfGSAhluhuUcVCoVt922GGi6gORKkH
         ZIaFXSzls3v4NS7PTjiOQj/Lt7+H90M3sia5e7D48ma5lZh1vj7moZ7ZoMtzAuXsvm+z
         PnLQ==
X-Gm-Message-State: AFq9FYK2a661G+7J0cYvfj2jxMPKQ4X4zLZeCCs0mk66aTd7HBP02xh7
	BTGKzwPuKMRQ4wwbSTdf5y/J1foz4FRufzuzTBXbNii8I8PddYctpTgrnPysHzuU
X-Gm-Gg: AYBFou0vOGJxuL8k4GQkNNjvzyN74VzzVL84BgMbgdpHK+73X9ZAXn6FM5HkcK4KGHz
	OkiAu5C4nkmb/Qh94DcAtQz1+6x3wjexSEgcuLr7UcqVmbjWzLAoIT9IyKX1cxBUGjoU88PwsEN
	hl6cYCHSyl5GLr93blMpbburfnAIRoyVl24x9vJYUMtV4LT8WjE0HnPYsiZpSNVkizYfmWSEyY4
	ACW/enGBGBvQ9gScZVVf0ALLiV45D1bOhjFH88q65hJK1fdCNc35h2R/alxTnNaqUcWmntthWKZ
	jB8YnVLTvQxU+v8uQF48XEztCAGPpwR66vAu1QxoVhvF+lHm8B2z8qs0KZ2sUu5c488i4ULhIur
	/5vBDeY0WMGbTJQoZaXbbiO8QLILQnysppZGrz3bq1mHpqAmcwTqGZyM5VjLzdtggpeYCSnfEnq
	fVas4E6gm2lHpg3RWhKEsxEw1sF8iTG+hUjmpRPN6VBQgjPAwh3x4cgW0Fe/DTaCsgiX4qyJ52T
	W+6dRW6T8PwVBKkm6HwqKjw7A76lunIS9QCUzVnRgd5sV7k1ThTYt27EuFk4nEbA+nvt6QS0iM/
	qMTLLGs7vDwuMYCy++tx3yov71rKfgYZs3Lx0gIF+qk=
X-Received: by 2002:a05:6a00:7542:b0:886:ecc9:555e with SMTP id d2e1a72fcca58-89f208021a0mr2911530b3a.8.1792200064435;
        Fri, 16 Oct 2026 18:21:04 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89febdc2209sm1301970b3a.33.2026.10.16.18.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:21:03 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 01/38] bpf: use the frame mem type in devmap egress XDP
Date: Sat, 17 Oct 2026 01:20:21 +0000
Message-ID: <20261017012058.355787-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

A devmap egress program that removes a whole fragment of a redirected
xdp_frame with bpf_xdp_adjust_tail() or bpf_xdp_pull_data() frees it
with page_frag_free() whatever the frame's memory type is. For a
MEM_TYPE_PAGE_POOL frame from a page_pool based driver this drops the
page reference owned by the pool while the pool still accounts the
fragment ("page_pool leak" bad page, leaked pp reference).

kernel/bpf/devmap.c:dev_map_bpf_prog_run() points xdp.rxq at an
on-stack

    struct xdp_rxq_info rxq = { .dev = rx_dev };

whose mem.type is 0, i.e. MEM_TYPE_PAGE_SHARED, and
net/core/filter.c:bpf_xdp_shrink_data() releases frags according to
rxq->mem.type. cpumap, which runs programs on xdp_frames the same way,
already copies xdpf->mem_type into its private rxq for each frame.

With 9000 byte frames from virtio_net and an egress program that cuts the
fragments off:

  BUG: Bad page state in process swapper/3  pfn:10660b
  page dumped because: page_pool leak
   bad_page+0xbd/0x190
   __free_frozen_pages+0x5c7/0x900
   bpf_xdp_adjust_tail+0x3be/0x480
   bpf_prog_dad43f894a3faff7_egress+0x15c/0x1cd
   dev_map_bpf_prog_run+0x288/0x610

The pool waits for these pages for ever when its device is gone. That is
the harmless case. A page of the pool can hold more than one fragment
while its refcount is 1: the first page_frag_free() frees it under the
fragment which is still in use, and the second one runs into

  page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
  kernel BUG at include/linux/mm.h:1846!

veth is not affected. It takes references of its own on the pages and
redirects the frame as MEM_TYPE_PAGE_SHARED.

Fix by setting rxq.mem.type from each frame before running the devmap
program, as cpu_map_bpf_prog_run_xdp() does.

Fixes: ca9984c5f0ab ("bpf: devmap: provide rxq after redirect")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/devmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index dc7b859e8bbf..1b8f0d7f8455 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -350,6 +350,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 		xdp.txq = &txq;
+		rxq.mem.type = xdpf->mem_type;
 		xdp.rxq = &rxq;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
-- 
2.55.0


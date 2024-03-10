Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01F529411
	for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710085658; cv=none; b=HUPJPbxh7eEiR3ZVTzr1G+3Ppr3UGsMJo+gdmDeawP138YlloJAHNFPKxvD32kRtOBUtGg7sR4imQ0M9EBX53nDsms4PimptgRl4nQPVnA63pf+P1Nf12rpoEoE20QUKBThf9RjN6UfrDGO0C0tm/cjNspp0cEEtM0z0pyneckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710085658; c=relaxed/simple;
	bh=Pujf88MSgeBgnVk3XoQ+u8p6dPOMYRawFtSeLnjfy6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DvJix1ni3ipmNvsWXu8YPxUcx6nGU16s1lqwxWPwcHhWsSvklaiwQ9soTpkHdDciQP/qsu7lYF1gYkaZW/PplsWF2+G/kwNOQ7jtNsLv2RkOPQqQbuZUwNvXUty2y6hoOd9VT01HI4Kjpr6q9FpeK5DiG4JTz08HHhKd8nRIzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=k8CBp5Lz; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="k8CBp5Lz"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B043F48A9E
	for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1710085652;
	bh=3x1QmuNCSkhKmOkbx/k9p+MANy4otdnhu0jXgm0Ki0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=k8CBp5LzYXhGPbcR+Y0ZUahzuctNhcOFEqscHdPUKYfadZ/tjEP5uwj2GIKvWEs2O
	 Je1FtoyKahzh68HcKC6uSbn/AhjEBb6Cr/pQHJWd50aCSOHaGfqaxgqYUNMYz9kxC7
	 pr7E9gctEUAbMrOykUtFUhkuI9BbavRzbvQlUCmfkxm/Ie9mh3AQnSkFDdZDYmhRwY
	 /2aII6yAngPK9GJTwXQDoSp3NWE8DaozEDjKOl0VrVdoFuHz6D8w/q68Eso9CViOZD
	 yBAZkOcvfxf1PyZdyBaolViPN+W54FiDT1BB3gQH+9iAiOklRPTLcWGYuuBLH+utA6
	 1+wn9Xlmxp8kA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a4623436bd1so8121966b.2
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 08:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710085652; x=1710690452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3x1QmuNCSkhKmOkbx/k9p+MANy4otdnhu0jXgm0Ki0g=;
        b=rHJSloyK3XGbDESTHhu4nvdeD64d/s1hftLG1QBNSkjuiguXrM++qJHSoxRegwfsDl
         Yo0GlS1DkOPS+Z8NEZcGuoEqMT/drLFeZLViLrAhwoWC/Uy1B8gBbL/znHF18h2508iP
         Zte6nnP5rzv/yPy35jcORQEp5c1DsvhnvtMj8L5OQjszfdSviO/xVo23omRDCOLFHSBT
         iCRQ8mq3MOagh4Qjbx9Hmcr7RebNV+SlWBfmQOj0GgXlqJZJt3vFdHrxpr10/bjhbszB
         nodNTPngztK+l2JVhachqWRW6bc7DUNtBLTYNvd233kTWNnePIR4oqwprNUwHDWBq32C
         0YLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMtqzzPY56CI3RAKNDcWfpkqGTRfjnVuT92UUWrdW32hlkEDO+mDM1oVC8KeomqoNwF+clPnY/Nknu0a5ZSSvp71CU
X-Gm-Message-State: AOJu0YwosTzsfInOGKMuYJBRF+2KEunvLcKjs5MjSg4fieliX4zDriw9
	9yvnoVIYQpdO1QzvS59ewWcj80Eq13a3Q/mjjCM9XjoTX3AWTcrNgC+wyoixXYkES+OhuuUiOJr
	d/Izd6PCfU8BWJrLxU7S2S50BsqeWXtG8urgCQNWOQo5/OU24e0ifpRJoe8B793gISw==
X-Received: by 2002:a17:907:1019:b0:a45:e3ab:152f with SMTP id ox25-20020a170907101900b00a45e3ab152fmr2489394ejb.21.1710085651894;
        Sun, 10 Mar 2024 08:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENK7ttrDdst22S8NlzkTYOHuK9XdIpvxOY4BupgfkauqF6iuk+XsSwN9Rn7jDGuE0TrKQE/g==
X-Received: by 2002:a17:907:1019:b0:a45:e3ab:152f with SMTP id ox25-20020a170907101900b00a45e3ab152fmr2489368ejb.21.1710085651366;
        Sun, 10 Mar 2024 08:47:31 -0700 (PDT)
Received: from localhost.localdomain (host-87-21-72-46.retail.telecomitalia.it. [87.21.72.46])
        by smtp.gmail.com with ESMTPSA id l20-20020a170906a41400b00a46163be639sm1092417ejz.12.2024.03.10.08.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 08:47:30 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH] libbpf: ringbuf: allow to partially consume items
Date: Sun, 10 Mar 2024 16:47:26 +0100
Message-ID: <20240310154726.734289-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of always consuming all items from a ring buffer in a greedy
way, allow to stop when the callback returns a value > 0.

This allows to distinguish between an error condition and an intentional
stop condition by returning a non-negative non-zero value from the ring
buffer callback.

This can be useful, for example, to consume just a single item from the
ring buffer.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/lib/bpf/ringbuf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index aacb64278a01..dd8908eb3204 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -265,6 +265,14 @@ static int64_t ringbuf_process_ring(struct ring *r)
 					return err;
 				}
 				cnt++;
+				if (err > 0) {
+					/* update consumer pos and return the
+					 * total amount of items consumed.
+					 */
+					smp_store_release(r->consumer_pos,
+							  cons_pos);
+					goto done;
+				}
 			}
 
 			smp_store_release(r->consumer_pos, cons_pos);
-- 
2.43.0


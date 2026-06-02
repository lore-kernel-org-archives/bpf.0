Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB93F23D7
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419843; cv=none; b=u15GpNgXDMINeU5I40L8yWIFy1/yypqDXbdV/qbW1BaCOPZber2/0cnHfoJNMZocV2wHKQ1DiugVsn9sO2yupRxxMYi0Uyl2u3tOf79VguBzvHhUeTg0zZ5qFgNhBYjRu3S+Lc2Urk8iiPtT0tjTdTg2fZ9KpovA/SgEvuVtG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419843; c=relaxed/simple;
	bh=KR0hla4tV1LUJkpn+oTYAc0ONp9Ic2niIOSornSkz34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGFvFfMIbfol5zZjo6gH6wGFgZoju4tpJmUHNtuwIQDBzc+xsgZHHC+5ZcbJqRfqem3pyC34FxdL+n/vpuwkkt0wy1A9G6dHtCkIydMzt0UNNdcwtgcDYjLZAFRRlO+S547CkG1Cxuv9Occ402sCZALUgNHgkR49udnD3iG6N1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UF3ISLrI; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF3ISLrI"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so1601729b3a.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780419842; x=1781024642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NB9Zv1REhgPk0lZpVwIiTaf5BCrizmFFnfxV6DlwrVM=;
        b=UF3ISLrIZ+op0xB/rVBgEWNyw1DgIkhFQKtI5Qwd8d5u4pAFXOwBI+PP+cT1eX9vFf
         KYkWUAPLL+cxDK1FnJqq/XVAqVkvixVeezcp2Eu3zOH4up0l64f9saPaEjCUj/2ky8g9
         9ZyTqf+Me94B6L6+Y8iutQfPErxku2peOZ8ea8HrkMIHBwfQ3n8l6zzNTdSTQ9PGupab
         KLtSEgiiIjab+OJW1LmldYSWX3w6Vcd5BaU2wC0AX1ZMAkRrmHxXgL41E80F6jh61tQY
         ZG533sPMqkZj/YZHcMV7f+DkuOL6jah7CGLPXIQq1U3Pal0cTBoUtLbyrdyIYaCqUE+p
         ZEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419842; x=1781024642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB9Zv1REhgPk0lZpVwIiTaf5BCrizmFFnfxV6DlwrVM=;
        b=D4IUh06AEMF8DJNN0MQRQRVRFpiN8AORrEYKuf7iXo3bikq2x+573NjsEvZRrP6Bge
         DoxYUPtYRvgnCtDXOwENg+0HRrWaQMG0XL3F0hC7tfSwxXOWp8Ec4Wvx4/gyhmA2KwTe
         VW67rZ4ooTR/UOwcR/WjzxKlszpscWZ+toF6behQcXdviSW2hAFb2EC8Cy6PvDBWEV3z
         R97/avzgQXCvNwZBKmS7Am62zmwXtw9pP4y/83zXy+NmU0Uu7O3OSOuo0wwILXA/bbIm
         hY8khme5FXsF1cF+VPCiKajR2I9TIzzDp9AeRO9pZCCXZSbIDrrZx1/SW1c+KtWzpH3e
         5fpg==
X-Forwarded-Encrypted: i=1; AFNElJ/T5AXBaf35yh3qTfRiMCmLsvnBAHm4MM9Jfdvr7d5fSQjsB/1fKcqyp42VdM81Sr8dAkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwMa6rhV9AF8r9bIxhJ8sY/BILfMw30jxh96ggPJNxIOnSDd1O
	1ncubLGh4ZboOA1jkFy5+YRplpi8bbEqWPVD3MoUYZUGh7KoL0ZfOCnk
X-Gm-Gg: Acq92OFhEczHbYkJOoieD9f2moD5xY1JyK8ih+WOGRNrMIJCxSrJi/7q0i2njy//bqD
	fzDJJz1YCS8i5DDYgYCwqWDXPTPHatJMKRr9aNqBW/wQ5wB6QJezto+1xaVrjtHk9YbdSQNZlT2
	AHJZHTrJXhkNU/BviElpd7AvQxzyZpo4MRADRZ+TQVBfUjy9zxKKW+Mu1JXkHUbGMpOHzEBPwt8
	ZiXVIQEqfY0ksXDYK/TOJwhWVFIakHW12eUh7DT8ZUM+fTjMn5d/9enlIldpFd7X7G1RHdzRqj0
	NJHilEwSwCp62PeEFrce+XM3c0jUJJGecD3m9p27sczDCUtBJ+qx5tALWtnCMyvKSwBssKXzh9c
	WXNbZIRDZlURIllUQh+M4F+LEndXrITzJmcExEDcqSdJmtpE7stUWU8nBnTfGmr9MHMqR1dz11Z
	G0R/m4QIDxntPlrcbogqYJyhmSN29brb0=
X-Received: by 2002:a05:6a00:1810:b0:83f:250d:5a5 with SMTP id d2e1a72fcca58-84283e04a59mr95952b3a.16.1780419841294;
        Tue, 02 Jun 2026 10:04:01 -0700 (PDT)
Received: from laptop ([223.131.147.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842820e8e6asm390585b3a.0.2026.06.02.10.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:04:00 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Woojin Ji <random6.xyz@gmail.com>
Subject: [PATCH bpf] bpftool: Use libbpf error code for flow dissector query
Date: Wed,  3 Jun 2026 02:03:50 +0900
Message-ID: <20260602170350.261035-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_prog_query() returns a negative errno on failure. query_flow_dissector()
currently closes the namespace fd and then reads errno to decide whether
-EINVAL means that the running kernel does not support flow dissector queries.

That errno check controls behavior, not just diagnostics: -EINVAL is handled
as a non-fatal old-kernel case, while any other error makes bpftool net fail.
Reading errno after close() is fragile, because close() can overwrite errno
before the check. Use the libbpf-returned error code instead so the
compatibility branch is based on the BPF_PROG_QUERY result itself.

Keep the existing errno reset in the non-fatal path to preserve batch mode
behavior. The success path is unchanged.

Fixes: 7f0c57fec80f ("bpftool: show flow_dissector attachment status")
Assisted-by: ChatGPT:gpt-5.5
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
 tools/bpf/bpftool/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 974189da8a91..dba28755d284 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -603,14 +603,14 @@ static int query_flow_dissector(struct bpf_attach_info *attach_info)
 			     &attach_flags, prog_ids, &prog_cnt);
 	close(fd);
 	if (err) {
-		if (errno == EINVAL) {
+		if (err == -EINVAL) {
 			/* Older kernel's don't support querying
 			 * flow dissector programs.
 			 */
 			errno = 0;
 			return 0;
 		}
-		p_err("can't query prog: %s", strerror(errno));
+		p_err("can't query prog: %s", strerror(-err));
 		return -1;
 	}
 
-- 
2.54.0


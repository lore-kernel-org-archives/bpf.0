Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794725119;
	b=vTzyYLem9EWMDjy4c8ahUCPxHUgIGk8LVccg6/aFF4HUIRs2mOKk5gcAFmgpFlfTKBCr
	 ktspCaX3jqwy08bEQ2TqZ0nplIKweJ5QvGWANSwUkP433sdrLG9UkzMSuivkma7XtzLz4
	 Xt0DBdMbxiUqM8MydjOWlXFK/ii9gj5/CnMvC7DSFFnV0CVgB8egO9N/slVfAYFIWRMlQ
	 xspCngqCL8kIFxmfT+Wn+V/UIGXrDcX6eFkpAqsj6/Y6rz+r62H8XxNj+j47HdV4705aK
	 hCZ9Sr+DeUfRO+g+JsFKdide7uY2r7e7pxWrg5MLrzU31faf5NmrP8+ibGW5sQY68tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794725119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0pH2zO8Y+wDHFAh0xWZZCbUUbHzL+XO1Q3bpqwy6tnw=;
	b=aK5kxuQsqXsA5GBN+x1tLFtag7AIlIIult3viB37heNwGqo4Guk8IwR61roM9D6MjqML
	 LGWI/0ki/W9MSlgnt3CnWVpcWF4SN1cC4E97hcPsqTPGxN6917+6wyu3yZQDqMwZE2BwV
	 TnChAM0V5wpfHRVxf/hsCKAwXJRRftPczUiZAJutA3ID+qM7MKre7IOnNkldl+CG+JqY8
	 Db7DBi9GMe/YIZZUlyk4NvDcHSniYCw7o2HQ+C4jDCJXnu9Zihida4FQ5aLhOjwb4b1Cl
	 ZGDZOgYy5tbIFLK5qGEzQXShf12yaq1+jrXEm4BNQ1YNse/TvuKXGcrxgOSl0cRfG5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lvo1BI51;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B49606A330
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 06:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35B49606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lvo1BI51
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4910b863b84so1899010f8f.0
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 22:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794725117; x=1795329917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0pH2zO8Y+wDHFAh0xWZZCbUUbHzL+XO1Q3bpqwy6tnw=;
        b=lvo1BI51xLx+UlUjoKGAS5jKdsWX393laUfFx0CN5qIR9C5RtfGOXgN8DoFGlXdWaN
         z26o3m+NGRNrQAvTu4vuhNZ52S95wWY8Ff/SpxVpnktLYogxh5XQ3It7kJ0vNH5/Qcfa
         QHjRxuUL39fhJRJCMATmL1/ZsV+t4GooJpSH0LMItRc9mDyyNS5PyIy2IpGqJIFLc7z1
         GK5fPA68iArw+V42zpZyWwpdZQa1zGap14CN6n9mfM5Cdq+AXjAOz9zQHwc9Cm2Q5s32
         uAfWs8MkJ400y5lQ5LRSAWzSCG745514AXDAw2QHUA6rUAMzU0Jk0sOd2u6c0oOPcLOb
         LiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794725117; x=1795329917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0pH2zO8Y+wDHFAh0xWZZCbUUbHzL+XO1Q3bpqwy6tnw=;
        b=DM1bOdVox4UUUZwj3cH3sBi8M7Sbr86tB0R64iEr4ATj67CMaMgMHi37Rs0bGfP/yM
         XEttcBpPUWnkpr3t6KqXqORyY+GWJck/GjYyAREGbWlXTk7ja9JSJT9pLr4iUCssANNM
         5goQlxBGWn0rQS0j3g/QCNF+eqlw7XQdbseKcX1J6uTowBHLTCvr9YPrPCxIHZDQ/1Vr
         sqdM1663CNpf1VjjQ25c35b0FZqKVcY3aqgayBF61cq6uH0jkWbAYDemk+IYOhkCl9fh
         8+Hiq5iLsfaUdE2+2MOzFOMUMm/K9l7BN4fFXXo4hTnTmYfOWFqb2lT8d+18rQq0hioG
         w5gw==
X-Gm-Message-State: APuU4Z+Wx3SPxHlOnNqGP7lPpoliiTlXdeeAnOBYN9QeAwzWRb4DGdO3
	m5hlGj3IP1ZAlDFvOn1dXMnNv4IdOjNFooLExbsy+S4JyQylg55SukknbsrMJQ==
X-Gm-Gg: AYBFou3mCodi/T6kyXymJlDxKlwAaOzGcQBkpiXpIFqTBBAQ2caWrEzaCKpkF9q+tnj
	jRbT/sVqJGAHd9vOgirDuM4I9movIysJCX6p3pFvqXj8hX+J6maT5FX2Pi7kt1O65//mQfyV6PK
	3JNsz1lyXSHH8+9YIs2GM4OiLTZKxpGBw0R7sTJFX8Kdri/zjpP56SG8CL8hl7s8Cn99jB3Kpat
	52AihE0BfKFBtf8rHupTaZ00GCXERNnCQQeuetrW/5/yCjB90YVlNFzBKPyc5KHvw2SfY1FwUzX
	iJB5TpHDc2UobSGGyapiwbIjwnxZ6orZsHwa3XpT8awStFyQQ1l7ih4q3dRs98JRiEnLmPtYa4X
	Qr8lFz1VSk/oEP+00qw5M+4aoBtPiEtP0vVc+Hbf5EEX8cU2CNBEhAuwHd4O2oxSC9EFMnr5uoZ
	R6fU4ho0Wc2qGQLpdaI5J7M7MEtnPi7zG9DZvvIurHUMI1cPE8yq/c3Ha4hTKVE7hVuBR2w5bwj
	pNJTd+ryq+4JQx2oh9RQy9rGr98YgLC2m82zRm09V7+Q6r79jvQtfvdjSCqFbPdfWYJFNh1zwWf
	FPOq1t+RuYYfsv/gLhMDXKQtz9OYHYuvbnfM
X-Received: by 2002:a05:6000:41d7:b0:491:e477:6820 with SMTP id ffacd0b85a97d-49c70824309mr15696644f8f.20.1794725117343;
        Sat, 14 Nov 2026 22:45:17 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:474b:1700:dc0a:bc51:e26f:5cf8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c6020bb0fsm14073284f8f.34.2026.11.14.22.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 22:45:17 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org,
	emil@etsalapatis.com,
	houtao1@huawei.com,
	linux-kselftest@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH bpf 1/2] bpf: Clear invalid tail bits when populating a cpumask
Date: Sun, 15 Nov 2026 08:45:11 +0200
Message-ID: <cdb1367b32ba590c822461688e96660b1ce2d035.1794724099.git.thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794724099.git.thnkslprpt@gmail.com>
References: <cover.1794724099.git.thnkslprpt@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cpumask_populate() uses bitmap_copy(), which copies the full last
word without clearing source bits above nr_cpu_ids. Those bits do not
represent valid CPUs, but cpumask operations that scan a whole word
can still observe them.

With CONFIG_NR_CPUS=64 and four possible CPUs, populating a bitmap
filled with 0xaa makes bpf_cpumask_weight() return 32 instead of 2.

Use bitmap_copy_clear_tail() to mask off the unused bits in the last
copied word.

Fixes: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 kernel/bpf/cpumask.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 1336a4efa755..203f93077a0c 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -467,7 +467,7 @@ __bpf_kfunc int bpf_cpumask_populate(struct bpf_cpumask *cpumask, void *src, siz
 		!IS_ALIGNED(source, sizeof(long)))
 		return -EINVAL;
 
-	bitmap_copy(cpumask_bits(&cpumask->cpumask), src, nr_cpu_ids);
+	bitmap_copy_clear_tail(cpumask_bits(&cpumask->cpumask), src, nr_cpu_ids);
 
 	return 0;
 }
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530722;
	b=ZvSwde+A+8E3Ery0vqmJ/OTsWcne4+7n5hL+WWzLA9nT37o396bonTvvpZtLraNdSQP4
	 KkzQ91qb4HZkZzQcOeZ4F3V1dvlm9ZmsnRFehU8JP8AMT4FI33NdEKY8lNCxfElv0tU+6
	 U1mT9XCoEIVys3VhcJfgp8rcyTWpVedRK2AWZsRpwbpRXxOByOgVGmXMY7cFrKjyeW/u0
	 cCfuiT4oUX21pnoWhL+fUallBbgrJn0RFlT+QHS+ivXxeZpZUvlN0hACI7Y2vOf93tovL
	 YdN4jlM1Dqp9wTzEW4NCZs5HbX6ujOqJKZ7EFgUQlSPLWpgZGsRPln6bgg5exKvynJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dAalStsyfXudMpg2j2V+fdfxbWvoIc3klIPMOpbgtew=;
	b=AIAW1p5zjVLLIvdUvsKWzplbH5WGD6tEdVvWShKXpZ5AJIDU4Driimpfxqf/LXUdKA2/
	 yYtVv+tZ0uMpXLBkHeOSxZ2hLTnF+9D1/WrYtwCa+U/JI4oj3M6Jf1AEcTydznlffLD/G
	 vlZDaKz4SbQt7scqXeSdviRLHFshQCkAd32z+NdbhJ2alN7CBLhlIkzzXaV6zkeMQe9AC
	 7nyhibJbFG5d7Mu2u9r3evyRRfHrGePThWtf1MO1CT8sIfZpLwQyCM3yhjL59p5ygJRHB
	 d+Gc6iCqzOSHf5PGd3d4n38EoNDLVhdpjuHRe2wOQPHF0ODm063AaCW5LIePCbVhdMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cN6AA1Jo;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53C606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C53C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cN6AA1Jo
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8ca6a12efd9so1291516b3a.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795530722; x=1796135522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAalStsyfXudMpg2j2V+fdfxbWvoIc3klIPMOpbgtew=;
        b=cN6AA1Jo5PTed4Fuh1Z32tEBYOm+rwHdXRbPRhYueW20CqSPtk5CMVk+ar2L4h8YfR
         YDfoP1ddutTvohm8JkfBJLQP0L/rIc9rfdbeXoNlv3i9kStKCiUWl/2Sh+S6aZ7Oh0nI
         uiHQ6sCsJF7cXiyTzuRvHbYEFWH8L0zvTYAIn9VvopHd/ImDLgymUzizDWmswczd6OoC
         95DbOCDWTgzTefd+29AaCAuvjTrJjaRcqjUhesHuJlSjw/59rnscG053hvpwnIKHtUp4
         uROQuVFyxnBuPUVhEMOF6213D+8WP86Q6TxVERdTqqEF4/BA1Jq46UwVUH0b+LX+qI2s
         r32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530722; x=1796135522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dAalStsyfXudMpg2j2V+fdfxbWvoIc3klIPMOpbgtew=;
        b=FcNGs93lU37zmIZOJQyZNi84k51Qx4+FwGvcqZRiyJ31QxK7QsWydti3kXe01wf7P0
         MSua4BahJ7KAv63UrSp8vMiQLPuL7x/Lsp2iNGgVRjAvoyOwbqSPpjrlXG/slYCu+A9o
         SdTHuR6RvF6K3ETyN94LG/YaAIkMNnyKdfPDymFqkh0Xl9oS/2T4bNijxOFHQ2gbtp0w
         4KIhtX5xPG/QL/DEjZ6O6oYCCgEv/Kd9ASgyIhLJcCIiMsUfAaWdrajYN7lM9kzoQVfi
         BilQVu521we3DGSEE3IIVzYNhaMdtlzcB3cRTYnlKRd9eltRAVJhxMep9zvuwwHPqSUA
         K4xA==
X-Forwarded-Encrypted: i=1; AL+hErG8M8Wpeiu8bFkcov/BQCC6zzlzgMYU/NfejWyOipxQOPHFLMujDG6IGZ9u6zbmCEPngbY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9i+r5lDVNHnEoelQoSRhscrg0NkWpUoFRaGyt5jJZA3nY3mqPi
	x+xh4G8T8rQG266ntbIJ32ItptccRE6fFZjkxy7RMaYsgTnVDKHjLHk8
X-Gm-Gg: AZFdTZdwoP0C1z+z9uJi/L2heb458pkLW7yKwMiQbzOrC1+V8haDlBElV4CANK3dQB5
	PQLRVNG70IqeI58q3CxKpifM7asqfhrXcmSBDkXtJ4y5hme0nDqnA6KZxGm/Da2Z9+qJ/YVbCR6
	Z0mgSkMROEgpoP/vHagdAQJ5K4zx3iU0TT4QbUpWd3siWOAkVlx0RkNokiHEFiVR2ch9WG3LLQw
	Is5/+JpkcGVYLFuoa0HcENibSBgrMVmszKlYcPz+7tTYzuX6w70f1d3ps8R42BYGVEe3vZf3rTs
	baje6PenTgnh5TZtClM856XXSkiVMQ02h4m2rMveuOocv7iBDWQD8CyPPK/07iE2tFBj2Mv96DP
	McUQBAMgQU2luCstbfNHCJ8oMPybfWdsAQzwucvD31Pq2ik/pPRC2uAoOGtu/4A/SxO3N5WLAGa
	4NZzi+QgYoTnqDGPUBLc2uLy9NAb+5q2/ALp6+yLVo47KUaiK+5d1lNaf54KeRLwn4x4VtHAdML
	KFoz7CgUA8e+u5AQoMTFNh/LlA2tg3Gg4F8ThkWJYD7HIsGYDazlIQSaI3qPT37ZSn9YW0VDRbp
	yaG/za61PS19Wz5PKcFLSUHdr9A0huhDW/YWnPqa37XWRt6YrmP13459qeflEkLOkaEn8rzNodO
	9p3f0QrUkqA==
X-Received: by 2002:a05:6a20:a107:b0:3de:b0cc:b0ed with SMTP id adf61e73a8af0-4014c94a7aemr14594290637.18.1795530721628;
        Tue, 24 Nov 2026 06:32:01 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc8829sm7171737a12.8.2026.11.24.06.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:32:01 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Amery Hung <ameryhung@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	David Vernet <void@manifault.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH bpf 3/3] net/smc: bpf: Reject sleepable programs in smc_hs_ctrl
Date: Tue, 24 Nov 2026 14:31:15 +0000
Message-ID: <20261124143123.1182108-4-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
References: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
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

An smc_hs_ctrl program can be loaded with BPF_F_SLEEPABLE, but
smc_call_hsbpf() calls syn_option and synack_option under
rcu_read_lock().

bpf_smc_hs_ctrl_ops has no check_member, so nothing rejects such a
program. Add one that rejects sleepable programs.

Fixes: 15f295f55656 ("net/smc: bpf: Introduce generic hook for handshake flow")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/smc/smc_hs_bpf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/smc/smc_hs_bpf.c b/net/smc/smc_hs_bpf.c
index 063d23d85850..66cf5143109a 100644
--- a/net/smc/smc_hs_bpf.c
+++ b/net/smc/smc_hs_bpf.c
@@ -82,6 +82,16 @@ static void smc_bpf_hs_ctrl_unreg(void *kdata, struct bpf_link *link)
 	smc_hs_ctrl_unreg(kdata);
 }
 
+static int smc_bpf_hs_ctrl_check_member(const struct btf_type *t,
+					const struct btf_member *member,
+					const struct bpf_prog *prog)
+{
+	if (prog->sleepable)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int smc_bpf_hs_ctrl_init_member(const struct btf_type *t,
 				       const struct btf_member *member,
 				       void *kdata, const void *udata)
@@ -130,6 +140,7 @@ static struct bpf_struct_ops bpf_smc_hs_ctrl_ops = {
 	.unreg		= smc_bpf_hs_ctrl_unreg,
 	.cfi_stubs	= &__smc_bpf_hs_ctrl,
 	.verifier_ops	= &smc_bpf_verifier_ops,
+	.check_member	= smc_bpf_hs_ctrl_check_member,
 	.init_member	= smc_bpf_hs_ctrl_init_member,
 	.owner		= THIS_MODULE,
 };
-- 
2.56.1


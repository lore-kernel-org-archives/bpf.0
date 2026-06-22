Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142513385BE;
	Mon, 22 Jun 2026 03:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782097999; cv=none; b=OLZNb5wSdecEqDAjyrtjM4wYHDgwWNk0TJLBLZfQ9wXeRZBvfbkf5J9uvgADwIeI9qDl5KTIUPhbFpZpSGIsOLpNlG8bc6AxdSyndQRG2drEFH5aOL4YRRfPpgOjoBUlXkvCh2Rg4e66tIdy+YtfPFLBBB73iSwpBZDrCJwOlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782097999; c=relaxed/simple;
	bh=FFXerJr+VNoZX+lCjKYXG5q3iyJOvurkFx7TtADP1Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NShMlkrwhONgTW6zslnwxpR38AYzJIjP4612cDPxn+KYVUr0g1jwv9SDYG9h0CtrqSow0s1zfm5SuGn+SYPNQpyFEy3fMmqNgaam59CqtKg0T6IBeT82X5cAuCMaQjeXm+7myh3cvNcnrDP8WlaanRhVXZc6aP6PC3X9cXgVX5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Te+8BOsc; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Te+8BOsc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782097994;
	bh=a4/LDFCeSh/CtEmBczCiOIPnMouaPDoUWWVbHGIwmfM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Te+8BOscuwHIchCQNGj+46SM0PZxvGp/n2d7cAKL9+CS6A89tWtF5EroLV4dBIpC7
	 tRAT0F3RgtsQj5htoJ76tTIOSnW2eDD/gbyMs8GpAEKgoYICBfsRaYlTyaupHonz5G
	 UoowT3j0jNG/LpS4QpQeE+nwdaKbm0zviXvsGYHY=
X-QQ-mid: esmtpgz12t1782097990tb0789c82
X-QQ-Originating-IP: b+UM1+mZDq/HcRXEbLHX3eybMLdfLYwtzAr56pR9tvs=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jun 2026 11:13:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6638219374528715177
EX-QQ-RecipientCnt: 13
From: Yichong Chen <chenyichong@uniontech.com>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH v2 2/2] tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands
Date: Mon, 22 Jun 2026 11:12:55 +0800
Message-ID: <70577DC64C69EA1B+20260622031255.1160657-3-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260622031255.1160657-1-chenyichong@uniontech.com>
References: <20260622031255.1160657-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NX+V370L36ibhwvG64/ulmdXRqxdSd3qqJZyT+DevIBVdc8y+XbnGxEb
	QR0Du69yxMc6eKvU0t/SIlpu2cwIHftBz+yubwGyBEuDJcz6Mescm8TiA3oElL9LUdETzVa
	tvHegrGaRnQf9JbpwoqtUO72P6VpOmrI0VqI/ZGoUTL7DffeAfTv7AJ/xfpfz8zTFjePvhQ
	I5UhvqLmVRb5FC7OY+ceNHIurhAt4iWoMfpLgfDgV8fgrFvw8vdps2e2nq7j8BixBwCpWDi
	tAeptgrw/YtW94sTStGTMc1lhmrlsBEgS/aGREULTe6l3tSQBCUyIDuW9b7L3haoqOmLEUs
	RUcpqNuimhKp+skFWucg3F5wcIs+DIIoK24TtzCdt+iQGH7h+EmHGPEDT3iRGi/g1L1tPYt
	qYS0BnkiFL/aRUMWtxd0zMeiOqYE/7EJh8Ko/dKCU617XwDyA7dQ4/kWpdSY1Vv5Fq8mLeP
	FI0U/Rdbqas0245rNYcOAQthkyAkOa9J2DRez0/AbMt8FoAh5lHR/jA0EpKeMKCqTjXPZ7o
	wnKJcSk2wWMGgvPNwiaJXz9TY5PieJasXnugmazvV/FhYnil2h7csyFfgzwAQ60hw6LjvyZ
	gEtiIg1u8K3Euc0GkkN//pjqPkZ9R95h904VEGu1/8MDqEVi9ec0gOzn7EcD78apAiNAZMr
	rWQg7FGzdSphKlfh1obWf9Nq8K43M7tejfrTjiQQ8g1OyFq6a9mUi/VqNvMoo/Ebotd+I5U
	Le2z1q3JnfAT5WaCiT+4+Y9GuOss2ZKQ10L1RM3qzm3k3IUM9ZM6kk8brjVXwm+M84dXP5L
	VshftETUUmN4pp2rSy7S4/qaaGVXg40GSnQ5kWBg8KbdF4zCp7bl3Lcf9yqtKuElTD1Rmyc
	opQPGDS4iTnII+Fc/bBsoXIXQrGiVBKcw4PSpuo7DgaxqYAlJTXVBn0W/mPkKoGJtlSkebo
	lTRJh+ZB+1Txmy3XHWPWOWF/00UVoaZ1hOed5tJjT6iMToqdvASC9T7xFyHW9bByovASstx
	+7Xi3r5hTYom4QBH9LUWP1pK5e9PoB0ZxV8oN9Ux6xBZ3X9wsw44SyjGXfeqGbFg+m3+TOQ
	Ye8sNbfVCkHfkdrpXC+1loeKQAmxB0z+6OvVRcrPNA0
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

struct_ops frees the global btf_vmlinux object.

In batch mode, a later struct_ops command can reuse stale state.

Reset the BTF pointer and cached map info state.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 tools/bpf/bpftool/struct_ops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index aa43dead249c..4dba7c96e5f6 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -21,6 +21,15 @@ static __u32 map_info_alloc_len;
 static struct btf *btf_vmlinux;
 static __s32 map_info_type_id;
 
+static void free_btf_vmlinux(void)
+{
+	btf__free(btf_vmlinux);
+	btf_vmlinux = NULL;
+	map_info_type = NULL;
+	map_info_alloc_len = 0;
+	map_info_type_id = 0;
+}
+
 struct res {
 	unsigned int nr_maps;
 	unsigned int nr_errs;
@@ -642,7 +651,7 @@ int do_struct_ops(int argc, char **argv)
 
 	err = cmd_select(cmds, argc, argv, do_help);
 
-	btf__free(btf_vmlinux);
+	free_btf_vmlinux();
 
 	return err;
 }
-- 
2.51.0


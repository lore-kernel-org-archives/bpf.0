Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83213959D;
	Mon, 22 Jun 2026 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782095674; cv=none; b=FR69keypT5W85ansGhTU8xGI+tuePQE64EHIFd3Xh227KPfAClhI8REuBCdKOxj3T9sZSxjrpzMQpIYxcJSsNxoryhkpp4YDqiaSkDdcU+ZRc2Kw0YaPvAQpPPXgEr1xEdG4CR+DxtGmyNjjcfFSIRDSVcrpc3bnwivqhfnMOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782095674; c=relaxed/simple;
	bh=FFXerJr+VNoZX+lCjKYXG5q3iyJOvurkFx7TtADP1Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKNBjC3GdPO0kp1W0H/K/IZvixL+UsDDgIJ9WBgArFtDThKXyrvtXOCrqHpuNqr7da534RqioZsx65uohTO6ej2a0tKAsVqnhA80gjK6dT9VhCNlTCuXkPOswrEwUtMYlZ27qnLdR2iz9BggobK4Zs2jrccLBkH+0zWIMQ6c7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=G6qdXHqj; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="G6qdXHqj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782095661;
	bh=a4/LDFCeSh/CtEmBczCiOIPnMouaPDoUWWVbHGIwmfM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=G6qdXHqjoYi7dtEBRtZeXhfST/xNOadHk37SIbMCHbWV6sS3TfDVwU6kTarkiYzWA
	 OOmLAH3m1gB64ksSsucpYOA8lZdCgIP/MOBO8YXqxV3d9vmB3pzeV+kTpgehBYZ92u
	 AdRQFZySPGYDH8n10o1oTBOvizk5LoaqdbeHbFRQ=
X-QQ-mid: zesmtpgz6t1782095656tded5225e
X-QQ-Originating-IP: Q3l6BFPVbzAczNYj45l5DRVwI7lnsADO+hwCgWGBpeA=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jun 2026 10:34:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9066787468411026779
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
Subject: [PATCH 2/2] tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands
Date: Mon, 22 Jun 2026 10:33:45 +0800
Message-ID: <507ECA61416703FC+20260622023345.1135373-3-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260622023345.1135373-1-chenyichong@uniontech.com>
References: <20260622023345.1135373-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NiG+iAFIVXAyI4BX5iNDzweWPGVA166FlL+y/jJvTxagxP55Fq9xeDBA
	JoBteLTubWx+bKCQJgWEjEfo84jleIc1XcIrcIiFPi6uVo+h1/6zedmimcj1whUh04Qlhz5
	MuGdHAs48cxoWYRO1vrSpSR8YCsuIZeDyaRX5oyiIJQzEIsLxC17j+mBnN2700iZIIzHSIV
	KOMx66H+1KIfeeo1/PXp+qhXcsti5U+scJyYRx15rf1TVi/VVGH5+LkPFn4ZGpmNE0LuNHR
	Y7cQ6/fxk2Ewj93vjeimcm7EGFnK5jhovnOOZD0K7IgIC4zyRyo76IbWr1Ny5pnUGELVGHi
	/FcMLL86Q6sUz+0vNrsMzX5mFDY/ZMyEex692cfvZoO+/yxln0W1mZMIaHK/OYlEQ8Lv4Ke
	DfswgUFiOYWlQYwNEp3zsSnH08IXmhheVLvuOupo34RnRhc2TSlLgXIFzzbJz6DYbeURg/J
	B0XtigrMXtn67E4cs1swlrugNgdxiOBQtYOqKbtBnMjYXHNehhGm7mhiVCE3QjO960birTj
	IVSsYw/VKgnPhoHMkatGAHGyoRDy7bxu+h2ozWR4XwJ5SQbzypqc6hGc58Sw2IJzY4eud8U
	YduMSkkc5ieb1rFXo+smCNHbzuzD0Q/osSV1v0hV44tS2HO/y16rZLwjVXOHZ4hMrKcFq05
	PXJ9+TRTDhB6ZJVIpXG2d1lzgYzsY/LjW+BS7+7wGDcyk5toCW0NP1GuVffSWSM3Gg8PIES
	sTya1JV0gjVsyAUYa4DEjaifKdrRvjtxZxR1+2azVh/5CY4EVzZDpdWf8/NEcZCT8S9LncV
	kSy78q/YBzeqtAbOkFKO8JyV/ISb1790DCJcL8MYBoJIXCv87WDtGFjP//mxDHSrU8jyIyd
	/YTJz9kyG3UdYiCOwcErX3uH5YuoMku/dE3RK/H/vrnClocb4IINGNTNkybjdskTe2MvxbV
	GSk9rTmVSyirVJIeXZiHZ9GcAIJjqND/23Ro/hFe4ogSQI8XO5Co/6NqdphAwhh78qe2ajA
	XmCV5M4hvEo7bvuocIcel1yevc7nLCQEpprjP0+bgUFfIk00/w
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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


Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A3369208;
	Sat, 21 Mar 2026 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090674; cv=none; b=Yg5qUspXwLArdjDJozGhZ3OgozIZsVKMZlXt7wFp20iqlTfINiQLOeEzELjJltrTIroOkxGsls6pYycpkaxSN0jZ9P8FRIKsNXrq9x+GnsOK4Em+XlrsBI3VABE8CbdUxujbw9qFIexKAKH6VPSRQ/ksckxXzhiufmc7JdU17o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090674; c=relaxed/simple;
	bh=3NDk1PLqhwk39BuL6ALUWntVVCLLOE8nYtp7Jy9bb2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lwrJvF6L/AzUvJPCK/czZRELVlNjxm4Iq28Dz6HwWIZd7PpjpImQmQ9skcP7PEvv8EWvhEHTcblewy3gjE3BEt/2h7G29LUQgv86bgHE4pOTwDShPVLqQxdZ8zDUGrJK9lyiv++WsF6U3momBiEXO2wKzxaQY4g9yMyDwA8SS1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=TIoqKKIE; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="TIoqKKIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090625;
	bh=uZsA2ooiEXjnhXihbfyy+pV5K8rRHenbQiXKpfAYxlY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TIoqKKIEcJwNRSJJQJ2G9BuxsgpO7AP5/a9oqrfoIsIMl5pbSNYdouTdm1tj2kDlv
	 2HvwX0WcLzL9v48nXtQVBOc5AwjAIc2noDDXU4JRIn+r685YkOHwoeIeBxADSQSzlY
	 tjhHpZkdKbOTAgc7H5v9U2p1WDIRdMfrvI/agtDM=
X-QQ-mid: zesmtpsz4t1774090622t318a7d03
X-QQ-Originating-IP: pDOiLpDhXUmVNxo9j6ab9iD6fUzRTbtktDJhCrDirjg=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:56:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12087612631715720790
EX-QQ-RecipientCnt: 19
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] bpf: update outdated comment for refactored btf_check_kfunc_arg_match()
Date: Sat, 21 Mar 2026 18:56:58 +0800
Message-Id: <20260321105658.6006-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: OKK2DAMrOULSB/6T3BitOyVS9yZGEQ5wWka971gjdRh1XU/eyvsOuv0r
	KrceTRhU+JZ37sU76Tep3j1HzNM9rFh3AljDe4s5ZSUDsSKgaOOpE6V3ktNDjAm82gPt1Hw
	ixg91j6OjwjyXoUum5uwFTCZGCEu+x0Wve7hi70s6yqAbkdDswfMbZ+QzJzWBgcm1B8u6xh
	ysM/y4qMFGtzDf8d4e5F3kU2ApzIlpR5nbw+4XlsyNoCEGCDaEVuIxq6oUuQGSMn/Vy0335
	PLQsE7uJ26peFr19fI8BQom0GUmrd8gtkwfCopnD+n2LspwoEgOZYb6T/cMhe2+BX1oSEMt
	Zl/oyxwDppeGdweMN61ym0woLd5wkTEJZZTwv782LWxi7I9FMPGSA4VS3heJOqwj1znkZTu
	8wJTDiNIWQqqHO4ghHJDVcqrFijg40fmyptCuuwXvm0H7YP7ahsLZ1td1qRdAlcZrfDj/G5
	5izAPTcnMrdVo8jkGq7hTJpE0cuYknh6UASHb1oJQJQ8aFMc7vnF0BIz7/8dLad4cdOwl3w
	pY2XYNF6ie6A3VOzfYdPD16MepjwC9vZa+KzoUVSjCyituLRsRHZcn1gAcHwYCLG3lpIqWk
	0uG++zX+DXeUzu/c5718uFOhfrI5VxZSrf0MEtBFp0sfbJC2ibvBXKoVPjpbpYUjHw/wjAf
	nAOq3M4gxJ4Xkhll5PZCPZltdD3OXWksP2/CT1E9giwr6c2m6FdPBeyk1yrOMX4NlLnP041
	YKeBAmK+QBMLSRkG8eo66Gn9bN7gYJFoVEsPuvoXNRU4/kA1r2DBcMSihNkBLVCjt2ceizn
	xYbkZfET83YjDdqbAeIBbVmb2freZDD7MvtCPiLi9yQDUq0YGGq4Gr4IrVh8S2Nl0VqcBvK
	r07cJAm7pz/S+7hE7VGQpvGiTwJXkioMnde3HD4tZbYiZkLX/wCQ5uDTrNKL113TvtxCPiw
	dCLs+8maBFONIPZJHLl6iobyrZ5jH1PS9aGdkgkjmkLlKqoF5mkTutVyqdCO0noc7hn9Heh
	BO5EUKeJdfZ6inwAi49rAeOPTJRD9yndpHbfXyNGIdCx6eyUWY6U6AwawPE0TTHeQW5eNem
	oKRdXGK+cYa
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

The function btf_check_kfunc_arg_match() was refactored into
check_kfunc_args() by commit 00b85860feb8 ("bpf: Rewrite kfunc
argument handling").  Update the comment accordingly.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb12ba020649..c0ecf02a1b78 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14410,7 +14410,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		if (btf_type_is_ptr(t))
 			mark_btf_func_reg_size(env, regno, sizeof(void *));
 		else
-			/* scalar. ensured by btf_check_kfunc_arg_match() */
+			/* scalar. ensured by check_kfunc_args() */
 			mark_btf_func_reg_size(env, regno, t->size);
 	}
 
-- 
2.25.1


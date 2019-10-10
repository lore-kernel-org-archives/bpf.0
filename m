Return-Path: <SRS0=kVgz=YD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10866ECE58D
	for <bpf@archiver.kernel.org>; Thu, 10 Oct 2019 04:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F58218DE
	for <bpf@archiver.kernel.org>; Thu, 10 Oct 2019 04:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570680910;
	bh=vPWob/SSxZMcmk2NlU3D5+LZ4h4rwF5/2STTNbwccs0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0z07mTCAgyN2lLYV4I81PcFUKQUJtr6Fi3TcJNc3geHz2yA49kD+Tfo3TYX3Nx5zW
	 fZIuaijbtZAOVC5bTw/5eUTYf44XWM0sB+Qk0PurcNP1WXm3AlsdrWVEyfWqYnHSrr
	 v/XwYPpoxhjuAYYIsa52hU2nxvFLf/SrO9kVMsOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfJJEPK convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 10 Oct 2019 00:15:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37264 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726495AbfJJEPK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Oct 2019 00:15:10 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9A4DW2H005450
        for <bpf@vger.kernel.org>; Wed, 9 Oct 2019 21:15:09 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2vgr0gtanp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 21:15:09 -0700
Received: from 2401:db00:2050:5076:face:0:9:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Oct 2019 21:15:07 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 46171760CF9; Wed,  9 Oct 2019 21:15:07 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <x86@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 02/12] bpf: add typecast to bpf helpers to help BTF generation
Date:   Wed, 9 Oct 2019 21:14:53 -0700
Message-ID: <20191010041503.2526303-3-ast@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010041503.2526303-1-ast@kernel.org>
References: <20191010041503.2526303-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_02:2019-10-08,2019-10-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=1 adultscore=0 lowpriorityscore=0
 mlxlogscore=891 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910100037
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When pahole converts dwarf to btf it emits only used types.
Wrap existing bpf helper functions into typedef and use it in
typecast to make gcc emits this type into dwarf.
Then pahole will convert it to btf.
The "btf_#name_of_helper" types will be used to figure out
types of arguments of bpf helpers.
The generated code before and after is the same.
Only dwarf and btf sections are different.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 include/linux/filter.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 2ce57645f3cd..d3d51d7aff2c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -464,10 +464,11 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 #define BPF_CALL_x(x, name, ...)					       \
 	static __always_inline						       \
 	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
+	typedef u64 (*btf_##name)(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__)); \
 	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));	       \
 	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))	       \
 	{								       \
-		return ____##name(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
+		return ((btf_##name)____##name)(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
 	}								       \
 	static __always_inline						       \
 	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__))
-- 
2.23.0


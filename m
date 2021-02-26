Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E4DC433E9
	for <bpf@archiver.kernel.org>; Fri, 26 Feb 2021 20:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7272E64F24
	for <bpf@archiver.kernel.org>; Fri, 26 Feb 2021 20:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhBZUuQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:50:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1918 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbhBZUuP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 15:50:15 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QKkRqH032068
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:49:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3WLpjNkYBbX5Z0SIzIESrvA3KpE6uH4D14GksN/VsUI=;
 b=IfHAmwvUe/zFu/4hCAomPeanPRpgbaePhgvALlJRq8MteXuAhVoNzAVcTSrk1YjZom7e
 6yXEm8WmXIm5IBH9ZKL+XvpiuYz9QgjkeRJZ1Envhwfke6a/fhhoaCNaMgrJ7e9ac+TI
 qtDDRLjMmVrpHGa+s72MNFsCbbV2jvC8SDg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36xd17s14q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:49:35 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 12:49:34 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 060B03705324; Fri, 26 Feb 2021 12:49:32 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v5 10/12] bpftool: print subprog address properly
Date:   Fri, 26 Feb 2021 12:49:31 -0800
Message-ID: <20210226204931.3885458-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210226204920.3884074-1-yhs@fb.com>
References: <20210226204920.3884074-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_09:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=646 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260155
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With later hashmap example, using bpftool xlated output may
look like:
  int dump_task(struct bpf_iter__task * ctx):
  ; struct task_struct *task =3D ctx->task;
     0: (79) r2 =3D *(u64 *)(r1 +8)
  ; if (task =3D=3D (void *)0 || called > 0)
  ...
    19: (18) r2 =3D subprog[+17]
    30: (18) r2 =3D subprog[+25]
  ...
  36: (95) exit
  __u64 check_hash_elem(struct bpf_map * map, __u32 * key, __u64 * val,
                        struct callback_ctx * data):
  ; struct bpf_iter__task *ctx =3D data->ctx;
    37: (79) r5 =3D *(u64 *)(r4 +0)
  ...
    55: (95) exit
  __u64 check_percpu_elem(struct bpf_map * map, __u32 * key,
                          __u64 * val, void * unused):
  ; check_percpu_elem(struct bpf_map *map, __u32 *key, __u64 *val, void *=
unused)
    56: (bf) r6 =3D r3
  ...
    83: (18) r2 =3D subprog[-47]

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/xlated_dumper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated=
_dumper.c
index 8608cd68cdd0..6fc3e6f7f40c 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -196,6 +196,9 @@ static const char *print_imm(void *private_data,
 	else if (insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE)
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
 			 "map[id:%u][0]+%u", insn->imm, (insn + 1)->imm);
+	else if (insn->src_reg =3D=3D BPF_PSEUDO_FUNC)
+		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
+			 "subprog[%+d]", insn->imm);
 	else
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
 			 "0x%llx", (unsigned long long)full_imm);
--=20
2.24.1


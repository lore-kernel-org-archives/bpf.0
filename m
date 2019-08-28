Return-Path: <SRS0=TyRX=WY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B76C3A5A1
	for <bpf@archiver.kernel.org>; Wed, 28 Aug 2019 21:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2EC22CF8
	for <bpf@archiver.kernel.org>; Wed, 28 Aug 2019 21:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Pc8RQXM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfH1VEK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:04:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31714 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726864AbfH1VEK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Aug 2019 17:04:10 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x7SL2O2R023022
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 14:04:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=YrAxoIc+gtSqaMELjDilDkdqQog0vQqu8ICAlVzdfbU=;
 b=Pc8RQXM9Hs8FIV8o24Pd0xzu6BC0t4PKfgAs5ufwjgtK4J795AsfX1Jr5JhnjYYSJ2bp
 njemN0zan43R6mZCFcaahJkmWDyEc1KOrPJB+xDTmddk26j/Xt2qr0tSo7bBP7xxc8W8
 NPWaodVhpC80P9Ks9t+NSyVVBzQYXGldn4g= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2unuwq9r05-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 14:04:08 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 28 Aug 2019 14:04:06 -0700
Received: by devvm2868.prn3.facebook.com (Postfix, from userid 125878)
        id A1A92A25D5E3; Wed, 28 Aug 2019 14:04:04 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Julia Kartseva <hex@fb.com>
Smtp-Origin-Hostname: devvm2868.prn3.facebook.com
To:     <rdna@fb.com>, <bpf@vger.kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     Julia Kartseva <hex@fb.com>
Smtp-Origin-Cluster: prn3c11
Subject: [PATCH bpf-next 03/10] tools/bpf: handle __MAX_BPF_(PROG|MAP)_TYPE in switch statements
Date:   Wed, 28 Aug 2019 14:03:06 -0700
Message-ID: <1895f7dfe2a8067f6397ff565edf20130a28aa91.1567024943.git.hex@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1567024943.git.hex@fb.com>
References: <cover.1567024943.git.hex@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-28_11:2019-08-28,2019-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908280205
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add cases to switch statements in probe_load, bpf_prog_type__needs_kver
bpf_probe_map_type to fix enumeration value not handled in switch
compilation error.
prog_type_name array in bpftool/main.h doesn't have __MAX_BPF_PROG_TYPE
entity, same for map, so probe won't be called.

Signed-off-by: Julia Kartseva <hex@fb.com>
---
 tools/lib/bpf/libbpf.c        | 1 +
 tools/lib/bpf/libbpf_probes.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2233f919dd88..72e6e5eb397f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3580,6 +3580,7 @@ static bool bpf_prog_type__needs_kver(enum bpf_prog_type type)
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case __MAX_BPF_PROG_TYPE:
 		return false;
 	case BPF_PROG_TYPE_KPROBE:
 	default:
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 4b0b0364f5fc..8f2ba6a457ac 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -102,6 +102,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case __MAX_BPF_PROG_TYPE:
 	default:
 		break;
 	}
@@ -250,6 +251,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 	case BPF_MAP_TYPE_XSKMAP:
 	case BPF_MAP_TYPE_SOCKHASH:
 	case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
+	case __MAX_BPF_MAP_TYPE:
 	default:
 		break;
 	}
-- 
2.17.1


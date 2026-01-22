Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A310E4A138B
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097722; cv=none; b=q18ZTDhBqBU8HR56o9biVch8oDCLYRV2OiTmS5EvSLobrmv2SC5jG8LZsRRCJnBMncsuuVKwS6oR926YDZDTVdH2yirDP228nEExlbgWf+eP5WGrs0hxrlB84YpTS6eHUH62wsOC4FEkDh937NUXx1PiT6O2H/ZMx5ymyeubDwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097722; c=relaxed/simple;
	bh=7IkLS3Bau4xgRQvvcKfOqREW/TuGgjmvT4XEZ8VMZdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgZub7OQ5/vWV8gNULx+lrXwnxSPdrcgbqTligPhDu+0rEIr7lda3AkfbbjKhyAiYBg9FPg3j6EVXYSykcBx8GGCUNhQfT/zeL+IDeAWzl6IbHnBOyx27Okftt4lUeX7YyqYOZ2SWFpp2WezFTDP3ueGdPnFGk/Mm4Lat+r0nV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=uw6K1TV0; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="uw6K1TV0"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MFC5lH2070343
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:01:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=sn/kXpRPBXgSOURfqKLMGENJJTb2th2ESwXUmXp11qg=; b=uw6K1TV01Mvm
	s0vKnKFtbiwY3dIRPmB57GZwvkesR9yC1B80bPOD1Xka2HAD/NZn0MVTHKH9gdci
	3Tftwhp3TxC7quauHq7NEmlSsadnTHeKQlkhjTvC2l//vOmBnd6fOP/8qbb5PYlh
	tm7auOE/ATGZ3o0KhkgIaJHIsnmdkg3bbn8idM+KncItiqMDEY2w4v0E9t6Y1+q7
	fXnmcm2Mo7R2kEV/vf+qY4K6XPi/EjFjixPBolaNheaa6w1OxYews4VCqZLMZ3m/
	0H7/S/RmOsUkxqObrs4+brhTrOrg7z66zOR2GQuaqTEQzzS2V9EMjPX2o0lVBI06
	WtH1I8MG1Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bubagvbr5-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:01:53 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:44 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id 70E3A10A69E90; Thu, 22 Jan 2026 08:01:42 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 02/13] bpf: Allow BPF stream kfuncs while holding a lock
Date: Thu, 22 Jan 2026 08:01:20 -0800
Message-ID: <20260122160131.2238331-3-etsal@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122160131.2238331-1-etsal@meta.com>
References: <20260122160131.2238331-1-etsal@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rCEVCp1Q874DWpAzfjz7rK9uCakpeMps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfX3FEbmVSimxVc
 rZPv/M881OIlhvfUD3BrlH70hcVxgfNh5AY7MLSEdlCyQxruHcDjad5NvplMJeeEeaiVA8R3wSi
 YZe0qJT3Rr1Zw5hULNU44VncdFP50zeZ0fztty7CeGPdYxsFm/JqIR/f/+PmoNIU+BhRTIPZuJk
 S1tT+CNGkW1fIZ714a2AabGbTDMnhEofy3APTTFVTgbBMPLFCnIXSgupzUVxNhSXbKRCSdrie6P
 7ImVSteHRaoc3bWZH2eCGJh6zmapXydJbQm0Xsa013+LyrFtFJAL1r7lzptbOZQXkojDhb8ngiP
 P7xCmb+odSCPBMU36ZGsvRlwfRQqS/+2M6YULqjEveDESIBLn7AHIbRwi7qIgvejJRciK6Bw8oh
 PSF6F5SOLYN2LVPswLYmBQ8N5prwfx1h+OdnP0ndMKfpBgJ7eQtIcjE3mapeLSy2hGllL/kYjkG
 xJ7xxddfi8OoypOtMrg==
X-Authority-Analysis: v=2.4 cv=UJnQ3Sfy c=1 sm=1 tr=0 ts=697249f1 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8
 a=YGBY62vhfSIA2HD_NVEA:9 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-ORIG-GUID: rCEVCp1Q874DWpAzfjz7rK9uCakpeMps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

The BPF stream kfuncs bpf_stream_vprintk and bpf_stream_print_stack
do not sleep and so are safe to call while holding a lock. Amend
the verifier to allow that.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 919556614505..fbc88176cc8c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12455,6 +12455,8 @@ enum special_kfunc_type {
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_arena_reserve_pages,
+	KF_bpf_stream_vprintk,
+	KF_bpf_stream_print_stack,
 };
=20
 BTF_ID_LIST(special_kfunc_list)
@@ -12532,6 +12534,8 @@ BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
+BTF_ID(func, bpf_stream_vprintk)
+BTF_ID(func, bpf_stream_print_stack)
=20
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12974,10 +12978,17 @@ static bool is_bpf_arena_kfunc(u32 btf_id)
 	       btf_id =3D=3D special_kfunc_list[KF_bpf_arena_reserve_pages];
 }
=20
+static bool is_bpf_stream_kfunc(u32 btf_id)
+{
+	return btf_id =3D=3D special_kfunc_list[KF_bpf_stream_vprintk] ||
+	       btf_id =3D=3D special_kfunc_list[KF_bpf_stream_print_stack];
+}
+
 static bool kfunc_spin_allowed(u32 btf_id)
 {
 	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_=
id) ||
-	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_id)=
;
+	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_id)=
 ||
+	       is_bpf_stream_kfunc(btf_id);
 }
=20
 static bool is_sync_callback_calling_kfunc(u32 btf_id)
--=20
2.47.3


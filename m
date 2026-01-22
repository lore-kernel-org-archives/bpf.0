Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD64C0406
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097740; cv=none; b=n/Evh0sIU+U04bA1UTxr74z+5lBF7Q3tvd7lhFWq7bgG2kI344isaCD6+so5Zpnrj2I+LfG2pZBaJcRyzjQi7HDqoRO9I6V6QgBjMwr8QvF7lc4LKO59WT6a4ix0VPX6UdcRcY4HQzVH6bHbjb/30807bUkRzvuyUjHjOmnFH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097740; c=relaxed/simple;
	bh=5EUOV6ojKhJvRZDbbQEqe9fMiBJXdJ59/rUPEhOYFPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toHmGyXpI7fRcszy65IerB2izlnjPE5ph5jMy19UfbwpMcE+Ldex3kRpwC7CA/m7um+T+7eAsbWFRIQUk3+iUg+J+MTgeUlYXECUpZdXcG6QtZ+7ida5WwEwUWxP1f/U7BjiulUwD/h30D2TEYZIzLV1Ty3mbyykFYMI7bJK7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=R5Uq7Z5p; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="R5Uq7Z5p"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60MEbFM42875515
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=5EUOV6ojKhJvRZDbbQEqe9fMiBJXdJ59/rUPEhOYFPk=; b=R5Uq7Z5pd7PD
	Hbu/eoCGWeRlgZAR5qq4kYsq5JhEw109KLgK+JWrk/4fw53azJVjo8DQHt1DBtfo
	kGSeHBfIFhhH+CGimY7kjam9I8vByRdIa6AbweCnFBB5Nj7qdZcwZk7cwH1RjL8U
	Qlm0z/BLg8dhFIxxNwPVCEHNlGc7yrDGPncvY7oyaSLm0WC/yTjUHmsi+Y/D/O++
	+v967qM2QTIPXLjiWQ3rcqO18SrYT8azgY/C0osVmxjfP1r2RgVp5qrWHsB29WCf
	nmyWLf+Fnu0NPJuVVw0UOWVI0zzhOUmUkjalVTjdJ7f1o5XUjsOcAEKrVGAM10Ni
	4YU7Pq4e3w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4buntngphx-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:02:14 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:56 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id 0B90010A69E9B; Thu, 22 Jan 2026 08:01:44 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 04/13] selftests: bpf: Make WRITE_ONCE macro in bpf_atomic.h conditional
Date: Thu, 22 Jan 2026 08:01:22 -0800
Message-ID: <20260122160131.2238331-5-etsal@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfX3gVMc9xeG9Ug
 RvO5DR2OzrPNaDUVMUmZluNjhtFds4v4gItakiMmsOmn2Bs824yD9+ILzQItbQuQqKNc//CREk0
 jqm/5xm1gd6InFzfUjTFOhBU3u3Z4LOh816N2FBctUw044bDbPbUGEWzl8TBG5LDq+MA34k+5Jz
 AxYsqo4HiBwkLanLDjb2vO6gZi0U3+zi5U+PPiMUrwA+pcA3/MBa0wRdNt5JviGvx8X52uzNu0/
 Y9CF+A/FRP04fTT/lzto7GsmrxSCbAJDjJY8CxH+Nd7SendAlnV4N1FuRCEfxGPtp2vre6bHp4q
 hwhrcTc0IWn/0SML78EARXshuXSTN+CgMOtdBBgPcpDsDwg0KTVRMcNnDz1X8cjm0k8cyVGg12F
 b48ieg19xyvMUTMmxpUAvpisZoyLGzKTiKILv9rxCVyDwHH8t9o05A+el2jsmp2UICfqiREcioV
 wgNmRcDEDo0XUBfj8Zg==
X-Proofpoint-GUID: 41TmNmXy0PKZt2c9JCNfwksZo5DKHu8w
X-Proofpoint-ORIG-GUID: 41TmNmXy0PKZt2c9JCNfwksZo5DKHu8w
X-Authority-Analysis: v=2.4 cv=Ls+fC3dc c=1 sm=1 tr=0 ts=69724a06 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8
 a=HdM9rK-uikPyUDXMxQcA:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

The WRITE_ONCE macro is identically defined both in bpf_atomic.h
and in bpf_arena_common.h. The bpf_arena_common.h definition is
guarded with an ifndef to allow for inclusion after bpf_atomic.h,
but the opposite does not hold. Add an extra guard to avoid requiring
a specific order for the headers.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/bpf_atomic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/sel=
ftests/bpf/bpf_atomic.h
index c550e5711967..d89a22d63c1c 100644
--- a/tools/testing/selftests/bpf/bpf_atomic.h
+++ b/tools/testing/selftests/bpf/bpf_atomic.h
@@ -42,7 +42,9 @@ extern bool CONFIG_X86_64 __kconfig __weak;
=20
 #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
=20
+#ifndef WRITE_ONCE
 #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) =3D (val))
+#endif
=20
 #define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
=20
--=20
2.47.3


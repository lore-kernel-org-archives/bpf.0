Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA96383AD
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103182; cv=none; b=e0X1HH+xyQEqnsUtHmR280MjIHC3yRCCL2pu9FLNT7cY8byPcC7LQ5Q5rzMlV6zhfoh0Znv8GuaHJrYtiOMr6pcCwgwELb/ArUOBO8jJap2hR9vBjcp7OVMUTbaAXhjV4XRIgLytuxp5w1QTPK6g2xmSKhh2gImrhhuQxye/PtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103182; c=relaxed/simple;
	bh=kbjbSavJiGuyahgBI8ERdnGFiTUoeTfRx3WJDFFIJkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XKCtsptrUG582tnT8bV89FrC4uMkvKXJxQ9LNVNGR0CAUSfvkXz4mjM+p9BVHkJPhmiVyL6oKb3M8ddK6tn+xENMypBBX6+/Hg8pC66HeE56g4bGAbYGmc1X5YCEZN9cZ9YQ1KpC7qP/GlTo0p0hyHzvw3BohxtOqMAfPp3CKxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wz1Txvas; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wz1Txvas"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7YOF9008447;
	Fri, 22 Mar 2024 10:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=I3g/9YSsG6tlH9epaUQxVVk0aT2CWbN/PJ4JAB3TGvw=;
 b=Wz1TxvasVPrFiY19qiCOlSzIek/jVi53w8gldCeVDEQIMSheT2WO8WbYQQ5Lgi7Q33Nm
 Y8ADo/mZF+l6G3x/6NGEqKdYEol9AN6Obrft2pgFF6+YeCstFNp3AjUMXcJGL+pNzA/9
 CF82JQCrLjxh61JLLJUDzFn+Zv/HWAVnqTTfA60cRmEEN4Dm8rrkiqKmmqVekl81O99A
 0G87V42HC68CLD58pR97tGRMkJpGClnOP/Of0BuvfSxF6mLNvSYkrOJEd2rEzvQ5JvYJ
 NdwkUacxIo0BLbfu8fy++3Y+g6QKd0657vybGJym2eXNby/5SnbOXvYEzyvfeL6UiEBL OA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvm8s88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M9KQpr014859;
	Fri, 22 Mar 2024 10:25:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2jaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:56 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kj030399;
	Fri, 22 Mar 2024 10:25:56 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-12;
	Fri, 22 Mar 2024 10:25:56 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 10/13] module, bpf: store BTF base reference pointer in struct module
Date: Fri, 22 Mar 2024 10:24:52 +0000
Message-Id: <20240322102455.98558-12-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240322102455.98558-1-alan.maguire@oracle.com>
References: <20240322102455.98558-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220074
X-Proofpoint-GUID: ZpfM4SB-wEOMKotFC3QR9g0hZ2ka2FAX
X-Proofpoint-ORIG-GUID: ZpfM4SB-wEOMKotFC3QR9g0hZ2ka2FAX

...as this will allow split BTF modules with a base reference BTF
representation (rather than the full vmlinux BTF at time of
BTF encoding) to resolve their references to kernel types in a
way that is more resilient to small changes in kernel types.

This will allow modules that are not built every time the kernel
is to provide more resilient BTF, rather than have it invalidated
every time BTF ids for core kernel types change.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/linux/module.h | 2 ++
 kernel/module/main.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 1153b0d99a80..4167175b580b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -510,6 +510,8 @@ struct module {
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	unsigned int btf_data_size;
 	void *btf_data;
+	unsigned int btf_base_ref_data_size;
+	void *btf_base_ref_data;
 #endif
 #ifdef CONFIG_JUMP_LABEL
 	struct jump_entry *jump_entries;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 36681911c05a..d116ca4a5794 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2148,6 +2148,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 #endif
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	mod->btf_data = any_section_objs(info, ".BTF", 1, &mod->btf_data_size);
+	mod->btf_base_ref_data = any_section_objs(info, ".BTF.base_ref", 1,
+						  &mod->btf_base_ref_data_size);
 #endif
 #ifdef CONFIG_JUMP_LABEL
 	mod->jump_entries = section_objs(info, "__jump_table",
-- 
2.39.3


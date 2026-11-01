Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.148.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562912;
	b=1OoLmwosMfFdU7LgtWP9t7fvBgYaqc2bdc7DdHi2zNlaapFZMCBXfvgIsdHXNAD2S005
	 SGUV5l7XbTYMQgC4cMMgl5QXBnjn4exFa2dysSsQyvqyAs9j34D76RXbP7e2AlucU5s/5
	 h7oHTJF8wGxKgIFx8nsekSMU+oZvzXGqd5DpiePxz4eeEjgB6c/o6YlaZQm8mu4BTlGYX
	 Ptns0121g62e0KxZmuxB5n/zZ1YN2i4f8GztIcHHLP6Dwa2Ldd+O1c1C0wccN/AdL8n92
	 G9XMU9QSX6lokSU/ZE7IeMcffI9zrHUy8624bvFQE78KktwXHDyfwTBXoneywc+W6Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562912;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Ce85114mDFvfbWuL1jNqa1Zhgt6aBo11Zg/QhuctFtQ=;
	b=MZHqS6CDbCwT1b5cNUfiapCEph1OXGxQ6+9UFr8pvvtS0ckK/CaT9p7SVeRFmJu5MRqh
	 QaGNhkaa7gMkOVwk5mF9RmHTFSp1B6mtb2mPGZ/sWbhyyMv5FisTu+4r4bkZiUj7ruNEH
	 38NkZifyEf4GlT6I6B3miS4mwZ3TWjCI+jzryLJITBdvzVaTZPwgmN5DzXOO71Ixer86q
	 7WdpMBSgMhoC/8qLTl120OOwmywjbYVDZImJGT+q9EpWrjq1gU4D85BNNSpdcr9eEdmZi
	 0DW0unQHqW9XL1pyVqmqodHbbSSHPRJ7/+EV1jOukhci6XoX/Np1G6b9ZDgot6eV0RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=rUAEZgFZ;
	arc=none smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D6606A338
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 549D6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=rUAEZgFZ
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1F06rn3901218;
	Sun, 1 Nov 2026 19:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=Ce85114mDFvfbWuL1jNqa1Zhgt6aBo11Zg/QhuctFtQ=; b=rUAE
	ZgFZV/h8aXJk9Rian/T2ql/GVCn6W0FW/rc8mW6p30Ka916zDTmugkB5XtqElKWZ
	iEIwgSUxr+kG4PIMq2x6KCUC4lDH78JLCuceKeOMlw0aF18liybAptj06pmlJf7E
	/jx7aCDoVWwow3rLOW0IaxhWG5bgAoCryeiPSxlIe7r8RSmf5UK74+7D+fQ7EQAc
	JB7J0TPQYOoq3TlRTRCuNZlW+zNwgltmOUhJcF0Xr/sxET8c1p8PLxlR/n/N7IDd
	2uy64c1vaNwOpzJNE4jE1+SIGvUNx5HMi4TpbxrcxcJOu6rL3MThIE4JPLOW3MeF
	E4NOv+bXUfHpMX7hxQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hnuk01p9d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Nov 2026 19:54:58 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Sun, 1 Nov 2026 19:54:57 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <andrii@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next 3/3] libbpf: Clean up BPF program manual loading
Date: Sun, 1 Nov 2026 14:54:53 -0500
Message-ID: <20261101195453.3859308-4-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261101195453.3859308-1-andrey.grodzovsky@crowdstrike.com>
References: <20261101195453.3859308-1-andrey.grodzovsky@crowdstrike.com>
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
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3OSBTYWx0ZWRfX93n/Rac8HnR+
 UpF7AcCyLN1lxWbY59iSOLWK43ki8/X+uHT43sZaf+CSNINhqOTgcBSvmA8Opj4AOoxl4eeonSB
 9XLuWvsy9yNquC+MDskDTozJJpFy288Zu9daI7WQqcWCcwsBx5M5
X-Proofpoint-ORIG-GUID: EzwJn6sTorNuoGQJUQxlT-h4mET7XJqt
X-Proofpoint-GUID: EzwJn6sTorNuoGQJUQxlT-h4mET7XJqt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3OSBTYWx0ZWRfX796i7eSry7Zi
 elSLmOk0nhEWHZDr4/5sN/lNxE04OL9jw7AQ4uXEGXqOfi6L8D39CdrFauVuWJ0vqqiJLJE/jtF
 k1JJ7GXK8EVsLJwaOpoNMKXb7B/G9NvYXQ5u/vq06sYUlELY94OjCuOf9MkzjjIOYy9Q782TOb7
 yevGXg7FC4NzcpbiRQANvGPy6D5kLWm+taxSqPnflsWeaEyFTHV+zktzrIXC6PRDf4ki8EvE8lT
 hFO4tkerz1WVOHWoT+2RgaSBPmlEIM11l40NeQ5jN6IM2IWGTTRHil+FHPqOsM9aOTQzmvFZlOi
 MYyTqUfe5uC7Xic8Ojainx0n0Ec/VZWE8iIcMrYOohlZFYe3u04lT4p4MrWWvf8uZ/3s/Iij4nK
 yTfpWvuHvjNTB9B3E+KyWV42+kfWjbXIu2muxY+rwx5z5LeLLqLkljyDzSd9SAosDxWtwIvV9U9
 rjE2tmqEcnR4cLaiMWA==
X-Authority-Analysis: v=2.4 cv=OaINnRTY c=1 sm=1 tr=0 ts=6ae79912 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=Sske_ziaJ7fd_or9XTcA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11953
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010079

Follow-up cleanups to the manual loading series, just
some extra documentation to the API headers, reject
subprograms in bpf_program__set_load_strategy() for every
strategy and a few more NITs.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 15 ++++++---------
 tools/lib/bpf/libbpf.h | 14 +++++++++++++-
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 02e75b183ed0..446b947c48f3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9844,7 +9844,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
 	}
 
-	bpf_object_post_load_cleanup(obj, false);
+	bpf_object_post_load_cleanup(obj, false /* !force */);
 	obj->state = OBJ_LOADED; /* doesn't matter if successfully or not */
 
 	if (err) {
@@ -16013,16 +16013,14 @@ int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_
 	if (obj->state >= OBJ_PREPARED)
 		return libbpf_err(-EINVAL);
 
+	if (prog_is_subprog(obj, prog))
+		return libbpf_err(-EINVAL);
+
 	switch (strategy) {
 	case BPF_PROG_LOAD_STRATEGY_DISABLED:
 	case BPF_PROG_LOAD_STRATEGY_AUTO:
-		prog->load_strategy = strategy;
-		break;
 	case BPF_PROG_LOAD_STRATEGY_MANUAL:
-		if (prog_is_subprog(obj, prog))
-			return libbpf_err(-EINVAL);
-
-		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_MANUAL;
+		prog->load_strategy = strategy;
 		break;
 	default:
 		return libbpf_err(-EINVAL);
@@ -16036,8 +16034,7 @@ enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program
 	return prog->load_strategy;
 }
 
-int
-bpf_program__load(struct bpf_program *prog)
+int bpf_program__load(struct bpf_program *prog)
 {
 	int err;
 	struct bpf_object *obj = prog->obj;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 22204a544b23..a8a23c135c17 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -390,6 +390,17 @@ LIBBPF_API void bpf_program__set_ifindex(struct bpf_program *prog,
 LIBBPF_API const char *bpf_program__name(const struct bpf_program *prog);
 LIBBPF_API const char *bpf_program__section_name(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
+
+/**
+ * @brief **bpf_program__set_autoload()** sets whether a BPF program is
+ * loaded automatically when its bpf_object is loaded.
+ *
+ * @param prog BPF program to update
+ * @param autoload true to load the program automatically, false to disable
+ * its loading
+ * @return 0 on success; -EINVAL if the object was already prepared or if the
+ * program is a subprogram
+ */
 LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
 LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
 LIBBPF_API void bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);
@@ -2177,7 +2188,8 @@ enum bpf_prog_load_strategy {
  *
  * @param prog BPF program to update
  * @param strategy new load strategy for the program
- * @return 0 on success; negative error code if the object was already prepared
+ * @return 0 on success; -EINVAL if the object was already prepared, if the
+ * strategy is not a valid one, or if the program is a subprogram
  */
 LIBBPF_API int bpf_program__set_load_strategy(struct bpf_program *prog,
 					      enum bpf_prog_load_strategy strategy);
-- 
2.34.1


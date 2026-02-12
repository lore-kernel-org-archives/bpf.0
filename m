Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7F28B4F0;
	Thu, 12 Feb 2026 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770888712; cv=none; b=oVP5AYYVR3pc44ksIw+zrVwX/XDneI8kl0+f2EX0wJbH4mhkWVzxAWNj8XdbXm5lihFDSwnKye/CoPu7m6QJhkgWWT5ju3VwUuzCF8zl1hShtNMYjHhMjVSsy1oVFziqPwIcDNzZ2vqDPx5hOozFj9u/dQp1ZvX5dzvFteZiaE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770888712; c=relaxed/simple;
	bh=6v5ueOuoizItCs4xbX6/bBRRJfIi3+966dfqYFUcPaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+lM0ymiXb6BnoY84MvSMZEYn45zaqw9gFy4ctBhMFo5ORiJJH1kzodESoa920A/z5gYHBl73bvME6B3e8BTnsojrCcPK9UEBqDzCIhSh+D/0WxDXmRMIvxQxMNsgpDz+d7uW5/z921hDXdoHyumh8iuZT3Cc5W++oP3tyfesxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=afpRfTWP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="afpRfTWP"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61C7u78n806309;
	Thu, 12 Feb 2026 09:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ks4BWxfs6IP6kZxAGA0CrXgQnXf5n4rU8aglfzaiF
	S4=; b=afpRfTWPxTn+G7zuh3Y7TNVBuAa0tLiJUZr895YQUL8ErYQxrh5nYh0mn
	5G5gkUSHaFHcuRK/CVXeSOZAGjTNM0GeeaqdPPGtcJnTNE7Ov23e23ihmN0QCYO+
	u2FrpKSlT2DdH9DnFJx5KEMnzImayAMqN1WDdcBhlESSbQqEDEB0ivlt8RXK1Uc3
	Z96yUG3L695RauHq4NuvTD+TgWhWBTf76Zv/Ndc70EaM61EVmQ6Mud72jiH9ytBQ
	CdpuZC0mC6Q/crnHea7UZ0HbgZRlLLuhPD4b06IO8hnlxcZhk/BF6FY+3/mWh2w0
	9AfB/3cmQbADZRCU/IlVkANuAtdIQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696unc74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 09:26:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61C4jsf9012626;
	Thu, 12 Feb 2026 09:26:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7khnka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 09:26:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61C9Q4Jl39518520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 09:26:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E77E20040;
	Thu, 12 Feb 2026 09:26:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD6F220043;
	Thu, 12 Feb 2026 09:25:59 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.in.ibm.com (unknown [9.109.207.131])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Feb 2026 09:25:59 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, maddy@linux.ibm.com, mpe@ellerman.id.au
Subject: [PATCH v2] selftests/bpf: Add powerpc support for get_preempt_count() in selftest
Date: Thu, 12 Feb 2026 14:55:58 +0530
Message-ID: <20260212092558.370623-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698d9cb2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=RLNl__C_HODNSpg9kEgA:9
X-Proofpoint-ORIG-GUID: LFwYoB5YgqT2ivpOH70C3OkLaxkxwh9W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA2OCBTYWx0ZWRfX2TEliqCAk0cE
 ZzqxsGG/rmSvlc1lN191Xxb3pfmkkN9PxUYiu3w3gtfOuwTBXx0PzOpNoms1QWBeZjfxhoGnROx
 Zy0NKDu5axiwdWqw141pR6Bl2d725Fd4mhpZuFyK/SkylnoJa7dO2gqNt0kRJLlT2G/iAbe4Aot
 mDaUO8okuoj4TWh6h3UrZ/py0ldNtposaqllqyspW5NFAFlztdFU8XYhePDz0aWFiP87ak9Aq1G
 xTsFdMaoFUR9XgXKzPrCsJZFKiBBK18+eg9P2q5Obv4mO8+e6NAX3/adcHBhl0cClUBpK2NgNQ+
 ApZm4qkTl4JC9wUdhDXNzm/VMUoGkfxWNNGslW3NBZ48TCogfB1pOf/0fEiBvaapd0gDPY86xSf
 MXW4mRyV6RvgnUNdnoJM3QsgphG7/kemVwvTnFxABnt5ro1NY9AnjQNaDh37WHBT4Vt6vkxZKjP
 FODi8FhR/aNN2oVU5mg==
X-Proofpoint-GUID: i1J05qq25vvJNc-Aa6lbYJrB11DndFMM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120068

get_preempt_count() is enabled to return preempt_count for powerpc,
so that bpf_in_interrupt()/bpf_in_nmi()/bpf_in_serving_softirq()/
bpf_in_task()/bpf_in_hardirq()/get_preempt_count() works for
powerpc as well.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
Changes since v1:
* Updated the comments to include powerpc for the APIs.

v1: https://lore.kernel.org/bpf/20260129054035.168078-1-skb99@linux.ibm.com/
---
 tools/testing/selftests/bpf/bpf_experimental.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4b7210c318dd..9df77e59d4f5 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -645,6 +645,8 @@ static inline int get_preempt_count(void)
 			bpf_this_cpu_ptr(&pcpu_hot))->preempt_count;
 #elif defined(bpf_target_arm64)
 	return bpf_get_current_task_btf()->thread_info.preempt.count;
+#elif defined(bpf_target_powerpc)
+	return bpf_get_current_task_btf()->thread_info.preempt_count;
 #endif
 	return 0;
 }
@@ -653,6 +655,7 @@ static inline int get_preempt_count(void)
  *	Report whether it is in interrupt context. Only works on the following archs:
  *	* x86
  *	* arm64
+ *	* powerpc64
  */
 static inline int bpf_in_interrupt(void)
 {
@@ -672,6 +675,7 @@ static inline int bpf_in_interrupt(void)
  *	Report whether it is in NMI context. Only works on the following archs:
  *	* x86
  *	* arm64
+ *	* powerpc64
  */
 static inline int bpf_in_nmi(void)
 {
@@ -682,6 +686,7 @@ static inline int bpf_in_nmi(void)
  *	Report whether it is in hard IRQ context. Only works on the following archs:
  *	* x86
  *	* arm64
+ *	* powerpc64
  */
 static inline int bpf_in_hardirq(void)
 {
@@ -692,6 +697,7 @@ static inline int bpf_in_hardirq(void)
  *	Report whether it is in softirq context. Only works on the following archs:
  *	* x86
  *	* arm64
+ *	* powerpc64
  */
 static inline int bpf_in_serving_softirq(void)
 {
@@ -710,6 +716,7 @@ static inline int bpf_in_serving_softirq(void)
  *	Report whether it is in task context. Only works on the following archs:
  *	* x86
  *	* arm64
+ *	* powerpc64
  */
 static inline int bpf_in_task(void)
 {
-- 
2.52.0


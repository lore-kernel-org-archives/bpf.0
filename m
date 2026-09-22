Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C656260A
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097644; cv=none; b=C7I4u9Ykbric3GvVRd0+tg50ftNkHJoxO484TO8zKN2MvAKTnOKTRFXagAjEfMduevOYjkLcQq1rWkc4+o2jAGei4U9k9TNfZsfKyh1YShsjBAh16rYyEEsIt2tBFpPtEQNl8438PzPTIGs0BhAT85YLbOgREebYrkIzJcKRvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097644; c=relaxed/simple;
	bh=v9l7tVvrVmZba6RbmYUyb8MQTP/pDEanXcjNhFrjUxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkAcTOc5sJ193Td5af9i42GKikiofPXjY8IkPcacudxwcbEA1uh1fOL0HWqfipiDzcTYZ+nXkZyJV+Nb2JbfvXztIbukukG2G9X3NXbfXwRkSXe9uCebPMKv7VW9L6VJLXzs1h+gFNdDwDb1LeZP5utZA1RP19GFWqG+vIwTONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=g9vU4f6z; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="g9vU4f6z"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so124205a91.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097642; x=1790702442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wuJ2qCnS/wmK7OW9fsN5CCesdI0U+o2AEkrSo+G4ms=;
        b=g9vU4f6zfjepL1ahYJocF3Sol+ULi9lCoUTkJjMeJ9dZFcYS+dojYQbSxhuwLaNtZW
         KITnksRdABgOIWzx8I3jB9y+VLn5OST2baq6O/4PTLqIpFFS1sg69c/u3gO1oDjDHr8W
         Oag00tGWQbWLyqDCJeIv2ZB8v4VYvobTeH3gAjj813Vk+zcgEfgE5HcURYqzjRGZ33kh
         yKWbfqK1cELLiprQE8kVobL1kjtCTGKqa/AK0twku3DL1Kimf/XG6FoGTfAt2yPN44hj
         RzZDIkMc1zacuCDSWM2FeNRZQuJ5iM3YYy3b1jRGeqbbB9J0d/fMrc51R9pdHH+RazFn
         m0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097642; x=1790702442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wuJ2qCnS/wmK7OW9fsN5CCesdI0U+o2AEkrSo+G4ms=;
        b=2eB8QDbhavd26U+ZZCBOWAwiPuLoVSqDfJmoWnFV4kDJ5xvlWL/DHEcd6zgBVuoaoq
         0bBJXjf4PW/oG9PHwQRsytMrlrXrOduXXT8qAOR66tmfZVaJ56CNI9hF5tZjJvDW2G8P
         BLj0b01RE6kIKYEtqLSBBUbzdpsEW1zC9AZ7GWWHHoK1ASSLOuj8CUo2b562YzcmlVHP
         JPOH9boV2gLTHFYv3UYTPalx/R6SI1nnwe3O4jwCaGi2SLTPzxPjiegH9JHjIYrnMpUf
         TIAwN4SA7XQ/d9O70IkYydMqFB6YXsORoVOzBPU3tKtcFvgEdkdiyEy2tKXVLmUdV3vR
         j0Iw==
X-Gm-Message-State: AFuF++mfE9J8SLTr5/W/ky3J91Zu4fmriQ/DOvOQ+VmCSOgNpNCA9fOe
	AI5RLcXWO01a2atdi1ZR9gb4pqD33F+yP+X+0ZMt0bcIfCvmIpG1RqF9DpIFY3pJx4/SkEzsqt/
	TtT7vlJs=
X-Gm-Gg: AYBFou1pXjvfScXILJVXnS99bb4CvEZSRb7vgNEDyCZrSQZyivP4QLqtkSphDwmlyqF
	qdxc3BEqji6GKH2A8gab1GD54L4aKb4y6USFFDlhllPJia+S5vxx776cLq8ag3IRKMzbSHYymt5
	ksJl7O9WEcHr3ZcaqQaamTcWws8DRDMvZKR9ENm0oVR4V8HiGEdBrU/wGryl1FCeHcTFHB50Wbu
	rqNix5OfMKgmT+RafwUqDanjvh3ARjrQ6kEbVHfrA1s1ZJimCbB/yKgDv92Yb9lEuR0+AYJaNwe
	CGnR0g+Hmaj8nopckFng1PE+zpiqW/lXe4fNI/uhwd69Sucb9VnsBGjRwmdHKGM2/1IYs1AHjaq
	eyMtkmif/20buN+1dAU2iCh/STcKdQU2uPDhCQD5RjmYoBtjzb67JTR09w72mwd3lxgZv9TDX6R
	Ds+fRDX3QMlYQfVVrtzKGAC7s3o8vl2xnD2zMIhHYdXEdgxwb2KRxGsNNGeBaNNk7zTXBKGuQWA
	3N+7J/GFBKbdWV1mV5MhK2PtGtycutVB9WQFVE6dQ==
X-Received: by 2002:a17:90b:1c06:b0:39e:3554:4d0e with SMTP id 98e67ed59e1d1-3a07e4f0355mr133318a91.1.1790097641471;
        Tue, 22 Sep 2026 10:20:41 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:33 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 02/11] selftests/bpf: Test dynptr slices past end of skb
Date: Tue, 22 Sep 2026 17:20:19 +0000
Message-ID: <20260922172028.6269-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to ensure dynptr slices cannot include
past the end of the linear area of an skb.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c | 10 ++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 20 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 5fda11590..439656036 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -9,6 +9,7 @@
 enum test_setup_type {
 	SETUP_SYSCALL_SLEEP,
 	SETUP_SKB_PROG,
+	SETUP_SKB_PROG_NONLINEAR,
 	SETUP_SKB_PROG_TP,
 	SETUP_XDP_PROG,
 };
@@ -32,6 +33,7 @@ static struct {
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_slice_non_linear", SETUP_SKB_PROG_NONLINEAR},
 	{"test_dynptr_skb_meta_data", SETUP_SKB_PROG},
 	{"test_dynptr_skb_meta_flags", SETUP_SKB_PROG},
 	{"test_adjust", SETUP_SYSCALL_SLEEP},
@@ -94,7 +96,9 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 		bpf_link__destroy(link);
 		break;
 	case SETUP_SKB_PROG:
+	case SETUP_SKB_PROG_NONLINEAR:
 	{
+		struct __sk_buff ctx = {};
 		int prog_fd;
 		char buf[64];
 
@@ -106,6 +110,12 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 			    .repeat = 1,
 		);
 
+		if (setup_type == SETUP_SKB_PROG_NONLINEAR) {
+			ctx.data_end = ETH_HLEN + sizeof(struct iphdr);
+			topts.ctx_in = &ctx;
+			topts.ctx_size_in = sizeof(ctx);
+		}
+
 		prog_fd = bpf_program__fd(prog);
 		if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
 			goto cleanup;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index e0745b6e4..b668ebd61 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -10,6 +10,7 @@
 #include "errno.h"
 
 #define PAGE_SIZE_64K 65536
+#define TEST_SKB_LINEAR_SIZE (sizeof(struct ethhdr) + sizeof(struct iphdr))
 
 char _license[] SEC("license") = "GPL";
 
@@ -211,6 +212,25 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
 	return 1;
 }
 
+SEC("?tc")
+int test_dynptr_skb_slice_non_linear(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	void *data;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* Ensure we cannot read past the end of the buffer. */
+	data = bpf_dynptr_slice(&ptr, TEST_SKB_LINEAR_SIZE + 1, NULL, 1);
+	if (data)
+		err = 2;
+
+	return 1;
+}
+
 SEC("?tc")
 int test_dynptr_skb_meta_data(struct __sk_buff *skb)
 {
-- 
2.54.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.34.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537958;
	b=Q5dkFaufQDFrga8Y5IRGBUm4TS+OOdk/wEzqKEM6GuEZa/F78biJOKNrw6XzIR9oOxMi
	 P6EdqG1AKqVnKEkmbMTO7KD7usBgx8Uj9ctvYhJ2EsMFP+/z4dxrEZiAainK2vfyfD3gg
	 1LhSb4oWOfQFg0tFA28ETBgyxDdBn2MEzAQTqnz7juqNX+14uNMntxOKOdTVhnomgBu83
	 AKwB7tUIAc+3SRIT2c4ew5iV7Hgy1rHLVVsnLy1cOL+dDpvirhsl8Grtf7SLMuWSpo5xb
	 v0HD9NnQ3buA+b32r0ZodacGLls7AFQQzowXPIYcUAN+tj2/3Hvt9jb8XonE1It7f1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537958;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=mTlpRf3RC5HQeQMo+DdAMqZqEodWvEjesUOo1Ubmpcw=;
	b=CvwGdsxzD8n/sKOv3Kt98Rbg01MhXNOMNuVQHno+KqPqWBsIXlb3Ny506jKgvzdkBsE1
	 +ou6/1u5pFWS6N9mxEWOjEUF/Lv8Z4/Mds/WdpY1+5Xjyq7/NEX8NpJZzZsxhXEkHDPDs
	 I22FB0Ncn2wRyCX7jy5oF0OgjfPpar5yLSJRSV2f1NFhX7O9amYNGZAgPcDE80DlW7GEu
	 fMPZjIYEz190NiVO2pMcxkOKYhCjL/jDVCx0VLeRcCeQgcYUPdrTml3igH5vPoHyy5GxL
	 13A4MwNWHTwSQwJRbRMG0dsY87+iPgLpvgX4AfmNt5BJO4MM7WCHeqGNj1qqBw5FBDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=5FdAlNzD;
	arc=none smtp.remote-ip=54.206.34.216
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A4606A31C;
	Fri, 13 Nov 2026 02:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B34A4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=5FdAlNzD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1794537907;
	bh=mTlpRf3RC5HQeQMo+DdAMqZqEodWvEjesUOo1Ubmpcw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=5FdAlNzDY1dDjCgztCvQCIubEB+hmyxJ3r+BP2o2rdueSZA4aA9IoFPOT39zi0s3A
	 9mow4WA5zkK8cWExJz+a2ie7ys3OMEuadfCBbuRoj1T8toK+R/In0AqHqtfHEjCFmF
	 yphQXe48Wi4ow5FawXygpFqXCzpUvcd6C83rQH7E=
X-QQ-mid: zesmtpip3t1794537901t03476850
X-QQ-Originating-IP: 3u2wNutTpS9BTw7g1NZK+DIx62/GjeUOjoXaMFoxYjU=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 10:45:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15325428955130335503
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: make task_vma iterator stay drained after NULL
Date: Fri, 13 Nov 2026 10:44:59 +0800
Message-Id: <20261113024500.922824-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NLq8blVtEno8+b8nLV6LxrHrLVCy8pLzGaBKEuFrtwxkOC2+j7f09qwO
	6amoyZ3gnXPDBll7MuRgPwPoaHfa2d6uZObaGUT7ZoQxNkbi0RhOEjcrUEnW7HKvUqxmzdu
	WOwCYOX8Xw6Ri7+HOZnnsp2G1vFrP5MvwFlYm0NNTxHpWU5oU8wxFIyBfJNoasorIvQKeBr
	mqMqYmdIwmkIj5f49zNokweU2LYNqavlRYKhG7qoZxr2a4Qw0zo10PYijUQMQBYtK0/+n9D
	P4uymkGWZv7x5Uio89kwwRtQhCSwxKpQ4Pysg0uWqSd5zdXM4WYysFjFO55s0meUNfk1vd0
	oWTBH1uXiKiFayzp7LZYe188ebmMxQJG5HnS8YnY8SdgBVh4kxRXmc4oXqDJFclg4upIJrG
	rDvQsYPwBgl4pGuE1EodyUcrzrlElHTj4CRmWha5Tql/JlvcSy03cacXo2+72I6m8EW6H/R
	184+Hb52j1Mf3ZPSwhR524Iq2k5yyuVWr/aophsPYKEZl7qBGDslyVjUuNm/P4bZ/nhRWBA
	IABrR2hIAXx7gcNEq12Ci23fDUJdXCJwTB9sQCuhwBNmLCSSMTMCACJnD2gVppg2eG7wcGX
	naHj+XX+40Juu206Xf97S4aH3XO29REFNOt6z5MM2HWF/H72T7/MXgC2Crcdo+GIt096yeK
	V5ljAlTvceh8F+5WvsKxbz5hFb0iGjsr1FMSJN1nAaNTxYFxxWJfN9HxHG/ydT+If4pBUyV
	nXqkF0gI1Uma2TZLKS9pGA0jIPM++tN3NhkPd4Rv4HWqBbFrRUsAGHI2FigM9Z49Q0r4UBu
	sznF/WLJRXikmiEGgeeNtZV+H5kEig/1jniOhksX0Z7vGncick09HLiSkydwpODIY4GZGPg
	Av2btPCbvGt6/Ea3ewAwgdkecWT0ltGF3tfpV4cOeEU9v9FcXqeRSF9CYqSfhy7xU2dSrMs
	hQFvZx+MbboxSK0JfADKjul9lbeO+0I8sxein8PEp5KSBDWbbFuOsMnMOmfGQf1r42Vweqh
	pN7NSg93FWRZFy2G5E8rTqa+R/NPt8F6pUeF8w9938w3t8CeKnxyHzVkIRpS4=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

bpf_iter_task_vma_find_next() returns NULL when there is no VMA at or
after data->next_addr, but leaves next_addr unchanged.  Since the
per-VMA lock conversion, the iterator does not hold mmap_lock between
next() calls, so a VMA mapped after exhaustion can be returned by a
later next() call.

The verifier relies on the iterator contract that once next() returns
NULL it keeps returning NULL: process_iter_next_call() marks the
iterator DRAINED and treats later next() results as the constant zero.
A restarted task_vma iteration therefore hands the BPF program a kernel
pointer while the verifier believes R0 == 0.

Add a done flag to the internal iterator data and set it when
bpf_iter_task_vma_find_next() returns NULL.  Later next() calls return
NULL without walking the maple tree again.

Fixes: bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to per-VMA locks")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 kernel/bpf/task_iter.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 2ee7b3b3c10b..720ff7545072 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -854,6 +854,7 @@ struct bpf_iter_task_vma_kern_data {
 	struct mm_struct *mm;
 	struct vm_area_struct snapshot;
 	u64 next_addr;
+	bool done;
 };
 
 struct bpf_iter_task_vma {
@@ -931,6 +932,7 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 
 	kit->data->snapshot.vm_file = NULL;
 	kit->data->next_addr = addr;
+	kit->data->done = false;
 	return 0;
 
 err_cleanup_iter:
@@ -1007,13 +1009,19 @@ __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_v
 	if (!kit->data) /* bpf_iter_task_vma_new failed */
 		return NULL;
 
+	/* Once NULL is returned, next() has to keep returning NULL. */
+	if (kit->data->done)
+		return NULL;
+
 	snap = &kit->data->snapshot;
 
 	bpf_iter_task_vma_snapshot_reset(snap);
 
 	vma = bpf_iter_task_vma_find_next(kit->data);
-	if (!vma)
+	if (!vma) {
+		kit->data->done = true;
 		return NULL;
+	}
 
 	memcpy(snap, vma, sizeof(*snap));
 
-- 
2.34.1


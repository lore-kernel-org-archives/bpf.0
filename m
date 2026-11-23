Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463904;
	b=moTar/Ui66bNg+hufj81eiDl7JkL6p7ImI1kDaw7InhFSILgwxsRzFchoIalQqAd9xfw
	 CEGQi59FhOa8inZrqbnz0KHhDFnubVEGdEmbxX/UJM1Ccj9RvRBkgpUjT5TDcMd3UNQT1
	 w0OHRPISCVSNbNK1ov0QARYXSDe4M+NK9yxkp99kzgjInv8QIPfVPixrnoPDOWZtRKoCE
	 OA+ePVlfFl9Rogfa760pZ5nczmBEWgCWcY//7MhLiY0u3f5N+WLQ74ZyCAUlVg/noaOr2
	 mWiW0Qlde/MDFpEMmdwWHrZC039Wl0lgY+9bQqbpyDIHhnkJU9LGu2FZwxKF7xfVXTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=M/BEC6dc0+bno6k47W7drSlFR0Eiv0IfyeVbx1uXu3g=;
	b=SScS5uymW5yqJKWmJAHEtrH9p5uSVtYTwOK2gnLtda1wHTxLZvSVN10HSjOmY/lERMaY
	 8Uv4EWkZ1niIDSsM39UHsdW489uZzGnY0jil00AI2bHpZHcdrl8D1WDaevcRrMxEh8NgP
	 6N0P6X5X+DidUJKig9iB9k1le7VB8SQSheo2a/igLFFgoe/lhGL9MCKnEDkrkWC3QUAMs
	 p25sYDKx196hU3AjjtkhR/4/ZjuWV+WkMGudyXBzIelqwnJB+IgcavgvJOHEU4WhDKd53
	 2Gwe/M5k2RKP+WKRskBxKNdt1YxxRhXF6WB7nyRql2703zNh0j/G2OS7VXC0uhVi8Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WKYEqKTe;
	arc=none smtp.remote-ip=74.125.225.137
Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686B606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 19:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5686B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WKYEqKTe
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-4b4e4d13850so12922215e9.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 11:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795463901; x=1796068701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M/BEC6dc0+bno6k47W7drSlFR0Eiv0IfyeVbx1uXu3g=;
        b=WKYEqKTeS/jCz+JpwQrPFQA7pwCkO2giLQ1ZA8MCSuzX8SJW1vSBvyvWec6Dq5ojDg
         7wBTrxW1p7SKV8lB3hcBNh/YpbrFUygX0GcYpwv0sOl0DeLUE/DqomtLiej15pnFgrFT
         Wq2T72zZ7lIW6vaQ/GRxIE8HDuj+JTu2fMOdMgJ0xjtwFz73nqFyweDto5giQT4fVGXy
         sNKw0ZymaiBqArw+bOz+Rc7BbAb8I8tA0rDhEwImXuSs7FH1P+W8Ir3B7sC83D+qte6X
         ELonqnfSbHtI27No8IyK0VYA4FQ6iVwpCiHVb2p7gWpwJ2yoCRsx/Nk5O3hFbZn2xKE9
         WLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463901; x=1796068701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M/BEC6dc0+bno6k47W7drSlFR0Eiv0IfyeVbx1uXu3g=;
        b=MgXtcM7oPhscGFgvmbUbfIscbf4Kmp5RlLXYjuCDhzZD/VEpvaDNbo1C05GRDzS3ky
         lVurY7Kyz9YG9I36Mw947uDm18qX05jAwct0T7uuwpXmxTtJm+qWY9SjjPYH3ki/ckl2
         ZN/tL6NDR8FA1L5awhcmQt5CRI0+XV95JmqSjOeeWFHsQvz9MKRm8ycFFdGAmzowhybm
         goHyWPqjt/G6S8rxx5wXwCQ+32rgFIPoP+6hkameatqfI3tnGA05HUJPkgcWLxSs31Sv
         ssRxJ3CNuizEpKlxgS0Dpc+ZYnBkR7lO4/mCYuPY7zJwYaeJIl0R1bzwhofBuouc6cJe
         LjfQ==
X-Gm-Message-State: APuU4Z/hdWwMkwp8PafpMXzyF89qViZGz0yxg0oVFXKYdp8STJtKPKJU
	+vxEf/P5ZGdujWNS/C7QDnHyPHAudjTR0DssNH81ljIiJvQ2S823hD3Zg72pVjPRARU=
X-Gm-Gg: AZFdTZdUce1cS9AAHHGpUgXXiMq53wDUu+0yIzwa5UrJzhFrH5pwawK1+7yh2U2cwqV
	DKEYXy9/rPUKvNF3qiN5ENV9kNIvgTz/0OHkFhJ5srZ6GGG27ShjxTeMfcejyn5wIaRj+UFIqg4
	4htqXc2iq9F7FNNpDsG77knfcJkdm2C6K+/wrAkZkRn61uqHXzrA0EMtd0U7Xar0pCU5AJUI38Q
	Cs3Dyg1WyQKZ4oODsMiJm6vuhxBvgBqKBt4hxXTRg5Cp8MX9k68QIVNSnb+52BnwZHxXX1Iakwd
	ES+esMgloC7O2GA2UN9omnmZKhNIs1LnfeqdzXHkeD9xCBdFDvzcptdB/hAux/KSOpm1WM33Wio
	g/Zi2m6G+VEXsGONqg73jtMB1SNsbBnUO8tRkzo2O1HFdKEO+7LKwj2NOHU2YcZlsosLTnduiHx
	FVTgVDwrMlQkfFniK+hsCBGfwZNbFLH/udaZxhuTKXvdlglkIy9+uXPoZ6pNn63A1HKAu68b2zd
	+BuzzMUS3RdyMFEmDLzHEy7vLIZxrwW9pdXtSZwvjlT/kgtioA5K9JBCZSbGR5jr8vrOuGBWBiV
	4NgetYhObvUzaM3pWSDPDIQ4vP1ON7r5nYYwcgP5MkVpiryj08qg0LB/avshvuWZf2eiqBni0RJ
	djjZ3oLCNots+1cD+A8QertRjFNJgkyaPP3Hj9ElrjCcRymlKemPkXzKEmh59VzmTZe1K
X-Received: by 2002:a05:600c:a087:b0:4a2:5267:3cd4 with SMTP id 5b1f17b1804b1-4bb887c9fbamr267778105e9.3.1795463900472;
        Mon, 23 Nov 2026 11:58:20 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853368d3sm380263525e9.1.2026.11.23.11.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:58:19 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2] bpf: net_sched: Let bpf_kfree_skb() run with irqs off
Date: Mon, 23 Nov 2026 20:58:19 +0100
Message-ID: <a2d4276cbf11b1254aa7997874a6539d20f296cf.1795463894.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1999; i=memxor@gmail.com; h=from:subject:message-id; bh=d0FMlGrAxmPPst5D+uhc0aolGXjC9RkA4xjY4SGoeYQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtl1jWb/ClPdhzUn83xQV40QWTV4qmqXUIFgU2Nj7628 Z93jvjWUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgImkpDEyvNPNPGTaXvLeiMEr rbwwZsv9N2EJ8vEPpzJyaP584HB3LyPDxmrBpOT98lzfr858IG/cvFFjVuaDHwZH78pFLrl2t9e MFQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_kfree_skb() is also the destructor of an skb kptr. A destructor runs
wherever an object or a map value with such a field is freed. That can be
with irqs off, for example:

 - bpf_list_add() drops the new node when @prev is not in the list, while
   the program holds the bpf_spin_lock of the list, which keeps irqs off.
   The drop frees a node that has no other reference, with its fields.

 - bpf_local_storage_map_free() frees the fields of each value under the
   lock of its bucket, which bpf_selem_unlink_nofail() takes with
   raw_res_spin_lock_irqsave(). A qdisc program can keep an skb in task
   storage.

Currently bpf_kfree_skb() calls kfree_skb(), which is not made for that.
The destructor of the skb may enable softirqs, or take a lock that sleeps
on PREEMPT_RT.

Use dev_kfree_skb_any(). With irqs on it is kfree_skb(). With irqs off the
skb goes to the completion queue of the cpu, and NET_TX_SOFTIRQ frees it.

Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 net/sched/bpf_qdisc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 5691c13781a8..e041383a848f 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -196,10 +196,13 @@ __bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *skb)
 
 /* bpf_kfree_skb - Release an skb's reference and drop it immediately.
  * @skb: The skb whose reference to be released and dropped.
+ *
+ * Also the destructor of an skb kptr, which runs wherever an object or a map
+ * value with such a field is freed: under a bpf_spin_lock too, with irqs off.
  */
 __bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
 {
-	kfree_skb(skb);
+	dev_kfree_skb_any(skb);
 }
 
 __bpf_kfunc void bpf_kfree_skb_dtor(void *skb)

base-commit: 84afebd853437e44cb71f718be11d90e4c1a59dd
-- 
2.53.0


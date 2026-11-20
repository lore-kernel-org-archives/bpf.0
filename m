Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211120;
	b=MUU+BIZTTpEHCr6aBmv1UYrBEsN2xuhHRPfW6TQMRhmtOGDMv5v8Iw5X2zA4oAZH05c1
	 34s2DitCBvmL7DXaFkq7722YdLULr+QUSKZp4LubNrXZs7mQEzdrKKIj0vMJ2kiFaYQoA
	 FicO/9SGLD20VbOYc0b04za0lhOBwpKIJ409DJ05Ws243hg3JGc6x36V8JaaFgEQ8AbL+
	 NppPeVGoim6Qcqyyloa8TQRfAiStaWQlWI6HjrBu/gK5CIkXxHqI9hCjqWljvJLRzwqXL
	 f61eEfyAH6dFA6uNLTsABSGKI4z9VgYZgG6zZ3Kr8+zcyicPw5sZRqcY1dKt4pCFwWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LQYysgp//9KShYReg1WCF+KgYK2YJRDdVhocAyIlPg4=;
	b=b0JtW2eXhHo1iAo6K13cXJH5jodZ/b4Kx/0mstmEIlBce4u/CSan0QHdHrrZ7/yxiQPj
	 XxN8Qw5P/6O6RxVQQVxFT94pE2CBumL5DgxS0nv6L1uSjcPoZPizg4vqIYSGtQVTeUVWe
	 W4Db4AfzZPoju0cH18X6JHEsUcr0swHkKvkkWe/DSETIvXoVFF7rIRFFHd63a62A2gFbM
	 bPy26vTjQ21H0JwmNVyxVaOKp6u8GalWUgihbRwi583lAJ1C+gPbe4hdirNVZCutjb/KN
	 br/A7hfSc0MFO87yGSrYIczjowQKS5DoJWY4eNnGqabbP0EPgAHu1V3nBbOCRZZV7MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=C2jpFfSu;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897BE606A6B7
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 897BE606A6B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=C2jpFfSu
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4a76f0cce5fso660177fac.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 13:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1795211116; x=1795815916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LQYysgp//9KShYReg1WCF+KgYK2YJRDdVhocAyIlPg4=;
        b=C2jpFfSuutuCZeuGrrbB6CPrXuCLHPjsYbHeZ0INc6l3v8QadfuYXncjt5KuVqhCt7
         3SGz83K3k0XfOMALHygvAHc0p1IU97YYD7qpD97CXDb1KaWyKI9wQnFAKN+YjHjDDrKi
         mrAFEuwoV4wVp4oMYecBLnGPaSrvpuSnn1QWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795211116; x=1795815916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LQYysgp//9KShYReg1WCF+KgYK2YJRDdVhocAyIlPg4=;
        b=uNDArhTg4bcTImxKOvMc7yYIy1IOJB029tubRimG1/Nl+ru/5CAqiTVLNJY5d9YsT/
         iqKm3F3nJvTeUOT5aYMYQ0IS0VRrW6gJneBSSRRoMoUaLZoHYdZlzV9YR6c8YubEptMA
         l7ShwyR0ybPJzBe3PWygDt5DeQSu4/j7djV7jrcU3lkWL3qIQflYa2kpJNqlvM/DbuyJ
         HLYp7pf9ud0ky1CA5XSQDJS9zme4W/YsZ+KFTebJok8w5hvytyXXQr8oIjOtQg9tyKii
         9mwyDJh0GJPeV5nzSHf2pi+yG+27gFnYRJDrbiJmxQZ5DUSQJ1mavk4OqODAxAosR86X
         v9qQ==
X-Gm-Message-State: APuU4Z+KNpkcWMz98gqTL+LMJ5uDtEKgEGtdw63vARHCzu3ULFTyzw3S
	g/r+cexuRl9TyU+KNOZDNilSvto9cG4B9joLM9at4pvzHcJ2jKECBv4NEJICuzgFzrfgu0ixYEs
	tu0D9LBw=
X-Gm-Gg: AYBFou2kk6Wd3Ba4skc8exz2iL3rn7Wfz6CajxmMJ8qjiu/WBa5vs5djYTo8jB6rtH3
	XiJVyMTn/2TqNqP5iVUQVSd826zH7V9mC0/enHxMkXorAI81aqoRc+WoR71T8orhduqxMhTWsmL
	Eza7/hoAjKuHkGRiBJ2zq5CiELO5zWq2pBJfCFA9Xj2Lz5gd6BD2t8uevD908Qa5sP1f4SKQPEA
	F9l5F2n/E+mbsVKg9d1FBUZw1ooqs7TQIXedJOAfUr2fYi/AzVvHcczyIP8EtvUuU+cJ8tosho6
	QmW3pQIWDYSCCRXrTzCkG4PMxDBVem9jzEbI+ih8SqJydJJR6QZTRMCBCo/KiK15wa68lfDbkmU
	UDXwblOgCcjBR00SHevYONIrUTn48uNH8rjRFNUjJfxiSt2jHqy46HAkGauwb9tgDWDtZyA9HY2
	WA1hDO3lA5E13Cx/lKMEMYP1wRoH7662ybtmbC0xOo2nacJB2h8CwZRAC/MqB8iGCzYlJ0l6des
	Z0fhR2MRNQ/Ch6PcM+riS5gO6c08Irkop54TMvVcpO5kw3gOm3N/zHtBJz+2Fyhdfsxi/LB8dDK
	6f7COnxneCYVbrUIZvWImhfrnM8Sba3nhgZcFw7/GS46LJJ1mAzDv0imywILHLRks+0Uiy0uIm0
	iBjzQjNo5z7fuMuX7+ovSk9tBQiISwL1lF8pskj9hb7veXYNFAX0=
X-Received: by 2002:a05:6808:308d:b0:557:308a:9e9a with SMTP id 5614622812f47-57a095037bemr5687975b6e.21.1795211116347;
        Fri, 20 Nov 2026 13:45:16 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35c5ac5dsm3222237b6e.15.2026.11.20.13.45.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 13:45:16 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v2] net: skmsg: fix copy cursor when coalescing clones
Date: Fri, 20 Nov 2026 13:45:11 -0800
Message-ID: <20261120214511.25934-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

A splice or zero-copy append can leave the destination copy cursor at
sg.end. If sk_msg_clone() subsequently coalesces with the last entry,
sg.end does not advance and the cursor still points at an unused slot.
sk_msg_memcopy_from_iter() can then walk around the ring and write into
older entries, including file pages spliced from a read-only descriptor.

Software TLS can reach this with an ordinary MSG_MORE send after a file
splice and a splice from another TCP socket. Both TCP and the TLS
encrypted-message allocation can use the sending task's page fragment,
so the TCP-sourced plaintext can be contiguous with the next cloned
encrypted-message range.

When coalescing with an exhausted destination, move the copy cursor to
the tail and set copybreak to its old length before extending it. Find
the actual tail on each iteration using the ring iterator, including
when end wraps to zero. Leave an existing copy cursor unchanged and
preserve the normal coalescing, reference counting, and memory charging.

The issue was found by an LLM.

Fixes: fda497e5f5b8 ("Optimize sk_msg_clone() by data merge to end dst sg entry")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v2:
- Rebase onto the BPF fixes tree; no code changes.

v1: https://lore.kernel.org/bpf/20261030042138.73739-1-kylebot@openai.com/

I have a reproducer for this issue and can share via DM

 net/core/skmsg.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 8a3b8536c0c2..f47c59ba1ec6 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -103,16 +103,26 @@ int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
 	}
 
 	while (len) {
+		int last = dst->sg.end;
+
 		sge_len = sge->length - off;
 		if (sge_len > len)
 			sge_len = len;
 
-		if (dst->sg.end)
-			sgd = sk_msg_elem(dst, dst->sg.end - 1);
+		sgd = NULL;
+		if (dst->sg.size) {
+			sk_msg_iter_var_prev(last);
+			sgd = sk_msg_elem(dst, last);
+		}
 
 		if (sgd &&
 		    (sg_page(sge) == sg_page(sgd)) &&
 		    (sg_virt(sge) + off == sg_virt(sgd) + sgd->length)) {
+			/* Start copying at the newly cloned suffix. */
+			if (dst->sg.curr == dst->sg.end) {
+				dst->sg.curr = last;
+				dst->sg.copybreak = sgd->length;
+			}
 			sgd->length += sge_len;
 			dst->sg.size += sge_len;
 		} else if (!sk_msg_full(dst)) {

base-commit: d5ba86298b45e1a81c578c499e9a222a3b734d5d
-- 
2.55.0.openai.911.g06873a30d2f3


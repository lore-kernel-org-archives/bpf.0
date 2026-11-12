Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467404;
	b=0YCiMJpPnIYRjCLaA/HDRpTAj/DJ/YQHWrDpflRixlSLxBUwEEt2RIyqRpbcspDAA8tE
	 0NG2/OMl7Yq/zj2ucsDC8kpPXDnslwc/ShY+p51DgDD0sf84S/t2GwwkMrtvUx+WwkGpH
	 cDMyOFTswpQ43A4gXQBnC2hHZFtQSG6oasIl4tT4BzIDjoEOEBl1eC+hbxgJiDqlGadGJ
	 xr1qopKSILVHt+Q8FbDvdwEi2rXacwQLVf9eeoyeJH0V5u6uSAhEVOG82P6MbHHvOWcSz
	 27adLg9ChVj5RcHm7lFI5dDaQAxaVq1/SR0nFf8hZ/fKz164U6i6vRyM44SU9YAlNqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467404;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HABVVW+/wy81O+RGhGQtZQq+rs+MKTCxcnw5ryaFQCk=;
	b=E83diUINVNAPsMmpHU1mQGX+/nP7cCtO/umfFb7gshJY+/O6s6CDZYqb6xSsHFIm1A68
	 2gJz1ilyzYPwKYVNUoKO+19IrMo/R1FvcPxZbja0vsOXxit1qnh9FrRyHAmxemBDeEZqh
	 38/QKFflzzx1E5iubliM6C4zJVCIf43tqjAtrLI7G/+E0sO0frkMmzlFarL7e0O8mm5SM
	 61bGoXUnqBCS7EnN+QMrMnQ2orIKBzjRgnkTJyXjJwIpZhJcE3I6Ac7VFBnK7XmxYliUr
	 Suf4E4iT2XULPe0qmXZY0Fj9IYi2OUzKCCD8jZRI/1TGYqZYBqGsGW5+FMk2TQ8WUyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=bghIV0lN;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF98606A31C
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DF98606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=bghIV0lN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794467398;
	bh=HABVVW+/wy81O+RGhGQtZQq+rs+MKTCxcnw5ryaFQCk=;
	h=From:To:Cc:Subject:Date;
	b=bghIV0lNbyBFDGbvEtnLCr+zlVCl9qPY1Joi8ZgFqIdQVjb+zStPg5pNuHC4o5uq6
	 VHK2/5qBvjEEm23vWCuAE5dFzm0RyCS3ebEAQ6wqakK6G7N4wUwIWT30L4DBHoYBPc
	 Uhh8FEtDmNoblrSyoWpp3KqjSiwYb8jxJxIYgb94=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.240])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 277002AB; Thu, 12 Nov 2026 15:09:55 +0800
X-QQ-mid: xmsmtpt1794467395tyirqzuda
Message-ID: <tencent_F9A4094B6B79A77230BD540754D65D17BD0A@qq.com>
X-QQ-XMAILINFO: OLz1w8njBCTcDPKKBZi6rXwhrUmo1g1UdkU0SuLAVele6BYpKRtmz8OaiZBXFE
	 QQFrngOb/IiWHzmqgOgUb5MHUvls+ghsZTypHpgrhZ4w8MCHZa9/zItPLQnJos7NggylEMKScNVI
	 kQVmdODeaPJtFU0SlSzlGiAlPb4tRDKwZ0Jq9JhxE+9pBctW9eieyMkOjAsCMIVpOzfT9VhEG14a
	 rXSGSCgMssJjBMfKIkVuv4krKCmdF5odbJGdfd7a8Ct2atUEggBCnbL1me3Jw0FYmhNp7Sei+/f4
	 0IcNwkKxbxqY4nb1AprfD8pk1Ze4/nypFPzUn+5W3QgwfvuDlqyuvY0nwzmv518JEPvS5hxrAZCa
	 3kH2uvuvD0Zeysb7ue+re8fnHNMCW+VR459iw3TD6sNiHtl/TVHXy7rE5dMWy4jLquaKSWFzx83O
	 stNqAufVhMurrHbaIWm7iqDrvFzQRmnkZ4tn+eKDnBfp4kRa25p67qSU/+x1C/vX0UMmBGtqkvgV
	 +iiEEzwQSefvdR7MBRaTcDJ8aY2PXzYjPzwnOO+XoVc0kAzofk3c1Ot9iOjXO2MMhgz9llhx+Vuh
	 sZbGP4NdVyiV3U7N7VWVWp0FCPh40GZPhbBET/2Mlefsc8TRYCCT7RDdHqvhYYx9g0KzYL4Bbp1j
	 0HTsz2r88U4QfH7SbwCZnIlEpoylUYz+I2UirNbW0nxKbhZYUH/VyvA5SjZYwWx+Yb3AAwhHGKi+
	 lM1WoxVodFZlAtbaadpkYKjOMMrn8xqr+PUvE8zLp0SSeHJt4A/UfpAZ1pSDpjTGURrhFnyQCLDZ
	 pi6DsaQzH4dfV0szLGuQWIYu5D5eynEcgiEveoYmYVjc2uaGssU2L+bXNKPOKXg+v+e6YypMppi9
	 5hT8g002llNAHOm8YX0ey/c5C3cY7MA9ee2VXm9WnmslZAZiH/Elhtje7XHU5EQEibUCAJFVauuy
	 4Yd6k+cJ0zragzS8IM61dwtF7EiOpEqVP2y+nU4UGG9MK2+kdxaP1t+lSBwE8RWot6SqAFj0ParT
	 W2JDZ6DTBBk/glUBEvn4AtdL4PZK3+kRgttMgI9OrtMW+HqWVSHRdzg4ca7BnVFXtj0UiqYdxSAs
	 FJwu0ixDCN0gks8lZ2exOcdyOnFxSTLL1aMe3ZHurA+0bmFdA=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: bo cao <treebacker@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Bo Cao <treebacker@foxmail.com>
Subject: [PATCH bpf v3] bpf, sockmap: Fix ring capacity invariant break in bpf_msg_push_data()
Date: Thu, 12 Nov 2026 15:09:53 +0800
X-OQ-MSGID: <20261112070953.14924-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Bo Cao <treebacker@foxmail.com>

A push at msg->size on a full ring reads the length of the free slot.
It is 0, so nothing is copied and sg.end moves onto sg.start.
The ring looks empty and the next push overwrites live elements.
The prog needs CAP_BPF and CAP_NET_ADMIN.

Fixes: 15ab0548e310 ("bpf, sockmap: Several fixes to bpf_msg_push_data")
Signed-off-by: Bo Cao <treebacker@foxmail.com>
---
v2 review: https://lore.kernel.org/bpf/4d767dd560c330fee6b646e99675d84ac5ddecc3f34e2cfc25eeaf580e9bf8d0@mail.kernel.org

Changes since v2, per the review: require two slots only when the
split leaves a non-empty remainder (start < offset + l). A push at
the end of the last element with one free slot keeps taking the
split path (zero-copy, one slot) instead of the copy path and its
get_order(copy + len) GFP_ATOMIC allocation.

Tested on 7.4.0-rc2 + the bpf master sockmap series (arm64 QEMU
virt): the crash reproducer exits cleanly (no WARN, no Oops), and
the reproducer that drives the corrupted state finds no corruption
in ~1900 rounds. Triggering requires CAP_BPF and CAP_NET_ADMIN;
the reproducers run with those capabilities granted via setcap.
---
 net/core/filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 1f81a3dd6a5c..0747f1a4a9c5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2883,6 +2883,10 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	if (start > offset + l)
 		return -EINVAL;
 
+	/* A push at the end of the msg works on the last element */
+	if (i == msg->sg.end && start != offset)
+		sk_msg_iter_var_prev(i);
+
 	space = MAX_MSG_FRAGS - sk_msg_elem_used(msg);
 
 	/* If no space available will fallback to copy, we need at
@@ -2892,7 +2896,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	 * offset case because its the common case for inserting a
 	 * header.
 	 */
-	if (!space || (space == 1 && start != offset))
+	if (!space || (space == 1 && start != offset && start < offset + l))
 		copy = msg->sg.data[i].length;
 
 	if (unlikely(copy + len < copy))
@@ -2908,8 +2912,6 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 
 		raw = page_address(page);
 
-		if (i == msg->sg.end)
-			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		front = start - offset;
 		back = psge->length - front;
@@ -2931,8 +2933,6 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	}
 
 	if (start - offset) {
-		if (i == msg->sg.end)
-			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		rsge = sk_msg_elem_cpy(msg, i);
 		rsge_copy = sk_msg_elem_is_copy(msg, i);
-- 
2.39.5 (Apple Git-154)


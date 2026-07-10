Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9129994B
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 03:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783655769; cv=none; b=O7N0+KmsHMEH4sIi2xQxPTxgXFyTxA5Txo/6VXZ4GQUtBCdJGDGmiBVU5fG3LQXEZkE9lzuJY2liUOkXPwa00r/zbkbbN5YSzRYcDiYLy5upTprgIvdV1I2X1Hrskw5n4Ay/qWJvy0/G9dazoEUusTeP1OojQqu8oBYay9UssHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783655769; c=relaxed/simple;
	bh=5BLxZUryZC6JV0WKMgu8rlXcL1QpjStH3KOvVwWpDyY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=NUibhsGkidQzLrHgzoBuUsC6+yfn72WETuk4bgZBw6Y222nYyeqwOGY8cRteDJNwhsrvhwKygSwTGVg2om9nX/fE7zjdyDyYilYrxXYokDSzR/fp3nCW8eOLCwJKIOtysAPAmn5BATfYp6Y5bk8burZtO4inz1w8+ZrxbGuibtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=dQLI4qpx; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="dQLI4qpx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1783655757;
	bh=LHDHBvsYiuaNGKVD6rCi5sbkUiJTHY/x4SBF7dLSCnw=;
	h=From:To:Cc:Subject:Date;
	b=dQLI4qpxSHKVxjZKrnnQ7UevToyZO4gtnJ2JF8SRZcv560KnjSSdGD4bkOOlRthbU
	 QFx1gKQzobODPeJnmllBTpeSCyX6ZDPQXihezYYPwBNUiboh6L3zbgfnMg7dWCtQY2
	 U0GuewC6ZeECZWoJtywuJfRvd2MzpFXzlKMu6CFM=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id DF79DC9A; Fri, 10 Jul 2026 11:55:55 +0800
X-QQ-mid: xmsmtpt1783655755ts9hsy36d
Message-ID: <tencent_39A7924F2A472D74FA6AD444744E57027905@qq.com>
X-QQ-XMAILINFO: N7Z3XQrOpILuGmPbNn393wsieOP7ItbFr7zbvWPLsKPFjIaJkOKTD9TEskXGdH
	 QTOzBl4+HdxYcB7tgOcmmZXIRJL1u7SrTyIOmmkYgnPc07MCv9pU5DJt5y2dYfy0a9v6jRHp7CJ3
	 63kI2AAOfWd8kzLNOoWJakGeWGGZRfB2UlNRRs8aGWedDFAjumjk1ENv5KV2V6nEqkl+3xofO55o
	 ZZg1JoPLx2QX2AHJ6NytmWVk00mm1fR03iNyf/0RkCc+Pu7XNSvqvwtjycaehGpBI2hnXZRsGShY
	 j21EBix/nlsyUM4FfvLj38hIWtkjGuIWeRiSvOKBqE/vhaeAblzax4fh2cgZjn02q65uL8lFdhHL
	 hvmXJNUCWgHvd/AYQYcdLMia1KOuuuAui394fBl5fqiMM0Ai6xvcminWv+jjT8GxZYXW5QpMEgsG
	 RzhWqGsfHKMOYOVnlsZAjQo7/esCZ2U7O1wMiKOJPuvgJBNkRbZjz7WAP8oyEV4hdD1FCW5LHTqQ
	 Kflb9YRzZV4giw0B7Sv9zTnl0w5hLezwk4bL53OivPNBEOmKDhuQmR7NejLybstfaCCqo8vdjlNW
	 6xRwsMKO8z62vgbVRxUG/7j4J9ec/JfN3/F3kcN6r7Au+0iB7YlOrPCQE/yo/fGVGuUf1212XILZ
	 44HxP8I7vUbvCfa2KNAnmBpjTzCwO6WpDpqVNtzhEf2c8jKhZX5tYMve59NnqiuJlOLaCaIdXj1I
	 4KVKaLFgFflwGryIURkGqs/0hOzQqAEsstPNvh6NG7XChlkICP41SWWlugeUxJ6V9rBw0N0REoIY
	 FL4WKpkAkvFk7N58TyemQgnM4ilmL1tftUgIaBSImJ/Bll71w59R8K1l0Qrcrsz6qrXIIYmd++Lh
	 NcX//BzFfWH66/0VSFmWbVEiua3qNRHsPbq0vFp8h85zdB2r6KYcEh9fzbaVDtIzLuZVNzO96JhM
	 wFo6amfOCfNU+lBEYiqYBRxGEeH1xWhcSK10VZ9AyJYFk1PJ1cj/A6nkAY0eznn1q2oR+g0txFS8
	 ixSUv82wjIbLVOI1tQ
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Subject: [PATCH] bpf: return -EINVAL from bpf_ringbuf_query for unknown flags
Date: Fri, 10 Jul 2026 11:55:55 +0800
X-OQ-MSGID: <20260710035555.3725522-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_ringbuf_query() returns 0 for unrecognized flags, which is
indistinguishable from a successful BPF_RB_AVAIL_DATA query on an empty
ring buffer. Return -EINVAL instead so invalid flags are reported
explicitly.

Update the helper documentation accordingly and document
BPF_RB_OVERWRITE_POS, which was missing from the description list.

Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 include/uapi/linux/bpf.h | 3 ++-
 kernel/bpf/ringbuf.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8d400b76..b18d5810d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4664,13 +4664,14 @@ union bpf_attr {
  *		* **BPF_RB_RING_SIZE**: The size of ring buffer.
  *		* **BPF_RB_CONS_POS**: Consumer position (can wrap around).
  *		* **BPF_RB_PROD_POS**: Producer(s) position (can wrap around).
+ *		* **BPF_RB_OVERWRITE_POS**: Overwrite position (can wrap around).
  *
  *		Data returned is just a momentary snapshot of actual values
  *		and could be inaccurate, so this facility should be used to
  *		power heuristics and for reporting, not to make 100% correct
  *		calculation.
  *	Return
- *		Requested value, or 0, if *flags* are not recognized.
+ *		Requested value on success. **-EINVAL** if *flags* are not recognized.
  *
  * long bpf_csum_level(struct sk_buff *skb, u64 level)
  * 	Description
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 35ae64ade..e549acdc6 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -656,7 +656,7 @@ BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, u64, flags)
 	case BPF_RB_OVERWRITE_POS:
 		return smp_load_acquire(&rb->overwrite_pos);
 	default:
-		return 0;
+		return -EINVAL;
 	}
 }
 
-- 
2.43.0


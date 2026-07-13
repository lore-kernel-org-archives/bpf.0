Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D1175A7D;
	Mon, 13 Jul 2026 01:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783906749; cv=none; b=gfb15gU78PvDIDNSpGBWa8nCUlClBG1K+uk6a2plj90U+cxqJIx8PvOH7NZQB+oSyhBx2GLXxMF4PN5whH8ZSttg/rBuuurE3cATkKZKk48MvfDWHZyLk6iaAUS3LG22J221vgJp+ePvfB2iXxNmD8np694LkJKb4sqIs4NGlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783906749; c=relaxed/simple;
	bh=Xm+o9V/pZoI5ixOOp3mcAHjJqvCs6YRnRUK+3j+nB2E=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=N3i1ZVp6ZZs07l1hTg7dNxss2e59set3mDkTdChIPyipxbvFRioEN5fou1eO8NR1CZAXitVe8v0+kfZefH6Pb0O4dd4Foet8Fa0es5iljO2ckZXtowmnZGATuFcmY/NQaeRTmHJmBP2s1BfW56ya7vTXC7bQejz2axznmxkHIIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=aWgYep3+; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="aWgYep3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1783906738;
	bh=D6B9pz1fK6riDIyk72cXswr2Sg+YM6H5UgEI3ZXy31E=;
	h=From:To:Cc:Subject:Date;
	b=aWgYep3+FLcXo6RSkLqKkzLH6eyB25MptQCkycv9U+HYAaiKu4KiflcLvLfUILj0a
	 0g8Mx6rRxvXSTxLE/KpPDY5AU6ETJmxuthhzQ3reQ4aWCIIEkP3axP4tooBEDqVzot
	 pTp/u1U2XzU4qV5GZJEPfLb0ji1cJHtuLdz4B1rU=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 9B883854; Mon, 13 Jul 2026 09:38:56 +0800
X-QQ-mid: xmsmtpt1783906736t9k5gynmx
Message-ID: <tencent_38F9B572430A53ED62FA69944E7448970A05@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XnEP6N59yZqm88RwujNhjYfvgmQ5XVGhnjUsHqLxcP+Z7xN+QG9
	 QaigLQG1CmrYDQdqxmNSHQXmn4YwJEsW84oST212AwmTMb1wGXwbuNFM1skR8ERkEiA8hGPKGQwZ
	 pixugoTW9oIiW8MEXA7KQ9OvEDfa3lP8zjjL0imSrIkTbqNq6sokf2i3s+c5CPA2gRnZ7sMHC5h7
	 EtN8ozqm95z10dj/O83vwpEG7wRvNlUBIhUeQDbplzzgTPNQkb69BWeAt6Y1X3/IuJum/76jFbOM
	 lztAQRXXhDaz3bFANkR2flCgF0GOP33hBfLiO2UGnUa5KMAELAjqQi92ZiKYvZRjvMv/cPqUj4mq
	 1BaP7B60KafIktiYifff7zpPFClSqPtCa2yToAD5vU7XghQNHKk39cfH7YCn4GjHJ9pdrxfesuh1
	 I4n8FWWdiSAtiLv4gAmTAaU0qRfdBlvCbTOJ9qnuXumPdpo3YCo4RJUgr9yGQR6zJn7zbmCMTO3e
	 E3HXv5mkhsrOXOXHlWdVncsUC2bTQ9vZ06zSnksjr1QvkN2f0iuNMzbITGKBl2ayuRmPUhwLhhEq
	 B5nrsWqElSH8hVNpG0zy8eOO3yjHnUi07YvFimE808hSqQwnF+7ufr5v+H0K5get2BXsHoq7QBrt
	 VxkR7LEtrhIcKlbImzimG2u8KWz5Myayuj89xgYX0DYxHcA6FTfswf9FiLVnmeIjZ+U9QxMXBL8p
	 PlURiGqORuYFexJ63uw7jmFRKLC+skBwq6vvgImV0+iZZfBDKRdui+ZILTnU0IfeFMHUtLxMTCN3
	 nTeHavvDhkij55kClntR2OUWnYVzQWYR7F7s0Fq8AuoYW+XOT8CFoxo/4sTXdYkr9UoCWSxwSwB3
	 LfB7/m6SeVa3Ud14QDrA7E3ADFFnoCo40VgIvC6txqIzd4OiucU7HNXmYReMjOmwdae7Bap4zPxI
	 TV8kzeMb8DReYdj1t4JJB+q+FnOgD8BrmKX/y1yioX9FmjZvlrna2/bmt1wGtuu/w1ngL+8+bRnU
	 18Loj3LmlGYsHNJhx3
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: bpf: document BPF_RB_OVERWRITE_POS in bpf_ringbuf_query
Date: Mon, 13 Jul 2026 09:38:56 +0800
X-OQ-MSGID: <20260713013856.1743009-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_RB_OVERWRITE_POS is supported by bpf_ringbuf_query() but was missing
from the helper documentation. Add it to the flags list.

Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 include/uapi/linux/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8d400b76..fe2873f6c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4664,6 +4664,7 @@ union bpf_attr {
  *		* **BPF_RB_RING_SIZE**: The size of ring buffer.
  *		* **BPF_RB_CONS_POS**: Consumer position (can wrap around).
  *		* **BPF_RB_PROD_POS**: Producer(s) position (can wrap around).
+ *		* **BPF_RB_OVERWRITE_POS**: Overwrite position (can wrap around).
  *
  *		Data returned is just a momentary snapshot of actual values
  *		and could be inaccurate, so this facility should be used to
-- 
2.43.0



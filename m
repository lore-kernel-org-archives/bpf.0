Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F626B777;
	Sat, 30 May 2026 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780104674; cv=none; b=Y7oAB+y9zbiGASWxzhU3gEx7RTFnUdOo+Bz6K600krIsi6NytN6WjnqV5gDK/dd7WU2zCnHEOzp60hwoLvyi5HqObl13hyPoBlQj+hpWosIrD2tkPC9HsINoH6ZshsJE14KkROnSG7SJHguoxWcuSQtNOAPOH1W8FvMZaLkthB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780104674; c=relaxed/simple;
	bh=fVfTqHZ2WHbogx2nZBr70UNIHILr0wIdELp33WCeHes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TWS1igkm7zbdVU2E0Uy602ONyTW1wr2CIlTiN4Sa6nHJHj7qzrqEDi7xa/djqn4S7iDlOW0zMPs2Y22tLb7F7jyOTseE5RBmNo9Hbkdi1bh37bKaR2IpcgKKMdGGjSjQyjExzPeg1+/OXWqQdReIujYydqJblPrlcU7Qxck49RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Xv+Nnv8k; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Xv+Nnv8k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780104651;
	bh=r/sU9JlbH1OG3HMPjg289VM23WNc0borWAhxLH5SNOc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Xv+Nnv8kH166O+i8+RZ5sVqR6vvRtvmBBBXtwHXfa0Lr6qkOAiwGhLibQ9wCYB/Np
	 WlEKMbjzgcbMMAEdgkHKCS6GIPuu+TC4iPNfjZ2lCT00FH8dcHKvZ9II5zcLXSNIiA
	 erG1PWLDkdPBXk/UpohQ8VTarUmVCfDYSvfMUJs8=
X-QQ-mid: esmtpgz15t1780104635t2418dc9f
X-QQ-Originating-IP: TdDOzGIOTRzwJSKNiRfrszmOjb3t9cW8a0G8N4w1F3c=
Received: from PEN202512010006 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 30 May 2026 09:30:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8794944139201534320
EX-QQ-RecipientCnt: 14
From: hongao <hongao@uniontech.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kafai.wan@linux.dev,
	linux-kernel@vger.kernel.org,
	hongao <hongao@uniontech.com>,
	syzbot+0962e3a1af6d5e26a52c@syzkaller.appspotmail.com
Subject: [PATCH] bpf: defer bpffs symlink inode freeing until RCU grace period
Date: Sat, 30 May 2026 09:30:22 +0800
Message-ID: <B36A1A9E983EE6EC+20260530013022.1692378-1-hongao@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MgG/Zwx1chQMlPibVLxxIVYRZkr/T5xmi5N+bT9D4qgBf++lRiAA1Vu5
	NvqA/ExXUf4R4kfl//mzrbcWDVlXxPlh2iN5F3as7mwOI1J0X6YdHsBl9j0JCJjCaCw8jO5
	Yx7Xl5QIndZDOP5z1nkvSlzDEZAht81SLaWTHAlW9ax6rXqUSipB4Jc/AIzWimIjRG6YHoB
	FYCAcR+85lsQxs4wGF+5WM2dT6e6GQCduH09X16V7PX4us2eA5Scns64zGBNg4zUxRtp+7J
	egPEHmmUj8vlvHLpW9eav+/g+R8uza0x6e56l4uaDgr4hvXSgVvluiy3LyKkNeoN4aDYDLk
	oWibhmLARmBflWTH3K0XMX7FQmXIyQZF6xrjiV264/6GU31lP/aZ19QdWqjpau51IjngHnG
	FNtberebY+FEqC2/e9+rjwukX7/XppswlG6Dg3EBhDpyek+YxJFJ+Tg+DaElrsCbntwuMqV
	MGw6GoGrHZqRklZZtWpp4miFC7IoaICQfA8pKElHDjjzXJsC6hSB3TQ/FrMUJCXi4Vfm1JZ
	dABsdqbQax7LLdxA3FD73WTYRjcgU6L2WJaX1KB66CkUjO+3vnEquKMF0vEwh4pr3eUPNqn
	8rjIY89ZtsqxX8ApjmvrZ/XV3hSLg0a4zOcj2OPEbwE3jYLf8tjZenuK0wQnYw0p6LKFh3v
	MQ+ctZmMYc9GiDyAHg7kgeZPBZTKjpmwcpkfvBV2VxRG18iCQI2tM6bbT+bYa6jNWIOK+yi
	WsKiiAp8IX8d62BAXkee4W6sHA9nvj1ZVK3cEF5EbVfJFofa6r//StX4XD+bpuu6O6xaRSS
	0QYYvmUVVmRChKk1kRenQWFQwNR6Nl2PMX7792Dn3yMDvHwRL/jreCIqPOmrTp67iSwMq/f
	QgCdLK0x6+oa54SWaUWleneWCdjsJ+V5LrnGD06wsDIexO9629hWcF+kONu24hHro/iqc29
	729gFB8+dWU4NuM+rwIkeydbYpoGck3Ai3kg5VV8kw9+VSI5YuiPSdJ4KaEHITDks5tvH+F
	isqmEPxHgx1iPVciCVib5KmrKPi/J2Tprmy82hA+4YmGo5jMTCalUQER9rrcVQ0nOQIIgGi
	SuXBqwD057DvuQdBNOOkj3J2idF1NomzZ/KQJ3e9iutr70u00IsUCIBKR1p8aXNSA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

bpffs currently frees inodes directly from ->destroy_inode(). This can
race with RCU path walk following a bpffs symlink: a lookup reader may
still hold an unstable inode pointer while unlink frees the inode
memory, leading to a KASAN use-after-free in
security_inode_follow_link().

Keep BPF object reference dropping in ->destroy_inode(), where sleeping
cleanup is allowed, but move symlink target and inode memory freeing to
->free_inode() so VFS releases them after an RCU grace period.

Fixes: 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning htab with internal structs")
Reported-by: syzbot+0962e3a1af6d5e26a52c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0962e3a1af6d5e26a52c
Tested-by: syzbot+0962e3a1af6d5e26a52c@syzkaller.appspotmail.com
Signed-off-by: hongao <hongao@uniontech.com>
---
 kernel/bpf/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 25c06a011825..a1e9660f9237 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -766,10 +766,14 @@ static void bpf_destroy_inode(struct inode *inode)
 {
 	enum bpf_type type;
 
-	if (S_ISLNK(inode->i_mode))
-		kfree(inode->i_link);
 	if (!bpf_inode_type(inode, &type))
 		bpf_any_put(inode->i_private, type);
+}
+
+static void bpf_free_inode(struct inode *inode)
+{
+	if (S_ISLNK(inode->i_mode))
+		kfree(inode->i_link);
 	free_inode_nonrcu(inode);
 }
 
@@ -778,6 +782,7 @@ const struct super_operations bpf_super_ops = {
 	.drop_inode	= inode_just_drop,
 	.show_options	= bpf_show_options,
 	.destroy_inode	= bpf_destroy_inode,
+	.free_inode	= bpf_free_inode,
 };
 
 enum {
-- 
2.51.0

Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B97436DA00;
	Sat, 21 Mar 2026 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774073301; cv=none; b=dZSQl+6SD9vau7UlgJMEsWDo0bPW7TmsvGxdjruJjX4vDN+JqdDWbIwx8zfOKFOC3b+X6GQnhYkYI4OB8t26+MJerHZxmUr9QaLjB4oKIb2KnSHeG+JghuFUHhY0Kb1cHDpampjFeW0JahatSJSYxKBQ8/Ud1eHk6dyTOQUPUgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774073301; c=relaxed/simple;
	bh=pgIlPL14lAnVW+YSZJDMXBIFV0kir0ycWCGLJWO77CE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=HGvHUTP/ZS2ovdPIfh2aCfOFnB5jjEjbsPrV+gQnW5anJL9i0w4ra+r6ZGTR0jU9dgJwWj1oG13b5B8FCjDhxVnLycnjovhWk4ZKZmmIivs6nqODNflLbFGJpoUECqHAz2BhSZ3ex4WWRMrsFTyp6yKntjpEzMPWIhrbolQOzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pq0QvCyL; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pq0QvCyL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774073287; bh=K3F2Fq+dzbKSIPEcVrdMJMJaRex6Laz1laLkkj3l/f4=;
	h=From:To:Cc:Subject:Date;
	b=pq0QvCyLeeL+HyY0HxzzarSHLxXSmr0CMa3/YsbGW4Dq5lmKCEjqzRNc5jP4pAszk
	 hTokhH9tQrehlEfUFvj60MGJ1Okptaws4KvUSDzRdKl8r9pHvwiMCAMMaZ/gqmpy9p
	 ujlR5Es5t+V/TVfj+jgMwzUoDas3a+tY1CjDKJbY=
Received: from localhost.localdomain ([120.229.96.134])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 2032F495; Sat, 21 Mar 2026 14:08:03 +0800
X-QQ-mid: xmsmtpt1774073283t6n3yd780
Message-ID: <tencent_C9C5B2B28413D6303D505CD02BFEA4708C07@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnRK+3nHNCZ3sG9RlxPCPphizHL/svxJINlYejD94FScBNxpOtrAw
	 xhRd3X69NkwqDTHju3wSc2jp7Qn4BWdDoXcmThgG0YW5fAkjfoo2DFmitukM+NBW9a9eJydX7ouR
	 DiM4mMYVLQ16phBW65MZkOjkZfRlus/m8VkpBX9tbQDg7BvV2eylwP36iTbNIJHGnUSbj+lO0IJp
	 35ytfRHYqnFwY7sn1V0XYiowo2y8SkdUlx9UhScUCW50hsGqHNj8lDGmOSD1TZNMIHfqTxr8B+qs
	 SHmwlYsZiaMABupgfhSeyIDMsTCIyBuR0avHZmu7iwP4yQUa7paEq//aDdCvIkopKN0RnJCSEDMe
	 5qy0VOozTKqzTNaNHJKMsdiqOpRqHBH8r14A+xEH8fshnWbUCHUC8UCsUhUaGHWu90enkfgi6qlq
	 gQxxrtKqY+AJSdY/71098HzPkJqVyQyTUDv537Ycn1y67Nb0iindZT0xpi2ZaejXz15TOhk9i6e0
	 upB2IJH5cRdeInKG2sA//D4T/1SDX1RfOMMGXf3pTcyv7gbEGPhzh2+x/d/xNcSzZeFLIRFHN1X6
	 VKLo83nWn56jKdnHNU6OJPgwWuWzjCXeLbtRCNsnX4OsqVkE/b/refYfGsb91jzmA8aYOauAvZLq
	 9Xzw659ffJRxOEDdVkKJBEnfs7LeW6/4GNGavwAd//usRrBhShzoB4AxnwRkXp+qFHcwds4vxvzD
	 pPgVLGVXqw/2rsc4NOT6ANp1ONYAD46dfUKc3oEgKncoyl1EnFUs/wr1n5zVMf6Dz0W6fyOMY4kM
	 tNZM9QcUX9MyAWo7r0RdD3h9MFzFZtTHnT3rDaNvNHKXaYn+s0govgaikzw426UB/NnSQfBAeuN/
	 KOLiWsIqnfnJ16oyofLaiZ/BxOYYSWTlGihw4crvHMcDN3J2jg+M55/p2K3ToC6rlHhlWvK0E5zv
	 lAtSGbWv4B4m5CnINnViLVm0eG+T/n7jcVUvlpWiALA2yZmyiVKJ4SJYSLvE78SPTzWJUMhftkc4
	 uUuSN+C+3k268Ifkvh66okWjKBCHFtltwFHRWphQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Weixie Cui <523516579@qq.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weixie Cui <cuiweixie@gmail.com>
Subject: [PATCH bpf] bpf: propagate kvmemdup_bpfptr errors from bpf_prog_verify_signature
Date: Sat, 21 Mar 2026 14:08:00 +0800
X-OQ-MSGID: <20260321060800.52699-1-523516579@qq.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weixie Cui <cuiweixie@gmail.com>

kvmemdup_bpfptr() returns -EFAULT when the user pointer cannot be
copied, and -ENOMEM on allocation failure. The error path always
returned -ENOMEM, misreporting bad addresses as out-of-memory.

Return PTR_ERR(sig) so user space gets the correct errno.

Signed-off-by: Weixie Cui <cuiweixie@gmail.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 274039e36465..51ade3cde8bb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2832,7 +2832,7 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
 	sig = kvmemdup_bpfptr(usig, attr->signature_size);
 	if (IS_ERR(sig)) {
 		bpf_key_put(key);
-		return -ENOMEM;
+		return PTR_ERR(sig);
 	}
 
 	bpf_dynptr_init(&sig_ptr, sig, BPF_DYNPTR_TYPE_LOCAL, 0,
-- 
2.39.5 (Apple Git-154)


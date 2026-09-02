Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2B4403AE6;
	Wed,  2 Sep 2026 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339748; cv=none; b=sLJqav7x3ZdsORIng4rdtGvb86BArmb7afqUPnleSmkG4nW43xi3dgp08pH9ljY8z7lNrDKJPrep4PBCB6qEtS8q48QFM67ioTJlz66bj0PbwAhUj8LzPbczFzl2DZ3pzfWrcnNONnpWecSvnxDoxRDUZHt/9N+WCmm0xnfQ9Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339748; c=relaxed/simple;
	bh=I6hf3ZfFfPjE+CdA9iYSwQnShjw39T27Qimm1qIwvLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TR0BOEGke7Pv5GOVTFtbeSPbzV9T881iRXEpothuYE9+QaazsUsav16BwpfRjEueSjTJ4cm/XKct9p+PhaFNk2wcEIh6ZZ+krGZPo2V9LzI8Uy/07EJiEIx3qCKAja/S7q7Yj6Wh5rRwlefoOyZYOF3VeGf2KRj9JnPKAZr57wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=unTMJvQs; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="unTMJvQs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=unTMJvQsiopL4/vEV1uqCsH5FvoD9goyTdO9VGTbtCnGo4R8ua1tT8jOjXkFzVBjoGJgliW1Pp2bB
	 etGLBafjmx2RXne7UjYhpmouyOSG7vKuTXxd5zCIm97mrAKkI7/0N4E6IBEYP12s+GbHK+2S1PrcoM
	 y2DsF554cf/tfOHM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16a97e61e50e-7aa77;
	Wed, 02 Sep 2026 17:02:23 +0800 (CST)
X-RM-TRANSID:2ee16a97e61e50e-7aa77
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86a97e61db23-f39d4;
	Wed, 02 Sep 2026 17:02:22 +0800 (CST)
X-RM-TRANSID:2ee86a97e61db23-f39d4
From: Liu Jing <liujing@cmss.chinamobile.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] bpf: cgroup: fix null-ptr-deref in __cgroup_bpf_attach
Date: Wed,  2 Sep 2026 17:02:20 +0800
Message-ID: <20260902090220.16395-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __cgroup_bpf_attach(), the expression "prog ? : link->link.prog"
dereferences link before validating that link is non-NULL. If both
prog and link are NULL (a contract violation by the caller), this
causes a null pointer dereference.

Add a safe ternary fallback and a NULL check for new_prog before
it is used further.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 kernel/bpf/cgroup.c | 4 +++-
 1 file changed, 3 insertion(+), 1 deletion(-)

--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -814,7 +814,7 @@
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
-	struct bpf_prog *new_prog = prog ? : link->link.prog;
+	struct bpf_prog *new_prog = prog ? : (link ? link->link.prog : NULL);
 	enum cgroup_bpf_attach_type atype;
 	u32 old_flags, old_pl_flags;
 	struct bpf_prog_list *pl;
@@ -833,6 +833,8 @@
 		return -EINVAL;
 	if (!!replace_prog != !!(flags & BPF_F_REPLACE))
 		/* replace_prog implies BPF_F_REPLACE, and vice versa */
+		return -EINVAL;
+	if (!new_prog)
 		return -EINVAL;
 
 	atype = bpf_cgroup_atype_find(type, new_prog->aux->attach_btf_id);

--
2.43.0



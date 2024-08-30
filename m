Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0626ADD;
	Fri, 30 Aug 2024 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983194; cv=none; b=rlNGolrajd7/d+B1I8i6XT9V0ezob5Pta/JqVWlKoVmyczhG+3w5FyzVIxh0hQzILSmjkDs5LnCMcvllWP4/8xU0dbBDuOXywqrOK1nQypg4N8RmfyLm91GFHzQg8VTIsIsl3LR5al4bXXpyPX/Evz4A0pXgSijONv2hxYlLngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983194; c=relaxed/simple;
	bh=mqhQhlMokAAr/KDzdS77oJ4HTaGfsVxEAAaDO6YMwdg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fhaw/9Uu4RUj2ZFBtrOvgnUI3Tl0W+xEeCOznIGMmeUuEiG3/pVgJbHixriO3t1G1MArncg/3HKP+U7M2L2bbqY/EQY1oOJXvfV8dzfNvtkjSKFQY3FWC17aJ81QuV+hMFxd0pjlczBULPEbksLImoJGcAIGWwJ1EDl+1cyY41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ww1Xg2bydzyQj5;
	Fri, 30 Aug 2024 09:58:59 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id F0417140202;
	Fri, 30 Aug 2024 09:59:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 09:59:49 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH bpf-next RESEND] bpf: Use sockfd_put() helper
Date: Fri, 30 Aug 2024 10:07:56 +0800
Message-ID: <20240830020756.607877-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Replace fput() with sockfd_put() in bpf_fd_reuseport_array_update_elem().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
v1-> RESEND
- Use bpf-next instead of -next for commit title prefix.
- Add acked-by.
---
 kernel/bpf/reuseport_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 4b4f9670f1a9..49b8e5a0c6b4 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -308,7 +308,7 @@ int bpf_fd_reuseport_array_update_elem(struct bpf_map *map, void *key,
 
 	spin_unlock_bh(&reuseport_lock);
 put_file:
-	fput(socket->file);
+	sockfd_put(socket);
 	return err;
 }
 
-- 
2.34.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7CBD304
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711603468; cv=none; b=fZKU+bkOG4A3vzfvNXOTD+M/WXd2d/SYd3jHHrghq4GvwvVXa3UlHo9FM48Hc12JibktaRyDRCJmu76+tDqBBOeY403Fp+h5y+2CX2F5mZnjL/VDhtIxTPomzL0DlrXMnLWPfGgC0a4t1nul7qIuVAVYsIjvb68Dnc3rCLYTjH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711603468; c=relaxed/simple;
	bh=MGRS7pTbKLKg0ILrOu32KJ4QlyQZKi2nfA5IIxTn5Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n52nEs/XvDsUNJ1mDD47nr9VD7pmxymVRHZ+2kvL/EcxjhhRodIZD/xamMMnm5xABMulClfJjhfwlZgS7+KaY0iOv9oX4Xd66CnlmowkzRrN7o9D9DUDRrK06xP6qxHSjTLJT+SmRJAl9TAxV/X/xoHQ9PMH+EWFYAAeTMCo+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhXxpWpp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhXxpWpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F348DC433C7;
	Thu, 28 Mar 2024 05:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711603468;
	bh=MGRS7pTbKLKg0ILrOu32KJ4QlyQZKi2nfA5IIxTn5Hk=;
	h=From:To:Cc:Subject:Date:From;
	b=RhXxpWpp5WmgEei6sJdkoPYwtZKp4qwP6CcD3Sq/HCMUqo3Oeww1xeRE5hnaouPmF
	 47rxLsF3bnVOYTKTq+TEmCc693+bzTapQ41zZeimIbNAX7IuoOHrPy7wYZyOm5+r4h
	 CnXgDT1UuQxeNFV95D5mrHfjMUSeQ0hDvEmsIQJxN43PrNh+RxnyiGdsc2W+gRaouP
	 5yobWMjrscWLwuppn58GHZ7BijFCbgYO1uckuodXTE0MWOArd8sauSd1JFJknUlL3Y
	 HKaCCQSTpI4qJvaIsWQtPYa/fW5WFQxDfZPCuPrez4DJyOUkUok65HDtlldzZQypoq
	 E8bOZQMr/2VOw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf 1/2] bpf: put uprobe link's path and task in release callback
Date: Wed, 27 Mar 2024 22:24:25 -0700
Message-ID: <20240328052426.3042617-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to delay putting either path or task to deallocation
step. It can be done right after bpf_uprobe_unregister. Between release
and dealloc, there could be still some running BPF programs, but they
don't access either task or path, only data in link->uprobes, so it is
safe to do.

On the other hand, doing path_put() in dealloc callback makes this
dealloc sleepable because path_put() itself might sleep. Which is
problematic due to the need to call uprobe's dealloc through call_rcu(),
which is what is done in the next bug fix patch. So solve the problem by
releasing these resources early.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/bpf_trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0a5c4efc73c3..0b73fe5f7206 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3157,6 +3157,9 @@ static void bpf_uprobe_multi_link_release(struct bpf_link *link)
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
 	bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, umulti_link->cnt);
+	if (umulti_link->task)
+		put_task_struct(umulti_link->task);
+	path_put(&umulti_link->path);
 }
 
 static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
@@ -3164,9 +3167,6 @@ static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
 	struct bpf_uprobe_multi_link *umulti_link;
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
-	if (umulti_link->task)
-		put_task_struct(umulti_link->task);
-	path_put(&umulti_link->path);
 	kvfree(umulti_link->uprobes);
 	kfree(umulti_link);
 }
-- 
2.43.0


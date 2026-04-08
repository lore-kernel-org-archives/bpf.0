Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BA93B6350
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645358; cv=none; b=qf0sCgPUJuSxZSITM9zz6AWeF7nzw52qPomxGcKtrMuVHEWzY7Y3cy7qme1Jl5YXdrBaFh80dj5uBy2ZCeRP0vLGyPO/fBZj8m0Dxdx8Ixtf79t2TdDxaaixfpncd1MUc/mg+vxfghWl6KYpUdDv1FLxE2DV3zOUeZNQG48iQzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645358; c=relaxed/simple;
	bh=qDfq7B1jAeoui31LJGm9SGD8izpu3YkVBn8qweM8r+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lv4AMksVFdV2XGwvjBORz24LidapeEaZkkj2/IwZJYR6CVWtXPVmt4GLpCT5h4KijkuD8ugrZVeJgiSlqadQPlZKmT+XmqcB7DCxuXUTphgE5+mJUfS9V4OxISw3LBGPI6GLwm4yVRCO5HJhR7ZnOAxAsgldxUBD2iuuVaQ9J8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dxUlZM2x; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dxUlZM2x"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775645342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h++aYznlUjGCsdITk5Sm0RChqsDmheECuw/vR5Kr2yM=;
	b=dxUlZM2xnldQnlYl4N5jRzSOR/4iEQPX5MPVa1HLHWMiRUmDXxXjzGtfZR14F5xzxd4Kp1
	6veeT9stLPx8GCjAI0bRhzJId6qiU8ooqsSv/BQ+C3MSAJWowrg32hq0KE6u3wbzEn4U1k
	jGBxHryn/JLvR+tLm0Y9mBp+6O9BVBQ=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: Fix use-after-free in offloaded map/prog info fill
Date: Wed,  8 Apr 2026 18:47:31 +0800
Message-ID: <20260408104732.259683-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When querying info for an offloaded BPF map or program,
bpf_map_offload_info_fill_ns() and bpf_prog_offload_info_fill_ns()
obtain the network namespace with get_net(dev_net(offmap->netdev)).
However, the associated netdev's netns may be racing with teardown
during netns destruction. If the netns refcount has already reached 0,
get_net() performs a refcount_t increment on 0, triggering:

  refcount_t: addition on 0; use-after-free.

Although rtnl_lock and bpf_devs_lock ensure the netdev pointer remains
valid, they cannot prevent the netns refcount from reaching zero.

Fix this by using maybe_get_net() instead of get_net(). maybe_get_net()
uses refcount_inc_not_zero() and returns NULL if the refcount is already
zero, which causes ns_get_path_cb() to fail and the caller to return
-ENODEV -- the correct behavior when the netns is being destroyed.

Fixes: 675fc275a3a2d ("bpf: offload: report device information for offloaded programs")
Fixes: 52775b33bb507 ("bpf: offload: report device information about offloaded maps")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/f0aa3678-79c9-47ae-9e8c-02a3d1df160a@hust.edu.cn/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/offload.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0ad97d643bf49..d6dc684d0e872 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -435,9 +435,12 @@ static struct ns_common *bpf_prog_offload_info_fill_ns(void *private_data)
 
 	if (aux->offload) {
 		args->info->ifindex = aux->offload->netdev->ifindex;
-		net = dev_net(aux->offload->netdev);
-		get_net(net);
-		ns = &net->ns;
+		net = maybe_get_net(dev_net(aux->offload->netdev));
+		if (net) {
+			ns = &net->ns;
+		} else {
+			ns = NULL;
+		}
 	} else {
 		args->info->ifindex = 0;
 		ns = NULL;
@@ -647,9 +650,12 @@ static struct ns_common *bpf_map_offload_info_fill_ns(void *private_data)
 
 	if (args->offmap->netdev) {
 		args->info->ifindex = args->offmap->netdev->ifindex;
-		net = dev_net(args->offmap->netdev);
-		get_net(net);
-		ns = &net->ns;
+		net = maybe_get_net(dev_net(args->offmap->netdev));
+		if (net) {
+			ns = &net->ns;
+		} else {
+			ns = NULL;
+		}
 	} else {
 		args->info->ifindex = 0;
 		ns = NULL;
-- 
2.43.0


Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C62E6CC0
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 02:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702286; cv=none; b=uqAh80T36gUqljFhO0mBFSb9NXY+Iv3NP/oASugGlKdrBtdEAkWk1NygNptmpeOvVjshpd0gSPUGQiNW0OZyN1hIl6aSLfvir3YCEjLeVuIWfYAF5rphMFZz+LzZoIcs+zk8zA59XCZC0b6B8a6IRtTTXWSaXZqtvlPLkGrJJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702286; c=relaxed/simple;
	bh=iboPAysu5FVZY9DSbZkB2uSur0iwM/BDdPF314YWQMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHBkTBGADcCkxZADich2IiDZOyVTJMoZ296PFoL21gGbseXj3UHXR9R753gi0PGXPADYoNUpid+i5DKR9BwnVkxUr9ffnOUQNsLwnISRX4xVX3Ddccr3zT8lVG3tDAbjmx4XF3/KFWILF0E/ZUKN7xPkvUdZjL7g8AlucXhElCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VEZ4wgjr; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VEZ4wgjr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775702282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j0ntqr0eCaKHhnWx3mL0czlYIr6pfx9bXG9ovvs2on4=;
	b=VEZ4wgjrupbdKEyUbn/8BSesAScfXul+T6CNlG86nUBf7I/5S9cWtAXYSW9kKzgSTYQHe3
	TuPFtnYs0xEd/iyvn+/MQAQ1pEH2voFDm2tUZwEcjSmmesSab+RxDMlrtnA1bw8vnytO0G
	+qoNVie0rTO8q71fr6HqKu4kT3TpyxQ=
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
Subject: [PATCH bpf v2] bpf: Fix use-after-free in offloaded map/prog info fill
Date: Thu,  9 Apr 2026 10:37:32 +0800
Message-ID: <20260409023733.168050-1-jiayuan.chen@linux.dev>
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
-ENOENT -- the correct behavior when the netns is being destroyed.

Fixes: 675fc275a3a2d ("bpf: offload: report device information for offloaded programs")
Fixes: 52775b33bb507 ("bpf: offload: report device information about offloaded maps")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/f0aa3678-79c9-47ae-9e8c-02a3d1df160a@hust.edu.cn/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v1 -> v2: fix the commit message and simplify to ternary.
v1: https://lore.kernel.org/bpf/20260408104732.259683-1-jiayuan.chen@linux.dev/
---
 kernel/bpf/offload.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0ad97d643bf49..0d6f5569588c3 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -435,9 +435,8 @@ static struct ns_common *bpf_prog_offload_info_fill_ns(void *private_data)
 
 	if (aux->offload) {
 		args->info->ifindex = aux->offload->netdev->ifindex;
-		net = dev_net(aux->offload->netdev);
-		get_net(net);
-		ns = &net->ns;
+		net = maybe_get_net(dev_net(aux->offload->netdev));
+		ns = net ? &net->ns : NULL;
 	} else {
 		args->info->ifindex = 0;
 		ns = NULL;
@@ -647,9 +646,8 @@ static struct ns_common *bpf_map_offload_info_fill_ns(void *private_data)
 
 	if (args->offmap->netdev) {
 		args->info->ifindex = args->offmap->netdev->ifindex;
-		net = dev_net(args->offmap->netdev);
-		get_net(net);
-		ns = &net->ns;
+		net = maybe_get_net(dev_net(args->offmap->netdev));
+		ns = net ? &net->ns : NULL;
 	} else {
 		args->info->ifindex = 0;
 		ns = NULL;
-- 
2.43.0


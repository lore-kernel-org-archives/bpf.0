Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E38385521
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157611; cv=none; b=kMJh7rAKKPLPMHZNgpl/O6rmWigc0H5iimlupgEklwgXIKaMdZE6FnwYPJLew7dMRtk0MhXZAFxKGPodqZ1bFDZAfnDTnzyd74wFRgxrBmZmNqxNI5HHhTHlN6oJGnwnlNCnk8QuPsGtC5Tye+VnFoYRIO8Xq84HeXa2hXsox/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157611; c=relaxed/simple;
	bh=3dHREFcLm7gqKgNAjH/wkK7TlEmtSb0IT8JfzGYJXmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2ZYz4nQ359Yvjpc5V2xXdE/ISSeoeU51yJ9VSVz5dpRfk3/9gg7bKHFmikimd29DrpWRi2CHclGopv2sBHGtkd0IiYctITZCo5ALZaKQ90nPG/EEis6HF0T+WSfsFW3bXwtmh7W5FkUc+q7THk1s5705xBvCZIAn4SScDliLxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR5fYCgh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR5fYCgh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so60750625e9.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792157608; x=1792762408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UuGrO2Nw+TigaB2RBhvd97a0VXkhWCtVzbs6ynwIRds=;
        b=RR5fYCghDi7fDayOgFtmRZ7V7pNISEJDP+cZAjggSAggX2/oOIqNBfRq4kR1W2A1dm
         e/zcuRl200ZBBtPr9wUT5VIfjTC4AXJ1vZyxlCGh2stPv6Ba4AfPmsY465QyXt/8O8Tb
         wL1Mp8/YKki7C8R1qj0naHXgbqzm8AHlYZvKmJ4ukfOow/jc5K+3Xbv+HCk3OrSzF6hY
         fPE8n6tDGCERMjmzJK3XdoZyeB9xadnI/IrkS4dYQP34uvqxQy6iZpa5WLw0bmNixufR
         1qpIHzvcPkakNEk0ESAn8r27fLy4wLaekdi6gQwjYBoPLtYnrx6krZ71Euiwf1i19wTT
         iQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157608; x=1792762408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UuGrO2Nw+TigaB2RBhvd97a0VXkhWCtVzbs6ynwIRds=;
        b=CJIvWY+gTi+o9GNPV7J/o/DX0AhR/YgBFb7gePnIXZwAWwpt7cf59D/1t+cG+lfrQF
         M3bHLyjPP8RoA+7fzHfpWOb/ynxWJC8rzs9SLVifnJcyKOmRMmmJi+T2Pv4a95UVmUKz
         uCX08zFNN5yCdpyoF63CIxsfkOe1QJLJEN3liqee8tQgGFioeyiVWp2lQ5MUNkhjQjB5
         yizEsk/6yYyHJCxsyNJAGLk2a0IJbQn8EvRNjWfZ+o9BkjP2dWbInRUnvg9UAF6Wc0gj
         6fTIb/3CGpAsWeNhLCObYmPWH7Abb/XKEDPLNp1cJm/zlunDHxGgp/OjoJ+UQunD43D1
         9MmA==
X-Gm-Message-State: AFq9FYJZwg0y1rzUifmWwINNVmlY7BDnWMTLsxc3DmPRogyVeJxcLdsi
	ZLqBRdUVdFpgR09FZJ2w3EwrShgfIVdoe7tcTrk6ahgGhLlXgub7CHv/lQVuJneTnG4=
X-Gm-Gg: AYBFou1LT9pw6hQkagNG689GbhbWmcY2OkiHSRda3AhpMAOKySyiyjEdL5+zVXK9FRm
	ce9dwfYe4ODZyU9aGEIH8KpatB8JGaabKdL+tg9WAxaNjhfgArrr8s8/aCHx0jY5FA1CLaNFsaC
	EUzDITlywM1aGm7rI9I9BsPFuMiJ6+UPvtVIZvrIv30kLhpbaolBIGMJEua2wrmpjodmSOxdYXU
	x+v2WyaG5/hVgcBTvRNEDYeO9tY6Et+/8WWlGQXJYpPC5VVeVOQg2vLur/hGZu/aj3nN3H+QFGc
	xnmu2gqsQIOdcI7I4yV8K47oPbyGoNik0MFhrOU8ur90Ftgo0dGxKn9I8LakeAlVLU+Dj7rmXkv
	N+Wvoms5rgvSXr+bYNYFOgQDDIoBEm0jB/Fz/00No8KzW7OsIunUF1brwQfKi4k2UZRrwzT9Uil
	2FutJolVAGaYcCbjyXF/VXvWl+NNhBnUXVsnqMh+JgGykDLscvsZt4MefjcYtq/RyU6GpIQmGLo
	t2S8NrGlioLbtKeLYm1rKOcIKtTaiAekKGteJ3vv16vkw==
X-Received: by 2002:a05:600c:3f0c:b0:4a1:85d9:13be with SMTP id 5b1f17b1804b1-4a18e498471mr477331905e9.20.1792157608065;
        Fri, 16 Oct 2026 06:33:28 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1cf05009csm42169885e9.10.2026.10.16.06.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:33:27 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	ameryhung@gmail.com,
	kuniyu@google.com,
	memxor@gmail.com,
	jiayuan.chen@linux.dev,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v7 1/2] bpf: Allow ksock connect/send calls from wq
Date: Fri, 16 Oct 2026 13:33:17 +0000
Message-ID: <20261016133318.33999-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial ksock implementation, commit 7ae4eb14c5f9 ("bpf: Add ksock
kfuncs"), kept LSM checks from the kfunc calls and disallowed
asynchronous workqueues because worker credentials differ from those of
the triggering task. However, discussions at Plumbers 2026[^1] revealed
that bypassing LSM checks for BPF-created sockets could be acceptable.

This patch allows workqueue use while retaining LSM checks for now,
paving the way to call bpf_ksock_connect() and bpf_ksock_send() from
non-sleepable programs, such as tracing programs, in future patches.

Note that bpf_ksock_create() still checks:
* for current to not be a kernel thread (thus excluding bpf workqueue
  callbacks) because the socket is created within a userspace task
  network namespace. It should, most of the time, be the process that
  triggered the SYSCALL program, but could be another task when called
  from bpf_task_work callbacks.
* for current->nsproxy to be non-NULL since when called from a
  bpf_task_work callback and the task is in the do_exit() phase, nsproxy
  is torn down just before the remaining task work is executed.

[^1]: https://lpc.events/event/20/contributions/2430/

Tested-by: Alan Maguire (Oracle) <almagui@kernel.org>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/bpf_ksock.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index e9943aeeadd3..7bf796193ab6 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -37,15 +37,6 @@ static void ksock_release_work_fn(struct work_struct *work)
 	kfree(ks);
 }

-static bool bpf_ksock_has_user_task_context(void)
-{
-	/*
-	 * Task work can run from do_exit() after exit_nsproxy_namespaces()
-	 * cleared current->nsproxy, while current is still not a kthread.
-	 */
-	return !(current->flags & PF_KTHREAD) && current->nsproxy;
-}
-
 __bpf_kfunc_start_defs();

 /**
@@ -59,7 +50,7 @@ __bpf_kfunc_start_defs();
  * This function may sleep (sock_create), so it can only be used
  * in sleepable BPF programs (SYSCALL).
  * It cannot be called from a BPF workqueue callback because that callback
- * does not retain the invoking task's namespace or security context.
+ * does not retain the invoking task's namespace.
  *
  * @opts:	Pointer to struct bpf_ksock_create_opts with socket parameters.
  * @opts__sz:	Size of the opts struct.
@@ -74,11 +65,10 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
 	int err;

 	/*
-	 * sock_create() derives the network namespace, credentials, and cgroup
-	 * from current. Kernel threads, including BPF workqueue callbacks, do
-	 * not carry the context of the task that invoked the BPF program.
+	 * sock_create() derives the network namespace from current and task
+	 * work can run from do_exit() after exit_nsproxy_namespaces()
 	 */
-	if (!bpf_ksock_has_user_task_context()) {
+	if ((current->flags & PF_KTHREAD) || !current->nsproxy) {
 		err = -EOPNOTSUPP;
 		goto err_out;
 	}
@@ -165,9 +155,6 @@ __bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
 	struct sockaddr_storage sa;
 	int addrlen;

-	if (!bpf_ksock_has_user_task_context())
-		return -EOPNOTSUPP;
-
 	if (!addr || addr__sz != sizeof(*addr))
 		return -EINVAL;

@@ -247,9 +234,6 @@ __bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
 	};
 	int ret;

-	if (!bpf_ksock_has_user_task_context())
-		return -EOPNOTSUPP;
-
 	ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);

 	return ret;
--
2.43.0


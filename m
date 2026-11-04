Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788673;
	b=LDUguDT6TCkhZil+dtU2pREUDykrcHxIwymJWOURMCKMltOPZULY/B+CdsFAZ59QpI7y
	 trz8yViyJ6FuWYgLj2K5TvIfQ3jEgxTE1Uh+43+JARC6AxfiLWLXjiXoj/ICuoU3Ac4lp
	 Sbmr8vfFu1Rtak7AHToMOJLL5yz1ym9tgYsXb1oOf5WYaDik0HLDUoIxVYwAmg4hCCSjq
	 ldcjN0zH2fv2j04DNa7V9SO+/RHg1sTOLwzPpPrrVbVG/GpIAxaEMz+B/LCy8OtdsJ3OS
	 7kyPl6e0RwdtOL+k+Rvgstu6r70NG8R7VGfKNpXg2sNCHVHFxRW1Mji4Lr+Z2e+mlFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0Sl/A52Jh/+7K7hLZYa6AaSvNalEM+ZTj9gDU5w7sVs=;
	b=AvCO5vZ/xwO2XccWYGgRvqnIxStmSVfiXw3hGlXfGs2RD6sgCFZvJ/g+gIsM68aiEcK5
	 rYXf1D+Ba8569jm+4wc2LQ+XQbIbPEofTcRIXwB5ORxQdV3nPuW6q0AX/VadahnHcFStp
	 7UPA9i9F4z3zFiiCfRRRkdqslk+LQ+ve6reJoRPI3hAeIf9VSdZnAGoLAlntiAoTsBRiV
	 x4B02jUW7C2AtZMhU0TFij5U6e2FM5Uvj1cJWWxLn++IQRdzbiCnIR7rlTDHCPZ+pZxlL
	 mB9DUJEkxuYaQxjvAIzjaAOn9DYgFCYAJhR4lJUEjG4nZksWMBKYF4KZytHI7liSuCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P51Ypa3m;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C512B606A32E
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 10:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C512B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P51Ypa3m
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso5030125e9.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 02:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793788671; x=1794393471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Sl/A52Jh/+7K7hLZYa6AaSvNalEM+ZTj9gDU5w7sVs=;
        b=P51Ypa3m7ZQtfDxgBbqjO+5DdALJBpaQl7jAbwlQLCKGPL1qm4NzwF0GbksUJRbJBp
         i2zrrcQ2ZHqCFuxvbjuUAX1Fz9zv8EFOxdPuCtrZ53J0G+Wix/8UPOfS/Swh5T+UdXk3
         t76CSdeHEwwjtdvjjd3bf66/rMvQ5csfWv4dbcTXY6WO562q93HZ/9feX7mZWTSoZA4F
         /viJeRaonhTDzK3wRjpKx/Rr19hNFtZyuT728rTeEz4TDy0HCzI6iOpg99qtbPKGqkiy
         zLKK59btxJuC2iF7sk44KHKSFv4jOwJo7bukH5zyA7M6a4zY8Vu4QVVlNOmw9CQZao8W
         Cbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793788671; x=1794393471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Sl/A52Jh/+7K7hLZYa6AaSvNalEM+ZTj9gDU5w7sVs=;
        b=dysQ0j3qaQ51FMUZ3oKHXDwW2+TXsnCFYLSKMFa7W7YLYAgM8PVjCaT8o8MuIe7ZN2
         YqlWqYpytdjyXHuDO1K8h3/GKZNTEwdV+izsw5QtWDv9uMc53qFsKp5OMyRs9jLvUALZ
         +dOgeVG34wHtvdiWw86UBKqtM0stym6WKBrGrjwpftUHbXkwF+xkhoIo74fIvzfiTShd
         9zzbaBMMVmaaRNpjqo8HeXn2U/apSTqBDzohmEuT8C8cIFQQA5ez4F4Mbc8XO+X+mxRn
         1ipHGza6Kueuxpt2cWMXxtQcLnwl9dNEp6y08UiVxKBeV5uSGkvHtAS7Pg2JJYUUOeN/
         3t9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzGsD5eKPCHkNvFhAgKgJVQavOncMIpmNLiZGiq0L7pdwSnDg+0EkcahAStX5VBx1lfWjE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0ljuK478y/Hs1qvFQD7qmTc1ZHiP7dWatFu/tWA6NplbXUARU
	+P5stitOm2StUusCTLHYepRvaJZJjvaqXrqJcVnUx8+zetip4xc0tAj/
X-Gm-Gg: AYBFou3ZOoHksEep2CrK9qyWHuTmUzt6Vh5YuF8LsI2xCDVM6lH8C0p8A4mAlvGuPob
	QZneWKNksYkLvXel+tOsKoIULYuTjVO6IxcTqQMmKFMiwGV9r2IzGc8XwydaUIAfWjPFVs+ZtS2
	LsOzPcWoPdp2vO40gSplswud6fElbgY7Ppo9pmlYuSUSEMYmzxqsT051FAZa0EePoyMU/L21EeV
	CpacRsacEplWRGt3BLhMmRYWZ2LEeVxq2JYJnfmzlysuQDRdoXDcyXDSYg4hJDnHqve9rUSAKL1
	/2HvvqIGUe/ybQqi/MAaFFW3uYAA7rfXINYAs6JB57Q74sRfzO6PXtbzNBQpNSk8ywzKKsDVL3Q
	/BPuQcrYRcrMQHfturWW0ApaZYKsW3C0RSNU0K8r8qOypHb2sT9irxVn9iRldX9NDm9Im3B1620
	Dzyc1BI2dwM0D0HayuT5829IvMd6fPW5kJ+UnT2vpdiMx37hztPuu1nHmorm4//AfLMtTDpYlyI
	L6SDQLY6N78MAq13lxTfjXvHE75uMeis4ZFSidnzeBr9TJAEp92ufuBaUu6pYgeJIQjnXBkipaO
	gZ2QLoXIxMP2HjtHFMIo6SioYxXT3LZWMVPY2G41TY9BOEOkdlZVIyHm9fgey/dbDnZtAbw2vaf
	89Q==
X-Received: by 2002:a05:600c:a00a:b0:4a2:190f:cf6a with SMTP id 5b1f17b1804b1-4ac19802310mr360321275e9.35.1793788670903;
        Wed, 04 Nov 2026 02:37:50 -0800 (PST)
Received: from andreayoga.wind3.hub ([151.76.4.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b40ff10f88sm36342995e9.0.2026.11.04.02.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:37:50 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Rodrigo Campos <rodrigo@kinvolk.io>,
	Christian Brauner <brauner@kernel.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Sargun Dhillon <sargun@sargun.me>,
	Hui Peng <benquike@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	Cong Wang <cwang@multikernel.io>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/4] seccomp: wake poll waiters after interrupted addfd send
Date: Wed,  4 Nov 2026 11:37:32 +0100
Message-ID: <20261104103736.71956-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104103736.71956-1-parri.andrea@gmail.com>
References: <20261104103736.71956-1-parri.andrea@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An atomic SECCOMP_IOCTL_NOTIF_ADDFD request stops the listener from
reporting EPOLLOUT for its notification while the request is pending.  If
a signal interrupts the request before the target dequeues it, the
notification becomes writable again, but poll waiters are not woken.  A
supervisor waiting for EPOLLOUT can then remain asleep, leaving the target
blocked in the trapped syscall.

This affects edge-triggered epoll if the supervisor consumed the event
before the request, and level-triggered epoll, poll() and select() if a
concurrent waiter found no EPOLLOUT while the request was pending.

seccomp_notify_addfd() restores the state from REPLIED to SENT on this
path, but unlike seccomp_notify_recv() and seccomp_handle_addfd(), it does
not wake poll waiters.

Wake EPOLLOUT waiters when restoring SENT.  Extend the interrupted
ADDFD+SEND test to consume the initial edge and require another after the
interrupted request.

The bug was found and the fix was written with the help of an LLM.

Fixes: 832b9b176be06 ("seccomp: restore knotif->state when SECCOMP_ADDFD_FLAG_SEND is interrupted")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 kernel/seccomp.c                              |  4 +++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index d74e66bcb5211..ee94a071736ef 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1824,8 +1824,10 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 		ret = kaddfd.ret;
 	} else {
 		list_del(&kaddfd.list);
-		if (addfd.flags & SECCOMP_ADDFD_FLAG_SEND)
+		if (addfd.flags & SECCOMP_ADDFD_FLAG_SEND) {
 			knotif->state = SECCOMP_NOTIFY_SENT;
+			wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
+		}
 	}
 
 out_unlock:
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 6dd51efe8dff1..123eddb0c0d64 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4485,6 +4485,7 @@ static void empty_handler(int signo)
  *      returning 0 from the trapped syscall without the FD installed.
  *   2. The supervisor can retry SECCOMP_IOCTL_NOTIF_ADDFD (or
  *      SECCOMP_IOCTL_NOTIF_SEND) instead of failing with -EINPROGRESS.
+ *   3. Poll waiters see a new EPOLLOUT edge for the notification.
  *
  * To deterministically hit the race window where the supervisor sleeps in
  * wait_for_completion_interruptible(&kaddfd.completion) after waking the
@@ -4504,7 +4505,10 @@ TEST(user_notification_addfd_send_interrupted)
 	 */
 	pid_t tracee_pid, sig_pid, parent_pid = getpid();
 	long ret;
-	int status, listener, memfd, err;
+	int epollfd, status, listener, memfd, err;
+	struct epoll_event event = {
+		.events = EPOLLOUT | EPOLLET,
+	};
 	struct seccomp_notif_addfd addfd = {};
 	struct seccomp_notif req = {};
 	struct sigaction sa = {};
@@ -4563,6 +4567,12 @@ TEST(user_notification_addfd_send_interrupted)
 	/* Wait for the tracee to trap in do_user_notif(). */
 	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 
+	epollfd = epoll_create1(EPOLL_CLOEXEC);
+	ASSERT_GE(epollfd, 0);
+	ASSERT_EQ(epoll_ctl(epollfd, EPOLL_CTL_ADD, listener, &event), 0);
+	ASSERT_EQ(epoll_wait(epollfd, &event, 1, 1000), 1);
+	ASSERT_NE(event.events & EPOLLOUT, 0);
+
 	/*
 	 * Demote the tracee to SCHED_IDLE and promote the supervisor to
 	 * SCHED_FIFO(99) on the same CPU.
@@ -4630,6 +4640,8 @@ TEST(user_notification_addfd_send_interrupted)
 	EXPECT_EQ(waitpid(sig_pid, &status, 0), sig_pid);
 	EXPECT_EQ(true, WIFEXITED(status));
 	EXPECT_EQ(0, WEXITSTATUS(status));
+	EXPECT_EQ(epoll_wait(epollfd, &event, 1, 1000), 1);
+	EXPECT_NE(event.events & EPOLLOUT, 0);
 
 	nanosleep(&delay, NULL);
 
@@ -4645,6 +4657,7 @@ TEST(user_notification_addfd_send_interrupted)
 	EXPECT_EQ(true, WIFEXITED(status));
 	EXPECT_EQ(0, WEXITSTATUS(status));
 
+	close(epollfd);
 	close(listener);
 	close(memfd);
 }
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788675;
	b=3xNZBKbYiCkro+aTqjDm8zFSMQHceYzioel18YUYCOprF7UZ/oD7UMfWfOl22Lxi+QlQ
	 1clOjXsOarutQ8fz+l24hjWlY6oNEloV3BPLHwn/1G8zo4GtPgqkYL/fsFKag/CHj0vX3
	 OFel7Y3dI0JZoiJ6GIzeSohysbu7Eu0/W+D0QDB0J/bIKMeZZIT8NfcLWqT1+FQQZJtLd
	 E4jNVyAV1Zd5QfldmbVqhXlXxtcHZ9LQ49tyAgAjWCvcIwRB7GbJVmX0RRQaGAmJaFwRn
	 WWVtP/v98l8+2GmrCdLGjDHNsYUJ5hx8KjPQ1y34tP6IF/3AryDp69ETds/P43Z3m6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=onAfKGASw105JYI87UHnMZzgOAw/UrE5Kfe5HtsiM5Y=;
	b=pLyyb1H+0rnTmDhmv9tZXZM0JAvV8RTSOM9nHFwfGPyMMuwARq7oqCbHjaMhS8xE/8FY
	 pCe9sczpzsA3qtRhalYrMYbslTgb83l4k3lAkkfvezlLsdjleav6Q+RRDU6T4kktE1Muc
	 nMOyMWp+JJLlcIGnB56MASbmW3BvTqepTI+cgoBb6xMV1CWzIKTqEPtzCSe50Eqtb6pqF
	 DAqf2LklbyUi9yrXSD9qNMQE+Ar4+i5lTTyRyRw0Oggv03bpHzVLvmSDISDa4ENp60kHQ
	 3Bt+oF3tXG+sjZNB62P8fN0XhP4cXF+jLSm63XHOYk2h2lN0yFAFY+zbvWdOfsEgpiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ky/Vvs7v";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E04606A336
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 10:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7E04606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ky/Vvs7v
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a210470b49so3625565e9.2
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 02:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793788673; x=1794393473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=onAfKGASw105JYI87UHnMZzgOAw/UrE5Kfe5HtsiM5Y=;
        b=ky/Vvs7vq9acnbAepAf0/7PqZUgHqQhJ4a1jWVId1ZL5PMZ9n1cXoI4O/MFd4PCDuN
         mVCr3+rcb95tcGDQ2pM0Z3W/KlfGkuN3rysnVL57YSKjWbxA+d37SlXRl6VteydczA0A
         +P4PEfGGiBxtkM/CTtyxvU3OgfwnnRUNiouA5vud1D6xnJwPoSiy+pNIl5Euv0YYZWsL
         2wbSgTRF9oLjzz+reaRVnj/xSyCLeDXuJe1HiTgncZJXx/QYVH7odhAuTW92cQrh8oiM
         TCNRpahqS22ALACm8jukuWC2qySmc6IalfIOt+blGS5PFLQV0BQ3sT/RylPghRnniv34
         vT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793788673; x=1794393473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=onAfKGASw105JYI87UHnMZzgOAw/UrE5Kfe5HtsiM5Y=;
        b=rHCM2wOpGgSafm7PuS1LfJzhYJaeSoP0gf6F477g1tkqU9yw8jm0hgPGkK8+En/+lu
         Al0sPNdujbmNOpepez1X4LYCkzCmVEv1Wn6KkAV5cAv0dvFDhW2zyFZzR9/ol3GSUv82
         sAMC54VL+Ulwh/6GrSc1B0La+m3BEuW441+jwozOMTFk/h2ACFrS/d7q0oNr1wYjtan9
         wOZ25uPtgsKYn/bYNkUq0ELD1/Pk67fWduZoYRsghME+57z3vpZ0c3hNkJ3UigRgomPe
         H6mXoyqmMIqr98p2v6ZoMFCuvQ+Uk1+qT54VF+RpahzxmZ6XkyMv8uInE/wplzhSMhDN
         Jeew==
X-Forwarded-Encrypted: i=1; AKwUvBxu6BDWN0jqM1niVOgd3gNXRmYaXUeWhfBApB2Mv7Scsu77Z1utK4r5guWAbQ+4noKUb1c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2WSmoT303QnbMTqnGEypoc145CEHwzZv2t+QwGS3IoQCSis7G
	veEKwZmSTXU/DB5s9HIoRQyTY+3yRBDc0i+g7fjNr6Nsqlg9Zj9kA7k1
X-Gm-Gg: AYBFou1r+UQHOPP8Fj9KbkXO1oTIR1rMPBf9IZhPBTaAbUlAzG459BLGAIYe4GC9iFY
	VkpJWfj7NH8Hkbx1wENWSSA3eYlkirHjWtydqRFpBO5bYzKpMkpWS+hDHNw+IOr4wjWOlKbA3+F
	eQaLkBPH1XAN83b+jm55dgeTcpTOg803hcX0JF/ONpAHaOs2mNZ/SVgpjI869zJqztQe7c992e+
	cfPcXG/RcYLr9OGrrcOp9eIdymKd3dbaJzC/WpiOCKkQXW/PCeN5PjhI6R2RnrNew2OGakXpxnM
	GZjAv1oPUwBKs6gGXKvqeQ4rsgbwbINYJDFrsOFJnlBe6p0x2dh9XWHfa6yMBIxR3v0dnIHTa5F
	MWxzM2K5xaAmEdI8vJLRmwAd2verCky4kZ2IZwC6AoaP6scZpme9/VUs8aByonclP9qgPBwS39V
	Lc/VCzvYmzCmRg3Ge/Y8Q+YKoniaQqSPE2pM9fJsmU42rAehyO874qQznnTWGU3eJ3RcqHmZflU
	P9Zwc0d3ibvT2Ybjxp+wiWz7Nw9OlvFipkF8pA9Ba43tBMRfNRumKWZ074tSUuhMAl0gT18MIid
	r2UsJaDaOFafGC3g7Xm3rsHL1ky78KqPgq2RjBGvFoBKPgMvh+FO8D6RTglATq/IHPPP+6Vam49
	9Cw9AwgFyykb056a2dAJJkY0=
X-Received: by 2002:a05:600c:8b06:b0:4a2:d:5ccc with SMTP id 5b1f17b1804b1-4ac17b2bc63mr368842285e9.10.1793788673254;
        Wed, 04 Nov 2026 02:37:53 -0800 (PST)
Received: from andreayoga.wind3.hub ([151.76.4.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b40ff10f88sm36342995e9.0.2026.11.04.02.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:37:52 -0800 (PST)
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
Subject: [PATCH 3/4] seccomp: add a helper to move a notification to SENT
Date: Wed,  4 Nov 2026 11:37:33 +0100
Message-ID: <20261104103736.71956-4-parri.andrea@gmail.com>
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

seccomp_notify_recv(), seccomp_handle_addfd() and seccomp_notify_addfd()
each move a user notification to the SENT state.  The notification then
accepts a reply, so each site must also wake EPOLLOUT waiters.  Both
addfd paths have missed that wakeup before.

Move the state change and the wakeup into seccomp_notify_set_sent() so a
new path cannot set SENT without waking poll waiters.  The helper asserts
that notify_lock is held, as all three callers already do.

No functional change intended.

The change was written with the help of an LLM.

Cc: stable@vger.kernel.org # 7.4.x
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 kernel/seccomp.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index ee94a071736ef..75a758128db2d 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1125,6 +1125,15 @@ static u64 seccomp_next_notify_id(struct seccomp_filter *filter)
 	return filter->notif->next_id++;
 }
 
+/* A notification in SENT state accepts a reply; tell poll waiters. */
+static void seccomp_notify_set_sent(struct seccomp_filter *filter,
+				    struct seccomp_knotif *n)
+{
+	lockdep_assert_held(&filter->notify_lock);
+	n->state = SECCOMP_NOTIFY_SENT;
+	wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
+}
+
 static void seccomp_handle_addfd(struct seccomp_filter *filter,
 				 struct seccomp_kaddfd *addfd,
 				 struct seccomp_knotif *n)
@@ -1145,8 +1154,7 @@ static void seccomp_handle_addfd(struct seccomp_filter *filter,
 	if (addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_SEND) {
 		/* If we fail reset and return an error to the notifier */
 		if (fd < 0) {
-			n->state = SECCOMP_NOTIFY_SENT;
-			wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
+			seccomp_notify_set_sent(filter, n);
 		} else {
 			/* Return the FD we just added */
 			n->flags = 0;
@@ -1600,8 +1608,7 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 	unotif.pid = task_pid_vnr(knotif->task);
 	unotif.data = *(knotif->data);
 
-	knotif->state = SECCOMP_NOTIFY_SENT;
-	wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
+	seccomp_notify_set_sent(filter, knotif);
 	ret = 0;
 out:
 	mutex_unlock(&filter->notify_lock);
@@ -1824,10 +1831,8 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 		ret = kaddfd.ret;
 	} else {
 		list_del(&kaddfd.list);
-		if (addfd.flags & SECCOMP_ADDFD_FLAG_SEND) {
-			knotif->state = SECCOMP_NOTIFY_SENT;
-			wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
-		}
+		if (addfd.flags & SECCOMP_ADDFD_FLAG_SEND)
+			seccomp_notify_set_sent(filter, knotif);
 	}
 
 out_unlock:
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398392;
	b=E/K+veXuOO1FGMuljdT6KazzbKVY2Kw6EHnOAGuTJBJ2k0ZMTyxrLA3bgt8ofe5LlCv9
	 v/ZaFTqG/6TuvC9vpX3lFhM2tdnyPPGxG959EsW/4zjWH+PGyXbyPt6NhJ7al8UQ/QUDr
	 /vIo3ioGdWApb0k1CEaopeUswvOVdHsRH2Xvm9cOfJXY5TgDee4vIYXMbERIzktrSGDWD
	 7Fl+RZGApbIY4QsSray29i5lkA7nW8Gy3b2xjBP3Dv7wPGZisqMvGxq5S+7ChulhnTmT+
	 igebZmB6rb/LmPw0BZg2BnPaPWy267Nf/QlMk1zo/VollRzh9Cqd0ojVjeXOqarNkww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398392;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yhn8wScMRzd3oB4ma+bZ4trIlQBHGnnrBagYtK6G5Ik=;
	b=C3iD5GojZ5HpszsF7X/EJJsoe9DAe61vHx/aIbDKwyky3KS+kXqbQE/+GqlPGC9f680n
	 W5ggj5HEjtwJEfKmBv/4kLenLOhqltEe0Asx2ElNeuk5+aoHmxhDAtlWmYn595+6I8SL1
	 D0hiCWRo18vsDFK5G0mj/ovoQk7UGLIGGgubNnU9gs+iBI8KigYByqzguLUORZbRk+YPj
	 I8icDeHfNs/rZPzpBW0pznOe3rGN8TbR+rBfGoWhdF7uxUXqwh/gs2VROZ2jUHkx7/E/v
	 soP21gSFSqeq5krxiUai54IzVDFlXlcF2oL7DYOHJKDj/SwtfObbMXKTchuV3rOiMIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b="Hvi9C/Jq";
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AA60A260D;
	Wed, 11 Nov 2026 11:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD6AA60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=Hvi9C/Jq
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zM-001rxF-1O; Wed, 11 Nov 2026 12:59:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=yhn8wScMRzd3oB4ma+bZ4trIlQBHGnnrBagYtK6G5Ik=; b=Hvi9C/JqmQi+/4PxW18TXMLnMT
	l12eEszPuNsBXBOkX2pF1+IZ0Q6T1so21hqEJuIjA4a7NL81kEydNtfizwkFix7zoyuFrph4qLhb8
	Kg9gIY3YzX/Y5hvxb601pvoWu3mFeGn+7vrZdSqwFQ8hzSxM++qyeIzB2Om2bNBitIGZufELaE1cV
	Z3OdYb0mc9OxCRcryg24r4uJ4lbZZ4zjWYCrmobEYGr0ZbLYxMug7I8gSXPsqQ2vPEhdSsZX+NnQz
	J7/kHpvXDmM0YedaBhbafFhMIKIRm//KMnhMWvpJNZhZ7TyciBm1fylaUtfyZjVovXORVQHJZ+foh
	rb0/2d5Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zF-0000UX-Kt; Wed, 11 Nov 2026 12:59:33 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xR6z7-001mRM-6H;
	Wed, 11 Nov 2026 12:59:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Samuel Wu <wusamuel@google.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 next 05/13] kallsyms: Fix selftest startup delay
Date: Wed, 11 Nov 2026 11:59:03 +0000
Message-Id: <20261111115911.1142000-6-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261111115911.1142000-1-david.laight.linux@gmail.com>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
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

The kallsym_selftest code clearly intends to sleep until initialisation
is complete in order to get more reproducable timings.

Replace the schedule_timeout() calls with schedule_timeout_idle()
so that the thread actually sleeps.
Poll every second (not every 5) for SYSTEM_RUNNING and then wait
another 10 seconds before starting the tests, otherwise the tests
start as soon an init is executed.

This code is in the initial 2022 import of the tests.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Previously patch 2.

 kernel/kallsyms_selftest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
index 8f6c4e9b3a1c..0db79237fe54 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -411,9 +411,11 @@ static int test_entry(void *p)
 {
 	int ret;
 
+	pr_info("waiting\n");
 	do {
-		schedule_timeout(5 * HZ);
+		schedule_timeout_idle(HZ);
 	} while (system_state != SYSTEM_RUNNING);
+	schedule_timeout_idle(10 * HZ);
 
 	pr_info("start\n");
 	ret = test_kallsyms_basic_function();
-- 
2.39.5


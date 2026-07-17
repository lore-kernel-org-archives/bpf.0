Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09610370D75
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303639; cv=none; b=bxKID0hNC7lqMcidmNpheyY/kYf7VFTy38AIB1rVhy4f7UnEtmsiA3NHbgQsczpWt1LqCOaOdI2gfbzs8EX8V9D8oDbrxa9TdoZYNlOOTPk48LKqj1t9hyxtpcp4HDB57KhaHJlYSk/pZ+jPuUjjK7WQ17jA8es0IDyzJ7RSAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303639; c=relaxed/simple;
	bh=VKuA9f4L9c2fHlbPxYh5eVx4PTiH7moY6MV+G6sSpbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZZ5SZWdEgoN3vFtJgT7alyWQNN1OwSZYQjb+6oEBZCMtHAv+LO88wKv055+LQoANqCNSGifE01WTnA06/RGI9QQTiBWUtdnCd1pOyUJ6Yak9PsUbWs+eWrvULC7czcUqT0xPQpGueybzfICUcsZwHpwfjwVQslmo49HeW+5h2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jw4knwCx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw4knwCx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso17637155e9.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784303634; x=1784908434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJZFhVlVRJBtOvN4CxOHlR9fsZLHag9Vm77ey5DeUVg=;
        b=jw4knwCx20jIkw9/m85F9eMM8jGA+jOCrq7YduUU0ueF2pg9RcnNUJp7DxlVqVVrpI
         DbjjWuC9tuVMmZXjl6OY3K6NDukGxOPEBo8T6l4lM2SyjQ1sIGx4KPNsh8M4wUyskjiR
         IFAHo1rzLJ9Akhgn1q4Y7XlMD/Rf54Mkw4/NXcQuLOk8jSgbfaZr75WU0Sd0TUAD4dey
         4rQ0wFGWceojbHcpqee/LEQukU+ZAJpWc0aI5u24We9f0X1XrPKvCJjSFB6yGR1joQIj
         N4Wi8WL+xauoo3cFQVA6oloN5QEmZZNpsBzvLHvUyySE8A17X6YCupJfhipt8xxRqO09
         ZU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303634; x=1784908434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QJZFhVlVRJBtOvN4CxOHlR9fsZLHag9Vm77ey5DeUVg=;
        b=XlwC6q3MimbdddlGPwALRLElYC3kA7VPU8uMrxHd+SkBpKfpiat3gHIGPhmok50cej
         VCtQVm6yy/WEfj6xo84ymrmhY1fB+IXSQ99AQbXqYfn1P1q6UTi3LwQyrmZZsT+hnpte
         /5FGrB32UCfoxAoiI+f7Oz1z7gOhhclzE1RzaFwzk75sHcUiHHYD9gutBgWg6YpjaykC
         dPrDuojktEDmcNHkDCz0KBLLI6+ICN2w6gGX0Aqg5PVoeDxL4Q6rj6JeEdmucQKUwUIP
         eaPexi/Fi+DrKDavZSQSfN8EOgbnFEjsdZBPSpVPERiGZ6uIcUMzdmEh62GMbXKlQIS5
         VCDA==
X-Gm-Message-State: AOJu0YzPsJxa6AN1jE7kPPvYaCxoiXORBBfli3lF6yyXfNZNKYL3Hyih
	beStSVP0G6rTWwIQZufFPGrDk7R/TeLOHghMtMRnTQCcfWmKrOHhdHGS
X-Gm-Gg: AfdE7cmxe4aT1hJphj5uTSwky6E4gAyYlhZ7ovPZz8T/qNdK8/VRCZCIiKR3KtjY6j7
	+I7LJZ/rMnexH7Tfa1vUYy4AzgposXKfRcR5dZD4nIBMdNtyG/LPl92KGk763zadFJ9HnJ3BRdo
	Mw3rBwlEyYqgEK1zsEniem6pUOfJBNEXNRGCEqmXnAXnWCJdx1YamAM7Ks50hSS4SUKNNSiNIA8
	Te5xMcuf7InGehzFzMMjr/0V/FWChHJOB9bgdBRXs3KDqjsRRfFFsuYlP7h2oYGUKMRMOpFkHZm
	IkUiAIT736ShhLm2CHzh2ZsO/2UGPjljhylTtifoQvJ/+jGWjZcKWBmxng0e2rzL2WHdwtksaa7
	tkIMnH+U+E9fiOAjJG+q8Hzngn6OW0DUBqhERds85/T0/aQSQopM1EL+hJjrB8lWOpmjJHtlX4l
	W16S/2ZQXRym7lqDKVH1xcYo/AV3F4EHnL0U2WpeMv2X67RVrmq4aOU7gV5+DHCYxnQA==
X-Received: by 2002:a05:600c:4504:b0:495:495b:9248 with SMTP id 5b1f17b1804b1-4954a3d0cf9mr35460595e9.4.1784303633793;
        Fri, 17 Jul 2026 08:53:53 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63edcf8dsm5321369f8f.27.2026.07.17.08.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:53:53 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: nnamdio@gmail.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sashiko-reviews@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] selftest/bpf: added selftest sockmap_basic/sockmap recvfrom eagain
Date: Fri, 17 Jul 2026 16:53:48 +0100
Message-ID: <20260717155348.54975-3-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717155348.54975-1-nnamdio@gmail.com>
References: <20260717155348.54975-1-nnamdio@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These selftests exercise the tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser()
functions, to ensure that they are properly handling spurious wakeups in
tcp_msg_wait_data().

The expected behaviour is that recvfrom() does not return an EAGAIN
error.  If the spurious wakeups are incorrectly handled, this assertion
will fail.

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index cb3229711f93..852a12b17e6b 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1373,6 +1373,117 @@ static void test_sockmap_multi_channels(int sotype)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
+static void *test_sockmap_recvfrom_eagain_thread(void *arg)
+{
+	int fd = *(int *)arg;
+	char buf[1024];
+	void *result = NULL;
+
+	while (true) {
+		ssize_t len = recvfrom(fd, buf, sizeof(buf), 0, NULL, NULL);
+
+		if (len == -1) {
+			if (errno == EINTR)
+				continue;
+			result = (void *)1;
+			break;
+		}
+
+		if (!len || buf[len - 1] == 'e')
+			break;
+	}
+
+	send(fd, "test", 4, MSG_NOSIGNAL);
+
+	return result;
+}
+
+static void test_sockmap_recvfrom_eagain(bool with_verdict)
+{
+	struct test_sockmap_pass_prog *skel = NULL;
+	struct bpf_program *prog = NULL;
+	size_t buflen = 1024 * 1024 * 25;
+	char *buf = NULL;
+	int map, err;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	map = bpf_map__fd(skel->maps.sock_map_msg);
+
+	if (with_verdict) {
+		prog = skel->progs.prog_skb_verdict;
+		err = bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_VERDICT, 0);
+		if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
+			goto cleanup;
+	}
+
+	buf = malloc(buflen);
+	if (!ASSERT_OK_PTR(buf, "malloc buf"))
+		goto cleanup;
+	memset(buf, 0, buflen);
+	buf[buflen - 1] = 'e';
+
+	for (int i = 0; i < 200; ++i) {
+		ssize_t sent;
+		char ignored[128];
+		pthread_t thread;
+		bool thread_created = false;
+		size_t rem = buflen;
+		int c = -1, p = -1, zero = 0;
+		bool success = false;
+
+		err = create_pair(AF_INET, SOCK_STREAM, &c, &p);
+		if (!ASSERT_OK(err, "create_pair"))
+			goto end_attempt;
+
+		err = pthread_create(&thread, NULL, &test_sockmap_recvfrom_eagain_thread, &p);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto end_attempt;
+		thread_created = true;
+
+		err = bpf_map_update_elem(map, &zero, &c, BPF_ANY);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto end_attempt;
+
+		while (rem) {
+			sent = xsend(c, buf + (buflen - rem), rem, 0);
+			if (sent == -1)
+				goto end_attempt;
+			rem -= sent;
+		}
+
+		err = recvfrom(c, ignored, sizeof(ignored), 0, NULL, NULL);
+		if (err < 0 && !ASSERT_NEQ(errno, EAGAIN, "recvfrom eagain"))
+			goto end_attempt;
+
+		success = true;
+
+end_attempt:
+		if (c >= 0)
+			close(c);
+
+		if (thread_created) {
+			void *retval = NULL;
+
+			pthread_join(thread, &retval);
+			ASSERT_NULL(retval, "retval");
+		}
+
+		if (p >= 0)
+			close(p);
+		if (!success)
+			break;
+	}
+
+cleanup:
+	if (buf)
+		free(buf);
+
+	test_sockmap_pass_prog__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -1451,4 +1562,8 @@ void test_sockmap_basic(void)
 		test_sockmap_multi_channels(SOCK_STREAM);
 	if (test__start_subtest("sockmap udp multi channels"))
 		test_sockmap_multi_channels(SOCK_DGRAM);
+	if (test__start_subtest("sockmap recvfrom eagain"))
+		test_sockmap_recvfrom_eagain(false);
+	if (test__start_subtest("sockmap recvfrom eagain with verdict"))
+		test_sockmap_recvfrom_eagain(true);
 }
-- 
2.52.0


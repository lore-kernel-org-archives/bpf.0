Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193444;
	b=fm/kWwPJl97yYDRecs7GgVIkXrHlqCeMTcll3vjPpXpZ7ih6YkR7732pHQgx+7nDqFK0
	 fIi9carZP7ljO0/YZANNlYL68RDa9alRzN/VIxkII+rhHfcn2lvh4kSijY8pCpCvZ8bio
	 39K6OK9jjt7C3W++U6M8EWVMeCOVtnSzJXrsYnWrByQozpG1pX6dh+ZPNNZT/BSde000C
	 5pdcFFYJTgNe2uHD0d+U82dBm5oFP5QcvvzXtUXXJBdP0QQf7lndrahPwqLNbO9F70DUE
	 pOlGTYgJbeBZdbZVVYG1o8UEI8YYosQuGhWPSTYKn3F+3m8nXc3zYp1jPdU90b+MfzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W/ErCOQlL7PFlFttDgTOPB12+JuuR+9+i9HgQWVpVjo=;
	b=OYWqAJqKnnfHBynSH1KdIk96ueShffVAZDoMDfEL9YEOwT0QaD/CcvHj55DYsHUIULGa
	 1GMUrAkKHUT0XHfoniImW8a3KATTTAjT11QSpGzjmJWHp2hnLpa8MyS5TQ8PjxTPCjKYj
	 r6af7vbbNBhE3Z0ps+PHOSxInhKNMCfktmb7rKvhAjGg0p4mTsKi4fpXBeW3h/aCOzFs+
	 uYD+Zho/2tCRsPTHa/+Ar0g9ybatn/46ffE1c8QB08yX0ug1OB5Rm6+xkWWmQkTXZhHxu
	 SoNP1uAJn9rbxjat9cul34qaF+Ud200rm2X54veSivkijWuFYDsHMUnlBRN5Rx0lO4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=PXyBkbEw;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCAE606A320
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 03:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADCAE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=PXyBkbEw
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b5efadd183so159133b3a.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 19:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1794193443; x=1794798243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/ErCOQlL7PFlFttDgTOPB12+JuuR+9+i9HgQWVpVjo=;
        b=PXyBkbEwD/oNZRbrtbV4HCnh99gqUzI+CI1QhSKaJ9mkB9jx4pil253hYgu4fJz3cQ
         uo2XfW6FxfW9m31t7AC5kISYK4pjrxoyfXziMDvWLl/alDwK6Me9Tafd+QsatxE/tUOl
         ssQIrkFuZjuxt7NrYK6KVrPlJiq0Os2uPb9fvHgUChD9o0cXTXOBQ0zGePQOjkyddK9E
         tMpLFeObgcgV1iuA7NAw9vz+NJG8A8S2ipQ+I7wb0q2V1kzWyxZW3KYi5dlfYYPmF7M6
         MhwYdCy0muq/+FWz2QRn/FjlltoQ6CQ27e3ftjx9ukGpMKuQiSOZIO+tBRVlt3ntWYon
         NmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794193443; x=1794798243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/ErCOQlL7PFlFttDgTOPB12+JuuR+9+i9HgQWVpVjo=;
        b=l24qSZs6PzxmAO1RhkTu3wjcAz7vRotcss52Jvo9jVKO99QogiUnb4ZAdo/hOI8yIt
         k7tpzIMiQR9yDSXavIjk0OCXNHQPkFfoX3tDKdI8fDL93Fkc9YAIlCEYtRT9DSKbRTN1
         JwkL4aIf4oLpBcDAtol9qXl2pzlswaCeRSFHtIdaPd4+l7bxyXZCLwU5VlQRbAXKlk+l
         FFqgoGJ+vHOYvAfnjVbfG0We1HmyfADTvPPk0dT2FXt+vl7Ylad4rNt26MJJBxPNs8Yr
         N29WIlaXhrAegygqeU5YeY6xgfYWlna7ejbY7CRquRaUaD+wfklHkHfSM1ZqfI4gvryc
         dnuA==
X-Gm-Message-State: APuU4Z9snUiIE5P9j+dEv9+B9ZcPCiq+MkUXEjDx1kdauDEz/w+FOH+g
	jnWctTQiDHfw6I3SA4I/6+/RNKS++sBeSOTCcrJ8QL9msSvDTfofyIzvxGNRNzzhj89VBpxaxos
	fVTSR+g==
X-Gm-Gg: AYBFou3qy6o17qQTFEbyiyxAQZ6WLUU2oZscszMxbgLPwk56n8ROYHvljPKyjdIO9ET
	M4TmyHBoN0U3HdL3ha0m9gHRT5P3rHQ74fxVuTEMPo64LFTNgfY3xul0J5o/1SzqFyTbW/jNIHW
	53mRwV6BivdtsLIAib3T3DsEQQ9ch2vBIOvPtU1QUmZb8zxc1QirMl0rdFkNt5pgO1joVb4zLwl
	aNcKXxc4Ek6jyZagHbjYIpxYzK+ZUeZoZBvzvV89iT2OdprjAuqx1sDLUruFTHC0t/rggoe2XmE
	VVNWhs+QHeAG3kYLsSsG8wLUEzRQzmVTuPA7Q1q0AurWwUU5aALA6Ty+9bOtk2qQs93WcT9vDGL
	3yr8ioWiWKrZnQnD75GffBCE16WxUrK1+Ec9NIaJrfFfl1maWOHFE86DWJ7oOkmsZsLJdihOxyo
	t8X2qeIr1562u/I/hkRIQ5bgsJkNTODs8eBChP0c6BZqh9SLV75nVZoHiftDwPna8E/7siRCl+y
	TsZ6m2CyOFIBWtsQNHcuocJ2Jk21SO1jZ8erxqNpa6n/2cgSbW9PJ0Ezp7JQA/szthmKIJFu9pc
	Y+37RN04yrBsfU7UMyjm/YcssMjedyutWoyEkA==
X-Received: by 2002:a17:90b:5804:b0:3b0:9409:6969 with SMTP id 98e67ed59e1d1-3b12d47fc8dmr1789820a91.19.1794193442836;
        Sun, 08 Nov 2026 19:04:02 -0800 (PST)
Received: from enjou-Legion-Y7000P-2019 ([74.52.12.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b12743e889sm4981759a91.0.2026.11.08.19.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:04:02 -0800 (PST)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	void@manifault.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH bpf 2/2] selftests/bpf: Test user ringbuf backlog larger than ring size
Date: Mon,  9 Nov 2026 11:03:45 +0800
Message-ID: <080cf00ad740b4cd9af71bfc6c9e9a57a6aef693.1793951856.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793951856.git.rakukuip@gmail.com>
References: <cover.1793951856.git.rakukuip@gmail.com>
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

From: Luxiao Xu <rakukuip@gmail.com>

Add a test case validating that bpf_user_ringbuf_drain() rejects an
advertised unread backlog that exceeds the ring buffer capacity.

A valid sample header is written to the ring buffer, but producer_pos
is advanced past consumer_pos by twice the ring size. Verify that the
kernel returns -EINVAL and drains 0 samples.

Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 .../selftests/bpf/prog_tests/user_ringbuf.c     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index 9fd3ae987321..b455e35d616b 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -280,6 +280,22 @@ static void test_user_ringbuf_post_larger_than_ringbuf_sz(void)
 	user_ringbuf_success__destroy(skel);
 }
 
+static void test_user_ringbuf_post_backlog_larger_than_ringbuf_sz(void)
+{
+	struct user_ringbuf_success *skel;
+	struct user_ring_buffer *ringbuf;
+	int err;
+	__u32 size = sizeof(struct sample);
+
+	err = load_skel_create_user_ringbuf(&skel, &ringbuf);
+	if (!ASSERT_OK(err, "oversized_backlog_skel"))
+		return;
+
+	manually_write_test_invalid_sample(skel, size, c_ringbuf_size * 2, -EINVAL);
+	user_ring_buffer__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
 static void test_user_ringbuf_basic(void)
 {
 	struct user_ringbuf_success *skel;
@@ -673,6 +689,7 @@ static struct {
 	SUCCESS_TEST(test_user_ringbuf_post_misaligned),
 	SUCCESS_TEST(test_user_ringbuf_post_producer_wrong_offset),
 	SUCCESS_TEST(test_user_ringbuf_post_larger_than_ringbuf_sz),
+	SUCCESS_TEST(test_user_ringbuf_post_backlog_larger_than_ringbuf_sz),
 	SUCCESS_TEST(test_user_ringbuf_basic),
 	SUCCESS_TEST(test_user_ringbuf_sample_full_ring_buffer),
 	SUCCESS_TEST(test_user_ringbuf_post_alignment_autoadjust),
-- 
2.43.0


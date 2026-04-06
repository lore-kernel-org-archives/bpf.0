Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037723845B3
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487954; cv=none; b=tsJaj3D+6hTeUlBF9bwLxXVCMtOrp+vZsuf/yMQxkF1VXblY3xzCaCfeaKjfsvaPO7P+Nxlo32O8wX2N/QZldc6SIrsld7kk5W+uNX8xqrtid7LN9dH1h2IgZdB9+H/tLEGsr/SKpWQNd75RfC1tHLVIJA5I/qPP5CLKEFQcZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487954; c=relaxed/simple;
	bh=iSVD7PqzH47lbzAcBg8vO+yCEjpD1L9OZkeYsOidZ3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KghBgCYryMePOUWJR8H/V/382IknTicsmKp090KbRO5can4YLMI2tOsvQUWftoVN0TlLlXlEMiHLLiWIlYpuEnNX53Bzn2RBL4ebt6LQMaZqN1g8+n9vxRRcJAOwcstLQU29sjcpD2qW/lSx9D7He4F/HdoeGaI/B9fuAe7Pe4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N55uCl7n; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N55uCl7n"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76af7b0f94so2587149a12.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775487952; x=1776092752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M41B8GcqNf/aH0au9990d0s6c7qR9UlLIn859WJCDxI=;
        b=N55uCl7n/OkN3OMgwnVFsVD3GWTEYW8IiVHLlTTqYW+Lf+8ORIOUz1Uktw6IGUNWW9
         KpTMJuztCVbTRTAPcRPnFBfu3+GFZRbSp4ZwHhCJQilEc5RaiFe0PYhSRu7A+H3CE9k/
         r8rtk9XHzFgcxst98LhR/fdNWAC2TKR9DUzPZpfataJHOnc38j+Jy840VZdW5PJkF7JS
         4e0+wiV1MfVtFt2HoFNEmN/EIUfa/bX+DRkuXvHMlQnp94f10EaEU1hT+oryp4ujpo6J
         xj5f37YDlYziqFMrfllYd47tIxfiyM63sHu2jugOkCYOWgLh1Ohbiri9rAYfrrW+PLL/
         eY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775487952; x=1776092752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M41B8GcqNf/aH0au9990d0s6c7qR9UlLIn859WJCDxI=;
        b=ODpMiVaBiuuYVkoVE0r+s0Vrt+Bu88ju/wP8Ibu8aZz4WUrS1WuJUSAzehMPpk+cU8
         tf7wPTnw8JPc5sTYKxNUgfthrVNk7htd9txlEaVkJEiKyEcniWvEFgLfqqd5ha6U5Fst
         lI/EgztnhfPy4/Kc9MqW1ZfC8G5h4cMOGAkYMX66hXafv8mmEiP9s7808lrfUyqzptTp
         wPAstcccMTWGH5Sr3nEBXpA1trW9RnNKnH0HcMVlanrw8mtcpGHZjjt9Bjy6dXtpsNWu
         BzRn0JNYOEEBtRpTJr1boaLQEBq7TBA38lSRE2Anp9sb+ukXK6X1sAaeqDX7GMBexWkS
         wBfw==
X-Gm-Message-State: AOJu0YwK1eFsWn/OlU3+nYmVuR7SVhqe50NhZtfvjpca2q2uXwbulACQ
	xgunmmtAHN6Y7+p98/9jaNjbpft0urZyAgE0DZRtnmkyaTJVN0k6zPslLzaRzg==
X-Gm-Gg: AeBDiessJt41ErBejMdN0jHDvIH8hHnhRDku7AstGZI02XJO2lsboTTHLdRM8PbmX8m
	7wBsdstar1G79gQ5bSrggqodmZr8mrwdsnmZ6iwvFdC8/LlTZOTqbcSnhh9/J2i9lohGnJHVuIC
	uI3TNaUvwC2lGukQecNHKjf1baN4uStiuFQ27NY0/3At3K34ypT3Y0jCtRDVkIiSk0yREU/6qrf
	IG3QHsRyrZ77ToVM4qsoMkL/aAZhF56hzeOru7TQwfN7L3CZV0IpD1B7O4NwY7uQ5zb+QOBgDAD
	gMavfwo2hKsLsGq93sIjgiqsiZ5Zrr9RJol2bCBXX6OU1X1YHKwzwYojzG7d3+ObeVXPhVllQx+
	0Xe+mpIFZE5D8ufzGXUMjkGKj1KSm9BoMwBhc3v8Puv73BAoOw0XziwE5jqoTzL4/Kar/bu2SNL
	UE9WPsYOraOBwfnA==
X-Received: by 2002:a05:6a00:18a3:b0:81f:31c3:2e34 with SMTP id d2e1a72fcca58-82d0da90bc1mr12815702b3a.25.1775487952016;
        Mon, 06 Apr 2026 08:05:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d12218738sm12157360b3a.21.2026.04.06.08.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 08:05:51 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	martin.lau@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Test overwriting referenced dynptr
Date: Mon,  6 Apr 2026 08:05:48 -0700
Message-ID: <20260406150548.1354271-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260406150548.1354271-1-ameryhung@gmail.com>
References: <20260406150548.1354271-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test overwriting referenced dynptr and clones to make sure it is only
allow when there is at least one other dynptr with the same ref_obj_id.
Also make sure slice is still invalidated after the dynptr's stack slot
is destroyed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 8f2ae9640886..b62773ce5219 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1993,3 +1993,118 @@ int test_dynptr_reg_type(void *ctx)
 	global_call_bpf_dynptr((const struct bpf_dynptr *)current);
 	return 0;
 }
+
+/* Overwriting a referenced dynptr is allowed if a clone still holds the ref */
+SEC("?raw_tp")
+__success
+int dynptr_overwrite_ref_with_clone(void *ctx)
+{
+	struct bpf_dynptr ptr, clone;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+
+	/* Overwrite the original - clone still holds the ref */
+	*(volatile __u8 *)&ptr = 0;
+
+	bpf_ringbuf_discard_dynptr(&clone, 0);
+
+	return 0;
+}
+
+/* Overwriting the last referenced dynptr should still be rejected */
+SEC("?raw_tp")
+__failure __msg("cannot overwrite referenced dynptr")
+int dynptr_overwrite_ref_last_clone(void *ctx)
+{
+	struct bpf_dynptr ptr, clone;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+
+	/* Overwrite the original - clone still holds the ref, OK */
+	*(volatile __u8 *)&ptr = 0;
+
+	/* Overwrite the last holder - this should fail */
+	*(volatile __u8 *)&clone = 0;
+
+	return 0;
+}
+
+/* Overwriting a clone should be allowed if the original still holds the ref */
+SEC("?raw_tp")
+__success
+int dynptr_overwrite_clone_with_original(void *ctx)
+{
+	struct bpf_dynptr ptr, clone;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+
+	/* Overwrite the clone - original still holds the ref */
+	*(volatile __u8 *)&clone = 0;
+
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+
+	return 0;
+}
+
+/* Data slices from the destroyed dynptr should be invalidated */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int dynptr_overwrite_ref_invalidate_slice(void *ctx)
+{
+	struct bpf_dynptr ptr, clone;
+	int *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	data = bpf_dynptr_data(&ptr, 0, sizeof(val));
+	if (!data)
+		return 0;
+
+	bpf_dynptr_clone(&ptr, &clone);
+
+	/* Overwrite the original - clone holds the ref */
+	*(volatile __u8 *)&ptr = 0;
+
+	/* data was from the original dynptr, should be invalid now */
+	*data = 123;
+
+	return 0;
+}
+
+/*
+ * Data slices from a dynptr clone should remain valid after
+ * overwriting the original dynptr
+ */
+SEC("?raw_tp")
+__success
+int dynptr_overwrite_ref_clone_slice_valid(void *ctx)
+{
+	struct bpf_dynptr ptr, clone;
+	int *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+
+	data = bpf_dynptr_data(&clone, 0, sizeof(val));
+	if (!data) {
+		bpf_ringbuf_discard_dynptr(&clone, 0);
+		return 0;
+	}
+
+	/* Overwrite the original - clone holds the ref */
+	*(volatile __u8 *)&ptr = 0;
+
+	/* data is from the clone, should still be valid */
+	*data = 123;
+
+	bpf_ringbuf_discard_dynptr(&clone, 0);
+
+	return 0;
+}
-- 
2.52.0


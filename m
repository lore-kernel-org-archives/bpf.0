Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A293B6C0C
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790550437; cv=none; b=Vra7NAEGTDtS0h7ZuchvtDeI0ijgk2EQoOh5TipHALuzM8PLP5QgqK+9m8CCnEPBTZUZ8W+wGkqDFc8Pp+0KrYgmVX34aJhfPMt0a5oiiSLXIdR0KhHj/89dATPDOGW6ImSftHcMBFBOZIDvZpfvgUNXP2OYAVCi1U6dhy/t14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790550437; c=relaxed/simple;
	bh=F9Sa7Q15VZJxKT3BZA0gOeZJQMHcfq0klY9AQGiGSOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dilfz1OudNoCuO5LUrkFBA2p4wfByLf3RD2q+AmEiT2iVYpJdsNgFzH8EhuUHvdwQcwYvhm1/Kcu2Aq5J5inrxDmzL/gVfwX6z+J/q3WD9zIVljQeK8rcN4YGd1owCCzoOqbRIujQM5oFBVhOL8qq3e1LQPbnG5YwjDZe4vBEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5mvhz4s; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5mvhz4s"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffed768deso4771635e9.1
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 16:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790550434; x=1791155234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/a+F39bGWb4OewkX5Hci6JgQLGfPvrvosBqj3gZjoyM=;
        b=q5mvhz4sY88KKx91DnEgAULZZt1vBzV/a9AyA0NnAQarsBrPOuffT+OlR9K8M02LtW
         B2yXi5a82kNnMiTFum85upIioSXCzVEfnuPWV2LCcmBfX/1rbzSCpX550fN/qcYyguVh
         jwbY39Yw+Wo0kLYRlq9xnV83a6aoeSHYDcLRXkdsCx2boT8wfW+KfEisnoILS1dAz7ey
         DUgxRJd8GJW/9mzy1mku14P6zG/2u4+jxjsNY8LjRkcOhM+naXLHnu2k/LZfKDZbh+d0
         xvFrEnLz0shSq+1eeCMBQ1kWx6J/Cu0WYTa92Rc4VRF/UJ2adi2oJqAam2nr+S/PllL4
         vIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790550434; x=1791155234;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/a+F39bGWb4OewkX5Hci6JgQLGfPvrvosBqj3gZjoyM=;
        b=ahF3AsuzjZw3E6lyjH0QOk3luVmKDq+LS0aAE6lo5sq8VCMwxPhGFZDVjyQMQP6Sjx
         8cRMpkx/QgcjIyqb9JfkWGwd8r3uM0QAcEFIYw1pflZv2PoV+SNrAmfIgPm/QOtaKHf0
         ZfT4c4l1hk6hQABMyTvRmGRtnX6VIlLauGdhk5y1F2fgcaL7ACpdQm9IaXRAt7RPgGZw
         AnLrkHh+70q5aZG1OGdClhBTV1QhlbaUNQdCb/sNTV8CcIZFFT7Op2Z5WXPlFlTdvZKa
         iGEl2FPH+b2BIscUbkFafYgMR+pmVb+Y4koYFUjMbIhMTd4S+6T3sr3rhWBCR6vsjmH8
         KcRQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8lflfqOAvtsnWKTh9aG9zfqC9nLFVxu/It3zGaUne9AeLlE69H5JLKisC04otTLBtafc=@vger.kernel.org
X-Gm-Message-State: AFuF++mtjUflzNScdEEkupC70LSBpIM+25/AtvtAISmxOMbZPnWPqiGx
	t0O2NT4KJUQsCxK2ej717I8sx44XAntUAJIxool0eSPTZbUE940jf2WF
X-Gm-Gg: AYBFou3Q5MXShA1aiRcdAAlB+Rw12+CN3GqI1Xb284IOQsSEKC+vaOxDw706leN6aUJ
	hGbLK3QWi1+qyYiZkmOOzvYu8DR9rUg6GxU0dOHMd2sp1iiwPDXfbhgwbPaNsHt/B8TmjVdwdtF
	05I2iGEDIPhD86jzpcSrFQYaZ3vwHC32mYvFloLtkutKoDpuI25MhDbAJl+ILtORoSpSy64u+Gg
	IrYbZ8KkreXiVHCsdysI4Dc0sJTlsL16ZLqqr7hSe8WiZ55hhoEnrNgqy/CSr+97K37WaVp/zgG
	t92dR8r9eTbIBf2e/JHWmZ9ogKLIAHF9Dsc/a4byuDcogiXRuAh9TCnbVacoFNUsvKnvKf4lWwi
	X+Cs5lJ2ZmFcy4u8ah5/JvymtCiTuNBH5m5MbeTlpAbFarjSu1eBlcf3RkFm6qWkDFzaukTt+M0
	ppjqg7zmvZR5ayBjlPRQEl/gUShZLQ6TRZdEhZN58QEzh8vecwUiLacgrcCgD2VtQKDkku
X-Received: by 2002:a05:600c:3148:b0:49f:fc4f:9efb with SMTP id 5b1f17b1804b1-49ffc4fa10bmr80800295e9.7.1790550434194;
        Sun, 27 Sep 2026 16:07:14 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017998dbsm134269715e9.14.2026.09.27.16.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:07:13 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH bpf-next] bpf: Skip redundant destroy_if_dynptr_stack_slot calls in check_stack_write_var_off
Date: Mon, 28 Sep 2026 02:04:28 +0300
Message-ID: <20260927230511.417420-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bpf_get_spi() maps 8 consecutive byte offsets to the same slot index.
When iterating over a variable-offset stack write range byte by byte,
destroy_if_dynptr_stack_slot() can be called up to 8 times for the same
slot, even though it operates per-slot.

Skip iterations where the slot index matches the previous byte's slot
index to avoid the redundant calls.

Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 kernel/bpf/verifier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fec5a1ae6a4d..0eeb498db9d3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3824,9 +3824,13 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		writing_zero = true;

 	for (i = min_off; i < max_off; i++) {
-		int spi;
+		int spi = bpf_get_spi(i);

-		spi = bpf_get_spi(i);
+		/* bpf_get_spi() maps 8 consecutive byte offsets to the same
+		 * slot index; skip redundant calls for the same slot.
+		 */
+		if (i != min_off && spi == bpf_get_spi(i - 1))
+			continue;
 		err = destroy_if_dynptr_stack_slot(env, state, spi);
 		if (err)
 			return err;
--
2.55.0


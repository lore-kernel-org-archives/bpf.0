Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D2397E85
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790552237; cv=none; b=KVMlLzaZKcSUIP+HXOf08skTXsjMxFpfccqCBnxeOUvflD1aL883q8WFyKvRAcwMFAqtFo+lOHnbv9eSJ0Sm9l1fShMlgW0POfMgig5brSUjxZ1UawstBKrrlS8fMUUugOubhJ+PBQD//N246fXu5Xu2czfhxy77oBtopiZxduU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790552237; c=relaxed/simple;
	bh=vMx2OEAWQB1yWyZ78d+EHmuyKxCDM2aewJvKv9yR0Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pxhmiv4bZumd0WdJaD7k/Dm3Yj2b7W7/F7LE1FM2OQ+l1peRD1sNfYZcOx4eFv6J7fWn8tJvp9oVNtISk2SF5gcFvbmXdQRDyCS5NcU+Cqw15rdT2auszHophT33yvFvCD5rNQRH7gSTPqyoapA6j7ypTay5btzHXmGaoDKSYyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhLXHVA0; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhLXHVA0"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so19870965e9.0
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 16:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790552234; x=1791157034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eeI+lVedHv94sduKpny4VEBPiP55GfeWt60bzHlR0o4=;
        b=RhLXHVA0T++C62hPZh+4Oi5oEkOYn8+Kv4cGKaHiFaM8imGcAzHRqQts/jyW8vCqqI
         AKyCkzrLs2q2VRtukZvTL4yZJIJyMRdodAedIqK6qzQIqV1ExAUMJaeJl68gxXi/oYQl
         MIbFdwk1uGzp+DtZ2gILMX31NRQ0bAQ76FpJtsCTbeNNlIZeH8KUTh8KJaPgKLtzZW+P
         F7QaJ66MkkibGG/BGjET3/3INANaxlZaCvdfdQ5z7ctYXhKI4rkXFXHvnNItDeyHbsV4
         emU87Hovfm/w0wHk/xYBPukdfKsyUk9DC35DOxRrLjWiC7U1GZcwcMZFASjbLcsIYolZ
         u8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790552234; x=1791157034;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eeI+lVedHv94sduKpny4VEBPiP55GfeWt60bzHlR0o4=;
        b=xYZZrwSx7BPmGi4w+PIhFCt/7jPlFdPOgK+R5CVLdEW/LsIzWkj9Ir447c6+qF0wsP
         ebrTp0nb7FD7O4Eskoyl1VZjm3po/3wjssmFBiynXiSSHERJu6qBiF9mDlRoNEjShr4b
         ffHY7vKXdiXdkm8qBj3bUjXHyKG6F/t8MSBgfjo8P8HbibXB1JyDSHhdzI1RhlddhZVx
         rJ+4VzDhKrC3CZP3Ec71ZIwBSzeFd4dWWUrRDiHgYzokoxaXOU1hspvaswVRNcYpgRmV
         OTQa7jIay098B1ftQqW4qSwIrPupmoxqxvewj7+FQ9O1lpeHqfFXCuFOKXjK63jNmis7
         BiNw==
X-Forwarded-Encrypted: i=1; AKwUvByhruH0fpDelR33J247BaOu8tW6Ruj0rZUMW7GSXQnGWlImkNGu/3FKvukTENjf99e7KwA=@vger.kernel.org
X-Gm-Message-State: AFuF++lFb01ZAFOB4iuMadybdb4BHjwHiqZV7pqe+1fB6MbwSmY5roTf
	4EYw1zviM6KAJPUbAP/tap1hqOnCzMe+lO6BPB4msFv7FaNGZO5Z5vp3
X-Gm-Gg: AYBFou2Qjj5phIRu5RoQztlc0iFCHVat1p0U6pt1eAVUSN4AtZmvL5yDSdzvuz01mbJ
	H0eAxd2srnJyMJ61B6xlF1whfcJuu5eaP8hATsBX2w0aqKSm64BwWem1HYRkvHg1qBD9de9GTSE
	zLe8Ot6A5zudwgX1KwYg4K6g4BM0DBagKGzxoYd965uj1I1yNWUBp9rsLYBC297jwdDQ60P63WP
	QzigTbLBYiaArV0MmILxwTs4F8+Uu7k0u7ydPzvlPXhpx8G/Cjt53MVmSYCRARsizbyoQu9a+Fp
	4AqelKEla7EXHJK8vGTE305eEndUaIRQTqkyxMfTgZH7W5p1A0ywi24RWFpqZKiWB2/30qbctrJ
	h0b38zPAcOAhaf7X9u+hF4mhz08Hy5iFJwQRAwPpEalUjOVBaL2viNfgQZuRqB175FO0o7EXJ4S
	03vAZ0M88BgWFRYFDDodHsKN/0z/FOzPedD+UN8ukb9MYUAmiu8ZXqyqJJdmUJ+Q5iUz2v
X-Received: by 2002:a05:600c:4505:b0:49f:f922:1dc1 with SMTP id 5b1f17b1804b1-49ff9221e35mr84930855e9.28.1790552234070;
        Sun, 27 Sep 2026 16:37:14 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ffabc3f33sm135335115e9.4.2026.09.27.16.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:37:12 -0700 (PDT)
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
Subject: [PATCH bpf-next v2] bpf: Skip redundant destroy_if_dynptr_stack_slot calls in check_stack_write_var_off
Date: Mon, 28 Sep 2026 02:35:59 +0300
Message-ID: <20260927233653.424163-1-omermetekaya0@gmail.com>
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
Changes in v2:
  - Fix multi-line comment style: move opening /* to its own line.
    Reported by Sashiko AI review.

 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fec5a1ae6a4d..6bc5bc56f0d3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3824,9 +3824,14 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		writing_zero = true;

 	for (i = min_off; i < max_off; i++) {
-		int spi;
+		int spi = bpf_get_spi(i);

-		spi = bpf_get_spi(i);
+		/*
+		 * bpf_get_spi() maps 8 consecutive byte offsets to the same
+		 * slot index; skip redundant calls for the same slot.
+		 */
+		if (i != min_off && spi == bpf_get_spi(i - 1))
+			continue;
 		err = destroy_if_dynptr_stack_slot(env, state, spi);
 		if (err)
 			return err;
--
2.55.0


Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC993F9F44
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145083; cv=none; b=LXiBKCQqH4JWIkgjXD3aSIovHebSiP3TpNq5nsCmnCFY1n+ZaBJT/3r5QCYfHIpnt7G7F26mW65jyd0ozhVWK1BM7esht0PZI2B0/67Qh0i/W07EbaNHw7kpMEC3SB69SBtK1KZG09gQAgbHUZ32Rmfvjk4tQQdWJ6vgQAZCnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145083; c=relaxed/simple;
	bh=yMpiKx3kguhJmc8qDGn1V3CoMpzc68Grv59UbQqZkL0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fFZg/kqw896CxeGht0CQk6rfh2VCkUSzQXPzQ306rMGRJmQPgtFK+/+cX7NmNpcn9s6lpeK5+5g3zurk1Pihnyhp2uNapFsTNU02nhcLkngl0RzrVjXs2TfWCUTlp63xahwogpeIn08lJsu1soXceuOoVhtkPjHwgBDR5KoQ6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxpHxazF; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxpHxazF"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d94f086fedso6239975ad.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790145077; x=1790749877; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tFs7REmvg7ALs7gDnIPL2Cm/x5EKpm+iCAcxe/e+E3M=;
        b=FxpHxazFm8D/CPAXV5DSHZoW+G0poMCEivZO3tIXv92LeWfvEvfuB2U8yNyWoEzEPG
         lNwmf7/LPBRcypLAD3FHrlFwqeGFTOusgZzeEM5tyUCxcAEsB6wMbpZTzFrXE1wXFVpf
         KHpD/wgsKjtiGKABseYf9aEaJRFpMUHx5XfYPFkQUZO6eJZfpUEPJOIXx1giRWZ2Pamj
         3hU3IGzGNs8A9WrxKzmi9QgO2Og9saYy0gBukEhgrXtr71pn+7vxjC8Zdiwy/luzg2v0
         vN68O9D5l3+9h1hvMl+XDfCMIRPfM4yfCrpw9K4klVjuOyngqhar66wM7YpBzXDIYaP0
         VF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790145077; x=1790749877;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tFs7REmvg7ALs7gDnIPL2Cm/x5EKpm+iCAcxe/e+E3M=;
        b=hFLaWDIzH+W7RHyJK0qU92L08HjUnujT8Ryt5dxM6h0n4veA7gddFiigWqAKADi+m2
         rCwTxo4UA2KQkmeMUkc3XQnZsSgVfLDVqP4GVZ/+qE2Al28XeoNy3TBIUbG106Au5K1i
         +hvLJIywItzIj1ZLz10SgdeSyGT9jUm+A9qnmgeThuPfutIVq0FiQH+BwNQBHhQJ/VON
         rih4iNe/cVzwq7f4yeejQ8WpcY3eXktKtK5kqou56KZrujHFyLFacIYEnKGCZu0PAXd6
         QFFxa30xXpDaLl8DIJZakL1aD1EhYw9D8T+9ybTywCS75yAmbADo0jlXFAwI0soS+BrT
         5Khw==
X-Forwarded-Encrypted: i=1; AKwUvBxeEZkmQk/5tEM7xNC+tIzJ4Ued+3pZ7dtnZZC6sylNHSwk0zkT++av2TL2Va5Ju/2oGM0=@vger.kernel.org
X-Gm-Message-State: AFuF++kX9Yn3nobbShSrFWvwc2gjYmsEsbrMcI/a59QFz0sI0KeQD/wU
	BzrtZ1dCX16aG96QvIgNuPv5c0jN7P9w+sCblrbvamnUqpW4Vs/TTP7fExT2K9qtEXDjAYkAA9H
	4
X-Received: from pleg9.prod.google.com ([2002:a17:902:e389:b0:2dd:26c1:6565])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d05:b0:2dd:319:c9ef
 with SMTP id d9443c01a7336-2df69d28094mr16150785ad.3.1790145077322; Tue, 22
 Sep 2026 23:31:17 -0700 (PDT)
Date: Wed, 23 Sep 2026 06:31:14 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923063114.2683575-1-morbo@google.com>
Subject: [PATCH] HID: bpf: add __counted_by_ptr attribute to device_data
From: Bill Wendling <morbo@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	bpf@vger.kernel.org, Bill Wendling <morbo@google.com>, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

The 'struct hid_bpf' contains a 'device_data' pointer field (of type
'u8 *') and an 'allocated_data' field (of type 'u32') that specifies the
size in bytes of the allocated memory for 'device_data'. Since
'device_data' is a pointer to 'u8' (elements of size 1 byte),
'allocated_data' represents the exact count of elements allocated for
'device_data'.

Annotate the 'device_data' field of 'struct hid_bpf' with the
'__counted_by_ptr' attribute, pointing to 'allocated_data'. This enables
bounds-checking sanitizers (like KASAN and UBSAN) to detect
out-of-bounds accesses to 'device_data'.

Because the count 'allocated_data' is always set before any access and
accurately tracks the allocated buffer size at all times, adding
'__counted_by_ptr' will not cause runtime panics or false-positive
bounds checks.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/hid_bpf.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 19fffa4574a4..f45fb9cccece 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -185,10 +185,12 @@ struct hid_bpf_ops {
 
 /* stored in each device */
 struct hid_bpf {
-	u8 *device_data;		/* allocated when a bpf program of type
-					 * SEC(f.../hid_bpf_device_event) has been attached
-					 * to this HID device
-					 */
+	/*
+	 * allocated when a bpf program of type
+	 * SEC(f.../hid_bpf_device_event) has been attached
+	 * to this HID device
+	 */
+	u8 *device_data __counted_by_ptr(allocated_data);
 	u32 allocated_data;
 	bool destroyed;			/* prevents the assignment of any progs */
 
-- 
2.55.0.1082.g2b9226bbc0-goog


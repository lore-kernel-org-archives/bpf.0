Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DCB3FF883
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659051; cv=none; b=keG8pZpDjuaIkp7jmms1Fgu+G9X4ULSadhsJ9tDf/wzT+Y1N+D+DX+AqPvb9NEJy61fwaP/xrZkkn04o00I/xD0nbetUQ7nrRt8cco3+96L0LBl/lF0QTibfkm6wR83yLRUjv3NfsfI8GwczUn5FF7ZnHtsGLgzrANVhvKjv6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659051; c=relaxed/simple;
	bh=j5Afy2as19W32q8jX2j1wSb9qr7wYiWdDuuQVS6+rk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBF+VhLu9brO7g3vhYEnWor43r6mNJ+//DNn6dx8YyHPMO24YqK4pgqnGBJKWCMz/4UvB/T9TvzizNt15J4R5vTu8ywj1S3sEqX71uUcaYUCWiLMv3OWuXA1fMdt1sbi/pHwb+exIT35mttaI5kuRfew8wNRhxLkGSRB9ViS+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg+hYwSs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg+hYwSs"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ceaf8a1265so52563435ad.2
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787659049; x=1788263849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j5Afy2as19W32q8jX2j1wSb9qr7wYiWdDuuQVS6+rk0=;
        b=gg+hYwSse9dpgs0gwzrhf4pUvobe+L2iPwAjEAG01IyUEXU2k7/JFEdBtjh0qWDMo3
         Baw7pyZ0GMl4Lfa5buRouGxSekdt+UO+7GdhxJ9PQzusxyg+Fx19mhNqMsNVpkiU45I7
         uJMo+HSm/VXsl6QuFs30xu7Bnq3g+VN/uDDMVF4RFjf5WzDlsmJr44/HT9EFfLpy1bOq
         qnAsakVHMYaLA4Wc3GxOBphXyeqTmXpoxESg2rMLximZKsKKX102s6bm4ztEAQ1RWf6O
         CzcYL1J019rZaR4mHNQTpdXdfyCZgJiZqPgUR1IiLxn90J+wPY9cRKtM2oTpZJrUdmg3
         B7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787659049; x=1788263849;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5Afy2as19W32q8jX2j1wSb9qr7wYiWdDuuQVS6+rk0=;
        b=BGepE51g6suS6oetqxOshmDwD+gAzrP1KgkyUGmDCYJD6kSk6M5rYproqp5wUEEc/A
         Qsly7E1N6fQP9d9LMXH2jdn7hG8dsp54ALv9GfkCRexxBosoSInbi/QOo8rcYojrLJd9
         IF18mtd9ht7Wo8plMpL/7fuP9hpqvlxjEQgsXCfU51GX+TDybTbx1K3dEMK3VfTgx67E
         383gj2Aizi2KEHVtbCzdrCOFBIud5HCD7UiwvpTgZebWBIkFWPfTcRMiyGLMNNaVPUff
         HgrxHLlesYLj96rZSuPJykgUCi3r9C0qj2cVp5GAhKc9QgH5j0TYSZRdosafFb6lWgZ/
         cQ1g==
X-Gm-Message-State: AFuF++mSo7y6Dn28nY1YUAr5VG6qGGXcUAHGKQHCaGMgxYbo0l1ecSiw
	ZurrcPV3wwQtgT0Jd/n+G1u1GN9r/Xwe8oEDzqxFCVoWAgTXv1nR+pR5
X-Gm-Gg: AR+sD11eZMhdY25IEopZS7CWaMHuo9tTSRQzaXhiZh+ab6cB70dEEhQ8h+foSg8Qo5D
	MZh+FRKrCc+VLT37Ks5QVtCnfneU22TWYwFpK5UONIKasBt6gwzRyITMfKyT6NThgY6HEX0+MJL
	5dFKGtDrGr8ofJzruDXSl5XNK/3Thy2ib4HMaRYbpWizIH0iu7cJYea1uNFBwoMn90T1IFSu+WR
	AWGbZt0ACU2HFsMutaviBYdQIbl8N44F84RxdNFTJcpd+57HDSqNsYFCfagYvj1Ap+/C/ZWYydZ
	km4M84k4l9uwbAPaaGs4fAX2iKUhDbOycQTK38EtVd3r2M36+z10hmyAenCGPSJK8UOEhibGipW
	rsKTgzbMrVicRRJVsx8GjyKj0oxS3eCJa02uXPxAWgGN4oRD1TKJJr6NbDUkNPs0DwKu+KF9qj0
	qBI4hGOXAmQRJJFZPJRorrn+gIApgS7oxisALuZK7W0zkfH/PZOobNumNbgV8vyxVRTpJve1JKC
	jI4J/Ozq2J4CTUCqpO/4A9q
X-Received: by 2002:a17:90b:520c:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-395c3867ac5mr65374029a91.14.1787659049210;
        Tue, 25 Aug 2026 04:57:29 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d37cesm41861522eec.15.2026.08.25.04.57.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 04:57:28 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: Re: [PATCH bpf-next] bpf: Fix stream capacity leak and spurious -ENOSPC in bpf_stream_stage_commit
Date: Tue, 25 Aug 2026 17:27:21 +0530
Message-ID: <20260825115722.85375-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825113948.85020-1-ahemadkhawar123@gmail.com>
References: <20260825113948.85020-1-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sashiko reviewer,

Thanks for the thoughtful analysis. Addressing both points:

1. Regarding 0-byte elements (Low):
A 0-byte element in BPF streams carries no payload and no delimiter
(unlike NUL-terminated strings in userspace, streams are raw byte logs).
When bpf_stream_read() encounters a 0-byte element, min(0, rem_len) is 0,
copy_to_user() copies 0 bytes, and the element is immediately popped and
freed. Staging and committing a purely 0-byte stage transfers zero bytes
of data to readers; returning early when ss->len == 0 safely avoids
unnecessary atomic operations and lock contention on stream->log.

2. Regarding the rollback path and commit description (Medium):
In normal sequential execution, ss->len > 0 implies ss->log is non-empty
because ss->len is only incremented upon successful element enqueue.
The if (!list) rollback check is defensive programming: in the unpatched
code, if list was NULL, the function returned 0 without considering any
capacity consumed. Adding bpf_stream_release_capacity() ensures that even
under abnormal or future decoupled states, capacity accounting remains
strictly symmetric with queue state.

The primary immediate functional fix is preventing spurious -ENOSPC:
when stream->capacity is at BPF_STREAM_MAX_CAPACITY, calling
bpf_stream_consume_capacity(stream, 0) returned -ENOSPC due to the
atomic_read(&stream->capacity) >= BPF_STREAM_MAX_CAPACITY check,
incorrectly failing zero-byte stage commits.

Thanks,
Khawar Ahemad <ahemadkhawar123@gmail.com>

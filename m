Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795072776;
	b=Mko5EbEHjSvSMNDxyAhbzqQ4xVKeMcFJhs21ty8ktp69l/f14sVsyEeXI8MkUIMkJICk
	 qbLLV87Vj4gLyd7OsIbvMJTnPBaUDayX4MRfuoIRR9bG7QpCZkiofh9Dd/+uy0tW7hi66
	 xodPNAEG9p7NGV3GyG0xmxuJK8eN1IvWklOm3+8SUGvGutlApGAxLYqjrg3AJAd9SHrVV
	 a4r9KE3R49PShXLtCyuXvhSBIcnxd+LUSZWf8/YElf09A7NGzcsz2j+sP5Wr3Om0a/7hp
	 Ahp+AmK4v2l/JtmO9yfj8uMPhhu+MRFEyu7f7x+myp22vYsDZDD8fXNQ3Pc0ZPx7gfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=anpfjOBmsHIUC3TQqXl6CPDDEhejvdqvM3KrtY3UP0Q=;
	b=g1H5odBIzwNxGrCOMl1lp194jwpydzUbmlx3dNsnPXTGxdUyKCqNSGJNcxfGCBm8hNdH
	 Z1axnZO/KR6qlEatWNsPuC8gFdQt06b0eunJwXXdFNqTmiySS7YimtYUk9VhUhQLbSfot
	 LmOYIwlJYag3GI+uThzPpIWO0X4HIh898TSqn/WQnMe42A4Y8TNeBmqyGJaxzT+lkksOx
	 esJhrT3So8TL9NkB3VJIldtXW+j9NLvJ4i926RFHZUYkGYHSDM2wgL/eKZkrYRxPNZQkq
	 f23zYPIf2HzcfWgERY6v8lKk9kzEBZYadYbXEzkfTsjVDxVL4O6hO+QHb4GBkU04CcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipgbtKzO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B760A2600
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 07:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D8B760A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipgbtKzO
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91f23ddf32fso13774506d6.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 23:19:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795072775; cv=none;
        d=google.com; s=arc-20260327;
        b=rZ8eNaH+A22If/Gob5Flb/5HG0b/Ck6Ii5EmghFyz1vhKg51F+Z1ShSXus0rHd4HMe
         Y6wPbldOuvNIIXAWD2tX1izTmMI57LBjTIrJWLHm0OVzYXUojOu0IQKGRhqIkGUeX5wb
         LZhsjOWe3nb0WeFWnFK2vowJOwAWYj1fN8b79sMmFDInwXnVFiemEAPMCc8/BXAdI99Y
         L6TrTbXsJEes7Srdt7bVZTVgD+WVRzl8SRGehy8+kz/tetgNXqqwvnAFWhRsiwF+CE1d
         OCaZ/kdXcj6m3TxaHlROd3zzRgsPm4+h2JKMnGfZurg7L/umJfmfnamNywhxv9KXx+ch
         LtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=anpfjOBmsHIUC3TQqXl6CPDDEhejvdqvM3KrtY3UP0Q=;
        fh=wpbWIcxy2QFtFMZOX1xpbfjPDSb3W3lPwW4GdF3gSMA=;
        b=Hnvjt2uFjxkt9paNHlUX9RngwqnZ6btLkpxdX9g27k8qnXsV+vRV+4DuMgpiIyi7iD
         69e+uqgK3cGstcEgLtfQR6olxafsbq/XGsf9rw0b92wc+2+M0TmxXgQo8E271LCdYsin
         vClhZL03Ra9qMOpMlffVdjZHXaS3YyqD9obNKDnCcamXqec9VQGnOiWbcQRp6t8lWMDw
         mz83S2ymmGcbuJ5hnODMneAbxaW3SLG/5MzufnvwKTaG+NDwyd4Y4txQvLToVvVRx0kd
         tonEhEamjRVGY/nzeFYy1HqIxYZK8QS2M4BUKfxr+VUG71Uq/Dh6+NJi495ltlFO0hD5
         jXMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072775; x=1795677575; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=anpfjOBmsHIUC3TQqXl6CPDDEhejvdqvM3KrtY3UP0Q=;
        b=ipgbtKzO47kTqztaxtvQrPaEEJkMqagfg4PklqZem6C5iY8BSrJ1dqhz+10BPSuIoC
         cSZWcWhzzPX8z6eZGM7m4yZ3Foh0d6BcV3IKA74DloeR4YoLXUDaCrV5zP9Wba+hntww
         CP5YsvJMuKXaNeue5C3tkzE8PtSLDRxoENoJXzB9nm9wT7N3FS5PD2eXX55BdR7ShxO5
         dtWLJLhIeZppiht6yOQwd9ySj7byEXFmAJPJYaPsd3/qMm8k/MxhKeI8GNmGaKBHT/Ze
         kIdRNNEpVwRBA1IvUYjU1u4uAuZnf4puMJwAfuZ+kt+p2wPzHbs5cpPKg/Nmk9Ms5pLH
         NIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072775; x=1795677575;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=anpfjOBmsHIUC3TQqXl6CPDDEhejvdqvM3KrtY3UP0Q=;
        b=wP8+H5G8bMG6cyNM5NCq4+fuVNufOJn1RtxDstYjTk+vqgmRKwV6H5rmZeReBOYYkF
         ZQ6JP87xiSkTpPcj4or4Y1n/yk0tDTZLFzJgAQ+n6lXsFhwrFelS4phGJ/+Gzs+On2gG
         Jl5GpqKdqAB9evUzelRyaogXlZV/pM8jlQU1NMRHMhdWQs0K5eXVAbxpRU59nOvFJOp9
         jnuc92A80tU3FKEvsDZzTOdz4mrCFSOeTidSj0Xaha9cRuUhMg7rTuWhj0wtVPdGsjxK
         LUTWzpgP2XjHS/jP+di2CAexbSH4isVcvSH1Nbvc3YI8Ex7zDhvkVrHRKYISSXDVPLuI
         vyDQ==
X-Gm-Message-State: APuU4Z9Be5MNFGM3yVv73mbppK845bdoMmj3p47M09J6l3x7lX5pmQ+4
	sh5kecwtBE+KamemDVidGLmzz2sUdg85qpNmKK3+YHeZelMPO5IF96Dd7w9QlFqogsAaCoAKb8h
	mLoPNzDcXIeKBwgwmDBV9lpFTM4hl1C7Db+Jd2Tu4guI7
X-Gm-Gg: AZFdTZdVuwA4Xc3Fpr9cibFqem79HYy1w9tm2NWqtfyy3wDkuzybcBY89Gx0m1AbeiP
	rXlPq5vva3w5EB3z9/5hwfKEOZbJD8xPBzhjpkVfGIJ+W+QGKqGYj92KwAajzD0V9hjvQENVKcN
	3eNrRjO56loKzKd/o+iCZBx7SCk0Gzf2vIh489Vm87hOxTxmfeeFhTC2Y/10iRuQ4XwDOCzZuT2
	EHizvnL745lSLeDDN97Rm5bV1Loe+SeloFZNdoP3Pbp3WcyEW/1femneXnSwexxCE4mcoYTwD5w
	owfMEexS3zOKJECTtm1hBnjSr2VfIY6p4V6YA2Bqctg9M7arXbECWwns8f82rVPEVZcEcWWf/BY
	4ITWYIHlwR8rdXNlTtCDoalOC19HIl+u1NqyZX2U09DgPawbqlCgdIk3jOwL0sBsayQjqN/J3h5
	eubANIrwyceDwm2uLEVA==
X-Received: by 2002:a05:6214:4784:b0:921:1cc7:80c with SMTP id
 6a1803df08f44-9211cc71c9emr52693146d6.34.1795072775342; Wed, 18 Nov 2026
 23:19:35 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 02:19:24 -0500
X-Gm-Features: Aa3M54qXFrwgtFLlrgRKJFJJgccYJHjtkJLvYiWNUjzb-GPFdVBg-cmr6Ghvh1E
Message-ID: <CAMcAce_827HxqEcwcN9Pp9n1J_vRb15qGaKC-U+ERtQgoKn2Ow@mail.gmail.com>
Subject: [PATCH bpf v2 3/3] bpf: Add missing raw_tp_null_args entries for fs tracepoints
To: bpf@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Multiple VFS and filesystem tracepoints pass NULL pointer arguments
under valid error or uninitialized conditions:

  1. fsnotify_destroy_event (fs/notify/notification.c:82) passes NULL for
     arg 1 (struct fsnotify_group *group) during queue cleanup.
  2. vfs_open (fs/open.c:1012) passes NULL for arg 2 (const struct path *path)
     when opening anonymous files or unnamed sockets.

Add raw_tp_null_args[] entries to enforce null checks on raw tracepoint
BPF programs attaching to these hooks. Verified on x86_64 7.4.0-rc3 and
6.12.118 LTS.

Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
v1 -> v2:
  - Correct sender identity and Signed-off-by with real legal name per DCO.
  - Remove drafting notes.
  - No functional code changes.

 kernel/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c345678..d456789 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6604,6 +6604,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "sunrpc_task_run_action", 0x20 },
  { "bcache_journal_entry_close", 0x20 },
  { "bch2_journal_entry_close", 0x20 },
+ { "fsnotify_destroy_event", 0x20 },
+ { "vfs_open", 0x200 },
  { "fsnotify_bump_event_seq", 0x20 },
  { "nfs4_cb_getattr", 0x200 },
  { "nfs4_cb_recall", 0x200 },
-- 
2.43.0

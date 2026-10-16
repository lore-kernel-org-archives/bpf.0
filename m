Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329BA26299
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110866; cv=none; b=cMGKz78vBgmiXByYRw+eTaIiyTkGfer6CROAxfn8Hf+xGzXqlZ2zS+kJnxmXvwoZmDqSD7EKpY5HC6WVi4UzGbHGKD9vjjAh2izVY+NA90/A50b+XWf8BDe4IHnNv6O0yj60PpblwfYHR61T+kJDS9L+NZbFrKbd4za5McZwLLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110866; c=relaxed/simple;
	bh=dWUTo2n72i8a4kUxv+Yn3ug90GBl82qfhnZXKOVF2Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/mw5vF6o/EbkZDBKI+6296RzSulnXhbzPEPM0sXWd1ZAmebXuuin9CjQnctJImfhmUnlcpCJ6alunOgAJIyHc8B+ZMxcC24Uyf4Jmx8qpXFLYhBP/fOOIqE/XwemTAQiNEZmRAwJIcR8/kNP2dEnPXaEtkvhSPHp411mhOAN9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTl6TUJe; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTl6TUJe"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ac525c1f05so29076967b3.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792110864; x=1792715664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=naVPTdLBkGW0uis0AnktX+NhPTF71p9vdwxuj5+66Gs=;
        b=YTl6TUJeJJ2Sm1ndSjgMnjqpkZOgvWOIrGoKJ9vMWyJGxa4YQZIyjvwwlrcT9a6jRm
         vD0DbeKce4lUbs4OMKJ8jhjFwCSLzMMo9FtHea0Cc+xvX1kLBBIshp3kK/ezsmjWES2+
         FFLlEuN60u3xuN4R3ih9+Ir6L+xVldtteU/gZVocYnweJGl9H5dew7SBnU4eqY7dG9h6
         7B/S1JF/fmiDb2aDaCnU6Dy5PDoHMN3A3t6lHh7T5hL8xZIQTIWzSD3PpuvtobHKEkRw
         TOSVWC8ro+G4IMM/ZR11SjlXW/kj70EBqT+JUcn6ja9aH37wJoKDsrMIhZzCi0DbIrcf
         81ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792110864; x=1792715664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=naVPTdLBkGW0uis0AnktX+NhPTF71p9vdwxuj5+66Gs=;
        b=jz5oKY8O/BTtlvBLqkb3wGpOuf+adfEHZT7q79f34IycZYhZwQ6MrWXXyWEy+toB7t
         XFaBcMGGdoqjEWFiqDSnZT49Sbr3xkHqIT2u5oNhmjdvLJqZ0v8r9oIBi2F8iOtwc6Ld
         5GLvNNFiaDDQgYmRzbOJKArieHRnhMgfqNJIWB0GiQULq+BtBqs6R4jrvLMlxqybv/IK
         G9ECDpyuNk3UdToY/nW6H5UHxiScqV/r+WsDEQz8u4t3e9Ebb9ijNv0YmR7epRCLntTF
         px5XroTucNV+KQnTaRcc6vYof4tZnrExx7RSGuvswHd7CtLfARobLR5ZSEe+DvFc87Tk
         5Ajg==
X-Gm-Message-State: AFq9FYI9mzydyAqS5gxUCJuRHOnZA60Lj4TanVIQSgyDMU35tK/LzIBD
	MxI5s6ZB+Z+EnMEpaon7obFr+n8s/NqUA+btCPDbknBicEq/+lFcOyUi4zmuF/ZSR3Y=
X-Gm-Gg: AYBFou3S4ZmHJi9HdZqBrxP1udiYsnrKzEN+Jie/g+8+OAM2wOfp3smEyVZM8jbZyqT
	pa9QWrAjY9AlD4FdNuQetzDaS5c8yzseKIkBEc1p0kV4w2Y5ARINSu8KpyuDoCEleplcvtIa4v4
	QFmu821l5byPHh6wn9z+VasnWigRD5WSTh49jtu+a6wLl9R4mKkJxGYXKooRNulUQPyUKlYLozM
	P7OfHXzbvlkFFDebVHvV/fIzakt8fnyTz+A8Jam6qaV56aZUxmBvXOsDIzKx7AYNEyhwg57OPjG
	8p7fh0XeDCas72jAbjXc9HsfKm/nH9XdtGX2ebYYfZO0NKQ80mqIDTXHhosOvOO+ctu7ECSSJV8
	yoGfsOVZCtCyOfL7RGxkaB2kvepZL/kKz9WyduJYmZyvClF3LF+DKI6S+x+te/7PaUKQv66IdfO
	I+fm/JgP1GQQVLtfQUEK4Hi+FMYvB7hbmE0jbRKuoI2zU/GWBkP3s=
X-Received: by 2002:a05:690c:fd4:b0:8b0:e385:edc3 with SMTP id 00721157ae682-8b0e385f62amr6595847b3.33.1792110863971;
        Thu, 15 Oct 2026 17:34:23 -0700 (PDT)
Received: from corey ([2600:1702:5081:b900::49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e58892cfsm2982937b3.10.2026.10.15.17.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 17:34:23 -0700 (PDT)
From: Igor Malovitsa <igor.malovitsa@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	Igor Malovitsa <igor.malovitsa@gmail.com>
Subject: [PATCH bpf 1/2] bpf: Load ringbuf consumer_pos under the spinlock
Date: Fri, 16 Oct 2026 00:33:17 +0000
Message-ID: <20261016003318.529860-2-igor.malovitsa@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016003318.529860-1-igor.malovitsa@gmail.com>
References: <20261016003318.529860-1-igor.malovitsa@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__bpf_ringbuf_reserve() loads consumer_pos before taking the spinlock.
Nothing bounds how stale that value is when the lock is finally taken:
other producers may have reserved, and the consumer consumed, any
amount of data meanwhile. bpf_ringbuf_has_space() compares
new_prod_pos - cons_pos as unsigned long, so on 32-bit, once positions
wrap, a value close to 2^32 bytes stale passes the check and the new
record is written over records the consumer has not read yet.

Load consumer_pos after taking the lock. producer_pos cannot move while
the lock is held and the consumer never passes producer_pos, so the
value is less than a ring behind and the difference is exact.

This needs a reservation to stall for about 4 GiB of traffic on a
32-bit kernel; it was found with a formal model of the protocol,
and reproduced using late_initcall.

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Assisted-by: LLM
Signed-off-by: Igor Malovitsa <igor.malovitsa@gmail.com>
---
 kernel/bpf/ringbuf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 3f1013d80544..6b86c4db5108 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -473,11 +473,12 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	if (len > ringbuf_total_data_sz(rb))
 		return NULL;
 
-	cons_pos = smp_load_acquire(&rb->consumer_pos);
-
 	if (raw_res_spin_lock_irqsave(&rb->spinlock, flags))
 		return NULL;
 
+	/* Under the lock, so at most one ring behind producer_pos. */
+	cons_pos = smp_load_acquire(&rb->consumer_pos);
+
 	pend_pos = rb->pending_pos;
 	prod_pos = rb->producer_pos;
 	new_prod_pos = prod_pos + len;
-- 
2.53.0


Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B53DA7DD
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962395; cv=none; b=p/s03NJlzIxgmbx5X+fgOA+ZZNNiflTfZDfFUdWyKD8GEgWvzAzeYwcg5uOfzkAD5H76y5tsHq/aZ7/UALVZOsbZuxYNiYqvVJxfd+T0W5rSQjOZs2cXmoJeKjh4AWnBjUiMN8Kd2rhtD3x2MboL8HAeCpHEEhbGx/cjOES6jns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962395; c=relaxed/simple;
	bh=dxvcoat3Wwn+n7RIFNKfzl5LtsC2cR8AgDCXFtfrnio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nq8mEAXn2tXWrN9fWqAQTBw6aB63odkpr/8390o+Qc40ntY/Ns+c2Z9lJzPwO9IHwbKfNhyO235pkRZvUiNK4UJ6z0//HCmgMQFtZKwnyv8VvSkze0sXsZYMRFMSX/v3TP/sR77mnbO9QVyyYo3Iwdi/U8V/5eQrCuBCIoPSCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOz9A9Y1; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOz9A9Y1"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ba895adfeaso6044078eec.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 06:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774962393; x=1775567193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/9fLtMz+TQLzN6OE9LOc/96sQri5JH1KB1bq/AzFpQ=;
        b=XOz9A9Y1dr+91KenHUr6Ik/cmHjPDxosbVJxYjmPkgG03t7EEECGK0JleKpBUeiUQJ
         +KY90T6gee82pZV9XmOumT+1jbGeCYCZN6FDeGjOh5g8kRWQIouzyGtYrRd3J0aA3Peq
         Vx46TUIFr3d534Xa8TLFuRyXJ9QVHTaX2WrgltxYqXOw9P0tTVF0JpDNYH4y0OVQ6Cr7
         x3k8xQH8chDzJJcGqD9tVkqEyv34514WfHHf8i7tJZ8/pSdEoQbH7H6AZnElLlGP9hqO
         jyRHPmCJ536bq0SZh31UyhUuw7KGH9BJPX7N5gFriskyzCMc3ATYZQwWh1rBXAUE4p1Z
         F7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774962393; x=1775567193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/9fLtMz+TQLzN6OE9LOc/96sQri5JH1KB1bq/AzFpQ=;
        b=ooh5gBtty6JVi86HhBI7t6+wqTPnTvERaHJlMlhU+6zexOO93uQ4aOHWYldQIp6D3Y
         cfxHmcBERJHP1PsY2+1Oi3FdPYfn38rSFOYJVNhORBKiDVeAjThKC3/U245/rKf4ANkT
         JzvVks/xrgWGT5Cq9KnoiTcRkNncZEAtO12SbIvunDDNgHBpgQM7oM4JGFXuK6kxUaus
         ye8d6h9CL7X9DDn0HbxdGtIYazyprcEqhDomU9+vg5J6TCwe04HuiyRk1UrIio3Z56uY
         /+zyIQf3bB1qRv5BSIAx15HyyrE9CPuYjrIrwrCcE4A95yXStx3UaU9BP0oDBPoElRp8
         9d/A==
X-Gm-Message-State: AOJu0YyhlNxQJ3MHrYCIWrbvN2OrqPOcQ5dD37XUYTpgMxV6tx6vS8pz
	07Grq6KWMuOcD92/HmhgV9Vwz8lobQOFKJVeo0dM+W8XgeWRvGo/079l
X-Gm-Gg: ATEYQzw0zP4+/kFT4E5UlkDpIInBiGv0yphOstrm1sj+ia9gITDviaTzYtOd+Z83Gh3
	cisf/H2iWw8nWzIXYH+z7/aVaxAmPR/tuOvp8TveCUtfv6EzVyyYCV6fCYxmgOeE5AhL62+fyyP
	f/VyvDOggemKqlD+ublWsZzD/EWfGO5rBe1XvYc0u2KihBWLIVQh+fsp7tN5gsSH+gadgkKXw0w
	yu2mFfWJP0HOiEd1v1LjKmMfkg3v8N8qhtHifQcO1ABp6BKl98ToFAMOFhlA188JCAsCv4LcLVq
	o2wUXjR0JdrmQEPcwcinekJ8IrzuTC4C4sl8GXIg4g9jAs+vQfQZLEHfexJ8GmlWVf3/eg6Gdjp
	Zo810hFUL5+//E7JurdjzHrgIcXQ1Qb3dq5HuG1eZbVVwNhPka9FXmt+ck7edP92rqgkoe/Nqh6
	TFeAU68oZTgG3U86iuhwY=
X-Received: by 2002:a05:7300:8c28:b0:2c0:c767:b65 with SMTP id 5a478bee46e88-2c185d20cb8mr9764817eec.15.1774962392970;
        Tue, 31 Mar 2026 06:06:32 -0700 (PDT)
Received: from animal.. ([104.35.26.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c811186f5csm1700247eec.23.2026.03.31.06.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:06:32 -0700 (PDT)
From: Eyal Birger <eyal.birger@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	paul.chaignon@gmail.com,
	chen.dylane@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	yatsenko@meta.com,
	ameryhung@gmail.com,
	tklauser@distanz.ch,
	shmulik.ladkani@gmail.com,
	puranjay@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH bpf-next,v2] bpf: clarify BPF_RB_NO_WAKEUP behavior for bpf_ringbuf_discard()
Date: Tue, 31 Mar 2026 06:06:12 -0700
Message-ID: <20260331130612.3762433-1-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clarify bpf_ringbuf_discard() documentation for BPF_RB_NO_WAKEUP.

Discarded ring buffer records are still left in the ring buffer and are
only skipped when user space consumes them. This can matter when
BPF_RB_NO_WAKEUP is used: a later submit relying on adaptive wakeup
might not wake the consumer, because the discarded record still needs to
be consumed first.

Scenario:

epoll_wait(rb_fd);                     // blocks

rec = bpf_ringbuf_reserve(&rb, ...);
bpf_ringbuf_discard(rec, BPF_RB_NO_WAKEUP);

rec = bpf_ringbuf_reserve(&rb, ...);
bpf_ringbuf_submit(rec, 0);           // valid record, but no wakeup

Document this in bpf_ringbuf_discard() to make the interaction between
discarded records, user-space consumption, and adaptive wakeups explicit.

Reported-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

----

v2: adapt wording per feedback from Andrii.
---
 include/uapi/linux/bpf.h       | 4 +++-
 tools/include/uapi/linux/bpf.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8d400b7680a..552bc5d9afbd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4645,7 +4645,9 @@ union bpf_attr {
  * 	Description
  * 		Discard reserved ring buffer sample, pointed to by *data*.
  * 		If **BPF_RB_NO_WAKEUP** is specified in *flags*, no notification
- * 		of new data availability is sent.
+ * 		of new data availability is sent. Discarded records remain in
+ * 		the ring buffer until consumed by user space, so a later submit
+ * 		using adaptive wakeup might not wake up the consumer.
  * 		If **BPF_RB_FORCE_WAKEUP** is specified in *flags*, notification
  * 		of new data availability is sent unconditionally.
  * 		If **0** is specified in *flags*, an adaptive notification
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5e38b4887de6..677be9a47347 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4645,7 +4645,9 @@ union bpf_attr {
  * 	Description
  * 		Discard reserved ring buffer sample, pointed to by *data*.
  * 		If **BPF_RB_NO_WAKEUP** is specified in *flags*, no notification
- * 		of new data availability is sent.
+ * 		of new data availability is sent. Discarded records remain in
+ * 		the ring buffer until consumed by user space, so a later submit
+ * 		using adaptive wakeup might not wake up the consumer.
  * 		If **BPF_RB_FORCE_WAKEUP** is specified in *flags*, notification
  * 		of new data availability is sent unconditionally.
  * 		If **0** is specified in *flags*, an adaptive notification
-- 
2.43.0


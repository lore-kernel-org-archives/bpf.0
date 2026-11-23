Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468428;
	b=BDWSRCDWka+j4cKaIpgngWCN3JC7YKFVmVCdWv34+eF6+bfQLMDdBTbCsbFazQn3/Cls
	 QM19Z39PA6VE9tf1kLdQNQHIJL+GUmhnfakAcfBEL+G3F8rpMjTIsWWp1ZXRh+qBqHbkt
	 2CPpbJTJhFKAlpOonQC06c1/e1ZZSRQpW9+vJj2grO8G8fTTZo0/A1TT6wNQTqGoDvEbv
	 8s9gi/08zwpqmO4sy7ZppX3UOku4IV/ugKim4RiCx6xR6RM6o5U3OfH+HjCp8yytSsrlA
	 qe2BcMCLM8y7grlmX1/XR9w+zpAmNPt4Bx0oFkxPrg5Iv2xS8LqZFnNU+2EI5ehoSOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=gSGAJaqvsTNHXVHAOnsjRO6dcAnOkcqwflrmLLnTBSg=;
	b=oev3rSuI8wiCpWTniXom5r4uB1P+GBjzR/hQMqpGG2ddkdHXyLvGDZB2KhA79cAT1na9
	 7lzCJFLj9Gja2gN7dLSYgUzYyse5y8YNNsX9BsmGHLQDzzSgBIfV3KLd0FthiBB1Wxi9Y
	 t2toWpDlgUx91R5LpS/zVxH4GC0qbEenlNLqL2ZjRuhELdg+mgUCH6uTTnP1v7i4Tw39E
	 1ZgneCbJ5To8HVr4merDvAAwipAwrNHufbDW74smP7UCQkJHYZGNT2ojqSE4P4rgq/L48
	 ll0j2ZQSeFL0ypGoom9ibjnaYxqhk7RvpG/dLCFNVqWtLtLW+gzwnc/apAN5+1gBtCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zvqvFpVl;
	arc=none smtp.remote-ip=74.125.231.138
Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0055606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0055606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zvqvFpVl
Received: by mail-oo2-f10.google.com with SMTP id 46e09a7af769-862aa241d77so1184337a34.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 13:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468427; x=1796073227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gSGAJaqvsTNHXVHAOnsjRO6dcAnOkcqwflrmLLnTBSg=;
        b=zvqvFpVlLqC3QB+48aSZvpSJihZhOqPG5zoYL4kbeFmROf+wReCJXnkahzFo9txii0
         IsVz/TjV9CMriE55SJZz2keACdkIlYwQhVoOO9PoIaWIBgWFRj+QvpN11mli4DCaZ1Kh
         qP1bpE5x7l781uL5jgxBmg4RVTFEdzd9aoOWe+kuMM2UyTYdd1jTg9T/z0+JadKZyYG5
         HFS3QSIZYozyjcoOs7wcLshMBhUcUJCmV3rDRz5NUh58rq3QylUkS7oTyVjEckk+KTBG
         wtZNW4MJfHe2lVGVZ48+6XmMEfAU36ApRoM4UQ0y4h/VsO+Nhb1JibXGuGbegqi//OE1
         PSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468427; x=1796073227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gSGAJaqvsTNHXVHAOnsjRO6dcAnOkcqwflrmLLnTBSg=;
        b=vBryw52x1xXM/RswfzK8w9YrhVVdDCA8aAFQrGK2nC83qzbecTugRDo+QYh4BWz6nh
         +sNxa2WkvjQrt2JBCzaTybeRrDRpM3oVziBtAMIZ2evSCF6ududRGE7576qDS3Ft6LJ/
         eTmR100sC3cKHkY+4msrkcvnuZtNQLobsS5VyDQMP+H4NoZ4QdG5Ra1abTTVAl3r39Yc
         JpSFFXRYClm2Crf+AOwT4t9UoxOW6F2VsQ3e2ss0ft/Gln2EZLsH5q3FGTfeTwsNZbKx
         2T/0q19giJcIeKl7y+0HO+VFOS+drVlJ8DnjeVrelgQPC54i6mUyfbyJN7cLjyqt2qeG
         +WYg==
X-Gm-Message-State: APuU4Z8Fgfyz4uRFxIHQJTbZTj/jOPGrjhGUOYV66vA9ZSZoPSGHXp9/
	gfpSTKGBb0q8RixXDyxsYCVsJdZlpDbPhgPB2GjyHhOnXKOY41x+PVdQnbObAHno0qQ=
X-Gm-Gg: AZFdTZeccIbIfgFHxr/3WkQUfZfySRNbLzOgCHxLarmLraXeBjMOzMMhi4bDHtzxtZJ
	phozdeZVwQkGsPk4QB33muHXGUkSevCPT3IcpnRIZLsvjFMa6ohdoSErHbxhTjQOEoJ/9wZFG6T
	FpriHRS/opynVD286aZGf8gWa+GPvljnLddHpJxQ/eaAjFx2y/D0zmN8PJT0a70zGLKSUJsqS9d
	vP4njDGKJRsDWWhd1wIi2LbZ8/cRI+sFDBBof4aZh/D2yM30nGgS3q4aGaR//qUTHYK5t6DBuMx
	sXnYvHBswYrd7spunojA/S2uBAboj/Zp1XZauYV0jGx6YAFR442bLqKU7H+C7694NAYilmvdGuH
	0IoVnw8+3APF2x864RVrC4tJbyRzpNKWivyVwfbgTnny1HFzDXLtRv8GpiYPKKT43fltcOqbhH0
	LYZkI0sp44VNiLl/TRzxXf6WE1AbP1TQQHJnHJFpxMwO8OMwuwCQAJ2kXPDNDb1Pgf/CPn7WiIf
	cj3pFAgly8NP3PH+8aDZlnA2b8VjjkzX7ehs2dS5tJT8p3XmeVtQgNwjSgrLqp2CuJmsxMwETsn
	KXfP/GiXNH1PJrD632nWChS+syJ0z7nUE3cChxsJ6sDNPWy8mBUPKfJ6ND31vDQtkNy9guiE+OF
	qiqxAGfiZzBvuvlhy5BeLhZV196mKB0wVRCSP
X-Received: by 2002:a05:6830:2309:b0:7f6:ec23:7956 with SMTP id 46e09a7af769-863152f7039mr14476449a34.2.1795468426709;
        Mon, 23 Nov 2026 13:13:46 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168bdc75sm10372602a34.8.2026.11.23.13.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:13:45 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Xu Kuohai <xukuohai@huawei.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 03/10] bpf, docs: Document the overwrite mode of BPF ring buffer
Date: Mon, 23 Nov 2026 22:13:26 +0100
Message-ID: <b9243eaf40e91eb71994fce04d45ca91f1740c86.1795467315.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <cover.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3984; h=from:subject:message-id; bh=nYWK0J1dXr+XTkwrFT4zwddgJsgpIsmHK0+uB0Hzs/U=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtlhYlVSvsqu0M+EuL5dlz2OvvjCu10BA+YBR37fPmn3upP Dsc7SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJEv7IwMXzuPcXzcJNPAUMAZNvlxSe qDDTLFhx0TJ4YxXPeNWHt5PcP/6mfLSjmTfE8cM/qR8SDzwJk3qupnliQKHTizwq6q1ZuTFwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Describe what BPF_F_RB_OVERWRITE does, where the overwrite position is in
the producer page, and how a consumer has to read records that the producer
can overwrite at any time. Consumers that don't use libbpf need this. Also
list BPF_RB_OVERWRITE_POS for bpf_ringbuf_query().

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/ringbuf.rst | 44 +++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/ringbuf.rst b/Documentation/bpf/ringbuf.rst
index a99cd05d79d4..9715d4335d5b 100644
--- a/Documentation/bpf/ringbuf.rst
+++ b/Documentation/bpf/ringbuf.rst
@@ -120,12 +120,14 @@ reference-tracking logic, similar to socket ref-tracking. It is thus
 impossible to reserve a record, but forget to submit (or discard) it.
 
 ``bpf_ringbuf_query()`` helper allows to query various properties of ring
-buffer.  Currently 4 are supported:
+buffer.  Currently 5 are supported:
 
 - ``BPF_RB_AVAIL_DATA`` returns amount of unconsumed data in ring buffer;
 - ``BPF_RB_RING_SIZE`` returns the size of ring buffer;
 - ``BPF_RB_CONS_POS``/``BPF_RB_PROD_POS`` returns current logical position
-  of consumer/producer, respectively.
+  of consumer/producer, respectively;
+- ``BPF_RB_OVERWRITE_POS`` returns the logical position of the oldest record
+  that is not overwritten yet (see `Overwrite mode`_).
 
 Returned values are momentarily snapshots of ring buffer state and could be
 off by the time helper returns, so this should be used only for
@@ -204,3 +206,41 @@ buffer. For extreme cases, when BPF program wants more manual control of
 notifications, commit/discard/output helpers accept ``BPF_RB_NO_WAKEUP`` and
 ``BPF_RB_FORCE_WAKEUP`` flags, which give full control over notifications of
 data availability, but require extra caution and diligence in using this API.
+
+Overwrite mode
+--------------
+
+In a ring buffer created with the ``BPF_F_RB_OVERWRITE`` map flag, reservations
+don't fail when the ring buffer is full. The producer overwrites the oldest
+records instead, so the ring buffer always holds the most recent data.
+
+The read-only page mapped before the data area holds three ``unsigned long``
+counters in this order: producer position, pending position (used only by
+producers), and overwrite position. The overwrite position is the position of
+the oldest record that is not overwritten yet. The producer updates it before
+the producer position, and it is always less than a ring buffer size behind the
+producer position.
+
+The producer doesn't wait for the consumer, so a record can be overwritten
+while it is being read. The consumer has to read first and check afterwards:
+
+1. Read the overwrite position and then the producer position. Start at the
+   consumer position, or at the overwrite position if the producer position is
+   a ring buffer size or more ahead of the consumer position. If the start is
+   the producer position, there is nothing to read.
+2. Read the record header and do the check in step 4. Use the length and flags
+   of the header only if it passes.
+3. Read or copy the record data, without using it yet.
+4. Issue a read barrier and read the producer position again. If it is less
+   than a ring buffer size ahead of the record's position, everything read
+   from the record is valid. Otherwise the record may have been overwritten:
+   drop what was read and start again from step 1.
+
+Records are overwritten in order, so when several records are read in a row it
+is enough to do the check in step 4 for the first one, after reading the last
+one.
+
+Positions wrap around, so compare them by subtracting one from the other. The
+check in step 4 can't notice a producer position that wrapped all the way
+around since the consumer stored the position it starts from. With a 32-bit
+``unsigned long`` that takes only 4 GiB of records.
-- 
2.53.1-Meta


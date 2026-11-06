Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937256;
	b=HMNE6xoC7FjKf1risQ+/AnLCPbZDwNoZ2J2S3IqHJPnQmKGuBGOctO/cXmvs5eCtX5rr
	 UGlrqF2yV/aCFC6LNDS20lQO11oZYEyVBQxUS+GavGAwf+9NhdEagjDFXetrb+bWKYhpY
	 To1mRRszytGzEXhzjCo1yX61oIGz0aB61MwRRU+4Vyc2mOPvmTPbenFFiTmthciPPpqsg
	 TzrYZIJt+LEkpI0vzg71hT8/LHOrCFdpz3YiXnFHh/uBdH/fWgWF3IagvuqGL0dGM6cY6
	 jIpHdyN73CxGV7b/VmER+5Tlyl6cK0sFCkImEYr53dvzvU43VidFmLfAu+qHiECg8iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4jBz2XFH4Z3v8BWRwWMjuGwhLB1O1nk0VaKy3FBySCQ=;
	b=q6v37DXy5oErtYniH1pPSd3nPvPELJBgzvKbE6GaBHvroKBx+3iV6uSls0Z+8OQip2T8
	 PK4Yw5tjI+nmQ4pJ7QUgC24DxYy0CO1+JmUnRJj8JjdcZtarxc8SfKxJgVYjdD69UqG+P
	 ei9ONdZewK4/X0ICfIUR6pB5bEyCazzJAyXjuPEnM0DIrKQ2Tarn/tOng6vlzpJyrHrWr
	 2knqkrHOIl4hsZnyxoMz+TQP2Nx4YZuXZzxRAHbmmSYX3Xs7bwry9MPB6HLMYpViHfxQ4
	 I8KU/V7I76GCb5st+SI4uOmdHIXktREwiZmR0PKSbmCU3etOoQDT2EZ8csjlEAJLN9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SOU0MjD1;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47258606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47258606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SOU0MjD1
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e95bd1c14cso1796665ad.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937256; x=1794542056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4jBz2XFH4Z3v8BWRwWMjuGwhLB1O1nk0VaKy3FBySCQ=;
        b=SOU0MjD1ozAZHH0vjiXXGp/9B8S8eoptRL0CW+b/mrkR+jFl9VUaF95Y3UYGcgFroB
         7bNiM6au1pNkXqrjO49LM4AKhTHw7ucPqR4OUDUEnM+cqX+YyVtGGRaTJQI123VfTv4I
         JmBRrFkWq6BA7WKAaz0eDUPO//DK7sCVSH9Dqpqp1xeSryNiHfCVyfbVd9ygRN4BNd2e
         FNPBNOAMgpoDbmY6D/ZtM5cwoGIJnr1cmWdIybPakdFgud9sqkPEztmnLqYSLQjn0otE
         4qoENX0Bj3i8AX603txIA6m3k1ycfwKv8vyTuA5arOSoaP4ltvZC6auPRgHZNQOCzjyM
         QVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937256; x=1794542056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4jBz2XFH4Z3v8BWRwWMjuGwhLB1O1nk0VaKy3FBySCQ=;
        b=nXFYzTWRIBG11u06J6xNUcJhtrnY/R79C2O2KPQyYj4vg9XLWJPUpo6MgWzLo9bRZI
         B7WldS1rOtk5D9pv8ORtmtBcgKP6DseJSRV3KBGld41VEEncuRMMtPp+zvzbjiRL6m/3
         hWzSMzmsa257YtOByWIjxCcfTTs1SSImxxjtvut+pAtMbnetkYSUNeEEUOd4Npv48CwS
         YjEFkciuTXbfC3aHX9VvdUAEelIaQmbd5sTH7sXfIX5q55yxzsH+esJ25qg547F2qcCa
         u9kVmSF4eQ4HoQxT6jLXCSu4sS4G6a8n8PuofDE/a+fvXkfp5i1skRJqL+MmmGOrZkVK
         EFYg==
X-Gm-Message-State: APuU4Z9LP3vNQdyMTjifGfRwKoOUN8Kp0IH7peFf0wnNU7CVvvm9cp6w
	FghtkpEzKwqVOQDj3Yy8G7QguiUZvqhoDbcvZMTQej9JydEspLYcgru4GvH5Ow==
X-Gm-Gg: AYBFou3MJrN3LbJq4aiZeZ1Lh6m6FRnlXJdFrhSXCnx5dzIx6be1Be2gb2immv/XWrJ
	OWTe9DYjcqZOaJoLLZCRssP+uSjUXkzL19GXSqqOb05+hsVRllhPeNPijNOyGnMtf3ncS9trCRN
	MXyhq45KOWUjqhxrKDKcwIFSabiL3PbSOwhGpRSd//xz7S9mVhPkUnXlpXTtFIqEC8bVRzP7UTV
	c/BBZNbzZDzCzAwc5jRUOJSM32MOfB9CFpiQd4ucDJKzHCw1B7B6zm7G57FZAfCjR9mq8z4aPKQ
	64vD45r5QITHjLGVq4PSGJavc2pWO5xe8O+BFEsJye2Y6cmN04UnPxEftsp/FHlyuXOJ2UOTEar
	ijJF1W1PdLyvlKhDzjIRVXIwAutuSejUc/bFwEgdx9rWPwGJKaSg/IUIQTFUUfv8Un8JeWYrzgw
	F/735ys3l9jrnrAXY/KEqyeDe2/1HyogjIffiQetLg89YTCSxlKSOcI+aTGAPYpHeONfJXzH6Rj
	5vB3Qy5ZyKmAr8S/QV7xHXnwWZcEJ/5Rl1rTkAn9Qyq9RRFaPweXR7hj7U1oUqXqoTANl0tpgSe
	vNOwRu8XroqbN2u9jWC5L/94JEeLG4MIDd9Jegkg2gKDi3u62yFFIvomeDPO9Skg2VAXQPNm2Y2
	LleodsDd7dp8YaQYl7HXUhAGKdRrkJY4oQyLsvAZbgg5XCYgH1FOvgfIBFbiGqc6CFl5xl5FRdQ
	==
X-Received: by 2002:a17:903:2312:b0:2e9:9f14:c40 with SMTP id d9443c01a7336-2ed4062f470mr17699975ad.6.1793937255472;
        Thu, 05 Nov 2026 19:54:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f234sm1245125ad.46.2026.11.05.19.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:54:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 31/45] bpf: A base that nothing is known about can be the context
Date: Fri,  6 Nov 2026 03:50:55 +0000
Message-ID: <20261106035111.3315285-32-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

test_tcp_custom_syncookie.c and test_cls_redirect.c keep the context in
a struct and read c->skb->data. A function that is not inlined and does

  void *data = (void *)(long)c->skb->data;
  void *end = (void *)(long)c->skb->data_end;

  if (data + (v6 ? 40 : 20) > end)
          return 0;
  return v6 ? *(u8 *)(data + 39) : *(u8 *)(data + 19);

loaded before states were joined, and is rejected now:

  invalid access to packet, off=19 size=1, R1(id=3,off=19,r=0)

c->skb is loaded through a pointer to the stack of the caller.
bpf_flow_compute_kinds() can't tell that it is the context, and took what
a load of less than 8 bytes through such base gives for a number. Nothing
kept 20 and 40 apart in front of 'r3 += r1' then. The same if the base is
the context on some of the paths only.

Ask is_valid_access() about such load also when the base is not known:
4 bytes at the offset of data, data_meta or data_end can be a pointer.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 6854e795e537..51c7cce57b49 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -708,13 +708,18 @@ static enum flow_kind flow_loaded_kind(struct bpf_verifier_env *env, const struc
 	/* a number that is good for a load is an address in arena */
 	if (test_bit(base, k->is[FLOW_IS_VALUE]))
 		return FLOW_IS_PLAIN;
-	/* only the context has pointers that are shorter than a register */
-	if (!test_bit(base, k->is[FLOW_IS_CTX]))
-		return size < BPF_REG_SIZE ? FLOW_IS_PLAIN : FLOW_IS_OTHER;
+	if (size == BPF_REG_SIZE && !test_bit(base, k->is[FLOW_IS_CTX]))
+		return FLOW_IS_OTHER;
 	valid = env->ops->is_valid_access &&
 		env->ops->is_valid_access(insn->off, size, BPF_READ, env->prog, &info);
 	/* it notes what the prog reads, and this is a question */
 	env->prog->tstamp_type_access = tstamp;
+	/*
+	 * Only the context has pointers that are shorter than a register. A base that nothing is
+	 * known about can be the context: it came out of a struct, or only some paths have it.
+	 */
+	if (size < BPF_REG_SIZE)
+		return valid && info.reg_type != SCALAR_VALUE ? FLOW_IS_OTHER : FLOW_IS_PLAIN;
 	return valid && info.reg_type == SCALAR_VALUE ? FLOW_IS_PLAIN : FLOW_IS_OTHER;
 }
 
-- 
2.55.0


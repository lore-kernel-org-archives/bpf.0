Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577466;
	b=r03cWydTEcHvf5wsxkNZUgQeB5Fydy+Igq3AFMFodEguMXRgRc0VmlBVf5+FsNjlDzOn
	 cWvHBXVMVU5fU2I5iQCFLdBHuEXZdvVNO29fXceti6jTJqNynzST+zJF2wRbXhZfyCC+U
	 hNI3wnhrFZGqlj2JQx2SoyEo2r6YibRxL1zX/osNIsrI20evjTK/SKb8KdIThc/sgP7FF
	 v8hqOmnuSLOhgtTffY1Oei8rUhVa1eZquJfn3A8aSlzqhPM4vVhDdZlMBsNGR9DQfhulu
	 XQNKApCWd5fKV+N7f00yHNSc0DfIVciP1KjG7lABVdDq7StngObB+a4ld8R7SDVMKJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GgS3xmZT1H37HzkF9Ikx4kPzdHj3TpCO+R3lHpwdEa8=;
	b=aKE+S0BHBqdvJ+R/VeogdCDcZAYzcjrBeGWWPkI4WeP6n8wUbTVRpV2B4C3KWaJAdHc/
	 j3XElD88sQ3/YWhgtRSecadyKVo8GtzVTu9TS7XtlGlnU7LVwFPDGkdtGG3Sm1QkWHN5e
	 MHlqPP0DSuSuriuuGYkByautn1IcrLHaQB0nTaZhIWsJlgrsWaVNkOKYogr1JnZf+hbX9
	 05ZswbWG+wacEmu9rb5cp+1hy2pYbhIT/r7guggXff7NmoA7BP1rEcDzYkcSSQREgKISb
	 CfaGlWrqjO6A/c/smiAx0Aso5T2AWckIhiS608qzttt3HBv6JnBbEUg296GpOoEO9Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jvlSWqrK;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99FC606A333
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E99FC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jvlSWqrK
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cde5a7d7849so2257145a12.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577465; x=1796182265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GgS3xmZT1H37HzkF9Ikx4kPzdHj3TpCO+R3lHpwdEa8=;
        b=jvlSWqrK3hWt8LVvZusVjj+tHsfAcU0OKJLGCnryDWHp+pBGMX7AG+jaZ3qLayBL+p
         cDqXsrDmwtdhvVnBCW9VO615gIeK6t7x+/44G4EgV7dbZIk3GNVU4kC3WEYpYYpON6/G
         ai14faaDzVwSeR8yq8pqWYrGegeYfLPNMgHWkoAZKNh94UviI3q4bbKceiiPTJHecKn1
         J9LogWXpqA7tucofeDAsEVNvnn67r3n59h1PH9RhwrZQKnbeaJxvM3X9vSiXMNLj0WIz
         OXcUwAxIbsdiDb6K8qoGaumTtbIyDRGb/dGHdrdh9dSjEEkXz1Wa4hXDbxYvg5pFDr07
         HWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577465; x=1796182265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GgS3xmZT1H37HzkF9Ikx4kPzdHj3TpCO+R3lHpwdEa8=;
        b=dI/faa2W/xLQy9MQmA0NJ2emh4rRxOc47MV4I9uUvFt6Kd5C9U25mADehzatGsXJNC
         KliC9I4K5yPzyq1DCc6DIANRER8leam17CXy9HCv9Fkajvvf+ZX6yTrV1CozauPByJJK
         hrMhRi941ELppFnoIVzRbo7FCvJEmdnCs+xRvmnk/YuE8c6ddy0VFU8RoTWmCMBXH2fd
         vyWPGj0DzasgPQtKhWEe4gSUfW7d6cOGkh7Eg/i2rmUCm87/PVjjQ/BJWIm1+L4RFkNz
         CgZptMS+nICor1sGjt9nuM+TMmjaU55x7yJV62868sx4msRGGuRvVRUguSeDiutManjx
         ETTA==
X-Gm-Message-State: APuU4Z+BFn6GbVrTX8ycbCJOvnvquKrE1ksSs1xDeXseMnKXmfQmywP4
	durHNoaZMeNFDyZsJPO/Ze+dm162atVnHAMro5KBRStvFUWpueiyDnQa75nO0A9+
X-Gm-Gg: AZFdTZfDIgCtgVPqh8c4jC8vIblNf06/tnLNOUwvlFlPnDPoLp7w0jm2o7HValyBq8D
	rx81eXQXnU+xKu40+zT2j6WZ5vkV8OjtLJ+Ct+11Y+htUOPXGuYMKkaycbE0FDoZCckO/R1Ft61
	ddkuhrkxC/Ji9CPJMlcs/nC4BnXsXukLMmIYdQcrBnXyRMUXHDvsTcW+t6Xoh4NzqdGqQFsXA47
	FvLv53lvk9fxUSRabwhUeSGR19dK80WvBDEmkkH54KrsEdhKLsoe4qRBdTOx0YedrPZCzXoJxua
	JtYF44AGCFPJWqtCwCfCAkKms2QMgnluQE90QK1dofilrCCoRbzCSm71+gtVNfpyCqJq8NWr/mq
	UPHqzMInu8u/+ZMjBtcHGYrUKNArwpsfmT3jOM9tKSNytl/7K8CeKwvGwrl6Ld/1uw0ZtnI5hzH
	NWwQgF7YKdvF3knVeMKRp+gecH99KpCxqdbx3Y3w7jmUbfjfLXLDqschZqRJFEibSVh05wTTe44
	KPEMed0tEZFo3ngbRf9yIm8V+czuMTT4EntQrPzdCqRyz3u3MP4nv0/hBgo1VT5AjQgEHSQx16d
	18fi4uDj3vp7ZxAQKkgjAT51MMqcjmcAsguyIWqnDdTpKoUcJ3UBn5IgJQ8gdWRKUlvf0prSgQQ
	/XgmzVPgXHl6cTOA4oqbqeqhXu0gw2lfckxuvw6JyIOzQwwTf96vWrINQZQm5+2OQqV5io6fhsk
	kjCcNxQoMZg7GlhWKbtHM=
X-Received: by 2002:a17:90b:4ec5:b0:3b3:a6b0:8991 with SMTP id 98e67ed59e1d1-3b41c96180amr15412332a91.60.1795577465155;
        Tue, 24 Nov 2026 19:31:05 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1f42sm77353755ad.25.2026.11.24.19.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:31:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 14/47] bpf: Add the symbol of a prog before its id
Date: Wed, 25 Nov 2026 03:29:05 +0000
Message-ID: <20261125032938.670542-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

A prog can be taken by its id and run before bpf_prog_kallsyms_add().
bpf_throw() does not find the main prog and oopses:

  KASAN: null-ptr-deref in range [0x0000000000000568-0x000000000000056f]
  RIP: 0010:bpf_throw+0x129/0x220

The exception table is found by the same symbol.

Add the symbol first. bpf_prog_free() removes it when there is no id.

Fixes: 3dec541b2e63 ("bpf: Add support for BTF pointers to x86 JIT")
Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 571eec4f0cf5..03cb9f769398 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3179,6 +3179,9 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	if (err < 0)
 		goto free_used_maps;
 
+	/* bpf_throw() and faults look for the symbol. The prog can run once it has the id. */
+	bpf_prog_kallsyms_add(prog);
+
 	err = bpf_prog_alloc_id(prog);
 	if (err)
 		goto free_used_maps;
@@ -3197,7 +3200,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	 * Also, any failure handling from this point onwards must
 	 * be using bpf_prog_put() given the program is exposed.
 	 */
-	bpf_prog_kallsyms_add(prog);
 	perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_LOAD, 0);
 	bpf_audit_prog(prog, BPF_AUDIT_LOAD);
 
-- 
2.55.0


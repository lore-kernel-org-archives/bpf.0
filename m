Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546550;
	b=tuRWV4cOCcIr/oz7zQnZB7nFCPtRgzH+PIXPp2hgT+y8rQpRpz5eIMEWVu63vvSYC1+a
	 0kCylKgP9hJ5ITif2t5es48wIA0pyZBy47wjM11z5z7kQIz9PyI3DU5XCeb7bTd6zAwWk
	 jsuPt5uL1u+FStVIMjatiRjr1A/wr6S6L7L2hpVMQkBB13PDVrFInftso4yE1/ItqGhEk
	 yfaIcazX+6imCGz7D1ak8qMZ0jTlyfBWu3rtK55tDtp5J68qcziXKAXHA9+NjzoykTJ6J
	 zauGdDsx31AXLhJMze4YpQecCbp/WIs5brPMFHy2RiwWqDmbSEFh944eO+9RvRCzzzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mhVrMYhQgb6pr2/MeA7h94qHe86XQdg//KRO+w4piJk=;
	b=twC7rIjqRp/fbdDlBRYjOs3E1gw+wBlRJaaETddiAh2rokY00x1KnHIrDN1LUV6WkfZW
	 p/MzxG/i9OBuKsRip0vpsSv1vnset0sUox/Tipy/Pr68TV4kJhVLh5QkG/05JDmG0J2Fe
	 AF2Xzm/wzYOLElU+r6dZkI2NxxsyTUn+FjAkp6MAqqGWy9bp/0cGxk2WHSY5khyjEVFQq
	 iqiOpsZ5LFu+b25wQGcIdW5Q23JG6fYOo8i1PuVq9wIlw1boYEQURWdE1zT67y+mk4kLG
	 4l9FU4B0l05+ioN81hqKjmQlgmObyFjV4hpyyzxexHJB6q2gvKU62Xq8GzDeI52sfYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y7M0ZXQq;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F656606A895
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F656606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y7M0ZXQq
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so835115a91.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546550; x=1795151350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mhVrMYhQgb6pr2/MeA7h94qHe86XQdg//KRO+w4piJk=;
        b=y7M0ZXQqqq4u8P09md0cZj+KVbq6yxOnTiJB1WhToIzrDQdFzY7Mq6NxhwYxHIWFIh
         xcMN912xyZE1mCeY0sd5/rvhCEaTB6vxVJNmmIxOQJL2lSlGYp8kzL0xOaWJpRM9Kwo3
         gystX9j3ZRroi0btJZmIwK/m0pmh2N8dxxO8rr6/87Z+JCsadkZNPa1HP3XldQQAIbKK
         e9iH2HGpqQHJMygBICcene9C3DaeOj6OuhYINIfbS4VGhnMia6T7aXpwMJsADAYIyC4R
         ogRkmH0wia4+mg9TS6vz6AuvsE+HxbmfRlj8vUlVbqmG19ndygsvTwCL6rGcXQ0oGWKR
         eJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546550; x=1795151350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mhVrMYhQgb6pr2/MeA7h94qHe86XQdg//KRO+w4piJk=;
        b=pJJzPkpT81WJmdS5CD6xHDjCNn3SxJjsNz6a1dRmyZNORKxlnNjHG++wZyjwLXwJlh
         KzT+P6MFn8gXyVC0Sf3g39impKl4phvG8JhgeOM18Xjc3y6HPJnIO7oY7+K/MwOezuQy
         8YKm/HbS2zU69E6MaHypTLMoxWAKGe3pfltItvfQxvavYtKSOPplHUwX381Ej08sSZR9
         frWb1C57ne8kXBAFO+HVZZYlkRU7xIRuqVmnJy+OyRBy4oOkZ2lXRoQ6jvEPGs1CXJ0W
         RBOFs4WfZCOS/tIfXwPA7qSq46Ac/39oYz1ZqMjYa2ySxqOrYnapHG2iB0EKDvvpynNF
         nE1w==
X-Gm-Message-State: APuU4Z/maHgdl4E1S3+NUVE4DYPf0DD0aNC9jUi0FXywdHQEopXxtmwM
	FOPqoYwoNDILYmgYM9pdwJ6twO+Tk73k0Crz8QTBKV/CKLKB1qr/Gdyz0KpNYA==
X-Gm-Gg: AYBFou3DF6CAtEFuuaYytxXZ6gsTlfWe9+3A7LlxaXr+/vXVgqjMDT+MOrnNYub/nGq
	u9g3T8QwXzEGtOe6ufBtx+ALkjaH1wWApg4qhg2iqs+2tT7qzNo11Ox1t8WxEZvKb9hlPmQw7Be
	PWK2Y1gnlCKivyH31qoXcZ2ceeJUkqQ9HbtdxT2DhWCZ1jfEuaz4fKXL9/SUUdygFoHkbi7Q1WH
	/KNL+i2Fm2qGZCx/dqnfm46AgcbCa0HSIoyUcdnP14wR8iVXR93SgxloglwAzi6hWTYW9z/rPZP
	l3h+Bke6ddzeU1zEvN+s5cfizi5OM2vsNBLRORzScn20LDsDKcWQTVZ/sbPxdTq1LG88NV0KXO9
	5a/MCt84G9Yyv8UmUjinuzg11S9i7BlrHumbXCtjkMRY7/lPsLPfyh0XODAt77nz+DE8RGnSObc
	9bjfs/6TEXR0UywjqtOcot5n4s7vYmha1OSCel+pya5b7ztcNDWx465LnjAeShPszJY8F36LPg2
	TVZT5crAYEXXVzmEYbiuJSM64fQI93ycAsC3cHv8sy8ci6d5UkXUArBTDT6UuPQYZMmN7iBf0b6
	s60u+nx0XBaAD1EySahbxBn5DsKkf5Be+TGmpsZVRH8znRIvyNoG8vXqXWGY3l7lYFmlcrlzwd9
	gOuiKNmY6OWggbUE9IoZEC0L8TG2Edj/VC/j94EIMyQWeP8cXZUOJPGlDa8U+UUkEhLrbMOuiEA
	==
X-Received: by 2002:a17:90b:380f:b0:3ab:e588:c29b with SMTP id 98e67ed59e1d1-3b1b0816e0dmr1234873a91.5.1794546549640;
        Thu, 12 Nov 2026 21:09:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae981c55sm2589312a91.1.2026.11.12.21.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:09:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v2 bpf-next 01/13] selftests/bpf: Don't depend on the width of a BTF id in verifier_live_stack
Date: Fri, 13 Nov 2026 05:08:49 +0000
Message-ID: <20261113050901.1399091-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
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

kfunc_iter_stack_liveness matches a line of the verifier log:

	 6: (85) call bpf_iter_num_new#95448          ; def: fp0-24 ..
	" 6: (85) call bpf_iter_num_new{{.*}}          ; def: fp0-24 .."

The pattern has "{{.*}}" for the id and then ten spaces. The verifier
pads the insn to a fixed column. An id of six digits leaves nine spaces,
and the test fails.

resolve_btfids sorts BTF by name. The next patches add about 12000 decl
tags to vmlinux. Their names start with "bpf_fmodret_retval:", so all of
them come before "bpf_iter_num_new":

	                      id of bpf_iter_num_new
	before this series      95448
	after this series      107433

Let "{{.*}}" match the spaces too, as other tests in this file do.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/verifier_live_stack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 2d31868bcfdb..4bc4091b17a5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -979,9 +979,9 @@ void __kfunc_btf_root(void)
  */
 SEC("socket")
 __success __log_level(2)
-__msg(" 6: (85) call bpf_iter_num_new{{.*}}          ; def: fp0-24 may_def: fp0-24{{$}}")
-__msg(" 9: (85) call bpf_iter_num_next{{.*}}         ; use: fp0-24 may_def: fp0-24{{$}}")
-__msg("14: (85) call bpf_iter_num_destroy{{.*}}      ; use: fp0-24 may_def: fp0-24{{$}}")
+__msg(" 6: (85) call bpf_iter_num_new{{.*}}; def: fp0-24 may_def: fp0-24{{$}}")
+__msg(" 9: (85) call bpf_iter_num_next{{.*}}; use: fp0-24 may_def: fp0-24{{$}}")
+__msg("14: (85) call bpf_iter_num_destroy{{.*}}; use: fp0-24 may_def: fp0-24{{$}}")
 __naked void kfunc_iter_stack_liveness(void)
 {
 	asm volatile (
-- 
2.55.0


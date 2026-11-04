Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828956;
	b=0h3d9xBjiJ0PBPa8xQegIqgK5WqN+Ra2LTtQS/TGXhwfTAZ3oc7od7lnFw6J92kdyitT
	 KXDrsZltfaCV2FPuMHEtKqmjnFrtpYyRAFbhCtiKkWNDyFcoMwU4DR34qMvdY9nfYh9RQ
	 8CLAxSNOJQMi3/bQKYI4mqe/cznVuENXRYBhzHaZaUQfYp6+6yX8g+WXvWIu7jEE55+po
	 Yni9KDtv0V3ubBRhugAg8sPvzXqx3QMR99RwtGMZGAHoMp733OnHQq6PBnhG9bAs+d9Sa
	 wJAkt02cHd96oG814vIqxmru0ddk0YXUHwkz6RH0d6O3F9lJgW0A84B+M3rMPtWL70A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=U83vFw3HmE0+rYcDJKfZ6bA7vTCnfKK+lz28TTSI4yg=;
	b=QfhYYRLBpoLKSPOM7st05CbGophu9sbneKVpaQI1LTD5BDLhS+W6HkmWXJdsupMzSNN6
	 Q8I+ktZvbgXWUaZDJ0Zgs7sJUogOKAsDpqfvEdjp+BOTJBNvWpIFTsCG9RnDAglfao9jd
	 DfwO45rhzUat5u9MEC41EmT5gMRsvGepQrqFUKFjSqH6L7hgIe5A1I3hMtL5dFyIUNaLQ
	 eaN/nslllUJ3sa7LFzmocPfnkon3wAnzWsVDHP2VhEp+mOQ5eNKIrId0ZW4RLCpiaYuh5
	 n4ZwQtwD0p2sdkeLIkuJIRI21HFa/uoFJtnxe+H+7AunJspYrbCqVl+8e8mCK/dwGTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZCANMZdG;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F66070431
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 468F66070431
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZCANMZdG
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso549772a91.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793828955; x=1794433755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U83vFw3HmE0+rYcDJKfZ6bA7vTCnfKK+lz28TTSI4yg=;
        b=ZCANMZdGQ4uPqVftrnqOmPGwSAN2bQtBf8wz2QFHqdH/xp5fGB6e0lOgMUsrB39YUz
         VpGLh9Pbdsn9CyV46DtAF8QMcckU/MQcKqNdEaJALwOdGN5oBi7B2RN9DleKPrDid6MC
         xA3DQfGSQsNPqUFLCFLHUUZ4Rzpn4JUd1EgbtXwt9GzXhLpmuq/3ViO7y4LSIso1e2N6
         xBZ8qW4LyiPBLOx9Y11G2DPUYZMYNW8QtiWz0t3FCDmrXOuebFVdQa97SSmce8omPVxi
         YFe17rmyhTYFFbpBKKIdUP4crK5ky6P8VlB7KnAbUNufW3sM6UuCiyoLPco7RPjCJD1s
         R2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793828955; x=1794433755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U83vFw3HmE0+rYcDJKfZ6bA7vTCnfKK+lz28TTSI4yg=;
        b=14GMWEoaifdpd8HiJ8FTcFAmb5HX308I7iSs09Un+bvsDdfD+rbLwcV8rADgyxnRwM
         xAnGweDou2cQQbqGNVe0XSAaIVJ87AgbXIH+q9hdGaDznqWO9HOBDseq+IXR+Ja42HB6
         9XBB21szFR2yUSfdCtnfYg/6+Ks04XMOfobKj7SsNBZaf9Hon2XG7G3z0/NleA7sUpl5
         5baz+VTGVGAb4KGCklWzpJc8hQXVSvu8UjyEuuJMN+yTUoxwljMBDkNPDHuHzFgJE0la
         jIdeygKtB9Yulgq7LH0grKZOI4omxaoaCbbE56UB866DJSOVYnUQnmlYt+ilfCE3GKNR
         ixlw==
X-Gm-Message-State: APuU4Z9Y9E7llCSIS/1Uz7JlbnSIGnxiJH2qMz7tXh0fl3+ngFZ4UWwR
	8phPH5/vKxnZ/q6tz4fuXdXppH2ldVvJALZ9cdTW9lJXlA4wmP4ZejSwTnB2JQ==
X-Gm-Gg: AYBFou2DMQ2Sb7n5V+Qr5ayQV2f/wp7TWQ+mmwZNrpUWWItoSh9uwxZ+14yz+pzzvfD
	3bFXXLCI41SXf/6E04tZNMhmjd0b8n9nD8mP7J3h84cuMQnd+RcPlA9m8RDMt2YH+1pw1ww0qC0
	O1wMXFRehpALH6kHiO9IpfJlKe4TtXoMmr6UPjw2dEGV9O81KviOw2P0lDBrlZEEyyZBbUt1HxU
	MKwNKh2L+In2U3WX75WKTjmLaz88jtRAfDI1yWUFVK2leZidsf6j9DWXYNL+krCqnk7+4ucsLAc
	5/eUquQxM6ljawKwTX9XT3UUBiiifKpsLbDFJLFTbAyMK8dyl9pzWPx7yDqvVxmiu83vleyWkUn
	qJqAij3FZGbIMrnaVyI5qM8GVsAn4eT/s6rr9NEo/0nibnH+Ia/a2+KzJBUHpUJa43o9CSTqGpK
	OL9LccF+Pm21T7slPjyuk7GLAz4WXJQIukvn9QY2+6K4szcYacVI7KoGLvHuUkqt2IDkxD1MkpL
	1gE9Wh4pj82attcwBYBsicFKxFb6+76QcWsWko98WHbe364PqpHHXgOF/8FVV1xl3gjCGnCPsSk
	rot3UvP+/4bg+N7xmYn7AVy1y/zZsNNb4yYfLFHAv4GL/axkNx/TDifoUs5afbNrE2vytGrKxH+
	DtYMDSq/2ebR+APEWGT+mLE14fQ28Zt1I18qHjWa4gTtURFHjJwP7whLgPx+GgLsRRrrz/9CKzb
	Bz
X-Received: by 2002:a17:90b:1a8f:b0:3ad:eb38:9778 with SMTP id 98e67ed59e1d1-3ae897994dcmr15553166a91.48.1793828955392;
        Wed, 04 Nov 2026 13:49:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32b6507sm711212a91.16.2026.11.04.13.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:49:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next] selftests/bpf: Fix bpf_gotox with noipa global func
Date: Wed,  4 Nov 2026 21:49:12 +0000
Message-ID: <20261104214912.1543558-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

use_nonstatic_global_other_sec() is an fentry prog, so it has to return 0.
It returns the result of the global function __nonstatic_global(), which
always returns 0.

Before llvm commit 28b4a2032f97 ("[BPF] Mark global functions noipa") the
compiler replaced the result of the call with 0. Now it does not look into
a global function. The verifier does not either:

  11: (85) call pc+1
  Func#1 ('__nonstatic_global') is global and assumed valid.
  12: R0=scalar()
  12: (95) exit
  At program exit the register R0 has unknown scalar value should have been in [0, 0]

The skeleton does not load, and all subtests of bpf_gotox fail. Only the
cpuv4 flavour shows it: the other flavours have no gotox and skip the test.

Ignore the result of the call and return 0.

Commit fdda033f7fb5 ("selftests/bpf: Fix callback recursion test with noipa
global func") fixed the same problem in another test.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_gotox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_gotox.c b/tools/testing/selftests/bpf/progs/bpf_gotox.c
index 99b3c9c9a01c..f3488d7b4b4c 100644
--- a/tools/testing/selftests/bpf/progs/bpf_gotox.c
+++ b/tools/testing/selftests/bpf/progs/bpf_gotox.c
@@ -418,7 +418,8 @@ int use_nonstatic_global_other_sec(void *ctx)
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 0;
 
-	return __nonstatic_global(in_user);
+	__nonstatic_global(in_user);
+	return 0;
 }
 
 SEC("syscall")
-- 
2.55.0


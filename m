Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071019;
	b=FTeBOUF6F9JS4E0pKF8HNtM0Pr7C6DhRyEjvN0gitlKqFB765zI1cszmCQwySfttxODd
	 PuRLiwM8CxAqrESLgbKUrc6qenQqhGHG966s75DT9EW5bz4FolQqhNJ3rutZhZBhkPr1y
	 ndtKRP8k4wVlDb1z1pN0kYEp0/PgPTA0F+hnddCJYwS5b8j2NkAlPvqRPtnf3HfxN1JIY
	 2aPaw9TzFjflu5Gue7fuSVZZ1PY9LS0cgIBA7fKtM/HZG8UZF9Fc2Gg1B9S9bKM2/oXpf
	 gEu4+MrHqyVL8LhV5vqQc5693IAh90kReoufjh73G/qUOUNW4YUmDFqMIBWZFxkp/tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Nz8L7ZO59Tsj8/ksCe4aovZHdoavAt4I7KkG9jbaYAY=;
	b=SMsUlIi1du6sa+I4V2xB45rFAiTvNQiaqBuNzEEIof5cdUltWdRf8i0Mgh8tWD9Epqm3
	 Rlq1ZhShIlIUhR3XtkVlYHrONEJVea/mAUpN15xp7Lly4liJkbVbujFq47b1jG0Ye9nTJ
	 uvRv3Z1F3Toheh/VKGNb9Fej2QkNqiZCtJ7Jvt5W2pXIbkcWpLrCIMwOSze3SyUIt13OG
	 3y8FvbAlBdTPMxSk/+ZJT3dZJUmOisR1FROGTzh+QtuWy9qtN83IhGIxX/uhQnqZ5E4Ad
	 Lyaq1GM4u/PfgI9i49zL2s2v5IGGIGN7OV76OIjh2+MXBqZOu9IUxnjShJybsjF1iLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CF0nWxUa;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5634606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 17:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5634606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CF0nWxUa
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso613734b3a.0
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 09:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071018; x=1794675818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nz8L7ZO59Tsj8/ksCe4aovZHdoavAt4I7KkG9jbaYAY=;
        b=CF0nWxUa7MZ3ZHVAlg9iNiWsfUX6fU2mAXFAVkr3PrRt5EY7fOR9d6CWNEBBfdAu7d
         tmQgOFKB9ofQvdFf1pwVf6JVGKKEz6sOEmJKDVJwlt9gO4esaE1cK5sbtaA+qjxckAKQ
         glyHfl43WB18rWdhn8fe94v1OmOd9LaXRw29icfrYluq4lVojnxun9fVPWB8Vty41siE
         83AVaS0KuTvhCYRLObYJefSWzmeA34oBHA2sfONxKN6MVH2FzLkxDirTaOPAu7sxFace
         gYJfTZPvDgMl9o6c1CANLn9uNzfYFYZRSVgu2VhrY6P0CTs5xMesHUYsAeD6PyqKSenF
         iBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071018; x=1794675818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nz8L7ZO59Tsj8/ksCe4aovZHdoavAt4I7KkG9jbaYAY=;
        b=aEWKxqbTaoPLq3wzjP7PHGwgoTQXD/bNnGlGONLL3JzC4cQ/7Mtuofgy35eEQJeZoQ
         GniJXfFF1iETuJuiR9+7nnnZpU+6Op1Rs6QmH/rSDS2vr5DpkpW1WPhJiG1CZLucym9h
         pOTdVU1MWMPfFzXngm132GW7JCyp7rl4/0TJVEUPsWwW439MuDyXdTeB6Vc8Po3fNzM+
         trJu7UTPrkF9B9/Vw8mwjsruGWuZOrxUY0vr+voM/6VbH/30Vsk/tHvbATzyMTBmF0gU
         VrEXRYdncwEOqXT6y/jGY95LsDSZdBerY1G4+pMzWUGqmYQS2NjL0PiNrwhP7snIWR+8
         u2yw==
X-Gm-Message-State: APuU4Z8Sny6d/b7qau1EBPAxLG++id+B8aH7kvvkHyg9/EQ4zD5IIg6+
	lB9f6ic6H0WcnGcgY6PKeK0Ut/fliw2K973cD5Og0MIRsa3wOODBsBd7iV/mTg==
X-Gm-Gg: AYBFou199YXEg+Lemav1kb2lDou7eyfXEXIW2+8s/vVifwsfkGq0pa+IaRCAaCPSrOO
	SAJ3ipdQ35tPhl6fdW0akbh7xNHV6ZaW83zNNvMH+aakeLTYwF9/bk+aeqzLdBevnfe9mgiz++L
	bSPOllX94lua2dKnADMDTemgsPdFiH2Q7HcKdh/GdMCZP+WfZ6jnUmKcKgwds7Qap3AfIuUcwuf
	yO6b9+B37SHxB9IcsV/d9QmHJSKnLbUqppKdqnNHaBSHO5I321GotjPYHKmAWNAsUiEYOI0s8no
	AKJqziTabWKt7PCaBTq1U4aiGSuVmr7VkByLqwNcPxyLzil4g/GyUc23YDC2E7JITUlDQip17Ww
	SrgSh9LUVLwiedq16xvPilbKOjqzchTPKW6tnHgWmigYVmtdYLMtTFR/llz65VvQDYPL/GYYFLa
	ev5WyTmVNr8OCBIwCNCRJh7l8AaplisolfZ/o/IdVSvGqg3YQpM9wHmTkA/DcrUSuc+MxKXt3Yn
	TaMNKH2sh08GeaEieh7PQODsIDSrQl5V14Q7tuNQ9U+4VL/ZpEtQsHK5mDygGFE8CvAXAE8dRFr
	0SK7VM3ux1Rgc+dN65CqqHTJa+gmXuj/Xdu5oblnTqVzkpClCxs6KpG3C0G7uzr1f01MhMGQ+mD
	/FM+4KH24cNwvUh28tYBuyy1Jk0cfydvF9Wg8ue+M16CeZqy4ICSTUGSIhsGzi0nssGgegj9Pcg
	==
X-Received: by 2002:a05:6a00:1256:b0:874:708d:b620 with SMTP id d2e1a72fcca58-8b37b478b80mr5454841b3a.30.1794071018120;
        Sat, 07 Nov 2026 09:03:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b35921deb7sm1315018b3a.12.2026.11.07.09.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:03:35 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 3/9] selftests/bpf: Skip the stack walker of verifier_loop_latch with GCC
Date: Sat,  7 Nov 2026 17:03:00 +0000
Message-ID: <20261107170306.2831028-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
References: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
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

The GCC BPF jobs of BPF CI fail in:

  verifier_loop_latch/latch: frames of a stack walker

The test is about the outer loop: 'if (frames == 8) break;' counts it, so
out[idx + j] stays within the 256 words of the value. GCC unrolls the
inner loop

  for (j = 0; j < n; j++)
          out[idx + j] = b + c + d + e;

by 8, walks 'out' with a pointer and ends the loop with 'if r9 != r5',
where both registers point into the map value. The verifier finds no
count for that and says:

  invalid access to map value, value_size=2048 off=2048 size=8

Skip the prog with GCC, as plain_c_verifier_loop_as_is.c does for the
same reason. The prog with nine frames is rejected with both compilers:
it stays.

Fixes: d0a8c63bfc66 ("selftests/bpf: Test loops that are counted, walked or widened")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/verifier_loop_latch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
index 8b9a2853ea05..35bb3e16db3d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
@@ -206,6 +206,9 @@ int name(void *ctx)								\
 }
 
 OK("frames of a stack walker", "[0..9]") __retval(256)
+#ifndef __clang__
+__skip("GCC unrolls the inner loop")
+#endif
 FRAMES(eight_frames, 8)
 
 BAD("frames of a stack walker, one too many")

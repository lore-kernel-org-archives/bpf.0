Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577431;
	b=bgeHdA1HZR2Y2P/DadS4J7j4dbrtKX/5pX+AtR+nC7Ojsl7RWBCDWn1CP0+nV4OdOk8h
	 DxxLzLtuzR/xRQ2bDCF6EUlh2PV3V6x5pj+diCf/1jZ5kMsL4HIfJqRdVBVLK/iL/g/k0
	 SaEFutrIXzqP+3IAA790Q42yQu84UvJ+q0m5TJ8KcoybiM8JLky+a7EfZk2dxoYrYGyyx
	 C/HPXy5yZadOLFyxtcPZVBV0e9z4cOHn+vDX31mDaeosk/oC4Sjg0AF06IM/nrwFjNRF7
	 2lKU822FJaTw0f/qsaJRd/kKNcdpgXacioO1w/LpsTMoX7Gpk3Gm92ZfPy0bQt6iYrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s6wJ+4GRbUc5cdVyS+/gZn2PiKHi7MowB0E60D2MYEs=;
	b=PRqUFnCmJdI7omn5wA4UhIfPcpePlBhV2LxSrlQftCA1qR83HgEPaFE5cIfcwyB/G0QZ
	 hwyLHqlFXe1XlICh8tnfx2IwaI2oOXFgmMNwe3SAtHM91RvP/Vfn2UnYU4vUdynM4IdPw
	 GqBM05RiXBGzUTtLk1q4JkDC7MnYwLre35VGloZEDUGATs/daxpRUp9YXafIwH3zdQ3g+
	 fULaNlF+oW9zrxqsD4EIweTHCL4DniobFk2nDb124CZyg6X5R4Nf8Z5mPzJ79KhU0Pc/E
	 7xvIvT8+AnTXu0dqJ6vB1G5u6IDaA/6qOPcU6xeV62eH201e0tLbZ0yjyp2VoHpyHUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nvwrlL4y;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24EB606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E24EB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nvwrlL4y
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f01f296937so40591485ad.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577430; x=1796182230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s6wJ+4GRbUc5cdVyS+/gZn2PiKHi7MowB0E60D2MYEs=;
        b=nvwrlL4yFBwRRW1x7yNI21cKbHmTp58CWSYGelhQfVryTN83HzaRUE28ltPo4HMWsc
         yUT1GskYt1VxEDWNSqQN/CYthT9WM4szLsg+9oJkb9p8+0g/MESqOeD7CaOWkWuT3/Ti
         kqI7zX3eN6OWbDJcDutHq4Y6bXdWxiHHd6+cAwncqUfUVD4xiGe5h3fq4qGgrg7vl0Y8
         R3LB6vcrKbU3d8Q3EOCSGYSoMN2vSiD4MHQKVWzuBLFhD3ASc8/b4gqym/qhXM4/sseR
         QpijPd/nsgtRkZQEL9FKpu/T1PJwvhsy/3sytelJ6KD0VtpcwCXcjheZSYkCmXjST05U
         Ln9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577430; x=1796182230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s6wJ+4GRbUc5cdVyS+/gZn2PiKHi7MowB0E60D2MYEs=;
        b=G5ewFgVVDpieRvcc8uno7qaPNFZqnCmAyIZjDTRblEz1yKC5ujIdqMRv/SQ8dcdKYc
         A3uy9iQI7KAww3nS7IdTr2v+xrM6C4zNMIEqdHTdBMB5G59ovAyYbt3J3AS5kyK5syWN
         DtgrwNLQyc/jrH6KeBmaAs7cHO7rki5ATs6Jg4HO1xw1HGhnfXGT9PVX5xX3CD1NsMLN
         ZWeR3tQa2bbgBfEwpV4ANGvIyShErD5Fj7BOee0H8EYjWNQqnD2lYnRyEBJrhN5SOCBC
         R/L4WI9GQsLF+2iM2vSRHwHD8O36Kx7cTSn65XbHmge+GBf2IwqsoMSYIfHl6CLAvK7b
         KAZw==
X-Gm-Message-State: APuU4Z8Ta7mdePAlemlSDckBV9hjElwZlYOEHTGpIVanAAx7Y2LgSzPS
	jn9YJ3nLcTjr3d3l0AvMk/ihgnYpX8r53NeSLnb8hgDnsxyv+8FHsmRPbzGdIYWa
X-Gm-Gg: AZFdTZegnyUOqpOFe06NY8moAa9Xg0vRDvEfy96pOyV/TzLBqM/TzJcbWcoC4wfZARj
	W4+XzeysDQIwdJas+JoIiOfOgzsInBr+2KPwa1PCyyQzzls4eeBtT/5QI2EQTT11oMffJtl0Eub
	lf7tnHJs3W1u+epo27ZouLzk9CTIIFKrQt8n2bkQy2q4N5nKpVUnay7gTBPZTJ2s2XHPK4yttnb
	U6ir6byAPmr3csYD6UDJP4PK/anr/eQenhEaJp972vk5IUdzD6bzmHPr0JcvCfOmlsWmAGrP9UG
	bTpq7pNLXtWYUiOsalPkyK2oitEQluyKqyCQThJWSShyy2XZA848w8Z4RantUBCI/wTdDODN4/L
	uuaBDNHUm8XVMXoLP/2HdqgTtB9VHGVGGb+FaKB5eExZmHjT4tvtjFiY3Ykj3rhzT9uL9yoJmCa
	bPiEE18EwLh3AGwboABzzrCdYqYSpQVIbAZmoCTCIeke36xePuUvHn4TjZo97wRzc79wojCv0Nk
	SL673rSt716seYu9X6eHhKerj9mXDaCJJIz5utTHVmUWo15gPLScPe4+WBFlU/MXIb+RXZtroWc
	+AkgicwfYAmHh1cAzjfMpknMWIyqT/SiJnUNUSFXSfDZOgNw9glZl6tSHmxCK0wk97R52sQgKZW
	iazWwRlT+X4m6LtJ8QigcgoNTdJfcgyLw94gzq2fYVfTxY8iVdXeLy52qwtxmuwhfkRadvWUmk0
	4=
X-Received: by 2002:a17:903:98b:b0:2df:aed3:2ac0 with SMTP id d9443c01a7336-2f03f1cf5ccmr181381515ad.10.1795577430053;
        Tue, 24 Nov 2026 19:30:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84285sm75931195ad.3.2026.11.24.19.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:30:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 08/47] bpf: Reserve cookie and ip in the trampoline for tail calls
Date: Wed, 25 Nov 2026 03:28:59 +0000
Message-ID: <20261125032938.670542-9-alexei.starovoitov@gmail.com>
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

The trampoline has a session cookie and the address of the function
only when the program that is attached asks for them. After a tail call
bpf_get_func_ip() returns what is on the stack, and
bpf_session_cookie() points to the first argument, which the trampoline
passes to the function:

  KASAN: maybe wild-memory-access in range [0x4141414141414148-0x414141414141414f]
  RIP: 0010:vfs_truncate+0x32/0x450

Ask for both when the program has a tail call.

Fixes: 9b99edcae5c8 ("bpf: Add bpf_get_func_ip helper for tracing programs")
Fixes: eeee4239dbb1 ("bpf: support fsession for bpf_session_cookie")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index a656634fa9e4..59dcd91ed551 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2254,6 +2254,10 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			 * the program array.
 			 */
 			prog->cb_access = 1;
+			prog->call_get_func_ip = 1;
+			if (prog_type == BPF_PROG_TYPE_TRACING &&
+			    (eatype == BPF_TRACE_FSESSION || eatype == BPF_TRACE_FSESSION_MULTI))
+				prog->call_session_cookie = 1;
 			if (!bpf_allow_tail_call_in_subprogs(env))
 				prog->aux->stack_depth = MAX_BPF_STACK;
 			prog->aux->max_pkt_offset = MAX_PACKET_OFF;
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577530;
	b=vHcol5WTjrvII1W3H5k4ak0k6fx9BIW0BC87ArdlumKR25MHWqDtwdpvBLvKjnAIEHb8
	 b9E5dwwNF1r+f/Y3uPL+JiYyhKeYjPnyQJPXMLrxzw15W/4TrxOYUeEEnN6AiVnB7BlWr
	 ZnMYvqdkjOa6VS5S5LV0M3LPb1yN5jZUzDtLmXnt6NMUA313jCRoojGNfsCEZd9oAY4f6
	 sBzgU8Ad7EjMaF363nxtzcENxSHozJbkjF6r+cCkSLuOoAELLHVdZi/uLslyMEhoCeD5w
	 X6m8i6Za05eE0PRTucHM4yf++gKIf9kKK2FqsK1r2oDd741y5HjhrZ5Y2iGJvTvOPCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8R8Nq/lGltfEI7R3doIfbHdtcQ/gi0zmk1TchRyl7m8=;
	b=2HhBsoo9SLDiLCitZ+cryRV2q0Ib1n874ppLejS1/QpoGMaiXeEj9wnggtsQZJja27pF
	 iqOIK5ZwTAvSLRSPSf02NJFvwa2BmvYFWcXoex2Lu/37onWwBFOBsKxEYpDh3CA9xVisJ
	 9SX8cMnt0KnJb6rHwBFUI0DNHnTciM0dN0cL2gXi1RKaRJogaGTDeTETP4pAvuEHOBHnX
	 YyWoctSgBgcPAexaqjE/cllae0BfqBrwXgbOxu8i0/v0HrK7+pTAT9MXSLdRurxxHRib4
	 lZ+2Bkn9lqXGljLZ670HdFFv4aHBByttpzOKopjgrByQhrTjl/El4m7JfJuuOH7zyNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YF6R+YTx;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB86606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AB86606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YF6R+YTx
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b421e8d111so3550109a91.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577530; x=1796182330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8R8Nq/lGltfEI7R3doIfbHdtcQ/gi0zmk1TchRyl7m8=;
        b=YF6R+YTxAcB/uJuXBAG3ILgbR5T78aPS2xtVtRSoii6PurmWDPH++v3YO5l5fEX1J5
         mhDoC3GmOpEQCxRkIfMEm1N4KBbOryckCZ2rBem9o7D8E3hEprdXQEpDVQ08RwL5qYO5
         +n718fD5CrT0lkNm0gQhM9d11JpvhxHIXGqy+D8xkQHg3sJgDnXATDSekL19pmM38Y9K
         t95azgzTycz2DGlx4CZ+H1FpDKL5pJbDydpF+E1ou0sGvwxMUMTIYesbqsqv7yQiBHsH
         i4FYXOu8l0hINxseB3uua6uMdI1ughHD2ea7WC/x/+XWHr9N81kp+4mbvVVScwZ/XOg5
         /4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577530; x=1796182330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8R8Nq/lGltfEI7R3doIfbHdtcQ/gi0zmk1TchRyl7m8=;
        b=ovsfuvxWGzhkHldHqmC4A7BUwlXkyPf/I2R3E/oNN9AJEgyE6mjMZIxAlx6s0RsY+h
         1RMA1DmEWiuV05pezZCeCbTOBkCxiAsGW5/2TEdQW4y90DNuz8mW4Nf9/djY91M5iZ4M
         gRsGeFe8BNWPwotMPqOp/RNF2bkpOhWSK/V5Bw+BO52dbYmfW07ivB/eCnGkah/Uyo46
         ib+u2HfFk9el3dh22GjGqohBD/RvC0aRR4atlINL8PQRfYxbHe4XbO0TSUcNo3sJtuh5
         9H/eaRA2CSwFCega0GCtSo6I2akCWr6VYXapRxC/3VZ3u/hgH0nntAflzI7TP7Ezceq3
         h56Q==
X-Gm-Message-State: APuU4Z8IJsdOHEjW6y0Gtl2dBC6Xp7vsu0znHMWQXwSEpBh4TwExMOPT
	qss2Upk1cy9f39aXGF4EWs5qKwSrXOR3ix7xk7c2mnJvVK7CdXZNIRcdo3LVoMDL
X-Gm-Gg: AZFdTZeR7z2fPP3X7mpl3uL0c3+a03W3rA82zc4+d1F+TSLiSaTiU3CWY9eK9Zd6/vW
	15vj6/uokuZMd7ZNAN0cC7EUzzuibsSxQf+rZ2Pt/4cMuekOocGbgelgNzNbWNh4T3uzeedWKWW
	dH9FMBYkLEET9T+/3/6brQK61lR5+QzD97kA/1jtf0mHafLyPoh25653JenQD3Uuiy8tI8Hyo/f
	d04sQ9MkNM5Tr3hdqCKuwGbtSQLc8XHiYBnZUNRpoEby3O6sFnurwGf8iK9KHor0ZM2sRgcuobN
	jShR6C5OZoTiIONu8JJApaf8pV7CxEAZ/sVlyC6sOzy2rRYaOke4upQNI66LNYzNye7tcQNtbob
	GgsoiqiQYxSSA2mlomjmIzFfndMj4j6Mghz2qUP/dGnktgqxxj7F6WrUgtmaVmBUvR6H2KlmGG3
	kRe4DZbF2M+0xPnrSw0Pf0AlRaWsWrexU1DoqFAqCIwoTLGKkNJVvjWv1FuvY+UteZiv2SekwBO
	9/lKaYlIITgo7KtAdoAsR9ZXGXhOzCL3KK1y+aA8+y2jzbVSUqdew5YOJCi0d/3HwwpKT4faJfu
	aHKDq5xWlDKas2RwcVVzDAGQdtGSJ+JwurhtAbXBCFMsKdSFTRz76GmKUr36wSktXFT3ikHvA1O
	3Wn4e86d02U7JGn+AA36AaC8xg7a2Y4H8nlqw9oBNTx3L5fcG3gw7zEPf1/5D90WNb13aKLazOA
	==
X-Received: by 2002:a17:90b:388c:b0:3b3:c04e:4b74 with SMTP id 98e67ed59e1d1-3b41c9b2becmr16702291a91.15.1795577529470;
        Tue, 24 Nov 2026 19:32:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4dfbe54a2sm3993633a91.17.2026.11.24.19.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:32:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 25/47] bpf: Give syscall programs without CAP_PERFMON the base helpers only
Date: Wed, 25 Nov 2026 03:29:16 +0000
Message-ID: <20261125032938.670542-26-alexei.starovoitov@gmail.com>
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

A syscall program needs CAP_BPF only, and it gets all helpers of tracing
programs. These don't ask for CAP_PERFMON, the load of a tracing program
does.

The helpers for loader programs take current for the loader. It's
another task in a callback. bpf_kallsyms_lookup_name() answers in a
callback of bpf_wq, as a kworker has all capabilities. bpf_sys_close()
in a task work closes a file of any process.

Give the program the base helpers. It loses bpf_perf_event_output() too.
Loader programs are not affected, bpf_sys_bpf() needs CAP_PERFMON
already.

Fixes: 79a7f8bdb159 ("bpf: Introduce bpf_sys_bpf() helper and program type.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 03cb9f769398..e82ae48c0bc0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6747,10 +6747,12 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 static const struct bpf_func_proto *
 syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
+		return bpf_base_func_proto(func_id, prog);
+
 	switch (func_id) {
 	case BPF_FUNC_sys_bpf:
-		return !bpf_token_capable(prog->aux->token, CAP_PERFMON)
-		       ? NULL : &bpf_sys_bpf_proto;
+		return &bpf_sys_bpf_proto;
 	case BPF_FUNC_btf_find_by_name_kind:
 		return &bpf_btf_find_by_name_kind_proto;
 	case BPF_FUNC_sys_close:
-- 
2.55.0


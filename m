Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071037;
	b=cKQsdcajgAu1mKS1FNos9X/lKtAMczpKDxRaSGIXwsInHzQoiRndb6nJYljqgykuau5r
	 oi/YqcbIT4dlHAMY4j3a91I8cvMdEok7h22QHesYOq56tJM5OAB4E4f3eCggXCNQW0EWQ
	 bVCYs+RsIE1bKI/sRIuYXUhfcitY0mBAxsRUPN5SnyPBwqaXQHI6upJmKvhsvsE/Fsy6z
	 gklC7RmH1Cdqsk1ikRxZDvm3LBb4q4H+ZNOm1Dt1pRBkmYTYht3aaYwLuxQ4K1SRp3QxZ
	 IvYZ3H7Y3IAuGQPbtOkEMk8Zb+NOrs2724eV2fAoKGzj+7E/np8QRURJpIeDiMDmkjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a61JwjnxKGRSd43XgWGH6Kd+4jztQXz3+tYtxQyCkm8=;
	b=3MIT+KVTrAheXAonSt40GGBE4cULHaDAIXAbXyI4882oobJKYmv9MPiA3r3IemVX64RC
	 hPw67EAGJe0DeLbnvyqLDMD1Ra7bXDcqzwqlbM35JRK88+L/OUCAr0SbqWUnX/iTyr0Ze
	 09d5rGY/NUPSNxgwLCnt13ZbqGjHrqfxDg5D5TFBQD9Ba2knS6zdHfWXqtrn1nOWnGxq9
	 BretHJXM63M/VLGtw6s1nZhYlFT9SfYti+vhV4/P6GJUZGuq/qJ7RmmXRRd+w66o46GxY
	 xIN6T5CwRG/YpiR8RGgxv+9P3zAvOPR+QLCo4PK/cclNFnxZH+8eoqVX8HN8HvI9Apw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xNdDfVpU;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34086606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 17:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34086606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xNdDfVpU
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd69954c755so1103001a12.3
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071036; x=1794675836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a61JwjnxKGRSd43XgWGH6Kd+4jztQXz3+tYtxQyCkm8=;
        b=xNdDfVpUfFRGBVKzQVzP0a77IDi1NJCAuMhIqRpi9V27zLQrl1aL9uIYfgbBrrGu3b
         IjxIdhmOpwqu+w4e34o4C/YOM1e6CFRUJ5K5Kln3PmGcne2FHhHkRpK4+KhKAjnX1wjV
         a3WVuFSjTmljfIOc1jYyXJf6ltfadBZql4htLNyCtm4kNkKrVyDXcc1Jh2puN99Zu8XP
         cJ/mETBu4b2zfNSuegOCb0VgO89r97L9xATwgh2E/vYkYAZng+NEAgrx1L/GweA8fdPx
         SRJYXvmQFJBkPWEKZIT2gw+4wC9UWDUYmjYw2aqB6zPzLJOnHDW8VceUgNYuP+G2MiSL
         7aBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071036; x=1794675836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a61JwjnxKGRSd43XgWGH6Kd+4jztQXz3+tYtxQyCkm8=;
        b=0SMI3UUe5+NPO5ivY8S2d49iLdNGZLp8gAOaRgY5rkQMdajU8ikid9FWZBZSVKkEkD
         ozHF/gqclg5c9vGS6De7jpYrnWtNKHKK2+shaLcItX1C1S58swqPXrtaTWWHYcpmql8Q
         n+5Q/WZtLI308x6WcQ43gQ1D2UwJvHDX6X4BTebHeWGwJUZSaGwlJ01Im29t9Rn8bTFR
         LLNYxxATxdXKzdbUpRvJn459yp80HrrO0Ut9P6SUVATg31Jw2PuR5Ww/JUgnbq2pHJT6
         HURbnnx8AOo8Zbvw74APf856kJZTM37YwVTiQA6rzVnZFqrtj5Xwjs+xLyYMiHbzTaW5
         urbQ==
X-Gm-Message-State: APuU4Z9ZhfPAPXoRiOOGi/ATnMT0R2qJpPtw5d7PAnCz8ax12JUDA7WF
	Z1XI1PUx15+MTw7Da3vVZ6rzeeIWg+39BcDR8PN7lDWzFIE5a5i37qiC9cmvaA==
X-Gm-Gg: AYBFou3sQJwRZeya/mKCkwi5Cy6zE255AK21A8oPKp4SF7J31K834H3HRH/gP3AR/Ie
	7wtNRHRFp8IxtrNZUtJirTQ6i8Db3wENASlM3hRTMWrfpNhUw+v9VMZ9oquiwwyhn4vhRQ0u+nb
	wYYz2MQp7HVQLFdLtUNqLe4Lhe6yIe5DmeY/U1SKcs58ni2tadXWFsyp9RIQqwopIPyzxdNRNsV
	U676AYIzFop+ydKHt5lccvZYjYflTzeWguCKeBnAQ7mkOS7wqLNDLWqjK+dWeCYfqnPMGWl4Zez
	QkZAo8nbwm+jJESJQzXxnNRYZIZeUkOMVJf25OSLhz9KBj7S4bUen/9Y2O+hx8zHT5RhfN0+FOx
	4LK1RvDRm8RW7BEr8xm30liPMjhi2m9h64AT021/PU1aSTiGZIPwwUeUwbXEZtlppCrXqZBPwYL
	P/X4RGskqgGNGGyhM1w15r1hFne8GF4Cdt09qb5Gd7JCDFbRb3W7SMZLtROoT4Jwjbuscc7i9Bh
	Lc8kR0jy41oyHcNsy/Fvaod3ymNK+7XvzalFSjSoizrnfYzr22rKp8whEr/aXPx9bJ6v3qKezad
	Qp5P5TDhLWqk2LYEQ5GHfGTWJt0Z6X4vK9vSNf/V5PYmmHMDVa+GImCboXdF6nOKHwWbbZ2lyvZ
	2H7dlqkSHAhcikVOuYaOUeYfHMPybKsxdgmbb5/6GnPLXooPEa+6KRKOcu0wyFFgdHFMWrpegsA
	==
X-Received: by 2002:a17:90b:3944:b0:3ae:5572:c4e2 with SMTP id 98e67ed59e1d1-3b0db6fb52bmr4919364a91.57.1794071036456;
        Sat, 07 Nov 2026 09:03:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057fda58sm4190502a91.7.2026.11.07.09.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:03:55 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 6/9] selftests/bpf: Skip plain_c_arena_race without zap_vma_range() in BTF
Date: Sat,  7 Nov 2026 17:03:03 +0000
Message-ID: <20261107170306.2831028-7-alexei.starovoitov@gmail.com>
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

plain_c_arena_race has the fentry prog of arena_race.c. libbpf looks for
its target, zap_vma_range(), in the BTF of vmlinux. When the function is
not there the load fails:

  failed to find kernel BTF type ID of 'zap_vma_range': -ESRCH

prog_tests/arena_race.c skips the subtests that need the prog in this
case. Do the same for the plain C form. The kernels of BPF CI have the
function: no job fails today.

Fixes: b5ae07f77d27 ("selftests/bpf: Test progs without bpf_for(), zero, can_loop and such")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/plain_c.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/plain_c.c b/tools/testing/selftests/bpf/prog_tests/plain_c.c
index bfadbbfd436a..ebdcf2275dbe 100644
--- a/tools/testing/selftests/bpf/prog_tests/plain_c.c
+++ b/tools/testing/selftests/bpf/prog_tests/plain_c.c
@@ -119,7 +119,16 @@ void test_plain_c_arena_list(void)
 		arena_list_add_del();
 }
 
-void test_plain_c_arena_race(void) { RUN(arena_race); }
+void test_plain_c_arena_race(void)
+{
+	/* prog_tests/arena_race.c: the target of fentry */
+	if (libbpf_find_vmlinux_btf_id("zap_vma_range", BPF_TRACE_FENTRY) <= 0) {
+		test__skip();
+		return;
+	}
+	RUN(arena_race);
+}
+
 void test_plain_c_arena_strsearch(void) { RUN(arena_strsearch); }
 
 void test_plain_c_bpf_ma_ttrace(void)

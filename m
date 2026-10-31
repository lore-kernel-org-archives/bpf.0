Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487259;
	b=rQO+RzjrPPWvDM4m8wBjF9P16nMDmkvbYDPG/6xJB+jnTnQgTRyrZYbPx4/+/ITqC64R
	 BLzGS5OmnWFSyyYmf+Hykbzoe7lDp6Ww/yZsCzehFJqsJU+aSXF6yhR0X1XEgmYwZzSw1
	 fI5utoQJRfhEE/sgcL03BktJShTFV5jORFHz/P6Oh4lWNESGgpRVhfvV2/NaDr2qI2RXx
	 gPa1xrHNCRm4fqq4A6wqRQa71SalBu5CrGWzpR/sYl3uifO1ZeSy+4ualcG5XJYVVqR7Y
	 g3zAVP8L8mVVj29oGPhRv7C/ao1DE+sLQuAzihKyqSJajR9ni7ka8ZrkmNTapn41yHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=Z8fT26vpsEDMPRnKW6QzA2H7dh87iXVUMOUV6O8C+50=;
	b=0/8ryrXIr9GeFKU+lxzron2bbXaXRuO7KBT+G2235aM8hB+N3l0DPJjdeG2bI3qK6hKg
	 f+RdeoWNW+rS4E778oSnfkJM4G4lZ6yeC/zzBIMxyPczD1xuDcOMsdqA3DerfIXRcfjNz
	 5pMeNclQxheuSEAkeC+Ngcl8tH1jeipTzpmy6U/6AtseAFJsUPytrNsBt1aQEgCDabCrj
	 XhHvehMfX0UixLtWAgmwplGuptu76IdMpXwEcQjl9wl/UwCdfbu73GcjMR703aGeKPdeP
	 muhlsrKO49olDSbsRzyTp9evU7hGyWlR939UwWldtEFbtf4GNVd2gdz0496E/qhXacA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l9JH1JKp;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD99606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DD99606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l9JH1JKp
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9f6a16aedso11607175ad.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 15:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793487257; x=1794092057; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z8fT26vpsEDMPRnKW6QzA2H7dh87iXVUMOUV6O8C+50=;
        b=l9JH1JKpuOVnqRGAGQhCpCfSchc2IxTEi3pMPwwzzMEqR3/PIvkYpeO27x6B0Vpogr
         yV/4ngakbHpr64ceYOk0SfcPZ0jTojMWQ1QHPcKHJQ3lWT7Me7+HybFR69JETMEHl0OV
         2gGq8Rk18Kl3omz8dSXyGXA5vlpgS7GwY7SGdQk0lLgWB5pgG9tbuoD2izDXylRyTtlM
         ZovSOIARxZ2LaYy0AOszBYrQZxMEsGwelFfyhvLyE7CtU8tK1vE8n7vuYs0DG3m+tHeq
         HIVv5HxW/+rytqtBeaI9LTmCcxeTHMcuGglWT4iPos07jMLZSFtBpa07u4j3zlayTPqv
         ME+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793487257; x=1794092057;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8fT26vpsEDMPRnKW6QzA2H7dh87iXVUMOUV6O8C+50=;
        b=dSKoKH76VsnK0kiTNLP9ol32PBD8/rY1MJ8Crqgbckv52Z2vNnmxfdqYW9r1YYJsYy
         j0Vqct4+ZIkg7WoAZ5V5WwH07TYndWkpYqdyQI4nCCHsXcvoW9rz+G0g4seByXJqyt2F
         DKdMxu6karyHGPzUDW4/5jKu3UqbafpcoO1TvIq7obr31HZ2d5bCxcmMytRPgp+Ms8nm
         TGV3LRSi+ESloCEZoaioNyQdywADiJC1G9dGtEn6D/zYBIiKO0kYFJiUG4bxoTAWnXkv
         T1s7NOtWhFgnLh03u9PGbTMKoNh1nRYom2bB5VBySm/ryy5z0QXIuVFVaY9KvQW39q83
         xUuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzD1PEUPTQz8XQK+bm3gy2NVNuCHzAHSVPQ0vsuJ0r5UvBxr4bOlDisO0Z7boCYzIVlBec=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbj5Q4jbuJCB2po36tO3ievp8hAxVRwQZdMh2y5UgMStLheBt2
	e9IhpVqXCx8tFNqpuxTz0SgaGtmTDFvfiThStFK9egb02StzBk9ZcL6s
X-Gm-Gg: AYBFou39AICFP6RNbxSYvyooa65BKUu2a885v7VOaXm2Xwqv+bN162jVk6RqR3zOsvi
	aUa8+LndaPZiredOJdybzKGNRrBE4UzmYJ8XPByCostgA+w+Zy7eKav3klgmc8L0T3XWtkvJ23c
	iMNzHvph6og7twksTJB8TQ7GNuQGVdztymSmXkdya6Pej+uFIukPq7EaFy1gQYEuwiLs4fN66BC
	G+tIxTbmftL1cWmYzMvVF5VEBqZwxCnhYV3y7JFXExbFuEu0+IKBz7OnHL55G0fDMc5dnJ8CndT
	qwMbYSUznM9WPuLyWRCua9wucAyhhYOjCutV/P+8a6tGaHlJtRDnTxHZXmw7EWb/sNh+tKes6XI
	2zIqoXHiYg0FPtsY9weIRZvdp+2NFYggP1t7pb4xTVX6z6wXwPW6k1YQ3w9g8tcrSNDj0xejBqm
	5R4j/qwiphsM6n+v143+QbVuc5ovE+jHKqtotMR8enMTuOUJyS35QVGA4tmx15uktE5OqQypxKu
	oVyTKEEMqdXRNKCNDdVwWLIK4QL5ZawoN7YwPXq1JNrmhtaZj364wfnDCCYHrjjaeYjUAap5LKf
	TbDxeDbShkeH6e5dDa+gb3I7DOW23HeChq/RhHGIBy+iCRtnHEyWINGAk2ZrRyT9FkBT+RzWrG1
	tHEDZooKzzp+Yr6mOtyXoIiHUnIoWOuzavoBOOAAyAgPRc9NtPzPh/Zo=
X-Received: by 2002:a17:90a:d2ce:b0:3ac:9772:8da3 with SMTP id 98e67ed59e1d1-3ae897f36c6mr5382448a91.31.1793487257312;
        Sat, 31 Oct 2026 15:54:17 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8805ebc8sm4636221a91.3.2026.10.31.15.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 15:54:16 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 22:54:16 +0000
Message-Id: <DMJE6776F9F0.1O5A9ZMKWYEUP@gmail.com>
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: port test_ftrace.sh into
 test_progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Daniel Borkmann" <daniel@iogearbox.net>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>
In-Reply-To: <20261030-ftrace_in_test_progs-v1-0-aa50c5dd1ccc@bootlin.com>
References: <20261030-ftrace_in_test_progs-v1-0-aa50c5dd1ccc@bootlin.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Oct 30, 2026 at 11:50 AM Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com> wrote:
> - commit 1 brings a few new helpers to manipulate ftrace from test_progs
> - commit 2 performs the actual porting
[...]
>  5 files changed, 412 insertions(+), 46 deletions(-)

This is quite heavy for a port of a 44 line script.

Lets use a tracing instance. function_graph works in instances.
An instance has its own set_ftrace_filter, current_tracer and ring
buffer. rmdir undoes all of it.

What goes away:

  series                          tracing instance
  ------------------------------  ------------------------------
  global tracefs files            files of the instance
  save and restore, patch 1       rmdir
  serial_                         not needed
  all functions are patched       only the filtered functions
  new progs                       progs/modify_return.c as is

modify_return has fentry, fmod_ret and fexit on the same function
and checks the return values.

The removal of test_ftrace.sh stays.

Instead of patches 1 and 2:

diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
--- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -61,3 +61,28 @@ void test_modify_return(void)
 		 0 /* want_side_effect */,
 		 -EINVAL * 2 /* want_ret */);
 }
+
+/*
+ * The same test while function_graph traces the same functions.
+ * A tracing instance has its own filter, tracer and ring buffer.
+ * rmdir() undoes all of it.
+ */
+void test_modify_return_fgraph(void)
+{
+	char dir[128];
+
+	snprintf(dir, sizeof(dir), "%s/instances/bpf-XXXXXX",
+		 access("/sys/kernel/tracing/trace", F_OK) ?
+		 "/sys/kernel/debug/tracing" : "/sys/kernel/tracing");
+	if (!ASSERT_OK_PTR(mkdtemp(dir), "mkdtemp"))
+		return;
+
+	SYS(out, "echo 'bpf_modify_return_test*' > %s/set_ftrace_filter", dir);
+	SYS(out, "echo function_graph > %s/current_tracer", dir);
+
+	test_modify_return();
+
+	SYS(out, "grep -q bpf_modify_return_test2 %s/trace", dir);
+out:
+	ASSERT_OK(rmdir(dir), "rmdir");
+}

pw-bot: cr

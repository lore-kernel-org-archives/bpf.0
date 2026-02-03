Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3E7405A
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160574; cv=none; b=qn8G/rpuwd5lCxY1a0wSeu8kmeGwV5L1kIdQASwb/iCbd99dRQEk6qxoktXHj0tBjOQZffHqcte3ssXHePSc3VYRmrR9lO7TBqooqKvpx3rYD34qQH8dOGoiB1cfsA8Xy3grhaOIspeIjzNtUYTe5Q51B59LoCujUM324VGtp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160574; c=relaxed/simple;
	bh=r1f76l2W8lfs2XcZ5GesaC4a6L1gjALG0EmEGjvWK7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E3t3co77hyG+9w1VklKc19YwNaAkmDxhCmAffIB151CTcSJgCHg3KPRfZnZhQjxtLtl9jvrRR73kO5SzD2diCF9oYkq1yhlx5GhZt29c2wobvzCx2oFLOZq5bt7w9Qxa3X4ik+27WJSDvjHJASq7gSL304ZgcIbZKfJujpvZcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDMH5hX4; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDMH5hX4"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1248d27f293so1510291c88.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 15:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770160572; x=1770765372; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=liFpSsTStyEIOQCv34lD2CguoacjGONgmTHEiB9qokA=;
        b=IDMH5hX4u0/5Qkd8EYRs5Hj3OKJmowFX4QlVmC6qJbdx6/LYKitYcKEeYFE+QI1G7l
         UJLQKM26WFL1khHh2WKToFekyYgaoZ2bzGN4UwygIPNy+mNchqeVsxf9ANfmgaXcvIiB
         n6ZT9nTOiJWCAw4LK6pLWkE2zMjA7g7odcxoLEn4fRBuECHonFKg667jYWbGjnjQLq4S
         bhgu+Fs75lWF9na5uQejTx5s9pjLfSVvAaH8RVdX5o2lo9OTa3KUUOV+wC+CXy3S3JPT
         GEa3M25RczzJ3PZOTSWa1RvlEsJpJfZkjSSMAuIlQVOJBhwKbhAJuZZabCuWWe3r/1XF
         TxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770160572; x=1770765372;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liFpSsTStyEIOQCv34lD2CguoacjGONgmTHEiB9qokA=;
        b=aP/XlQFEuq2EnZZ/Ym24VXAE04hZCVBoL39eEeaIHm6WNGkO7qQVH4AMdxF/tor7FS
         aXuccTdm9Q9ByZdF7NqiFWkzVSsmf67hZUU3u2RCbVq9jb2rEsDLsfwjBRb2Wcmyyz/R
         rybwyuK3vWvmfyG9LebtLulNZ2pmMA6KKdGNxubRTW8aGAXYpAqN5rj6KB6kDuKyJQi0
         GLFymG7TAn4/a7S3IPL84duc67wm+iOZCO+1ZR82gnMg/FqVDEpngBq4irC3TrNdq6dd
         8lXbynMemobJUHAgFKHkvfElyjQ1RkSv4rJRf2apUSCTeyi65Jp2zrtqydU9oQ6k+3Hl
         5Iug==
X-Forwarded-Encrypted: i=1; AJvYcCXTBgpKjzmh/lOTkMQ62RGN7Mpb4EcjkVxkYngO83pPCXbavEgzC2wVg4eA2plvEvx2u4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1Yi2Ph3E++1PoYA+/Vp0byaR4DWVEaSOLbU38AUr1ij9/Kel
	P7rTAw238kxpLV24iKumf503cnqGLoOJToKwekwkIpG4pbudLTZD+ayO
X-Gm-Gg: AZuq6aKh95sneKi9hUdw2Ri1DYotZbXKZClgI6hbilxYi4LrDMSD/esY6EMMBjhjMwx
	S1UKI/MNtrN+dxWKkl9XpT/7vP0qNkwqKv1KNdFdZXJfK81dxwvPS3ZAtEe5cba5Cx0oRy1Z9Vs
	Y4tQ2s9S6cNQxSvIInBDy94Q+e92eWlvf8Yg/xOuHTAIrTfPcLnHj6WAUMPM5ohOF+UvYmduEq+
	MxSOcZYKxI3ZuM/h8+JIbicVTa8UCBgsnsKoS1JO4KUwfHF/oCehywVmwbjKovPvukoR42n5UPK
	hDQ44/CqWwY60N7Dw4C6cazL75LaxirCeQMxGxTE6WBrWK56B6IDjVb8eUDBTYOo+MxFKp5RjZK
	Jr1rreolM/eNfpbC6n4VO2YbLKRcF7U0b2FPJvrkgEyPPiPtZwZUG0ex1yKqizXssZZnoIzsATS
	ia7tiAVB8mKk1icME2YHOUtrHyDsXJWGrO15UUZ+8LmTbbb7rJhhY14/j3sf7RU1kIHA==
X-Received: by 2002:a05:7022:325:b0:119:e56b:c75a with SMTP id a92af1059eb24-126f47bcfe3mr571073c88.31.1770160572095;
        Tue, 03 Feb 2026 15:16:12 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:60e8:c921:e408:133f? ([2620:10d:c090:500::9470])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f5030b01sm654333c88.11.2026.02.03.15.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 15:16:11 -0800 (PST)
Message-ID: <cde3706275830169d289d664d425df1a47b50f31.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for BPF_END
 bitwise tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tianci Cao <ziye@zju.edu.cn>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	martin.lau@linux.dev,
 sdf@fomichev.me, shenghaoyuan0928@163.com, song@kernel.org, 
	tangyazhou518@outlook.com, yonghong.song@linux.dev
Date: Tue, 03 Feb 2026 15:16:09 -0800
In-Reply-To: <20260203102015.5570-1-ziye@zju.edu.cn>
References: <b68a122d7a0b046a9ca5527bcf9f50dfea183ce9.camel@gmail.com>
	 <20260203102015.5570-1-ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-03 at 18:20 +0800, Tianci Cao wrote:

[...]

> However, I noticed that using macros does reduce readability somewhat - t=
he test logic
> is now more abstracted. Given that this is test code, do you think this t=
rade-off is
> acceptable, or would you prefer a middle ground?

Why not like this?

#define BSWAP_RANGE_TEST(name, op, in_value, out_value) \
        SEC("socket") \
        __success __log_level(2) \
        __msg("r0 &=3D {{.*}}; R0=3Dscalar({{.*}},var_off=3D(0x0; " #in_val=
ue "))") \
        __msg("r0 =3D " op " r0 {{.*}}; R0=3Dscalar({{.*}},var_off=3D(0x0; =
" #out_value "))") \
        __naked void name(void) \
        { \
                asm volatile (                                  \
                "call %[bpf_get_prandom_u32];"                  \
                "r0 &=3D " #in_value ";"                          \
                "r0 =3D  " op " r0;"                              \
                "r2 =3D  " #out_value " ll;"                      \
                "if r0 > r2 goto trap_%=3D;"                      \
                "r0 =3D 0;"                                       \
                "exit;"                                         \
        "trap_%=3D:"                                              \
                "r1 =3D 42;"                                      \
                "r0 =3D *(u64 *)(r1 + 0);"                        \
                "exit;"                                         \
        :                                                       \
        : __imm(bpf_get_prandom_u32)                            \
        : __clobber_all);                                       \
        }

BSWAP_RANGE_TEST(bswap16_range, "bswap16", 0x3f00, 0x3f)
BSWAP_RANGE_TEST(bswap32_range, "bswap32", 0x3f00, 0x3f0000)
BSWAP_RANGE_TEST(bswap64_range, "bswap64", 0x3f00, 0x3f000000000000)
#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
BSWAP_RANGE_TEST(be16_range, "be16", 0x3f00, 0x3f)
BSWAP_RANGE_TEST(be32_range, "be32", 0x3f00, 0x3f0000)
BSWAP_RANGE_TEST(be64_range, "be64", 0x3f00, 0x3f000000000000)
BSWAP_RANGE_TEST(le16_range, "le16", 0x3f00, 0x3f00)
BSWAP_RANGE_TEST(le32_range, "le32", 0x3f00, 0x3f00)
BSWAP_RANGE_TEST(le64_range, "le64", 0x3f00, 0x3f00)
#else
BSWAP_RANGE_TEST(be16_range, "be16", 0x3f00, 0x3f00)
BSWAP_RANGE_TEST(be32_range, "be32", 0x3f00, 0x3f00)
BSWAP_RANGE_TEST(be64_range, "be64", 0x3f00, 0x3f00)
BSWAP_RANGE_TEST(le16_range, "le16", 0x3f00, 0x3f)
BSWAP_RANGE_TEST(le32_range, "le32", 0x3f00, 0x3f0000)
BSWAP_RANGE_TEST(le64_range, "le64", 0x3f00, 0x3f000000000000)
#endif

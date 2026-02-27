Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040828C2DD
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153850; cv=none; b=XV4Kvf2vB3n5PMwUYC4eui0lVkJq550/rRRhkWlQVMlJJ8Ev9ACKfMuXmcLXQ5qPiXxqHG7pmsTJIAbGC7Es1rTZ4AVktW9Ym3ked+H8WTRLxXR2wbuwKFJ6R/yWc1mZEcpCLDEB96453O69InMwB+Ec00z9P03cCI7ym8QAM/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153850; c=relaxed/simple;
	bh=yvFcvYsUr1bme90hcxAbAS136wU80aIwVWyB8swZVSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLlTHrkAEn3Qex0cfIWthdYCQdVYVtW3CeNcRmYbrFsjUJqZHTQf7IOXemFBS8/Sd50SX9ELD7vDd8TAzxAe5kJF3IkYYHUYX1/LTdldTxBVdG5ynyDcLNt8iwn0SKY1B4zNkxxZteP02I4aKjk3HbgJYjw5gCwKG1pypIcF8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjA+HA66; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjA+HA66"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-4645dde00a7so2889635b6e.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 16:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772153848; x=1772758648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=id2/c1pGCLRMZrKVmrba8N4wylZbYX8sgM1MSD2WUz0=;
        b=fjA+HA66jxBvBZtr12Y5QVExhP+8V93iRDj2AugGF7ART3HR0tvwJNDYDKCWMm2Rms
         Spz9R9Osd32n/mfYw9fw4VwuUtssUnsjDNWbzTFpOaozBKL8Ixm9c/9FzrJAFD7Rxlb0
         6600/pGf8l2vIhowKcmNinVkJS3T9N8r3VI8WslGwzONC4or1nSd+aJh/Pcrd8SvvRqQ
         0LFzWRw7VBAC0f3hu3s6h0s1GrXJdOSrW2cJN2GoHw8l9PP8c1BLr+IJ05O0KNTX7mAs
         3UAQDVYU35heI3qOhGAAoxQaO1GV3pZpCEq+zvlvN2fSrc+XP12RtYV4ujJPQnLNb2e/
         cIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772153848; x=1772758648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=id2/c1pGCLRMZrKVmrba8N4wylZbYX8sgM1MSD2WUz0=;
        b=bUK8/Hc6K7XN16uI1iDB3S+BqfpJUKgOIOyN2in4uNBut0GlZ3CapHfxZjtdxyl2FY
         QCNc1NseyaZc+UDKAmqv1tWyWhbmzmKdza/Z0mXSc54jw49HO2UT5RGpLu+8KapfsD9N
         DU+hgfS0BaUEQamw1Dltcfvjf26bxtwG6kZS3sxcCCxXVFRYouK7I0ZKw7dxE+rcBwLK
         umveV51iwk++iDdIz9M/X7gHDzP4jtJ7KjnRkd067fsYnDuCJ9+qPmkwBsyaRTgo40al
         vgZy1GOn31GEB4wmviwna7PBkKKVv63E1/7HSyltNkPvbh4CNYtxAI3BWGiYX4uSFIPO
         vOiw==
X-Gm-Message-State: AOJu0YwoHqN7v2sRFRP1SNhoKyJGj1V/hIDBC6BSCxxIcuH8crBAridj
	fuK/9NlLiALjeAar2lT5DN95SmBR/LnQ6lM6MitKs+oaN4tDhRmv23+5PfI57IKyNWk=
X-Gm-Gg: ATEYQzyGZwtuRileYHbFxhZttV1b6a6RdJw0a7xhdXxPsYXBQROh5s8fFQAXIq7ZHuR
	1qYDhDE0WX+P5mWMtjeRAKLrYDkFfjUqBl7BZQMcb0KXFt5lZbFZx2n+jBzrFUcmj0FFVseJ4BV
	D3TPLkz7KxYH7MTxRsVHFgrcUNIomTyOtJZ6UoBGt5n3TZmQFSnLmdWR5ZxlF039dgjfRZJF1++
	3zM6gwvz0oaMBkDa5o0FEwi5GSilv2BtwO8qal+f0m8Acovq5n0ZghpGU8CLxmjn4ThPDmQY8XU
	nDFyM5L+TNDscGseyY2+VCC9ls/Iv3iZFOgskVhOh1y9J4ijPKSBJJgeyZRHcCNyVCgmQbnCdOh
	f8swtlBe5t/TPP3NgoK/b/GzRR34LH40JkUoZfmSvU2cHi2rD9cY0u7T+gwJlu+nlCPfc1V1s4h
	Sms78Hoo0FVOSaoQm6Q7+3lhklVH48LYzIHEgSa37Ml71c
X-Received: by 2002:a4a:ee0a:0:b0:679:dd8d:1c0a with SMTP id 006d021491bc7-679fb471734mr671161eaf.15.1772153847861;
        Thu, 26 Feb 2026 16:57:27 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d9b7bfsm2536512eaf.12.2026.02.26.16.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 16:57:26 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Allow fixed offsets for PTR_TO_CTX
Date: Thu, 26 Feb 2026 16:57:23 -0800
Message-ID: <20260227005725.1247305-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=556; h=from:subject; bh=yvFcvYsUr1bme90hcxAbAS136wU80aIwVWyB8swZVSc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoOuAOjiMOHCjCYQyA51XLx0gAUzik+FdFVR355wW OjHZfciJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaDrgAAKCRBM4MiGSL8RyipHEA C7kfQMQNYI6bppc+OFto77XNBUAz9ygkm/DI8MuZPT7cCnuaTOFQQvPhmk4I8H8Ad+5Axl1c1Y3Rnk WPVEPwoiEbQAkRpFdxVQkfc8RN/SY+KFZlmTXxL2cOYA8AfLxQuVO2hKFNdMT6mCX1Qb4c/Qfpg8xk UTHIF/1zNTiGSj0ZYdSJQ9sd6QuwSeszZRWIUyZc7B/t9JVbS6B7PF0s8C1P4tvnxqHAxt3fvdgJRv cVIptRxTx2gXsEztaW2QNA3f3AC0JMBjcWk77qwtiVRnH5fmzxehsO7/r/1x+cbXL2ctSVqRZnadMg SZVAAnVFlF/pUvC03r9fRmoiKsmPL3ji45YgKAaPeUWe3I518seyQaFPlsw61q6bGYtEra+KEprb6d sBmLZUexK2iuZ3+hjo7dFuhkkvoKXF09+EPacu1JX2i19SxkafF03+YJcwgzX4HNsyzWqLOYqxXSTD zIo1X8i2sO+yOTNAqReQhYdH3uTxLv4W3TXUVSdRf+szTKqcwbWebPe0h10nvn5LXQ1ycLzXP3ArBZ TmqZUhipMD+StyclIPkkUiNCfk3cYRvTg5Cuo7p4MHxzLbzb9veum3UZI2vNTy23t0WgSo5UIwWod8 wDxVQDq/eS8LRo+m0cdFEufsWe8MwGttofueVxKZw/beoVkuARF8+ByAzhzQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Enable pointer modification with constant offsets accumulated in the
register for PTR_TO_CTX for programs where it won't be rewritten. See
patches for details.

Kumar Kartikeya Dwivedi (2):
  bpf: Relax fixed offset check for PTR_TO_CTX
  selftests/bpf: Add tests for ctx fixed offset support

 kernel/bpf/verifier.c                         | 13 +++-
 .../selftests/bpf/progs/verifier_ctx.c        | 76 +++++++++++++++++++
 2 files changed, 88 insertions(+), 1 deletion(-)


base-commit: f620af11c27b8ec9994a39fe968aa778112d1566
-- 
2.47.3


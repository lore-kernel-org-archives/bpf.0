Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593B1C683
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147595; cv=none; b=jrXFGUAzTIl8KN6WVboVXkrZffmiKB+aP3q/XRJ1jtwlz7g9oEurXqsjLqc+ciSOHF5s1Z9pxW4a4UK1H5bCVT5IalzEk4pyZw/DZtX5oeDrF+k0WdoZzYtli52MB2hKzFBzUALFIQwO9Np30NDdw2crvMO8dYjukS2OOEwHRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147595; c=relaxed/simple;
	bh=Q/ltXT+BpwFO/h0wqGFU0jolcLTzV3uFIe9qgC3XJZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mzeNNhEfMEJtxAP/fhVMgaJsZqn3enXUSvF5XQ2ouMtLX4rSJB5ua4ancaKZkA7xg0YASUMJfZ0RDXprXj/iuz/3yOi27zVvZx3SmYfbIreUDTJlN59d9h5w7yOyGCjPwAATGRK/5ldorrj8SN5Odtyd8Xcz4zmCToo/DJEGnwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=CHoF4EB1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="CHoF4EB1"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4e60a64abcso148353766b.1
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1712147592; x=1712752392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nWZYj7rCEid76Wcm9RKbiLWZ/1nR7cWjb24KGQVqXkk=;
        b=CHoF4EB12P13LGirzUsBqNd4j+ojJ4xdwv2mf9FJLWLjgpkwzDR9zYoTOFWaEb1Nl+
         mOmRympP73cGaS4N9gT3/Y08iTOtckZWzrtaZ4e1/UteDfqSN0ugCV4N14oblEURUaCo
         E3B5blVYICvhGm6r+h4Q5JFFkMaQSp2z4J7+eifu9RiVZYCntqRHx/F+sMwR+6kKD49f
         5vjp6WTrlHjoEmn0PJjBnZtnLIoKHPe9Xpk4n/NwE0rBhbr5/I/Us9bp0T9hoJ0iSpNZ
         BQHcSguL0HSBjFyQmoqHyQMCY1Nh28ZPPnIeII6qlWfyB/7t8IAZYEa00d3rG46cVTwQ
         4zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712147592; x=1712752392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWZYj7rCEid76Wcm9RKbiLWZ/1nR7cWjb24KGQVqXkk=;
        b=owuLK/IIM3isO8otikpV3xGJQyYBvdsIF/WUcbklVzmiSVBl6U5YvVT5kfc2ZXBeaC
         tvJI7XnGc2SEtBGG/mm5pSLq7ZDXl3Eca8HYp3LDIFBZyZqDzHrHJnrIUcLomIXblFyP
         /0Lg018dGaTR85U+ozfYT8muywJLglwT64du4rwZn43rk5rhH4g9F88EtRxIcR6UKskB
         TKII301jHVpSmedtcckQ71uIotiTTcPARPLkRCdYNzxurcpCh14XIIl3N0/vO7W/BIca
         rNK+l6owwUn0W/DKtWedadZ3HHF0zY45hB0PVlBaU1gpD1uHvPIQ2AxU1IFOjG7lfyq1
         jc4g==
X-Forwarded-Encrypted: i=1; AJvYcCWu2/xF/BNG7kXWQUsAk4XSe9nqRooJEe7HZRPTF/XJhMdrA74WXRfM2Zmaf2SWal2kgkSqBPW0PHQnhOfPFuDkBKTZ
X-Gm-Message-State: AOJu0YySeD6M0I1ZQ+CvgqRCCtlsIpJRb8e6BziGwC07GO1aMW7S8a/5
	TOEqTkokQUPklzlybJN/INLtOkd59iqmjpcPJH4CRwPM0keXumw1WqpWCb/kjW4=
X-Google-Smtp-Source: AGHT+IGCJKnLv9iC2SM5hjXIBJiQ2UzBRBbriqY3loIDfjTvCjWOUqXXwXCfGtmqsroQjqDsvbKsaQ==
X-Received: by 2002:a17:907:7243:b0:a4a:36e4:c3f9 with SMTP id ds3-20020a170907724300b00a4a36e4c3f9mr2773424ejc.7.1712147591693;
        Wed, 03 Apr 2024 05:33:11 -0700 (PDT)
Received: from lavr.home ([2a02:168:f656:0:c6fe:aab8:1c7d:aaee])
        by smtp.gmail.com with ESMTPSA id w20-20020a170906d21400b00a4750705a07sm7700949ejz.190.2024.04.03.05.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 05:33:10 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH bpf-next] bpf: pack struct bpf_fib_lookup
Date: Wed,  3 Apr 2024 14:33:03 +0200
Message-Id: <20240403123303.1452184-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct bpf_fib_lookup is supposed to be of size 64. A recent commit
59b418c7063d ("bpf: Add a check for struct bpf_fib_lookup size") added
a static assertion to check this property so that future changes to the
structure will not accidentally break this assumption.

As it immediately turned out, on some 32-bit arm systems, when AEABI=n,
the total size of the structure was equal to 68, see [1]. This happened
because the bpf_fib_lookup structure contains a union of two 16-bit
fields:

    union {
            __u16 tot_len;
            __u16 mtu_result;
    };

which was supposed to compile to a 16-bit-aligned 16-bit field. On the
aforementioned setups it was instead both aligned and padded to 32-bits.

Declare this inner union as __attribute__((packed, aligned(2))) such
that it always is of size 2 and is aligned to 16 bits.

  [1] https://lore.kernel.org/all/CA+G9fYtsoP51f-oP_Sp5MOq-Ffv8La2RztNpwvE6+R1VtFiLrw@mail.gmail.com/#t

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 79c548276b6b..6fe9f11c8abe 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7157,7 +7157,7 @@ struct bpf_fib_lookup {
 
 		/* output: MTU value */
 		__u16	mtu_result;
-	};
+	} __attribute__((packed, aligned(2)));
 	/* input: L3 device index for lookup
 	 * output: device index from FIB lookup
 	 */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 79c548276b6b..6fe9f11c8abe 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7157,7 +7157,7 @@ struct bpf_fib_lookup {
 
 		/* output: MTU value */
 		__u16	mtu_result;
-	};
+	} __attribute__((packed, aligned(2)));
 	/* input: L3 device index for lookup
 	 * output: device index from FIB lookup
 	 */
-- 
2.34.1


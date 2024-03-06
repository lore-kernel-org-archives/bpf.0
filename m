Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F37D11CAB
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695190; cv=none; b=HLFqGti5j6uZXmHALgt6K5TMIWM8dWNCKr74qslm70uvU1MaCDjlS87JJS0q5avPnQcmmjY0AUM3Gey+RsWgc1KYadSdtUBkh6fZKejjXrKVrrBgaHg+Z1/Atj9CtFOuGXxJeokAyJdd7hKG93oTi5d6vLPp/Iazj3npco6V4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695190; c=relaxed/simple;
	bh=mCa42/Q98qGiGrElS19uEf5wTtmbxd6P3lHNZbxLTmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CUIkiCXbsS18MJL88vr7Skn81E8FOB/z/kB4Fr7JikmMc2LoWTNpujpAX6Zb0wwdO6FobQ7WmhsgbFqL9gLlCY9sP8MWXPh651JUTfz3d/OtBJ7xJ0WqqpGiEyKcsf7Z/a+tmciyexGvIzjZSPOjRIlzbjyFR01QMYmYvV58Zf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTtt15Zx; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTtt15Zx"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so5634994a12.1
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 19:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709695188; x=1710299988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1XGjkNPdvKETGMdqvp5/vYhVvH/XT13ZLHghy/4+Jo=;
        b=LTtt15Zx8FUunyTIdCnRVglJwvCMII+DBJ4jKtEZG0V8r0gHtBGYoR04kgy3dVyai3
         w3QLJDJlnODtxa+cI/POLL+4oc/AMyZOTVsmey8Ez33GRG1RMqv8b7onKMdIlYeKmuZ4
         LAjYv26HPUsOw2+n72SjFsmryFcazmAFNMg3JWSn6Uc+DxDrv17NqKtrAB9yO4jXXJWI
         2BGhq9p4DK9aqR4fy7uDd2+5Z7jkthNFM2AwLS+6DWIscolBZQl3IvUG8w/Gzg/vNGWL
         nSk5ToVNS863PUJ91FF5ugX4jObwNV0dYsMckRveaq6jaB9q23L4uYJmkJOW0iP0v5Sa
         SIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709695188; x=1710299988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1XGjkNPdvKETGMdqvp5/vYhVvH/XT13ZLHghy/4+Jo=;
        b=uBuHEVYE/SRqILcp+xunI99CCrKTfduVlFZ0HDXTBrDSnNsuPuFQyX5wmD9KUDdqvn
         MPaEfx8jBYTCAU2IjSK09O7n6D3p1TbX5wkALzSSX02PcIXAtna3ciMU6ebUDVKuEgRn
         HZvwz1FD4GeAXfCt89QzdU7GmjPSH9fvdQVWWdoJeTnXl/BwBVU0XrhuJszlwS+1K84s
         VTjNRdawrft1YjpwLgbd/eGJqUYgmFR+wLMb1MXwGwFbFMNfBI4Bt/BQGmfOiuslNclQ
         XgOAWbpxjUrZMcQ1wKnkvrr45KXV0gflW/g4GMMyMWRSFDgLdUJmr3IhdVc6dC+d4P9J
         L25g==
X-Gm-Message-State: AOJu0YzclWJwRgoGGXGHfeWV1C+jc+q2WmS5UeDWnx9PgQ3BmuyQAK9b
	BJf7v6YyD/7G2ybFJpPWQTNF2bEiYRv6mQ7+CjgvY9h0f8zsen+4KXsv+RYh
X-Google-Smtp-Source: AGHT+IETc6wq/2rpKhg7v45ZGVlWHEL7Jtg71YurpAqMGt/V5p9PcnA2RWSAZPAqRydEMDe4TkIuyQ==
X-Received: by 2002:a05:6a20:d395:b0:1a1:4a48:d7b8 with SMTP id iq21-20020a056a20d39500b001a14a48d7b8mr4876885pzb.31.1709695187863;
        Tue, 05 Mar 2024 19:19:47 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:52ad])
        by smtp.gmail.com with ESMTPSA id p2-20020aa78602000000b006e24991dd5bsm9951120pfn.98.2024.03.05.19.19.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 Mar 2024 19:19:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v6 bpf-next 3/4] bpf: Add cond_break macro
Date: Tue,  5 Mar 2024 19:19:28 -0800
Message-Id: <20240306031929.42666-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
References: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Use may_goto instruction to implement cond_break macro.
Ideally the macro should be written as:
  asm volatile goto(".byte 0xe5;
                     .byte 0;
                     .short %l[l_break] ...
                     .long 0;
but LLVM doesn't recognize fixup of 2 byte PC relative yet.
Hence use
  asm volatile goto(".byte 0xe5;
                     .byte 0;
                     .long %l[l_break] ...
                     .short 0;
that produces correct asm on little endian.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 0d749006d107..bc9a0832ae72 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -326,6 +326,18 @@ l_true:												\
        })
 #endif
 
+#define cond_break					\
+	({ __label__ l_break, l_continue;		\
+	 asm volatile goto("1:.byte 0xe5;			\
+		      .byte 0;				\
+		      .long ((%l[l_break] - 1b - 8) / 8) & 0xffff;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: break;					\
+	l_continue:;					\
+	})
+
 #ifndef bpf_nop_mov
 #define bpf_nop_mov(var) \
 	asm volatile("%[reg]=%[reg]"::[reg]"r"((short)var))
-- 
2.43.0


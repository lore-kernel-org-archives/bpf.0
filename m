Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B547945035
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614357; cv=none; b=HYxH5IkxxZT8KEkPJWeoL7cMO9vSJv8rbyJ9TawfXpsWCas4wKTYWG0ncva3pJ6m/EZNi91f3qPbicCj/RNJ5ecYG1OMkvoKIMn4IY0imzgcpY7h/XqHrhOgWeJaviRF9zMbV58wQbzXeBBzRbBYMkR570qeGUc2xKicqnfGfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614357; c=relaxed/simple;
	bh=mCa42/Q98qGiGrElS19uEf5wTtmbxd6P3lHNZbxLTmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aLAMQMkG7MQ3RU6Gk/Dr+y/kzHf9R+bh4QleHRHuqGBGvK41EM9BAZPs5wPZQwAixcW4niUYQph3mSqRXBnyCpCFVVM6BhXDrEl4zhIIpZ/VLfESsA6LI7YDpzwDfOEOzz+eNt575lIRRSRXDkLl7J3V8DW0XdPmhW1tDWBGBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/EriwE2; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/EriwE2"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c1ea59cf81so1098183b6e.1
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 20:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709614354; x=1710219154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1XGjkNPdvKETGMdqvp5/vYhVvH/XT13ZLHghy/4+Jo=;
        b=d/EriwE2+R0WbhqccBKuTnIErXADMr49FsrtC4C/Wr10s/AZWE556qRFjt7pBD+GfT
         lIFP2mjQN/ZXQWlxkq3CRtUjJTBXogyQ83y+BYOazyeaUJXvIzmT4ByElSnJmmIs+AXt
         7jjI6jViVxrMXiIN/B7SnBWcEdxI1wphok9vXHHCf3afxoHdseiPGyoqFHMNB8GzsCv+
         toi4ARMloiJic7HdW7S+sT5yBCmzOpz4HJcjl4016zHJFCJYVzfLlERJBQ5QAgxswvjG
         IFfLas7TAymRUO4c4ZN6lPMhf6xEHPcbOKRGEY4TK6nlN6Yihn7i4EVj/Xd10mCgZngX
         1XmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709614354; x=1710219154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1XGjkNPdvKETGMdqvp5/vYhVvH/XT13ZLHghy/4+Jo=;
        b=GVVtVZcP/VMkoFkVI1aLXfcNj8FAZlV8FOgyZSc6cgDDdOpaNIAhDjrH/q11dgibYq
         qavG1lVR5tnRmOOoU6nfcWGM+Arms8gxJRKgJr6AfFV/rXv6jt35OdK48EV/c4fC9btA
         a+Tfe+Et8YhwlyRaSwYbmrnUV9bi1C3WMIdqX/iqQcaSBtaka5s0AYUI8grc5qJJ3na6
         BgQ7BlgdAlnDEBQhDBSGzIXyXlBpLXxqvEqivGb0KvGneSNI9kAnPbz8JfONWxuwdYun
         nZtxhHzbPxevuFzyP28Pu5sMxSldJYyuKkGfCP5yTg/h08JGZfG8LiEdTIqS00N/X877
         5CcQ==
X-Gm-Message-State: AOJu0YwyE4mwcl21DH6B3V0c/k9h73GsauqmeJ7hN3rd6mCFe+72uMKk
	/Vz5CBE1JOggYUuWWCoGsERZSSHWnfuVKTnXRfuYYw+2XCExz5raDu5dklnu
X-Google-Smtp-Source: AGHT+IEJbiQolKj0lStTRN6Wb0dFzQOJm1vzDvBRYwfF25e4GXp70PnYNvLyMO0xI3WEuBGGnEvKnw==
X-Received: by 2002:a05:6808:8c4:b0:3c1:eac5:3b5e with SMTP id k4-20020a05680808c400b003c1eac53b5emr775251oij.7.1709614352497;
        Mon, 04 Mar 2024 20:52:32 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:9426])
        by smtp.gmail.com with ESMTPSA id y11-20020aa79e0b000000b006e537e90f91sm7986117pfq.131.2024.03.04.20.52.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Mar 2024 20:52:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v5 bpf-next 3/4] bpf: Add cond_break macro
Date: Mon,  4 Mar 2024 20:52:18 -0800
Message-Id: <20240305045219.66142-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240305045219.66142-1-alexei.starovoitov@gmail.com>
References: <20240305045219.66142-1-alexei.starovoitov@gmail.com>
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


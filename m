Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T44MvMZB"
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC19CF
	for <bpf@vger.kernel.org>; Sun,  3 Dec 2023 17:13:04 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d8481094f9so2208227a34.3
        for <bpf@vger.kernel.org>; Sun, 03 Dec 2023 17:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701652383; x=1702257183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDXnBjtbC7OXz+KEjhRQvJJc0VVSLufkr3cTWwuURwI=;
        b=T44MvMZB5KGne9q9BgFYtS7EodhQFOhtjpetbklbTY5OE0yfHGOxN+nUj/Q2/5RqXv
         8qWbFOCmpiaVHDlTHvtMV1e3gUFDCkK60F4Fc1y2AzxStpQffBaoUz6SRI8JuVkQ+/1X
         LSihTuM4MdMOlUiq7Er2ztLhYWqGFDq+VSzO4NsaxfJVwQ4VJ4zsuJDtKtU8e1+GbyEC
         MP2SOhF2E0mplRhdRWOksVsiju+ZCIPWNrtfCneQYZzgSGIvSbgksTRNp99MNLNBMqtH
         oMHo+ct4V5DsLjevaWC+jaasFKYUiJZphK6anLmyV8oicXsLP8PNKuJZWkI+fVqabVK7
         58eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701652383; x=1702257183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDXnBjtbC7OXz+KEjhRQvJJc0VVSLufkr3cTWwuURwI=;
        b=q0SqvM/uHIjSHIxxucKoOr4PpRvV7uPBODmfyriGe/3KhdrYzdejG7hP4bip/FmKJY
         mrBP4BHNnfWN5q8paY2Mb7Yz8XzvcGqj0HY//tqAyTQZSC2l6fp3XUBx8z4vjX8NS4Bg
         6QNxTi3wg21iCVPFZtwiiyrEnRy8QySs7OHvLIN84XL5GU1Hvb1ClbMbpv86pipgQsZ9
         SwT4DP08udCJ79vmB9EXkmXGyfHhWzeYsNm+NsVCLjCvBaSM1UiO/sCGf4mM7+doa4YM
         v5vdP7hMRStdILZCXa/iljbw9fkr/pKE8Z18uk76WzIkvaynWPHuNeoU102YrogX15si
         TkUA==
X-Gm-Message-State: AOJu0YyjbF0sDvPyMF0AOzaEs0Yr+5G8UWKgJ6HDjSQeRqtNU7xnRWnC
	HzwsVd8trhE06NcycTcqqSY3BDC/5+WHJw==
X-Google-Smtp-Source: AGHT+IH8u7Sung5KSNHdqQUbAeMv9mo+Rd59pzKHsVIrSrEiSUkwUTGMyxN3uI12g+OKFJ3vwOywRw==
X-Received: by 2002:a05:6830:1110:b0:6d9:a2e4:c5f1 with SMTP id w16-20020a056830111000b006d9a2e4c5f1mr538978otq.16.1701652383091;
        Sun, 03 Dec 2023 17:13:03 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net ([2600:4041:599b:1100:b3d4:94c:3d56:e9ef])
        by smtp.gmail.com with ESMTPSA id de16-20020ad45850000000b0067aab230ed9sm1836537qvb.21.2023.12.03.17.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 17:13:02 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf] bpf: minor logging improvement
Date: Sun,  3 Dec 2023 20:12:48 -0500
Message-Id: <20231204011248.2040084-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One place where we were logging a register was only logging the variable
part, not also the fixed part.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af2819d5c8ee..9cf410fd63f5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6834,8 +6834,8 @@ static int check_stack_access_within_bounds(
 			char tn_buf[48];
 
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "invalid variable-offset%s stack R%d var_off=%s size=%d\n",
-				err_extra, regno, tn_buf, access_size);
+			verbose(env, "invalid variable-offset%s stack R%d var_off=%s off=%d size=%d\n",
+				err_extra, regno, tn_buf, off, access_size);
 		}
 	}
 	return err;
-- 
2.40.1


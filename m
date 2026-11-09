Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235135;
	b=SYJISouC3iY/AGI5x6Vgbv9AoQYL8Xei3s1+kBgJyjCUuQV7iEf83ufy55Qkwqg9ENBI
	 uMbFoeMF9hLyb6xyd0pXNRp7XuvNT/gRU4q4V1wOdT6QJSMK4yomcB3ezuKuB+NmIL8yQ
	 03btYkeflFfInWs8Cx5CBN6nnVVp+Q3VXnde9gUxKmVdTR2m1M+0Lf82jjbU3AqEef9T0
	 BaTiUhGeSXqADpsEHRagL6HdPRtVLaWnKF/4JoJ2fjxgiWi5NGH8Fo7vpISIzFEcRcm5h
	 oL3QlVpGMXkt7wH+E6ztG5w4QF1GF0TnH+2gXoLKxvFnPz9KBp1yoO0r9gOg1dJ4QNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MC7laDpFvD5HoSHVamTEOzw3wKYCyM6X0vAnuJqfH6g=;
	b=YzXmYz9/WX1AiUvP/RFSeAG9C4JMGgZpEG3ywRRJ7dtClfFy8azSAtBzre4YgZPCaK49
	 XON6/ClcXcG7oLfFyP0TJmDi0PSYPwoVzm4bLvktQ9qmeB8Tp/nihAR9Dh+M4nA+pRUjc
	 rkPbXJwRhf2jTK1dGExk2cIEs5t7xqgUSB6NtOVIozuEwxkf89urZiK1m1hFQNjCIWRLl
	 PU2cdnJpGSaHyh0EnQfBItBi4UYyYcDzML3KrhYLq5wKIqiMAK5Ca7OWpKfeb0DwcLDex
	 7EJGyD+GUROQU44CQDemLRvr5mjxeQlHtMAF5Os7i7aDoUuaSBE/AymVSI6RwsRsq6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eTvgiOZ/";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5287606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 14:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5287606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eTvgiOZ/
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso6405965e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 06:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794235133; x=1794839933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MC7laDpFvD5HoSHVamTEOzw3wKYCyM6X0vAnuJqfH6g=;
        b=eTvgiOZ/pHqWchZ8MLiwLCevFFiWQnhXTD4d+GtJ4VfIvMzwa22uZdnci1m5e+vR6+
         9tdkhoLWg+9FZBlqjB0WgZBXvVeRAyiI82xuu0Sg47Dx06Ki7CsSL/XXmBwEW+6ZWRs7
         jlHtw908doAoCWrtLaJRjVQ9fgLoTIbTJa/xPoi1S5ZuIbX3j6h7kaI6RRvaeQJGo/li
         SZYY57irqta1DaJDDQxUYAWnoeVvKq+MExpq/AfO9UfuIgIyip7imUj2QEBEpBdfAxcI
         dop2cRxEKgeAt0drBTIkXi/uCAtzRMfyJUONtYOrkV1wivP8BpwsSJUzn0OFj/1rLBbg
         mFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794235133; x=1794839933;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MC7laDpFvD5HoSHVamTEOzw3wKYCyM6X0vAnuJqfH6g=;
        b=NgjGld4u6FImQphFCvuPwTz3/84jD/gbWrzsLPF+6MBQ9UipipUB7nfAC4hiliy139
         kJ1HvLB0wFUH3W/4LQ/Tf96e2mUqgBT0VlVIb6G0+rjjbRnyd42bC9XnIJrwdj16e5pu
         gUkhK2cF3SxJDQzmPrJawCNYeISj7rrB2UWwPN58Hwy8zh368xzbwXIL7RFCcQyjJPKH
         /+YMlBDvcE6VXlZZRvHOUVxeSL3iyjqDE/XhqDN8+x+Pho9O6gaF0aUfJc4FyUuvMqoQ
         nNevVL3uUApX24HJ0IpPB9H6pUfnnrpvqZ98+rz2rdNFQrhVl4hz1ys/6sOflNN7u/Qp
         Hf/g==
X-Gm-Message-State: APuU4Z9Pyd8paUx7GLiNRLT9AMFncKpFmzpfUJuEutoeQN1AJcDTEnKT
	wFLLa4B5nsdJ80NiRIUAKb3srb8J0G4XW7GdFdZFyk3MjBLmtcEDU1x2Zq9uODfidk1mVA==
X-Gm-Gg: AYBFou1RwKha/C2lLePA6EOGejnFrOOcEu/tpFgMZNtlkJ/AMFlss/qghJ4xt8y8s/s
	SoaHaBmePiWtPwNHyuit5cBtwL8d6RB1f7UV/bSQjmH+S1MnJiyH8SkxCsNr5nnYM0258iXdEbY
	fiU5/TYtYRLt/w3L3z9Lo/1WZHWzsrpiJ6785JEYWQ643kh3EbxTJEdz+MFw826L5Z9omB6kKGA
	GjBEOwp9atIvVZduinKt/tzd5Q2wQCXTJsnFiYZIP3NnobrsSLfUSLHEWAUO3g8Hxhmq2Er0YXK
	EdynKWWMsOD0oJ4VfV8Srzx7exG9ZKCEQja7LV5PxDhWzo8V7iFDqPVM7wC+RtqaDi3pvavoWzf
	Vxwldl1lh66Pb7oS8Ivbd+hh/lDA/ixtDoQanEUkwPw0HdQ5yiCeoM6K2OG/gqyEqDuNKB5r7+v
	AZdHWtKXGGuxdIpavZh8ptj3FGOtSlQf1mw6iRgUg/jXGG2acGpm3yNXtDnoe1feULI70lU87Ue
	sgGZ2XAfgr6VNLWQL/RAXMIhLUMiywKX/iLSUaV6pr5WM9ZZtMhO4e7/CvSOTrNyuYTZEzizjZj
	JrNmV/sV5ape+HDk3DbGzNXF3hzkSZ3EbmQ5I6jo7FA=
X-Received: by 2002:a05:600c:4e51:b0:4a1:fb23:68f0 with SMTP id 5b1f17b1804b1-4b94d763136mr81000455e9.3.1794235132952;
        Mon, 09 Nov 2026 06:38:52 -0800 (PST)
Received: from ADRIAN-PC.lan ([171.22.87.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cb76697sm142009995e9.0.2026.11.09.06.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:38:52 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix va_list reuse across loop iterations in scanf_one_line()
Date: Mon,  9 Nov 2026 15:38:46 +0100
Message-Id: <20261109143846.1626182-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

scanf_one_line() initializes 'ap' with va_start() once before the
getline() loop and passes it to vsscanf() on each iteration without
reinitializing it.

According to the C standard, once a va_list is passed to a function that
invokes va_arg() (such as vsscanf()), its value becomes indeterminate and
cannot be reused without an intervening va_end() and va_start().

Specifically, when scanning '/proc/self/mounts' with the format string
'%*s %4095s cgroup2 %s', every non-cgroup2 mount line matches the leading
'%*s %4095s' (returning 1 instead of 2) and consumes one pointer argument
from 'ap', exhausting the two passed pointers after the second line and
causing vsscanf() to write into uninitialized stack values on subsequent
lines.

Move va_start() and va_end() inside the getline() loop so 'ap' is
properly reinitialized for each line.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 9622af98dc734..ba4da33043d00 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1462,9 +1462,10 @@ static int scanf_one_line(const char *file, int fields_expected, const char *fmt
 	if (!f)
 		return -1;
 
-	va_start(ap, fmt);
 	while (getline(&line, &line_len, f) > 0) {
+		va_start(ap, fmt);
 		res = vsscanf(line, fmt, ap);
+		va_end(ap);
 		if (res == fields_expected)
 			goto out;
 	}
@@ -1474,7 +1475,6 @@ static int scanf_one_line(const char *file, int fields_expected, const char *fmt
 	}
 
 out:
-	va_end(ap);
 	free(line);
 	fclose(f);
 	errno = saved_errno;
-- 
2.39.5


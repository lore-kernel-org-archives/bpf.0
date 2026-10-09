Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59B27B340
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510598; cv=none; b=F9Grnuw/gadeFbRqY+4qCBofa0PDzO44vLYZ3yQnJgKhMCrgONhVHGVx3NfAdDz9obNeQYwxh4VJvMP7NgL5ECfaUKkg78Iq+ki5aOL4gzSvsf3GPN5OcDp6pxw4ujylsIpZwQHQEFF+lMgOMRQhlPEgrXAjGw1sYYlb4eRQxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510598; c=relaxed/simple;
	bh=HtIl/nwx6bOv1iqWUYSobRqCIqsM0aPvGMZVuqqehNY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cWieqg84PdVsX/MnxCj1ctQhG3IXWRcusjipRDR1eS45Rpjm6cB5A1529lIVjhBn4KMWGjOEruCTOQBlV2uDdVFw4dAhQHRLiOzieMqUIbO7S7+m4aI0E4XE9On6z/sNIK8LDfeb2Y6GrSAr9FKGJtJB/bLSmnBJ4RVVfKkdDf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXsv4S4N; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXsv4S4N"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-34c4a0868b6so5423863eec.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 18:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791510596; x=1792115396; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GMDytykDqwmOSKHEI4lP8Wfae7lF8nVLH1/sChzwqGw=;
        b=aXsv4S4Ni1U6ydBnnaNzMaBhZE0cHz7aRSYhF099qUT6Gazmo1A87ASfwOuSWQP6oY
         ArBwTkku09IlyzEInP5RwHLg5i9OvdQKsRAypjCKjzywMVFEPN00fkP0gKj2g6v0d0j/
         bi3LzX0eXPDYM1Mnr7HrsUyz+ydTmix/V7+CG1ueE8U9LvYDVJnyofmaY1HgEzjPBgxD
         Xj3R1fd7nB4bsoqlXp1g2/46unZrxr9lKODi8cghrjooT0j8lt3PZpK01SjJn+EpGz8e
         Ql/gE0QVZz64lvwsrl2HJGxS3dFalbNMfF81YJ+lIV4U+slymtuHr2vA8E8o9j3KkArX
         /RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791510596; x=1792115396;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GMDytykDqwmOSKHEI4lP8Wfae7lF8nVLH1/sChzwqGw=;
        b=0/TqiI3gf+bYDnAjHUeNz//PHI5qvXu66r1o5ygbqj3bQxgtYboMUIQo/cyaBmCtyb
         DzncbsXFc78g8obgihZKVPFx1I7pHecagf0xUhIs3zUsdemXgW0I7JdKnEFPM5g3VNEb
         l93/uSeZ5iJHJThvNk1MHZUYWmtk+udjbWpUueuf3Yd/+xv26JZbeNUvGmPGIMxnMOLN
         U2DmvmXe+Q4GRAs1wqC11pTk8egl7i17H88P8f56rbOTWLyHTTxFDBDrT26gQyw0RK0B
         e0juAtPFV/QrAMMC67I5jSZrRr8FKVJNY2dhFBg5RNpLGQm/hi5unTcP9+WUnx97+/+q
         r4+Q==
X-Gm-Message-State: AFuF++ndCH9DptC0DT462dF7/4uJ+S8bWNYObxiOtP7gMJrGJs40aGse
	p0nrpG+9fxLSiiZ3QAh+tRKj7TXorg+XiKedmuC4IDq9T5lWxRycNVzc
X-Gm-Gg: AYBFou0O1K6g/yS6m+cc5wVEIbfvXBAXE/AIbkwGYKNiwCSOa/d18zAPYNTmIWBfFPL
	PSti2Xlm6S5zdUXsayqV+FLiKpgDr6NLzUB0aJ8cXVqxSswPhghAgKnXBik33KfLNqFvwMcjHh6
	lRJdqjefXuJ1q4YXQ7O7MwEURP9gVxA1Nwl0whNOoeKx6QuZVfaNNKBJKNfQLZXG4P9NqKT2Gsz
	q0gBXlq9QzieyyjJ+H3LY5rr/sCxUvIRZ+f8Kg/pN1r/MyMAYCGLolPauqs7INkozfZ7EEHMf89
	/DHb8GE+NOxAPX7Tnb5cD7mbHWlQM8md8kWYoD0uF1a1L7GU7coIwRzxkxSxs6ljM/I1dRvSIxc
	vF8cOOyFWihVTzdIESfPbyVcKI5hL8WliE7pFL9rVVTLqgkBhplFL9M7QxJ/O0nH0akOo2hyQks
	KAWSCCH8zU4zSWt+i8/ePE0FEKU+w7lAxeV4B/C4IBNiUgpzMcMjOOojAST4nzj8CXMA==
X-Received: by 2002:a05:7300:c87:b0:33e:61ab:8309 with SMTP id 5a478bee46e88-3537b291a93mr1987985eec.23.1791510595779;
        Thu, 08 Oct 2026 18:49:55 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1d6e6sm1984845eec.24.2026.10.08.18.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 18:49:55 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: Skip libarena when arena spin
 locks are unsupported
Date: Fri, 09 Oct 2026 09:49:50 +0800
Message-Id: <20261009-selftests-bpf-libarena-nr-cpus-v1-0-e726ccc66fc6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD5IyGoC/x2N0QrCMAwAf2Xk2UBWmKC/Ij50bbIFRi1JlcHYv
 1t9vIe7O8DZlB3uwwHGH3V9lQ7jZYC0xrIwau4MgcJ1JLqh8yaNvTnOVXDTORqXiMUw1bfjRJK
 mnImEA/RINRbd/4MH/IzCe4PneX4Bx3hJinoAAAA=
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

serial_test_libarena runs the test programs of libarena, whose buddy
allocator serializes its operations with an arena spin lock.

arena_spin_lock() fails with -EOPNOTSUPP on kernels built with more
than 1024 possible CPUs, as distributions commonly configure them.
buddy_init() reports that as -EINVAL, and every test then fails at
arena_buddy_reset.

Patch 1 makes buddy_init() return the error of the lock, patch 2 skips
the tests when resetting the allocator fails with -EOPNOTSUPP.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (2):
      selftests/bpf: Return the lock error from buddy_init() of libarena
      selftests/bpf: Skip libarena on kernels with too many possible CPUs

 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c | 5 +++--
 tools/testing/selftests/bpf/prog_tests/libarena.c    | 9 +++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)
---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20261009-selftests-bpf-libarena-nr-cpus-50fc5dd00fe2

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


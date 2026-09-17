Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E693A9018
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678026; cv=none; b=MZtNk5BkTZKrhb3c+J2RQw52TgQMQhd2iac2GiIt2quyLIZaTmL7bLgGoMw9gAs+qd91hR2k5NSETt3epj1e3EIUzlKgLPzXEDETQAfK9o7I+OZWftG+dzdwIRb0LHQxE24absIkpU3exuKQQfGfQJe3oFN1pkaskGydd+uYfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678026; c=relaxed/simple;
	bh=nIVOkYYFqQJ0yVigMP8u4kUJIqRX2qfKDMZ1LhH9o/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HIMbRmkl4jiHtU0fLWpbVi7meVWvnToz3zqE/ajpgP5JKjJo/31qen2m8gcaI9r9/KF+3AIIJi5KvhT8lqIJe/qaYkNrZs2VSjcEziZVxrY39YCnfiaZLCqLkvWmKSZVrFqEYPAAeO2Wo9D5FO30/3Ucm0dT3pBzvBYTphHzjvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyfN7cY7; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyfN7cY7"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so970492a12.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789678023; x=1790282823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2gunvEfcyXymrnukDaYw8Fai9UY+V2Nlpd2w2MiKQn8=;
        b=KyfN7cY7cp3EewmBcfgrZpEPz83D0+LU62/Y0cZauw2jnCJ4duwF5SEd+Ucx5+VCGz
         0CLIsGFYIfBrQGMIq+szUMryjtGqZ+/fTYdsjTpyU+WKXwpjRsN8Qs9vAtCJtaORfsJB
         oAfS5hg9sZTZV97C+P834jK6LSl+s+cHtRAO7pLLenkqOczPvFHUgpKkS+CXW8CvKLJW
         FSW+t5pPZy7DrN0OUEcJsZjq+ANbBBzsdZcEnM/sT7gYjLWZ8Woix33q3YnXZSpif9ga
         oJGiKWCToHLpaoxPYpdSoZ9f5a3bvAyHwIPR5fJDsP981EQlV8zvphTvCHyLFZIokaYj
         8zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789678023; x=1790282823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2gunvEfcyXymrnukDaYw8Fai9UY+V2Nlpd2w2MiKQn8=;
        b=Fx5NRudDwGZfWJAbf19OcTYb3rd6GEwRLCE8XxRSos+hcsbnur27HgRXeTbe00fSLv
         J3QJnHqM/dJ6G9i0D8moojbyL+Rr4st28eGK8JV5znYqCXqEX+jbUS25B1J/5Jwp2VBV
         DPUEiEz5ordhUhh7LHgehKF6dC9tpqMIzEldU6IylAowW+CExm5QV0AJKDSL1xt6dpPS
         ZoJFFMfr4byWpSlvVz8WcjcUD20xhtV5bVLwD8KYlj76vQX+CVM5L1TdY4pFap9MpfSp
         xE4nIEquxMeGoQw+pBfdigunPeNy3cHH6bQBFtF0nBh4Pv8Dav5Q3yDwerR9OSSd+3eZ
         FrhA==
X-Forwarded-Encrypted: i=1; AKwUvBzdKc4jynkIjgxMfV5EY0mBU1wjMTnFsE+tYjgGdvBVlRRYPXPc4azfhWe+PYPyaZaYfcc=@vger.kernel.org
X-Gm-Message-State: AFuF++l5gpQvaB3Jjbal0qulaVrh8X1grqOVYqCTjAQVRjYToGCwSfeo
	gb3CZDNWb6ehfL6O809Dv8pOiEZNP2gl3T9uuP4DQVTvwjdyWVeWfFr25x4kCNwL
X-Gm-Gg: AYBFou3hfgaEvfcgVlhXgqcJTJ9Bh4EGwWob9rel3G0LnvV+Mv69oshOJTKB/iBd19D
	kLOlKq+GuxtEeIwqhoWceu1sOTeT8Ra1u7KEi8pME/73OOYnI6BFDYzGySATcwBGBN73CAYptE9
	OPUNthxgiMa6beUt/XcbQ70J/CBHURbgOoqDpIdUIN/7vqeaxr4Tb/5BiA8HoOBUjkug/jG3usL
	NK59kD0TtzGZhf2xTFlbe4nzBLrfZBFbuEOlUuX/W77T6IPkGX+M0mNivzcYC0iDT9YYh4qHDYh
	QXl4vmxXRuYUvRMaVtXsfYAUuxD0KaKAcvDbHuU5iFFf37hKr/ZPWT/7hS8ecL/sdaKlkQlJmy3
	IloT7BKUcn46NtDihzBTlrrxllbOiBoMPexxbYic7NnVfaNEIFqLtdHWLNT+D403o/ug//rK6k/
	4wAHOzeTR4cZIKUGVUD4tV421wxX6fu16if1X+gFkWpMEePH/lFdf8o2kKhd18VeJ0NcoEVps=
X-Received: by 2002:a05:6a20:3946:b0:3dd:85a8:cace with SMTP id adf61e73a8af0-3dd8c4ab5d2mr286409637.37.1789678022967;
        Thu, 17 Sep 2026 13:47:02 -0700 (PDT)
Received: from G15-5520 ([103.246.195.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d3a31asm14274126c88.9.2026.09.17.13.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:47:02 -0700 (PDT)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list)
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH] bpf: use str_plural() in diag_print_history()
Date: Thu, 17 Sep 2026 20:46:48 +0000
Message-ID: <20260917204648.9110-1-lalitshankarch@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the string choice helper function to simplify the code.

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 kernel/bpf/diagnostics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 0abbbe177e31..ff139777ac64 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -2354,6 +2354,6 @@ static void diag_print_history(struct bpf_verifier_env *env,
 	if (log->first_seq)
 		diag_write(env, "  %llu older causal-history event%s not retained because diagnostic "
 			   "event storage reached capacity\n",
-			   log->first_seq, log->first_seq == 1 ? "" : "s");
+			   log->first_seq, str_plural(log->first_seq));
 	diag_fmt_restore(env, mark);
 }
-- 
2.53.0


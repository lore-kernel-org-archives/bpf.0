Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E761C3BFC
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772264777; cv=none; b=CguypPmbFe5iCIjrPWAwHK74FMSm7l1baL6EkLIicQcTafudT3UJgEEywhWD0tHBfe/2V8Y3BPR6MA0bSpOmxuWJyiWVkRELeJx+2s+IPXzx+72LfECtWpuYebqFp7780OBvHqo2/SDdVBUTHZb3Th4Jn/n2KvuxiOSn+udW/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772264777; c=relaxed/simple;
	bh=p2aSFGQoBgSywwgSIEnLpuWg2GFD0rXSLdwVlwaTJIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KgLSi3fGbNJPXknxBMtF3I5+rplFFSwmE5UfrPSWyTC3d/8RvgF5DZ9otLLyYnVL4t4p7V1o4dWOldewkJIjiYO6gpGDzRLHvb72xvOka8AJat8u4CssIUK4LsNXOeJOqYtHHGH79XBUtRn4fytRkjYWn7Lb9g8/iK5UfKp8Nl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3kOWAPb; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3kOWAPb"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bded9bf7a7so1035566eec.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 23:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772264774; x=1772869574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wu4x5CQAoY5SwDUEuWuzuIox/7baMZlh2zSWLJQRs/o=;
        b=G3kOWAPb1VrsOs2PQGUkLdD9GPOXA48GSJEFimhAxLgQ85+VslViqqh4yelJhyuKId
         pq7GPMPQIgHGiavSZr6C29AMjABbsxQ1MmoU9vBgm0W1HAdO/1krWnAg+aqrSb/acXuN
         KX2PFBbhCUoc2qOBuCze6qz56yW7yQwhyH/71+krRz83yFw9BvNREXk7Qi1/bRV4ImlC
         V2Tu3PkqxIVgGUrNnVqhkvXrVDnFzivr099w/l73J1/1ygk0RiGEEW+ZhOJ7/QiO133J
         eQPFzZ9MC6FKjzIx2SLAgZV7GDoIKsa/JRw5hZZBrCnTmZNcMCVC+s/9KNXHncvpGi6h
         0FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772264774; x=1772869574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wu4x5CQAoY5SwDUEuWuzuIox/7baMZlh2zSWLJQRs/o=;
        b=aGYKVYyNxmL5p/NypiFZxbzS0frK8x7N0ll0N0MgGch9P6vJmGx9z55pdD3F5gDXvN
         pyo6DLZeeGkPJ7AMunhtELWs0q07RaUEs8jIZK0AWe4HAvPU/hCjLvflUc9BjOBAY3EE
         ZlUopQcSDsj0LJLHbeRF9jFnMfssLH2ocYDgrUwBBPZ6tPmpN06WnbjAmqM0Z6HBmPH4
         /f6ma9X2Mke5lwt/jIxIdf+cXkEt2iqQtLf+sPq8KWYLNzB+8SN8KrvyUFP9VN61lYH2
         ICGDGdiGYPbPkOnsThQ8Bng4Cyi1Jz2iP1JZgjO+3sQmStYsk6+ATh8hX9bmxo/5QdqZ
         D8lw==
X-Forwarded-Encrypted: i=1; AJvYcCXTj7Z+Rb7DJIhKd1X24gxr4QzaVpMDmPy7m/nWs/FiHxn0k9pfUVN+Kt/Pyqf6SaKu0vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlBIZov7XFykDxa7ygY6C+v4dLOqEVK/QW/ybQo6c8LcWPtMxC
	NRoTTrLdDwNgxkQLXrDN+BwcDXqnQjL7wlw1yEMsC+9Z0mUiPhG5/o19
X-Gm-Gg: ATEYQzy5s7U4+BVKJyksYjCCqBRnVYF0lxIlvJAFKx/WZG7hoTG/GGCSeOkusMRsS9U
	dSLu+0HsWpWRAKePehDA+3fp0mnQx8zDd1XuHwkteBYlGRiKyGdpz/vn1VxdWrzn659DttE/y+d
	sOHuE4SrNMZX7kCuVC5BBcjykkeMFkqE6WWbPdLFzedPQQw4jSFbvDVF6fgdlY2RHoYXs3pqzBu
	uswhTMueO8XahEzovXZfGr1fPgRF8TZU9pwYHMmD9QtAUtlrl8nqn3K8Gsmb0jUrlOnud6CwYFH
	I07CCZhSgvRQ3CxXt09M68Vd2r3z+tN/GyQrWiKoEmnMkoXha8aNY7eScRE74/BfvtoO+7kS9hF
	OOpmwSIN5DkxeOjeHvb8aDLYskfVoZxbT702+j1d+6rqAJvNWANvKST6plPs6JOl26kAAJWg9K3
	JtRq98V1JOyA2ho85s1/HMEdLgN5j/0XR9cmybGR6+u/2/BnKIn10fl6Pr5CGz/ZFF7ALg/8DAd
	VOkuWjQcOdeGgzgSq1CwYM92AA=
X-Received: by 2002:a05:693c:2b08:b0:2ba:66fd:3705 with SMTP id 5a478bee46e88-2bde1c3f0edmr2115477eec.1.1772264774400;
        Fri, 27 Feb 2026 23:46:14 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bded67bd05sm1874926eec.1.2026.02.27.23.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 23:46:13 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2 0/2] selftests/bpf: fix bpf_cookie failures
Date: Sat, 28 Feb 2026 15:45:53 +0800
Message-ID: <20260228074555.122950-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bpf_cookie failures due to missing bpf_testmod and flaky perf_event
triggering.

Tested:
  ./test_progs -t bpf_cookie/perf_event -vv (30 runs): 0 failures
  ./test_progs -t bpf_cookie -vv

Sun Jian (2):
  selftests/bpf: bpf_cookie: skip kprobe_multi tests without bpf_testmod
  selftests/bpf: bpf_cookie: make perf_event subtest trigger reliably

 .../selftests/bpf/prog_tests/bpf_cookie.c     | 29 ++++++++++++++-----
 1 file changed, 21 insertions(+), 8 deletions(-)


base-commit: f4d0ec0aa20d49f09dc01d82894ce80d72de0560
-- 
2.43.0


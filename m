Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1596F376486
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786074; cv=none; b=dnJe0cFbGF8SJUL4tUuZ0DkMAQ8XVVTF9IjWZDCkhkd1Ydh511H6f0gAPLXK1/7aA2hrvuZ8cuZcniRnb/ocPQmUriatOmM5wZn0XyNpx2uH3aGTObSAI8AW1Jh4SXwRHoIb0aYwpzkEqWVH3xTNGsYHjj9fNU4+LhA5fzKWnPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786074; c=relaxed/simple;
	bh=clVf7GqR7W7fSCjiWJJXJAaVwuefWYjZHusO5/YfFSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkcafHWZsNASU9Gh2LycFY7YpS+jYQfW/Z7DiRE3GLU9ZuwSUj+aC4a8v35jpkQGFhT1LmucHJwcBlSJ23mrbph4kgoC0Pq5PMHv40DqCovoBqTfRi34AfnRxVhxpJDePrrYL6JABRxh/jK4z488e2S95EEwCdzPzO2UM7GAEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVYyuL4e; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVYyuL4e"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2be1ab1fa7dso6691333eec.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 00:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772786071; x=1773390871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNnmYE0R4N2smug7XMNMUgUzL8tG2gVRbeEqqmNaiP4=;
        b=QVYyuL4exvfUQB39je7q/FSlDDCOQid5XeIh8+3H69v5Kc5ETHxmuDCVfH+NA6+yND
         M6TQXwJLbcobWT/Lst6wnOqpKjlohEhs3ElwgpkF0gFwk2HCtruRwwErDjP55P9Czlv/
         RVvWe3QXhAaBjyNP0HHnZc4WE6raNOMwPqMJgB9kI7NMLvtGiNbBXvPjH0mnXdFP5eep
         KUZGnUgUI6AALQ8AusrP35mnhOmJhkhO7Sq3P5YbxTYiyYIZQrKKCa0tOW8P3wpOy2dy
         WRnAOnodcmio/At0zxULXri7T5pIhFiDGpt2p9Xgp9g4Tkbd+9DsS4/CdGKTpF66ocyF
         Zt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772786071; x=1773390871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CNnmYE0R4N2smug7XMNMUgUzL8tG2gVRbeEqqmNaiP4=;
        b=b/EoVLT+9Q0+GDm5polv8fkJkClLgSsWWd82V6QXM/LLgKxbYEvrK5zGDtThoRCT3D
         GAeBJJ59vKpehvEWlPx6rMW2jSgrCDDMJl0rKGHmG8YLZMCNMJJVCYy9olvTF97RLLK2
         VgtOkX/Cha83+0kfTMLtwkHhx5UjX/jtoVOJ+JyqNc9NY09KhBRZeT25GW/BPVh58YRk
         Qiuhoq9Y4tL2WvDsBTXGEez19n3+W4fjDwdnKOHJAVontkUgpsA7KQxLnX9etidTZC+7
         FGNok9gazMfjos3MQ7IFUi5pFhTTAWpq/UkgcSjjz4qmDTtMdG2G8pArtp9r3t2S0bWl
         oVDQ==
X-Gm-Message-State: AOJu0YwGDCNZ7tZBi7leS2WRBd7/eO0DcXyW90QeIvoo973oUFMTk2Cz
	wycekDOgDDUkMhDZsoTKthkxypfc2zRN5VZ/XB2A8zmvePoi3G5BWeL/
X-Gm-Gg: ATEYQzwAp5WATNFkQMeNxdqVq6cf87rwjevtYba/eR3wp5UwIl82b4aUJdgB+Zk6Zsl
	fenvkIomtCKBnEVKj+lDt/oOe5Cfw5wCuFzNRSxxNCQ9WoJj1NdsRAHbutkd+qcEvbxzhvhX+RW
	kc4zo+4qd8slNk8KeLF1zphn5DO5nLYv56VmfRJLw+/X9OR1bBstnP0DCdEYMl7gC828K+KSNoB
	uLIlnH8Ow0ec8YkfAxuVUdTatjmFUfD7vFrmt66gXYJeqn7FFVcQ2S0mz+1EVu0vPZRTZkDy5v4
	bocHyR9VwoQ/YRtYRtKo4NFMoaQR2+5YIh570yU/Ez2nFj/SGzT5OgrJmZEC41RSEUXZ4wcK41Z
	Jzkc7YiQ/WakMgmWnFbBAkuIw8hjGb38okoseB2w4SefIdvlsIMkKwoLlu39jliDFugBK3rTE6+
	sDWT28DYbEbX/PkRx5X97JXmadu/CUg1mFnEde61qbAk6IxG+DStrkkiJG2StS5OBj5HaUpluLb
	iXzxKQ98PxDuawY9Q3TWRPePltSOVELWA==
X-Received: by 2002:a05:7301:2f95:b0:2be:e4b:60d2 with SMTP id 5a478bee46e88-2be4de766demr563325eec.4.1772786070906;
        Fri, 06 Mar 2026 00:34:30 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f807a30sm680324eec.6.2026.03.06.00.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 00:34:30 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v3 2/2] selftests/bpf: drop serial restriction
Date: Fri,  6 Mar 2026 16:33:30 +0800
Message-ID: <20260306083330.518627-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306083330.518627-1-sun.jian.kdev@gmail.com>
References: <20260306083330.518627-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1/2 added PID filtering to the probe_user BPF program to avoid
cross-test interference from the global connect() hooks.

With the interference removed, drop the serial_ prefix and remove the
stale TODO comment so the test can run in parallel.

Tested:
  ./test_progs -t probe_user -v
  ./test_progs -j$(nproc) -t probe_user

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/probe_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/testing/selftests/bpf/prog_tests/probe_user.c
index b3e17a329cb4..7a9d13aa2c87 100644
--- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 
-/* TODO: corrupts other tests uses connect() */
-void serial_test_probe_user(void)
+void test_probe_user(void)
 {
 	static const char *const prog_names[] = {
 		"handle_sys_connect",
-- 
2.43.0


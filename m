Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA03E95A4
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085524; cv=none; b=AiwAFxusbCopyaQ0Ukad3U/qkx8xPT2YUCZEpZXt8/lFUlbJNZ/6t4wlb5obCBGwq7K1V/4fZNiH2ykA0wWfPmqudXXEiSY51Hhxeglu/okz7cfvIcDRrRBchszIMR72fYshROl2MGcpfBNi6pQW2t05HG2KqJarFMvgFwcC2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085524; c=relaxed/simple;
	bh=dI1WStqlpIXOwEbl0Tq1nJF8npf3hJwV5o6BMMo97jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ci2NfgEXnqnra2WeYKIyikkR1+qRD6PmLgrHWGFsoitJ3pL5L2SMKCZfSUTiaNeSsvoPVckKig9PxTWNk4dGF7fTjANCdshVe9lKuhmYDD9ap1W4miz/kWXWJauhgrMCT61RGi+k18NHJKUt+fb2ojXf0EoGFgEzkognsPpluJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qBIxUgvU; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBIxUgvU"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-141395927feso10668882c88.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792085512; x=1792690312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gR2GS+zLKe5N4zqWPOfXWRNDOn0SGujJKSCC0wtMo+M=;
        b=qBIxUgvUO96D84ejDfDAD5aS2cqMdudqKnoI2iph9jTolWVs0Nh8gMFQH+/A8wkwR7
         vgZLpgkUTNuhzKXohA3/zreCZzVpWH8Rk4m2Jo4SVbUdVR9jEhoZrJBflMunavT3pOfq
         kaS/h+jywkDPqrh69Q/jz/jACPd6v/Tq/4FvVTjTpDpkgP+rDikijPxh6cI6UPsWB/yB
         XmzNDmoMbanYu9KZKDbEbXYgrpk//b/l3yPJcMbFXjEU9aS8M99nVkxwSnKqArGV2C14
         IWPrbdcaUJTzZB+aOwE+NzbU52T3jIm687B861yPcMjoiGjxLrytMAb1RWJvfIVq5ZxI
         hirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085512; x=1792690312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gR2GS+zLKe5N4zqWPOfXWRNDOn0SGujJKSCC0wtMo+M=;
        b=bul82e34GZKkLuwZGvU33M+cXS9rMr+2gSfbRCLRhXqc3uVazlrnDIk1jaBiKcTVNT
         t5Q9I3AdfNE9ROK7qQ1cOYXDfxewSOv+r5H5X0do5KjsXFWBi0NiK0bQsHoNazSJWY43
         JrGlBjTeYenQh6ZPN0Q44WuxH6eGFsm4wxfKJpLP/euFS246qcRWe8HqbGsFibwRXca2
         vdQCdfC7mgusiwuy8jIopoBNlTUYi/m7g78ncm0c9i8IbS5sCWYJul/S/QAdoAZ+r0rc
         4qCqnU2nJA5EyKVY+KB1q2v05WVei5/l/YGCouktGGFdJWhdUchvN3HhLVnyxqyuOUjW
         I/0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzYvOnOz/4TeNrjDC8WAOF+xrxv5h0WtQahSIIlz5wQ7d3CwHrtfcdkqLuv7OUuTo0tm60=@vger.kernel.org
X-Gm-Message-State: AFq9FYImw63ycYNPj6zv4fFyEbZMTB9SKFvRHq2V98wTe5+K3THzhP59
	Yu2NdGuNhzccKNc35uUJwORETptsktf0znLXXxpeI53whKucXalwXyd7
X-Gm-Gg: AYBFou0awyhkaWr5QH0cKcQVbi5MyxdCVkpuyr+ggV0xpsBDwZsssZz9crJqQ3cA/XT
	6B7zrgEhxrbVpaTBmPHnEac9cEU4hjJoUbJbd6alWZd0Jgt+faSXplZap0Lyk1Y2op1V+g+56GK
	1QWkWDv3PwAa2DYnT9PM+u0Emc7W/MUXvhIBVXZEoOkdETpWyr7ElYwx1wW+zQcz9xbKtlELszQ
	uwihdHD0Nbmh8GUeZZFtL0n2Vlb1mpp3kOuSZ9VuX1FN177uvQsMYpDn61/7s/uBGYbJhDrrfNI
	5G6f3q4cUmxDI3fggdPEGRFcu4gM7pnq9/bXb7klFcsXnhgY2iL6oOjUXFzuy+DCgdtiGC6CUR0
	usRGtV3aDVdFlDC1Z0bvjBRx7H5Ee09AOLy0hnGm0IGruYorNbeLKZytjTNty1lFeRm3YJJG9+8
	g10KkaxpoWWUOsy+k9IsrJklsgsyonx/vPEeBeexoSSs11wOt3h8fOHyDBaZ+Z4/PRlREAQJeRK
	Q==
X-Received: by 2002:a05:7022:b057:10b0:160:a80f:3ed2 with SMTP id a92af1059eb24-16a5dbfecb9mr26202339c88.10.1792085511888;
        Thu, 15 Oct 2026 10:31:51 -0700 (PDT)
Received: from gmail.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-182a5a305absm363860c88.7.2026.10.15.10.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:31:50 -0700 (PDT)
From: pdsj2807@gmail.com
To: andrii@kernel.org,
	eddyz87@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Palak Raval <pdsj2807@gmail.com>
Subject: [PATCH] selftests/bpf: remove unused duration variable
Date: Thu, 15 Oct 2026 23:01:39 +0530
Message-ID: <20261015173142.1361483-1-pdsj2807@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Palak Raval <pdsj2807@gmail.com>

The duration variable in cgroup_attach_override.c is not referenced
anywhere in the file.

Remove the unused variable.

Signed-off-by: Palak Raval <pdsj2807@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
index 9421a5b7f4e1..28a946e2a736 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
@@ -26,7 +26,6 @@ static int prog_load(int verdict)
 void serial_test_cgroup_attach_override(void)
 {
 	int drop_prog = -1, allow_prog = -1, foo = -1, bar = -1;
-	__u32 duration = 0;
 
 	allow_prog = prog_load(1);
 	if (CHECK(allow_prog < 0, "prog_load_allow",
-- 
2.43.0


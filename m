Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D60331EAE
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511489; cv=none; b=qnjioU3CYJ2E19r7l1+JO7Hgi8KsN2EJhfvfZsV/0G1rXZwDzd8ZnbP6GZC+k7Y7XLmBjWvsP8+6rnm5rscebL/Ld5Hw/+FxjzT5vw2r9P1tCCpO1rlv1TG/fqD90m0JsX55ci5GgyZUg3z/gwBHjicAswge+fDNo0jeAtpR+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511489; c=relaxed/simple;
	bh=Ir7MgX27vMUb2Apf+h3LJ/iJ4arup/JT+v11T/qNDPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3OugwDs7dIQTesGZs2E+WUvdNwEVPio41xMxTrZFgCrgpjbd9jqy5VJh4pdTd0u/AnoXW61dSjj5CJFlMS/30GwpmtiB1H2e9BwlPAlumWR8va+JNLiP1bN9jSUWWP/0eVCrhX8wfEMPKKLKDMlb/0HhIuz49hlNY5dIvvevSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwZA9ayR; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwZA9ayR"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30b6dad2382so8386386eec.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 19:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791511487; x=1792116287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNS0qOhcnpeatXmssqXfSOSgncnW9wacWfiHik59GKA=;
        b=bwZA9ayRCsILVSYooSCI5ZGTsa4Mp67khhtj4CH9EpE0myKVBD1kFAi403iKpM8tMR
         KuM3J52VdVlGz6EgdueUbGJA+sHusyQQWEdd0GIr0ncX6BarjK49fMryMUZ+di8z6AXu
         ZJM9Sxv5ONtJ9fEqTeAEWSXkRvgR5/8L6WthkC+YJ+YkDmxNsi598O/QSPu6P8MwuCbM
         lxGLSJXwZZWo5jOyUnK8k67QMn+ARGbkSyDv3qsCs2qo1/Pdj7fRCM8QMZF+4EHofZAU
         RG1HXrq/zlaYt25OsIH3+h3ldTKhOcjaCxuHDbdNgkvZCdCUtzzHWCIaTEUQYnU3Ryvs
         l5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791511487; x=1792116287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNS0qOhcnpeatXmssqXfSOSgncnW9wacWfiHik59GKA=;
        b=hBAxHV4gpoGwVrh/Zab5GaC2Z1ngPP5b40sopKAZ7t1wS8EezTtssYpJ0FeXcBL3oK
         QdDmNtaG+upAvHOc62LbkQklSaT+shl4Jpf6CRTWcm7Z6b8prBjmnlavn3F9fTHq2s+e
         WI/tAPEvj43jdP9BOukPbBU5JmkuW8h65X163SEkl5iGXPRRoUBsA87mRvVGy1v7OFMT
         h7U5UCbQ6F+NXdpHTtKLISlrShDc71PGKUdg3NESILHRb+7ZVTEkrZ1mpGqDJZHCvPx9
         Tqp0f49/Udp6alXy5CNSReVPjn/0d95vU2fUq+HHvf/RBT6Ub1PNL3ZiavuocQF9XIQv
         Hcyg==
X-Gm-Message-State: AFuF++lphy5Gz8v7gX4g1qzgKPsKYivHFM7d8W8THvJN3FJepcNGo1vO
	pPEuJh/e9olGIYk97LrDwm9e9Gyjqq+NCJttifdJniz4Lxg63cBp2xnz
X-Gm-Gg: AYBFou3x9O/S7r9YBOfkpn5xPEeM8r8xrMfD05cAZy5K6iQv7G2uzSo+a5SoI/6rlkq
	JAW73hkchBnyFu5Z+Ud/xumJYoKXwvzd+/dOd1MvL3k/KeNQoXcLG/NBUJmp5708qeCtdv6DlWW
	dRobwq5nNGStNwAiGBjLuvL0kGIt9FJFfBUObybJjz2pt1KUE2cnQhpFuQpyXxGyro3HGgUmXTH
	TZZ8RG8iB2k4hXT2xxopd72raP5h2ltq1D+utHuOfM3k+H55Z+/DxkeliKCS4O3rY+Zhlf6kwCo
	Ky9UlorQsV/omSQI5+r9ITqMOZUyWGZm9Ml9ilNOEULXxtHN5spmbl7+X2f1mXYDSTVa6CSI4HI
	dySojRwyJcJcA01eGQrmRRopFmdUjIuosa1Pd8AfK0MyueaCOq79Y5qSqryKEWEsjpSxABlVNFN
	rqcETI94wpNVib2XKdDgwNxqVQhWQFiRk6+h8oh67yW9XIHx1UHY0dtJDMYXY7BNeQ3A==
X-Received: by 2002:a05:7022:f50c:b0:151:2e62:fe54 with SMTP id a92af1059eb24-16a5ef287a7mr564383c88.20.1791511486741;
        Thu, 08 Oct 2026 19:04:46 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16996eac537sm1970743c88.1.2026.10.08.19.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:04:46 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 09 Oct 2026 10:04:37 +0800
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Keep the bpffs of
 cgroup_hierarchical_stats private
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-selftests-bpf-cgroup-stats-bpffs-v2-1-f93a111da992@gmail.com>
References: <20261009-selftests-bpf-cgroup-stats-bpffs-v2-0-f93a111da992@gmail.com>
In-Reply-To: <20261009-selftests-bpf-cgroup-stats-bpffs-v2-0-f93a111da992@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Yosry Ahmed <yosry@kernel.org>, Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

setup_hierarchy() mounts a bpffs on /sys/fs/bpf with setup_bpffs(), and
then sets up the cgroups with setup_cgroups(), which moves the test into
a private mount namespace.

The bpffs thus lands in the mount namespace that test_progs shares with
the tests running in parallel, on top of the bpffs already there, and
hides what they pin. cleanup_bpffs() later runs in the private mount
namespace and can't unmount it, so it stays there for good.
bpftool_maps_access then fails to pin an iterator because
/sys/fs/bpf/test_bpftool_map doesn't exist anymore, and bpftool_metadata
can't find the program it pinned in /sys/fs/bpf/test_metadata.

Set up the cgroups first, so that the bpffs is mounted in the private
mount namespace.

Fixes: 88886309d2e8 ("selftests/bpf: add a selftest for cgroup hierarchical stats collection")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
index 3bd27d2ea668c..ad19d6d41918a 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
@@ -151,7 +151,7 @@ static void cleanup_cgroups(void)
 /* Sets up cgroup hiearchary, returns 0 on success. */
 static int setup_hierarchy(void)
 {
-	return setup_bpffs() || setup_cgroups();
+	return setup_cgroups() || setup_bpffs();
 }
 
 static void destroy_hierarchy(void)

-- 
2.43.0


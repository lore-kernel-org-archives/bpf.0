Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7209954788
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266075; cv=none; b=Bbmxm4sP5blCKBkd3pvUGihsuyoTL6s22zMAInAYfVqy850RXMkuW0L8gFus02xa3I3T860v4voEB5ZrseecylZcAzvOiY8yDtjrINr/9hNBVf0zjw7hJ2Om5UECqVqaP64VwjXMRI0hxk3hz1IkAQe1KpRdiUg3+nD4HQaEitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266075; c=relaxed/simple;
	bh=FTA1hplTwE6Tm/AWt8cHu0oNlw5249gED31A1Xs7JiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBHrIuDVapCq2fbmyTNj4Cmj6D4EA4xYlB5i5ZLQA+k90EuGAyd7CzFemcQgCFfb/OVS+b4K6QtLhhEnfO5NlntS908l0nQ4lAgV+RQ4cN40iNvnN/Q3cUXnQfbskZZn7UeA6PfcO524oRQB8A0Yi++APNdbCOVnTXPi0x0G6bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwWVD/ep; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwWVD/ep"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so1967513e87.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790266072; x=1790870872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FlJxRGZbP2ljvL1oHIJzjCOAGk0RJfd7Mzmzs0O27ho=;
        b=IwWVD/epET2GPaCk7VZde047Hnmfk8pE6XmPa+Ax6Md2EY7RZMbIFDX0Yl9PaZPB30
         YY759VtRdN6p1i/87A17zRBFV9lCN5HzUU48cChksdw+Ug06+u7G/oXt2N/AItO8TKoR
         ZfvQosC62Bd1G019pL+WRJoyFhwPdKZE48CAqkyR+aZl+qmx/X9DDPbOdCVPq91lHcNi
         KJBAuEPNm3wwvCgBvdA9vYgdicDvyCw4OHHEplawY8zOmk1S7K8jUHNiKslBTKEvVdQ1
         vgz4fgdRO3pUxsFp69EeEYcMYmyCKpSvB6UYZZWiMQ93V695QDbtnhnIQNCH0aORBT4D
         FROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266072; x=1790870872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FlJxRGZbP2ljvL1oHIJzjCOAGk0RJfd7Mzmzs0O27ho=;
        b=LbVsf4GZwFsT1m2QEIRzNvrAD8IMOij89YKlTzkvkESgbPV4nynvx2o4iV1u0MnrqM
         ql3ElMCMsdZcz0XV9VXIXIgMKeiJ50fmkWlN690eu9bT6FfXZ0+9oWR+oGgsUwHFFAN4
         kCPTErijfzeNzh7SWv/bKQu0EltHq970SBUshpzEiOR6Z8KeE+Y+doDtkrsCeddxkD1K
         FcQGBeXa4JQ2U3gpBIupvtpK+PXfwz9XnfhN7MrCkCgLB23jBXvAOUF6SH52CBfVkLFk
         HBgGbKzlF+EE2ADkQRRsu/a6MYEcuDeIzbedJFprsFDfAp9UXYozHrTnnZVkY5tMUNNC
         YtcQ==
X-Gm-Message-State: AFuF++ltV4Dv31TvDkVheUy5mgiiIqmZvNNjzDv5WAKaL8GDNItrt68q
	PMmtmjZphGdxNN4pTweuTLJfCT+3zRkiklbfqOdwyzNmoIJEm34Ih2eK99uRB+HBMVXq0g==
X-Gm-Gg: AYBFou2TPL0DRC2qj0e8nminUI+uBuM0/xrtXHuzDzQSD0oEW2Q2+QYvwGR3VJr4gi0
	4vA4U7OuxUPNpPGm4ozlc1kg4Stbn13ly72OdMKPHEdSwufBKaojmW38u9bn6Xg+PAQfLAIk7dN
	rWed9VtBNQ77+Bz+vfl3K0nd9MHpWAMp0lg5+B0BNBjNVy1RyKVJjezmGTvohRMysyqLrn17mN+
	HjjNXVmOFbX6EZg0nr9//ForO9+GmRr0bgXH8MOPRBNWF1lCG1L5aCFryO4xuAhradTwWwrp/Zl
	ahpraB4pFEz+O/uIddg5WQ3k6GUD/ysn1Ng4Yg8fGvzz3ThwtbUMA8hX+9JyM7vyXnoqOuezQ9d
	LuFy7yh16wHoJtMl7Lm6i0Ool2IDtZKjF7y2O1DLP4q67LWzXu5KLecKEh0kDAjBPkkHav35+aG
	znLr8e/dZT9rJzGUEhxjiK25W6Hx/cyT/6MRxrLnGc2VFfVBFbXd8RLdskuPYvEoycgRTer6O7I
	MwWFe5CWwvfvqY=
X-Received: by 2002:a05:6512:1344:b0:5b7:6ff5:24fc with SMTP id 2adb3069b0e04-5b8df0d42b4mr924391e87.9.1790266072156;
        Thu, 24 Sep 2026 09:07:52 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.93])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d8552fd4sm1563292e87.2.2026.09.24.09.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:07:51 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuba@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Maxim Skokov <skokovmaksimevg@gmail.com>
Subject: [PATCH bpf-next 0/2] bpftool: Don't report an empty map when key iteration fails
Date: Thu, 24 Sep 2026 19:07:18 +0300
Message-ID: <20260924160732.485650-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"bpftool map dump" stops at the first bpf_map_get_next_key() error and only
treats ENOENT as the end of the map. Any other error gives an empty dump
with no message, only a non-zero exit status. Local storage maps always
fail that way, so a socket storage map holding elements dumps as "[]".

Patch 1 reports the error like "bpftool map getnext" already does, with a
hint when the map type can't be iterated. Patch 2 adds a test_progs case.

The new test fails without patch 1 and passes with it; the other bpftool_*
selftests pass. Tested on x86_64 under a bpf-next kernel with KASAN and
lockdep, and through BPF CI (x86_64, aarch64, s390x).

Maxim Skokov (2):
  bpftool: Don't report an empty map when key iteration fails
  selftests/bpf: Check that bpftool reports a map it can't dump

 tools/bpf/bpftool/map.c                       | 11 ++-
 .../bpf/prog_tests/bpftool_map_dump.c         | 76 +++++++++++++++++++
 2 files changed, 85 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c


base-commit: 4f3a5eae895b9995e93425a75235d8f1f3268caa
-- 
2.47.3

